Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F2BC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksn-0001Wd-A9; Sun, 27 Sep 2026 05:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkrA-00022M-5f; Sun, 27 Sep 2026 05:07:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkr7-0008Bv-HM; Sun, 27 Sep 2026 05:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=4E0CcUu8n3Vm2M5kMzT6kzBXFIz2F3TBe/Lu+pyPeTo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vrb53tqaXlKN3rlennDLxMd2OGWVmWUaqcK/fVIkv8GI0F5YO1ht+K9GAZ5fmYebQ
 H2logWgnrZGQvYToA6/HkgXiBmvHx+9DA4ENHxshPoGb/6YuzskqRa2f0M2UacY1ou
 WqnEOQD+44zv8dWQs78RtvtZx8qgo9t3MSysYaQOS/H28NI0f0eHXM10hnx+PeUGrm
 kuItposBid3sfSqn63It6P/F180EcbuO4ZvAD7Ki/b8wPCEprBHr36+K9Ypq3cfCIR
 pHhD/bcBBeLmJuoIHtNaGJYB5XGNFHOb0+rO1i0eliIc1YvJtf9kDyMGY8mPvMlyLY
 chVUuwmVRIicg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 501A41D8B1F;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4BE0E4320D8;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DD99F5E66F; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 78/86] tests/qtest/usb-hcd-xhci: test isoch
 endpoint type mismatch
Date: Sun, 27 Sep 2026 12:05:25 +0300
Message-ID: <20260927090540.102811-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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

From: Junjie Cao <junjie.cao@intel.com>

Configure the interrupt IN endpoint of usb-kbd as Isoch IN and queue one
TD. The TD is deferred by a microframe, the kick timer retries it,
usb-kbd NAKs, and a second doorbell retries it again. The TD has to stay
pending both times and the controller has to keep running.

Without the fix QEMU aborts in the timer retry. The endpoint setup is
taken from the reproducer attached to #3886.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Message-ID: <c1166d1b83db5a507035d6fc27b1b552d4a95b0e.1789968699.git.junjie.cao@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 1288b0869c082690c04c81ac940c126fb399592b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 61eca37b157..2e173af7506 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -33,6 +33,7 @@
 #define USBCMD_RS               (1 << 0)
 #define USBCMD_HCRST            (1 << 1)
 #define USBSTS_HCH              (1 << 0)
+#define USBSTS_HCE              (1 << 12)
 #define PORTSC_CCS              (1 << 0)
 #define PORTSC_PR               (1 << 4)
 #define PORTSC_PP               (1 << 9)
@@ -57,6 +58,7 @@
 
 #define EP_TYPE_ISOCH_OUT       1
 #define EP_TYPE_CONTROL         4
+#define EP_TYPE_ISOCH_IN        5
 
 #define XHCI_RING_TRBS          64
 #define XHCI_MICROFRAME_NS      125000
@@ -390,6 +392,37 @@ static void test_xhci_isoch_mfindex_32bit(void)
     xhci_test_end(&x);
 }
 
+/*
+ * The endpoint type in the endpoint context is whatever the guest says. Tell
+ * the controller that the interrupt endpoint of usb-kbd is isoch. The idle
+ * keyboard NAKs, and the TD has to stay pending when first the kick timer and
+ * then a doorbell retry it.
+ */
+static void test_xhci_isoch_ep_type_mismatch(void)
+{
+    uint64_t ring;
+    XHCITest x;
+
+    if (!xhci_test_supported("usb-kbd")) {
+        return;
+    }
+
+    xhci_test_start(&x, "-device usb-kbd");
+    ring = xhci_configure_ep(&x, 3, EP_TYPE_ISOCH_IN, 0, 8);
+
+    xhci_write_trb(&x, ring, xhci_alloc_page(&x), 8,
+                   TRB_TYPE(TR_ISOCH) | TRB_TR_SIA | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+    qtest_clock_step(x.qts, 2 * XHCI_MICROFRAME_NS);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+    g_assert_cmphex(xhci_readl(&x, x.oper + XHCI_USBSTS) &
+                    (USBSTS_HCH | USBSTS_HCE), ==, 0);
+
+    xhci_test_end(&x);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -406,6 +439,8 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/xhci/pci/isoch/mfindex-32bit",
                    test_xhci_isoch_mfindex_32bit);
+    qtest_add_func("/xhci/pci/isoch/ep-type-mismatch",
+                   test_xhci_isoch_ep_type_mismatch);
 
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,"
-- 
2.47.3


