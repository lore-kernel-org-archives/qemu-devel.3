Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C75C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVqP-0002BB-EG; Thu, 15 May 2025 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVns-0005i3-Ua
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnr-0008JC-2D
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so6131835e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304816; x=1747909616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uHg4ycwbPf3C1Edy5OlGts+9E0FlfMfrBWAhEu26MCU=;
 b=wRWdeD4yrNAZm409NdYr9UHWwVR9LbyZ5UpcpNSW/naqeQ8l7SlmhkOiok5d+oGi5R
 K1F6E37pDfbX1s/Nb97dWrUgbnnsY6RK+suk/U8pSEdD82YT98I7gMJ2uzG8nUFPf0rl
 R/62kzoXlhFwv5G/Dw2c3kNndj8BAQ97xri7qlQ/oGjkHCD6nf6K8ak9pimkmCpeVezP
 0Rfh08LK3H7MYxS3gfwh6nNxjW95Yf7XVvwU/LzIglDI5Ppsom0oNX8CkUNoFEX2aPbq
 PEcDPp9QamATMpg55+/HOSxTG1U0gVXyUvoN5zjcTzdn5UsS0LGBBxuiibl4kuhJOllb
 rNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304816; x=1747909616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHg4ycwbPf3C1Edy5OlGts+9E0FlfMfrBWAhEu26MCU=;
 b=e+rZSmGitVRoOs6JUCh+uGQ5eiGTQT2WebvTtFARUnxNNbXPkw7Tjd+cIO5dYSQMJn
 ixeacJMw4AN4ihvihDKsP2YfKxwsPvb0MfQeWhxpaOZQ6WBTEdszofO/Fbt40Nhi2vou
 d6DAgosIYg+lsWT3vrujxujSSFjCJckMF8J1GbXZPy2wJh9dn1Ww+ut+/TFfdSxW6VYD
 W7h79ROeCi5X5ceTgi+pXRtlo8seqdyjahPJWkT8E98IguBGnbFKmJQT+ELoSTEzOrlj
 /hDVtjwF5DJoWDK6/fVOlTdDlprwBrD6K/eRzeNhP5Csjc47sfvOaAd+uiMQdVJIIJyX
 F6nQ==
X-Gm-Message-State: AOJu0YyL1txJzk+gt5Q0q6jCf/gC2OgyeVIuwggHGBxIc/GSoPIZN/EQ
 Lu2ZluFmwulVyr2t7zofNHUWmfCDnlzhoD33goBGjYekv/7CAwBLufguAcD2ZYDTOTbBxzjyo2E
 zn8g=
X-Gm-Gg: ASbGncsJI10ANkaD2zKl6u4+s6p01RqQnofqfa10ivJltMq5PGr+QAWbmKlDFbD0fiq
 /fmn727wl5n1X/mBKrJ9FpPXm9CrbPU+1YSwLgnt2RNekAGN7XohhsOABXvqOFdyMZtAXWfo+3d
 J30AZ+l9S27j3bPc4H7uZLIGT0RaNc1Gpm1ji+1ttnZgg3Y52xX3omhwe0WX4jQt6TZKdCWgig4
 9qB9go08f9lLcx7Ls9E607rh6NqpZNVOD307mOePDxHCnIEH7kO63V1BNqYaBk19BlkAaEeexnc
 eTcjHtTYdYmXEjYzcXi/XEU0lnjinstbC5uTwBDUn7LgETyjIFlEQgBy+g==
X-Google-Smtp-Source: AGHT+IHphXRO6E7WetKpMoSy5DAY8mFhrOwUbXKNOdQsU4mKfXn6p1POMAcLKHj0A3INkdvjetUNsQ==
X-Received: by 2002:a05:600c:c1c8:10b0:442:f989:3dfb with SMTP id
 5b1f17b1804b1-442f9893f2dmr7997995e9.1.1747304815772; 
 Thu, 15 May 2025 03:26:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/58] target/arm/tcg/tlb-insns: compile file once (system)
Date: Thu, 15 May 2025 11:25:44 +0100
Message-ID: <20250515102546.2149601-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

aarch64 specific code is guarded by cpu_isar_feature(aa64*), so it's
safe to expose it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-47-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 7 -------
 target/arm/tcg/meson.build | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 0407ad5542d..95c26c6d463 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -35,7 +35,6 @@ static CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-#ifdef TARGET_AARCH64
 /* Check for traps from EL1 due to HCR_EL2.TTLB or TTLBOS. */
 static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
@@ -46,7 +45,6 @@ static CPAccessResult access_ttlbos(CPUARMState *env, const ARMCPRegInfo *ri,
     }
     return CP_ACCESS_OK;
 }
-#endif
 
 /* IS variants of TLB operations must affect all cores */
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -802,7 +800,6 @@ static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae3_write },
 };
 
-#ifdef TARGET_AARCH64
 typedef struct {
     uint64_t base;
     uint64_t length;
@@ -1270,8 +1267,6 @@ static const ARMCPRegInfo tlbi_rme_reginfo[] = {
       .writefn = tlbi_aa64_paallos_write },
 };
 
-#endif
-
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -1299,7 +1294,6 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         define_arm_cp_regs(cpu, tlbi_el3_cp_reginfo);
     }
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_tlbirange, cpu)) {
         define_arm_cp_regs(cpu, tlbirange_reginfo);
     }
@@ -1309,5 +1303,4 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_rme, cpu)) {
         define_arm_cp_regs(cpu, tlbi_rme_reginfo);
     }
-#endif
 }
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 49c8f4390a1..5d326585401 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'tlb-insns.c',
   'arith_helper.c',
   'vfp_helper.c',
 ))
@@ -68,6 +67,7 @@ arm_common_system_ss.add(files(
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'tlb-insns.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
-- 
2.43.0


