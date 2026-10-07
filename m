Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95F4CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENcA-0001zV-6W; Wed, 07 Oct 2026 05:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEMaG-0004Ry-Rd
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:01:05 -0400
Received: from out-73.mta1.migadu.com ([2001:41d0:203:375::49]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xEMaC-00030S-Er
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:01:03 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=fFxHzIV0eSnU5WJN8HLRv0Vr1WaPMW5vaKA+HJab+a0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791360058; v=1; x=1791964858;
 b=cszTm6U1SepiexY7qZFWBzvMJJJeN7i5jY4CAZaFqUObYPHhZEmPJYEeZ2qQ8G8uT2Q7pFhE
 7Sw3wJF06fRR7eOyqv1iVuLRR7lXikYsnhJtf4tifk2qawZGpqeziSbI78POdjsDHEM3gttJ9yt
 tMGj2LmHrEDdSvHc6CWJKfWI=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id d7bdcd0e766fb0df;
 Wed, 07 Oct 2026 08:00:58 +0000
X-Mizu-Trace-ID: d7bdcd0e766fb0df
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gromero@redhat.com>, Will Deacon <will@kernel.org>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Fuad Tabba <tabba@google.com>
Subject: [PATCH v2 3/3] tests/tcg/aarch64: Add a test for the 52-bit TTBR base
 address layout
Date: Wed,  7 Oct 2026 09:00:19 +0100
Message-Id: <20261007080019.350315-4-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261007080019.350315-1-fuad.tabba@linux.dev>
References: <20261007080019.350315-1-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::49;
 envelope-from=fuad.tabba@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

With a 52-bit OA, walk a two-entry level 0 table through an IPA with
bit 50 set, which stage 2 maps back onto the table, so the walk
succeeds only if TTBR[4] is cleared from bit 4 of the base address.
With TCR.DS or VTCR.DS and a 48-bit OA, check that setting TTBR[5:2]
is a level 0 Address size fault.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tests/tcg/aarch64/system/meson.build  |   6 +
 tests/tcg/aarch64/system/ttbr-baddr.c | 197 ++++++++++++++++++++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/ttbr-baddr.c

diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index f51feb253f..270d4d6c31 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -79,6 +79,12 @@ tests += {
                   '-semihosting-config', 'enable=on,arg=2',
                   qemu_base_args]
   },
