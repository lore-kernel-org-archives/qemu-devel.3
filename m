Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87C606A333
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iwBBBKkX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xODiR-0000Cb-0d; Tue, 03 Nov 2026 07:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xODiK-0000AQ-UA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:34:09 -0500
Received: from out-148.mta1.migadu.com ([95.215.58.148] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xODiJ-0005Mo-3q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:34:08 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=K1FxMyuJTEOJcNaBNIhk1yFfIKHt5f4bGQT6c7TTMl8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793709245; v=1; x=1794314045;
 b=iwBBBKkXjB1rmwOwFdFS/AuMjwRkD6mOdr63y5+iU/DgqxWUhWYQb5CM/ItkU5+gvKckpP7R
 k7nvrPE4QEf+PwNFe9RHrQ1G3hNFcQbu2PhoehPfWDPv0pkGlTgiNphQ2Dkd/pn6R8qheYdfcUA
 XnG1Mxutegl0FyemLBJJAgNo=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 03580630d6fb2a36;
 Tue, 03 Nov 2026 12:34:05 +0000
X-Mizu-Trace-ID: 03580630d6fb2a36
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, jamin_lin@aspeedtech.com, philmd@oss.qualcomm.com,
 clg@redhat.com, peter.maydell@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, junjie.cao@linux.dev
Subject: [PATCH 2/2] tests/qtest/usb-hcd-ehci: test descriptor reads that fail
Date: Tue,  3 Nov 2026 06:33:50 -0600
Message-ID: <20261103123350.1253202-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103123350.1253202-1-junjie.cao@linux.dev>
References: <20261103123350.1253202-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.148; envelope-from=junjie.cao@linux.dev;
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

Run the async schedule into an unreadable list head, into a head QH
whose horizontal link is unreadable and into a QH whose next qTD is
unreadable, and the periodic schedule into an unreadable siTD.  Each
must raise HSE, clear Run/Stop and leave the controller halted with
both schedules idle on the following frames; before the previous patch
QEMU aborted there.  A reset afterwards must bring the controller back.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 tests/qtest/usb-hcd-ehci-test.c | 119 ++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
index 87e37cdd7c..b0a0b6df9b 100644
--- a/tests/qtest/usb-hcd-ehci-test.c
+++ b/tests/qtest/usb-hcd-ehci-test.c
@@ -12,6 +12,7 @@
 #include "libqos/pci-pc.h"
 #include "hw/usb/uhci-regs.h"
 #include "hw/usb/ehci-regs.h"
+#include "hw/usb/hcd-ehci.h"
 #include "libqos/usb.h"
 
 static QPCIBus *pcibus;
@@ -142,6 +143,123 @@ static void pci_ehci_port_hotplug(void)
     usb_test_hotplug(global_qtest, "ich9-ehci-1", "3", pci_ehci_port_3_hotplug);
 }
 
