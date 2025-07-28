Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3C2C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSST-0007qG-JN; Mon, 28 Jul 2025 14:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPI-0004ph-WB
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:16 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPE-0002no-As
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so3162416b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726618; x=1754331418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hmuf5M0Ch/uKIrJoN7UCzkopi/XLRHDhRKtkHeoLcXE=;
 b=diw2j9+aTY+S0ewcEPCWA5LmgYpAFycCKdNGEGumlhZ0rZeg0QgrfbdkklV/R8n5Mq
 gvbm749QUqm0HO3f1O8epzdG07GZDbVi/1m1wuiK1V4pi/XMLVjggofHEWtMnGCT4/xm
 dEhdoEuhU/paGN8oao2GVBPglvIo/Hq2T3M8WpzK88FW5y0sTnIXf1edjQ+Kt2EZOcOp
 jeDAZZxQFkYRU8/uoCD6FE/Lind3yaulz5frj56+h5hJDOKLzY08ar+LBOqYRYbcbHfK
 12LiyGKjL3JSXh+WVGwoJy0/r9WcTasJyQ2gEW5cHUE2p3dW7shvDY9IFdfSpgk1vXpg
 D4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726618; x=1754331418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hmuf5M0Ch/uKIrJoN7UCzkopi/XLRHDhRKtkHeoLcXE=;
 b=ii4AWd1JJMq2d/o3qgy3UaQsPcYKJ4StscOftQxAYURE535U7M/2tgPPXEW0QVQSSW
 BRmlbPgSS+R9KHOXrbJrzLuMG3p3Rxf8x47ECOK+GWn45YltG90d0uyIWMjItVC6AAWY
 M3BIDP5FhzVfyn+pmc2nuWDeorq3TATkxGhVZM9CFCym0AnT8aQ84RjmLPVFh9jU433G
 5OQi+1voY1/aJ18/wj1n7OpjqmXIQVS90jsvwYK9eaOgCBnGsWmSGWooYW8bgXEAMVtW
 Bh08EEjkGMWgtCOQBKhOOK4LqUmQEEJuGVjNjleRpsQJbI+JuTU/y8cpQ0iF1O1nvY8+
 CxHQ==
X-Gm-Message-State: AOJu0YzNQWKNZFuNvas21kpRHNllzqyqwETIOa7qpti5i+opMnOcDhDQ
 mu4Ei2B2yigGtXwAyv9WwlqbNS51OM9RLrhucnUFPNTn6mi5oX6Ba2wZCYtxIrsLlhhqTnizPP6
 j/zVs
X-Gm-Gg: ASbGncvf68GZOlWf6rr+CSrs++vDgP+j+KmpdO5tPWMwts9NjPejiYKvRHIHJoXQZPw
 O2rzxlMmJ8MlNeMepEJ5a44KZQuzflvbeSOqeUa7gCqrfKF2EzOjzuCcDYXVhdgP6PFqweAMSrQ
 zzF63EkM8M2HQrwNgLT/lGtL3VRSVOvu7dcDl60hwOUiXukh9JGNT/y2OjtvByqL7LRSrOWiNgm
 n8kMnTpKFhjbMPrf5I6GN8uhLIwVklAH9X/MUsd3mx1rscLf54gZC3O/oguZw+xOCxvCC1sPJQr
 CJWwBLwA+PuZZgFGhZwJLhbiKFlPfoO6s1IGyVaCILUoIVSI2R9BKjb9ACu2ub4YZp09BCyk0wu
 QNFMCCmnfHKiuds3UAGlDVi/zerxgVbUHpV5c7AJ0myCMxJU5FXP909RxtuT5HZJuMxvEamNxqA
 rJ0m7dueoXyA==
X-Google-Smtp-Source: AGHT+IH2sRBvgaIXRdz0QnVg9HdqGQ3+TobygqeCFL5yB1MfAxgNwhOKzJJIwJiHQqubCKdMF2dchg==
X-Received: by 2002:aa7:88c6:0:b0:748:f80c:b398 with SMTP id
 d2e1a72fcca58-763382d8395mr15177782b3a.15.1753726617865; 
 Mon, 28 Jul 2025 11:16:57 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:16:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/9] target/arm/sme: Introduce aarch64_set_svcr()
Date: Mon, 28 Jul 2025 08:16:44 -1000
Message-ID: <20250728181650.165114-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-4-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2a8af3825958e5d8c98b3ca92ac42a10e25db9e1)
---
 target/arm/cpu.h              | 1 +
 linux-user/aarch64/cpu_loop.c | 2 +-
 linux-user/aarch64/signal.c   | 2 +-
 target/arm/helper.c           | 8 ++++++++
 target/arm/sme_helper.c       | 4 ++--
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 32b0bf8e2d..8acfd3af4c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1118,6 +1118,7 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
                            int new_el, bool el0_a64);
+void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask);
 void arm_reset_sve_state(CPUARMState *env);
 
 /*
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 9875d609a9..d53742e10b 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -93,8 +93,8 @@ void cpu_loop(CPUARMState *env)
              * On syscall, PSTATE.ZA is preserved, along with the ZA matrix.
              * PSTATE.SM is cleared, per SMSTOP, which does ResetSVEState.
              */
+            aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
             if (FIELD_EX64(env->svcr, SVCR, SM)) {
-                env->svcr = FIELD_DP64(env->svcr, SVCR, SM, 0);
                 arm_rebuild_hflags(env);
                 arm_reset_sve_state(env);
             }
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index 6a2c6e06d2..b6e4dcb494 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -669,11 +669,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
      * Invoke the signal handler with both SM and ZA disabled.
      * When clearing SM, ResetSVEState, per SMSTOP.
      */
+    aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
     if (FIELD_EX64(env->svcr, SVCR, SM)) {
         arm_reset_sve_state(env);
     }
     if (env->svcr) {
-        env->svcr = 0;
         arm_rebuild_hflags(env);
     }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6cffbcb276..86b97daf7e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6429,11 +6429,19 @@ static CPAccessResult access_esm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
+{
+    uint64_t change = (env->svcr ^ new) & mask;
+
+    env->svcr ^= change;
+}
+
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
     helper_set_pstate_sm(env, FIELD_EX64(value, SVCR, SM));
     helper_set_pstate_za(env, FIELD_EX64(value, SVCR, ZA));
+    aarch64_set_svcr(env, value, -1);
     arm_rebuild_hflags(env);
 }
 
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 8ba3f3a247..7717dab64f 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -43,7 +43,7 @@ void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
     if (i == FIELD_EX64(env->svcr, SVCR, SM)) {
         return;
     }
-    env->svcr ^= R_SVCR_SM_MASK;
+    aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
     arm_reset_sve_state(env);
     arm_rebuild_hflags(env);
 }
@@ -53,7 +53,7 @@ void helper_set_pstate_za(CPUARMState *env, uint32_t i)
     if (i == FIELD_EX64(env->svcr, SVCR, ZA)) {
         return;
     }
-    env->svcr ^= R_SVCR_ZA_MASK;
+    aarch64_set_svcr(env, 0, R_SVCR_ZA_MASK);
 
     /*
      * ResetSMEState.
-- 
2.43.0


