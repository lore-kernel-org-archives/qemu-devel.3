Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB260A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d+zAp5+l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt7w-00072D-0x; Thu, 22 Oct 2026 09:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7n-0006xV-1Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:31 -0400
Received: from out-91.mta0.migadu.com ([2001:41d0:1004:224b::5b]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7l-0004z9-AQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:30 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=UE6RXNM+obcH7vS942XR7EXu0iU+YYJzWuKVsQfVgtA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676787; v=1; x=1793281587;
 b=d+zAp5+lGgPh+YpmVCu6DjXc5NtOKzC3CyR7LeruWaxB7AOD80s3YBuRoEDvM8tCLAVrhGjz
 D3Q+rx8AR0F24pxraZFcirN+N0lxYbVNjZuMuAQNZg8YObGdSsCY6lIa2xsBu05vLCKiHqPsGva
 E9DRhaU8fYiSLMVSK6PVT8lQ=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id a7154bca160184b5;
 Thu, 22 Oct 2026 13:46:27 +0000
X-Mizu-Trace-ID: a7154bca160184b5
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 3/7] tests/qtest/usb-hcd-ehci: Cover isochronous OUT to EP0
Date: Thu, 22 Oct 2026 13:45:57 +0000
Message-ID: <20261022134601.1207204-4-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134601.1207204-1-junjie.cao@linux.dev>
References: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::5b;
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

An isochronous OUT transaction sent to EP0 must leave a pending
control read intact. Extend the IN mismatch test to cover this
direction as well.

Without the endpoint type check, the unexpected OUT packet changes
the control state and the following valid IN qTD halts.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-ehci-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
index 66070ee5c1..6097d470fb 100644
--- a/tests/qtest/usb-hcd-ehci-test.c
+++ b/tests/qtest/usb-hcd-ehci-test.c
@@ -38,6 +38,7 @@ static struct qhc ehci1;
 enum EHCIControlScenario {
     EHCI_CONTROL_ONLY,
     EHCI_ISO_IN_TO_CONTROL,
+    EHCI_ISO_OUT_TO_CONTROL,
 };
 
 typedef struct EHCITransferTest {
@@ -147,7 +148,7 @@ static void ehci_control_packet(EHCITransferTest *t, unsigned int pid,
     ehci_stop_schedules(t);
 }
 
-static void ehci_iso_to_control(EHCITransferTest *t)
+static void ehci_iso_to_control(EHCITransferTest *t, bool in)
 {
     QTestState *qts = t->qs->qts;
     uint8_t buffer[18];
@@ -159,7 +160,7 @@ static void ehci_iso_to_control(EHCITransferTest *t)
     qtest_writel(qts, t->itd + 4, EHCI_ITD_ACTIVE | EHCI_ITD_IOC |
                                   (sizeof(buffer) << 16));
     qtest_writel(qts, t->itd + 36, t->isodata); /* Address 0, endpoint 0. */
-    qtest_writel(qts, t->itd + 40, 64 | EHCI_ITD_IN);
+    qtest_writel(qts, t->itd + 40, 64 | (in ? EHCI_ITD_IN : 0));
     qtest_writel(qts, t->itd + 44, 1); /* One transaction per microframe. */
     for (i = 0; i < 1024; i++) {
         qtest_writel(qts, t->mem + 4 * i, t->itd);
@@ -176,7 +177,8 @@ static void ehci_iso_to_control(EHCITransferTest *t)
     }
     g_assert_cmpuint(i, <, 10);
     /* A non-iso endpoint must not transfer data or receive the packet. */
-    g_assert_cmphex(transaction, ==, EHCI_ITD_IOC);
+    g_assert_cmphex(transaction, ==, EHCI_ITD_IOC |
+                    (in ? 0 : sizeof(buffer) << 16));
     qtest_memread(qts, t->isodata, buffer, sizeof(buffer));
     for (i = 0; i < sizeof(buffer); i++) {
         g_assert_cmphex(buffer[i], ==, 0xa5);
@@ -197,7 +199,7 @@ static void test_ehci_control(gconstpointer opaque)
     qtest_memwrite(t.qs->qts, t.data, setup, sizeof(setup));
     ehci_control_packet(&t, EHCI_QTD_PID_SETUP, sizeof(setup));
     if (scenario != EHCI_CONTROL_ONLY) {
-        ehci_iso_to_control(&t);
+        ehci_iso_to_control(&t, scenario == EHCI_ISO_IN_TO_CONTROL);
     }
     /* The invalid iTD must leave the pending control transfer intact. */
     qtest_memset(t.qs->qts, t.data, 0xa5, sizeof(descriptor));
@@ -362,6 +364,9 @@ int main(int argc, char **argv)
         qtest_add_data_func("/ehci/pci/iso-in-to-control",
                             GUINT_TO_POINTER(EHCI_ISO_IN_TO_CONTROL),
                             test_ehci_control);
+        qtest_add_data_func("/ehci/pci/iso-out-to-control",
+                            GUINT_TO_POINTER(EHCI_ISO_OUT_TO_CONTROL),
+                            test_ehci_control);
     }
 
     qtest_start("-machine q35 -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,"
-- 
2.43.0


