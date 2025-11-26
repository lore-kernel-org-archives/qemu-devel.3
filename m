Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C221AD10F5D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHUY-00059F-Ru; Wed, 26 Nov 2025 10:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vOHU7-0004iR-Ey; Wed, 26 Nov 2025 10:31:14 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vOHU3-0001nR-Gp; Wed, 26 Nov 2025 10:31:11 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnVVw2HSdpY5IEAQ--.4713S2;
 Wed, 26 Nov 2025 23:31:02 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX8e4lHSdpN6MHAA--.21552S8;
 Wed, 26 Nov 2025 23:31:01 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v4 3/4] tests/qtest/libqos: Add SMMUv3 helper library
Date: Wed, 26 Nov 2025 23:30:39 +0800
Message-Id: <20251126153040.1280317-6-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126153040.1280317-1-tangtao1634@phytium.com.cn>
References: <20251126153040.1280317-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX8e4lHSdpN6MHAA--.21552S8
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWkmDa4HlgABs+
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZFyrZryrAw4xKryfKw1kuFg_yoW5tw15Co
 W3XFs8Z3WkWw17ur12kF1xtan7WFWv9FWxAr45Jw4q9an3GrWY9a4ftws8X3Wftr15Gry8
 Ar95JayxJFykJr95n29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
operations. This module encapsulates common tasks like:

- SMMUv3 initialization (enabling, configuring command/event queues)
- Stream Table Entry (STE) and Context Descriptor (CD) setup
- Multi-level page table construction (L0-L3 for 4KB granules)
- Support for Stage 1, Stage 2, and nested translation modes
- Could be easily extended to support multi-space testing infrastructure
    (Non-Secure, Secure, Root, Realm)

The library provides high-level abstractions that allow test code to
focus on IOMMU behavior validation rather than low-level register
manipulation and page table encoding. Key features include:

- Automatic memory allocation for translation structures with proper
    alignment
- Helper functions to build valid STEs/CDs for different translation
    scenarios
- Page table walkers that handle address offset calculations per
    security space
- Command queue management for SMMU configuration commands

This infrastructure is designed to be used by iommu-testdev-based tests
and future SMMUv3 test suites, reducing code duplication and improving
test maintainability.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/qtest/libqos/meson.build  |   3 +
 tests/qtest/libqos/qos-smmuv3.c | 731 ++++++++++++++++++++++++++++++++
 tests/qtest/libqos/qos-smmuv3.h | 267 ++++++++++++
 3 files changed, 1001 insertions(+)
 create mode 100644 tests/qtest/libqos/qos-smmuv3.c
 create mode 100644 tests/qtest/libqos/qos-smmuv3.h

diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 1ddaf7b095..8d6758ec2b 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -60,6 +60,9 @@ libqos_srcs = files(
         'x86_64_pc-machine.c',
         'riscv-virt-machine.c',
         'loongarch-virt-machine.c',
+
+        # SMMU:
+        'qos-smmuv3.c',
 )
 
 if have_virtfs
