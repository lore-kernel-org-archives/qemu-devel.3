Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99860A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sM06Yc5a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt8H-0007W8-00; Thu, 22 Oct 2026 09:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt8E-0007Hh-C3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:58 -0400
Received: from out-85.mta1.migadu.com ([2001:41d0:203:375::55]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt8C-000522-1T
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:58 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=35H/xz7JAQzRM30Vu/0cFhtv/ihkXSitYZwgogFOQ4g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676813; v=1; x=1793281613;
 b=sM06Yc5abFwLaATWXCoad+nH/PsSNH6UUVtZabBfPYNYVSWzRdRJOI94zaq7AVxAbUlCy123
 C+2tvVapOav6fS00P/qNi0lABklVUlZe8H9AzWVyMPUXcy1UgcCwpj3b+i47jn1944DXAiS7Wng
 YF0QRr7yQsgtxQsNFGCwjvLs=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id dccb3b8d37eb1b38;
 Thu, 22 Oct 2026 13:46:53 +0000
X-Mizu-Trace-ID: dccb3b8d37eb1b38
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 7/7] tests/qtest/usb-hcd-xhci: Test a successful
 isochronous transfer
Date: Thu, 22 Oct 2026 13:46:01 +0000
Message-ID: <20261022134601.1207204-8-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134601.1207204-1-junjie.cao@linux.dev>
References: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::55;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
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

From: Junjie Cao <junjie.cao@intel.com>

The MFINDEX test leaves the audio streaming interface disabled and
checks scheduling with a transfer that stalls. Add a successful
isochronous transfer so changes to endpoint checks are also tested
with a configured device.

Enable the audio streaming interface through EP0, then check the OUT
transfer event for success, zero residual length and the expected
slot, endpoint and TRB pointer.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 95 ++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 2e173af750..c14c19988e 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -42,13 +42,18 @@
 
 #define TRB_C                   (1 << 0)
 #define TRB_TR_IOC              (1 << 5)
+#define TRB_TR_IDT              (1 << 6)
+#define TRB_TR_DIR              (1 << 16)
 #define TRB_TR_SIA              (1U << 31)
 #define TRB_TYPE(t)             ((t) << 10)
 #define TRB_GET_TYPE(control)   (((control) >> 10) & 0x3f)
 #define TRB_GET_CCODE(status)   ((status) >> 24)
 #define TRB_GET_SLOT(control)   ((control) >> 24)
+#define TRB_GET_EPID(control)   (((control) >> 16) & 0x1f)
 
 #define TR_ISOCH                5
+#define TR_SETUP                2
+#define TR_STATUS               4
 #define CR_ENABLE_SLOT          9
 #define CR_ADDRESS_DEVICE       11
 #define CR_CONFIGURE_ENDPOINT   12
@@ -69,8 +74,8 @@ typedef struct XHCITest {
     QPCIBus *bus;
     struct qhc hc;
     uint32_t oper, runtime, doorbell;
-    uint64_t cmd_ring, event_ring, input_ctx;
-    unsigned int cmd_idx, event_idx;
+    uint64_t cmd_ring, event_ring, input_ctx, ep0_ring;
+    unsigned int cmd_idx, event_idx, ep0_idx;
     unsigned int port, slot;
 } XHCITest;
 
@@ -204,7 +209,8 @@ static void xhci_write_trb(XHCITest *x, uint64_t addr, uint64_t parameter,
 }
 
 /* Fetch the next event if there is one. Does not advance the clock. */
-static bool xhci_next_event(XHCITest *x, uint32_t *status, uint32_t *control)
+static bool xhci_next_event_full(XHCITest *x, uint64_t *parameter,
+                                 uint32_t *status, uint32_t *control)
 {
     uint64_t addr = x->event_ring + 16 * x->event_idx;
     uint32_t c = qtest_readl(x->qts, addr + 12);
@@ -212,6 +218,9 @@ static bool xhci_next_event(XHCITest *x, uint32_t *status, uint32_t *control)
     if (!(c & TRB_C)) {
         return false;
     }
+    if (parameter) {
+        *parameter = qtest_readq(x->qts, addr);
+    }
     if (status) {
         *status = qtest_readl(x->qts, addr + 8);
     }
@@ -224,6 +233,11 @@ static bool xhci_next_event(XHCITest *x, uint32_t *status, uint32_t *control)
     return true;
 }
 
