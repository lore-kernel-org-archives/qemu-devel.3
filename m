Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0356ECA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9EL-0004iP-KE; Fri, 09 Oct 2026 07:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EH-0004gE-5A
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:38 -0400
Received: from out-54.mta0.migadu.com ([2001:41d0:1004:224b::36]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EF-0001WD-4I
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:36 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=OQQZ3ApuUEa7T2Q/cseY5Hv6MGtqtA7RpvRazwRx+M0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791547052; v=1; x=1792151852;
 b=pEmljV9DUOiFFVUoZl7QT3ebS4dXKIkoeJx2akEPRqG+3yA6W0c4zH1yFbZ5mDE1ThFMXZWp
 yhLfVDo3I5fLKESE/t7GElCPA7lLIHESh6T8rlfoDoTY6A9IUXAoagz0B/zWchpYsyhvLs/ErRQ
 ekO6/ql7RvXZxHdNlKqFCpI8=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 16b2cbb997a424a7;
 Fri, 09 Oct 2026 11:57:32 +0000
X-Mizu-Trace-ID: 16b2cbb997a424a7
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gromero@redhat.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>
Subject: [PATCH v3 2/4] tests/tcg/aarch64: Add a test for a two-entry 52-bit
 TTBR table
Date: Fri,  9 Oct 2026 12:57:26 +0100
Message-Id: <20261009115728.1299384-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261009115728.1299384-1-fuad.tabba@linux.dev>
References: <20261009115728.1299384-1-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::36;
 envelope-from=fuad.tabba@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add a test checking that, with a 52-bit OA, TTBR[4] of a two-entry
level 0 table is taken only as base address bit 50, not also as bit 4.

Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tests/tcg/aarch64/system/meson.build  |   6 +
 tests/tcg/aarch64/system/ttbr-baddr.c | 153 ++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)
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
index 0000000000..b29c9e1ab0
--- /dev/null
+++ b/tests/tcg/aarch64/system/ttbr-baddr.c
@@ -0,0 +1,153 @@
+/*
+ * TTBR base address with a 52-bit layout and a small initial lookup table
+ *
+ * With a 52-bit OA, walk a two-entry level 0 table through an IPA with
+ * bit 50 set, which stage 2 maps back onto the table, so the walk
+ * succeeds only if TTBR[4] is cleared from bit 4 of the base address.
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
+/*
+ * kernel.ld links the test at 1GB, so the tables below lie within the
+ * blocks mapped at RAM_BASE.
+ */
+#define RAM_BASE    0x40000000UL
+#define HIGH_IPA    (1UL << 50)
+#define TEST_VA     (0xffff000000000000UL | RAM_BASE)
+
+/*
+ * Stage 1: 16KB granule, 48-bit VA, so level 0 has two entries.
+ * Stage 2: 64KB granule, 52-bit IPA, mapping RAM at its own address and
+ * again at HIGH_IPA.
+ */
+static uint64_t s1_l0[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l1[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l2[2048] __attribute__((aligned(16384)));
+static uint64_t s2_l1[1024] __attribute__((aligned(65536)));
+static uint64_t s2_l2[8192] __attribute__((aligned(65536)));
+static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
+
+#define TCR_T0SZ(x)     ((uint64_t)(x) << 0)
+#define TCR_T1SZ(x)     ((uint64_t)(x) << 16)
+#define TCR_TG0_16K     (2UL << 14)
+#define TCR_TG1_16K     (1UL << 30)
+#define TCR_IPS_52      (6UL << 32)
+#define TCR_DS          (1UL << 59)
+
+#define VTCR_T0SZ(x)    ((uint64_t)(x) << 0)
+#define VTCR_SL0_L1     (2UL << 6)
+#define VTCR_TG0_64K    (1UL << 14)
+#define VTCR_PS_52      (6UL << 16)
+#define VTCR_RES1       (1UL << 31)
+
+#define HCR_VM          (1UL << 0)
+#define HCR_RW          (1UL << 31)
+
+#define PAR_F           (1UL << 0)
+#define PAR_PA(par)     ((par) & 0xfffffffff000UL)
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
+static void setup_tables(void)
+{
+    /* Stage 1: TEST_VA -> RAM_BASE, 32MB block, AF */
+    s1_l0[0] = (uint64_t)s1_l1 | 3;
+    s1_l1[0] = (uint64_t)s1_l2 | 3;
+    s1_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | (1 << 10) | 1;
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
+     * 52-bit OA: TTBR[4] is base address bit 50, so with it set the
+     * level 0 table is at IPA HIGH_IPA | s1_l0. Stage 2 maps that IPA
+     * onto s1_l0 (through s2_l2_high), so the walk succeeds only if
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


