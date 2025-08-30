Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C63CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNwP-0000X3-6T; Sat, 30 Aug 2025 11:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMs-0006E9-0I
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMp-0004LE-Dv
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:43:13 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77033293ed8so2496586b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532589; x=1757137389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEUqCHyIsyVo0vO4j57YgwWlmSmcGS9jWyzGXqSmI4s=;
 b=d8esRXNcoTFRJW2KbGuGZW+8RHIhpoCBG7kq1uo/mzFoRKualEZsNpWBE2BvmO//mq
 DmpZmWgt/EnZj5rZdOf4hdUfyjZi2T+bNJZ37U4Y8biZgVsvEX5OdxqLBLku9bT//fNA
 xqyNUzqf76RrhyKdQYhYwh5qhdRCeZGJY2IM5rSxe3cnd62zHyNL3MW8qVFHuL8kSrA5
 VS1p0NpmSJM3Z1lIMBDqji9NH+x1+R9ScxG/qQNvW/Z8fZ/zxs3t6MUgoK58wruTqER/
 A0yoKYbg+RF64Hp1XPdW6vzt/+Gvi0VlyUjUzMOFcjccK+damb/lPIP4qkqlswmSO1+Q
 H55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532589; x=1757137389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEUqCHyIsyVo0vO4j57YgwWlmSmcGS9jWyzGXqSmI4s=;
 b=e+XbQ/cdD+7YwZvKgzOdMmVilhNl1JoY/4pcCV0KsR3+mw2wL9iMukrJofyZjOIWmY
 e/qljlxFrzfXInP/uV+qllekwRA9g3oiYvhcWIylJ3gX5YC39T1C0ftTRW4+sRGP0ANT
 s02xGT8wxmciAzK19YqXnIbEbTJDOFaWpdjS6c0uqTYAaJ7fGWrgL/CUp/5lStmf+0H1
 p3qkR2eJcD6Vqt5muh5jSZIp1NjqDHggFm7KHNWQYvCbbtD1xjp9I8/5A14hs5H+ZDJ6
 h7vB8w3SyPTqOMQolgUyEvtBQYZFkdMAuiDUBEoFj0VaznUoMPcCgVagV6nRJWtae3yn
 HaRQ==
X-Gm-Message-State: AOJu0YwL6AKlcMQ523ts8m+3z4ueOGU5U6IabNhX6ZLCtVqlxBH+20VV
 gU4slfdE9R6D7jNzc1Bn5A2US/yI3RHylr1gek5yqGNiOo1gViWsiSvzEppQZA/LwZ9VMtZPo6b
 FKLq6nv8=
X-Gm-Gg: ASbGncsycx+QpKIMkEB9I3vbQEYM05OdF082LuugO31Jnv5NsqjQVMbQ3xsgEQKKG1y
 CfhFKVC6Sh3WUxrwbRaRLBiooMC7s8t2ssrRdRUUxaIZigBbN3+o/jpCeqSzcMoHJxr10j8t1ym
 l8fNqLOxrAPy6XmX6qOpMAKHp2RSywXAA8VxUjNpYTbcSW9MZ9foVNxurWuWlkdLiSXW006AIYN
 /9ZgVhb4xzEA/uTmLDaahLjaEfYzZOGLCrjhric5xq7VFQwTGWQr5SNgpxilEKVrBVglJyhfFYp
 SgrsTv/9oOKx3KT3a5kimMcvj2AyATqwXOovQ+HOpkgX4jzfNtHwTgq1d3XUyloqPYwrjuuirsi
 nwkMVWc8RyW66BSqgSijhTx6RK295qb2IqVyxSqR/We6oCBVwWpqQRl1uw6d/
