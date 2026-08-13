Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A3FC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuUba-0000WW-BZ; Thu, 13 Aug 2026 08:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wuUbZ-0000Vq-8h
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:32:17 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wuUbW-000505-TC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:32:17 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso1242068a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786624333; x=1787229133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JTf50H2KjEE9dRaDlPScRqHmYiVlaQA2BV2jrqegP6w=;
 b=dpthDddwxFC3l5bMDJbwZOMPpUHc5NS7PYQXHBFPmwCdUAXM/BimeIGA2SRP2QCsuD
 eDWkQ7jsL0W35rotJzF+5msPNRk9R518hbprESt3gx4eOGWcz7UYJzTFly3GErHMSegL
 HIpjrXS4eMuYY4bA/OO9ucJuvfBYbXXQF0GjI5c0cw9t+Qak0bq6VkDY+tQf1ioaCbch
 6i6rt0Sriqie2OuYijvQUjtv7Nci0HtLhseQ+TYCvdHYET4t3O72dADRW5QFZXo77gxS
 EtAAtvdYsroXFMN8/yE2hWJMjMLbUN/VNTXtohjzsCseLj9sVeBjLYvb7cOXabnJ7Cxi
 rrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786624333; x=1787229133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTf50H2KjEE9dRaDlPScRqHmYiVlaQA2BV2jrqegP6w=;
 b=pY3oy6vnqJfLJWGX770jYbXqDnMdbmbHKoQv2yjwVO799qw+pKI770thR1LVlvECKM
 c4jPanPmX6c/2TP0bGfhAaoDKGgwUBWKe7nsjfClSECFzq60TDw1vGCjehDCnexInC6A
 aig8AFpaH4wrb1ghL+K6GdZT09sMJLmq4KmhlfhCYr3SvZaxp1GHZilL+joVEj8AQumB
 koT1e5lIjpiLRhCiB1gthJk7C0PaAzT2WXqhGNLIkpREn5//iCCC6S09T2D+egsnQC6p
 /ZfhH9mRQRJrDQNHlWk39wv5POOh/u9Wa2Amu41KnDGSwQ7+aq1YQlBFrlFHmEe8AuMB
 jAeg==
X-Gm-Message-State: AOJu0YwV4jMFjH8TTU1tcV89Y55NIFrZf0D9Ytk1agf/NsD2/pWGG0+l
 h/k2X05VNh3xhoeEFPmi1ziHflIvLaM/lB7fGvlJ643VMAybqD1NfB3AMhLHHbup
X-Gm-Gg: AR+sD10d45T9FPYcwWCfDVWqlSSmG8tKX861jZZ5fEOWfYpDjzz05kOxPsBd72XZJbK
 uIxpCRBx9rRb+pxLml7YUdR4DYvCZCsYFWyKPv98nClWjmOGxZutP8SmLGCCA+RyG1CfDWwBcWA
 bqsQqBFivQtSgtKQNUSEfgfCgF/UlGztprrimJVWzDgudC59t7BnjrlB4q/4Q1Bzgk6jf5bA7OO
 J1IzaxxgDojEIa3vgIK1M8MLtCH+9Hw4obxWID1LiL6HDvQvVp92n2eJz8ML0jrzB5r8Sysa/W9
 ok2yedQVl+IeG+/Jkp4xbkuhzdg3v9ByjOA7o26URlfl3N65YSzvyQdHnoI4+nA7CjsI/XfgkLW
 epkT4j9lyZr08Mq+cQ65lIlKUQ1C72pibC/r2/1sIrxx19iF1C0pW4XybFfDZfzvoFbV6oPZUQ9
 SYwNUp7d45FW18XC5JA0xtkHJ7qHhLnJ0Pzef/25eG+UAsGj7TY7W7XKbLZk5zvJyDosbiVLD0t
 8SOvNSl
X-Received: by 2002:a05:6402:50cc:b0:69e:8ad:515f with SMTP id
 4fb4d7f45d1cf-6a3805c6bc3mr2171957a12.6.1786624332607; 
 Thu, 13 Aug 2026 05:32:12 -0700 (PDT)
Received: from DE-PF5B95TD.clients.cmblu.de ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f8cde03sm843270a12.27.2026.08.13.05.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:32:11 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: bmeng.cn@gmail.com,
	qemu-block@nongnu.org,
	philmd@linaro.org
Subject: [PATCH] tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer
Date: Thu, 13 Aug 2026 14:32:10 +0200
Message-ID: <20260813123210.28987-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add an image-free qtest for the microchip-icicle-kit machine that drives
the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
(hw/sd/cadence_sdhci.c, SRS window at 0x20008200) directly over MMIO
under "-accel qtest", where QEMU_CLOCK_VIRTUAL only advances when the
test steps it.

