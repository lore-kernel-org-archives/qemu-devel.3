Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B78C79F9E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3InQ-0002I3-5d; Sun, 06 Sep 2026 15:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InO-0002HH-To; Sun, 06 Sep 2026 15:44:54 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InM-0006xW-Ug; Sun, 06 Sep 2026 15:44:54 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdLJ90G1Mz7vjs;
 Sun,  6 Sep 2026 21:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723881;
 bh=dCCd+ACp9P2lYS6q7+kAnohBplRue+32oVYGSJCn/yI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GdkQY8Els3K4hU0q0/UuJQJQF/HBCRufkIxzcFVFPN8xHp/efVzPCub19Uyzc4Lu5
 jNxdXvQAqzlAwjVgGOy5ZM72rycL2FNdj+J8TOUiR9iBdKH4hemYhXFL4qRQfRuUx7
 kyzXECiO7YPncz+9kF1C5jSOfSV+y26CiQIaygCww0QLNhKserk2O3lSvK8GY0Rv0I
 EqctmPv2SLgiBdvFhSKZxnPNbZlWWk9p9TBDwIhQgJUi8/DBuE5adLNAs4Lu+pNN9h
 Yg3jgwCGhU66hZdEL5Ipd2VJCpRLxQLdI6QGcehtQHokF/ToNcZ+pfepTF+M5vrQgn
 v6KI3w0g6EEyQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJ84rZtz7wHs;
 Sun,  6 Sep 2026 21:44:40 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 04/36] hw/char/pl011: expose DMA request outputs
Date: Sun,  6 Sep 2026 21:44:03 +0200
Message-ID: <20260906194438.93046-5-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Expose named TX and RX DMA request GPIO outputs from the PL011 model.
Update them when UARTDMACR or FIFO state changes so SoC DMA controllers can
consume PL011 pacing without device-specific callbacks.

Add a qtest covering TX and RX request assertion and deassertion.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 MAINTAINERS              |   1 +
 hw/char/pl011.c          |  32 ++++++++++--
 include/hw/char/pl011.h  |   2 +
 tests/qtest/meson.build  |   2 +
 tests/qtest/pl011-test.c | 106 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 4 deletions(-)
 create mode 100644 tests/qtest/pl011-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6a..15c9b8bf2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -764,6 +764,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/char/pl011.c
 F: include/hw/char/pl011.h
+F: tests/qtest/pl011-test.c
 F: hw/display/pl110*
 F: hw/dma/pl080.c
 F: include/hw/dma/pl080.h
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 5ad9e7358d..7e982e54bb 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -80,6 +80,11 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_FEN     (1 << 4)
 #define LCR_BRK     (1 << 0)
 
+/* DMA Control Register, UARTDMACR */
+#define DMACR_RXDMAE    (1 << 0)
+#define DMACR_TXDMAE    (1 << 1)
+#define DMACR_DMAONERR  (1 << 2)
+
 /* Control Register, UARTCR */
 #define CR_OUT2     (1 << 13)
 #define CR_OUT1     (1 << 12)
@@ -157,6 +162,17 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
     return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
 }
 
+static void pl011_update_dreq(PL011State *s)
+{
+    qemu_set_irq(s->dreq_tx,
+                 (s->cr & CR_UARTEN) &&
+                 (s->dmacr & DMACR_TXDMAE) &&
+                 !(s->flags & PL011_FLAG_TXFF));
+    qemu_set_irq(s->dreq_rx,
+                 (s->cr & CR_UARTEN) &&
+                 (s->dmacr & DMACR_RXDMAE) && s->read_count > 0);
+}
+
 static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
@@ -190,6 +206,7 @@ static void pl011_fifo_rx_put(void *opaque, uint32_t value)
         trace_pl011_fifo_rx_full();
         s->flags |= PL011_FLAG_RXFF;
     }
+    pl011_update_dreq(s);
     if (s->read_count == s->read_trigger) {
         s->int_level |= INT_RX;
         pl011_update(s);
@@ -258,6 +275,7 @@ static void pl011_write_txdata(PL011State *s, uint8_t data)
     pl011_loopback_tx(s, data);
     s->int_level |= INT_TX;
     pl011_update(s);
+    pl011_update_dreq(s);
 }
 
 static uint32_t pl011_read_rxdata(PL011State *s)
@@ -280,6 +298,7 @@ static uint32_t pl011_read_rxdata(PL011State *s)
     trace_pl011_read_fifo(s->read_count, fifo_depth);
     s->rsr = c >> 8;
     pl011_update(s);
+    pl011_update_dreq(s);
     qemu_chr_fe_accept_input(&s->chr);
     return c;
 }
@@ -473,6 +492,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         }
         s->lcr = value;
         pl011_set_read_trigger(s);
+        pl011_update_dreq(s);
         break;
     case 12: /* UARTCR */
         /* ??? Need to implement the enable bit.  */
@@ -482,6 +502,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         }
         s->cr = value;
         pl011_loopback_mdmctrl(s);
+        pl011_update_dreq(s);
         break;
     case 13: /* UARTIFS */
         s->ifl = value;
@@ -496,10 +517,8 @@ static void pl011_write(void *opaque, hwaddr offset,
         pl011_update(s);
         break;
     case 18: /* UARTDMACR */
-        s->dmacr = value;
-        if (value & 3) {
-            qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-        }
+        s->dmacr = value & (DMACR_RXDMAE | DMACR_TXDMAE | DMACR_DMAONERR);
+        pl011_update_dreq(s);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -607,6 +626,8 @@ static int pl011_post_load(void *opaque, int version_id)
 
     s->ibrd &= IBRD_MASK;
     s->fbrd &= FBRD_MASK;
+    s->dmacr &= DMACR_RXDMAE | DMACR_TXDMAE | DMACR_DMAONERR;
+    pl011_update_dreq(s);
 
     return 0;
 }
