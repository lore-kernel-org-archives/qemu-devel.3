Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88082C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLhP-0007hx-50; Sat, 02 Aug 2025 19:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgb-0006mK-Cg
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:46 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgZ-0004uG-MW
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:45 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ffa1b10918so1987953fac.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177442; x=1754782242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZyOZ5ibz8YB1lWsiaU/JxXFHwk/vo9PWaKWI3jDReA=;
 b=ljhohh4J2Lqd0KBNZeqNClgRpYb/6IAsExY0XRr+s7qLlNzlTWGTY+VAIkFznOKB8F
 0NXq8m5s1zIdZcgqwNF8SszVASrwiohzVtN7qlIN5U1ybiUt/uN4S8U2BRmoh6h9mQdO
 JJXL5zB5rGH7vaPsVBVKfqMtBSWa6RVf1CTNkrIsBHoJ0+rcMgzvL5mbe5zv1YWTqMtx
 X6oM4lAL5tPgoJH5NgPnaq+ttMSnX5aFdSwPWCmQeezJ/HdOeaoIZXWR0cLF7l2MY2N9
 Tt3gVN/iolRud+WqbAdOGlsqLVCDsSaZ/N1HhZHiHrJmKNcWN+2inZ0+AG1WHyfoK1Xj
 53YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177442; x=1754782242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZyOZ5ibz8YB1lWsiaU/JxXFHwk/vo9PWaKWI3jDReA=;
 b=N3eT/UYkAfnFyRXbemZrRc7KC0y6G/HvRsu8QV0v3Kn1sMDqzmwmTD47FYvPyzpZof
 Lj6pW405kFKKssNM3cNMGdXw6VGVIccmYiWDvWj1u5Z3w2KbZvsGTx4SInGfjXqvzXQY
 3QjcNIZVqG4NFogIrpe/zwsr4KkxsOPlkOELNgqAt0eymeh9JoLcN/6Lt6HSOPq1w9ZF
 c0cZtcNKt5GowRNLEuLF9FOXGS4k+7K1TBkbRxiTHMSFLgwoNYzj9ABuiyG+Q8DRUKyh
 4+yh4tsIihVL7m5x4bXbcZPywLXoWzKTTEUzVhrhXJ64Y0z/aNivgpif0BKLPz+klGDi
 kO+Q==
X-Gm-Message-State: AOJu0Yxpgy/jvqOfL0cX/hklOyoHIJ3sx4yIawbs3UKzwmK8WW1a6IEC
 jIGJB2g9OPv3mzyjm8UOSzlU5kJoifN2gQKetWeLeqnTKzWuVLsElMH3IBtdpAPWrVfIwe3o61G
 CKJf/SOU=
X-Gm-Gg: ASbGncvyOWlIrkJdKwfiP9go0V6uYUEm3t+PsEzc7uDTQU2W9maEdyeW5tyYH4qPXTy
 vmyB5qLHUPqRpFEtQ6O7edQNUfR/t7XvQCY3bh8/NiVo/El6ZZ/Bp5isat8Isndcf0/o44+evYn
 laHLEEcAdeFSJz42BmMwGzhVRFLgZ5X//t74bdQwbgSwZY0/s+11V65NSCgfdd+ixllRTpRUXAf
 dIiJ9lXYsk9+6CXFuJwO13G6ks6Gw/rFp8kwz/GhnuquvnPPfhEUsD1fJr6Xysa307blleImZ2x
 y9xP1zQqQUSKi6JkYmv0+zF/QwsDDaROAfEWI8Q30DpsPthdDUtmKXR673VsgvghMCfQpQ65DxL
 IUfMx/Cg44zuQT+DTKGjXc/1pSV/BYaCpoxHMPrH+26Ivp010HZ+HeWpCNY/Egns=
X-Google-Smtp-Source: AGHT+IGukVB1JlVARvWQrAXUEnSCP+hxMp5H/nbHFMvlGxrtokoaFRwEciLa155NexkoY30F3VWxNg==
X-Received: by 2002:a05:6870:b60b:b0:2df:a9d0:1dc9 with SMTP id
 586e51a60fabf-30b67be9669mr2676103fac.37.1754177442506; 
 Sat, 02 Aug 2025 16:30:42 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/85] target/arm: Add prot_check parameter to do_ats_write
Date: Sun,  3 Aug 2025 09:28:37 +1000
Message-ID: <20250802232953.413294-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Separate protection check from access type, in preparation
for skipping the protection check altogether.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpregs-at.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 2ff0b3e76f..bebf168997 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -24,14 +24,14 @@ static int par_el1_shareability(GetPhysAddrResult *res)
 }
 
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
-                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                             unsigned prot_check, ARMMMUIdx mmu_idx,
                              ARMSecuritySpace ss)
 {
     uint64_t par64;
     bool format64 = false;
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
-    bool ret = get_phys_addr_for_at(env, value, 1 << access_type,
+    bool ret = get_phys_addr_for_at(env, value, prot_check,
                                     mmu_idx, ss, &res, &fi);
 
     /*
@@ -191,7 +191,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 
 static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     uint64_t par64;
     ARMMMUIdx mmu_idx;
     int el = arm_current_el(env);
@@ -253,7 +253,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         g_assert_not_reached();
     }
 
-    par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
+    par64 = do_ats_write(env, value, access_perm, mmu_idx, ss);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -261,11 +261,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     uint64_t par64;
 
     /* There is no SecureEL2 for AArch32. */
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2,
+    par64 = do_ats_write(env, value, access_perm, ARMMMUIdx_E2,
                          ARMSS_NonSecure);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
@@ -309,7 +309,7 @@ static CPAccessResult at_s1e01_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     ARMMMUIdx mmu_idx;
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
@@ -352,7 +352,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
+    env->cp15.par_el[1] = do_ats_write(env, value, access_perm, mmu_idx, ss);
 }
 
 static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


