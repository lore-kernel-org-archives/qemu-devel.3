Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F9DEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socQx-0006WD-Cy; Thu, 12 Sep 2024 01:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQJ-0003hU-0n
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:23 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQG-00035T-Kh
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:18 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so425699a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119075; x=1726723875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0QoSfGJXqOMmELOrOr90/RAPKmZ/9pld+RMp498JFM=;
 b=MVZ/tHr9QEzVG18+mclv+Tixoxax8SvH7isStwA3eH3Mhe4GXg7FPj51Sh1uk/pgUh
 oUplAMeFRV8azGGPtWw53idDpJqmwx/V6TvSJOgZaMMU9mkKifBcPIUwSAvEyuDQXlub
 gPb/QedgeN8pczmhREL1xFPcUyhxRKvN9NyQUqWjcAQ2Xx3WWj8NIG5BF0qxmHWdlhru
 /UxRJM7xp4lWesFbyiA7q+saRdq2LgYMQadlWKoQWN8+cmo1uHzFEqgFQxorZCAYru33
 Mzih5K5wzdwDGqncLJ9Q3ylBcp0vA6LxLSmsjrzicdire5zHLmdN7fSwe1VqpvKs4zvg
 u21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119075; x=1726723875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0QoSfGJXqOMmELOrOr90/RAPKmZ/9pld+RMp498JFM=;
 b=AriX8Jpafno9WcL5toM0aGamxTQKJTP2cM7ZWg0HcGOrwMKqBUZhium/2HP6xFJcQH
 JMtbjjj9MduE5RLXCehMCvl1U9yVf58rIxxO68KgEP1dgM4HBatzedI68K6fFPrM/Dpb
 pscuR1SKmVN2CCNOYaOifTEEQLqDNbhpWDd7r9BYRpNpREUEHE5o3ZOjXc0cEsBdFvVm
 CUHkNADjBPUp1OnbLKKMwRV1U2K4XpxGPb3evEZi/OaZ55ALtVGHSeT7taPK0deEl4KS
 24kaq5n/uddos/3+fetgOGu8FhBDNumub1pMkP2k1JJkKsuiJVnNkcCNQPQhUiIH4Jo8
 5u/g==
X-Gm-Message-State: AOJu0YyNTryQBy6zCDdATFE28APEiORLBT4iLWqTxvasShXdI1x+eCQY
 Vh4MvFGP9TTR1fZZTF2g2ZM1BgeORwyilBUG/tompdPLMkRN2UldG8fwMA==
X-Google-Smtp-Source: AGHT+IFINdLzsheOopuexKEJ90gMyuDC6sN9x8R4KB/vZvCjk2JCPxvtk2JhI+ADLuBgzprq+irWhQ==
X-Received: by 2002:a05:6a21:164a:b0:1cf:54bd:393a with SMTP id
 adf61e73a8af0-1cf7620c101mr1916357637.37.1726119074955; 
 Wed, 11 Sep 2024 22:31:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/47] qtest/riscv-iommu-test: add init queues test
Date: Thu, 12 Sep 2024 15:29:29 +1000
Message-ID: <20240912052953.2552501-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add an additional test to further exercise the IOMMU where we attempt to
initialize the command, fault and page-request queues.

These steps are taken from chapter 6.2 of the RISC-V IOMMU spec,
"Guidelines for initialization". It emulates what we expect from the
software/OS when initializing the IOMMU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240903201633.93182-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/libqos/riscv-iommu.h |  30 ++++++++
 tests/qtest/riscv-iommu-test.c   | 127 +++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-iommu.h
index d123efb41f..318db13799 100644
--- a/tests/qtest/libqos/riscv-iommu.h
+++ b/tests/qtest/libqos/riscv-iommu.h
@@ -62,6 +62,36 @@
 
 #define RISCV_IOMMU_REG_IPSR            0x0054
 