X-Google-Smtp-Source: AGHT+IEef3Etk69b38TEZaAjdqXuBuZz2TtijMlQn1FjGxKUdsCmA6RWNnkuUdFlYhtoDIVghFWMAw==
X-Received: by 2002:a05:6a20:430f:b0:243:78a:8272 with SMTP id
 adf61e73a8af0-243d6f8a600mr1571936637.56.1756532589302; 
 Fri, 29 Aug 2025 22:43:09 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:43:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 34/84] target/arm: Remove unused env argument from regime_el
Date: Sat, 30 Aug 2025 15:40:38 +1000
Message-ID: <20250830054128.448363-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  8 ++++----
 target/arm/helper.c         |  2 +-
 target/arm/ptw.c            | 34 +++++++++++++++++-----------------
 target/arm/tcg/mte_helper.c |  2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4e0c057a8c..c3bce6c09b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1074,7 +1074,7 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
 }
 
 /* Return the exception level which controls this address translation regime */
-static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline uint32_t regime_el(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_E20_0:
@@ -1128,7 +1128,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 /* Return the SCTLR value which controls this address translation regime */
 static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    return env->cp15.sctlr_el[regime_el(env, mmu_idx)];
+    return env->cp15.sctlr_el[regime_el(mmu_idx)];
 }
 
 /*
@@ -1160,13 +1160,13 @@ static inline uint64_t regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
         v |= env->cp15.vtcr_el2 & VTCR_SHARED_FIELD_MASK;
         return v;
     }
-    return env->cp15.tcr_el[regime_el(env, mmu_idx)];
+    return env->cp15.tcr_el[regime_el(mmu_idx)];
 }
 
 /* Return true if the translation regime is using LPAE format page tables */
 static inline bool regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
-    int el = regime_el(env, mmu_idx);
+    int el = regime_el(mmu_idx);
     if (el == 2 || arm_el_is_aa64(env, el)) {
         return true;
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index eaa6766a36..b88d1573ae 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9527,7 +9527,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
     bool stage2 = regime_is_stage2(mmu_idx);
-    int r_el = regime_el(env, mmu_idx);
+    int r_el = regime_el(mmu_idx);
 
     if (!regime_has_2_ranges(mmu_idx)) {
         select = 0;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2b753b1319..5adea5cd65 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -232,9 +232,9 @@ static uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx, int ttbrn)
         return env->cp15.vsttbr_el2;
     }
     if (ttbrn == 0) {
-        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
+        return env->cp15.ttbr0_el[regime_el(mmu_idx)];
     } else {
-        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
+        return env->cp15.ttbr1_el[regime_el(mmu_idx)];
     }
 }
 
@@ -1023,7 +1023,7 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
     }
     type = (desc & 3);
     domain = (desc >> 5) & 0x0f;
