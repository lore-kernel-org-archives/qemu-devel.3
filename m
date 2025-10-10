Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571F3CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cp2-0006AF-Aa; Fri, 10 Oct 2025 09:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coq-00067Q-HW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoZ-0003ll-Uh
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso15327415e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101538; x=1760706338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ASyzth2+dJyh1MI3oXSuce6UC/YaXqBlkKj5sq9zv/8=;
 b=vrvhbYyCtdzT5BlYbsVWSGmBudnB4U+EilDevsHkuRwsmfbqtBGUsFauMZz/qEmB0F
 30G6W1Wt+kbE+YYq8/ma5nXSSnjN7EK5hOFDz9uft4vrL/8Pc+ZkvJEM/Zx4PwK2a5bB
 iSiBWM7BvoT1o3oV3Wexc3QElfBAdqybwsiHbKRan9DebtttU9pX33ohPCWWC8pdce5Y
 Hph2L6tjknmu3WlYfix8u5YlgVdpr8dbQLRhZNkHotJgPWboXH7c4ULf8+WjgGVP9dfY
 5L2WTqd4hr4ahZrvsir43WBkckSHrK0GT656AmRccPXNcpGrh7fWwz9wJeUrvaP7ii3P
 FpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101538; x=1760706338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASyzth2+dJyh1MI3oXSuce6UC/YaXqBlkKj5sq9zv/8=;
 b=fDCAQvx+Tam8/aAElDwEn8vJ9yKp2e1DVKAADeEocreHcGuHRVpuvo0j1X/1VLHdFL
 bpXpjCUi/wbLPlIKkCytWg/BEGz/MxrJNj9cKzMq9bwPHqY9kMc2tor1BuDOI/7dQtFX
 uynYZqItNErCkz1IEgMJhRx8dXeZsj+aIdoZk9w7gZ6lq3IMi8oCWDrVjQMX4t+BsO4I
 NszpeYRWl/D+qKMHUH3bsae6ibkWxcmaXR+wOc+efIjY2A4cU86i1a4Y/Ih7Q5AC2fWP
 mU8PhqdNbL3AwoZRDyYAwcxhtctKEfNcA8rBXE74xoYzhA3AjDvPLBNueeSp8RYIMfVC
 3csQ==
X-Gm-Message-State: AOJu0YyucSE8/WePYRbbd7QHKSvmHK19RYBQBvTIBCYKyYmkDT2LptMv
 /oeP0O+zE20pc5zTMPF1s+B+HDZWad0V3ZtkdSW02F1nQu52eWHeqFDQDGVzHa4b2FcHYFVQOdV
 K4njp
X-Gm-Gg: ASbGnctU8yq2uo4mBnQFXRbep3SHTypJtr0Y/j8IUH6L7fiX/M76o3alTnkhVlHxtSJ
 4gtTiakLKO1UqiB5Ot8Vdkbh60sdD+U1feARiLr3zuNCWtdTIW1vnJUkXDZA3+f5rhRgArMhDyK
 PVuGYOzxwX40RdF9eU30lGXHXR1k8ucZzlKHMwmwHc8MFx/cfbRYQ83UkQz6vUgARqC3mUEh6iZ
 tIc5VwaBrozzdoetICmc57ccQoXH5dyWy0UZntYvR6bsOxII7bVO/bBf1Zm0jlXDv9PQx1v0pU6
 kFYGGqtYJi+8BQxYWPza2xJ0wc4Sow+JV7XKPN4BsMPwICUd9Ov0ryekQ+IMlHhHckksXiL6+HE
 YcOd0i2+rHdigaQFhyz6klAePYZc0aYNG140cVeMWQleqQMTePjI=
X-Google-Smtp-Source: AGHT+IEHPJyeEhNjV1tb8c4DcYPcjewmSjBQkHNYgjkSgLwFEsSCtcbmCT3fxi/vStiukbbl8Jualw==
X-Received: by 2002:a05:600c:1d18:b0:45f:2869:c3b2 with SMTP id
 5b1f17b1804b1-46fa9b1834dmr83842385e9.33.1760101537784; 
 Fri, 10 Oct 2025 06:05:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/76] target/arm: Populate PIE in aa64_va_parameters
Date: Fri, 10 Oct 2025 14:04:18 +0100
Message-ID: <20251010130527.3921602-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Select the PIE bit for the translation regime.
With PIE, the PTE layout changes, forcing HPD.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  3 ++-
 target/arm/helper.c    | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1d958dbf685..face1019f52 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1491,7 +1491,7 @@ static inline int arm_granule_bits(ARMGranuleSize gran)
 
 /*
  * Parameters of a given virtual address, as extracted from the
- * translation control register (TCR) for a given regime.
+ * translation controls for a given regime.
  */
 typedef struct ARMVAParameters {
     unsigned tsz    : 8;
@@ -1506,6 +1506,7 @@ typedef struct ARMVAParameters {
     bool ha         : 1;
     bool hd         : 1;
     ARMGranuleSize gran : 2;
+    bool pie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b7bc27436f7..37865bf70eb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9386,11 +9386,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    bool el1_is_aa32)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    bool epd, hpd, tsz_oob, ds, ha, hd;
+    bool epd, hpd, tsz_oob, ds, ha, hd, pie = false;
     int select, tsz, tbi, max_tsz, min_tsz, ps, sh;
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
     bool stage2 = regime_is_stage2(mmu_idx);
+    int r_el = regime_el(env, mmu_idx);
 
     if (!regime_has_2_ranges(mmu_idx)) {
         select = 0;
@@ -9402,8 +9403,17 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
              * Thus disabling them makes things easier during ptw.
              */
             hpd = true;
+            pie = extract64(tcr, 36, 1) && cpu_isar_feature(aa64_s2pie, cpu);
         } else {
             hpd = extract32(tcr, 24, 1);
+            if (r_el == 3) {
+                pie = (extract64(tcr, 35, 1)
+                       && cpu_isar_feature(aa64_s1pie, cpu));
+            } else {
+                pie = ((env->cp15.tcr2_el[2] & TCR2_PIE)
+                       && (!arm_feature(env, ARM_FEATURE_EL3)
+                           || (env->cp15.scr_el3 & SCR_TCR2EN)));
+            }
         }
         epd = false;
         sh = extract32(tcr, 12, 2);
@@ -9443,7 +9453,13 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             regime_is_user(env, mmu_idx)) {
             epd = true;
         }
+
+        pie = ((env->cp15.tcr2_el[r_el] & TCR2_PIE)
+               && (!arm_feature(env, ARM_FEATURE_EL3)
+                   || (env->cp15.scr_el3 & SCR_TCR2EN))
+               && (r_el == 2 || (arm_hcrx_el2_eff(env) & HCRX_TCR2EN)));
     }
+    hpd |= pie;
 
     gran = sanitize_gran_size(cpu, gran, stage2);
 
@@ -9522,6 +9538,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .ha = ha,
         .hd = ha && hd,
         .gran = gran,
+        .pie = pie,
     };
 }
 
-- 
2.43.0