+/* operational registers, relative to the BAR */
+#define EHCI_USBCMD             0x20
+#define EHCI_USBSTS             0x24
+#define EHCI_PERIODICLISTBASE   0x34
+#define EHCI_ASYNCLISTADDR      0x38
+
+#define NLPTR_TYPE_QH           (1 << 1)
+#define NLPTR_TYPE_SITD         (2 << 1)
+#define NLPTR_T                 1
+
+#define QH_ADDR                 0x100000    /* in the default 128 MiB of RAM */
+#define FRAME_LIST_ADDR         0x101000
+#define BAD_ADDR                0x40000000  /* above RAM, nothing mapped */
+#define FRAME_NS                1000000
+
+static uint32_t ehci_readl(uint32_t off)
+{
+    return qpci_io_readl(ehci1.dev, ehci1.bar, off);
+}
+
+static void ehci_writel(uint32_t off, uint32_t val)
+{
+    qpci_io_writel(ehci1.dev, ehci1.bar, off, val);
+}
+
+static void ehci_hcreset(void)
+{
+    ehci_writel(EHCI_USBCMD, USBCMD_HCRESET);
+    g_assert_cmphex(ehci_readl(EHCI_USBCMD) & USBCMD_HCRESET, ==, 0);
+    g_assert_cmphex(ehci_readl(EHCI_USBSTS) & USBSTS_HALT, ==, USBSTS_HALT);
+}
+
+static void ehci_write_qh(uint32_t next, uint32_t next_qtd)
+{
+    uint32_t qh[16] = {
+        next,
+        QH_EPCHAR_H | (64 << QH_EPCHAR_MPLEN_SH) |
+            (EHCI_QH_EPS_HIGH << QH_EPCHAR_EPS_SH),
+        1 << QH_EPCAP_MULT_SH,
+        0,                                      /* current qTD */
+        next_qtd,
+        NLPTR_T,                                /* alternate next qTD */
+        0,                                      /* token: inactive */
+    };
+
+    memwrite(QH_ADDR, qh, sizeof(qh));
+}
+
+/* Run a schedule into a descriptor that cannot be read. */
+static void ehci_run_into_dma_error(uint32_t usbcmd)
+{
+    uint32_t sts;
+    int i;
+
+    ehci_writel(EHCI_USBCMD, usbcmd);
+    for (i = 0; i < 16; i++) {
+        clock_step(FRAME_NS);
+        if (ehci_readl(EHCI_USBSTS) & USBSTS_HSE) {
+            break;
+        }
+    }
+    g_assert_cmphex(ehci_readl(EHCI_USBSTS) & USBSTS_HSE, ==, USBSTS_HSE);
+    g_assert_cmphex(ehci_readl(EHCI_USBCMD) & USBCMD_RUNSTOP, ==, 0);
+
+    for (i = 0; i < 4; i++) {
+        clock_step(FRAME_NS);
+    }
+    sts = ehci_readl(EHCI_USBSTS);
+    g_assert_cmphex(sts & USBSTS_HALT, ==, USBSTS_HALT);
+    g_assert_cmphex(sts & (USBSTS_ASS | USBSTS_PSS), ==, 0);
+
+    /* a reset must bring the controller back */
+    ehci_hcreset();
+    ehci_write_qh(QH_ADDR | NLPTR_TYPE_QH, NLPTR_T);
+    ehci_writel(EHCI_ASYNCLISTADDR, QH_ADDR);
+    ehci_writel(EHCI_USBCMD, USBCMD_RUNSTOP | USBCMD_ASE);
+    for (i = 0; i < 4; i++) {
+        clock_step(FRAME_NS);
+    }
+    g_assert_cmphex(ehci_readl(EHCI_USBSTS) & (USBSTS_HSE | USBSTS_HALT),
+                    ==, 0);
+    g_assert_cmphex(ehci_readl(EHCI_USBCMD) & USBCMD_RUNSTOP, ==,
+                    USBCMD_RUNSTOP);
+    ehci_hcreset();
+}
+
+static void pci_ehci_dma_error(void)
+{
+    uint32_t entries[32];
+    int i;
+
+    g_assert(pcibus != NULL);
+    ehci_hcreset();
+
+    /* async schedule: the list head itself is unreadable */
+    ehci_writel(EHCI_ASYNCLISTADDR, BAD_ADDR);
+    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_ASE);
+
+    /* async schedule: the head QH links to an unreadable QH */
+    ehci_write_qh(BAD_ADDR | NLPTR_TYPE_QH, NLPTR_T);
+    ehci_writel(EHCI_ASYNCLISTADDR, QH_ADDR);
+    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_ASE);
+
+    /* async schedule: a readable QH points at an unreadable qTD */
+    ehci_write_qh(QH_ADDR | NLPTR_TYPE_QH, BAD_ADDR);
+    ehci_writel(EHCI_ASYNCLISTADDR, QH_ADDR);
+    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_ASE);
+
+    /* periodic schedule: the frame list points at an unreadable siTD */
+    for (i = 0; i < ARRAY_SIZE(entries); i++) {
+        entries[i] = BAD_ADDR | NLPTR_TYPE_SITD;
+    }
+    memwrite(FRAME_LIST_ADDR, entries, sizeof(entries));
+    ehci_writel(EHCI_PERIODICLISTBASE, FRAME_LIST_ADDR);
+    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_PSE);
+}
+
 
 int main(int argc, char **argv)
 {
@@ -160,6 +278,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ehci/pci/uhci-port-2", pci_uhci_port_2);
     qtest_add_func("/ehci/pci/ehci-port-2", pci_ehci_port_2);
     qtest_add_func("/ehci/pci/ehci-port-3-hotplug", pci_ehci_port_hotplug);
+    qtest_add_func("/ehci/pci/ehci-dma-error", pci_ehci_dma_error);
 
     qtest_start("-machine q35 -device ich9-usb-ehci1,bus=pcie.0,addr=1d.7,"
                 "multifunction=on,id=ich9-ehci-1 "
-- 
2.43.0


