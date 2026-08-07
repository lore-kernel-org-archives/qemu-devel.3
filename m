Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51763C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNd0-0001ab-01; Fri, 07 Aug 2026 12:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVc-0004Uw-Nk
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:29:20 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzy15515798875@gmail.com>)
 id 1wsMVZ-0007Pi-UX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:29:20 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so52485765ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786116557; x=1786721357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5/aZDuUgTzjvt17wtPEDLBGnusydhUp0vEqnbq27FU=;
 b=kyGyb976FOYZ7xK2n1sztEKGlNctZtXbrL8UdJNJA+maf7okpZizVBMrmeuwDEvuk/
 CvjdHE0S/gqkJ39aLGZQhj3TXtnGTaP70Kh9t7K6+rVIBNND/nvTrmJq3FHn8gCOT/Ml
 tBcZppiyjKKG6ysUnmnchKxsAERHCsfwW7lZ7A9fokqITE1/lUzjHIvoivkhG8ln83Y/
 HmzeWche1gcZhwx8N3LBkjSj/BWGzIUgy8qSm6y9lqlaV4h3fTYLsbKVYEt++CysiDb5
 ZbxT4DOKJv2xXSHknC5v+DJ5QOQohRoqKdHC2hdvO9cFUPhcLtFQGGPPRnIYUUxGKobJ
 f7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116557; x=1786721357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g5/aZDuUgTzjvt17wtPEDLBGnusydhUp0vEqnbq27FU=;
 b=HcH+La7kANMp8/SW2/sSRFCjjG7zZ+aR+/iKm1529IPRY/7Pw7Tp8Xd2O8GWWzp2+3
 UeChg6cPYX6yIqqzo9bgwaRZYCR1sZxapyl08t6FEbpaiiWvAZKDZWPMPcUFh3hCMAhC
 WF3EbYMbpm/alvAekRuDP0avbnagZr3QF267h1j4l0w1ZC4S+7od3nl4ll6+fEvgD/wo
 FbtLroQnrOI7p/3kzAbu10vHI/mxkXa9P6XyGwRgZWO9TgljczCkqXP3PIwcVrjyYARH
 IsscnNJ3DcX+RFVXRUN/5cSUtHH3Elfj+7k16jE64NMAhzttvma2BGGGsVt/bVQ4Ytb6
 Fa2w==
X-Gm-Message-State: AOJu0Yza56fI3Y2izb3fJqTBBBwoTKooDYYE/4i/bF3Tm3xPKT+TE5TB
 kr+h4p0KpDxgkUWkqoLo+MniEMZUWsbr4BoGvAhmTQeypblCrUxLaKN0
X-Gm-Gg: AR+sD13Dmx3lI13JjZOTZpqad29X+iTtaBgVvKQ3GzLTtbO96NuKIZthhkHp0aIjIt7
 HlMNsCG7qdfs8bOhgM9g3J3e2NttwF3YSEHUjDWzEKlbq8O3vit2ph/Pzqkromp2A0+d0KJJstH
 b2nzpJ5dJTy4PZmxZwazg9fZXd24a34LZn4aRPAf8pwNXs1PkRwO7nBdTFEs5MIG/+10fGSkgGR
 Zho/w6zu4bdlmxiFzkGVG2oY3WgtDQbSs6gI1aSTxZ8Zx5bcpTdM/grwbiThReNa2Fts1Zl5Agq
 MVz69miEup5LVdw2pMbOvOfLUvLs2ydCovpw56OVc0TVmnHYzGAhmyMrhDAYtoPUjL4Ti1IIpDk
 vuPSzHxAyRNGR9cgprSGcxoOrb6VrEtU+iG78apk6ydFe4gtJoPPnFGDwCOdZteU1EpVG3wkK0L
 +/Q1OpWyDm25vB1h8D/TImEn9l2MzF2xSD7lOxKRQqHyyPH33YPHf9Gm7bpkU/SNxzJDQElk2Gp
 24qciwg4R4=
X-Received: by 2002:a17:903:40c5:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2d294c48ec2mr62397915ad.18.1786116556519; 
 Fri, 07 Aug 2026 08:29:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2406:da14:1cf8:d800:471c:a879:4603:554f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccae6f8sm10953895ad.1.2026.08.07.08.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:29:16 -0700 (PDT)