+#define RISCV_IOMMU_REG_IVEC            0x02F8
+#define RISCV_IOMMU_REG_IVEC_CIV        GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_REG_IVEC_FIV        GENMASK_ULL(7, 4)
+#define RISCV_IOMMU_REG_IVEC_PMIV       GENMASK_ULL(11, 8)
+#define RISCV_IOMMU_REG_IVEC_PIV        GENMASK_ULL(15, 12)
+
+#define RISCV_IOMMU_REG_CQB             0x0018
+#define RISCV_IOMMU_CQB_PPN_START       10
+#define RISCV_IOMMU_CQB_PPN_LEN         44
+#define RISCV_IOMMU_CQB_LOG2SZ_START    0
+#define RISCV_IOMMU_CQB_LOG2SZ_LEN      5
+
+#define RISCV_IOMMU_REG_CQT             0x0024
+
+#define RISCV_IOMMU_REG_FQB             0x0028
+#define RISCV_IOMMU_FQB_PPN_START       10
+#define RISCV_IOMMU_FQB_PPN_LEN         44
+#define RISCV_IOMMU_FQB_LOG2SZ_START    0
+#define RISCV_IOMMU_FQB_LOG2SZ_LEN      5
+
+#define RISCV_IOMMU_REG_FQT             0x0034
+
+#define RISCV_IOMMU_REG_PQB             0x0038
+#define RISCV_IOMMU_PQB_PPN_START       10
+#define RISCV_IOMMU_PQB_PPN_LEN         44
+#define RISCV_IOMMU_PQB_LOG2SZ_START    0
+#define RISCV_IOMMU_PQB_LOG2SZ_LEN      5
+
+#define RISCV_IOMMU_REG_PQT             0x0044
+
 typedef struct QRISCVIOMMU {
     QOSGraphObject obj;
     QPCIDevice dev;
diff --git a/tests/qtest/riscv-iommu-test.c b/tests/qtest/riscv-iommu-test.c
index 7f0dbd0211..c38a0a160d 100644
--- a/tests/qtest/riscv-iommu-test.c
+++ b/tests/qtest/riscv-iommu-test.c
@@ -33,6 +33,20 @@ static uint64_t riscv_iommu_read_reg64(QRISCVIOMMU *r_iommu, int reg_offset)
     return reg;
 }
 
+static void riscv_iommu_write_reg32(QRISCVIOMMU *r_iommu, int reg_offset,
+                                    uint32_t val)
+{
+    qpci_memwrite(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                  &val, sizeof(val));
+}
+
+static void riscv_iommu_write_reg64(QRISCVIOMMU *r_iommu, int reg_offset,
+                                    uint64_t val)
+{
+    qpci_memwrite(&r_iommu->dev, r_iommu->reg_bar, reg_offset,
+                  &val, sizeof(val));
+}
+
 static void test_pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QRISCVIOMMU *r_iommu = obj;
@@ -84,10 +98,123 @@ static void test_reg_reset(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert_cmpuint(reg, ==, 0);
 }
 
