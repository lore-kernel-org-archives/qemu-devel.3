Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A1C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYT-0001LL-7J; Mon, 24 Aug 2026 01:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXp-0001C1-Is
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:31 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXn-0001gj-7T
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:29 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so3128708a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550506; x=1788155306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xc57UZiR6CZv6MB1llTkA2mMlYutp4bmWHzJ3XCAcac=;
 b=XQGj745ebiCgz3U8ddMm6VNWVJx0Ag38kIcPrKOL7r141P5dyRlD3kYUL6X9aWacQC
 Wen/96jDUFQLJDlBtogSGL3saoOREvUNgAUmyFDlpUNri8XBha3ebwJobzLC+V0cNL2j
 cKP9j1TxsYgwwtj098PvEbd5kc2MKiL8fDLlE4Vnax9vwz2y2V/ZeTTqduZFqmu87q+C
 6UFZVHzasOcEN9h5aZK3MMVi66ABUkUNFbVcAaFs5W19BHBsmntD6DdwFdFmXyDTTa8E
 1pCUNTcLP9Er7xAUoonp7lxqRp/SmCK98BkrqnRR5s/Ck8OdgIZ/dkbrcYIVJeNze/pN
 Fgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550506; x=1788155306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xc57UZiR6CZv6MB1llTkA2mMlYutp4bmWHzJ3XCAcac=;
 b=bNQrA7exHj3VLwKOyzUu1p5VAZsu2r8yyuSEPSr4keZw5IH3R/Pd9j7Hl70BVlAWhU
 p8GcVxxvoulVrSqwohK2jqw5Ro0FAzJ/OyIKyECZzvuSNewqRFkutl5JL7JoJjwuFgLH
 XuqAeCqjj5dkmgRiyOKRk5NEil2ijZpBglUmc5QnmAT6TC0VygwSw+TDemwGQf6P8LJM
 CCiDobJEs3fRozq0vTGC+ONhrD3ko7/ybd43uvEu8XK79IWChks4LENuFwcsj4PZmGXi
 j5nvv3dSRlMtl482TxMrC2DwhsrNoMkL2WiIzvriN2BDWyxCDMbXOdp9LLnxPGlVcMp5
 v3vg==
X-Gm-Message-State: AFuF++m2v5+O9fTPS3MOOjKAt3+Br9Ff25+w44PlOj9NemPP2Q+2cVbo
 JyhqI+Ztx/uvzLcTCPcY72xx4T7/RvH9XXEUYDwK9b6IndE5rP8rkBFBfO8EKA==
X-Gm-Gg: AR+sD11ZFQjVHxfVqZyU1fUZGVl1FYWULdh51d4RYgrCjHmL0fbb/P3jyBPOv4uCH3M
 bJz6oCgLpBXJoRmQNZGEnMW33yQ3uQPQSZb/9qa02Jca8is7yyc5uwyQZXvb0zpawOehTEYkfhv
 18Fxs0HtBrUHO1QgvzUzCzbyW40EdGOhu4H3jWvoJtu2QEnbVD+gOMsixE5QqjYI6+xBLB7gE7O
 7dRq9fvD5IAx/1BT0dG/SSPj18CfKBwElv5eD39ssyPI6bq6Fajo61JdWkccxAOpkOwx6DaOvuP
 D7ylHJg43OGdHrDALem7p9U1mvwhoq8A5zV9Ghqm5OQ7juEv/OUXHaeWijH96s6wbdQL8F6uC5k
 pRRifCnbOzNX3iuAOpmQOVc+NIeRzy+8YICc6Gt/2Oy6SHIj3XmMfbBHwCmd4mH67mYq3pf8kCQ
 deH7b1be/U1jCOxQXXQrNo5xAxwUrIZz8hFq9yN9xPH4Afe2d39dXzwSFDo5hgw/ztV/d7zHmIw
 gfdyw==
X-Received: by 2002:a17:90b:560d:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-395deea6acbmr31153692a91.5.1787550505671; 
 Sun, 23 Aug 2026 22:48:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Junze Cao <caojunze424@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 03/96] tests/qtest: Add K230 DDR controller tests
Date: Mon, 24 Aug 2026 15:46:33 +1000
Message-ID: <20260824054806.2790041-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Junze Cao <caojunze424@gmail.com>

Add qtests for DDRC and PHY reset values, register access policy, the
software-update handshake, and PHY register ownership.

