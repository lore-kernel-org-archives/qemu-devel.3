Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E74AC531C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 02:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woB54-0006m9-Sz; Sun, 26 Jul 2026 22:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB4z-0006jo-FZ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:28:34 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavien.solt97@gmail.com>)
 id 1woB4w-0001FC-HX
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:28:33 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-92e7c6ec9dbso120760085a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785119309; cv=none;
 d=google.com; s=arc-20260327;
 b=nPtQrew9EBRVO0gPHSo4fRlOvEKx5/oYnO/YCNZ+X7S4dH+hk46uX/LgTb6DRoaQqL
 4tIfCLiHCRT7p6+YaaH0vIXBwnd/5qbsEslrKJ5ReYQ5vnLtWUS6c6789OK0Z+IQP65c
 oIstON5XbbhnfVDwPRGq5VTYRer9+r0Om9eU20yia0cHwKYxwYaznwHg9si5uSAur9yx
 m1xpcSYaO6yVvbetUky/fPVRfDOqVCAJ9WSo0pYq21SmzjqrF3Yh7b4rGOnwrf0/upzw
 b/iiuY47KCXwaUNIkbcQVZTciwLOr81NH++q8jKC8mARA4QH6c2E0TQQPXomnYS1YpDo
 vi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=pCWjQx4w+GCh74OHw0vbTxUBJc1a3hAacXuGwjmTCTM=;
 fh=QaT6lRC5y6lD/gWdSAGuafbdbUY/EiCC08Uj3KsmyVY=;
 b=MHDk1P+WgoAHoEIOs6LdZGzfGMov1y9arbwDf4aCWsJ5eSIcz0WYjIcV6p0rWVqvE2
 /44cNOqafiaN7UdssMYShnZ8mgMYxyvfHw05kCLHjcJPVz/BgmByhM33DIboXtZbfFMr
 jw+hCzzz9lIaWLmA2xUK1rSJPH6y+z3eKM7Is2mmkWJ8CKQwUKmHpRto5hFtxXSRPsC8
 VcVFpce2Xg27nQ68gqesnPbzpakWA/Z0hOf70sI/2BxBNvjlsCb4Vj+lZnYDtl4F2oUu
 B7ZriO4a5KgIzlb45thMQNM9WD2ooUH+57mGVd8CUFiBMWOJW/soljVV0baVXLOfHzDm
 4nqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785119309; x=1785724109; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pCWjQx4w+GCh74OHw0vbTxUBJc1a3hAacXuGwjmTCTM=;
 b=FkNItFfJuIbmDSNtomv+nnzK8RmNlkmOrWFYhzHPKBCi//TncF79fYNldmM/8hHg0j
 q+/OiGeJEUSvy81StCZfwoGWrwra1MDQGpVWoJIqllYe8eqs1WcaFvCYXtGuFmy19bJL
 NXzyz1m7/oWvUuJVTWefm3w1mEkHHjDzR1DkoXIAuBqEwAqqHWDDINfplMex+eWmGMuT
 tGj06n7YuHe7THw2S4ipBVhL9+C8uSm0pdY3oLQOucKuoeOih0zfT7K9OryfEPVimt0w
 M9tMxHKiLUubGomeKKwqEFkIUZdOx4VlsFlAQ/aSJEIie1qCQ5v0BFMO/I3D3cKQ10PH
 RX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785119309; x=1785724109;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pCWjQx4w+GCh74OHw0vbTxUBJc1a3hAacXuGwjmTCTM=;
 b=V6sD95hITdjNeBRj76DKY+N3SkCt7AHx2sWSWx7uT4bfeOBb8RizF+GXZNKldJWlz7
 H0iRUNvFT3JQLDWCysedfCftLKmeLKm5aIdtRzc7V0BOduvq6LeG3JvT3YcHt0meZwim
 Com3t0QMd3rj4m4zzl/mxZ8L93EERx0jZyZxc48Ai/9pudcyOWXE76moUcXTp9nmLeTh
 +V828FNH2miF9tQIZbVwsGMrfcf7z2YLnjLi/gBasTmYv5n75aanGhYDU5XRSzLLenUE
 3GsFQsJMnux91HxlTt2CAfmJ024Y/btL01FTBSyUPbUDg5LAiOciR/EOwR4y8Ij8EZ+V
 sSJw==
X-Gm-Message-State: AOJu0YzpjrQ/sPnemCu0Y/hLVmY6s9mbv6U+/ebubktrdKVmRXSoW8pX
 w7Rv7Kwh6UexvjfeOgfV8/bdK8Dc2YvrJpyBZL05L7tUXuZORDQuK68bQJ6T6RnZZAJOAh/xF5J
 PQ4wYjC4F0UOmdXUhqAm88AAOEw/jQUuMEWGq
X-Gm-Gg: AR+sD10hm6SiKAP1QNsJ8OUzQqgslcinni1YG8zGlyWozVC2++q+S1x51QPtluEpsv3
 5FyssA9BNlYVcR1I8N1atrS277Zzwx5RH4nFvdSwxPFXa23dub2vzabgUlWj1qYDiKeOoFvdhSl
 XOjjt6TkrXRj3FUYHEJRDocSiBZZ4y/sjG0No3EdLHmDJXLR/ndBej4A+jFBp3RTWZVKezrRhN6
 zVQ01PxDd2DFiS9vh5N5JqjGejeOH6eGv6XQ8VjFVooSIM7QAWjV83/sxz7GkCWzHA83IgvQIOf
 vPdYeU1/TnaFiUfB
X-Received: by 2002:a05:620a:2702:b0:915:e670:4021 with SMTP id
 af79cd13be357-932df674b87mr630241285a.45.1785119309459; Sun, 26 Jul 2026
 19:28:29 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:28:28 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sun, 26 Jul 2026 19:27:49 -0700
MIME-Version: 1.0
From: flavien.solt97@gmail.com
In-Reply-To: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
Date: Sun, 26 Jul 2026 19:28:27 -0700
X-Gm-Features: AUfX_myA_9jgBJBZxGX_lRGMecf5ODMY1MrrSUNqkYVNZCF3gw2Rvjzd0UNMh2s
Message-ID: <CANVUYGsmXiKSQdb_BjCVPo1dvmF0K5-B63iQpszqqYLhZsc_Zg@mail.gmail.com>
Subject: [PATCH v3 3/3] tests/qtest: add RISC-V IOMMU MRIF notice tests
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=flavien.solt97@gmail.com; helo=mail-qk1-x729.google.com
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

From a13bfa64b84ac70c9e257253616ce650fc3e794b Mon Sep 17 00:00:00 2001
From: Flavien Solt <flavien.solt97@gmail.com>
Date: Sun, 26 Jul 2026 17:54:04 +0800
Subject: [PATCH v3 3/3] tests/qtest: add RISC-V IOMMU MRIF notice tests

Exercise MRIF-mode MSI writes through iommu-testdev with the destination
interrupt-enable bit both clear and set. Each case requires the pending
bit to be stored plus the configured notice ID to reach guest memory.

The enable-clear case regresses the notice suppression fixed by the
previous patch. The enable-set case provides a control for the existing
path.

Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
---
 tests/qtest/iommu-riscv-test.c | 102 +++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
index 2638024..85f79ea 100644
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

