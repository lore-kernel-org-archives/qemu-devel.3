Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68268C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPZ-00089F-K2; Wed, 22 Jul 2026 08:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWP1-0004lS-UE; Wed, 22 Jul 2026 08:50:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWOy-0001zU-Bd; Wed, 22 Jul 2026 08:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724391; bh=+75w/VZUSwhC1sWL09vmOUoi1+w4lHaJggyflyF2Vsc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h4sJ5iwd1DRvc3QYcLWM20Qfl3fIJ0p/09zNB+0Jq+6EnW01yU9c+rUndrrXSHfLV
 EUClM1QTbd5qn4Urg/H3pp0WMGXu5GhD1DdrJOD4y5Nkl0jg/t4CzchoKXlJ36FoyA
 ppy6HsdgFUlj9ku6FVMJ9ayj+XOympwBU1raKyOLU6AtYxGPRTh5Cs4jdrtR4NxhR4
 BqKMPKjj3QwM+bpY/k/X1V1CichLco6WUcRl229tcKDCzEAXQgoJ2GxCUSt4KhKiT5
 O9zmIVIFxQclZC3ZJEJaSKhrSobqpPjkOupSM9FPsPxWHs4T5UbYQDTPAJt43DIAt1
 enTv4EozpYtag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 08B1A1C3B1B;
 Wed, 22 Jul 2026 15:46:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 508C53F3775;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 921A617F1F; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 114/122] hw/usb/hcd-xhci: Fix guest-triggerable
 assert() in xhci_find_stream()
Date: Wed, 22 Jul 2026 15:46:03 +0300
Message-ID: <20260722124622.31034-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit 4daeaa2fe0f979b70fb3e54cc5661aadbffcd311)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 31def9dad7e..3aeb4f8780f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1011,7 +1011,12 @@ static XHCIStreamContext *xhci_find_stream(XHCIEPContext *epctx,
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
2.47.3


