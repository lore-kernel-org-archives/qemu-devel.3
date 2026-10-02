Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71770CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCXQ9-0005av-As; Fri, 02 Oct 2026 03:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xCXOg-00052R-UD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:09:36 -0400
Received: from out-203.mta0.migadu.com ([2001:41d0:1004:224b::cb]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xCXOe-00089c-TT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:09:34 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=+7d3FsfcK7AxA6d/g0hF/bkHk0JlpeVcDLqY9RkHtME=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790924970; v=1; x=1791529770;
 b=Q3Hu/yv0RPlFm/mbLAVgA8mfHEcpoxtJVxGgtav+9KI4Ofusd/CWI3ccnbY02YxpkfSkX4Ec
 9FdhTZUtEpJpj8wNMhb+u6SiCh/+zutc/zN8zhjfJGBtkFfpfvU9EDeOuIs1lLmn5A1NM54q7eH
 TSh1YngpBphDfKtdGXWuRhpM=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id bffb2d0489bb434e;
 Fri, 02 Oct 2026 07:09:30 +0000
X-Mizu-Trace-ID: bffb2d0489bb434e
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Will Deacon <will@kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 Fuad Tabba <tabba@google.com>
Subject: [PATCH 2/2] target/arm: Use the 52-bit TTBR base address layout when
 TCR.DS is set
Date: Fri,  2 Oct 2026 08:09:20 +0100
Message-Id: <20261002070925.2627344-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001175003.ttbr-baddr-52bit-0-fuad.tabba@linux.dev>
References: <20261001175003.ttbr-baddr-52bit-0-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::cb;
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

With TCR.DS set, TTBR[5:2] hold bits [51:48] of the translation table
base address, whatever the OA size. If the effective OA size is below
52 bits, setting any of them is a level 0 Address size fault
(AArch64_S1TTBaseAddress(), AArch64_S1Walk()).

get_phys_addr_lpae() uses the 52-bit layout only when the OA size is
over 48 bits. With TCR.DS set and an IPS of 48 bits, it takes TTBR[5:2]
as base address bits [5:2] instead. A guest that sets them gets no
fault: the walk either succeeds with TTBR[5:2] ignored, or reads its
first descriptor from the wrong address. VTTBR walks with VTCR.DS take
the same path.

Use the 52-bit layout whenever TCR.DS is set, and check the whole base
address against the OA size. Add TCR.DS and VTCR.DS cases with a 48-bit
OA to the test.

Fixes: ef56c2425e5f ("target/arm: Implement FEAT_LPA2")
Cc: qemu-stable@nongnu.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 target/arm/ptw.c                      | 16 ++++----
 tests/tcg/aarch64/system/ttbr-baddr.c | 53 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6cff52d592..16f5fdfe0b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2107,18 +2107,18 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr = extract64(ttbr, 0, 48);
 
     /*
-     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), bits [51:48] of descaddr are
-     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: a table
-     * under 64 bytes is still 64-byte aligned (R_KBLCR).
+     * With a 52-bit OA, or with TCR.DS, bits [51:48] of the base address are
+     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: the
+     * table is at least 64-byte aligned.
      *
-     * Otherwise, if the base address is out of range, raise AddressSizeFault.
-     * In the pseudocode, this is !IsZero(baseregister<47:outputsize>),
-     * but we've just cleared the bits above 47, so simplify the test.
+     * If the base address is out of range, raise AddressSizeFault, as
+     * AArch64_OAOutOfRange() does in the pseudocode.
      */
-    if (outputsize > 48) {
+    if (outputsize > 48 || param.ds) {
         descaddr &= ~MAKE_64BIT_MASK(0, 6);
         descaddr |= extract64(ttbr, 2, 4) << 48;
-    } else if (descaddr >> outputsize) {
+    }
+    if (descaddr >> outputsize) {
         level = 0;
         fi->type = ARMFault_AddressSize;
         goto do_fault;
diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c
index 7360684268..6a15c55fae 100644
--- a/tests/tcg/aarch64/system/ttbr-baddr.c
+++ b/tests/tcg/aarch64/system/ttbr-baddr.c
@@ -34,10 +34,13 @@
  * Stage 1: 16KB granule, 48-bit VA, so level 0 has two entries.
  * Stage 2: 64KB granule, 52-bit IPA, mapping RAM at its own address and
  * again at HIGH_IPA.
+ * Stage 2 with VTCR.DS: 16KB granule, 47-bit IPA, mapping RAM flat.
  */
 static uint64_t s1_l0[2048] __attribute__((aligned(16384)));
 static uint64_t s1_l1[2048] __attribute__((aligned(16384)));
 static uint64_t s1_l2[2048] __attribute__((aligned(16384)));
+static uint64_t s2ds_l1[2048] __attribute__((aligned(16384)));
+static uint64_t s2ds_l2[2048] __attribute__((aligned(16384)));
 static uint64_t s2_l1[1024] __attribute__((aligned(65536)));
 static uint64_t s2_l2[8192] __attribute__((aligned(65536)));
 static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
@@ -46,20 +49,27 @@ static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
 #define TCR_T1SZ(x)     ((uint64_t)(x) << 16)
 #define TCR_TG0_16K     (2UL << 14)
 #define TCR_TG1_16K     (1UL << 30)
+#define TCR_IPS_48      (5UL << 32)
 #define TCR_IPS_52      (6UL << 32)
 #define TCR_DS          (1UL << 59)
 
 #define VTCR_T0SZ(x)    ((uint64_t)(x) << 0)
 #define VTCR_SL0_L1     (2UL << 6)
+#define VTCR_TG0_16K    (2UL << 14)
 #define VTCR_TG0_64K    (1UL << 14)
+#define VTCR_PS_48      (5UL << 16)
 #define VTCR_PS_52      (6UL << 16)
 #define VTCR_RES1       (1UL << 31)
+#define VTCR_DS         (1UL << 32)
 
 #define HCR_VM          (1UL << 0)
 #define HCR_RW          (1UL << 31)
 
 #define PAR_F           (1UL << 0)
+#define PAR_FST(par)    (((par) >> 1) & 0x3f)
 #define PAR_PA(par)     ((par) & 0xfffffffff000UL)
+#define FST_ADDR_SIZE_L0    0x00
+
 #define S2_BLOCK        ((1 << 10) | (3 << 6) | (0xf << 2) | 1)
 
 static void tlb_flush(void)
@@ -78,6 +88,17 @@ static uint64_t at(uint64_t ttbr1)
     return par;
 }
 
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
 static void setup_tables(void)
 {
     /* Stage 1: TEST_VA -> RAM_BASE, 32MB block, AF */
@@ -85,6 +106,10 @@ static void setup_tables(void)
     s1_l1[0] = (uint64_t)s1_l2 | 3;
     s1_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | (1 << 10) | 1;
 
+    /* Stage 2 with VTCR.DS: RAM_BASE -> RAM_BASE, 32MB block, AF, RW */
+    s2ds_l1[0] = (uint64_t)s2ds_l2 | 3;
+    s2ds_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | S2_BLOCK;
+
     /* Stage 2: 512MB blocks at RAM_BASE and HIGH_IPA | RAM_BASE, AF, RW */
     s2_l1[0] = (uint64_t)s2_l2 | 3;
     s2_l1[HIGH_IPA >> 42] = (uint64_t)s2_l2_high | 3;
@@ -100,6 +125,15 @@ static int check(const char *name, uint64_t par)
     return !ok;
 }
 
+/* A level 0 Address size fault */
+static int check_fault(const char *name, uint64_t par)
+{
+    int ok = (par & PAR_F) && PAR_FST(par) == FST_ADDR_SIZE_L0;
+
+    ml_printf("%s: PAR_EL1=%lx %s\n", name, par, ok ? "ok" : "FAIL");
+    return !ok;
+}
+
 int main(void)
 {
     uint64_t mmfr0 = read_sysreg(id_aa64mmfr0_el1);
@@ -124,6 +158,25 @@ int main(void)
     write_sysreg(mair_el1, 0xff);
     write_sysreg(sctlr_el1, read_sysreg(sctlr_el1) | 1);
 
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
     /*
      * 52-bit OA: TTBR[4] is base address bit 50. Through stage 2, the
      * table at HIGH_IPA | s1_l0 is s1_l0, so the walk succeeds only if
-- 
2.39.5