-    if (regime_el(env, ptw->in_mmu_idx) == 1) {
+    if (regime_el(ptw->in_mmu_idx) == 1) {
         dacr = env->cp15.dacr_ns;
     } else {
         dacr = env->cp15.dacr_s;
@@ -1163,7 +1163,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
         /* Page or Section.  */
         domain = (desc >> 5) & 0x0f;
     }
-    if (regime_el(env, mmu_idx) == 1) {
+    if (regime_el(mmu_idx) == 1) {
         dacr = env->cp15.dacr_ns;
     } else {
         dacr = env->cp15.dacr_s;
@@ -1454,7 +1454,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
             xn = pxn || (user_rw & PAGE_WRITE);
         }
     } else if (arm_feature(env, ARM_FEATURE_V7)) {
-        switch (regime_el(env, mmu_idx)) {
+        switch (regime_el(mmu_idx)) {
         case 1:
         case 3:
             if (is_user) {
@@ -1510,7 +1510,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         /* F */ 0,             /* reserved */
     };
 
-    uint32_t el = regime_el(env, mmu_idx);
+    uint32_t el = regime_el(mmu_idx);
     uint64_t pir = env->cp15.pir_el[el];
     uint64_t pire0 = 0;
     int perm;
@@ -1585,7 +1585,7 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
                                           ARMMMUIdx mmu_idx)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    uint32_t el = regime_el(env, mmu_idx);
+    uint32_t el = regime_el(mmu_idx);
     int select, tsz;
     bool epd, hpd;
 
@@ -1811,7 +1811,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
     int ap, prot;
-    uint32_t el = regime_el(env, mmu_idx);
+    uint32_t el = regime_el(mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     uint64_t descriptor, new_descriptor;
@@ -2259,7 +2259,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-        mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
+        mair = env->cp15.mair_el[regime_el(mmu_idx)];
         assert(attrindx <= 7);
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
@@ -2737,7 +2737,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
                              uint32_t secure)
 {
-    if (regime_el(env, mmu_idx) == 2) {
+    if (regime_el(mmu_idx) == 2) {
         return env->pmsav8.hprbar;
     } else {
         return env->pmsav8.rbar[secure];
@@ -2747,7 +2747,7 @@ static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
 static uint32_t *regime_rlar(CPUARMState *env, ARMMMUIdx mmu_idx,
                              uint32_t secure)
 {
-    if (regime_el(env, mmu_idx) == 2) {
+    if (regime_el(mmu_idx) == 2) {
         return env->pmsav8.hprlar;
     } else {
         return env->pmsav8.rlar[secure];
@@ -2779,7 +2779,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
     uint32_t addr_page_limit = addr_page_base + (TARGET_PAGE_SIZE - 1);
     int region_counter;
 
-    if (regime_el(env, mmu_idx) == 2) {
+    if (regime_el(mmu_idx) == 2) {
         region_counter = cpu->pmsav8r_hdregion;
     } else {
         region_counter = cpu->pmsav7_dregion;
@@ -2905,7 +2905,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
             xn = 1;
         }
 
-        if (regime_el(env, mmu_idx) == 2) {
+        if (regime_el(mmu_idx) == 2) {
             result->f.prot = simple_ap_to_rw_prot_is_user(ap,
                                             mmu_idx != ARMMMUIdx_E2);
         } else {
@@ -2914,7 +2914,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
         if (!arm_feature(env, ARM_FEATURE_M)) {
             uint8_t attrindx = extract32(matched_rlar, 1, 3);
-            uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
+            uint64_t mair = env->cp15.mair_el[regime_el(mmu_idx)];
             uint8_t sh = extract32(matched_rlar, 3, 2);
 
             if (regime_sctlr(env, mmu_idx) & SCTLR_WXN &&
@@ -2922,7 +2922,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                 xn = 0x1;
             }
 
-            if ((regime_el(env, mmu_idx) == 1) &&
+            if ((regime_el(mmu_idx) == 1) &&
                 regime_sctlr(env, mmu_idx) & SCTLR_UWXN && ap == 0x1) {
                 pxn = 0x1;
             }
@@ -3407,7 +3407,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
         break;
 
     default:
-        r_el = regime_el(env, mmu_idx);
+        r_el = regime_el(mmu_idx);
         if (arm_el_is_aa64(env, r_el)) {
             int pamax = arm_pamax(env_archcpu(env));
             uint64_t tcr = env->cp15.tcr_el[r_el];
@@ -3659,7 +3659,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
      */
     if (address < 0x02000000 && mmu_idx != ARMMMUIdx_Stage2
         && !arm_feature(env, ARM_FEATURE_V8)) {
-        if (regime_el(env, mmu_idx) == 3) {
+        if (regime_el(mmu_idx) == 3) {
             address += env->cp15.fcseidr_s;
         } else {
             address += env->cp15.fcseidr_ns;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 0efc18a181..ed30026b7d 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -604,7 +604,7 @@ void mte_check_fail(CPUARMState *env, uint32_t desc,
     int el, reg_el, tcf;
     uint64_t sctlr;
 
-    reg_el = regime_el(env, arm_mmu_idx);
+    reg_el = regime_el(arm_mmu_idx);
     sctlr = env->cp15.sctlr_el[reg_el];
 
     switch (arm_mmu_idx) {
-- 
2.43.0


