Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75000CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8l2b-0001b0-GX; Tue, 14 Oct 2025 15:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2U-0001ZZ-GB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2R-0003PY-Bs
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:30 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso5192683b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471423; x=1761076223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFl/S3NyYvxn7AHHN5Wyq5GFhbcqVyXqzmKDA5xxH9g=;
 b=BOOn9EX50bvPI8hYVpBoqFSA8b3EQjfPv0CrwCczGF36LiKPS34ws+AfkHHJ2jVOqz
 VwZhHHN6sHENKzBk9sdn74g2mtg1dbBKC9VAUg7nV2Sr5TovC34ERWpHE5zglsY+mCub
 BmplDxmEdxPPKAWppg40l8xwsARliVJfJgoMT2R3rzMzEHVWEP0kt1jkrQC/KaJ6OLVF
 VDBYe6unuJ0/uA0Dd/QiNa5HHHfsWu2/mQIcyr+mfDEs99SNvt/EhAXeVirQVQ4MlBY8
 FuLKBrAm0a1R38C0XnYqPYxAuPyNDkDQ5XOHuHDfVrh26BYoIJkJQ5j0gyvWR0xeHUmu
 /ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471423; x=1761076223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFl/S3NyYvxn7AHHN5Wyq5GFhbcqVyXqzmKDA5xxH9g=;
 b=RQ3lsE0sze32ijcYWQLV3sgX3nLy8F6v23iq6iil5Sdn/wULsgkSJw+4B0556z0T5e
 DzSday1fkB9Yzzn91S2gTDtl7Q4AAR6hl6ot1GAWpNaI1ed+tbdWxwxLz8ZOznh8dk1y
 OWVsiEkYr1IHuJwh6Yb1plUL7gn3qyxZuRS5gJ1aoyCl6VDa0q3pwZZrZ3xuYgODzsTH
 jc+dc2fHOdzvwq1UYz3uZTyW536OZNHLcmnZp501vuiniEJmTVxNkS8nizTsLbJAtcWn
 YIiVZbcWcklFe5rivBynphnV8T9CjFyfJX3E+nmhRV6CSL1/RnHJUmi+CQ7l16kdARRc
 74tw==
X-Gm-Message-State: AOJu0Yzq4e5PeHEXArgXPzdnmHdqw0tOoy0oKdbH9JrqiopDX1vhzigj
 CM5eM9FN5WJ6lXvvmwgdpkQUuyFhvwZWwwlu0DxqRFRFUkyhLcavdATk9veog5k64XLcVYnadRo
 cP1m/yUs=
X-Gm-Gg: ASbGncsQSeApaliKexja5I3MIROgIsqCAAjJLUVmLHj2aRnRMJqrU8xHrLQkFzVnCLK
 Ge8FD9tYLVFtbe5CK18e2yuSvemNygOWUyOVEkL4e0/v/mKK94meek+V273fgpWWZr3WWMUfriL
 IrhLXvgDNPq+8wAHoIoOdkek4Umt2LYfgSl71Hxx87egI2WugrPAzgiYgB7FXrHxruZRzS0Y/CC
 cTgFOr5VguDaFxNKbOy+hOeQalPvSehRLMT/QQ8+9nhl7QG2kmajqfxTV+hQUgFUJJ2L5l6wBHq
 P0EmVPwAeS1Hj7QLKMLToADvbC1mX1iwd5a0Mr0SvS+fFiGdKR+/6rLtttODDdx4IjLon63JyCc
 H+SY9UMPO5uqRzQXw82p4DwxjAIBQ8yIKAPL/HYS0qSfX0nqHTLLB21QURogkDQ==
X-Google-Smtp-Source: AGHT+IEFjjyZcrv5mQPM07splw9sDAV1uCpgUKR95zTMlMrtsnlIc/Oo0R2cQ+1+b01512eWprvYxA==
X-Received: by 2002:a05:6a00:3d16:b0:77c:64d8:3afd with SMTP id
 d2e1a72fcca58-79387a28eadmr33467529b3a.28.1760471422688; 
 Tue, 14 Oct 2025 12:50:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b63a03dsm15918727b3a.19.2025.10.14.12.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:50:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/7] target/arm: Add AIE to ARMVAParameters
Date: Tue, 14 Oct 2025 12:50:13 -0700
Message-ID: <20251014195017.421681-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014195017.421681-1-richard.henderson@linaro.org>
References: <20251014195017.421681-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Allow the bit to be set in TCR2;
extract the bit in aa64_va_parameters.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/helper.c    | 30 +++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f539bbe58e..a65386aaed 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1391,6 +1391,7 @@ typedef struct ARMVAParameters {
     bool hd         : 1;
     ARMGranuleSize gran : 2;
     bool pie        : 1;
+    bool aie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e4d1651440..8c0b8889db 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6098,6 +6098,9 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_s1pie, cpu)) {
         valid_mask |= TCR2_PIE;
     }
+    if (cpu_isar_feature(aa64_aie, cpu)) {
+        valid_mask |= TCR2_AIE;
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6111,7 +6114,10 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_s1pie, cpu)) {
         valid_mask |= TCR2_PIE;
     }
-    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
+    if (cpu_isar_feature(aa64_aie, cpu)) {
+        valid_mask |= TCR2_AIE;
+    }
+    if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
     value &= valid_mask;
@@ -9666,6 +9672,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
     bool epd, hpd, tsz_oob, ds, ha, hd, pie = false;
+    bool aie = false;
     int select, tsz, tbi, max_tsz, min_tsz, ps, sh;
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
@@ -9688,10 +9695,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             if (r_el == 3) {
                 pie = (extract64(tcr, 35, 1)
                        && cpu_isar_feature(aa64_s1pie, cpu));
-            } else {
-                pie = ((env->cp15.tcr2_el[2] & TCR2_PIE)
-                       && (!arm_feature(env, ARM_FEATURE_EL3)
-                           || (env->cp15.scr_el3 & SCR_TCR2EN)));
+                aie = (extract64(tcr, 37, 1)
+                       && cpu_isar_feature(aa64_aie, cpu));
+            } else if (!arm_feature(env, ARM_FEATURE_EL3)
+                       || (env->cp15.scr_el3 & SCR_TCR2EN)) {
+                pie = env->cp15.tcr2_el[2] & TCR2_PIE;
+                aie = env->cp15.tcr2_el[2] & TCR2_AIE;
             }
         }
         epd = false;
@@ -9733,10 +9742,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             epd = true;
         }
 
-        pie = ((env->cp15.tcr2_el[r_el] & TCR2_PIE)
-               && (!arm_feature(env, ARM_FEATURE_EL3)
-                   || (env->cp15.scr_el3 & SCR_TCR2EN))
-               && (r_el == 2 || (arm_hcrx_el2_eff(env) & HCRX_TCR2EN)));
+        if ((!arm_feature(env, ARM_FEATURE_EL3)
+             || (env->cp15.scr_el3 & SCR_TCR2EN))
+            && (r_el == 2 || (arm_hcrx_el2_eff(env) & HCRX_TCR2EN))) {
+            pie = env->cp15.tcr2_el[r_el] & TCR2_PIE;
+            aie = env->cp15.tcr2_el[r_el] & TCR2_AIE;
+        }
     }
     hpd |= pie;
 
@@ -9818,6 +9829,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .hd = ha && hd,
         .gran = gran,
         .pie = pie,
+        .aie = aie,
     };
 }
 
-- 
2.43.0


