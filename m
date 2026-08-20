Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBE0C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjB-0000hL-Hj; Wed, 19 Aug 2026 23:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtj8-0000dt-HW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:02 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtj6-00041B-Jg
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:02 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1771911a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197559; x=1787802359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bmY41LJV136WTAQr9mDvHt6oN81a2s5d+AHK4tbcUfQ=;
 b=ix0TtYS+yZ+ecC5xmRqtuxcQbpNJhr6EM0FGEPqssM9Di9iTqFRK4cmHeU2ueqooc+
 TOzGtOzcl0laXP5qZOPLj0zis+TK6lpQpHOUeBBXbDTlf99Gt5gc5B+PRoxVwxu1THwq
 22Lwmv0p038dnvIVOp0FsdroOuxZDOIdLt7JKAPmwjrvKAJSbXOi8XjOdMGNZLxItRrL
 asLbHPwQ5ShyglwmZlaUyqiDh1kDGQJVxyauqBx/N3dtt7KDrU9BV2lnOzS6XaDg7zmG
 VzjqIgmrT/bcyc/IBZnw2S3JWu/oCxP0M4XhpGoBob4oFZsJjlXSouvHBhrtGURSHlXC
 7B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197559; x=1787802359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bmY41LJV136WTAQr9mDvHt6oN81a2s5d+AHK4tbcUfQ=;
 b=gYpITM7KiPEajTgkbTKqCmTYJNTE32sa+36/1y7w65HItzsoooCZwfbM0x8YNnTJcN
 pGQ9Jh5/aRLR/9ZawQ2BEmvIPpG7NAbDfw4JP4bLdMbrvJo42bycsFAERVbABNOvKbnx
 twFfHfh1KepruNkL9eLUtjsGD3d3ectApADR5dMhFBWb3zcs59rvfN9DrsDTe1XwKiQI
 UKChpekUlT0XQv/Kpm481mSCooch4FOodkQwiQeGeAlnUgc2XB8p6xhRcNqm7SMesJvT
 XzkCByJSLVPFDV8QUGWYl3wuuB5cDOwc0jucaJMctW1Z6HRAAvONSE4OdlxRiWsfTbbh
 JO7w==
X-Gm-Message-State: AFuF++mNG8sz/XsN9IRxJkYlaYLGvDpoyeSJtoB9EU90COTNwA7MVykQ
 lXMeCraU1vTPL1tHvM4L9BZU8xp+5ufmQ9g/maJ67V0krLWwecUkNP1ELaiSzQ==
X-Gm-Gg: AR+sD12t8TQZ/EHW70Dj9uYTBjQT3Uj6uTfsEofCrtsVGgOI6A/kUtOJgLNlLiQpVIa
 JI4sQfJgx8gsZdzp0pMvwI9jAOVlv7IbYVkAkcnKAGBJhEtSWODJLkKqpKC7TCELw48qG6KihGB
 D5sk1rrKOvV70HnmdEGNBw8SQ6FX3Rpn61U9YSQl20fqwTNfYqmhWWDCeSVkP5xEG+2dQ3kNE7G
 vJcjF9sP4sX598Z/Py+PSyUQxcE8uWWRtfsCGneFY1mMlo292/8uFqzHOsPaJpWruxtskN3Euco
 MFRzTNM6tMMKIj6nwCkEnQOw+7F5xXBHI8hJVFV3s4yjW91SmvT14jTV6gSO+QyvBEF47EuPFXU
 6jgt8F5V6C9aqkkntEyVNLy02wsmt7TNdUpANB79o4Yq7IRr0MH9jO1QXzLfE1M3wcQ8E24LHaR
 J3DLU0/sAtLKmm1FCTMtEdGpIeAzY8nOjzxJQMt0qDvAYfIKxM+i56AW13+xsYMHePbIaTGvoQx
 F+Ogw==
X-Received: by 2002:a17:90b:1f8f:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-39580840520mr19089238a91.1.1787197559259; 
 Wed, 19 Aug 2026 20:45:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Flavien Solt <flavien.solt97@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/93] tests/qtest: add RISC-V IOMMU MRIF notice tests
Date: Thu, 20 Aug 2026 13:43:22 +1000
Message-ID: <20260820034430.1186695-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Flavien Solt <flavien.solt97@gmail.com>

Exercise MRIF-mode MSI writes through iommu-testdev with the destination
interrupt-enable bit both clear and set. Each case requires the pending
bit to be stored plus the configured notice ID to reach guest memory.

The enable-clear case regresses the notice suppression fixed by the
previous patch. The enable-set case provides a control for the existing
path.

Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260727-qemu-mrif-v4-v4-3-73e0890ad395@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/iommu-riscv-test.c | 102 +++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
index 2638024891..85f79ea9cc 100644
--- a/tests/qtest/iommu-riscv-test.c
+++ b/tests/qtest/iommu-riscv-test.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci_regs.h"
 #include "hw/misc/iommu-testdev.h"
 #include "hw/riscv/riscv-iommu-bits.h"
+#include "libqos/qos-iommu-testdev.h"
 #include "libqos/qos-riscv-iommu.h"
 #include "libqos/riscv-iommu.h"
 
@@ -26,6 +27,13 @@
 #define RISCV_BUS_MMIO_LIMIT       0x80000000
 #define RISCV_ECAM_ALLOC_PTR       0x30000000
 