+static bool xhci_next_event(XHCITest *x, uint32_t *status, uint32_t *control)
+{
+    return xhci_next_event_full(x, NULL, status, control);
+}
+
 static unsigned int xhci_command(XHCITest *x, uint64_t parameter,
                                  uint32_t control)
 {
@@ -246,7 +260,7 @@ static unsigned int xhci_command(XHCITest *x, uint64_t parameter,
  */
 static void xhci_test_start(XHCITest *x, const char *usb_device)
 {
-    uint64_t dcbaa, erst, ep0_ring;
+    uint64_t dcbaa, erst;
     unsigned int maxports;
 
     memset(x, 0, sizeof(*x));
@@ -302,14 +316,39 @@ static void xhci_test_start(XHCITest *x, const char *usb_device)
     qtest_writel(x->qts, x->input_ctx + 0x20, 1 << 27);
     qtest_writel(x->qts, x->input_ctx + 0x24, (x->port + 1) << 16);
     /* ep0 context */
-    ep0_ring = xhci_alloc_page(x);
+    x->ep0_ring = xhci_alloc_page(x);
     qtest_writel(x->qts, x->input_ctx + 0x44,
                  (64 << 16) | (EP_TYPE_CONTROL << 3));
-    qtest_writeq(x->qts, x->input_ctx + 0x48, ep0_ring | 1);
+    qtest_writeq(x->qts, x->input_ctx + 0x48, x->ep0_ring | 1);
     xhci_command(x, x->input_ctx,
                  TRB_TYPE(CR_ADDRESS_DEVICE) | (x->slot << 24));
 }
 
+static void xhci_control_no_data(XHCITest *x, const uint8_t setup[8])
+{
+    uint64_t setup_packet = 0, parameter;
+    uint32_t status, control;
+    unsigned int i;
+
+    for (i = 0; i < 8; i++) {
+        setup_packet |= (uint64_t)setup[i] << (i * 8);
+    }
+    xhci_write_trb(x, x->ep0_ring + 16 * x->ep0_idx++, setup_packet, 8,
+                   TRB_TYPE(TR_SETUP) | TRB_TR_IDT | TRB_C);
+    xhci_write_trb(x, x->ep0_ring + 16 * x->ep0_idx++, 0, 0,
+                   TRB_TYPE(TR_STATUS) | TRB_TR_DIR | TRB_TR_IOC | TRB_C);
+    xhci_writel(x, x->doorbell + 4 * x->slot, 1);
+
+    g_assert_true(xhci_next_event_full(x, &parameter, &status, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_TRANSFER);
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    g_assert_cmpuint(status & 0xffffff, ==, 0);
+    g_assert_cmpuint(TRB_GET_SLOT(control), ==, x->slot);
+    g_assert_cmpuint(TRB_GET_EPID(control), ==, 1);
+    g_assert_cmphex(parameter, ==,
+                    x->ep0_ring + 16 * (x->ep0_idx - 1));
+}
+
 /* Returns the address of the transfer ring. */
 static uint64_t xhci_configure_ep(XHCITest *x, unsigned int epid,
                                   unsigned int type, unsigned int interval,
@@ -423,6 +462,48 @@ static void test_xhci_isoch_ep_type_mismatch(void)
     xhci_test_end(&x);
 }
 
+static void test_xhci_isoch_audio_out(void)
+{
+    const uint8_t set_configuration[] = { 0, 9, 1, 0, 0, 0, 0, 0 };
+    const uint8_t set_interface[] = { 1, 11, 1, 0, 1, 0, 0, 0 };
+    const unsigned int packet_size = 192;
+    const unsigned int interval = 3; /* bInterval 1: one full-speed frame. */
+    XHCITest x;
+    uint32_t status, control;
+    uint64_t parameter, ring, data;
+
+    if (!xhci_test_supported("usb-audio")) {
+        return;
+    }
+
+    xhci_test_start(&x, "-audiodev none,id=snd0 "
+                        "-device usb-audio,audiodev=snd0");
+    xhci_control_no_data(&x, set_configuration);
+    xhci_control_no_data(&x, set_interface);
+
+    ring = xhci_configure_ep(&x, 2, EP_TYPE_ISOCH_OUT, interval,
+                             packet_size);
+    data = xhci_alloc_page(&x);
+    qtest_memset(x.qts, data, 0x5a, packet_size);
+    xhci_write_trb(&x, ring, data, packet_size,
+                   TRB_TYPE(TR_ISOCH) | TRB_TR_SIA | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 2);
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+
+    qtest_clock_step(x.qts, (1ULL << interval) * XHCI_MICROFRAME_NS);
+    g_assert_true(xhci_next_event_full(&x, &parameter, &status, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_TRANSFER);
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    g_assert_cmpuint(status & 0xffffff, ==, 0);
+    g_assert_cmpuint(TRB_GET_SLOT(control), ==, x.slot);
+    g_assert_cmpuint(TRB_GET_EPID(control), ==, 2);
+    g_assert_cmphex(parameter, ==, ring);
+    g_assert_cmphex(xhci_readl(&x, x.oper + XHCI_USBSTS) &
+                    (USBSTS_HCH | USBSTS_HCE), ==, 0);
+
+    xhci_test_end(&x);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -441,6 +522,8 @@ int main(int argc, char **argv)
                    test_xhci_isoch_mfindex_32bit);
     qtest_add_func("/xhci/pci/isoch/ep-type-mismatch",
                    test_xhci_isoch_ep_type_mismatch);
+    qtest_add_func("/xhci/pci/isoch/audio-out",
+                   test_xhci_isoch_audio_out);
 
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,"
-- 
2.43.0


