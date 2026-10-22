Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246160A6F6C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H4G/45Ft
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt8E-0007CT-66; Thu, 22 Oct 2026 09:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7v-00073V-Ff
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:40 -0400
Received: from out-65.mta1.migadu.com ([2001:41d0:203:375::41]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7s-0004zz-5j
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:38 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=6Fq/z6mkbl2W1vOskWaj9N2iAM4pg1d9ZkOnJm8XJ6w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676794; v=1; x=1793281594;
 b=H4G/45Fto5eEoqGCbmdoa+2mpO0yPk6vuGuEYq4J5KEnRMOKebSRBgYvr9ukpkmzUiupKTHX
 zujblwNGrqCLbrhG7SL3hRwcdwNVzYNxG83SApRLonnUqLhRtnxt7VfQb37N0od7BJ7yLv4IqaE
 gsUh0RClgrsTOwsO/vbmeYQ0=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id e5f501b8f4e3cc19;
 Thu, 22 Oct 2026 13:46:34 +0000
X-Mizu-Trace-ID: e5f501b8f4e3cc19
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 4/7] tests/qtest/usb-hcd-uhci: Test interrupt NAK retries
Date: Thu, 22 Oct 2026 13:45:58 +0000
Message-ID: <20261022134601.1207204-5-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134601.1207204-1-junjie.cao@linux.dev>
References: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::41;
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

An idle interrupt endpoint must leave its TD active on NAK. Once
data arrives, completion must clear the NAK bit left by earlier
attempts.

Configure a USB keyboard through EP0, check that an IN TD stays
pending over several frames, then inject a key and verify the report,
completion status and QH advancement. Keeping NAK set on completion
fails this test.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 tests/qtest/usb-hcd-uhci-test.c | 161 ++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tests/qtest/usb-hcd-uhci-test.c b/tests/qtest/usb-hcd-uhci-test.c
index 4446555f08..5c2b6cef7c 100644
--- a/tests/qtest/usb-hcd-uhci-test.c
+++ b/tests/qtest/usb-hcd-uhci-test.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "libqtest-single.h"
 #include "libqos/libqos.h"
 #include "libqos/usb.h"
@@ -17,6 +18,163 @@
 
 static QOSState *qs;
 
