Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84891C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACRf-0001D9-67; Thu, 23 May 2024 13:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACRD-0000tR-M4
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:41:16 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACR3-0001iB-9L
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:41:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ecc23e6c9dso121677255ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716486056; x=1717090856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJhbWYau4WstOwn4EIxb6YBMeRvDTbUyxW++LUcXVIo=;
 b=UycpzrR9xDjMcNAVXW+Gg5ysBWQTs5/fPMdwcZO45wVce7fxz1brkwgexXoVvTtUYZ
 38xMrl1vxeCgEEXYXcNzSs+5JFCS2fuzrsCubYgtL1Tm+D/VUh2wCw/PshYxhWgY4dAa
 OL6NzG5RZR13UuBQA5Cs7dBKrfWDqIAgW2ph2I3xqPnP20S6/O/MriTM/MvUXjo+7jFI
 rZzXak8Kt0bEF6t4J2CxKwKstJizPNNP4WpCw4GxcinPaiWE15xMUsJDaDildo9ynkKc
 HMxYD+YoPDmKN4zozDTBMPQRhGoFD4Bk2UsWUmIxLk1AHwJ7XsHS9lk5J49sk5rRSnh8
 j9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486056; x=1717090856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJhbWYau4WstOwn4EIxb6YBMeRvDTbUyxW++LUcXVIo=;
 b=NaC7DDFHE/LTQKLMXZ0FAeQsW+b52lnmYUYI2aOss6VMnCQ57LvoNOcQeAv2PhkMeh
 4jzVmakfLhVsYibPcwWTWTSzRuCB9KJMTZBu9VZhrBaTFNc4nA0pmrARjDM+Ld6siYWs
 PIdtd11+BPt3sXxkXHFUgN6O9nNwzrA6wGhNUkMIwMXqEW/1UyvK1QsLKZkDblP9tifn
 QZ2DBBRNIAtaDg59Kb2TrF8mcBh7j+NyM9nZKgUcjJ6pPuSRS7ViF+QeNU9XuNk/SgQG
 j5fw3D3a+wr4T/umcwYbd/7zP5V94m56XizBYjWY39TesLuQN5Xop3C9ZzgVkZ4xMWpO
 g9Vw==
X-Gm-Message-State: AOJu0Yxw2zKRhJbFQQDsU3bszfXxubYAvDzOUI/jDWYQe2rqw3nL7MPg
 vwMgF6l1IX4oN+KGHEnRClVtAmnUwZ40CmmCWeOXsozb4zRUj3tCGOHHY9Pg8Us59Hxl59Tr06H
 q
X-Google-Smtp-Source: AGHT+IG6JpwGB+bAb8hKgCbbilTO23QmICWNUATOiCsWsUcJG6dlN5KcetRQ63/R2WCVDzago99pNA==
X-Received: by 2002:a17:902:e54d:b0:1e3:cfc5:589e with SMTP id
 d9443c01a7336-1f4498e1c90mr115795ad.64.1716486056545; 
 Thu, 23 May 2024 10:40:56 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fb4ca0ebsm81246535ad.119.2024.05.23.10.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:40:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 13/13] qtest/riscv-iommu-test: add init queues test
Date: Thu, 23 May 2024 14:39:54 -0300
Message-ID: <20240523173955.1940072-14-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add an additional test to further exercise the IOMMU where we attempt to
initialize the command, fault and page-request queues.

These steps are taken from chapter 6.2 of the RISC-V IOMMU spec,
"Guidelines for initialization". It emulates what we expect from the
software/OS when initializing the IOMMU.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 tests/qtest/libqos/riscv-iommu.h |  29 +++++++
 tests/qtest/riscv-iommu-test.c   | 141 +++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/tests/qtest/libqos/riscv-iommu.h b/tests/qtest/libqos/riscv-iommu.h
index d123efb41f..c62ddedbac 100644
--- a/tests/qtest/libqos/riscv-iommu.h
+++ b/tests/qtest/libqos/riscv-iommu.h
@@ -62,6 +62,35 @@
 
 #define RISCV_IOMMU_REG_IPSR            0x0054
 
+#define RISCV_IOMMU_REG_IVEC            0x02F8
+#define RISCV_IOMMU_REG_IVEC_CIV        GENMASK_ULL(3, 0)
+#define RISCV_IOMMU_REG_IVEC_FIV        GENMASK_ULL(7, 4)
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
index 7f0dbd0211..9e2afcb4b9 100644
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
@@ -84,10 +98,137 @@ static void test_reg_reset(void *obj, void *data, QGuestAllocator *t_alloc)
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
+    int k;
+
+    reg64 = riscv_iommu_read_reg64(r_iommu, RISCV_IOMMU_REG_CAP);
+    g_assert_cmpuint(reg64 & RISCV_IOMMU_CAP_VERSION, ==, 0x10);
+
+    /*
+     * Program the command queue. Write 0xF to civ, assert that
+     * we have 4 writable bits (k = 4). The amount of entries N in the
+     * command queue is 2^4 = 16. We need to alloc a N*16 bytes
+     * buffer and use it to set cqb.
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
+                            0xFFFF & RISCV_IOMMU_REG_IVEC_CIV);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_CIV, ==, 0xF);
+
+    q_addr = guest_alloc(t_alloc, 16 * 16);
+    reg64 = 0;
+    k = 4;
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
+     * Program the fault queue. Similar to the above:
+     * - Write 0xF to fiv, assert that we have 4 writable bits (k = 4)
+     * - Alloc a 16*32 bytes (instead of 16*16) buffer and use it to set
+     * fqb
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
+                            0xFFFF & RISCV_IOMMU_REG_IVEC_FIV);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_FIV, ==, 0xF0);
+
+    q_addr = guest_alloc(t_alloc, 16 * 32);
+    reg64 = 0;
+    k = 4;
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
+     * Program the page-request queue:
+     - Write 0xF to piv, assert that we have 4 writable bits (k = 4)
+     - Alloc a 16*16 bytes buffer and use it to set pqb.
+     */
+    riscv_iommu_write_reg32(r_iommu, RISCV_IOMMU_REG_IVEC,
+                            0xFFFF & RISCV_IOMMU_REG_IVEC_PIV);
+    reg = riscv_iommu_read_reg32(r_iommu, RISCV_IOMMU_REG_IVEC);
+    g_assert_cmpuint(reg & RISCV_IOMMU_REG_IVEC_PIV, ==, 0xF000);
+
+    q_addr = guest_alloc(t_alloc, 16 * 16);
+    reg64 = 0;
+    k = 4;
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
2.44.0