From: Wang Zhongyu <wzy15515798875@gmail.com>
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 4/5] tests/qtest: expand K230 I2C controller tests
Date: Fri,  7 Aug 2026 23:28:29 +0800
Message-ID: <20260807152830.6833-5-wzy15515798875@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807152830.6833-1-wzy15515798875@gmail.com>
References: <20260807152830.6833-1-wzy15515798875@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wzy15515798875@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 07 Aug 2026 12:41:00 -0400
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

Expand the K230 I2C qtests to cover instance isolation, read-only
registers, system reset, read-to-clear interrupts, abort source
reporting, and START BYTE abort handling.

Signed-off-by: Wang Zhongyu <wzy15515798875@gmail.com>
---
 tests/qtest/k230-i2c-test.c | 532 +++++++++++++++++++++++++++++++++++-
 1 file changed, 529 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/k230-i2c-test.c b/tests/qtest/k230-i2c-test.c
index cc8dd54153..1d134de5d0 100644
--- a/tests/qtest/k230-i2c-test.c
+++ b/tests/qtest/k230-i2c-test.c
@@ -25,11 +25,18 @@
 #define K230_IC_SAR                    0x08
 #define K230_IC_HS_MADDR               0x0c
 #define K230_IC_DATA_CMD               0x10
+#define K230_IC_SS_SCL_HCNT            0x14
+#define K230_IC_SS_SCL_LCNT            0x18
+#define K230_IC_FS_SCL_HCNT            0x1c
+#define K230_IC_FS_SCL_LCNT            0x20
+#define K230_IC_HS_SCL_HCNT            0x24
+#define K230_IC_HS_SCL_LCNT            0x28
 #define K230_IC_INTR_STAT              0x2c
 #define K230_IC_INTR_MASK              0x30
 #define K230_IC_RAW_INTR_STAT          0x34
 #define K230_IC_RX_TL                  0x38
 #define K230_IC_TX_TL                  0x3c
+#define K230_IC_CLR_INTR               0x40
 #define K230_IC_CLR_RX_UNDER           0x44
 #define K230_IC_CLR_TX_ABRT            0x54
 #define K230_IC_ENABLE                 0x6c
@@ -37,20 +44,32 @@
 #define K230_IC_TXFLR                  0x74
 #define K230_IC_RXFLR                  0x78
 #define K230_IC_TX_ABRT_SOURCE         0x80
+#define K230_IC_SDA_SETUP              0x94
+#define K230_IC_ACK_GENERAL_CALL       0x98
 #define K230_IC_ENABLE_STATUS          0x9c
 #define K230_IC_COMP_PARAM_1           0xf4
 #define K230_IC_COMP_VERSION           0xf8
 #define K230_IC_COMP_TYPE              0xfc
 
+/* IC_CON */
+#define IC_CON_MASTER_MODE             BIT(0)
 #define IC_CON_10BITADDR_MASTER        BIT(4)
+#define IC_CON_RESTART_EN              BIT(5)
+
+/* IC_TAR */
+#define IC_TAR_GC_OR_START             BIT(10)
+#define IC_TAR_SPECIAL                 BIT(11)
 
 /* IC_DATA_CMD */
+#define IC_DATA_CMD_READ               BIT(8)
 #define IC_DATA_CMD_STOP               BIT(9)
 
 /* IC_INTR_STAT and IC_RAW_INTR_STAT */
 #define IC_INTR_RX_UNDER               BIT(0)
 #define IC_INTR_TX_EMPTY               BIT(4)
 #define IC_INTR_TX_ABRT                BIT(6)
+#define IC_INTR_ACTIVITY               BIT(8)
+#define IC_INTR_START_DET              BIT(10)
 
 /* IC_STATUS */
 #define IC_STATUS_TFNF                 BIT(1)
@@ -58,6 +77,10 @@
 
 /* IC_TX_ABRT_SOURCE */
 #define IC_ABRT_7B_ADDR_NOACK          BIT(0)
