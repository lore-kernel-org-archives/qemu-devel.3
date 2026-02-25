Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF34FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5e-0004ja-2j; Wed, 25 Feb 2026 18:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5c-0004jC-4a
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5a-0002Zb-Bk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:14:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso3283165e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061280; x=1772666080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=deo9j952hjn8CALNTXXj3DLgNFYLnocA5bqBRKwzs1I=;
 b=tcnggh0q9OuseyRuaTcNFVc9vv3hEH1TVaidmGS8Y+uTzF0Ei0uo+x/J7fHBTsMQXW
 8ySyRp+BqXFN7JsKuRDctr76qEwHUAxMb4WT8L7sPPO7YhyRU8JSEZbEbD2Mi4nHSZlf
 lJYSXGGfO9JYjUiws5YeL0TrNr5LKJnA9rrsUaIEjlntS8xtSyeHzzUzE1iFjsVwOAUx
 Yrf45D0w13BXIYEqVEaaolHk7r+btgfiC8PkLfQVUQIq1lIFt5AsNssYBKUgdlUZ3YXo
 kMpeQAbm6GA7wvv8oAuVeaHvplyUCdMQegCjUGREI/X7mi/YBdjvscMDcaUweym6rJZK
 rudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061280; x=1772666080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=deo9j952hjn8CALNTXXj3DLgNFYLnocA5bqBRKwzs1I=;
 b=fQKHODA5/551bZ5uk9BAX0LmwYnNsH/HCy+12u8DAl5b8ZWAU/2b1sNq4nl9RimONz
 Lm4KurNSeyDeta2IniJxc5sflemH3Ap92hfJV4ZGgIoodQNnsom6N2n2tBNXu7GiEdJj
 EnvQFhf5NBWTibgSzNscWZmY1S3Akm7kgd0mKMsCXux8Lbt/BYUv6Ncof0scpRc52LSc
 ieCZPD68bBLWAUqlde2MlyyGq1KEjaA7gqZQVjHQ3OxDrlLCyUFC1/WPB9yt1VpvTUYz
 ky2QzmQIxwT+DMDOPEAXQbY4jyziwUnUy4PEuJ4UAXPZe7+s3G9z4f37lOsXL7N045/Q
 o3ig==
X-Gm-Message-State: AOJu0YxolwMyJnFPaahCCke8HUPW+W9aGkDGN0jOvLT6aayKfoNdLcrK
 Ie2FZcBXYBjZCEJG+8LHxzjvUUmH+V1NjXom071uuF5RTF7P3dR4vmhUHlmsxIe1VpJrSSQPFPi
 e5pXHA5w=
X-Gm-Gg: ATEYQzzdXvoA5lJQzq9eDqKJ4hhsX69YGx5UPwPEtFuXQABydKZsZARloioxXo7WuD4
 P2M/nmBx5pzceYTc6/dnv/Q/AIK2dzm2iUXvQQgYQhthkwTDng6At2mWuM+Cps1i0MxoezEQpIB
 nZQHelBjcCyqdmfrLDoXjFopW1Am19gBDU+R3DWJzH+J4YPJOn+EaH6kKek7xaoWZxtG69fJBPj
 fGbJ4K+UbR8zBHKF4Vn6HxJAz+uHUc+tylq6jLOCmZNlOJQl1f9gfVa1ks7Gy8B66BTTbE/MAXl
 Ld7EZf6okt54A0sXjI16lXJFk42o7m4OzPGQhIBiwyUmzaD1uY/qWsuEokr1XJkDBzY1ojEKcKZ
 Kj1Er/tgoOVj5tihAuqKOL1oKeXN0V7FYPBvugKDGZ5/PyVM+BLKFNst+S+v8SCxzDQYH+PgvUg
 bFrnMz7Y/f6JK9weVML1z5qngk5WIzWEThZt1UsiCQbm8zdhnz4VzHBeAzPur9qJACMF0jZ8gy
X-Received: by 2002:a05:600d:640f:20b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-483c252de9bmr23781795e9.35.1772061280341; 
 Wed, 25 Feb 2026 15:14:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4cc81sm36348814f8f.26.2026.02.25.15.14.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:14:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/70] target/loongarch: Introduce loongarch_palen_mask()
