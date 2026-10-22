Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49660A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SsxwVAKw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt7p-0006xc-2E; Thu, 22 Oct 2026 09:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7j-0006vT-AJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:27 -0400
Received: from out-55.mta1.migadu.com ([2001:41d0:203:375::37]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7h-0004yb-D2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:27 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=gWT3oRVCz6SAoDgiMcymugAL/7GJtDyCEB7mtRSf1pU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676783; v=1; x=1793281583;
 b=SsxwVAKwbGaDv4nzax3ObRJHsX2XiYDRJFlQNS/ycYPSj04gx/+5hNr1TRxfAWb5UTGklo3c
 CfwhFrmilRJ2T4wykw8BORUvJt3JcILD2mO2vEXVTm91894RIFqcsOau0Api00LueR2MbIiFIJk
 wKmkJ5xk8B8rWsWQKbO2WkAE=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id e2d3d952c994549d;
 Thu, 22 Oct 2026 13:46:23 +0000
X-Mizu-Trace-ID: e2d3d952c994549d
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 2/7] tests/qtest/usb-hcd-ehci: Cover isochronous IN to EP0
Date: Thu, 22 Oct 2026 13:45:56 +0000
Message-ID: <20261022134601.1207204-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134601.1207204-1-junjie.cao@linux.dev>
References: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::37;
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

Start a control request, then submit an isochronous IN transaction to
EP0. The iTD must complete without reading data, and the pending
control request must still return the full descriptor through qTDs.

Removing the endpoint type check in ehci_process_itd() makes the iTD
consume the descriptor and fails the test.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-ehci-test.c | 75 ++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
index 1a8019dab4..66070ee5c1 100644
--- a/tests/qtest/usb-hcd-ehci-test.c
+++ b/tests/qtest/usb-hcd-ehci-test.c
@@ -30,8 +30,16 @@ static struct qhc ehci1;
 #define EHCI_QTD_PID_OUT        0
 #define EHCI_QTD_PID_IN         1
 #define EHCI_QTD_PID_SETUP      2
+#define EHCI_ITD_ACTIVE         (1U << 31)
+#define EHCI_ITD_IOC            (1 << 15)
+#define EHCI_ITD_IN             (1 << 11)
 #define EHCI_FRAME_NS           1000000
 
+enum EHCIControlScenario {
+    EHCI_CONTROL_ONLY,
+    EHCI_ISO_IN_TO_CONTROL,
+};
+
 typedef struct EHCITransferTest {
     QOSState *qs;
     struct qhc hc;
@@ -39,7 +47,9 @@ typedef struct EHCITransferTest {
     uint64_t mem;
     uint64_t qh;
     uint64_t qtd;
+    uint64_t itd;
     uint64_t data;
+    uint64_t isodata;
 } EHCITransferTest;
 
 static uint32_t ehci_readl(EHCITransferTest *t, unsigned int reg)
@@ -74,11 +84,13 @@ static void ehci_transfer_init(EHCITransferTest *t)
                           "-device usb-kbd,bus=ehci.0,port=1,usb_version=2");
     qusb_pci_init_one(t->qs->pcibus, &t->hc, QPCI_DEVFN(0x1d, 7), 0);
     t->opbase = qpci_io_readb(t->hc.dev, t->hc.bar, CAPLENGTH);
-    t->mem = guest_alloc(&t->qs->alloc, 0x2000);
-    t->qh = t->mem;
-    t->qtd = t->mem + 0x100;
-    t->data = t->mem + 0x1000;
-    qtest_memset(t->qs->qts, t->mem, 0, 0x2000);
+    t->mem = guest_alloc(&t->qs->alloc, 0x4000);
+    t->qh = t->mem + 0x1000;
+    t->qtd = t->mem + 0x1100;
+    t->itd = t->mem + 0x1200;
+    t->data = t->mem + 0x2000;
+    t->isodata = t->mem + 0x3000;
+    qtest_memset(t->qs->qts, t->mem, 0, 0x4000);
 
     ehci_writel(t, USBCMD, USBCMD_HCRESET);
     ehci_writel(t, CONFIGFLAG, 1);