@@ -657,6 +678,8 @@ static void pl011_init(Object *obj)
     for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dreq_tx, "dreq-tx", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->dreq_rx, "dreq-rx", 1);
 
     s->clk = qdev_init_clock_in(DEVICE(obj), "clk", pl011_clock_update, s,
                                 ClockUpdate);
@@ -708,6 +731,7 @@ static void pl011_reset(DeviceState *dev)
     s->logged_disabled_uart = false;
     pl011_reset_rx_fifo(s);
     pl011_reset_tx_fifo(s);
+    pl011_update_dreq(s);
 }
 
 static void pl011_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 5695787650..c7b5a3a2b3 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -49,6 +49,8 @@ struct PL011State {
     int read_trigger;
     CharFrontend chr;
     qemu_irq irq[6];
+    qemu_irq dreq_tx;
+    qemu_irq dreq_rx;
     Clock *clk;
     bool migrate_clk;
     bool logged_disabled_uart;
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 17870e339b..bf563cdc6a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -248,6 +248,8 @@ qtests_stm32l4x5 = \
    'stm32l4x5_usart-test']
 
 qtests_arm = \
+  (config_all_devices.has_key('CONFIG_ARM_VIRT') and
+   config_all_devices.has_key('CONFIG_PL011_C') ? ['pl011-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
diff --git a/tests/qtest/pl011-test.c b/tests/qtest/pl011-test.c
new file mode 100644
index 0000000000..abc2dcfd97
--- /dev/null
+++ b/tests/qtest/pl011-test.c
@@ -0,0 +1,106 @@
+/*
+ * QTest testcase for the Arm PL011 UART DMA request outputs.
+ *
+ * Copyright (c) 2026 Gilles Grimaud
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "libqtest.h"
+
+#define PL011_BASE          0x09000000
+#define PL011_DR            0x000
+#define PL011_CR            0x030
+#define PL011_DMACR         0x048
+
+#define CR_RXE              (1 << 9)
+#define CR_TXE              (1 << 8)
+#define CR_LBE              (1 << 7)
+#define CR_UARTEN           (1 << 0)
+
+#define DMACR_RXDMAE        (1 << 0)
+#define DMACR_TXDMAE        (1 << 1)
+
+static char *find_pl011_path(QTestState *qts)
+{
+    g_autoptr(QDict) response = NULL;
+    QListEntry *entry;
+    QList *children;
+
+    response = qtest_qmp(qts,
+                         "{ 'execute': 'qom-list',"
+                         "  'arguments': { 'path': '/machine/unattached' } }");
+    children = qdict_get_qlist(response, "return");
+
+    QLIST_FOREACH_ENTRY(children, entry) {
+        QDict *child = qobject_to(QDict, qlist_entry_obj(entry));
+
+        if (g_str_equal(qdict_get_str(child, "type"), "child<pl011>")) {
+            return g_strdup_printf("/machine/unattached/%s",
+                                   qdict_get_str(child, "name"));
+        }
+    }
+
+    g_assert_not_reached();
+}
+
+static void test_tx_dreq(void)
+{
+    QTestState *qts = qtest_init("-M virt");
+    g_autofree char *path = find_pl011_path(qts);
+
+    qtest_irq_intercept_out_named(qts, path, "dreq-tx");
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, PL011_BASE + PL011_CR, CR_UARTEN);
+    qtest_writel(qts, PL011_BASE + PL011_DMACR, DMACR_TXDMAE);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(qtest_readl(qts, PL011_BASE + PL011_DMACR), ==,
+                    DMACR_TXDMAE);
+
+    qtest_writel(qts, PL011_BASE + PL011_CR, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_writel(qts, PL011_BASE + PL011_CR, CR_UARTEN);
+    g_assert_true(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, PL011_BASE + PL011_DMACR, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+}
+
+static void test_rx_dreq(void)
+{
+    QTestState *qts = qtest_init("-M virt");
+    g_autofree char *path = find_pl011_path(qts);
+
+    qtest_irq_intercept_out_named(qts, path, "dreq-rx");
+    qtest_writel(qts, PL011_BASE + PL011_CR,
+                 CR_RXE | CR_TXE | CR_LBE | CR_UARTEN);
+    qtest_writel(qts, PL011_BASE + PL011_DMACR, DMACR_RXDMAE);
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_writel(qts, PL011_BASE + PL011_DR, 'x');
+    g_assert_true(qtest_get_irq(qts, 0));
+    qtest_writel(qts, PL011_BASE + PL011_CR, 0);
+    g_assert_false(qtest_get_irq(qts, 0));
+    qtest_writel(qts, PL011_BASE + PL011_CR,
+                 CR_RXE | CR_TXE | CR_LBE | CR_UARTEN);
+    g_assert_true(qtest_get_irq(qts, 0));
+    g_assert_cmphex(qtest_readl(qts, PL011_BASE + PL011_DR), ==, 'x');
+    g_assert_false(qtest_get_irq(qts, 0));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/pl011/dreq/tx", test_tx_dreq);
+    qtest_add_func("/pl011/dreq/rx", test_rx_dreq);
+
+    return g_test_run();
+}
-- 
2.55.0


