Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5165CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbg-0004iP-FR; Mon, 22 Sep 2025 14:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbZ-0004e2-7p
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:41 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbV-00044h-2G
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:40 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77f41f819ebso974588b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566974; x=1759171774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeDVjFb3QFb5yHp7aGr6QIEnzzZoZpmvfgcLzDSF2qM=;
 b=wr3xDf6UqQbZW+TYaqzHQGo6/9MnYOzyiq+CfT3DKrzOwfAKTDlziGl53mCREvwGax
 gCs26K9mKQAm2dGgtJf5PfOIr80ZwTnj6TK4HdYwWn59x5QuHj3t4INA2wyZHiA0GW+Y
 1iab/gxt0O0icswuVXcJyXuQTvrs0ZgVhQRXL4W9FEPhlveUx+RMfG85dkmeTob0OGO+
 Ou+ECzZ8oqoHY2Eya7zmPGDMcBSYNLWYSMkB/UpbD9Dv5KbVlYa0G23X39x0sYnDoOjG
 SkbS6Lm5Az72UvVelROV8hRZkYXLm6Iq3csA8QFRcYZlaaG7hfO9fzb4zopNjUgho1kF
 mLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566974; x=1759171774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GeDVjFb3QFb5yHp7aGr6QIEnzzZoZpmvfgcLzDSF2qM=;
 b=TxONgnl75IznBX6EmWraRryN8rNyc6Nh7zuxnbZWLfoiAzMB4ciyrZWaOqAd8YC8Dd
 36y1GeMyzTd5OcHJfkm4qKSXLSKz3wsYvYOVthV8hePsylBHs+Nevxr1pp8Yi+tBZSvK
 SCdsKDn+l2i6R+552FzehDhzwuHaCddtI+02bl3gw+UJP3SyYtDni5DmxWHx6iJYhirh
 ZHvXFDmbVX4fmKmSt5yvUjRWpdKJxLDDObrgdaIGLpX5v2ou7mFQjLdHlTaWFetgGlCF
 mbX+EhzP1gKC/UguIGIaPAWJRWt2j4eZzs5PCPzb6n9r3gcya4ofjRzyiUtHc8jE3Xd+
 xMgw==
X-Gm-Message-State: AOJu0Yw3MVgoukZi9w7U1Xz631KTGxmjxpenk5TJ9RNCyY03Hzvm01nV
 sF25EUE9Xic4EqgFlBpRK6OPixrhF20MO0Kq/2SRlk8qJqmOv7sBWaZ4USdPYPo2qE5B31cDf+I
 5YuJ+
X-Gm-Gg: ASbGnct+Z9h94Kl6JiLDQT9cAuqKaAGCv9tAcdwPGzLc407FPCv67SOCMzgcb8jjqYd
 a39TQbOA6pzvfFFgxjkyVz4YZuZzmtU8cLwgkAncBbZw6gy4F7mp9Dbx0wqrY3iovhXGmtZCEAa
 RjMmdezAnPZuBWbsjupdFUkqgmOnPx1irPleyslrmWifMz1lsN1iUBkas7vhh9MNFC7pQ4QYlQZ
 TfPshBERMTzqZf71o3seUF3aKOEiA761Uw/dTRuo8/frQgozhQmECGINcIoEJL9B/4+oiXvrzcF
 2d92yS7/gdHtbCtPNGRgSP1idaI0iL/HvrOuWtVYbJmVJ4PrDZsWYNf39YoELw5MnQpauNch5iJ
 HtY6EslTpcABI6PaTfGQJcD2FGfax
X-Google-Smtp-Source: AGHT+IFjvZn/tzbQInVqrcT0+MESyQgeoosP4/eBV7g7bYlxPvDE9KdszICBtjaWfM6j2jlV9N9Ogw==
X-Received: by 2002:a05:6a00:4c16:b0:77f:d23:a1f3 with SMTP id
 d2e1a72fcca58-77f0d23a2d7mr15922006b3a.6.1758566974348; 
 Mon, 22 Sep 2025 11:49:34 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 06/76] target/arm: Populate PIE in aa64_va_parameters
Date: Mon, 22 Sep 2025 11:48:14 -0700
Message-ID: <20250922184924.2754205-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Select the PIE bit for the translation regime.
With PIE, the PTE layout changes, forcing HPD.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 ++-
 target/arm/helper.c    | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b1263e4750..b7a1b69561 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1486,7 +1486,7 @@ static inline int arm_granule_bits(ARMGranuleSize gran)
 
 /*
  * Parameters of a given virtual address, as extracted from the
- * translation control register (TCR) for a given regime.
+ * translation controls for a given regime.
  */
 typedef struct ARMVAParameters {
     unsigned tsz    : 8;
@@ -1501,6 +1501,7 @@ typedef struct ARMVAParameters {
     bool ha         : 1;
     bool hd         : 1;
     ARMGranuleSize gran : 2;
+    bool pie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f64543dc78..1111a16330 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9372,11 +9372,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
@@ -9388,8 +9389,17 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
@@ -9429,7 +9439,13 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
 
@@ -9508,6 +9524,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .ha = ha,
         .hd = ha && hd,
         .gran = gran,
+        .pie = pie,
     };
 }
 
-- 
2.43.0


