Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641B0C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSTs-00028V-R1; Mon, 28 Jul 2025 14:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPQ-0004rp-IP
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPI-0002oX-OT
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso4491142b3a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726622; x=1754331422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4+S7J9BtCEfIMC9GTPfnu5U0/LIAxmsC+ABvyfodl8=;
 b=bFFpRuYW1cDzJf7Bxji24WnHq/VcbjpxjFI5CLRynSlJXpAnJldASlC7+GyIxHk6kM
 y+YRGmNSkhXNhtCWX19fVIcbqBY+koG/An8gzG3pKpp8JqZ/QY24+pWl31dTqm9LOCKs
 Mn6ynFTkWgvb5iuUq8sFB4DZUFuHSeeCWWZcYCr3YRe+stl0UAB5Aq5Ir0bBU1A1sudk
 BerwMIpcpPIprcUwReRGpqcY7VDR0qRXA3Q9Vd0FwGIQmYopjd4e9k4W+dz0pT6Wjntv
 IRNmBL3SWg1kf2LxyHNhBDXZgYEBtMxmr1rI3mWswUGDexKvN0ibtkU/frWuFa5Zryfq
 I6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726622; x=1754331422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4+S7J9BtCEfIMC9GTPfnu5U0/LIAxmsC+ABvyfodl8=;
 b=XW+ueVBwvNjZeneQaQBZsfwDEQ8Lq7+95PMnNFT7A82NpJQ3aDktiQJIlZhu2bfoEd
 Pxiy2zHmWQTcuNynTX5G07dSl9CSvj/SdPwhjhYvVblb4kbTgs3dpPm0J788Yzq6oWhu
 2WDwpCbeJHSqX9GSMgH2XMYUfuazs3Fjbhz47X8MCA4nRyoprzst0coANJsc4uGGcVV7
 osPqJ2Ztmz3EOE6j3tAce6D78nKU+qHfuz0BpwqeHjemy/aOV8E5Gnes3P7KbaItuNf+
 Px5VHSaixh0xXTey6LB8CfOWxmmSSbeaZUyRaQ74nl4imYO6CXa06TQlEUO+cvQrkC0F
 gN0Q==
X-Gm-Message-State: AOJu0Yz6YsQ40JQAtxD4MB5DQw6vHRoLUReeW9+WimkshZNsI5Vo7oVP
 cCCC+M7m7RwvHs/mE6pGFJjCWxmsaJBHFqPQ/X+0WPeR7HSCXTaJp2cadv3ghQZzn323IwNClNN
 2hjEc
X-Gm-Gg: ASbGncuGAAxPnNM6wmb+ZFDFitqPxr1ayGcDeqNWvl7VSeUW1t7gpYkF2UIpWFKOe20
 4Yt/TvqRaRuG0fPVs0piw72kdOf+aYKuCTpjuuGW81Skmf4EbB9fFa4JyvAgwGPLgrtk+1b7DA0
 9LdxTqrFUfMF5q1aBR8cjaKGwpiBBxGuM8RFxXRqhwA+GyVpee4G4Tuw+MhWbMS6LqZVDWogiSu
 +WhaGuTa2xEKFJCt/v+23snHDNRMeKNBVSTOiojFfhfTua/dKYjJD4Udxmrt4wGsrUZ4qf9sEU6
 w96Vcf8fIa7LbwsOauxT2LUms9KgoLRpyj//yJn8OgGWFKL1AOZgqOpd9nomalsdUlg+cjt/u27
 PilAEQ1fU42WdJp5ZglJqQlvptgzs3xCSLSItvKjX7kqLmdSt4/eB3zyLtun5Gjw6P7ML8EAihl
 ZSJll/tQ2OGQ==
X-Google-Smtp-Source: AGHT+IE1iamK9hanr2gzNZ/XgRJoYLLP1hd5RL9dc/4z4U3v3xIwxHOCFCTJ6bFzJcG6EcAID0beew==
X-Received: by 2002:a05:6a00:1953:b0:748:2cbb:be45 with SMTP id
 d2e1a72fcca58-7633583028dmr15638923b3a.15.1753726622365; 
 Mon, 28 Jul 2025 11:17:02 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:17:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 6/9] target/arm/sme: Rebuild hflags in aarch64_set_svcr()
Date: Mon, 28 Jul 2025 08:16:47 -1000
Message-ID: <20250728181650.165114-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Message-id: 20230112102436.1913-7-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f4318557149184d6dac99e561acabcb602a84ee1)
---
 linux-user/aarch64/cpu_loop.c | 8 +-------
 linux-user/aarch64/signal.c   | 3 ---
 target/arm/helper.c           | 6 +++++-
 target/arm/sme_helper.c       | 8 --------
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 5e93d27d8f..2e2f7cf218 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,14 +89,8 @@ void cpu_loop(CPUARMState *env)
 
         switch (trapnr) {
         case EXCP_SWI:
-            /*
-             * On syscall, PSTATE.ZA is preserved, along with the ZA matrix.
-             * PSTATE.SM is cleared, per SMSTOP, which does ResetSVEState.
-             */
+            /* On syscall, PSTATE.ZA is preserved, PSTATE.SM is cleared. */
             aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-            if (FIELD_EX64(env->svcr, SVCR, SM)) {
-                arm_rebuild_hflags(env);
-            }
             ret = do_syscall(env,
                              env->xregs[8],
                              env->xregs[0],
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index a326a6def5..b265cfd470 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -667,9 +667,6 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     /* Invoke the signal handler with both SM and ZA disabled. */
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
-    if (env->svcr) {
-        arm_rebuild_hflags(env);
-    }
 
     if (info) {
         tswap_siginfo(&frame->info, info);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37e018e765..bc1c5a1f17 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6442,6 +6442,9 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
 {
     uint64_t change = (env->svcr ^ new) & mask;
 
+    if (change == 0) {
+        return;
+    }
     env->svcr ^= change;
 
     if (change & R_SVCR_SM_MASK) {
@@ -6459,6 +6462,8 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
     if (change & new & R_SVCR_ZA_MASK) {
         memset(env->zarray, 0, sizeof(env->zarray));
     }
+
+    arm_rebuild_hflags(env);
 }
 
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6467,7 +6472,6 @@ static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     helper_set_pstate_sm(env, FIELD_EX64(value, SVCR, SM));
     helper_set_pstate_za(env, FIELD_EX64(value, SVCR, ZA));
     aarch64_set_svcr(env, value, -1);
-    arm_rebuild_hflags(env);
 }
 
 static void smcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index 247c2823ac..bbda651974 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -31,20 +31,12 @@
 
 void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
 {
-    if (i == FIELD_EX64(env->svcr, SVCR, SM)) {
-        return;
-    }
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-    arm_rebuild_hflags(env);
 }
 
 void helper_set_pstate_za(CPUARMState *env, uint32_t i)
 {
-    if (i == FIELD_EX64(env->svcr, SVCR, ZA)) {
-        return;
-    }
     aarch64_set_svcr(env, 0, R_SVCR_ZA_MASK);
-    arm_rebuild_hflags(env);
 }
 
 void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
-- 
2.43.0


