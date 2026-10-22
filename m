Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57660A6F74
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GZTUUZR6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt8F-0007K5-9H; Thu, 22 Oct 2026 09:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt82-00074j-Fa
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:50 -0400
Received: from out-106.mta0.migadu.com ([2001:41d0:1004:224b::6a]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7y-00050j-Nk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:45 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=DokBFf8r1+uyxljl5i06J/Di2OG6hAEe62RJbEpfx4o=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676801; v=1; x=1793281601;
 b=GZTUUZR6i6C78+FXSfF9jHASkPIOI/0ZA8GfLIhM+KDTVAbX9KBAZt6YJLiJ9QX7P4UEoVvO
 lpaPL9lwnNixAXeEdR5EhcdjmPvSOBBX9nwtdTyfcsvl/+stTNqSRXivL1AcmkdqZNU0/5zAwo1
 5VDTTQ69e3p/aqyM5e1wE/F0=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id ce1931ef4cc8a024;
 Thu, 22 Oct 2026 13:46:41 +0000
X-Mizu-Trace-ID: ce1931ef4cc8a024
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 5/7] tests/qtest/usb-hcd-uhci: Test isochronous NAK
 completion
Date: Thu, 22 Oct 2026 13:45:59 +0000
Message-ID: <20261022134601.1207204-6-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134601.1207204-1-junjie.cao@linux.dev>
References: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::6a;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
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

A TD marked isochronous must become inactive on NAK. Send such a TD
to the keyboard's interrupt endpoint, then inject a key and check
that the inactive TD does not consume it. A new ordinary TD must
still return that report.

Removing the isochronous ACTIVE-bit clearing in uhci_complete_td()
fails this test.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-uhci-test.c | 38 ++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/usb-hcd-uhci-test.c b/tests/qtest/usb-hcd-uhci-test.c
index 5c2b6cef7c..bad279e9a2 100644
--- a/tests/qtest/usb-hcd-uhci-test.c
+++ b/tests/qtest/usb-hcd-uhci-test.c
@@ -64,13 +64,17 @@ static uint32_t uhci_step(UHCITransferTest *t)
 }
 
 static void uhci_submit(UHCITransferTest *t, unsigned int pid, unsigned int ep,
-                        unsigned int len, bool data1)
+                        unsigned int len, bool data1, bool iso)
 {
     unsigned int i;
-    uint32_t ctrl = TD_CTRL_ACTIVE | TD_CTRL_IOC | 0x7ff |
-                    (3 << TD_CTRL_ERROR_SHIFT);
+    uint32_t ctrl = TD_CTRL_ACTIVE | TD_CTRL_IOC | 0x7ff;
 
     uhci_writew(t, UHCI_USBCMD, 0);
+    if (iso) {
+        ctrl |= TD_CTRL_IOS;
+    } else {
+        ctrl |= 3 << TD_CTRL_ERROR_SHIFT;
+    }
     uhci_mem_writel(t, t->td, UHCI_LINK_END);
     uhci_mem_writel(t, t->td + 4, ctrl);
     uhci_mem_writel(t, t->td + 8, pid | (ep << 15) | (data1 << 19) |
@@ -79,7 +83,8 @@ static void uhci_submit(UHCITransferTest *t, unsigned int pid, unsigned int ep,
     uhci_mem_writel(t, t->qh, UHCI_LINK_END);
     uhci_mem_writel(t, t->qh + 4, t->td);
     for (i = 0; i < 1024; i++) {
-        uhci_mem_writel(t, t->mem + 4 * i, t->qh | UHCI_LINK_QH);
+        uhci_mem_writel(t, t->mem + 4 * i,
+                        iso ? t->td : t->qh | UHCI_LINK_QH);
     }
     uhci_writew(t, UHCI_USBSTS, UHCI_STS_USBINT | UHCI_STS_USBERR);
     uhci_writew(t, UHCI_USBCMD, UHCI_CMD_RS);
@@ -133,15 +138,16 @@ static void uhci_transfer_init(UHCITransferTest *t)
 
     /* Configure the keyboard's interrupt endpoint through EP0 first. */
     qtest_memwrite(t->qs->qts, t->data, setup, sizeof(setup));
-    uhci_submit(t, UHCI_PID_SETUP, 0, sizeof(setup), false);
+    uhci_submit(t, UHCI_PID_SETUP, 0, sizeof(setup), false, false);
     uhci_expect_complete(t, sizeof(setup));
-    uhci_submit(t, UHCI_PID_IN, 0, 0, true);
+    uhci_submit(t, UHCI_PID_IN, 0, 0, true, false);
     uhci_expect_complete(t, 0);
 }
 
-static void test_uhci_nak(void)
+static void test_uhci_nak(gconstpointer opaque)
 {
     const uint8_t expected[] = { 0, 0, 4, 0, 0, 0, 0, 0 };
+    const bool iso = GPOINTER_TO_UINT(opaque);
     UHCITransferTest t;
     uint8_t report[sizeof(expected)];
     uint32_t ctrl;
@@ -149,11 +155,11 @@ static void test_uhci_nak(void)
 
     uhci_transfer_init(&t);
     qtest_memset(t.qs->qts, t.data, 0xa5, sizeof(report));
-    uhci_submit(&t, UHCI_PID_IN, 1, sizeof(report), false);
+    uhci_submit(&t, UHCI_PID_IN, 1, sizeof(report), false, iso);
     for (i = 0; i < 3; i++) {
         ctrl = uhci_step(&t);
         g_assert_cmphex(ctrl & (TD_CTRL_ACTIVE | TD_CTRL_NAK), ==,
-                        TD_CTRL_NAK | TD_CTRL_ACTIVE);
+                        TD_CTRL_NAK | (iso ? 0 : TD_CTRL_ACTIVE));
         g_assert_cmpuint((ctrl + 1) & 0x7ff, ==, 0);
     }
     qtest_memread(t.qs->qts, t.data, report, sizeof(report));
@@ -165,6 +171,15 @@ static void test_uhci_nak(void)
         "{'execute': 'input-send-event', 'arguments': {'events': ["
         "{'type': 'key', 'data': {'down': true, "
         "'key': {'type': 'qcode', 'data': 'a'}}}]}}");
+    if (iso) {
+        /* An inactive isochronous TD must not consume the new report. */
+        g_assert_cmphex(uhci_step(&t), ==, ctrl);
+        qtest_memread(t.qs->qts, t.data, report, sizeof(report));
+        for (i = 0; i < sizeof(report); i++) {
+            g_assert_cmphex(report[i], ==, 0xa5);
+        }
+        uhci_submit(&t, UHCI_PID_IN, 1, sizeof(report), false, false);
+    }
     uhci_expect_complete(&t, sizeof(report));
     qtest_memread(t.qs->qts, t.data, report, sizeof(report));
     g_assert_cmpmem(report, sizeof(report), expected, sizeof(expected));
@@ -231,7 +246,10 @@ int main(int argc, char **argv)
         qtest_add_func("/uhci/pci/hotplug/usb-storage", test_usb_storage_hotplug);
     }
     if (qtest_has_device("usb-kbd")) {
-        qtest_add_func("/uhci/pci/intr-nak", test_uhci_nak);
+        qtest_add_data_func("/uhci/pci/intr-nak", GUINT_TO_POINTER(false),
+                            test_uhci_nak);
+        qtest_add_data_func("/uhci/pci/iso-nak", GUINT_TO_POINTER(true),
+                            test_uhci_nak);
     }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-- 
2.43.0


