Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C069CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3ql-0002v2-0O; Wed, 29 Oct 2025 06:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vE3qj-0002td-20
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vE3qd-0002Ut-MH
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761735366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hFjG2lmjB3VOUfWO2ci+B2pfILkJypf8Xr0QR8dkxg=;
 b=HbaK4jiTp3lFOv8FmNjbn6/GU9N3hknlHV/UIFg0mg67FoyNRRrPNOYpTjsXDzPPDVt2lH
 PesVDTUHO/Byc6Aqa1f+eHS7y+3lflRAUiZnAB41UsZTq/GAGMN5qpdN7WOJpxa1qXxW4R
 A8tMMY2TFU6I+hTRRgMpBWegVIHnYIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-3oj2bZ8UNGijOYgR5eX4kQ-1; Wed,
 29 Oct 2025 06:56:03 -0400
X-MC-Unique: 3oj2bZ8UNGijOYgR5eX4kQ-1
X-Mimecast-MFC-AGG-ID: 3oj2bZ8UNGijOYgR5eX4kQ_1761735362
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DF4C19560B3; Wed, 29 Oct 2025 10:56:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA4CD1800579; Wed, 29 Oct 2025 10:56:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 09B46180060A; Wed, 29 Oct 2025 11:55:56 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>, Ani Sinha <anisinha@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 2/5] igvm: fix off by one bug in memmap entry count checking
Date: Wed, 29 Oct 2025 11:55:52 +0100
Message-ID: <20251029105555.2492276-3-kraxel@redhat.com>
In-Reply-To: <20251029105555.2492276-1-kraxel@redhat.com>
References: <20251029105555.2492276-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 723d45b755a0..055bbba745ad 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -567,7 +567,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
 
             retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
             while (retval == 0) {
-                if (entry > max_entry_count) {
+                if (entry >= max_entry_count) {
                     error_setg(
                         errp,
                         "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
-- 
2.51.0


