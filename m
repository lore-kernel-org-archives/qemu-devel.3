Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0093C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjK-0003gm-1K; Sat, 02 Aug 2025 19:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhN-0007ho-S9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:34 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhM-000532-5N
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:33 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3005517e7d0so698313fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177491; x=1754782291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRRS/gV/szOXu7puF9a2nCAqRylQ06iARqw+VOh+yuA=;
 b=GuzuMgI039RxsACXw53lyR/rB8MHOeHoQd5wEeH+poyy6BJHaawr8t5mLaCFNdg972
 M7JEawbUFFdGYXfuJvzfaxVQHUUhhrxXp290wUduc2aS0VjmNVGuY+VVaJJag4O8pAvQ
 UAGqGf/oBhHXRr5Yz4d5uAe0SF1yr5ZBCK+8AFUyEHD7E0QRRs/+NkRYi2O1Zblhv3n/
 /EPT2+WfL2IZ4SijuSfC7svTIx/dOIdjgw0mUmJguJqXg6lUUcDumD48kG7fVDEwVykP
 2w7+E/Df7YcH47xDqlrbhd2+FQK/9/sFROhx7JVv9swnYHOdCFk1EmYsftWenwsoIjng
 8Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177491; x=1754782291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRRS/gV/szOXu7puF9a2nCAqRylQ06iARqw+VOh+yuA=;
 b=VqDWlC8b7j5gD6LdGntVadM+A6t4wYa027Em9Jv4RdiLin/8tZPnXqjlNrTXpgLLBF
 mW0PrFtfthhbRXspG4cm/0pYgn8WHomoFa2rCzrmtZkl55ju2C4/K78NKvYKplJGkTMN
 3dgrRy6HP4Ms9Sq2w/lzuVOye+bhKnPLJvXtb85OCwwiemmhuQ1XGmL+ah6g5+xYZypM
 5367IbyzFq6AwyeDv6bJxeY6+eQpioyhuqQbYOeq3aYqv7lyMVPWlzs9mnl1JNGNytAF
 pDAtXztA+YGw9zkETMIFS5aEcNZhbdLGN1eeO9nXFe4hu9oBqqpMrHm9ARdPozONbLkY
 LOsA==
X-Gm-Message-State: AOJu0YxXitXU9n3rgnOxpI3uD6U/Y288Wr5sgdbrCGGs5YYV0tGftkuN
 +ONjQhBVFglyeZM2NjzrrPqZRx0Yq6GGe3i+iW6eenVKFVwBhTO9ZyqfsOmJVlhinC4ToBMr0KO
 fY3FaFLk=
X-Gm-Gg: ASbGncu8AxskBQ2NdyCeR1mki4iG6ePucds+Isl1a4pbNanNxV0fAqqmMmvTxtoz09E
 egIsBNVWxFC3P+Bdd5hdbPSQZF7y0soavdNjrvOwv8Lp8haknyrFqhk0zWPNDmwqzKyc1pFJNY7
 b6rixE+gnfyotzVubYlXZWVE9CgMp53O264wip5mcy+FCzloHCp2FqP+tgujC5yTMLBM0sLjYxq
 UiCklFiGquSQQWpkFyHb3DakHeV9F3nSz/UkUNjrm5bqBl7azcCXKpsj9DK/iDXsa4Ep5APd+6q
 UBPLBa9lskXvTZQdO3xfOOX61+mrcDJyac/1yplIJoHCPOfx8B8/1CCG6YFlZM3qbfSwkIu5CsR
 COGAvlIUw2ev6rqm3v7heKB3FKBI3mNMI9iItBt9ZrSfsZPTvZ+w7soI9GwkfvjV1nJD+fE70Ew
 ==
X-Google-Smtp-Source: AGHT+IEpXOP5BjOmV5bdg8GlCsVa+fOV0Pxmhg5mWnbHYQpS9HHF5yv7yrX9XFWE4eIuY1w1vfwtWw==
X-Received: by 2002:a05:6870:8613:b0:2d4:e101:13eb with SMTP id
 586e51a60fabf-30b679db3aamr2682990fac.28.1754177490916; 
 Sat, 02 Aug 2025 16:31:30 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 18/85] target/arm: Populate PIE in aa64_va_parameters
Date: Sun,  3 Aug 2025 09:28:46 +1000
Message-ID: <20250802232953.413294-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 0dd1b214c8..d5f501bb30 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1488,7 +1488,7 @@ static inline int arm_granule_bits(ARMGranuleSize gran)
 
 /*
  * Parameters of a given virtual address, as extracted from the
- * translation control register (TCR) for a given regime.
+ * translation controls for a given regime.
  */
 typedef struct ARMVAParameters {
     unsigned tsz    : 8;
@@ -1503,6 +1503,7 @@ typedef struct ARMVAParameters {
     bool ha         : 1;
     bool hd         : 1;
     ARMGranuleSize gran : 2;
+    bool pie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a6130f7dcd..168557b08f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9628,11 +9628,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
@@ -9644,8 +9645,17 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
@@ -9685,7 +9695,13 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
 
@@ -9764,6 +9780,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .ha = ha,
         .hd = ha && hd,
         .gran = gran,
+        .pie = pie,
     };
 }
 
-- 
2.43.0