Exercise PHY training and mailbox acknowledgement through the DFI
initialization sequence. Include negative coverage to ensure DFI cannot
complete before PHY training or enter Normal mode before completion is
enabled.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Junze Cao <caojunze424@gmail.com>
Message-ID: <20260807-k230-ddr-v2-v2-3-c531308ae819@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-ddr-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0879c868..2190bc706b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1851,6 +1851,7 @@ F: include/hw/misc/k230_ddr.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: tests/functional/riscv64/test_k230.py
+F: tests/qtest/k230-ddr-test.c
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/tests/qtest/k230-ddr-test.c b/tests/qtest/k230-ddr-test.c
new file mode 100644
index 0000000000..72362929bc
--- /dev/null
+++ b/tests/qtest/k230-ddr-test.c
@@ -0,0 +1,226 @@
+/*
+ * QTest testcase for the K230 DDR controller and PHY
+ *
+ * Exercises register access, reset, PHY ownership, training mailbox, and DFI
+ * initialization.
+ *
+ * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define K230_DDRC_BASE    UINT64_C(0x98000000)
+#define K230_DDR_PHY_BASE UINT64_C(0x9a000000)
+
+#define K230_DDRC_MSTR    0x000
+#define K230_DDRC_STAT    0x004
+#define K230_DDRC_DRAMTMG4 0x110
+#define K230_DDRC_DFIMISC 0x1b0
+#define K230_DDRC_DFISTAT 0x1bc
+#define K230_DDRC_SWCTL   0x320
+#define K230_DDRC_SWSTAT  0x324
+
+#define K230_DDRC_STAT_OPERATING_MODE_MASK          0x7
+#define K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK    0x1
+
+#define K230_DDR_PHY_CSR(index) \
+    (K230_DDR_PHY_BASE + (uint64_t)(index) * sizeof(uint32_t))
+
+#define K230_DDR_PHY_ATX_IMPEDANCE      0x00043
+#define K230_DDR_PHY_TX_IMPEDANCE_CTRL1 0x10049
+#define K230_DDR_PHY_VREF_IN_GLOBAL     0x200b2
+#define K230_DDR_PHY_MICRO_CONT_MUX_SEL 0xd0000
+#define K230_DDR_PHY_TRAINING_STATUS    0xd0004
+#define K230_DDR_PHY_TRAINING_ACK       0xd0031
+#define K230_DDR_PHY_TRAINING_MESSAGE   0xd0032
+#define K230_DDR_PHY_TRAINING_TRIGGER   0xd0099
+
+static void complete_phy_training(QTestState *qts)
+{
+    qtest_writel(qts,
+                 K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL), 1);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 9);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 1);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 0);
+}
+
+static void test_reset_and_register_access(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
+                    ==, 0x01040000);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
+                    ==, 0x00000000);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
+                    ==, 0x05040405);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC),
+                    ==, 0x00000001);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWCTL),
+                    ==, 0x00000001);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 0x00000001);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE)),
+                    ==, 0x03ff);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TX_IMPEDANCE_CTRL1)),
+                    ==, 0x0fff);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
+                    ==, 0x0200);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_MSTR, 0x01040008);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
+                    ==, 0x01040008);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_STAT, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
+                    ==, 0x00000000);
+
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL),
+                 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
+                    ==, 0x7fff);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4, 0);
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
+                    ==, 0x01040000);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
+                    ==, 0x05040405);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
+                    ==, 0x0200);
+
+    qtest_quit(qts);
+}
+
+static void test_software_update_handshake(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 0);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 1);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 1);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
+                    ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_phy_ownership(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint64_t atx = K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE);
+    uint64_t mux = K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL);
+
+    qtest_writel(qts, atx, 0x155);
+    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
+
+    qtest_writel(qts, mux, 1);
+    qtest_writel(qts, atx, 0x2aa);
+    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
+
+    qtest_writel(qts, mux, 0);
+    qtest_writel(qts, atx, 0x2aa);
+    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x2aa);
+
+    qtest_quit(qts);
+}
+
+static void test_dfi_prerequisites(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
+                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
+                    K230_DDRC_STAT_OPERATING_MODE_MASK,
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_dfi_complete_enable(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    complete_phy_training(qts);
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
+                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
+                    K230_DDRC_STAT_OPERATING_MODE_MASK,
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_training_and_dfi_handshake(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    complete_phy_training(qts);
+
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_MESSAGE)),
+                    ==, 0x07);
+
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 0);
+    g_assert_cmphex(qtest_readl(qts,
+                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
+                    ==, 1);
+    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 1);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFISTAT),
+                    ==, 1);
+
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0);
+    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 1);
+    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) & 0x7,
+                    ==, 1);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-ddr/reset-and-register-access",
+                   test_reset_and_register_access);
+    qtest_add_func("/k230-ddr/software-update-handshake",
+                   test_software_update_handshake);
+    qtest_add_func("/k230-ddr/phy-ownership", test_phy_ownership);
+    qtest_add_func("/k230-ddr/dfi-prerequisites", test_dfi_prerequisites);
+    qtest_add_func("/k230-ddr/dfi-complete-enable",
+                   test_dfi_complete_enable);
+    qtest_add_func("/k230-ddr/training-and-dfi-handshake",
+                   test_training_and_dfi_handshake);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 12ed368997..663a66bded 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -299,7 +299,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ?
+   ['k230-ddr-test', 'k230-wdt-test'] : [])
 
 qtests_hexagon = ['boot-serial-test', 'l2vic-test', 'qct-qtimer-test']
 
-- 
2.54.0