+#define IC_ABRT_GCALL_NOACK            BIT(4)
+#define IC_ABRT_GCALL_READ             BIT(5)
+#define IC_ABRT_SBYTE_NORSTRT          BIT(9)
+#define IC_ABRT_MASTER_DIS             BIT(11)
 
 #define K230_IC_COMP_PARAM_1_VALUE     0x001f3fae
 #define K230_IC_COMP_VERSION_VALUE     0x3132302a
@@ -131,6 +154,38 @@ static void test_all_instances(void)
     qtest_quit(qts);
 }
 
+static void test_instance_isolation(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x2a);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_RX_TL, 17);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK, 0x41);
+
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
+                    ==, 0x2a);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RX_TL),
+                    ==, 17);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_INTR_MASK),
+                    ==, 0x41);
+
+    for (int i = 1; i < K230_I2C_COUNT; i++) {
+        g_assert_cmphex(qtest_readl(qts,
+                                   k230_i2c_base[i] + K230_IC_TAR),
+                        ==, 0x55);
+        g_assert_cmphex(qtest_readl(qts,
+                                   k230_i2c_base[i] + K230_IC_RX_TL),
+                        ==, 0);
+        g_assert_cmphex(qtest_readl(qts,
+                                   k230_i2c_base[i] +
+                                   K230_IC_INTR_MASK),
+                        ==, 0x8ff);
+    }
+
+    qtest_quit(qts);
+}
+
 static void test_register_access(void)
 {
     QTestState *qts = qtest_init("-machine k230");
@@ -163,6 +218,82 @@ static void test_register_access(void)
     g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TX_TL),
                     ==, 32);
 
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK,
+                 UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_INTR_MASK),
+                    ==, 0xfff);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SDA_SETUP,
+                 UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_SDA_SETUP),
+                    ==, 0xff);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ACK_GENERAL_CALL,
+                 UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_ACK_GENERAL_CALL),
+                    ==, 1);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE,
+                 UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_TX_ABRT_SOURCE),
+                    ==, 0xffff);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT,
+                 65525);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_SS_SCL_HCNT),
+                    ==, 65525);
+
+    /*
+     * Values greater than 65525 are rejected. The previous valid
+     * value must be preserved.
+     */
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT,
+                 65526);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_SS_SCL_HCNT),
+                    ==, 65525);
+
+    qtest_quit(qts);
+}
+
+static void test_readonly_registers(void)
+{
+    static const struct {
+        uint32_t offset;
+        uint32_t expected;
+    } registers[] = {
+        { K230_IC_INTR_STAT,     0 },
+        { K230_IC_RAW_INTR_STAT, 0 },
+        { K230_IC_STATUS,        IC_STATUS_TFNF | IC_STATUS_TFE },
+        { K230_IC_TXFLR,         0 },
+        { K230_IC_RXFLR,         0 },
+        { K230_IC_ENABLE_STATUS, 0 },
+        { K230_IC_COMP_PARAM_1,  K230_IC_COMP_PARAM_1_VALUE },
+        { K230_IC_COMP_VERSION,  K230_IC_COMP_VERSION_VALUE },
+        { K230_IC_COMP_TYPE,     K230_IC_COMP_TYPE_VALUE },
+    };
+    QTestState *qts = qtest_init("-machine k230");
+
+    for (size_t i = 0; i < G_N_ELEMENTS(registers); i++) {
+        qtest_writel(qts,
+                     K230_I2C0_BASE + registers[i].offset,
+                     UINT32_MAX);
+
+        g_assert_cmphex(qtest_readl(qts,
+                                   K230_I2C0_BASE +
+                                   registers[i].offset),
+                        ==, registers[i].expected);
+    }
+
     qtest_quit(qts);
 }
 
@@ -171,15 +302,78 @@ static void test_register_lock_while_enabled(void)
     QTestState *qts = qtest_init("-machine k230");
 
     qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x22);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SAR, 0x155);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_MADDR, 0x3);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT, 20);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_LCNT, 21);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_HCNT, 22);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_LCNT, 23);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_HCNT, 24);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_LCNT, 25);
+
     qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
 
-    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x33);
+    /*
+     * Configuration registers cannot be changed while the
+     * controller is enabled.
+     */
     qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, 0);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x33);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SAR, 0x222);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_MADDR, 0x7);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_HCNT, 30);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SS_SCL_LCNT, 31);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_HCNT, 32);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_FS_SCL_LCNT, 33);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_HCNT, 34);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_HS_SCL_LCNT, 35);
 
