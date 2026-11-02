Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F06606A91D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bLPYtSgv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuw5-0007Mq-56; Mon, 02 Nov 2026 11:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuw2-0007E4-PO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNuw0-0002Pt-Nl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRnbpNLtw7lyRFP8MIAP3OXqvttO+9aIWMKcc6H526c=;
 b=bLPYtSgvqV5k49c8y6DZ6415WSw6A6Ij4nuEe6TMI8Go+wguyAm6VU791IITrMhWtmXe21
 HIX68jiIddo6rGZWkwrrzegTz0WSgCZBGNGNVyun2lGUAuIltrJf+qHSuRYd8EKR+RTBgt
 tdi9UeBP5kJfoC7+lQ9XTjWr2Vv5YL0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-ojO4SwtCP_enTahPpe2P_w-1; Mon,
 02 Nov 2026 11:30:58 -0500
X-MC-Unique: ojO4SwtCP_enTahPpe2P_w-1
X-Mimecast-MFC-AGG-ID: ojO4SwtCP_enTahPpe2P_w_1793637057
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64B741800BC0; Mon,  2 Nov 2026 16:30:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.50])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E31F81800444; Mon,  2 Nov 2026 16:30:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Junjie Cao <junjie.cao@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/5] tests/qtest/usb-hcd-xhci: test Address Device with an
 unreadable DCBAA
Date: Mon,  2 Nov 2026 17:30:44 +0100
Message-ID: <20261102163044.644663-6-thuth@redhat.com>
In-Reply-To: <20261102163044.644663-1-thuth@redhat.com>
References: <20261102163044.644663-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@linux.dev>

Point DCBAAP at unassigned memory before Address Device. The fixed
controller completes it with TRB Error and raises HCE; check that, and
that the 64 bytes at guest address 0, where the contexts used to be
written, stay intact. With DCBAAP restored the command then succeeds
on retry.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261031033725.1275414-3-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 87 ++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index add2290bffa..be09b838c5d 100644
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
2.56.0


