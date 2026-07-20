Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8AEC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllOm-0003mY-NS; Mon, 20 Jul 2026 06:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOj-0003lK-K0
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOh-0008Hn-3X
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784543934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/AmVS2H7e5pCfszF4amIkYPrIlpVwvF0XwijKV+5Jc=;
 b=fLCf5oRig8HsGOhimrHgdRzdPpV/A9UNko6bxuTq9e/F2/p0hebjlD8SHgGvJB6PEkFUDi
 CDXS6S2xHDxQEJO8sfPjRhb6UjO1jNx46yEy1wzzlAxvInBW8XgPoYZMnKOl8xiSXvBMFD
 2RMwDQ3DrO/FiW01LDR8qXtr8in4Pk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-663L_OrWPZabOiN-XxclWQ-1; Mon,
 20 Jul 2026 06:38:51 -0400
X-MC-Unique: 663L_OrWPZabOiN-XxclWQ-1
X-Mimecast-MFC-AGG-ID: 663L_OrWPZabOiN-XxclWQ_1784543930
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2895E19560B5; Mon, 20 Jul 2026 10:38:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F38B158E; Mon, 20 Jul 2026 10:38:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 6/7] hw/usb/hcd-xhci: Fix guest-triggerable assert() in
 xhci_find_stream()
Date: Mon, 20 Jul 2026 12:38:32 +0200
Message-ID: <20260720103833.364506-7-thuth@redhat.com>
In-Reply-To: <20260720103833.364506-1-thuth@redhat.com>
References: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260715203357.424556-1-thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 47b7484d533..b94249993a1 100644
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