-    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
-                    ==, 0x22);
     g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON),
                     ==, 0x7f);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
+                    ==, 0x22);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_SAR),
+                    ==, 0x155);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_HS_MADDR),
+                    ==, 0x3);
+
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_SS_SCL_HCNT),
+                    ==, 20);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_SS_SCL_LCNT),
+                    ==, 21);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_FS_SCL_HCNT),
+                    ==, 22);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_FS_SCL_LCNT),
+                    ==, 23);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_HS_SCL_HCNT),
+                    ==, 24);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_HS_SCL_LCNT),
+                    ==, 25);
+
+    /*
+     * Configuration registers become writable again after the
+     * controller is disabled.
+     */
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 0);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x33);
+
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
+                    ==, 0x33);
 
     qtest_quit(qts);
 }
@@ -281,6 +475,7 @@ static void test_address_nack(void)
      */
     con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
     con &= ~IC_CON_10BITADDR_MASTER;
+
     qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
     qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x7f);
     qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
@@ -310,6 +505,325 @@ static void test_address_nack(void)
     qtest_quit(qts);
 }
 
+static void test_system_reset(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t raw;
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x2a);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_SAR, 0x123);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_RX_TL, 10);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TX_TL, 12);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_INTR_MASK, 0);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
+
+    /*
+     * Reading an empty RX FIFO produces RX_UNDER.
+     */
+    qtest_readl(qts, K230_I2C0_BASE + K230_IC_DATA_CMD);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
+
+    qtest_system_reset(qts);
+
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON),
+                    ==, 0x7f);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TAR),
+                    ==, 0x55);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_SAR),
+                    ==, 0x55);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_HS_MADDR),
+                    ==, 0x1);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_INTR_MASK),
+                    ==, 0x8ff);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RX_TL),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TX_TL),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_ENABLE),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_ENABLE_STATUS),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE + K230_IC_RAW_INTR_STAT),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                               K230_I2C0_BASE +
+                               K230_IC_TX_ABRT_SOURCE),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_TXFLR),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_RXFLR),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, K230_I2C0_BASE + K230_IC_STATUS),
+                    ==, IC_STATUS_TFNF | IC_STATUS_TFE);
+
+    qtest_quit(qts);
+}
+
+static void test_clear_on_read(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t con;
+    uint32_t raw;
+    uint32_t source;
+
+    /*
+     * Produce RX_UNDER.
+     */
+    qtest_readl(qts, K230_I2C0_BASE + K230_IC_DATA_CMD);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
+
+    /*
+     * Writing a clear register must not clear the interrupt.
+     */
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CLR_RX_UNDER, 1);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
+
+    /*
+     * Produce an independent TX_ABRT interrupt.
+     */
+    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
+    con &= ~IC_CON_10BITADDR_MASTER;
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x7f);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x55);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, IC_INTR_RX_UNDER);
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source & IC_ABRT_7B_ADDR_NOACK,
+                    ==, IC_ABRT_7B_ADDR_NOACK);
+
+    /*
+     * Reading CLR_RX_UNDER clears only RX_UNDER.
+     */
+    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_RX_UNDER);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+
+    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+
+    /*
+     * Writing CLR_TX_ABRT must not clear TX_ABRT.
+     */
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CLR_TX_ABRT, 1);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+
+    /*
+     * Reading CLR_TX_ABRT clears TX_ABRT and its source.
+     */
+    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_TX_ABRT);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
+    g_assert_cmphex(source, ==, 0);
+
+    /*
+     * CLR_INTR clears latched interrupts. TX_EMPTY remains asserted
+     * because it is recalculated from the empty TX FIFO.
+     */
+    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_INTR);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+
+    g_assert_cmphex(raw & IC_INTR_RX_UNDER, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_ACTIVITY, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_START_DET, ==, 0);
+    g_assert_cmphex(raw & IC_INTR_TX_EMPTY, ==, IC_INTR_TX_EMPTY);
+
+    qtest_quit(qts);
+}
+
+static void test_abort_sources(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t con;
+    uint32_t raw;
+    uint32_t source;
+
+    /*
+     * Master mode disabled.
+     */
+    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
+    con &= ~(IC_CON_MASTER_MODE | IC_CON_10BITADDR_MASTER);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR, 0x7f);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x55);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source & IC_ABRT_MASTER_DIS,
+                    ==, IC_ABRT_MASTER_DIS);
+
+    qtest_system_reset(qts);
+
+    /*
+     * A read command cannot target the General Call address.
+     */
+    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
+    con &= ~IC_CON_10BITADDR_MASTER;
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR,
+                 IC_TAR_SPECIAL);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_READ | IC_DATA_CMD_STOP);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source & IC_ABRT_GCALL_READ,
+                    ==, IC_ABRT_GCALL_READ);
+
+    qtest_system_reset(qts);
+
+    /*
+     * No slave is attached to acknowledge the General Call.
+     */
+    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
+    con &= ~IC_CON_10BITADDR_MASTER;
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR,
+                 IC_TAR_SPECIAL);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x55);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source & IC_ABRT_GCALL_NOACK,
+                    ==, IC_ABRT_GCALL_NOACK);
+
+    qtest_system_reset(qts);
+
+    /*
+     * 10-bit master addressing is deliberately unsupported.
+     */
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x55);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_start_byte_abort(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t con;
+    uint32_t raw;
+    uint32_t source;
+
+    /*
+     * START BYTE requires RESTART_EN.
+     */
+    con = qtest_readl(qts, K230_I2C0_BASE + K230_IC_CON);
+    con &= ~(IC_CON_10BITADDR_MASTER | IC_CON_RESTART_EN);
+
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_TAR,
+                 IC_TAR_SPECIAL | IC_TAR_GC_OR_START);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 1);
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_DATA_CMD,
+                 IC_DATA_CMD_STOP | 0x55);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source & IC_ABRT_SBYTE_NORSTRT,
+                    ==, IC_ABRT_SBYTE_NORSTRT);
+
+    /*
+     * Bit 9 remains set while the invalid configuration remains.
+     */
+    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_TX_ABRT);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, IC_INTR_TX_ABRT);
+    g_assert_cmphex(source & IC_ABRT_SBYTE_NORSTRT,
+                    ==, IC_ABRT_SBYTE_NORSTRT);
+
+    /*
+     * Remove the cause by enabling RESTART_EN, then clear again.
+     */
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_ENABLE, 0);
+
+    con |= IC_CON_RESTART_EN;
+    qtest_writel(qts, K230_I2C0_BASE + K230_IC_CON, con);
+
+    qtest_readl(qts, K230_I2C0_BASE + K230_IC_CLR_TX_ABRT);
+
+    raw = qtest_readl(qts,
+                      K230_I2C0_BASE + K230_IC_RAW_INTR_STAT);
+    source = qtest_readl(qts,
+                         K230_I2C0_BASE + K230_IC_TX_ABRT_SOURCE);
+
+    g_assert_cmphex(raw & IC_INTR_TX_ABRT, ==, 0);
+    g_assert_cmphex(source, ==, 0);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -318,8 +832,12 @@ int main(int argc, char **argv)
                    test_reset_values);
     qtest_add_func("/k230-i2c/all-instances",
                    test_all_instances);
+    qtest_add_func("/k230-i2c/instance-isolation",
+                   test_instance_isolation);
     qtest_add_func("/k230-i2c/register-access",
                    test_register_access);
+    qtest_add_func("/k230-i2c/readonly-registers",
+                   test_readonly_registers);
     qtest_add_func("/k230-i2c/register-lock-while-enabled",
                    test_register_lock_while_enabled);
     qtest_add_func("/k230-i2c/enable-disable",
@@ -330,6 +848,14 @@ int main(int argc, char **argv)
                    test_rx_underflow);
     qtest_add_func("/k230-i2c/address-nack",
                    test_address_nack);
+    qtest_add_func("/k230-i2c/system-reset",
+                   test_system_reset);
+    qtest_add_func("/k230-i2c/clear-on-read",
+                   test_clear_on_read);
+    qtest_add_func("/k230-i2c/abort-sources",
+                   test_abort_sources);
+    qtest_add_func("/k230-i2c/start-byte-abort",
+                   test_start_byte_abort);
 
     return g_test_run();
 }
-- 
2.43.0