+#define UHCI_FRAME_NS 1000000
+#define UHCI_PID_SETUP 0x2d
+#define UHCI_PID_IN    0x69
+#define UHCI_LINK_END  1
+#define UHCI_LINK_QH   2
+
+typedef struct UHCITransferTest {
+    QOSState *qs;
+    struct qhc hc;
+    uint64_t mem;
+    uint64_t qh;
+    uint64_t td;
+    uint64_t data;
+} UHCITransferTest;
+
+static uint32_t uhci_mem_readl(UHCITransferTest *t, uint64_t addr)
+{
+    uint32_t value;
+
+    qtest_memread(t->qs->qts, addr, &value, sizeof(value));
+    return le32_to_cpu(value);
+}
+
+static void uhci_mem_writel(UHCITransferTest *t, uint64_t addr, uint32_t value)
+{
+    value = cpu_to_le32(value);
+    qtest_memwrite(t->qs->qts, addr, &value, sizeof(value));
+}
+
+static void uhci_writew(UHCITransferTest *t, unsigned int reg, uint16_t value)
+{
+    qpci_io_writew(t->hc.dev, t->hc.bar, reg, value);
+}
+
+static uint32_t uhci_step(UHCITransferTest *t)
+{
+    uint16_t status;
+
+    qtest_clock_step(t->qs->qts, UHCI_FRAME_NS);
+    status = qpci_io_readw(t->hc.dev, t->hc.bar, UHCI_USBSTS);
+    g_assert_cmphex(status & (UHCI_STS_HSERR | UHCI_STS_HCPERR |
+                              UHCI_STS_USBERR), ==, 0);
+    return uhci_mem_readl(t, t->td + 4);
+}
+
+static void uhci_submit(UHCITransferTest *t, unsigned int pid, unsigned int ep,
+                        unsigned int len, bool data1)
+{
+    unsigned int i;
+    uint32_t ctrl = TD_CTRL_ACTIVE | TD_CTRL_IOC | 0x7ff |
+                    (3 << TD_CTRL_ERROR_SHIFT);
+
+    uhci_writew(t, UHCI_USBCMD, 0);
+    uhci_mem_writel(t, t->td, UHCI_LINK_END);
+    uhci_mem_writel(t, t->td + 4, ctrl);
+    uhci_mem_writel(t, t->td + 8, pid | (ep << 15) | (data1 << 19) |
+                                (((len - 1) & 0x7ff) << 21));
+    uhci_mem_writel(t, t->td + 12, t->data);
+    uhci_mem_writel(t, t->qh, UHCI_LINK_END);
+    uhci_mem_writel(t, t->qh + 4, t->td);
+    for (i = 0; i < 1024; i++) {
+        uhci_mem_writel(t, t->mem + 4 * i, t->qh | UHCI_LINK_QH);
+    }
+    uhci_writew(t, UHCI_USBSTS, UHCI_STS_USBINT | UHCI_STS_USBERR);
+    uhci_writew(t, UHCI_USBCMD, UHCI_CMD_RS);
+}
+
+static void uhci_expect_complete(UHCITransferTest *t, unsigned int len)
+{
+    uint32_t ctrl;
+    unsigned int i;
+
+    for (i = 0; i < 10; i++) {
+        ctrl = uhci_step(t);
+        if (!(ctrl & TD_CTRL_ACTIVE)) {
+            break;
+        }
+    }
+    g_assert_cmpuint(i, <, 10);
+    g_assert_cmphex(ctrl & (TD_CTRL_ACTIVE | TD_CTRL_STALL | TD_CTRL_BABBLE |
+                            TD_CTRL_NAK | TD_CTRL_TIMEOUT), ==, 0);
+    g_assert_cmpuint((ctrl + 1) & 0x7ff, ==, len);
+    g_assert_cmphex(uhci_mem_readl(t, t->qh + 4), ==, UHCI_LINK_END);
+    uhci_writew(t, UHCI_USBCMD, 0);
+}
+
+static void uhci_transfer_init(UHCITransferTest *t)
+{
+    const char *cmd = "-nodefaults -global pci-host-bridge.bypass-iommu=on "
+                      "-device piix3-usb-uhci,id=uhci,addr=1d.0 "
+                      "-device usb-kbd,bus=uhci.0,port=1";
+    const uint8_t setup[] = { 0, 9, 1, 0, 0, 0, 0, 0 };
+
+    if (!strcmp(qtest_get_arch(), "ppc64")) {
+        t->qs = qtest_spapr_boot("%s", cmd);
+    } else {
+        t->qs = qtest_pc_boot("-machine pc,pit=off %s", cmd);
+    }
+    qusb_pci_init_one(t->qs->pcibus, &t->hc, QPCI_DEVFN(0x1d, 0), 4);
+    t->mem = guest_alloc(&t->qs->alloc, 0x3000);
+    t->qh = t->mem + 0x1000;
+    t->td = t->mem + 0x1100;
+    t->data = t->mem + 0x2000;
+    qtest_memset(t->qs->qts, t->mem, 0, 0x3000);
+    uhci_writew(t, UHCI_USBCMD, UHCI_CMD_HCRESET);
+    uhci_writew(t, UHCI_USBPORTSC1, UHCI_PORT_RESET);
+    qtest_clock_step(t->qs->qts, 50 * UHCI_FRAME_NS);
+    uhci_writew(t, UHCI_USBPORTSC1, UHCI_PORT_EN);
+    g_assert_cmphex(qpci_io_readw(t->hc.dev, t->hc.bar, UHCI_USBPORTSC1) &
+                    (UHCI_PORT_CCS | UHCI_PORT_EN), ==,
+                    UHCI_PORT_CCS | UHCI_PORT_EN);
+    qpci_io_writel(t->hc.dev, t->hc.bar, UHCI_USBFLBASEADD, t->mem);
+
+    /* Configure the keyboard's interrupt endpoint through EP0 first. */
+    qtest_memwrite(t->qs->qts, t->data, setup, sizeof(setup));
+    uhci_submit(t, UHCI_PID_SETUP, 0, sizeof(setup), false);
+    uhci_expect_complete(t, sizeof(setup));
+    uhci_submit(t, UHCI_PID_IN, 0, 0, true);
+    uhci_expect_complete(t, 0);
+}
+
+static void test_uhci_nak(void)
+{
+    const uint8_t expected[] = { 0, 0, 4, 0, 0, 0, 0, 0 };
+    UHCITransferTest t;
+    uint8_t report[sizeof(expected)];
+    uint32_t ctrl;
+    unsigned int i;
+
+    uhci_transfer_init(&t);
+    qtest_memset(t.qs->qts, t.data, 0xa5, sizeof(report));
+    uhci_submit(&t, UHCI_PID_IN, 1, sizeof(report), false);
+    for (i = 0; i < 3; i++) {
+        ctrl = uhci_step(&t);
+        g_assert_cmphex(ctrl & (TD_CTRL_ACTIVE | TD_CTRL_NAK), ==,
+                        TD_CTRL_NAK | TD_CTRL_ACTIVE);
+        g_assert_cmpuint((ctrl + 1) & 0x7ff, ==, 0);
+    }
+    qtest_memread(t.qs->qts, t.data, report, sizeof(report));
+    for (i = 0; i < sizeof(report); i++) {
+        g_assert_cmphex(report[i], ==, 0xa5);
+    }
+
+    qtest_qmp_assert_success(t.qs->qts,
+        "{'execute': 'input-send-event', 'arguments': {'events': ["
+        "{'type': 'key', 'data': {'down': true, "
+        "'key': {'type': 'qcode', 'data': 'a'}}}]}}");
+    uhci_expect_complete(&t, sizeof(report));
+    qtest_memread(t.qs->qts, t.data, report, sizeof(report));
+    g_assert_cmpmem(report, sizeof(report), expected, sizeof(expected));
+
+    qpci_iounmap(t.hc.dev, t.hc.bar);
+    uhci_deinit(&t.hc);
+    guest_free(&t.qs->alloc, t.mem);
+    qtest_shutdown(t.qs);
+}
+
 static void test_port(int port)
 {
     struct qhc uhci;
@@ -72,6 +230,9 @@ int main(int argc, char **argv)
     if (qtest_has_device("usb-storage")) {
         qtest_add_func("/uhci/pci/hotplug/usb-storage", test_usb_storage_hotplug);
     }
+    if (qtest_has_device("usb-kbd")) {
+        qtest_add_func("/uhci/pci/intr-nak", test_uhci_nak);
+    }
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         qs = qtest_pc_boot("%s", cmd);
-- 
2.43.0


