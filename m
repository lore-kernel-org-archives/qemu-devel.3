Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4F606AF55
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v4J14Ms9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt7l-0006wO-GR; Thu, 22 Oct 2026 09:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7g-0006vB-MS
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:25 -0400
Received: from out-85.mta0.migadu.com ([2001:41d0:1004:224b::55]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7e-0004yH-9D
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:24 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=YioOvpGGItWk4UVSGUVQavUE/mHIViNyIS7Yr/VjNwA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676780; v=1; x=1793281580;
 b=v4J14Ms93IlfUfHgORsX1mNf7NyXTBOFctrzzaPy0GljwDPCv9grUrrrXIz0eD2IoCzzwZQO
 Li5tfM3i7tjQDpbQj1k2GntF9/AHia2nJ3mBoxo/g3l+BBBBkQscv13OKWet2f5C1bIUmHn9OI/
 N0KMnb82NxCepK2eph7kYw0w=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 0172a7e49be47a04;
 Thu, 22 Oct 2026 13:46:20 +0000
X-Mizu-Trace-ID: 0172a7e49be47a04
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 1/7] tests/qtest/usb-hcd-ehci: Test a control transfer
Date: Thu, 22 Oct 2026 13:45:55 +0000
Message-ID: <20261022134601.1207204-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134601.1207204-1-junjie.cao@linux.dev>
References: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::55;
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

The EHCI tests currently cover port state and hotplug. Drive a
GET_DESCRIPTOR request through the asynchronous schedule and check its
data and completion status. This provides a working control transfer
for the endpoint mismatch tests that follow.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-ehci-test.c | 142 ++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
index 87e37cdd7c..1a8019dab4 100644
--- a/tests/qtest/usb-hcd-ehci-test.c
+++ b/tests/qtest/usb-hcd-ehci-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "libqos/libqos-pc.h"
 #include "libqos/pci-pc.h"
 #include "hw/usb/uhci-regs.h"
 #include "hw/usb/ehci-regs.h"
@@ -20,6 +21,144 @@ static struct qhc uhci2;
 static struct qhc uhci3;
 static struct qhc ehci1;
 
