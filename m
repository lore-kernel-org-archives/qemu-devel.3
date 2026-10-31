Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B65606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ppbIu7fM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMzue-0003qs-5W; Fri, 30 Oct 2026 23:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMzuc-0003qS-FI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:37:46 -0400
Received: from out-8.mta1.migadu.com ([95.215.58.8] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMzua-0003t3-LY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:37:46 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=WY5GMGb9Ni7Ofb5lnY/xQmfA7Nde8Y/R+i7N1Ts/OAk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793417859; v=1; x=1794022659;
 b=ppbIu7fMMqrFtVhMrJEAZvKN+vfdZuy1F5GeXd4cdYgBvfh1aRn4zGMXlx6oXXVdvgwbLReE
 G3Ci+5l2DDWw2LFJiJfH7QbppblMPubbcRv/qbtdSHHh5/PuPiwQRXzSiCFj044icGWasQhX8Ws
 FmjTSh5UFARmURxlOkgKGwK4=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 8d6880e513897306;
 Sat, 31 Oct 2026 03:37:39 +0000
X-Mizu-Trace-ID: 8d6880e513897306
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 junjie.cao@linux.dev
Subject: [PATCH 2/2] tests/qtest/usb-hcd-xhci: test Address Device with an
 unreadable DCBAA
Date: Fri, 30 Oct 2026 22:37:25 -0500
Message-ID: <20261031033725.1275414-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031033725.1275414-1-junjie.cao@linux.dev>
References: <20261031033725.1275414-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.8; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Point DCBAAP at unassigned memory before Address Device. The fixed
controller completes it with TRB Error and raises HCE; check that, and
that the 64 bytes at guest address 0, where the contexts used to be
written, stay intact. With DCBAAP restored the command then succeeds
on retry.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 tests/qtest/usb-hcd-xhci-test.c | 87 ++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index add2290bff..be09b838c5 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -56,6 +56,7 @@
 #define ER_TRANSFER             32
 #define ER_COMMAND_COMPLETE     33
 #define CC_SUCCESS              1
+#define CC_TRB_ERROR            5
 
 #define EP_TYPE_ISOCH_OUT       1
 #define EP_TYPE_CONTROL         4
@@ -64,6 +65,8 @@
 
 #define XHCI_RING_TRBS          64
 #define XHCI_MICROFRAME_NS      125000
+/* in the PCI hole of the pc machine, nothing is mapped there */
+#define XHCI_UNASSIGNED_ADDR    0xf0000000
 
 typedef struct XHCITest {
     QTestState *qts;
@@ -71,7 +74,7 @@ typedef struct XHCITest {
     QPCIBus *bus;
     struct qhc hc;
     uint32_t oper, runtime, doorbell;
-    uint64_t cmd_ring, event_ring, input_ctx;
+    uint64_t dcbaa, cmd_ring, event_ring, input_ctx;
     unsigned int cmd_idx, event_idx;
     unsigned int port, slot;
 } XHCITest;
@@ -226,8 +229,9 @@ static bool xhci_next_event(XHCITest *x, uint32_t *status, uint32_t *control)
     return true;
 }
 
-static unsigned int xhci_command(XHCITest *x, uint64_t parameter,
-                                 uint32_t control)
+/* Submit a command and return its completion code. */
+static unsigned int xhci_submit_command(XHCITest *x, uint64_t parameter,
+                                        uint32_t control, unsigned int *slot)
 {
     uint32_t status;
 
@@ -238,17 +242,30 @@ static unsigned int xhci_command(XHCITest *x, uint64_t parameter,
 
     g_assert_true(xhci_next_event(x, &status, &control));
     g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_COMMAND_COMPLETE);
-    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
-    return TRB_GET_SLOT(control);
+    if (slot) {
+        *slot = TRB_GET_SLOT(control);
+    }
+    return TRB_GET_CCODE(status);
+}
+
+/* Submit a command that has to succeed and return the slot ID. */
+static unsigned int xhci_command(XHCITest *x, uint64_t parameter,
+                                 uint32_t control)
+{
+    unsigned int slot;
+
+    g_assert_cmpuint(xhci_submit_command(x, parameter, control, &slot), ==,
+                     CC_SUCCESS);
+    return slot;
 }
 
 /*
- * Start qemu-xhci with one USB device, run the controller and bring the
- * device to the Addressed state.
+ * Start qemu-xhci with one USB device, run the controller, enable a slot
+ * for the device and fill in the input context for Address Device.
  */
-static void xhci_test_start(XHCITest *x, const char *usb_device)
+static void xhci_test_init(XHCITest *x, const char *usb_device)
 {
-    uint64_t dcbaa, erst, ep0_ring;
+    uint64_t erst, ep0_ring;
     unsigned int maxports;
 
     memset(x, 0, sizeof(*x));
@@ -267,14 +284,14 @@ static void xhci_test_start(XHCITest *x, const char *usb_device)
     xhci_writel(x, x->oper + XHCI_USBCMD, USBCMD_HCRST);
     g_assert_false(xhci_readl(x, x->oper + XHCI_USBCMD) & USBCMD_HCRST);
 
-    dcbaa = xhci_alloc_page(x);
+    x->dcbaa = xhci_alloc_page(x);
     erst = xhci_alloc_page(x);
     x->cmd_ring = xhci_alloc_page(x);
     x->event_ring = xhci_alloc_page(x);
     x->input_ctx = xhci_alloc_page(x);
 
     xhci_writel(x, x->oper + XHCI_CONFIG, 1);
-    xhci_writeq(x, x->oper + XHCI_DCBAAP, dcbaa);
+    xhci_writeq(x, x->oper + XHCI_DCBAAP, x->dcbaa);
     qtest_writeq(x->qts, erst, x->event_ring);
     qtest_writel(x->qts, erst + 8, XHCI_RING_TRBS);
     xhci_writel(x, x->runtime + XHCI_ERSTSZ, 1);
@@ -296,7 +313,7 @@ static void xhci_test_start(XHCITest *x, const char *usb_device)
     }
 
     x->slot = xhci_command(x, 0, TRB_TYPE(CR_ENABLE_SLOT));
-    qtest_writeq(x->qts, dcbaa + 8 * x->slot, xhci_alloc_page(x));
+    qtest_writeq(x->qts, x->dcbaa + 8 * x->slot, xhci_alloc_page(x));
 
     /* input control context: add slot and ep0 */
     qtest_writel(x->qts, x->input_ctx + 0x04, 0x3);
@@ -308,6 +325,12 @@ static void xhci_test_start(XHCITest *x, const char *usb_device)
     qtest_writel(x->qts, x->input_ctx + 0x44,
                  (64 << 16) | (EP_TYPE_CONTROL << 3));
     qtest_writeq(x->qts, x->input_ctx + 0x48, ep0_ring | 1);
+}
+
+/* xhci_test_init(), then bring the device to the Addressed state. */
+static void xhci_test_start(XHCITest *x, const char *usb_device)
+{
+    xhci_test_init(x, usb_device);
     xhci_command(x, x->input_ctx,
                  TRB_TYPE(CR_ADDRESS_DEVICE) | (x->slot << 24));
 }
