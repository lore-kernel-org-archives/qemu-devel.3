Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A81AC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmSv-0001r2-BH; Sun, 27 Sep 2026 06:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmSs-0001fY-FJ; Sun, 27 Sep 2026 06:50:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmSq-00019Y-BW; Sun, 27 Sep 2026 06:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506136; bh=Wti9fprQX0fBqJ4tBP5IVX0DHD6OxIhM31AoX6U+EEA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dYoTdZosXiisszouqC3agaPs8SrZ6BFdstjQ4mvwY/EXJhN01Vj0nZy9FMcSWnQUE
 J16QBbNBnbNHufxtwHCPzUqnclEJuU1uxtnKbuIO79tyWHif0AwaxvDq0e8UrOx+s9
 TCtIhlNWY9klo4g15FiMMD0GZt9rQpNBAK/sjyl2PbPKl9McizQJm3egSvG7eS1oFQ
 LXIQ7BccNwz5dR3aeEz8dv1CKM7bRM2MDgt97XkahBN2hcC46h3fXri4Xt52hO57fc
 mdswqOLTTiowFf2xh6fmW8+KPk2pJSCbdx0kdeurXFszwCWFolXOlFkWkLg4QjcG6a
 ScJDCd1BJEoXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 226A91D8B6D;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1FC6F432174;
 Sun, 27 Sep 2026 13:48:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E61455E792; Sun, 27 Sep 2026 13:48:55 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 78/92] hw/usb/hcd-xhci: fix interval alignment
 after MFINDEX passes 2^32
Date: Sun, 27 Sep 2026 13:47:54 +0300
Message-ID: <20260927104821.196183-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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
index 12f8ffece0f..61690dbdcec 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1755,8 +1755,7 @@ static int xhci_fire_ctl_transfer(XHCIState *xhci, XHCITransfer *xfer)
 static void xhci_calc_intr_kick(XHCIState *xhci, XHCITransfer *xfer,
                                 XHCIEPContext *epctx, uint64_t mfindex)
 {
-    uint64_t asap = ((mfindex + epctx->interval - 1) &
-                     ~(epctx->interval-1));
+    uint64_t asap = ROUND_UP(mfindex, epctx->interval);
     uint64_t kick = epctx->mfindex_last + epctx->interval;
 
     assert(epctx->interval != 0);
@@ -1767,8 +1766,7 @@ static void xhci_calc_iso_kick(XHCIState *xhci, XHCITransfer *xfer,
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