diff --git a/tests/qtest/libqos/qos-smmuv3.c b/tests/qtest/libqos/qos-smmuv3.c
new file mode 100644
index 0000000000..377ceb9e53
--- /dev/null
+++ b/tests/qtest/libqos/qos-smmuv3.c
@@ -0,0 +1,731 @@
+/*
+ * QOS SMMUv3 Module
+ *
+ * This module provides SMMUv3-specific helper functions for libqos tests,
+ * encapsulating SMMUv3 setup, assertion, and cleanup operations.
+ *
+ * Copyright (c) 2025 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/smmuv3-common.h"
+#include "tests/qtest/libqos/pci.h"
+#include "hw/misc/iommu-testdev.h"
+#include "qos-smmuv3.h"
+
+#define QSMMU_STE_S2T0SZ_VAL 0x14
+
+/* Apply space offset to address */
+static inline uint64_t qsmmu_apply_space_offs(QSMMUSpace sp,
+                                              uint64_t address)
+{
+    return address + qsmmu_space_offset(sp);
+}
+
+uint32_t qsmmu_expected_dma_result(QSMMUTestContext *ctx)
+{
+    /* Currently only non-secure space is supported. */
+    if (ctx->tx_space != QSMMU_SPACE_NONSECURE) {
+        return ITD_DMA_ERR_TX_FAIL;
+    }
+    return ctx->config.expected_result;
+}
+
+uint32_t qsmmu_build_dma_attrs(QSMMUSpace space)
+{
+    uint32_t attrs = 0;
+    switch (space) {
+    case QSMMU_SPACE_NONSECURE:
+        /* Non-secure: secure=0, space=1 */
+        attrs = ITD_ATTRS_SET_SECURE(attrs, 0);
+        attrs = ITD_ATTRS_SET_SPACE(attrs, QSMMU_SPACE_NONSECURE);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return attrs;
+}
+
+uint32_t qsmmu_setup_and_enable_translation(QSMMUTestContext *ctx)
+{
+    uint32_t build_result;
+
+    /* Build page tables and SMMU structures first */
+    build_result = qsmmu_build_translation(
+                       ctx->qts, ctx->config.trans_mode,
+                       ctx->tx_space, ctx->sid);
+    if (build_result != 0) {
+        g_test_message("Build failed: mode=%u sid=%u status=0x%x",
+                       ctx->config.trans_mode, ctx->sid, build_result);
+        ctx->trans_status = build_result;
+        return ctx->trans_status;
+    }
+
+    /* Program SMMU registers for the appropriate security space */
+    qsmmu_program_regs(ctx->qts, ctx->smmu_base, ctx->tx_space);
+
+    ctx->trans_status = 0;
+    return ctx->trans_status;
+}
+
+uint32_t qsmmu_trigger_dma(QSMMUTestContext *ctx)
+{
+    uint32_t result, attrs_val;
+
+    /* Program DMA parameters */
+    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_GVA_LO,
+                   (uint32_t)ctx->config.dma_iova);
+    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_GVA_HI,
+                   (uint32_t)(ctx->config.dma_iova >> 32));
+    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_LEN,
+                   ctx->config.dma_len);
+
+    /* Build and write DMA attributes based on device security state. */
+    attrs_val = qsmmu_build_dma_attrs(QSMMU_SPACE_NONSECURE);
+    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_ATTRS, attrs_val);
+
+    /* Flip status */
+    /* Arm iommu-testdev so the next read triggers DMA */
+    qpci_io_writel(ctx->dev, ctx->bar, ITD_REG_DMA_DBELL, ITD_DMA_DBELL_ARM);
+
+    /* Trigger DMA by reading ID register */
+    qpci_io_readl(ctx->dev, ctx->bar, ITD_REG_DMA_TRIGGERING);
+
+    /* Poll for DMA completion */
+    for (int i = 0; i < 1000; i++) {
+        result = qpci_io_readl(ctx->dev, ctx->bar, ITD_REG_DMA_RESULT);
+        if (result != ITD_DMA_RESULT_BUSY) {
+            ctx->dma_result = result;
+            break;
+        }
+        g_usleep(1000);
+    }
+
+    /* Fallback for timeout */
+    if (ctx->dma_result == ITD_DMA_RESULT_BUSY) {
+        ctx->dma_result = ITD_DMA_ERR_TX_FAIL;
+    }
+
+    return ctx->dma_result;
+}
+
+static void qsmmu_push_cfgi_cmd(QTestState *qts, uint64_t smmu_base,
+                                QSMMUSpace bank_sp, uint32_t type,
+                                uint32_t sid, bool ssec)
+{
+    hwaddr bank_off;
+    uint32_t new_prod, base_lo, base_hi, log2size, prod;
+    uint32_t index_mask, slot, words[4];
+    uint64_t base, qbase, entry_pa;
+
+    g_assert_false(ssec);
+
+    bank_off = 0;
+
+    /* Read CMDQ_BASE register */
+    base_lo = qtest_readl(qts, smmu_base + bank_off + A_CMDQ_BASE);
+    base_hi = qtest_readl(qts, smmu_base + bank_off + A_CMDQ_BASE + 4);
+    base = ((uint64_t)base_hi << 32) | base_lo;
+    log2size = base & 0x1f;
+    qbase = base & SMMU_BASE_ADDR_MASK;
+
+    /* Read CMDQ_PROD register */
+    prod = qtest_readl(qts, smmu_base + bank_off + A_CMDQ_PROD);
+    index_mask = (1u << log2size) - 1u;
+    slot = prod & index_mask;
+    entry_pa = qbase + (uint64_t)slot * 16u;
+
+    /* Prepare command words */
+    memset(words, 0, sizeof(words));
+    words[0] = (type & 0xff) | (ssec ? (1u << 10) : 0u);
+    words[1] = sid;
+
+    /* Write command to the command queue */
+    for (int i = 0; i < 4; i++) {
+        qtest_writel(qts, entry_pa + i * 4, words[i]);
+    }
+
+    /* Update PROD to trigger command handler */
+    new_prod = (prod + 1) & ((1u << (log2size + 1)) - 1u);
+    qtest_writel(qts, smmu_base + bank_off + A_CMDQ_PROD, new_prod);
+}
+
+void qsmmu_cleanup_translation(QSMMUTestContext *ctx)
+{
+    static const QSMMUSpace spaces[] = { QSMMU_SPACE_NONSECURE };
+    size_t ste_cd_entry_bytes = sizeof(STE); /* STE size == CD size */
+    uint32_t sid;
+    uint64_t ste_addr, ste_addr_real, cd_addr_real;
+    QSMMUSpace build_space;
+
+    sid = ctx->sid;
+    ste_addr = sid * ste_cd_entry_bytes + QSMMU_STR_TAB_BASE;
+
+    /* Clear page table entries and configuration structures */
+    for (int idx = 0; idx < ARRAY_SIZE(spaces); idx++) {
+        build_space = spaces[idx];
+
+        ste_addr_real = qsmmu_apply_space_offs(build_space, ste_addr);
+        cd_addr_real = qsmmu_apply_space_offs(build_space, QSMMU_CD_GPA);
+        for (int i = 0; i < ste_cd_entry_bytes / sizeof(uint32_t); i++) {
+            qtest_writel(ctx->qts, ste_addr_real + i * 4, 0);
+            g_assert_cmpint(qtest_readl(ctx->qts, ste_addr_real + i * 4),
+                            ==, 0);
+
+            qtest_writel(ctx->qts, cd_addr_real + i * 4, 0);
+            g_assert_cmpint(qtest_readl(ctx->qts, cd_addr_real + i * 4),
+                            ==, 0);
+        }
+    }
+
+    /* Invalidate SMMU caches via configuration invalidation commands */
+    if (ctx->smmu_base) {
+        /* Issue cache invalidation commands to SMMU */
+        qsmmu_push_cfgi_cmd(ctx->qts, ctx->smmu_base, QSMMU_SPACE_NONSECURE,
+                            SMMU_CMD_CFGI_STE, sid, false);
+        qsmmu_push_cfgi_cmd(ctx->qts, ctx->smmu_base, QSMMU_SPACE_NONSECURE,
+                            SMMU_CMD_CFGI_CD, sid, false);
+        qsmmu_push_cfgi_cmd(ctx->qts, ctx->smmu_base, QSMMU_SPACE_NONSECURE,
+                            SMMU_CMD_TLBI_NSNH_ALL, sid, false);
+    }
+}
+
+bool qsmmu_validate_test_result(QSMMUTestContext *ctx)
+{
+    uint32_t expected = qsmmu_expected_dma_result(ctx);
+    g_test_message("-> Validating result: expected=0x%x actual=0x%x",
+                   expected, ctx->dma_result);
+    return (ctx->dma_result == expected);
+}
+
+QSMMUSpace qsmmu_sec_sid_to_space(QSMMUSecSID sec_sid)
+{
+    switch (sec_sid) {
+    case QSMMU_SEC_SID_NONSECURE:
+        return QSMMU_SPACE_NONSECURE;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+uint64_t qsmmu_space_offset(QSMMUSpace sp)
+{
+    switch (sp) {
+    case QSMMU_SPACE_NONSECURE:
+        return QSMMU_SPACE_OFFS_NS;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void qsmmu_single_translation(QSMMUTestContext *ctx)
+{
+    uint32_t config_result;
+    uint32_t dma_result;
+    bool test_passed;
+
+    /* Configure SMMU translation */
+    config_result = qsmmu_setup_and_enable_translation(ctx);
+    if (config_result != 0) {
+        g_test_message("Configuration failed: mode=%u status=0x%x",
+                       ctx->config.trans_mode, config_result);
+        return;
+    }
+
+    /* Trigger DMA operation */
+    dma_result = qsmmu_trigger_dma(ctx);
+    if (dma_result != 0) {
+        g_test_message("DMA failed: mode=%u result=0x%x",
+                       ctx->config.trans_mode, dma_result);
+    } else {
+        g_test_message("-> DMA succeeded: mode=%u", ctx->config.trans_mode);
+    }
+
+    /* Validate test result */
+    test_passed = qsmmu_validate_test_result(ctx);
+    g_assert_true(test_passed);
+
+    /* Clean up translation state to prepare for the next test */
+    qsmmu_cleanup_translation(ctx);
+}
+
+void qsmmu_translation_batch(const QSMMUTestConfig *configs, size_t count,
+                             QTestState *qts, QPCIDevice *dev,
+                             QPCIBar bar, uint64_t smmu_base)
+{
+    for (int i = 0; i < count; i++) {
+        /* Initialize test memory */
+        qtest_memset(qts, configs[i].dma_iova, 0x00, configs[i].dma_len);
+        /* Execute each test configuration */
+        QSMMUTestContext ctx = {
+            .qts = qts,
+            .dev = dev,
+            .bar = bar,
+            .smmu_base = smmu_base,
+            .config = configs[i],
+            .trans_status = 0,
+            .dma_result = 0,
+            .sid = dev->devfn,
+            .tx_space = qsmmu_sec_sid_to_space(configs[i].sec_sid),
+        };
+
+        qsmmu_single_translation(&ctx);
+        g_test_message("--> Test %d completed: mode=%u sec_sid=%u "
+                       "status=0x%x result=0x%x", i, configs[i].trans_mode,
+                       configs[i].sec_sid, ctx.trans_status, ctx.dma_result);
+    }
+}
+
+uint32_t qsmmu_build_translation(QTestState *qts, QSMMUTransMode mode,
+                                 QSMMUSpace tx_space, uint32_t sid)
+{
+    uint64_t ste_addr, ste_addr_real, cd_addr_real;
+    uint64_t cd_ttb, vttb, vttb_real;
+    uint8_t nscfg0, nscfg1;
+    QSMMUSpace build_space;
+    size_t ste_cd_entry_bytes = sizeof(STE);
+    STE ste;
+    CD cd;
+
+    build_space = tx_space;
+    if (build_space != QSMMU_SPACE_NONSECURE) {
+        return 0xdeadbeafu;
+    }
+
+    /* Build STE image */
+    memset(&ste, 0, sizeof(ste));
+    switch (mode) {
+    case QSMMU_TM_S1_ONLY:
+        STE_SET_CONFIG(&ste, 0x5);
+        break;
+    case QSMMU_TM_S2_ONLY:
+        STE_SET_CONFIG(&ste, 0x6);
+        break;
+    case QSMMU_TM_NESTED:
+    default:
+        STE_SET_CONFIG(&ste, 0x7);
+        break;
+    }
+
+    STE_SET_VALID(&ste, 1);
+    STE_SET_S2T0SZ(&ste, QSMMU_STE_S2T0SZ_VAL);
+    STE_SET_S2SL0(&ste, 0x2);
+    STE_SET_S2TG(&ste, 0);
+    STE_SET_S2PS(&ste, 0x5);
+    STE_SET_S2AA64(&ste, 1);
+    STE_SET_S2ENDI(&ste, 0);
+    STE_SET_S2AFFD(&ste, 0);
+
+    /*
+     * The consistent policy also extends to pointer fetches. For cases that
+     * require reading STE.S1ContextPtr or STE.S2TTB, we still follow the same
+     * policy:
+     * - The PA space security attribute of the address pointed to
+     *   (e.g., the CD or S2L1 table) must also match the input 'SEC_SID'.
+     */
+    cd_addr_real = qsmmu_apply_space_offs(build_space, QSMMU_CD_GPA);
+    STE_SET_CTXPTR(&ste, cd_addr_real);
+
+    vttb = QSMMU_VTTB;
+    vttb_real = qsmmu_apply_space_offs(build_space, vttb);
+    STE_SET_S2TTB(&ste, vttb_real);
+
+    ste_addr = sid * ste_cd_entry_bytes + QSMMU_STR_TAB_BASE;
+    ste_addr_real = qsmmu_apply_space_offs(build_space, ste_addr);
+
+    /* Write STE to memory */
+    for (int i = 0; i < ARRAY_SIZE(ste.word); i++) {
+        qtest_writel(qts, ste_addr_real + i * 4, ste.word[i]);
+    }
+
+    switch (tx_space) {
+    case QSMMU_SPACE_NONSECURE:
+        nscfg0 = 0x1;
+        nscfg1 = 0x1;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    /* Build CD image for S1 path if needed */
+    if (mode != QSMMU_TM_S2_ONLY) {
+        memset(&cd, 0, sizeof(cd));
+
+        CD_SET_ASID(&cd, 0x1e20);
+        CD_SET_AARCH64(&cd, 1);
+        CD_SET_VALID(&cd, 1);
+        CD_SET_A(&cd, 1);
+        CD_SET_S(&cd, 0);
+        CD_SET_HD(&cd, 0);
+        CD_SET_HA(&cd, 0);
+        CD_SET_IPS(&cd, 0x4);
+        CD_SET_TBI(&cd, 0x0);
+        CD_SET_AFFD(&cd, 0x0);
+        CD_SET_EPD(&cd, 0, 0x0);
+        CD_SET_EPD(&cd, 1, 0x1);
+        CD_SET_TSZ(&cd, 0, 0x10);
+        CD_SET_TG(&cd, 0, 0x0);
+        CD_SET_ENDI(&cd, 0x0);
+
+        CD_SET_NSCFG(&cd, 0, nscfg0);
+        CD_SET_NSCFG(&cd, 1, nscfg1);
+        CD_SET_R(&cd, 0x1);
+        cd_ttb = vttb_real;
+        CD_SET_TTB(&cd, 0, cd_ttb);
+
+        for (int i = 0; i < ARRAY_SIZE(cd.word); i++) {
+            /* TODO: Maybe need more work to write to secure RAM in future */
+            qtest_writel(qts, cd_addr_real + i * 4, cd.word[i]);
+            g_assert_cmpint(qtest_readl(qts, cd_addr_real + i * 4), ==,
+                            cd.word[i]);
+        }
+    }
+
+    qsmmu_setup_translation_tables(qts, QSMMU_IOVA_OR_IPA, build_space,
+                                   false, mode);
+    /* Nested extras: CD S2 tables */
+    if (mode == QSMMU_TM_NESTED) {
+        /*
+         * Extra Stage 2 page tables is needed if
+         *          SMMUTranslationClass == SMMU_CLASS_CD
+         * as smmuv3_do_translate would translate an IPA of the CD to the final
+         * output CD after a Stage 2 translation.
+         */
+        qsmmu_setup_translation_tables(qts, cd_addr_real, build_space,
+                                       true, mode);
+    }
+
+    return 0;
+}
+
+uint64_t qsmmu_bank_base(uint64_t base, QSMMUSpace sp)
+{
+    switch (sp) {
+    case QSMMU_SPACE_NONSECURE:
+        return base;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void qsmmu_program_bank(QTestState *qts, uint64_t bank_base, QSMMUSpace sp)
+{
+    uint64_t cmdq_base, eventq_base, strtab_base;
+
+    qtest_writel(qts, bank_base + A_GBPA, 0x80000000);  /* UPDATE */
+    qtest_writel(qts, bank_base + A_CR0, 0x0);          /* Disable */
+    qtest_writel(qts, bank_base + A_CR1, 0x0d75);       /* Config */
+
+    /* CMDQ_BASE: add address-space offset*/
+    cmdq_base = qsmmu_apply_space_offs(sp, QSMMU_CMDQ_BASE_ADDR);
+    cmdq_base |= 0x0a;  /* Size and valid bits */
+    qtest_writeq(qts, bank_base + A_CMDQ_BASE, cmdq_base);
+
+    qtest_writel(qts, bank_base + A_CMDQ_CONS, 0x0);
+    qtest_writel(qts, bank_base + A_CMDQ_PROD, 0x0);
+
+    /* EVENTQ_BASE: add address-space offset */
+    eventq_base = qsmmu_apply_space_offs(sp, QSMMU_EVENTQ_BASE_ADDR);
+    eventq_base |= 0x0a;  /* Size and valid bits */
+    qtest_writeq(qts, bank_base + A_EVENTQ_BASE, eventq_base);
+
+    qtest_writel(qts, bank_base + A_EVENTQ_PROD, 0x0);
+    qtest_writel(qts, bank_base + A_EVENTQ_CONS, 0x0);
+
+    /* STRTAB_BASE_CFG: linear stream table, LOG2SIZE=5 */
+    qtest_writel(qts, bank_base + A_STRTAB_BASE_CFG, 0x5);
+
+    /* STRTAB_BASE: add address-space offset */
+    strtab_base = qsmmu_apply_space_offs(sp, QSMMU_STR_TAB_BASE);
+    qtest_writeq(qts, bank_base + A_STRTAB_BASE, strtab_base);
+
+    /* CR0: Enable SMMU with appropriate flags */
+    qtest_writel(qts, bank_base + A_CR0, 0xd);
+}
+
+void qsmmu_program_regs(QTestState *qts, uint64_t smmu_base, QSMMUSpace space)
+{
+    uint64_t sp_base;
+    /* Always program Non-Secure bank first */
+    uint64_t ns_base = qsmmu_bank_base(smmu_base, QSMMU_SPACE_NONSECURE);
+    qsmmu_program_bank(qts, ns_base, QSMMU_SPACE_NONSECURE);
+
+    /* Program the requested space if different from Non-Secure */
+    sp_base = qsmmu_bank_base(smmu_base, space);
+    if (sp_base != ns_base) {
+        qsmmu_program_bank(qts, sp_base, space);
+    }
+}
+
+static uint32_t qsmmu_get_table_index(uint64_t addr, int level)
+{
+    switch (level) {
+    case 0:
+        return (addr >> 39) & 0x1ff;
+    case 1:
+        return (addr >> 30) & 0x1ff;
+    case 2:
+        return (addr >> 21) & 0x1ff;
+    case 3:
+        return (addr >> 12) & 0x1ff;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t qsmmu_get_table_addr(uint64_t base, int level, uint64_t iova)
+{
+    uint32_t index = qsmmu_get_table_index(iova, level);
+    return (base & QSMMU_PTE_MASK) + (index * 8);
+}
+
+/*
+ * qsmmu_get_pte_attrs - Calculate the S1 leaf PTE value
+ *
+ * IOMMU need to set different attributes for PTEs based on the translation mode
+ */
+static uint64_t qsmmu_get_pte_attrs(QSMMUTransMode mode, bool is_leaf,
+                                    QSMMUSpace space)
+{
+    uint64_t rw_mask = QSMMU_LEAF_PTE_RW_MASK;
+    uint64_t ro_mask = QSMMU_LEAF_PTE_RO_MASK;
+    uint64_t non_leaf_mask = QSMMU_NON_LEAF_PTE_MASK;
+
+    switch (space) {
+    case QSMMU_SPACE_NONSECURE:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!is_leaf) {
+        return non_leaf_mask;
+    }
+
+    /* For leaf PTE */
+    if (mode == QSMMU_TM_NESTED || mode == QSMMU_TM_S1_ONLY) {
+        return rw_mask;
+    }
+
+    return ro_mask;
+}
+
+/*
+ * qsmmu_setup_s2_walk_for_ipa - Setup Stage 2 page table walk for an IPA
+ *
+ * @qts: QTest state handle
+ * @space: Security space
+ * @ipa: Intermediate Physical Address to translate
+ * @s2_vttb: Stage 2 VTTB (page table base)
+ * @mode: Translation mode
+ * @is_final: Whether this is the final S2 walk (not nested within S1)
+ *
+ * Calculates and writes a 4-level Stage 2 page table walk for the given IPA.
+ * This function dynamically generates and writes all page table entries
+ * (L0-L3) to guest memory based on the input IPA and configuration.
+ */
+static void qsmmu_setup_s2_walk_for_ipa(QTestState *qts,
+                                        QSMMUSpace space,
+                                        uint64_t ipa,
+                                        uint64_t s2_vttb,
+                                        QSMMUTransMode mode,
+                                        bool is_final)
+{
+    uint64_t all_s2_l0_pte_val;
+    uint64_t all_s2_l1_pte_val;
+    uint64_t all_s2_l2_pte_val;
+    uint64_t all_s2_l3_pte_val;
+    uint64_t s2_l0_addr, s2_l1_addr, s2_l2_addr, s2_l3_addr;
+
+    /* Shared intermediate PTE values for all S2 walks */
+    all_s2_l0_pte_val = qsmmu_apply_space_offs(
+        space, QSMMU_L0_PTE_VAL | qsmmu_get_pte_attrs(mode, false, space));
+    all_s2_l1_pte_val = qsmmu_apply_space_offs(
+        space, QSMMU_L1_PTE_VAL | qsmmu_get_pte_attrs(mode, false, space));
+    all_s2_l2_pte_val = qsmmu_apply_space_offs(
+        space, QSMMU_L2_PTE_VAL | qsmmu_get_pte_attrs(mode, false, space));
+
+    /* Stage 2 Level 0 */
+    s2_l0_addr = qsmmu_get_table_addr(s2_vttb, 0, ipa);
+    qtest_writeq(qts, s2_l0_addr, all_s2_l0_pte_val);
+
+    /* Stage 2 Level 1 */
+    s2_l1_addr = qsmmu_get_table_addr(all_s2_l0_pte_val, 1, ipa);
+    qtest_writeq(qts, s2_l1_addr, all_s2_l1_pte_val);
+
+    /* Stage 2 Level 2 */
+    s2_l2_addr = qsmmu_get_table_addr(all_s2_l1_pte_val, 2, ipa);
+    qtest_writeq(qts, s2_l2_addr, all_s2_l2_pte_val);
+
+    /* Stage 2 Level 3 (leaf) */
+    s2_l3_addr = qsmmu_get_table_addr(all_s2_l2_pte_val, 3, ipa);
+
+    /*
+     * Stage 2 L3 PTE attributes depend on the context:
+     * - For nested S1 table address translations (!is_final):
+     *   Use LEAF attrs (0x763) because these PTEs map S1 table pages directly
+     * - For final S2 walk (is_final):
+     *   Use TABLE attrs (0x7e3) for the final IPA→PA mapping
+     */
+    if (!is_final) {
+        all_s2_l3_pte_val =
+            (ipa & QSMMU_PTE_MASK) |
+            qsmmu_get_pte_attrs(QSMMU_TM_NESTED, true, space);
+    } else {
+        all_s2_l3_pte_val =
+            (ipa & QSMMU_PTE_MASK) |
+            qsmmu_get_pte_attrs(QSMMU_TM_S2_ONLY, true, space);
+    }
+
+    qtest_writeq(qts, s2_l3_addr, all_s2_l3_pte_val);
+}
+
+/*
+ * qsmmu_setup_s1_level_with_nested_s2 - Setup S1 level with nested S2 walk
+ *
+ * @qts: QTest state handle
+ * @space: Security space
+ * @s1_level: Stage 1 level (0-3)
+ * @s1_pte_addr: Stage 1 PTE address (as IPA)
+ * @s1_pte_val: Stage 1 PTE value to write
+ * @s2_vttb: Stage 2 VTTB for nested translation
+ * @mode: Translation mode
+ *
+ * For nested translation, each S1 table access requires a full S2 walk
+ * to translate the S1 table's IPA to PA. This function performs the nested
+ * S2 walk and writes the S1 PTE value to guest memory.
+ */
+static void qsmmu_setup_s1_level_with_nested_s2(QTestState *qts,
+                                                QSMMUSpace space,
+                                                int s1_level,
+                                                uint64_t s1_pte_addr,
+                                                uint64_t s1_pte_val,
+                                                uint64_t s2_vttb,
+                                                QSMMUTransMode mode)
+{
+    /*
+     * Perform nested S2 walk to translate S1 table IPA to PA.
+     * This is always needed for S1_ONLY/S2_ONLY/NESTED modes because:
+     * - S1_ONLY: Needs S2 tables for "IPA as PA" mapping (for testing)
+     * - S2_ONLY: Needs S2 tables for direct translation
+     * - NESTED: Needs S2 tables for nested translation
+     */
+    qsmmu_setup_s2_walk_for_ipa(qts, space, s1_pte_addr,
+                                s2_vttb, mode, false);
+
+    /* Write the S1 PTE value */
+    qtest_writeq(qts, s1_pte_addr, s1_pte_val);
+}
+
+/*
+ * qsmmu_setup_translation_tables - Setup SMMU translation tables
+ *
+ * The 'SEC_SID' represents the input security state of the device/transaction,
+ * whether it's a static Secure state or a dynamically-switched Realm state.
+ * SEC_SID has been converted to the corresponding SEcurity Space (QSMMUSpace)
+ * before calling this function.
+ *
+ * In a real SMMU translation, this input security state does not unilaterally
+ * determine the output Physical Address (PA) space. The output PA space is
+ * ultimately determined by attributes encountered during the page table walk,
+ * such as NSCFG and NSTable.
+ *
+ * However, for the specific context of testing the SMMU with the iommu-testdev,
+ * and to simplify the future support for Secure and Realm states, we adopt a
+ * consistent policy:
+ *
+ * - We always ensure that the page table attributes (e.g., nscfg, nstable)
+ * *match* the input 'SEC_SID' of the test case.
+ *
+ * For example: If 'SEC_SID' is Non-Secure, the corresponding nscfg and nstable
+ * attributes in the translation tables will always be set to 1.
+ *
+ */
+void qsmmu_setup_translation_tables(QTestState *qts,
+                                    uint64_t iova,
+                                    QSMMUSpace space,
+                                    bool is_cd,
+                                    QSMMUTransMode mode)
+{
+    uint64_t all_s2_l0_pte_val, all_s2_l1_pte_val, all_s2_l2_pte_val;
+    uint64_t s1_vttb, s2_vttb, s1_leaf_pte_val;
+    uint64_t l0_addr, l1_addr, l2_addr, l3_addr;
+
+    g_test_message("Begin of construction: IOVA=0x%lx mode=%d is_building_CD=%s"
+                   " ===", iova, mode, is_cd ? "yes" : "no");
+
+    /* Initialize shared S2 PTE values used across all walks */
+    all_s2_l0_pte_val = qsmmu_apply_space_offs(
+        space, QSMMU_L0_PTE_VAL | qsmmu_get_pte_attrs(mode, false, space));
+    all_s2_l1_pte_val = qsmmu_apply_space_offs(
+        space, QSMMU_L1_PTE_VAL | qsmmu_get_pte_attrs(mode, false, space));
+    all_s2_l2_pte_val = qsmmu_apply_space_offs(
+        space, QSMMU_L2_PTE_VAL | qsmmu_get_pte_attrs(mode, false, space));
+
+    /* Both S1 and S2 share the same VTTB base */
+    s1_vttb = qsmmu_apply_space_offs(space, QSMMU_VTTB & QSMMU_PTE_MASK);
+    s2_vttb = s1_vttb;
+
+    if (!is_cd) {
+        /*
+         * Setup Stage 1 page tables with nested Stage 2 walks.
+         * For each S1 level (L0-L3), we need to:
+         * 1. Calculate S1 PTE address (as IPA)
+         * 2. Perform nested S2 walk to translate that IPA to PA
+         * 3. Write the S1 PTE value
+         */
+
+        /* Stage 1 Level 0 */
+        l0_addr = qsmmu_get_table_addr(s1_vttb, 0, iova);
+        qsmmu_setup_s1_level_with_nested_s2(qts, space, 0, l0_addr,
+                                            all_s2_l0_pte_val, s2_vttb, mode);
+
+        /* Stage 1 Level 1 */
+        l1_addr = qsmmu_get_table_addr(all_s2_l0_pte_val & QSMMU_PTE_MASK,
+                                       1, iova);
+        qsmmu_setup_s1_level_with_nested_s2(qts, space, 1, l1_addr,
+                                            all_s2_l1_pte_val, s2_vttb, mode);
+
+        /* Stage 1 Level 2 */
+        l2_addr = qsmmu_get_table_addr(all_s2_l1_pte_val & QSMMU_PTE_MASK,
+                                       2, iova);
+        qsmmu_setup_s1_level_with_nested_s2(qts, space, 2, l2_addr,
+                                            all_s2_l2_pte_val, s2_vttb, mode);
+
+        /* Stage 1 Level 3 (leaf) */
+        l3_addr = qsmmu_get_table_addr(all_s2_l2_pte_val & QSMMU_PTE_MASK,
+                                       3, iova);
+
+        s1_leaf_pte_val = qsmmu_apply_space_offs(
+            space, QSMMU_L3_PTE_VAL | qsmmu_get_pte_attrs(mode, true, space)
+        );
+
+        qsmmu_setup_s1_level_with_nested_s2(qts, space, 3, l3_addr,
+                                            s1_leaf_pte_val, s2_vttb, mode);
+    } else {
+        /*
+         * For CD address translation, we start directly with the IPA.
+         */
+        s1_leaf_pte_val = iova | qsmmu_get_pte_attrs(QSMMU_TM_NESTED,
+                                                     false, space);
+    }
+
+    /*
+     * Final Stage 2 walk: Translate the result from Stage 1.
+     * - For S1_ONLY: This is skipped in hardware but we set it up for testing
+     * - For S2_ONLY: This is the only walk
+     * - For NESTED: This translates the IPA from S1 to final PA
+     * - For CD address (is_cd=true): This is a table address, use !is_final
+     */
+    qsmmu_setup_s2_walk_for_ipa(qts, space, s1_leaf_pte_val, s2_vttb,
+                                mode, !is_cd);
+
+    /* Calculate and log final translated PA */
+    g_test_message("End of construction: PA=0x%llx ===",
+                   (s1_leaf_pte_val & QSMMU_PTE_MASK) + (iova & 0xfff));
+}
diff --git a/tests/qtest/libqos/qos-smmuv3.h b/tests/qtest/libqos/qos-smmuv3.h
new file mode 100644
index 0000000000..8f1dbfeb10
--- /dev/null
+++ b/tests/qtest/libqos/qos-smmuv3.h
@@ -0,0 +1,267 @@
+/*
+ * QOS SMMUv3 Module
+ *
+ * This module provides SMMUv3-specific helper functions for libqos tests,
+ * encapsulating SMMUv3 setup, assertion, and cleanup operations.
+ *
+ * Copyright (c) 2025 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QTEST_LIBQOS_SMMUV3_H
+#define QTEST_LIBQOS_SMMUV3_H
+
+#include "hw/misc/iommu-testdev.h"
+
+/*
+ * SMMU MMIO register base. We hardcode this as base_memmap is 'static const'
+ * in hw/arm/virt.c and not directly accessible here.
+ */
+#define VIRT_SMMU_BASE            0x0000000009050000ull
+
+/* SMMU queue and table base addresses */
+#define QSMMU_CMDQ_BASE_ADDR      0x000000000e16b000ull
+#define QSMMU_EVENTQ_BASE_ADDR    0x000000000e170000ull
+
+/*
+ * Translation tables and descriptors for a mapping of
+ *   - IOVA(Stage 1 only)
+ *   - IPA (Stage 2 only)
+ * to GPA.
+ *
+ * The translation is based on the Arm architecture with the following
+ * prerequisites:
+ * - Granule size: 4KB pages.
+ * - Page table levels: 4 levels (L0, L1, L2, L3), starting at level 0.
+ * - IOVA size: The walk resolves a IOVA: 0x8080604567
+ * - Address space: The 4-level lookup with 4KB granules supports up to a
+ * 48-bit (256TB) virtual address space. Each level uses a 9-bit index
+ * (512 entries per table). The breakdown is:
+ * - L0 index: IOVA bits [47:39]
+ * - L1 index: IOVA bits [38:30]
+ * - L2 index: IOVA bits [29:21]
+ * - L3 index: IOVA bits [20:12]
+ * - Page offset: IOVA bits [11:0]
+ *
+ * NOTE: All physical addresses defined here (QSMMU_VTTB, table addresses, etc.)
+ * appear to be within a secure RAM region. In practice, an offset is added
+ * to these values to place them in non-secure RAM. For example, when running
+ * in a virt machine type, the RAM base address (e.g., 0x40000000) is added to
+ * these constants.
+ */
+#define QSMMU_IOVA_OR_IPA               0x0000008080604567ull
+#define QSMMU_VTTB                      0x000000000e4d0000ull
+#define QSMMU_STR_TAB_BASE              0x000000000e179000ull
+#define QSMMU_CD_GPA                    (QSMMU_STR_TAB_BASE - 0x40ull)
+
+
+#define QSMMU_L0_PTE_VAL                0x000000000e4d1000ull
+#define QSMMU_L1_PTE_VAL                0x000000000e4d2000ull
+#define QSMMU_L2_PTE_VAL                0x000000000e4d3000ull
+#define QSMMU_L3_PTE_VAL                0x000000000ecba000ull
+
+#define QSMMU_NON_LEAF_PTE_MASK         0x8000000000000003ull
+#define QSMMU_LEAF_PTE_RO_MASK          0x04000000000007e3ull
+#define QSMMU_LEAF_PTE_RW_MASK          0x0400000000000763ull
+#define QSMMU_PTE_MASK                  0x0000fffffffff000ull
+
+/*
+ * Address-space base offsets for test tables.
+ * - Non-Secure uses a fixed offset, keeping internal layout identical.
+ *
+ * Note: Future spaces (e.g. Secure/Realm/Root) are not implemented here.
+ * When needed, introduce new offsets and reuse the helpers below so relative
+ * layout stays identical across spaces.
+ */
+#define QSMMU_SPACE_OFFS_NS             0x0000000040000000ull
+
+typedef enum QSMMUSecSID {
+    QSMMU_SEC_SID_NONSECURE    = 0,
+} QSMMUSecSID;
+
+typedef enum QSMMUSpace {
+    QSMMU_SPACE_NONSECURE      = 1,
+} QSMMUSpace;
+
+typedef enum QSMMUTransMode {
+    QSMMU_TM_S1_ONLY           = 0,
+    QSMMU_TM_S2_ONLY           = 1,
+    QSMMU_TM_NESTED            = 2,
+} QSMMUTransMode;
+
+typedef struct QSMMUTestConfig {
+    QSMMUTransMode trans_mode;        /* Translation mode (S1, S2, Nested) */
+    QSMMUSecSID sec_sid;              /* SEC_SID of test device */
+    uint64_t dma_iova;                /* DMA IOVA address for testing */
+    uint32_t dma_len;                 /* DMA length for testing */
+    uint32_t expected_result;         /* Expected DMA result for validation */
+} QSMMUTestConfig;
+
+typedef struct QSMMUTestContext {
+    QTestState *qts;            /* QTest state handle */
+    QPCIDevice *dev;            /* PCI device handle */
+    QPCIBar bar;                /* PCI BAR for MMIO access */
+    QSMMUTestConfig config;     /* Test configuration */
+    uint64_t smmu_base;         /* SMMU base address */
+    uint32_t trans_status;      /* Translation configuration status */
+    uint32_t dma_result;        /* DMA operation result */
+    uint32_t sid;               /* Stream ID for the test */
+    QSMMUSpace tx_space;        /* Cached transaction space */
+} QSMMUTestContext;
+
+/* Convert SEC_SID to corresponding Security Space */
+QSMMUSpace qsmmu_sec_sid_to_space(QSMMUSecSID sec_sid);
+
+/* Get base offset of the specific Security space */
+uint64_t qsmmu_space_offset(QSMMUSpace sp);
+
+uint32_t qsmmu_build_dma_attrs(QSMMUSpace space);
+
+/*
+ * qsmmu_setup_and_enable_translation - Complete translation setup and enable
+ *
+ * @ctx: Test context containing configuration and device handles
+ *
+ * Returns: Translation status (0 = success, non-zero = error)
+ *
+ * This function performs the complete translation setup sequence:
+ * 1. Builds all required SMMU structures (STE, CD, page tables)
+ * 2. Programs SMMU registers for the appropriate security space
+ * 3. Returns configuration status
+ */
+uint32_t qsmmu_setup_and_enable_translation(QSMMUTestContext *ctx);
+
+/*
+ * qsmmu_build_translation - Build SMMU translation structures
+ *
+ * @qts: QTest state handle
+ * @mode: Translation mode (S1_ONLY, S2_ONLY, NESTED)
+ * @tx_space: Transaction security space
+ * @sid: Stream ID
+ *
+ * Returns: Build status (0 = success, non-zero = error)
+ *
+ * Constructs all necessary SMMU translation structures in guest memory:
+ * - Stream Table Entry (STE) for the given SID
+ * - Context Descriptor (CD) if Stage 1 translation is involved
+ * - Complete page table hierarchy based on translation mode
+ *
+ * The structures are written to security-space-specific memory regions.
+ */
+uint32_t qsmmu_build_translation(QTestState *qts, QSMMUTransMode mode,
+                                 QSMMUSpace tx_space, uint32_t sid);
+
+/*
+ * qsmmu_bank_base - Get SMMU control bank base address
+ *
+ * @base: SMMU base address
+ * @sp: Security space
+ *
+ * Returns: Bank base address for the given security space
+ *
+ * Maps security space to the corresponding SMMU control register bank.
+ * Currently only Non-Secure bank is supported.
+ */
+uint64_t qsmmu_bank_base(uint64_t base, QSMMUSpace sp);
+
+/*
+ * qsmmu_program_bank - Program SMMU control bank registers
+ *
+ * @qts: QTest state handle
+ * @bank_base: SMMU bank base address
+ * @sp: Security space
+ *
+ * Programs a specific SMMU control bank with minimal configuration:
+ * - Global Bypass Attribute (GBPA)
+ * - Control registers (CR0, CR1)
+ * - Command queue (base, producer, consumer)
+ * - Event queue (base, producer, consumer)
+ * - Stream table configuration (base, format)
+ *
+ * Addresses are adjusted based on security space offset.
+ */
+void qsmmu_program_bank(QTestState *qts, uint64_t bank_base, QSMMUSpace sp);
+
+/*
+ * qsmmu_program_regs - Program all required SMMU register banks
+ *
+ * @qts: QTest state handle
+ * @smmu_base: SMMU base address
+ * @space: Target security space
+ *
+ * Programs SMMU registers for the requested security space which is called in
+ * qsmmu_setup_and_enable_translation. Always programs Non-Secure bank first,
+ * then the target space if different.
+ */
+void qsmmu_program_regs(QTestState *qts, uint64_t smmu_base, QSMMUSpace space);
+
+uint32_t qsmmu_trigger_dma(QSMMUTestContext *ctx);
+
+/*
+ * qsmmu_cleanup_translation - Clean up translation configuration
+ *
+ * @ctx: Test context containing configuration and device handles
+ *
+ * Clears all translation structures and invalidates SMMU caches:
+ * - Clears STE and CD entries
+ * - Issues SMMU invalidation commands (CFGI_STE, CFGI_CD, TLBI_NSNH_ALL)
+ */
+void qsmmu_cleanup_translation(QSMMUTestContext *ctx);
+
+/* qsmmu_expected_dma_result - Calculate expected DMA result */
+uint32_t qsmmu_expected_dma_result(QSMMUTestContext *ctx);
+
+/*
+ * qsmmu_validate_test_result - Validate actual VS expected test result
+ *
+ * @ctx: Test context containing actual and expected results
+ *
+ * Returns: true if test passed (actual == expected), false otherwise
+ *
+ * Compares the actual DMA result with the expected result and logs
+ * the comparison for debugging purposes.
+ */
+bool qsmmu_validate_test_result(QSMMUTestContext *ctx);
+
+/*
+ * qsmmu_setup_translation_tables - Setup complete SMMU page table hierarchy
+ *
+ * @qts: QTest state handle
+ * @iova: Input Virtual Address or IPA to translate
+ * @space: Security space (NONSECURE, SECURE, REALM, ROOT)
+ * @is_cd: Whether translating CD address (vs regular IOVA)
+ * @mode: Translation mode (S1_ONLY, S2_ONLY, NESTED)
+ *
+ * This function builds the complete page table structure for translating
+ * the given IOVA through the SMMU. The structure varies based on mode:
+ *
+ * - S1_ONLY: Single Stage 1 walk (IOVA -> PA)
+ * - S2_ONLY: Single Stage 2 walk (IPA -> PA)
+ * - NESTED: Stage 1 walk (IOVA -> IPA) with nested S2 walks for each
+ *   S1 table access, plus final S2 walk for the result IPA
+ *
+ * For nested mode, this creates a complex hierarchy:
+ * - 4 Stage 1 levels (L0-L3), each requiring a 4-level Stage 2 walk
+ * - 1 final Stage 2 walk for the resulting IPA
+ *
+ * The function writes all necessary Page Table Entries (PTEs) to guest
+ * memory using qtest_writeq(), setting up the complete translation path
+ * that the SMMU hardware will traverse during DMA operations.
+ */
+void qsmmu_setup_translation_tables(QTestState *qts,
+                                    uint64_t iova,
+                                    QSMMUSpace space,
+                                    bool is_cd,
+                                    QSMMUTransMode mode);
+
+/* High-level test execution functions */
+void qsmmu_single_translation(QSMMUTestContext *ctx);
+void qsmmu_translation_batch(const QSMMUTestConfig *configs, size_t count,
+                             QTestState *qts, QPCIDevice *dev,
+                             QPCIBar bar, uint64_t smmu_base);
+
+#endif /* QTEST_LIBQOS_SMMUV3_H */
-- 
2.34.1


