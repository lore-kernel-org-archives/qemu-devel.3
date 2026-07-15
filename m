Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849BAC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk6Iz-0000cO-I8; Wed, 15 Jul 2026 16:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wk6Iy-0000bs-GX
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wk6Ix-00045Z-6I
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784147646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+NxatQDYm01py5JuqNedmt6Tx2oRKx+rie4vsA50ZuQ=;
 b=g29ol9PcazQ9/w6ebOA/6cQwOJAevj1/kQ8yxZTQIOdFvkJu1mcmJ4y7ZedYKEqc5sieRI
 PLRse/x+kGFJsH/P7lOeeVJK1KYvx+VFRVVy7FGom2CrJGspW70lBoF49FWKUy1QBOBf8n
 RqXvmYN6qWmyU2Zo8nv4A79lZNMtD4M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-T7PQRGOnM_SOVeNM0eG2uQ-1; Wed,
 15 Jul 2026 16:34:03 -0400
X-MC-Unique: T7PQRGOnM_SOVeNM0eG2uQ-1
X-Mimecast-MFC-AGG-ID: T7PQRGOnM_SOVeNM0eG2uQ_1784147642
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D41921956077; Wed, 15 Jul 2026 20:34:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EAE01954107; Wed, 15 Jul 2026 20:33:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] hw/usb/hcd-xhci: Fix guest-triggerable assert() in
 xhci_find_stream()
Date: Wed, 15 Jul 2026 22:33:57 +0200
Message-ID: <20260715203357.424556-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The assert() statement in xhci_find_stream() can be triggered by
the guest (see bug tickets #273, #3895 and #3988 on gitlab.com).
Turn it into a qemu_log_mask() instead to fix this problem.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/273
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index c7e050e38fd..ae8add4227e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1009,7 +1009,12 @@ static XHCIStreamContext *xhci_find_stream(XHCIEPContext *epctx,
     dma_addr_t base;
     uint32_t ctx[2], sct;
 
-    assert(streamid != 0);
+    if (!streamid) {
+        qemu_log_mask(LOG_GUEST_ERROR, "xhci: stream ID is zero\n");
+        *cc_error = CC_INVALID_STREAM_ID_ERROR;
+        return NULL;
+    }
+
     if (epctx->lsa) {
         if (streamid >= epctx->nr_pstreams) {
             *cc_error = CC_INVALID_STREAM_ID_ERROR;
-- 
2.55.0