Date: Thu, 26 Feb 2026 00:13:04 +0100
Message-ID: <20260225231411.96482-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, define a
runtime function to construct a mask from the PALEN cpucfg field.
The mask is then used when converting from virtual to physical
addresses.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260218-phys_addr-v6-4-a603bf363218@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu-mmu.h        |  1 +
 target/loongarch/internals.h      |  1 -
 target/loongarch/cpu_helper.c     | 15 ++++++++++++---
 target/loongarch/tcg/tlb_helper.c | 12 ++++++++----
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 2259de9d36d..3286accc143 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -98,5 +98,6 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+uint64_t loongarch_palen_mask(CPULoongArchState *env);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 8793bd9df65..e01dbed40f6 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -13,7 +13,6 @@
 #define FCMP_UN   0b0100  /* unordered */
 #define FCMP_GT   0b1000  /* fp0 > fp1 */
 
-#define TARGET_PHYS_MASK MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS)
 #define TARGET_VIRT_MASK MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS)
 
 void loongarch_translate_init(void);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 51ad9ff2b46..60441687667 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -147,6 +147,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
 {
     CPUState *cs = env_cpu(env);
     hwaddr index = 0, phys = 0;
+    uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint64_t base, pte;
     int level;
@@ -154,13 +155,14 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
     TLBRet ret;
     MemTxResult ret1;
 
+
     address = context->addr;
     if ((address >> 63) & 0x1) {
         base = env->CSR_PGDH;
     } else {
         base = env->CSR_PGDL;
     }
-    base &= TARGET_PHYS_MASK;
+    base &= palen_mask;
 
     for (level = 4; level >= 0; level--) {
         get_dir_base_width(env, &dir_base, &dir_width, level);
@@ -181,7 +183,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                 break;
             } else {
                 /* Discard high bits with page directory table */
-                base &= TARGET_PHYS_MASK;
+                base &= palen_mask;
             }
         }
     }
@@ -315,7 +317,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     /* Check PG and DA */
     address = context->addr;
     if (da & !pg) {
-        context->physical = address & TARGET_PHYS_MASK;
+        context->physical = address & loongarch_palen_mask(env);
         context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         context->mmu_index = MMU_DA_IDX;
         return TLBRET_MATCH;
@@ -364,3 +366,10 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
     return context.physical;
 }
+
+uint64_t loongarch_palen_mask(CPULoongArchState *env)
+{
+    /* PALEN stores physical address bits - 1 */
+    uint64_t phys_bits = FIELD_EX32(env->cpucfg[1], CPUCFG1, PALEN) + 1;
+    return MAKE_64BIT_MASK(0, phys_bits);
+}
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index b6e9a3a3c7f..c1dc77a8f88 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -692,8 +692,10 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     CPUState *cs = env_cpu(env);
     uint64_t badvaddr;
     hwaddr index, phys;
+    uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
 
+
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Attepted LDDIR with level %u\n", level);
@@ -715,11 +717,11 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     }
 
     badvaddr = env->CSR_TLBRBADV;
-    base = base & TARGET_PHYS_MASK;
+    base = base & palen_mask;
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_le_phys(cs->as, phys) & TARGET_PHYS_MASK;
+    return ldq_le_phys(cs->as, phys) & palen_mask;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -730,9 +732,11 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     uint64_t badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
+    uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
     uint8_t  ps;
 
+
     /*
      * The parameter "base" has only two types,
      * one is the page table base address,
@@ -740,7 +744,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
      * and the other is the huge page entry,
      * whose bit 6 should be 1.
      */
-    base = base & TARGET_PHYS_MASK;
+    base = base & palen_mask;
     if (FIELD_EX64(base, TLBENTRY, HUGE)) {
         /*
          * Gets the huge page level and Gets huge page size.
@@ -781,7 +785,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_le_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        tmp0 = ldq_le_phys(cs->as, phys) & palen_mask;
         ps = ptbase;
     }
 
-- 
2.52.0