+  'ttbr-baddr.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on', '-cpu', 'max',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
 }
 
 tests += {
diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c
new file mode 100644
index 0000000000..b36c14aa29
--- /dev/null
+++ b/tests/tcg/aarch64/system/ttbr-baddr.c
@@ -0,0 +1,197 @@
+/*
+ * TTBR base address with a 52-bit layout and a small initial lookup table
+ *
+ * Copyright (c) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+/* from Linux's include/linux/stringify.h */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+#define RAM_BASE    0x40000000UL
+#define HIGH_IPA    (1UL << 50)
+#define TEST_VA     (0xffff000000000000UL | RAM_BASE)
+
+/*
+ * Stage 1: 16KB granule, 48-bit VA, so level 0 has two entries.
+ * Stage 2: 64KB granule, 52-bit IPA, mapping RAM at its own address and
+ * again at HIGH_IPA.
+ * Stage 2 with VTCR.DS: 16KB granule, 47-bit IPA, mapping RAM flat.
+ */
+static uint64_t s1_l0[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l1[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l2[2048] __attribute__((aligned(16384)));
+static uint64_t s2ds_l1[2048] __attribute__((aligned(16384)));
+static uint64_t s2ds_l2[2048] __attribute__((aligned(16384)));
+static uint64_t s2_l1[1024] __attribute__((aligned(65536)));
+static uint64_t s2_l2[8192] __attribute__((aligned(65536)));
+static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
+
+#define TCR_T0SZ(x)     ((uint64_t)(x) << 0)
+#define TCR_T1SZ(x)     ((uint64_t)(x) << 16)
+#define TCR_TG0_16K     (2UL << 14)
+#define TCR_TG1_16K     (1UL << 30)
+#define TCR_IPS_48      (5UL << 32)
+#define TCR_IPS_52      (6UL << 32)
+#define TCR_DS          (1UL << 59)
+
+#define VTCR_T0SZ(x)    ((uint64_t)(x) << 0)
+#define VTCR_SL0_L1     (2UL << 6)
+#define VTCR_TG0_16K    (2UL << 14)
+#define VTCR_TG0_64K    (1UL << 14)
+#define VTCR_PS_48      (5UL << 16)
+#define VTCR_PS_52      (6UL << 16)
+#define VTCR_RES1       (1UL << 31)
+#define VTCR_DS         (1UL << 32)
+
+#define HCR_VM          (1UL << 0)
+#define HCR_RW          (1UL << 31)
+
+#define PAR_F           (1UL << 0)
+#define PAR_FST(par)    (((par) >> 1) & 0x3f)
+#define PAR_PA(par)     ((par) & 0xfffffffff000UL)
+#define FST_ADDR_SIZE_L0    0x00
+
+#define S2_BLOCK        ((1 << 10) | (3 << 6) | (0xf << 2) | 1)
+
+static void tlb_flush(void)
+{
+    asm volatile("dsb sy; tlbi alle1; dsb sy; isb" : : : "memory");
+}
+
+static uint64_t at(uint64_t ttbr1)
+{
+    uint64_t par;
+
+    write_sysreg(ttbr1_el1, ttbr1);
+    tlb_flush();
+    asm volatile("at s12e1r, %1; isb; mrs %0, par_el1"
+                 : "=r" (par) : "r" (TEST_VA));
+    return par;
+}
+
+static uint64_t at_s1(uint64_t ttbr1)
+{
+    uint64_t par;
+
+    write_sysreg(ttbr1_el1, ttbr1);
+    tlb_flush();
+    asm volatile("at s1e1r, %1; isb; mrs %0, par_el1"
+                 : "=r" (par) : "r" (TEST_VA));
+    return par;
+}
+
+static void setup_tables(void)
+{
+    /* Stage 1: TEST_VA -> RAM_BASE, 32MB block, AF */
+    s1_l0[0] = (uint64_t)s1_l1 | 3;
+    s1_l1[0] = (uint64_t)s1_l2 | 3;
+    s1_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | (1 << 10) | 1;
+
+    /* Stage 2 with VTCR.DS: RAM_BASE -> RAM_BASE, 32MB block, AF, RW */
+    s2ds_l1[0] = (uint64_t)s2ds_l2 | 3;
+    s2ds_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | S2_BLOCK;
+
+    /* Stage 2: 512MB blocks at RAM_BASE and HIGH_IPA | RAM_BASE, AF, RW */
+    s2_l1[0] = (uint64_t)s2_l2 | 3;
+    s2_l1[HIGH_IPA >> 42] = (uint64_t)s2_l2_high | 3;
+    s2_l2[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
+    s2_l2_high[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
+}
+
+static int check(const char *name, uint64_t par)
+{
+    int ok = !(par & PAR_F) && PAR_PA(par) == RAM_BASE;
+
+    ml_printf("%s: PAR_EL1=%lx %s\n", name, par, ok ? "ok" : "FAIL");
+    return !ok;
+}
+
+/* A level 0 Address size fault */
+static int check_fault(const char *name, uint64_t par)
+{
+    int ok = (par & PAR_F) && PAR_FST(par) == FST_ADDR_SIZE_L0;
+
+    ml_printf("%s: PAR_EL1=%lx %s\n", name, par, ok ? "ok" : "FAIL");
+    return !ok;
+}
+
+int main(void)
+{
+    uint64_t mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+    uint64_t tcr = TCR_T0SZ(16) | TCR_T1SZ(16) | TCR_TG0_16K | TCR_TG1_16K |
+                   TCR_DS;
+    uint64_t base = (uint64_t)s1_l0;
+    int ret = 0;
+
+    ml_printf("TTBR base address test\n");
+
+    /*
+     * PARange 52 bits (FEAT_LPA) and TGran16 with 52-bit addresses
+     * (FEAT_LPA2)
+     */
+    if ((mmfr0 & 0xf) != 6 || ((mmfr0 >> 20) & 0xf) != 2) {
+        ml_printf("SKIP: no 52-bit PA or no FEAT_LPA2 with 16KB\n");
+        return ret;
+    }
+
+    /*
+     * The test runs at EL2 (arg=2) and walks the EL1&0 regime with AT, so
+     * the EL1 MMU settings below only affect those walks.
+     */
+    setup_tables();
+    write_sysreg(mair_el1, 0xff);
+    write_sysreg(sctlr_el1, read_sysreg(sctlr_el1) | 1);
+
+    /*
+     * TCR.DS with a 48-bit OA: TTBR[5:2] are base address bits [51:48],
+     * so setting any of them is a level 0 Address size fault.
+     */
+    write_sysreg(hcr_el2, HCR_RW);
+    write_sysreg(tcr_el1, tcr | TCR_IPS_48);
+    ret |= check("ips48", at_s1(base));
+    ret |= check_fault("ips48 ttbr[2]", at_s1(base | (1 << 2)));
+    ret |= check_fault("ips48 ttbr[4]", at_s1(base | (1 << 4)));
+
+    /* The same for VTTBR, with VTCR.DS and a 48-bit PS */
+    write_sysreg(vtcr_el2, VTCR_T0SZ(17) | VTCR_SL0_L1 | VTCR_TG0_16K |
+                 VTCR_PS_48 | VTCR_RES1 | VTCR_DS);
+    write_sysreg(hcr_el2, HCR_RW | HCR_VM);
+    write_sysreg(vttbr_el2, (uint64_t)s2ds_l1);
+    ret |= check("ps48", at(base));
+    write_sysreg(vttbr_el2, (uint64_t)s2ds_l1 | (1 << 2));
+    ret |= check_fault("ps48 vttbr[2]", at(base));
+
+    /*
+     * 52-bit OA: TTBR[4] is base address bit 50. Through stage 2, the
+     * table at HIGH_IPA | s1_l0 is s1_l0, so the walk succeeds only if
+     * TTBR[4] does not also offset the two-entry table by 0x10.
+     */
+    write_sysreg(vtcr_el2, VTCR_T0SZ(12) | VTCR_SL0_L1 | VTCR_TG0_64K |
+                 VTCR_PS_52 | VTCR_RES1);
+    write_sysreg(vttbr_el2, (uint64_t)s2_l1);
+    write_sysreg(hcr_el2, HCR_RW | HCR_VM);
+    write_sysreg(tcr_el1, tcr | TCR_IPS_52);
+    ret |= check("ips52", at(base));
+    ret |= check("ips52 ttbr[4]", at(base | (1 << 4)));
+
+    return ret;
+}
-- 
2.39.5


