Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30A1CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtI-0003nR-2h; Thu, 15 Oct 2026 14:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtE-0003mT-1J
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtB-00010r-Dg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso40217865e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087752; x=1792692552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9nPNao+8x8XrdLz6UNCPSRRQ5rQmCuLAuqzCi5g7l+M=;
 b=gUDl4ACb8gnPzakxgGwSFcTknvchXF0111882FN+DUScDaqMFp5uYMggsvDaOm5vPl
 SplZlZjcgZW6EcRfwPGr9CgKcY31whJEpNDFMhxScUGI1bmkmTd0VyygrrQw9S3KbHcy
 WNQMsfmnhJoYGZoeLnoigBSlKee4KO4HkI+tHO/mHh/MTeCHY2582veq+8IEpKcI7M61
 T5zEW3MDM4ba/DWpdpAzshV1jm0Fk/SUlW+Z1UbOYhrpHHC1vPDcZoR0MEciXToOE1f7
 yTOQLqSzHHvOCkQ34QvMkWHv1d//3BSRCtlpaE66KSBNPUiKJN64Xq17SVHpeyuM2KP+
 XqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087752; x=1792692552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9nPNao+8x8XrdLz6UNCPSRRQ5rQmCuLAuqzCi5g7l+M=;
 b=qwppqXdAFVyiqBgx97AiWMSRoA44R9UQg4BfKOTvoLHw9do/Dq7+TsA8kFaDp+s1Fc
 S+wNPlerjAOQrkgkXB33GKK0OfI4ulo54O0rH7/hrQA2kt9LVNhF+KC5VPmTptY12bYM
 RKjAec7trAu5rrh7irx2DstEE56vobI8CpUMrAaLs8ZBnjAtjhsf3YPGFaMt3g3GHa4n
 eDMTD+VNcTKm+YsdMmmJPv41m+Ig+7X5aTOuLHMXD31cg5DqM4xwEnhtVS2YSWpwDjA4
 Eg3YUzhvS8uwkaBEy4Bijf83q6NnFHZ8o4P/7axl+mCneWd6frU033IQic0Mx1VUsbvZ
 Mbfg==
X-Gm-Message-State: AFq9FYJdvFni1XDrQumjULCrYkyFUW/lc0YL7ddFoTnEKyzoOYcQgR8W
 kZ9yLA4E9jfkXmW/U5Ibo+ZAWnKa2VZt5JXHCND5VtrTUwenLyZKewPmCrBP4ikKe0N+yTndaDX
 MaYgY4Cg=
X-Gm-Gg: AYBFou2k2KXMf4ZrA/Hp2ESaYY5UXm1Y87su2HQRoP4LR1jlScYZ4ZsCDQm56FRXMz8
 /nNCxyGPWYxRkp6Po3GfEw7pizo2LyEyxBN3eOrn5wXBx1U/N/FN8uVgLa518dXYMWPOZZd5h23
 blykCrF1QiGfJX3/77UhODkOhjZR1MNM9ziTRZsjXBlM5AzLCupZRufwuGk5bAOFTD4F0BW55/5
 pFRl6BxJPba+hjmdVMDHpo8yAyx+NpE71PwClTgEQGIqdj5Ohz1fGwasTztZNtuX2WnUsHm5+ty
 36xa02gcd3DDG+dIj3HUbQxqQGlOoMEkc8J55KZAGxeN35zf/QmrCoddSRRH9UwQBVzSg5XiDbH
 /qjMHBo4dLVcfPCDQw9RS2EENgz+TG1VmC4491S/ciktpOacOe/hm7ud5s66XSm7B16u244C2kK
 TJMjnfjOSH4/w/7J4R13WL2PdmxtwDj/gsXD7gw1DafLHb5yV8X1S+isTT9P3+ESfa6R8dkIKCw
 dSDTRiU7fgX090ZxfPpxR6AdfoOEULmUB9dI8fmHCRGTI8WRI6c5O9vFhZHjhllFKwGeDuBC+aq
 iGA=
X-Received: by 2002:a05:600d:82e4:b0:4a1:a45a:88f with SMTP id
 5b1f17b1804b1-4a1a45a08f7mr259403205e9.20.1792087751974; 
 Thu, 15 Oct 2026 11:09:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] tests/tcg/aarch64: Test the TTBR layout with TCR.DS and
 a 48-bit OA
Date: Thu, 15 Oct 2026 19:08:50 +0100
Message-ID: <20261015180858.1863407-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
---
 tests/tcg/aarch64/system/ttbr-baddr.c | 55 +++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c
index b29c9e1ab0b..20a240410d1 100644
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
2.43.0


