Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D694ECCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB6t-0000sx-O9; Sat, 17 Oct 2026 16:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5V-0005VH-Go; Sat, 17 Oct 2026 16:33:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5S-0004be-Jw; Sat, 17 Oct 2026 16:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268891; bh=FXzr5fLZUvw+pZqQK2VFOPfwNcrD8X1apSacBXHdOXI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gtbXGoR9+8clWQtcOpLLz/H4W1qVV/RKKN7WYOYTCTlQMSrKdiUL3lcYN7OdgW/U6
 T8999Ts3KO78NB1ziT1DzXegFNVAgx7T5wX0uDYgaDuEQMHNfn9Cj244WvLTA9M+Pn
 QRRIXc0pCPg0MwpY6vmBc1oRZsSJqq9jxmQTUa8+eiafvFMuzTSoRd8Ng+v1BNRwJ7
 IkwY1QjUCL0BJ+1VNhxu9Tl2GPiquHKheTUAXOs0jf43KPF1KGmCcRpzEaZKd43dzr
 gWq/MNTnlMpyAue0OahEOP8bYha3asVTs9raJliPWGH9JKqjuUsmDIjb/ICy01n359
 CuqRgUlPLrwQQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0BCD81DE77C;
 Sat, 17 Oct 2026 23:28:11 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 069D244344F;
 Sat, 17 Oct 2026 23:28:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Gustavo Romero <gromero@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 61/73] tests/tcg/aarch64: Test the TTBR layout with
 TCR.DS and a 48-bit OA
Date: Sat, 17 Oct 2026 23:26:19 +0300
Message-ID: <20261017202638.728621-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Fuad Tabba <fuad.tabba@linux.dev>

Extend the TTBR base address test to check that, with TCR.DS or VTCR.DS
and a 48-bit OA, setting TTBR[5:2] is a level 0 Address size fault.

Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261009115728.1299384-5-fuad.tabba@linux.dev
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2579771a28a200cba27d843fbda549def09f421d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c
index b29c9e1ab0..20a240410d 100644
--- a/tests/tcg/aarch64/system/ttbr-baddr.c
+++ b/tests/tcg/aarch64/system/ttbr-baddr.c
@@ -4,6 +4,8 @@
  * With a 52-bit OA, walk a two-entry level 0 table through an IPA with
  * bit 50 set, which stage 2 maps back onto the table, so the walk
  * succeeds only if TTBR[4] is cleared from bit 4 of the base address.
+ * With TCR.DS or VTCR.DS and a 48-bit OA, check that setting TTBR[5:2]
+ * is a level 0 Address size fault.
  *
  * Copyright (c) 2026 Google LLC
  * Author: Fuad Tabba <fuad.tabba@linux.dev>
@@ -42,10 +44,13 @@
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
@@ -54,20 +59,27 @@ static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
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
@@ -86,6 +98,17 @@ static uint64_t at(uint64_t ttbr1)
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
@@ -93,6 +116,10 @@ static void setup_tables(void)
     s1_l1[0] = (uint64_t)s1_l2 | 3;
     s1_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | (1 << 10) | 1;
 
+    /* Stage 2 with VTCR.DS: RAM_BASE -> RAM_BASE, 32MB block, AF, RW */
+    s2ds_l1[0] = (uint64_t)s2ds_l2 | 3;
+    s2ds_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | S2_BLOCK;
+
     /* Stage 2: 512MB blocks at RAM_BASE and HIGH_IPA | RAM_BASE, AF, RW */
     s2_l1[0] = (uint64_t)s2_l2 | 3;
     s2_l1[HIGH_IPA >> 42] = (uint64_t)s2_l2_high | 3;
@@ -108,6 +135,15 @@ static int check(const char *name, uint64_t par)
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
@@ -135,6 +171,25 @@ int main(void)
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
      * 52-bit OA: TTBR[4] is base address bit 50, so with it set the
      * level 0 table is at IPA HIGH_IPA | s1_l0. Stage 2 maps that IPA
-- 
2.47.3


