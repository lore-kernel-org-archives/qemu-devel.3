Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2618C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjKA-0003l0-Fx; Sun, 27 Sep 2026 03:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIH-0000LS-NC; Sun, 27 Sep 2026 03:27:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjIF-0005Xd-Ff; Sun, 27 Sep 2026 03:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494013; bh=WT2bpGMtaRi3hozzh2O1oKM9th1XtT2iMg0ZMo70HDs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IJA7vMqM0B4q/VsZugQV/WRgSzVchmqrl4WMVvKM1ZtmyYspBUx3Qin7NUi6gpZ9E
 NyJo9icoHKwrIZGzrfaSON0okECQYKvSEsgK2aOcKVb8Dw1AWGyE0SMHpJBEDyogRD
 yIHtGUj0a/g85sOf2Aq9fN3H7gXmZ0f2NLMmkOfWrI91eBKnvQk9aaPqWsUBEMepeM
 mKDWd31kmTDVkTy7TbPbEgXDYD/Om0s6UmUCZtWZHcamnlBJZYQyoNvaKqNmbDCpeO
 aV1fDdycXtmR+xUm68JwzDETHzDG/6dSAtQ2sBLy+6y+XeFfmzh/eVuJ0QSNLWRmmi
 MtSRh6yBa0Hmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D5F881D8AC1;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BFB1C432053;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F412E5E631; Sun, 27 Sep 2026 10:26:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 63/72] tests/qtest/usb-hcd-xhci: test isoch pacing
 with MFINDEX above 2^32
Date: Sun, 27 Sep 2026 10:25:55 +0300
Message-ID: <20260927072622.93656-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Junjie Cao <junjie.cao@intel.com>

Add the minimum needed to drive a transfer ring from the test. Use it to
queue an isoch TD with SIA on usb-audio after stepping the clock past
2^32 microframes, and check that the TD waits for the next interval
boundary. Before the ROUND_UP() change it completed as soon as the
doorbell was rung.

The machine is started with pit=off. With the i8254 present the clock
step takes 26s in an ASan build instead of well under a second.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <eb57b4b9bd78f08d248fa1ae7ed5d2d5958c9ef4.1789968699.git.junjie.cao@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 3c770d72925eb06c1478612233e103e3de9b311f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index b58fa1e2dae..61eca37b157 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -10,8 +10,68 @@
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
 #include "libqos/usb.h"
+#include "libqos/malloc-pc.h"
 #include "qobject/qdict.h"
 
+/* capability registers */
+#define XHCI_CAPLENGTH          0x00
+#define XHCI_HCSPARAMS1         0x04
+#define XHCI_DBOFF              0x14
+#define XHCI_RTSOFF             0x18
+/* operational registers */
+#define XHCI_USBCMD             0x00
+#define XHCI_USBSTS             0x04
+#define XHCI_CRCR               0x18
+#define XHCI_DCBAAP             0x30
+#define XHCI_CONFIG             0x38
+#define XHCI_PORTSC(n)          (0x400 + 0x10 * (n))
+/* interrupter 0, relative to the runtime registers */
+#define XHCI_ERSTSZ             0x28
+#define XHCI_ERSTBA             0x30
+#define XHCI_ERDP               0x38
+
+#define USBCMD_RS               (1 << 0)
+#define USBCMD_HCRST            (1 << 1)
+#define USBSTS_HCH              (1 << 0)
+#define PORTSC_CCS              (1 << 0)
+#define PORTSC_PR               (1 << 4)
+#define PORTSC_PP               (1 << 9)
+#define CRCR_RCS                (1 << 0)
+#define ERDP_EHB                (1 << 3)
+
+#define TRB_C                   (1 << 0)
+#define TRB_TR_IOC              (1 << 5)
+#define TRB_TR_SIA              (1U << 31)
+#define TRB_TYPE(t)             ((t) << 10)
+#define TRB_GET_TYPE(control)   (((control) >> 10) & 0x3f)
+#define TRB_GET_CCODE(status)   ((status) >> 24)
+#define TRB_GET_SLOT(control)   ((control) >> 24)
+
+#define TR_ISOCH                5
+#define CR_ENABLE_SLOT          9
+#define CR_ADDRESS_DEVICE       11
+#define CR_CONFIGURE_ENDPOINT   12
+#define ER_TRANSFER             32
+#define ER_COMMAND_COMPLETE     33
+#define CC_SUCCESS              1
+
+#define EP_TYPE_ISOCH_OUT       1
+#define EP_TYPE_CONTROL         4
+
+#define XHCI_RING_TRBS          64
+#define XHCI_MICROFRAME_NS      125000
+
+typedef struct XHCITest {
+    QTestState *qts;
+    QGuestAllocator alloc;
+    QPCIBus *bus;
+    struct qhc hc;
+    uint32_t oper, runtime, doorbell;
+    uint64_t cmd_ring, event_ring, input_ctx;
+    unsigned int cmd_idx, event_idx;
+    unsigned int port, slot;
+} XHCITest;
+
 static void wait_device_deleted_event(QTestState *qtest, const char *id)
 {
     QDict *resp, *data;
@@ -109,6 +169,227 @@ static void test_usb_ccid_hotplug(void)
     qtest_qmp_device_del(qts, "ccid");
 }
 
