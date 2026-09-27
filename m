Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E23C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjK2-0003Ge-9y; Sun, 27 Sep 2026 03:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIE-0000Ji-2b; Sun, 27 Sep 2026 03:27:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIB-0005TC-Tv; Sun, 27 Sep 2026 03:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494013; bh=YjkLGra2R5/21VxIuW0V+PhnQN0hV7Ep8aXq2mss5ZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KRTd5Sv+HyATlhlKbHes0SPfxrRttjYrfH6QDFIiM2ZhTyk5KKOkIwzhgt4dlVMoY
 PkAufT7rw/wScVdIlhMXsi3dI8DuJEYBJysXvC0w9GDOaREOVnxdgNVOPo+zozeS3e
 5hetuqRv9l8DAq6+QKWc73ovFRMESVj8mkE5p7sWEJccGXjlw0Yx8oM6fhGWRraxwl
 AhTj73m6sZhy0ybxxTLuqtwj+57gJBCEZwlGcYBmZ3dOO9QuurE+/QI0y7h8Sw+KSd
 Z1Ya+NXhdUX5Ec3ua8BPkYlHn6U1sNT+GLEYhxQ7AZZ6w2OHAFdLorugWxfNUieDYk
 Svhq4CTWiy/pA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A39551D8ABF;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 892DA432051;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EDC015E62D; Sun, 27 Sep 2026 10:26:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 61/72] hw/usb/hcd-xhci: fix interval alignment
 after MFINDEX passes 2^32
Date: Sun, 27 Sep 2026 10:25:53 +0300
Message-ID: <20260927072622.93656-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Junjie Cao <junjie.cao@intel.com>

epctx->interval is an unsigned int, so ~(epctx->interval - 1) is a
32-bit mask that is zero-extended when and-ed with the 64-bit microframe
index. Once mfindex no longer fits in 32 bits (2^32 * 125us, about 6.2
days after the controller was started), asap loses its upper half and
always compares below mfindex. Isoch TDs with SIA are then run at once
instead of at the next interval boundary. xhci_calc_intr_kick() has the
same expression.

Use ROUND_UP(), which builds the mask in the type of mfindex. The
interval is always a power of two.

The reporter of #3973 also saw the symptom with UHCI. This change does
not explain that.

Fixes: 3d1396842d ("xhci: iso xfer support")
Fixes: 4d7a81c06f ("xhci: emulate intr endpoint intervals correctly")
Link: https://gitlab.com/qemu-project/qemu/-/issues/3973
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit bfb82d57e7299cb59471f7060cbab0b1ed39504e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 9805dff0114..26dcb8c6bd7 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1757,8 +1757,7 @@ static int xhci_fire_ctl_transfer(XHCIState *xhci, XHCITransfer *xfer)
 static void xhci_calc_intr_kick(XHCIState *xhci, XHCITransfer *xfer,
                                 XHCIEPContext *epctx, uint64_t mfindex)
 {
-    uint64_t asap = ((mfindex + epctx->interval - 1) &
-                     ~(epctx->interval-1));
+    uint64_t asap = ROUND_UP(mfindex, epctx->interval);
     uint64_t kick = epctx->mfindex_last + epctx->interval;
 
     assert(epctx->interval != 0);
@@ -1769,8 +1768,7 @@ static void xhci_calc_iso_kick(XHCIState *xhci, XHCITransfer *xfer,
                                XHCIEPContext *epctx, uint64_t mfindex)
 {
     if (xfer->trbs[0].control & TRB_TR_SIA) {
-        uint64_t asap = ((mfindex + epctx->interval - 1) &
-                         ~(epctx->interval-1));
+        uint64_t asap = ROUND_UP(mfindex, epctx->interval);
         if (asap >= epctx->mfindex_last &&
             asap <= epctx->mfindex_last + epctx->interval * 4) {
             xfer->mfindex_kick = epctx->mfindex_last + epctx->interval;
-- 
2.47.3


