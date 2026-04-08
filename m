Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133A10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSj-0003lJ-Ro; Wed, 08 Apr 2026 15:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wAY3n-00064g-5s
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wANQQ-0001L4-Ne
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 03:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775633648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ezy+HD52UjJTkuVdmNzj0BC3WnJxDi0i97P4xBBU1cc=;
 b=cQUHQCCCBzszEIsAfxKxszYsMAmjltZ8pkVI4wklxirXmCOtWPt+lio6vQIfllXCCZEuVH
 Y7i0SJiiRuORoBcibI3sEPOnE51S6nJC+hX3lGhiHyTcQm5jyuQUjuGvI/Z0cMsCD9Ra81
 zqPoWxH9+tIrtJruBWCO1VHFb2C/GA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-yya9sPyDOU-g_yDcKveqMA-1; Wed,
 08 Apr 2026 03:34:07 -0400
X-MC-Unique: yya9sPyDOU-g_yDcKveqMA-1
X-Mimecast-MFC-AGG-ID: yya9sPyDOU-g_yDcKveqMA_1775633646
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEAEE18005B9; Wed,  8 Apr 2026 07:34:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.216])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65D261800673; Wed,  8 Apr 2026 07:34:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1B2BD1800381; Wed, 08 Apr 2026 09:34:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Yuma Kurogome <yumak@ricsec.co.jp>
Subject: [PATCH for 11.0] hw/uefi: fix heap overflow (CVE-2026-5744)
Date: Wed,  8 Apr 2026 09:34:02 +0200
Message-ID: <20260408073403.3410541-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When copying the request response into the pio transfer buffer the code
skips the 'struct mm_header' but does not consider that when calculating
transfer size, so it will copy 24 (== sizeof(struct mm_header)) extra
bytes, which can overflow uv->pio_xfer_buffer.

Fix that by copying the complete buffer, including the header, which
also makes the pio code path consistent with the (unaffected) dma code
path.

Fixes: CVE-2026-5744
Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
Reported-by: Yuma Kurogome <yumak@ricsec.co.jp>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index ce0628fa5248..68d7594c0dd6 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -137,9 +137,8 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv, bool dma_mode)
                          uv->buffer, sizeof(*mhdr) + mhdr->length,
                          MEMTXATTRS_UNSPECIFIED);
     } else {
-        memcpy(uv->pio_xfer_buffer + sizeof(*mhdr),
-               uv->buffer + sizeof(*mhdr),
-               sizeof(*mhdr) + mhdr->length);
+        memcpy(uv->pio_xfer_buffer,
+               uv->buffer, sizeof(*mhdr) + mhdr->length);
     }
 
     return retval;
-- 
2.53.0