+#define RISCV_MRIF_MSI_IOVA        0x00000000fee00000ull
+#define RISCV_MRIF_MSI_PT_GPA      (QRIOMMU_SPACE_OFFS + 0x00030000ull)
+#define RISCV_MRIF_BASE_GPA        (QRIOMMU_SPACE_OFFS + 0x00031000ull)
+#define RISCV_MRIF_NOTICE_GPA      (QRIOMMU_SPACE_OFFS + 0x00032000ull)
+#define RISCV_MRIF_INTID           5u
+#define RISCV_MRIF_NOTICE_ID       0x12du
+
 typedef struct RiscvIommuTestState {
     QTestState *qts;
     QGenericPCIBus gbus;
@@ -264,6 +272,96 @@ static void test_riscv_iommu_nested(void)
     run_riscv_iommu_translation(&cfg);
 }
 
+static void riscv_iommu_setup_mrif_context(RiscvIommuTestState *state)
+{
+    uint64_t dc_addr;
+    uint64_t msiptp;
+    uint64_t pte0;
+    uint64_t pte1;
+
+    qtest_memset(state->qts, QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE, 0,
+                 0x1000);
+    qtest_memset(state->qts, RISCV_MRIF_MSI_PT_GPA, 0, 0x1000);
+    qtest_memset(state->qts, RISCV_MRIF_BASE_GPA, 0, 0x1000);
+    qtest_memset(state->qts, RISCV_MRIF_NOTICE_GPA, 0, 4);
+
+    dc_addr = QRIOMMU_SPACE_OFFS + QRIOMMU_DDT_BASE +
+              state->testdev->devfn * sizeof(struct riscv_iommu_dc);
+
+    msiptp = (RISCV_MRIF_MSI_PT_GPA >> 12) |
+             ((uint64_t)RISCV_IOMMU_DC_MSIPTP_MODE_FLAT << 60);
+
+    qtest_writeq(state->qts, dc_addr + 0, RISCV_IOMMU_DC_TC_V);
+    qtest_writeq(state->qts, dc_addr + 8, 0);
+    qtest_writeq(state->qts, dc_addr + 16, 0);
+    qtest_writeq(state->qts, dc_addr + 24, 0);
+    qtest_writeq(state->qts, dc_addr + 32, msiptp);
+    qtest_writeq(state->qts, dc_addr + 40, 0);
+    qtest_writeq(state->qts, dc_addr + 48, RISCV_MRIF_MSI_IOVA >> 12);
+    qtest_writeq(state->qts, dc_addr + 56, 0);
+
+    pte0 = RISCV_IOMMU_MSI_PTE_V |
+           ((uint64_t)RISCV_IOMMU_MSI_PTE_M_MRIF << 1) |
+           ((RISCV_MRIF_BASE_GPA >> 9) << 7);
+    pte1 = ((RISCV_MRIF_NOTICE_GPA >> 12) << 10) | RISCV_MRIF_NOTICE_ID;
+
+    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA, pte0);
+    qtest_writeq(state->qts, RISCV_MRIF_MSI_PT_GPA + 8, pte1);
+
+    qriommu_program_regs(state->qts, state->iommu_base);
+}
+
+static void run_riscv_iommu_mrif_notice(bool enable_bit)
+{
+    RiscvIommuTestState state = { 0 };
+    uint64_t pending;
+    uint64_t enabled;
+    uint32_t notice;
+    uint32_t dma_result;
+
+    if (!riscv_iommu_test_setup(&state)) {
+        return;
+    }
+
+    riscv_iommu_check(state.qts, state.iommu_base, QRIOMMU_TM_BARE);
+    riscv_iommu_setup_mrif_context(&state);
+
+    enabled = enable_bit ? (1ull << RISCV_MRIF_INTID) : 0;
+    qtest_writeq(state.qts, RISCV_MRIF_BASE_GPA + 8, enabled);
+    qpci_io_writel(state.testdev, state.testdev_bar, ITD_REG_DMA_WRITE_VAL,
+                   RISCV_MRIF_INTID);
+
+    dma_result = qos_iommu_testdev_trigger_dma(
+        state.testdev, state.testdev_bar, RISCV_MRIF_MSI_IOVA,
+        RISCV_MRIF_NOTICE_GPA, DMA_LEN, qriommu_build_dma_attrs());
+
+    pending = qtest_readq(state.qts, RISCV_MRIF_BASE_GPA);
+    notice = qtest_readl(state.qts, RISCV_MRIF_NOTICE_GPA);
+
+    g_test_message("MRIF notice: enable=%u pending=0x%" PRIx64
+                   " notice=0x%x", enable_bit, pending, notice);
+
+    /*
+     * Interrupt remapping consumes the original DMA write; the generic
+     * test device cannot read it back from the supplied physical address.
+     */
+    g_assert_cmpuint(dma_result, ==, ITD_DMA_ERR_MISMATCH);
+    g_assert_cmpuint(pending & (1ull << RISCV_MRIF_INTID), !=, 0);
+    g_assert_cmpuint(notice, ==, RISCV_MRIF_NOTICE_ID);
+
+    riscv_iommu_test_teardown(&state);
+}
+
+static void test_riscv_iommu_mrif_notice_enable_clear(void)
+{
+    run_riscv_iommu_mrif_notice(false);
+}
+
+static void test_riscv_iommu_mrif_notice_enable_set(void)
+{
+    run_riscv_iommu_mrif_notice(true);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -275,5 +373,9 @@ int main(int argc, char **argv)
                    test_riscv_iommu_g_stage_only);
     qtest_add_func("/iommu-testdev/translation/ns-nested",
                    test_riscv_iommu_nested);
+    qtest_add_func("/iommu-testdev/mrif-notice/enable-clear",
+                   test_riscv_iommu_mrif_notice_enable_clear);
+    qtest_add_func("/iommu-testdev/mrif-notice/enable-set",
+                   test_riscv_iommu_mrif_notice_enable_set);
     return g_test_run();
 }
-- 
2.54.0