+/* Guest descriptor fields from EHCI sections 3.3, 3.5 and 3.6. */
+#define EHCI_LINK_TERMINATE     1
+#define EHCI_LINK_QH            2
+#define EHCI_QTD_ACTIVE         (1 << 7)
+#define EHCI_QTD_IOC            (1 << 15)
+#define EHCI_QTD_DATA1          (1U << 31)
+#define EHCI_QTD_PID_OUT        0
+#define EHCI_QTD_PID_IN         1
+#define EHCI_QTD_PID_SETUP      2
+#define EHCI_FRAME_NS           1000000
+
+typedef struct EHCITransferTest {
+    QOSState *qs;
+    struct qhc hc;
+    uint32_t opbase;
+    uint64_t mem;
+    uint64_t qh;
+    uint64_t qtd;
+    uint64_t data;
+} EHCITransferTest;
+
+static uint32_t ehci_readl(EHCITransferTest *t, unsigned int reg)
+{
+    return qpci_io_readl(t->hc.dev, t->hc.bar, t->opbase + reg);
+}
+
+static void ehci_writel(EHCITransferTest *t, unsigned int reg, uint32_t value)
+{
+    qpci_io_writel(t->hc.dev, t->hc.bar, t->opbase + reg, value);
+}
+
+static void ehci_stop_schedules(EHCITransferTest *t)
+{
+    unsigned int i;
+
+    ehci_writel(t, USBCMD, USBCMD_RUNSTOP);
+    for (i = 0; i < 10; i++) {
+        qtest_clock_step(t->qs->qts, EHCI_FRAME_NS);
+        if (!(ehci_readl(t, USBSTS) & (USBSTS_ASS | USBSTS_PSS))) {
+            break;
+        }
+    }
+    g_assert_cmpuint(i, <, 10);
+    g_assert_cmphex(ehci_readl(t, USBSTS) & USBSTS_HSE, ==, 0);
+}
+
+static void ehci_transfer_init(EHCITransferTest *t)
+{
+    t->qs = qtest_pc_boot("-machine q35,pit=off -nodefaults "
+                          "-device ich9-usb-ehci1,id=ehci,addr=1d.7 "
+                          "-device usb-kbd,bus=ehci.0,port=1,usb_version=2");
+    qusb_pci_init_one(t->qs->pcibus, &t->hc, QPCI_DEVFN(0x1d, 7), 0);
+    t->opbase = qpci_io_readb(t->hc.dev, t->hc.bar, CAPLENGTH);
+    t->mem = guest_alloc(&t->qs->alloc, 0x2000);
+    t->qh = t->mem;
+    t->qtd = t->mem + 0x100;
+    t->data = t->mem + 0x1000;
+    qtest_memset(t->qs->qts, t->mem, 0, 0x2000);
+
+    ehci_writel(t, USBCMD, USBCMD_HCRESET);
+    ehci_writel(t, CONFIGFLAG, 1);
+    /* PORTSC1 follows CONFIGFLAG. */
+    ehci_writel(t, CONFIGFLAG + 4, PORTSC_PPOWER | PORTSC_PRESET);
+    qtest_clock_step(t->qs->qts, 50 * EHCI_FRAME_NS);
+    ehci_writel(t, CONFIGFLAG + 4, PORTSC_PPOWER);
+    g_assert_cmphex(ehci_readl(t, CONFIGFLAG + 4) &
+                    (PORTSC_CONNECT | PORTSC_PED), ==,
+                    PORTSC_CONNECT | PORTSC_PED);
+    ehci_writel(t, USBSTS, USBSTS_RO_MASK);
+}
+
+static void ehci_control_packet(EHCITransferTest *t, unsigned int pid,
+                                unsigned int len)
+{
+    QTestState *qts = t->qs->qts;
+    uint32_t token;
+    unsigned int i;
+
+    qtest_memset(qts, t->qh, 0, 96);
+    qtest_memset(qts, t->qtd, 0, 64);
+    qtest_writel(qts, t->qh, t->qh | EHCI_LINK_QH);
+    /* EP0, high speed, qTD data toggle, reclamation head, 64-byte packets. */
+    qtest_writel(qts, t->qh + 4, (2 << 12) | (1 << 14) | (1 << 15) |
+                                (64 << 16));
+    qtest_writel(qts, t->qh + 8, 1 << 30);
+    qtest_writel(qts, t->qh + 16, t->qtd);
+    qtest_writel(qts, t->qh + 20, EHCI_LINK_TERMINATE);
+    qtest_writel(qts, t->qtd, EHCI_LINK_TERMINATE);
+    qtest_writel(qts, t->qtd + 4, EHCI_LINK_TERMINATE);
+    token = EHCI_QTD_ACTIVE | EHCI_QTD_IOC | (3 << 10) |
+            (pid << 8) | (len << 16);
+    if (pid != EHCI_QTD_PID_SETUP) {
+        token |= EHCI_QTD_DATA1;
+    }
+    qtest_writel(qts, t->qtd + 8, token);
+    qtest_writel(qts, t->qtd + 12, t->data);
+    ehci_writel(t, USBSTS, USBSTS_RO_MASK);
+    ehci_writel(t, ASYNCLISTADDR, t->qh);
+    ehci_writel(t, USBCMD, USBCMD_RUNSTOP | USBCMD_ASE);
+    for (i = 0; i < 10; i++) {
+        qtest_clock_step(qts, EHCI_FRAME_NS);
+        token = qtest_readl(qts, t->qtd + 8);
+        if (!(token & EHCI_QTD_ACTIVE)) {
+            break;
+        }
+    }
+    g_assert_cmpuint(i, <, 10);
+    g_assert_cmphex(token & 0xff, ==, 0);
+    g_assert_cmpuint((token >> 16) & 0x7fff, ==, 0);
+    g_assert_cmphex(ehci_readl(t, USBSTS) &
+                    (USBSTS_INT | USBSTS_ERRINT | USBSTS_HSE), ==, USBSTS_INT);
+    ehci_stop_schedules(t);
+}
+
+static void test_ehci_control(void)
+{
+    const uint8_t setup[] = { 0x80, 6, 0, 1, 0, 0, 18, 0 };
+    EHCITransferTest t;
+    uint8_t descriptor[18];
+
+    ehci_transfer_init(&t);
+    qtest_memwrite(t.qs->qts, t.data, setup, sizeof(setup));
+    ehci_control_packet(&t, EHCI_QTD_PID_SETUP, sizeof(setup));
+    qtest_memset(t.qs->qts, t.data, 0xa5, sizeof(descriptor));
+    ehci_control_packet(&t, EHCI_QTD_PID_IN, sizeof(descriptor));
+    qtest_memread(t.qs->qts, t.data, descriptor, sizeof(descriptor));
+    g_assert_cmpuint(descriptor[0], ==, sizeof(descriptor));
+    g_assert_cmpuint(descriptor[1], ==, 1);
+    g_assert_cmpuint(descriptor[7], ==, 64);
+    g_assert_cmpuint(descriptor[17], ==, 1);
+    ehci_control_packet(&t, EHCI_QTD_PID_OUT, 0);
+
+    qpci_iounmap(t.hc.dev, t.hc.bar);
+    uhci_deinit(&t.hc);
+    guest_free(&t.qs->alloc, t.mem);
+    qtest_shutdown(t.qs);
+}
+
 /* helpers */
 
 #if 0
@@ -160,6 +299,9 @@ int main(int argc, char **argv)
     qtest_add_func("/ehci/pci/uhci-port-2", pci_uhci_port_2);
     qtest_add_func("/ehci/pci/ehci-port-2", pci_ehci_port_2);
     qtest_add_func("/ehci/pci/ehci-port-3-hotplug", pci_ehci_port_hotplug);
+    if (qtest_has_device("usb-kbd")) {
+        qtest_add_func("/ehci/pci/control", test_ehci_control);
+    }
 
     qtest_start("-machine q35 -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,"
                 "multifunction=on,id=ich9-ehci-1 "
-- 
2.43.0


