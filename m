Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A194CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHw-00026P-EY; Fri, 03 Oct 2025 13:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHt-00025k-Ts
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:45 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGh-0006I2-Ki
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:45 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so24690475ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511302; x=1760116102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Iqxxu0hxAy5QkLRBDQYG0trbPoBDKRADO1DvLD8JqU=;
 b=amtDuLG7nVoHUWFAU3LT+sKc8WswkyvCDUVGW15k2qeMMb1Wb9BpHwib7iE/WWPOQf
 7y2U0haY5EiSnyxA3fxNTaU+6L2HIS2r/xKz+tZq8qQiNnjVWqd6sf13zW3VCeiBaeNL
 sbIXspsr6nDnl5HJtiEBoc6nchwR04Hgj/HXetBBSXBC4AkINoeI3v3k7r21MjWaNMkj
 CjnD66sq6wQm7qFLETH5/NRzo/2tjh2IRq4/yA8n5Ke7npRdJk0DDugtyyRLXz/kU4nO
 1VB9P/xyC1N4k4smNBl7PK7DGbRLC0vcbx6+Adk0ZC/gpGV/aLQyJjCaBXPiJf32hDKF
 MKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511302; x=1760116102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Iqxxu0hxAy5QkLRBDQYG0trbPoBDKRADO1DvLD8JqU=;
 b=hndW8ZDmWg+uaxiSEA4kfbXXsKLXNFT/Wq5gBU8MZTCvijqIEu6khAiaYxwPV+dbey
 cK2XulEnLv8DKILpZ2zcgigCm02rZpFSOz1dAWhCAHmeR6rDc609aJBYY5iwYOc+MPCd
 IYaiT6qZ/R+vIcG2g21vIMtLSDjvMl08MeDBbywT7MHay9og/pDduzzdXdW8Cow5vOOI
 CqAHAnKJjOiCHMYkNNh3ZmP4lfok6dbpGxXxzNp6udMbTQ4gAGORubz7JDzT1IZ6J7dN
 g9T68awmktF2Ta9Eaui0qeQ2q39BediMLPeUPSyJ1Gb0evxdTU1lxdgcwVBhhOvYkG0p
 jbpw==
X-Gm-Message-State: AOJu0Yz0rtnCt0Lf+9gfAcVlfv/nAXTmt47/fLPB6sV+i5tAayCVYtaE
 xJyMJvvwzAGzQQt6EElJHfT4fa9rpwum51FgYcMzJrkRGMATGSrxaW8HB4ri6q2N4gyGYWogzTM
 QFa4U9Yo=
X-Gm-Gg: ASbGnctuGSmA9ABSBUb2u96kly8YzjbTqwJGVh8uzjAW4U2JENZwA7q+ndz3fUev98O
 7BgJ7VbOR7Z/Own+3DK5FtojtQEcI8OoimtptEekl2bePbkaePrv9xRFmytb9S4B5W+5dAFWPko
 03YxHeBMhHxh1+Mp2MhmivY48GJ7+U187a10/KhdFRwIeJYkXq2JbuZBlvZzFTNPXxV+DbGF4Ng
 P7rbOV+sHGkmCC7UPnBU73SU/HIfqu6JRjVpsSpdSMSIBvnOkR6cVnz8bD2b7gr63PCzWIZVn89
 iifWR4Rg8YC2DFKhp+XUi3jwWrS/S2xb3UNjgmW0L4jbhPjWeE8eLq+DXfa8idDHp/NrwCzlRrH
 Ai9uBBPpb80TaQQPCfxkAz0179x5MyNnn6zeUV908rk971U+FMROevq7o
X-Google-Smtp-Source: AGHT+IE+24Q0R6hhEApY7e7jSMh9vQJFwmEnVr+gmxPO9ML8YwEbITlRjGLmJF/8xOYChGn9MzNmEA==
X-Received: by 2002:a17:902:f68c:b0:25c:b1d6:c41a with SMTP id
 d9443c01a7336-28e9a513489mr41840205ad.11.1759511302469; 
 Fri, 03 Oct 2025 10:08:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 23/73] target/arm: Remove unused env argument from
 regime_is_user
Date: Fri,  3 Oct 2025 10:07:10 -0700
Message-ID: <20251003170800.997167-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  2 +-
 target/arm/helper.c    |  2 +-
 target/arm/ptw.c       | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 819ada7a5d..d0d976cbb0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1032,7 +1032,7 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_user(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b540f4dd36..861fd3c57a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9444,7 +9444,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ds = extract64(tcr, 59, 1);
 
         if (e0pd && cpu_isar_feature(aa64_e0pd, cpu) &&
-            regime_is_user(env, mmu_idx)) {
+            regime_is_user(mmu_idx)) {
             epd = true;
         }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index db51e55cd2..b72c1fc348 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -964,7 +964,7 @@ static int ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx,
                          int ap, int domain_prot)
 {
    return ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot,
-                                regime_is_user(env, mmu_idx));
+                                regime_is_user(mmu_idx));
 }
 
 /*
@@ -990,7 +990,7 @@ static int simple_ap_to_rw_prot_is_user(int ap, bool is_user)
 
 static int simple_ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx, int ap)
 {
-    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(env, mmu_idx));
+    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(mmu_idx));
 }
 
 static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
@@ -1376,7 +1376,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
                       ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool have_wxn;
     int wxn = 0;
 
@@ -1538,7 +1538,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
-        perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
+        perm = regime_is_user(mmu_idx) ? u_perm : p_perm;
     }
 
     if (in_pa != out_pa) {
@@ -2389,7 +2389,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     uint32_t mask;
     uint32_t base;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         /* MPU disabled.  */
@@ -2556,7 +2556,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     ARMCPU *cpu = env_archcpu(env);
     int n;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
 
     result->f.phys_addr = address;
@@ -2776,7 +2776,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * memory system to use a subpage.
      */
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     int n;
     int matchregion = -1;
     bool hit = false;
@@ -3656,7 +3656,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         break;
     }
 
-    result->f.attrs.user = regime_is_user(env, mmu_idx);
+    result->f.attrs.user = regime_is_user(mmu_idx);
 
     /*
      * Fast Context Switch Extension. This doesn't exist at all in v8.
-- 
2.43.0