It reproduces two aspects of the ADMA2 engine objectively, without any
guest firmware:

  1. Pacing: a 12-descriptor (> SDHC_ADMA_DESCS_PER_DELAY) non-interrupt
     ADMA2 CMD18 read completes after a model-dependent number of
     SDHC_TRANSFER_DELAY virtual-clock steps, which the test reports.

  2. MMIO coupling: a chain carrying a DMA-boundary interrupt descriptor
     yields mid-chain and reschedules on the virtual clock. With the
     clock frozen, a bare interrupt-status read must not itself resume or
     complete the transfer. This asserts the behaviour intended by "Run
     ADMA independently of MMIO": it passes on the fixed model and fails
     on a model that resumes ADMA from an MMIO read.

The SD bring-up (CMD0/CMD8/ACMD41/CMD2/CMD3/CMD7/CMD16) and the ADMA2
descriptor-table layout mirror the pattern already used by the SDHCI
device model; SDHCI register offsets and ADMA attribute bits are
reproduced locally because sdhci-internal.h is not standalone-includable
from a qtest.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 MAINTAINERS                      |   1 +
 tests/qtest/cadence-sdhci-test.c | 268 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   1 +
 3 files changed, 270 insertions(+)
 create mode 100644 tests/qtest/cadence-sdhci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..12c657d000 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2277,6 +2277,7 @@ F: include/hw/sd/sd*
 F: hw/sd/core.c
 F: hw/sd/sd*
 F: hw/sd/ssi-sd.c
+F: tests/qtest/cadence-sdhci-test.c
 F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 