@@ -135,15 +147,59 @@ static void ehci_control_packet(EHCITransferTest *t, unsigned int pid,
     ehci_stop_schedules(t);
 }
 
-static void test_ehci_control(void)
+static void ehci_iso_to_control(EHCITransferTest *t)
+{
+    QTestState *qts = t->qs->qts;
+    uint8_t buffer[18];
+    uint32_t transaction;
+    unsigned int i;
+
+    qtest_memset(qts, t->isodata, 0xa5, sizeof(buffer));
+    qtest_writel(qts, t->itd, EHCI_LINK_TERMINATE);
+    qtest_writel(qts, t->itd + 4, EHCI_ITD_ACTIVE | EHCI_ITD_IOC |
+                                  (sizeof(buffer) << 16));
+    qtest_writel(qts, t->itd + 36, t->isodata); /* Address 0, endpoint 0. */
+    qtest_writel(qts, t->itd + 40, 64 | EHCI_ITD_IN);
+    qtest_writel(qts, t->itd + 44, 1); /* One transaction per microframe. */
+    for (i = 0; i < 1024; i++) {
+        qtest_writel(qts, t->mem + 4 * i, t->itd);
+    }
+    ehci_writel(t, USBSTS, USBSTS_RO_MASK);
+    ehci_writel(t, PERIODICLISTBASE, t->mem);
+    ehci_writel(t, USBCMD, USBCMD_RUNSTOP | USBCMD_PSE);
+    for (i = 0; i < 10; i++) {
+        qtest_clock_step(qts, EHCI_FRAME_NS);
+        transaction = qtest_readl(qts, t->itd + 4);
+        if (!(transaction & EHCI_ITD_ACTIVE)) {
+            break;
+        }
+    }
+    g_assert_cmpuint(i, <, 10);
+    /* A non-iso endpoint must not transfer data or receive the packet. */
+    g_assert_cmphex(transaction, ==, EHCI_ITD_IOC);
+    qtest_memread(qts, t->isodata, buffer, sizeof(buffer));
+    for (i = 0; i < sizeof(buffer); i++) {
+        g_assert_cmphex(buffer[i], ==, 0xa5);
+    }
+    g_assert_cmphex(ehci_readl(t, USBSTS) &
+                    (USBSTS_INT | USBSTS_ERRINT | USBSTS_HSE), ==, USBSTS_INT);
+    ehci_stop_schedules(t);
+}
+
+static void test_ehci_control(gconstpointer opaque)
 {
     const uint8_t setup[] = { 0x80, 6, 0, 1, 0, 0, 18, 0 };
+    unsigned int scenario = GPOINTER_TO_UINT(opaque);
     EHCITransferTest t;
     uint8_t descriptor[18];
 
     ehci_transfer_init(&t);
     qtest_memwrite(t.qs->qts, t.data, setup, sizeof(setup));
     ehci_control_packet(&t, EHCI_QTD_PID_SETUP, sizeof(setup));
+    if (scenario != EHCI_CONTROL_ONLY) {
+        ehci_iso_to_control(&t);
+    }
+    /* The invalid iTD must leave the pending control transfer intact. */
     qtest_memset(t.qs->qts, t.data, 0xa5, sizeof(descriptor));
     ehci_control_packet(&t, EHCI_QTD_PID_IN, sizeof(descriptor));
     qtest_memread(t.qs->qts, t.data, descriptor, sizeof(descriptor));
@@ -300,7 +356,12 @@ int main(int argc, char **argv)
     qtest_add_func("/ehci/pci/ehci-port-2", pci_ehci_port_2);
     qtest_add_func("/ehci/pci/ehci-port-3-hotplug", pci_ehci_port_hotplug);
     if (qtest_has_device("usb-kbd")) {
-        qtest_add_func("/ehci/pci/control", test_ehci_control);
+        qtest_add_data_func("/ehci/pci/control",
+                            GUINT_TO_POINTER(EHCI_CONTROL_ONLY),
+                            test_ehci_control);
+        qtest_add_data_func("/ehci/pci/iso-in-to-control",
+                            GUINT_TO_POINTER(EHCI_ISO_IN_TO_CONTROL),
+                            test_ehci_control);
     }
 
     qtest_start("-machine q35 -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,"
-- 
2.43.0


