Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC1ECA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDL29-0001fO-TK; Sun, 04 Oct 2026 08:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDEA2-0006gG-4F
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:49:18 -0400
Received: from out-185.mta1.migadu.com ([2001:41d0:203:375::b9]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDEA0-0002C0-61
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:49:17 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=P5jpOGXOziFAlHXzVj3QOa4xT/lwCRxiCpo6hPJ93KA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791089354; v=1; x=1791694154;
 b=pKGzsS5V8RL4Kj289Co9e0Y0hPp21YUd5830qKFua66BmQuNem6NVNv0BczqkxKMe5Dfdobk
 Rr+mbcg/C4u2tPETtd8bD1QZ+xszUUasu1QRZ7EQjw+rZjXHdSgkxbw6GgqakR53uI64jXvJVIc
 YiGJkM6dtx+ouww82BQoR5go=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 33616d552c281cf1;
 Sun, 04 Oct 2026 04:48:01 +0000
X-Mizu-Trace-ID: 33616d552c281cf1
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 philmd@oss.qualcomm.com, junjie.cao@linux.dev
Subject: [PATCH] tests/qtest/usb-hcd-xhci: test interrupt pacing above 2^32
Date: Sat,  3 Oct 2026 23:48:03 -0500
Message-ID: <20261004044803.9740-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::b9;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2026 08:09:35 -0400
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

Commit bfb82d57e7 ("hw/usb/hcd-xhci: fix interval alignment after
MFINDEX passes 2^32") fixed both isoch and interrupt scheduling, but
the regression test only covers the isoch path.

Queue a keyboard report on an interrupt IN endpoint after stepping
past 2^32 microframes. Check that the transfer remains pending until
the next interval boundary, then completes with the expected report.
With the old 32-bit mask, it completes as soon as the doorbell is rung.

Link: https://lore.kernel.org/qemu-devel/52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com/
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 tests/qtest/usb-hcd-xhci-test.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 2e173af750..add2290bff 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -48,6 +48,7 @@
 #define TRB_GET_CCODE(status)   ((status) >> 24)
 #define TRB_GET_SLOT(control)   ((control) >> 24)
 
+#define TR_NORMAL              1
 #define TR_ISOCH                5
 #define CR_ENABLE_SLOT          9
 #define CR_ADDRESS_DEVICE       11
@@ -59,6 +60,7 @@
 #define EP_TYPE_ISOCH_OUT       1
 #define EP_TYPE_CONTROL         4
 #define EP_TYPE_ISOCH_IN        5
+#define EP_TYPE_INTR_IN         7
 
 #define XHCI_RING_TRBS          64
 #define XHCI_MICROFRAME_NS      125000
@@ -392,6 +394,48 @@ static void test_xhci_isoch_mfindex_32bit(void)
     xhci_test_end(&x);
 }
 
+static void test_xhci_intr_mfindex_32bit(void)
+{
+    const unsigned int interval = 6;
+    const uint8_t expected[] = { 0, 0, 4, 0, 0, 0, 0, 0 };
+    uint8_t report[sizeof(expected)];
+    uint32_t status, control;
+    uint64_t ring, data;
+    XHCITest x;
+
+    if (!xhci_test_supported("usb-kbd")) {
+        return;
+    }
+
+    xhci_test_start(&x, "-device usb-kbd");
+    ring = xhci_configure_ep(&x, 3, EP_TYPE_INTR_IN, interval, 8);
+    data = xhci_alloc_page(&x);
+
+    qtest_clock_step(x.qts, ((1ULL << 32) + 5) * XHCI_MICROFRAME_NS);
+    /* A ready report makes an early transfer observable. */
+    qtest_qmp_assert_success(x.qts,
+        "{'execute': 'input-send-event', 'arguments': {'events': ["
+        "{'type': 'key', 'data': {'down': true, "
+        "'key': {'type': 'qcode', 'data': 'a'}}}]}}");
+
+    xhci_write_trb(&x, ring, data, sizeof(report),
+                   TRB_TYPE(TR_NORMAL) | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 3);
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+
+    qtest_clock_step(x.qts,
+                     ((1U << interval) - 5) * XHCI_MICROFRAME_NS - 1);
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+    qtest_clock_step(x.qts, 1);
+    g_assert_true(xhci_next_event(&x, &status, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_TRANSFER);
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    qtest_memread(x.qts, data, report, sizeof(report));
+    g_assert_cmpmem(report, sizeof(report), expected, sizeof(expected));
+
+    xhci_test_end(&x);
+}
+
 /*
  * The endpoint type in the endpoint context is whatever the guest says. Tell
  * the controller that the interrupt endpoint of usb-kbd is isoch. The idle
@@ -439,6 +483,8 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/xhci/pci/isoch/mfindex-32bit",
                    test_xhci_isoch_mfindex_32bit);
+    qtest_add_func("/xhci/pci/intr/mfindex-32bit",
+                   test_xhci_intr_mfindex_32bit);
     qtest_add_func("/xhci/pci/isoch/ep-type-mismatch",
                    test_xhci_isoch_ep_type_mismatch);
 

base-commit: 2a0ac9c8ac2d303ca515dc819043409aef18cab5
-- 
2.43.0