@@ -355,6 +378,44 @@ static bool xhci_test_supported(const char *usb_device)
     return true;
 }
 
+/*
+ * Address Device reads the output context pointer from the DCBAA. Point
+ * DCBAAP at unassigned memory: the command has to fail instead of carrying
+ * on with the zero the failed read leaves behind, which used to put the
+ * contexts at guest address 0 and still report Success.
+ */
+static void test_xhci_address_device_dcbaa_read_error(void)
+{
+    uint8_t fill[64], low_mem[sizeof(fill)];
+    unsigned int ccode;
+    XHCITest x;
+
+    if (!xhci_test_supported("usb-kbd")) {
+        return;
+    }
+
+    xhci_test_init(&x, "-device usb-kbd");
+    memset(fill, 0xaa, sizeof(fill));
+    qtest_memwrite(x.qts, 0, fill, sizeof(fill));
+    xhci_writeq(&x, x.oper + XHCI_DCBAAP, XHCI_UNASSIGNED_ADDR);
+
+    ccode = xhci_submit_command(&x, x.input_ctx,
+                                TRB_TYPE(CR_ADDRESS_DEVICE) | (x.slot << 24),
+                                NULL);
+    g_assert_cmpuint(ccode, ==, CC_TRB_ERROR);
+    g_assert_cmphex(xhci_readl(&x, x.oper + XHCI_USBSTS) & USBSTS_HCE, ==,
+                    USBSTS_HCE);
+    qtest_memread(x.qts, 0, low_mem, sizeof(low_mem));
+    g_assert_cmpmem(low_mem, sizeof(low_mem), fill, sizeof(fill));
+
+    /* The failed command left the slot usable. */
+    xhci_writeq(&x, x.oper + XHCI_DCBAAP, x.dcbaa);
+    xhci_command(&x, x.input_ctx,
+                 TRB_TYPE(CR_ADDRESS_DEVICE) | (x.slot << 24));
+
+    xhci_test_end(&x);
+}
+
 /*
  * An isoch TD with SIA set is run at the next interval boundary. That has to
  * hold once the microframe index no longer fits in 32 bits as well.
@@ -481,6 +542,8 @@ int main(int argc, char **argv)
     if (qtest_has_device("usb-ccid")) {
         qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
     }
+    qtest_add_func("/xhci/pci/address-device/dcbaa-read-error",
+                   test_xhci_address_device_dcbaa_read_error);
     qtest_add_func("/xhci/pci/isoch/mfindex-32bit",
                    test_xhci_isoch_mfindex_32bit);
     qtest_add_func("/xhci/pci/intr/mfindex-32bit",
-- 
2.43.0