+/*
+ * Common timeout-based poll for CQCSR, FQCSR and PQCSR. All
+ * their ON bits are mapped as RISCV_IOMMU_QUEUE_ACTIVE (16),
+ */
+static void qtest_wait_for_queue_active(QRISCVIOMMU *r_iommu,
+                                        uint32_t queue_csr)
+{
+    QTestState *qts = global_qtest;
+    guint64 timeout_us = 2 * 1000 * 1000;
+    gint64 start_time = g_get_monotonic_time();
+    uint32_t reg;
+
+    for (;;) {
+        qtest_clock_step(qts, 100);
+
+        reg = riscv_iommu_read_reg32(r_iommu, queue_csr);
+        if (reg & RISCV_IOMMU_QUEUE_ACTIVE) {
+            break;
+        }
+        g_assert(g_get_monotonic_time() - start_time <= timeout_us);
+    }
+}
+
+/*
+ * Goes through the queue activation procedures of chapter 6.2,
+ * "Guidelines for initialization", of the RISCV-IOMMU spec.
+ */
+static void test_iommu_init_queues(void *obj, void *data,
+                                   QGuestAllocator *t_alloc)
+{
+    QRISCVIOMMU *r_iommu = obj;
+    uint64_t reg64, q_addr;
+    uint32_t reg;
+    int k = 2;
+
+    reg64 = riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
+    g_assert_cmpuint(reg64 & RISCV_IOMMU_CAP_VERSION, ==, 0x10);
+
+    /*
+     * Program the command queue. Write 0xF to civ, fiv, pmiv and
+     * piv. With the current PCI device impl we expect 2 writable
+     * bits for each (k = 2) since we have N = 4 total vectors (2^k).
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC, 0xFFFF);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_CIV, ==, 0x3);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_FIV, ==, 0x30);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_PMIV, ==, 0x300);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_PIV, ==, 0x3000);
+
+    /* Alloc a 4*16 bytes buffer and use it to set cqb */
+    q_addr = guest_alloc(t_alloc, 4 * 16);
+    reg64 = 0;
+    deposit64(reg64, RISCV_IOMMU_CQB_PPN_START,
+              RISCV_IOMMU_CQB_PPN_LEN, q_addr);
+    deposit64(reg64, RISCV_IOMMU_CQB_LOG2SZ_START,
+              RISCV_IOMMU_CQB_LOG2SZ_LEN, k - 1);
+    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_CQB, reg64);
+
+    /* cqt = 0, cqcsr.cqen = 1, poll cqcsr.cqon until it reads 1 */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_CQT, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR);
+    reg |= RISCV_IOMMU_CQCSR_CQEN;
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_CQCSR, reg);
+
+    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_CQCSR);
+
+    /*
+     * Program the fault queue. Alloc a 4*32 bytes (instead of 4*16)
+     * buffer and use it to set fqb.
+     */
+    q_addr = guest_alloc(t_alloc, 4 * 32);
+    reg64 = 0;
+    deposit64(reg64, RISCV_IOMMU_FQB_PPN_START,
+              RISCV_IOMMU_FQB_PPN_LEN, q_addr);
+    deposit64(reg64, RISCV_IOMMU_FQB_LOG2SZ_START,
+              RISCV_IOMMU_FQB_LOG2SZ_LEN, k - 1);
+    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_FQB, reg64);
+
+    /* fqt = 0, fqcsr.fqen = 1, poll fqcsr.fqon until it reads 1 */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_FQT, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR);
+    reg |= RISCV_IOMMU_FQCSR_FQEN;
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_FQCSR, reg);
+
+    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_FQCSR);
+
+    /*
+     * Program the page-request queue. Alloc a 4*16 bytes buffer
+     * and use it to set pqb.
+     */
+    q_addr = guest_alloc(t_alloc, 4 * 16);
+    reg64 = 0;
+    deposit64(reg64, RISCV_IOMMU_PQB_PPN_START,
+              RISCV_IOMMU_PQB_PPN_LEN, q_addr);
+    deposit64(reg64, RISCV_IOMMU_PQB_LOG2SZ_START,
+              RISCV_IOMMU_PQB_LOG2SZ_LEN, k - 1);
+    riscv_iommu_write_reg64(r_iommu, RISCV_IOMMU_REG_PQB, reg64);
+
+    /* pqt = 0, pqcsr.pqen = 1, poll pqcsr.pqon until it reads 1 */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_PQT, 0);
+
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR);
+    reg |= RISCV_IOMMU_PQCSR_PQEN;
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_PQCSR, reg);
+
+    qtest_wait_for_queue_active(r_iommu, RISCV_IOMMU_REG_PQCSR);
+}
+
 static void register_riscv_iommu_test(void)
 {
     qos_add_test("pci_config", "riscv-iommu-pci", test_pci_config, NULL);
     qos_add_test("reg_reset", "riscv-iommu-pci", test_reg_reset, NULL);
+    qos_add_test("iommu_init_queues", "riscv-iommu-pci",
+                 test_iommu_init_queues, NULL);
 }
 
 libqos_init(register_riscv_iommu_test);
-- 
2.46.0


