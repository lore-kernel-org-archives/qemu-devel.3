Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB862CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXaA-0005Sc-Ov; Thu, 14 Aug 2025 09:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXZH-0003ef-Sc
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:32 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXZ0-0004VA-7s
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:31 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32326e20aadso1162680a91.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176409; x=1755781209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL4FJWjHVfku8XpR/Kx1zBnrguDoHqeN3UFqZHuwYME=;
 b=dwBMhiMZxoJ966dvPv7yHuLO+4yu+V4m4E9Yrut2uYB1uR5i1Twxey3tvsfg0FTDrk
 VBHkiTOphldD1CBVw1E870gT9nrTalEOBNY8c5ZZct8uSxc9kCGqls36bs9xn5NzrDaK
 Q4lR22iJQvh9mx5I1dNYwYLLC2cQVcTPE3X+4L9cgcT6Rvy+4v9aj36WUONSDU4ZUCEw
 OIpTvsXw6vNkkNFGLxDMx4jrssOzAc1KUyfLW5eq+Fu8gUL4hBZNDl3ixMChZ5IRDd0P
 DAXlfnF1065tDAFMjdzGbBHibwNUjipv/IrxsJ352UNYSLewW200vB4PgFeQBWa2ZBj2
 +1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176409; x=1755781209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SL4FJWjHVfku8XpR/Kx1zBnrguDoHqeN3UFqZHuwYME=;
 b=hIWDcCSLDKyradiiUimCsjyZq1fElnGVfD+YpVLlwxWwrpVU53v0+ai2upVP6/ZCQK
 1EwQ4x2/HNlf3pfwDudsvxYVPilW2QBDg1IW/hwMphatS6X7m5YnS13BkOlGMoIiIzAs
 vyEv/HcfjMiz8kFRKYC5JHsW8J/fcviUqBLhGjRd/Z2SOYkOkDFz4+gEEluQdkq5rJsq
 ihKHS5m1NAh19x/gC+n57++HewRxU9+sCrDbL4Wx5Xc+sswjJzDF+i94K94mNYmHzyug
 +cOiQ/9b1uvwrQ1oTlZ7WnRaygjn8fyZs6R4/mXN8llgmIXpcsrKwzDBYVizf6nDgztx
 SE8A==
X-Gm-Message-State: AOJu0Yw6VeFGh9dCfqGasOKUt0IlzwrAetnw6zr7fJQ6VHd/e2uE/0nO
 RmLFY4eqnrvgzBJPaWxhQ03PzpDigExl2xhe8uMWXGqOLMcf+qKbTrkca8Bbe9TdqZvnUutS85x
 mGTohhXw=
X-Gm-Gg: ASbGncsbrIUDwD6n8zBhJVC9WH1vkvRFcBaJrDPmTeXX80uwj/LIFYrz2Eb668pAb6K
 1WDaI0YpBCkliHM84OV8ZVDxbVEMF4cKSvQRXz4aPEXPScaoUUzNJEhnJRhdc3/isNk1zXoT7z8
 HarWYAUAZv4NcvR9vbYttzBlO2pQHthvQ3Z6LxcvnG5wK9uPOgZWiCGSBKEBZ2GXhG02wzwMsYn
 UAb6fq3pDZMv/JpJxwQkK0cVfAOvwUVHOy29ZAIkT2k2g8RWVJN3jRiTUbvs7+7LP6GuCCd4mp2
 REPu/WyHOaCrRwzBdy03MevaonmhbqhLqQ6NPEpzfzAKa9lR06bTmIychIdDqOVEgvmffU9ZO62
 zVY5TMfW9/xYHE1POFGTc88s/J/1ptx+68PnFNsjtXpeJNv0=
X-Google-Smtp-Source: AGHT+IHHixtE0CCLByu2UB7j6b8DlwqRsUbmd/yqYtQESdCITjnwH38cxygPi1yri5123x6Y0ZNssg==
X-Received: by 2002:a17:90b:39c7:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-32327a51eecmr4877407a91.20.1755176408943; 
 Thu, 14 Aug 2025 06:00:08 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.06.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:00:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 39/85] target/arm: Remove unused env argument from
 regime_is_user
Date: Thu, 14 Aug 2025 22:57:06 +1000
Message-ID: <20250814125752.164107-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
index f665971b97..ea210c7179 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1034,7 +1034,7 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_user(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 78f670314d..090076af24 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9692,7 +9692,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ds = extract64(tcr, 59, 1);
 
         if (e0pd && cpu_isar_feature(aa64_e0pd, cpu) &&
-            regime_is_user(env, mmu_idx)) {
+            regime_is_user(mmu_idx)) {
             epd = true;
         }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c75b15b263..493ec78c1a 100644
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
@@ -1377,7 +1377,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
                       ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool have_wxn;
     int wxn = 0;
 
@@ -1539,7 +1539,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
-        perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
+        perm = regime_is_user(mmu_idx) ? u_perm : p_perm;
     }
 
     if (in_pa != out_pa) {
@@ -2384,7 +2384,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     uint32_t mask;
     uint32_t base;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         /* MPU disabled.  */
@@ -2551,7 +2551,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     ARMCPU *cpu = env_archcpu(env);
     int n;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
 
     result->f.phys_addr = address;
@@ -2771,7 +2771,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * memory system to use a subpage.
      */
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     int n;
     int matchregion = -1;
     bool hit = false;
@@ -3651,7 +3651,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         break;
     }
 
-    result->f.attrs.user = regime_is_user(env, mmu_idx);
+    result->f.attrs.user = regime_is_user(mmu_idx);
 
     /*
      * Fast Context Switch Extension. This doesn't exist at all in v8.
-- 
2.43.0