diff --git a/tests/qtest/cadence-sdhci-test.c b/tests/qtest/cadence-sdhci-test.c
new file mode 100644
index 0000000000..f2f06fdcaf
--- /dev/null
+++ b/tests/qtest/cadence-sdhci-test.c
@@ -0,0 +1,268 @@
+/*
+ * QTest for Cadence SDHCI ADMA2 pacing / MMIO coupling on the Microchip
+ * PolarFire SoC Icicle Kit (microchip-icicle-kit).
+ *
+ * Drives the generic SDHCI model (hw/sd/sdhci.c) through the Cadence wrapper
+ * directly over MMIO under "-accel qtest", where QEMU_CLOCK_VIRTUAL only
+ * advances when the test steps it; no guest firmware runs.
+ *
+ * Copyright (c) 2026 Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/*
+ * SDHCI register offsets and bits, mirrored from hw/sd/sdhci-internal.h,
+ * which is not standalone-includable from a qtest.
+ */
+#define SDHC_BLKSIZE               0x04
+#define SDHC_ARGUMENT              0x08
+#define SDHC_TRNMOD                0x0C
+#define SDHC_TRNS_DMA              0x0001
+#define SDHC_TRNS_BLK_CNT_EN       0x0002
+#define SDHC_TRNS_READ             0x0010
+#define SDHC_TRNS_MULTI            0x0020
+#define SDHC_CMDREG                0x0E
+#define SDHC_CMD_DATA_PRESENT      (1 << 5)
+#define SDHC_RSPREG0               0x10
+#define SDHC_PRNSTS                0x24
+#define SDHC_CARD_PRESENT          0x00010000
+#define SDHC_HOSTCTL               0x28
+#define SDHC_CTRL_ADMA2_32         0x10
+#define SDHC_CLKCON                0x2C
+#define SDHC_CLOCK_INT_EN          0x0001
+#define SDHC_CLOCK_SDCLK_EN        (1 << 2)
+#define SDHC_SWRST                 0x2F
+#define SDHC_RESET_ALL             0x01
+#define SDHC_NORINTSTS             0x30
+#define SDHC_NIS_ERR               0x8000
+#define SDHC_NIS_CMDCMP            0x0001
+#define SDHC_NIS_TRSCMP            0x0002
+#define SDHC_NIS_DMA               0x0008
+#define SDHC_NORINTSTSEN           0x34
+#define SDHC_ERRINTSTSEN           0x36
+#define SDHC_NORINTSIGEN           0x38
+#define SDHC_ADMASYSADDR           0x58
+#define SDHC_ADMA_ATTR_ACT_TRAN    (1 << 5)
+#define SDHC_ADMA_ATTR_INT         (1 << 2)
+#define SDHC_ADMA_ATTR_END         (1 << 1)
+#define SDHC_ADMA_ATTR_VALID       (1 << 0)
+#define SDHC_TRANSFER_DELAY        100      /* ns between ADMA batches */
+
+/* Cadence maps the generic SDHCI (SRS) register window at base + 0x200. */
+#define SDHCI_BASE           (0x20008000ULL + 0x200)
+
+/* Scratch in PolarFire DRAM (base 0x80000000): descriptor table + target. */
+#define ADMA_TABLE_ADDR   0x82000000ULL
+#define ADMA_BUF_ADDR     0x82100000ULL
+
+#define BLK_LEN           512
+#define NDESC             12      /* > SDHC_ADMA_DESCS_PER_DELAY (5) */
+#define INT_DESC          5       /* DMA-boundary interrupt descriptor */
+
+/* CMDREG response-type encodings (bits [1:0]). */
+#define RESP_NONE         0x0000
+#define RESP_R2           0x0001  /* 136-bit */
+#define RESP_R48          0x0002  /* 48-bit */
+#define RESP_R1B          0x0003  /* 48-bit with busy */
+
+#define ACMD41_ARG        0x40FF8000u   /* HCS + 3.3-3.6V window */
+#define CMD8_ARG          0x000001AAu   /* VHS 2.7-3.6V + check pattern */
+
+/* Issue an SD command and wait (bounded) for Command Complete. */
+static uint16_t sd_cmd(QTestState *qts, uint8_t cmd, uint32_t arg,
+                       uint16_t flags)
+{
+    uint16_t sts = 0;
+    int i;
+
+    qtest_writel(qts, SDHCI_BASE + SDHC_ARGUMENT, arg);
+    qtest_writew(qts, SDHCI_BASE + SDHC_CMDREG, ((uint16_t)cmd << 8) | flags);
+
+    for (i = 0; i < 1000; i++) {
+        sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+        if (sts & SDHC_NIS_CMDCMP) {
+            break;
+        }
+    }
+    g_assert_cmphex(sts & SDHC_NIS_CMDCMP, ==, SDHC_NIS_CMDCMP);
+
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);  /* w1c */
+    return sts;
+}
+
+/* Bring the SD card from idle to transfer state. */
+static void sd_bring_up_card(QTestState *qts)
+{
+    uint32_t rca;
+
+    g_assert_cmphex(qtest_readl(qts, SDHCI_BASE + SDHC_PRNSTS) &
+                    SDHC_CARD_PRESENT, ==, SDHC_CARD_PRESENT);
+
+    qtest_writeb(qts, SDHCI_BASE + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, SDHCI_BASE + SDHC_CLKCON,
+                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_ERRINTSTSEN, 0xffff);
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSIGEN, 0xffff);
+
+    sd_cmd(qts, 0,  0x00000000, RESP_NONE);  /* GO_IDLE_STATE */
+    sd_cmd(qts, 8,  CMD8_ARG,   RESP_R48);   /* SEND_IF_COND */
+    sd_cmd(qts, 55, 0x00000000, RESP_R48);   /* APP_CMD */
+    sd_cmd(qts, 41, ACMD41_ARG, RESP_R48);   /* SD_SEND_OP_COND */
+    sd_cmd(qts, 2,  0x00000000, RESP_R2);    /* ALL_SEND_CID */
+    sd_cmd(qts, 3,  0x00000000, RESP_R48);   /* SEND_RELATIVE_ADDR */
+
+    rca = qtest_readl(qts, SDHCI_BASE + SDHC_RSPREG0) >> 16;  /* R6 */
+
+    sd_cmd(qts, 7,  rca << 16,  RESP_R1B);   /* SELECT_CARD */
+    sd_cmd(qts, 16, BLK_LEN,    RESP_R48);   /* SET_BLOCKLEN */
+}
+
+/*
+ * Build a 32-bit ADMA2 table: per 8-byte entry word0 = (len << 16) | attr,
+ * word1 = target address.  When int_desc >= 0 that descriptor also carries
+ * the DMA-boundary interrupt attribute, so the model yields mid-chain
+ * (rescheduling on QEMU_CLOCK_VIRTUAL) instead of running to completion.
+ */
+static void build_adma_table(QTestState *qts, int int_desc)
+{
+    for (int i = 0; i < NDESC; i++) {
+        uint8_t attr = SDHC_ADMA_ATTR_VALID | SDHC_ADMA_ATTR_ACT_TRAN;
+        uint32_t addr = (uint32_t)(ADMA_BUF_ADDR + (uint64_t)i * BLK_LEN);
+
+        if (i == int_desc) {
+            attr |= SDHC_ADMA_ATTR_INT;
+        }
+        if (i == NDESC - 1) {
+            attr |= SDHC_ADMA_ATTR_END;
+        }
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8,
+                     ((uint32_t)BLK_LEN << 16) | attr);
+        qtest_writel(qts, ADMA_TABLE_ADDR + (uint64_t)i * 8 + 4, addr);
+    }
+}
+
+/* Program the ADMA2 engine, descriptor pointer and transfer geometry. */
+static void program_adma_read(QTestState *qts)
+{
+    qtest_writeb(qts, SDHCI_BASE + SDHC_HOSTCTL, SDHC_CTRL_ADMA2_32);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR, (uint32_t)ADMA_TABLE_ADDR);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ADMASYSADDR + 4,
+                 (uint32_t)(ADMA_TABLE_ADDR >> 32));
+    qtest_writel(qts, SDHCI_BASE + SDHC_BLKSIZE, BLK_LEN | (NDESC << 16));
+    qtest_writew(qts, SDHCI_BASE + SDHC_TRNMOD,
+                 SDHC_TRNS_DMA | SDHC_TRNS_BLK_CNT_EN |
+                 SDHC_TRNS_READ | SDHC_TRNS_MULTI);
+    qtest_writel(qts, SDHCI_BASE + SDHC_ARGUMENT, 0);  /* start block 0 */
+    qtest_writew(qts, SDHCI_BASE + SDHC_NORINTSTS, 0xffff);
+}
+
+/* CMD18 READ_MULTIPLE_BLOCK with data present -> kicks off ADMA. */
+static void kick_cmd18(QTestState *qts)
+{
+    qtest_writew(qts, SDHCI_BASE + SDHC_CMDREG,
+                 (18 << 8) | SDHC_CMD_DATA_PRESENT | RESP_R48);
+}
+
+/* Start a card-carrying icicle machine and bring the card to "tran". */
+static QTestState *icicle_start(char **tmp)
+{
+    int fd;
+    GError *err = NULL;
+    QTestState *qts;
+
+    fd = g_file_open_tmp("icicle-sdhci-XXXXXX.raw", tmp, &err);
+    g_assert_no_error(err);
+    g_assert_cmpint(fd, >=, 0);
+    g_assert_cmpint(ftruncate(fd, 1 * 1024 * 1024), ==, 0);
+    close(fd);
+
+    qts = qtest_initf("-machine microchip-icicle-kit -accel qtest "
+                      "-display none -drive if=sd,file=%s,format=raw", *tmp);
+    sd_bring_up_card(qts);
+    return qts;
+}
+
+/*
+ * Facet 1 -- pacing.  A non-interrupt chain completes after some number of
+ * SDHC_TRANSFER_DELAY steps (several for a batched model, none for one that
+ * runs a no-interrupt chain to completion); the count is reported, not
+ * asserted -- only a clean Transfer Complete is required.
+ */
+static void test_adma_pacing(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, -1);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <, 1000);
+    }
+
+    g_assert_cmphex(sts & SDHC_NIS_TRSCMP, ==, SDHC_NIS_TRSCMP);
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+
+    g_test_message("ADMA %d descriptors: %d clock steps to Transfer Complete",
+                   NDESC, steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+/*
+ * Facet 2 -- MMIO coupling (regression for "Run ADMA independently of MMIO").
+ * With the clock frozen, a bare interrupt-status read must not resume the
+ * transfer left pending by the mid-chain interrupt descriptor: Transfer
+ * Complete must still be clear.  A model that resumes ADMA from an MMIO read
+ * completes it on that bare read and fails the assertion.
+ */
+static void test_adma_mmio_coupling(void)
+{
+    char *tmp = NULL;
+    QTestState *qts = icicle_start(&tmp);
+    uint16_t sts;
+    int steps = 0;
+
+    build_adma_table(qts, INT_DESC);
+    program_adma_read(qts);
+    kick_cmd18(qts);
+
+    sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS);
+    g_assert_cmphex(sts & SDHC_NIS_TRSCMP, ==, 0);
+
+    while (!((sts = qtest_readw(qts, SDHCI_BASE + SDHC_NORINTSTS)) &
+             SDHC_NIS_TRSCMP)) {
+        qtest_clock_step(qts, SDHC_TRANSFER_DELAY);
+        steps++;
+        g_assert_cmpint(steps, <, 1000);
+    }
+    g_assert_cmphex(sts & SDHC_NIS_ERR, ==, 0);
+
+    g_test_message("ADMA coupling: %d clock steps to complete after bare read",
+                   steps);
+
+    qtest_quit(qts);
+    unlink(tmp);
+    g_free(tmp);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/microchip/icicle/sdhci/adma-pacing", test_adma_pacing);
+    qtest_add_func("/microchip/icicle/sdhci/adma-mmio-coupling",
+                   test_adma_mmio_coupling);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 54e2cb0461..78e47ee024 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -283,6 +283,7 @@ qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
 qtests_riscv64 = ['riscv-csr-test'] + \
+  (config_all_devices.has_key('CONFIG_MICROCHIP_PFSOC') ? ['cadence-sdhci-test'] : []) + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
 qos_test_ss = ss.source_set()
-- 
2.43.0


