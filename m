Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A820606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Zq4g5+9+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLDm-0002kP-4b; Mon, 26 Oct 2026 09:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLDj-0002do-F5; Mon, 26 Oct 2026 09:58:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLDh-0000Xd-H9; Mon, 26 Oct 2026 09:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022944; bh=ES7TJidJTboctxLWDO/F00v9No8M3DqcYrTnDFd1RWQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Zq4g5+9+nqoDUEKOh4p/03u+dPKZEXjuHAsO/aDMfrrgg2tHQW1XjkwEFrSJygeLS
 MAHVBZIXhL00zqWIkedolAWNlvWQqMH8AgNCZtr4Es/qCnSS9oAqkRttWtdRivcTU/
 0mssl63vJRXfFolQHqr1rt5yJ0xVvBhpY8M95RyCw6RZHUGRAlIwGXDOAbUyG7SB2M
 coZmDOM2R6BGCtaQ9fILozvvNG4j08j/9OUaC6udjBvs4NjJGNXPUdo3jpiPsI+uAa
 XL/8bki9anmALcRMNbjkfP83m9RmiuRQcP9tDUePVuHDKUwJt3GUwvKhPRrHzzoRsP
 N9DdFbksSS3Ug==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FFF31E12A7;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2E0A144B8F8;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0EF54934D5; Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@linux.dev>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 90/98] tests/qtest/usb-hcd-xhci: test interrupt
 pacing above 2^32
Date: Mon, 26 Oct 2026 16:55:17 +0300
Message-ID: <20261026135529.1019772-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@linux.dev>

Commit bfb82d57e7 ("hw/usb/hcd-xhci: fix interval alignment after
MFINDEX passes 2^32") fixed both isoch and interrupt scheduling, but
the regression test only covers the isoch path.

Queue a keyboard report on an interrupt IN endpoint after stepping
past 2^32 microframes. Check that the transfer remains pending until
the next interval boundary, then completes with the expected report.
With the old 32-bit mask, it completes as soon as the doorbell is rung.

Link: https://lore.kernel.org/qemu-devel/52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com/
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261004044803.9740-1-junjie.cao@linux.dev>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 432f505fa65ee12544d34998f56f4754115f605f)
(Mjt: this is commit 273bb4dcdebe in 11.1.x series)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 2e173af7506..add2290bffa 100644
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
 
-- 
2.47.3