+static uint32_t xhci_readl(XHCITest *x, uint32_t off)
+{
+    return qpci_io_readl(x->hc.dev, x->hc.bar, off);
+}
+
+static void xhci_writel(XHCITest *x, uint32_t off, uint32_t val)
+{
+    qpci_io_writel(x->hc.dev, x->hc.bar, off, val);
+}
+
+static void xhci_writeq(XHCITest *x, uint32_t off, uint64_t val)
+{
+    xhci_writel(x, off, val);
+    xhci_writel(x, off + 4, val >> 32);
+}
+
+static uint64_t xhci_alloc_page(XHCITest *x)
+{
+    uint64_t addr = guest_alloc(&x->alloc, 0x1000);
+
+    qtest_memset(x->qts, addr, 0, 0x1000);
+    return addr;
+}
+
+static void xhci_write_trb(XHCITest *x, uint64_t addr, uint64_t parameter,
+                           uint32_t status, uint32_t control)
+{
+    qtest_writeq(x->qts, addr, parameter);
+    qtest_writel(x->qts, addr + 8, status);
+    qtest_writel(x->qts, addr + 12, control);
+}
+
+/* Fetch the next event if there is one. Does not advance the clock. */
+static bool xhci_next_event(XHCITest *x, uint32_t *status, uint32_t *control)
+{
+    uint64_t addr = x->event_ring + 16 * x->event_idx;
+    uint32_t c = qtest_readl(x->qts, addr + 12);
+
+    if (!(c & TRB_C)) {
+        return false;
+    }
+    if (status) {
+        *status = qtest_readl(x->qts, addr + 8);
+    }
+    if (control) {
+        *control = c;
+    }
+    x->event_idx++;
+    g_assert_cmpuint(x->event_idx, <, XHCI_RING_TRBS);
+    xhci_writeq(x, x->runtime + XHCI_ERDP, (addr + 16) | ERDP_EHB);
+    return true;
+}
+
+static unsigned int xhci_command(XHCITest *x, uint64_t parameter,
+                                 uint32_t control)
+{
+    uint32_t status;
+
+    g_assert_cmpuint(x->cmd_idx, <, XHCI_RING_TRBS);
+    xhci_write_trb(x, x->cmd_ring + 16 * x->cmd_idx++, parameter, 0,
+                   control | TRB_C);
+    xhci_writel(x, x->doorbell, 0);
+
+    g_assert_true(xhci_next_event(x, &status, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_COMMAND_COMPLETE);
+    g_assert_cmpuint(TRB_GET_CCODE(status), ==, CC_SUCCESS);
+    return TRB_GET_SLOT(control);
+}
+
+/*
+ * Start qemu-xhci with one USB device, run the controller and bring the
+ * device to the Addressed state.
+ */
+static void xhci_test_start(XHCITest *x, const char *usb_device)
+{
+    uint64_t dcbaa, erst, ep0_ring;
+    unsigned int maxports;
+
+    memset(x, 0, sizeof(*x));
+    /* pit=off: a long clock step would run the i8254 timer all the way */
+    x->qts = qtest_initf("-machine pc,pit=off -nodefaults "
+                         "-device qemu-xhci,id=xhci,addr=04.0 %s", usb_device);
+    pc_alloc_init(&x->alloc, x->qts, ALLOC_NO_FLAGS);
+    x->bus = qpci_new_pc(x->qts, NULL);
+    qusb_pci_init_one(x->bus, &x->hc, QPCI_DEVFN(4, 0), 0);
+
+    x->oper = qpci_io_readb(x->hc.dev, x->hc.bar, XHCI_CAPLENGTH);
+    x->runtime = xhci_readl(x, XHCI_RTSOFF) & ~0x1f;
+    x->doorbell = xhci_readl(x, XHCI_DBOFF) & ~0x3;
+    maxports = xhci_readl(x, XHCI_HCSPARAMS1) >> 24;
+
+    xhci_writel(x, x->oper + XHCI_USBCMD, USBCMD_HCRST);
+    g_assert_false(xhci_readl(x, x->oper + XHCI_USBCMD) & USBCMD_HCRST);
+
+    dcbaa = xhci_alloc_page(x);
+    erst = xhci_alloc_page(x);
+    x->cmd_ring = xhci_alloc_page(x);
+    x->event_ring = xhci_alloc_page(x);
+    x->input_ctx = xhci_alloc_page(x);
+
+    xhci_writel(x, x->oper + XHCI_CONFIG, 1);
+    xhci_writeq(x, x->oper + XHCI_DCBAAP, dcbaa);
+    qtest_writeq(x->qts, erst, x->event_ring);
+    qtest_writel(x->qts, erst + 8, XHCI_RING_TRBS);
+    xhci_writel(x, x->runtime + XHCI_ERSTSZ, 1);
+    xhci_writeq(x, x->runtime + XHCI_ERSTBA, erst);
+    xhci_writeq(x, x->runtime + XHCI_ERDP, x->event_ring | ERDP_EHB);
+    xhci_writeq(x, x->oper + XHCI_CRCR, x->cmd_ring | CRCR_RCS);
+    xhci_writel(x, x->oper + XHCI_USBCMD, USBCMD_RS);
+    g_assert_false(xhci_readl(x, x->oper + XHCI_USBSTS) & USBSTS_HCH);
+
+    for (x->port = 0; x->port < maxports; x->port++) {
+        if (xhci_readl(x, x->oper + XHCI_PORTSC(x->port)) & PORTSC_CCS) {
+            break;
+        }
+    }
+    g_assert_cmpuint(x->port, <, maxports);
+    xhci_writel(x, x->oper + XHCI_PORTSC(x->port), PORTSC_PP | PORTSC_PR);
+    while (xhci_next_event(x, NULL, NULL)) {
+        /* drop the port status change events */
+    }
+
+    x->slot = xhci_command(x, 0, TRB_TYPE(CR_ENABLE_SLOT));
+    qtest_writeq(x->qts, dcbaa + 8 * x->slot, xhci_alloc_page(x));
+
+    /* input control context: add slot and ep0 */
+    qtest_writel(x->qts, x->input_ctx + 0x04, 0x3);
+    /* slot context: one context entry, root hub port */
+    qtest_writel(x->qts, x->input_ctx + 0x20, 1 << 27);
+    qtest_writel(x->qts, x->input_ctx + 0x24, (x->port + 1) << 16);
+    /* ep0 context */
+    ep0_ring = xhci_alloc_page(x);
+    qtest_writel(x->qts, x->input_ctx + 0x44,
+                 (64 << 16) | (EP_TYPE_CONTROL << 3));
+    qtest_writeq(x->qts, x->input_ctx + 0x48, ep0_ring | 1);
+    xhci_command(x, x->input_ctx,
+                 TRB_TYPE(CR_ADDRESS_DEVICE) | (x->slot << 24));
+}
+
+/* Returns the address of the transfer ring. */
+static uint64_t xhci_configure_ep(XHCITest *x, unsigned int epid,
+                                  unsigned int type, unsigned int interval,
+                                  unsigned int max_packet)
+{
+    uint64_t ring = xhci_alloc_page(x);
+    uint64_t epctx = x->input_ctx + 0x20 * (epid + 1);
+
+    qtest_memset(x->qts, x->input_ctx, 0, 0x1000);
+    qtest_writel(x->qts, x->input_ctx + 0x04, (1 << epid) | 1);
+    qtest_writel(x->qts, x->input_ctx + 0x20, epid << 27);
+    qtest_writel(x->qts, x->input_ctx + 0x24, (x->port + 1) << 16);
+    qtest_writel(x->qts, epctx + 0x00, interval << 16);
+    qtest_writel(x->qts, epctx + 0x04, (max_packet << 16) | (type << 3));
+    qtest_writeq(x->qts, epctx + 0x08, ring | 1);
+    xhci_command(x, x->input_ctx,
+                 TRB_TYPE(CR_CONFIGURE_ENDPOINT) | (x->slot << 24));
+    return ring;
+}
+
+static void xhci_test_end(XHCITest *x)
+{
+    g_free(x->hc.dev);
+    qpci_free_pc(x->bus);
+    alloc_destroy(&x->alloc);
+    qtest_quit(x->qts);
+}
+
+static bool xhci_test_supported(const char *usb_device)
+{
+    const char *arch = qtest_get_arch();
+
+    if (strcmp(arch, "i386") != 0 && strcmp(arch, "x86_64") != 0) {
+        g_test_skip("Test only runs on x86 (pc machine)");
+        return false;
+    }
+    if (!qtest_has_device("qemu-xhci") || !qtest_has_device(usb_device)) {
+        g_test_skip("Devices not available");
+        return false;
+    }
+    return true;
+}
+
+/*
+ * An isoch TD with SIA set is run at the next interval boundary. That has to
+ * hold once the microframe index no longer fits in 32 bits as well.
+ */
+static void test_xhci_isoch_mfindex_32bit(void)
+{
+    const unsigned int interval = 6;
+    uint32_t control;
+    uint64_t ring;
+    XHCITest x;
+
+    if (!xhci_test_supported("usb-audio")) {
+        return;
+    }
+
+    xhci_test_start(&x, "-audiodev none,id=snd0 "
+                        "-device usb-audio,audiodev=snd0");
+    ring = xhci_configure_ep(&x, 2, EP_TYPE_ISOCH_OUT, interval, 64);
+
+    /* Go past 2^32 microframes and stop off an interval boundary. */
+    qtest_clock_step(x.qts, (1ULL << 32) * XHCI_MICROFRAME_NS);
+    qtest_clock_step(x.qts, 5 * XHCI_MICROFRAME_NS);
+
+    xhci_write_trb(&x, ring, xhci_alloc_page(&x), 64,
+                   TRB_TYPE(TR_ISOCH) | TRB_TR_SIA | TRB_TR_IOC | TRB_C);
+    xhci_writel(&x, x.doorbell + 4 * x.slot, 2);
+    g_assert_false(xhci_next_event(&x, NULL, NULL));
+
+    /*
+     * The streaming interface has not been enabled, so usb-audio stalls the
+     * TD. What matters is when that happens.
+     */
+    qtest_clock_step(x.qts, XHCI_MICROFRAME_NS << interval);
+    g_assert_true(xhci_next_event(&x, NULL, &control));
+    g_assert_cmpuint(TRB_GET_TYPE(control), ==, ER_TRANSFER);
+
+    xhci_test_end(&x);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -123,6 +404,8 @@ int main(int argc, char **argv)
     if (qtest_has_device("usb-ccid")) {
         qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
     }
+    qtest_add_func("/xhci/pci/isoch/mfindex-32bit",
+                   test_xhci_isoch_mfindex_32bit);
 
     qtest_start("-device nec-usb-xhci,id=xhci"
                 " -drive id=drive0,if=none,file=null-co://,"
-- 
2.47.3


