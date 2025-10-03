Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BC8CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLG-0006eY-Dh; Fri, 03 Oct 2025 13:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jIl-0002sE-7b
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:40 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGs-0006Kd-CG
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:10:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-269af38418aso29203135ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511312; x=1760116112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyVn2pevWW2Uc+hiIrO4yPhGWtHB1lo+8PFC6UVXThQ=;
 b=lylFJfrzFXC7ws0lfFlO67gl8syUSMEDrVTy+eA3HluCXpQwqQOBC6xJQRavgd+ybk
 7ijYOfVoRWgfTSiv1mOLiYKrjz0oKeWAvLCb/o2BYsVqRBHzimyriZiO+2eJNSE4khX/
 kFsXjwdA3XzUrt2lRaISfUUiJpISUG3RIbyWxZpxjKlJOrKwEr6laWdH9qwbmwOkSZWA
 pkPYbA0i8V4J8fhyBP66yLDa7QKtaJ/iBA2zaINzkfAgEOs5lyUGkOS4ziOw2k01OtGp
 Bx2Bw8ppxeiVputtWPC31cnR88Nol5hj18sKkjRDOlKRHtgT7dgYoL9ZnDBq8JtodLD2
 4AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511312; x=1760116112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyVn2pevWW2Uc+hiIrO4yPhGWtHB1lo+8PFC6UVXThQ=;
 b=liliBTePDpGRmMan4I9S/gBRyPf9FQPML299drljB+G+9wY/CaforYBLXDGAytwfqM
 bivUw4FT4SHwBdpuPYw9z8AD/RVYwKnWqpDiqRNpeTacrFhQzeNFP3LD2x6OlZ2rPtI/
 I/kZNaNC+DTzajnFQ3SUtZgaJEEaTWVOfechgKFDXiKEL2S8pTHh8dZuhJWDk2XyM+Gk
 EtPLwXOiNvTDEA2JWACo8FO8ba2ErXV3WUylRj3VrItW0aKinUPKHBKahZTqg6/9QKu5
 OTTb2ELCqDk0nLTU1JRcoZVSubNnmJo/D9LCsleWFZ8h3cKkJtn06FqU4mt7GENjfmt0
 q8AQ==
X-Gm-Message-State: AOJu0YzUTZo/hD/XT64za8axztAoFiM88tAb3ruGIr62FdprdzX7R4Lf
 gosEVYDFQm/BXSPkXP+qYemgXouCkzoFUcD17koRauVEf58uj/8MKqRb39CI1HLeS76D5TBozOZ
 u6vA4DYQ=
X-Gm-Gg: ASbGncsHypltzNSySEjb2VQqKG+O29yxxp1Swhdg03r8eh8ZB7FffMDyx9//nSLqxAf
 IeAMTzinzFGQKhwMNbNLuB05MOy1mA7SgAvLjzg/ffrs6chRoJpgwaF0YtOgkOWOrH0sL+y8ryZ
 uHdPto9WsEOO+UfpDx/l5Zn0Sd/5Zw4FOtyVBt6PDR0B51Ii5Nnpfv4CAt4L9HD0a4nf5scBkom
 JI1ST/rQ8Hm7ryt8C6gdd8eYLatGPbYhb8n4NBt/DU3RODtWe88nvPTVLdphod3vWeJ9isl56xz
 HpNsxXI8SaoHWoUbYYn42xgknitTsT62r4h3/I5P9WFnnRCeMb4IYpc+lTw4vU2QcZltuXBc+3A
 w0NDTZDrb/Ti0cBgvUiiNU+eNQRwQw4JMmsYfF7WFCEsLkb0suKvREhhA
X-Google-Smtp-Source: AGHT+IEn3xsFbSjeztj7fAVN7g2W2jhWzcRuzwN60n4+y1er0VhbwAie+bJ5Lta8PXJ84lZq7y6EXA==
X-Received: by 2002:a17:903:3bcf:b0:273:1516:3ed2 with SMTP id
 d9443c01a7336-28e9a6dd480mr40206615ad.50.1759511312407; 
 Fri, 03 Oct 2025 10:08:32 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 35/73] target/arm: Export cpsr_{read_for,
 write_from}_spsr_elx
Date: Fri,  3 Oct 2025 10:07:22 -0700
Message-ID: <20251003170800.997167-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Move cpsr_write_from_spsr_elx from tcg/helper-a64.c to
helper.c, so that it's present with --disable-tcg.
Declare both in internals.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  2 ++
 target/arm/helper.c         | 20 +++++++++++++++++++-
 target/arm/tcg/helper-a64.c | 20 --------------------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 109aa104bf..2a85ab762d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1897,6 +1897,8 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
+uint32_t cpsr_read_for_spsr_elx(CPUARMState *env);
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val);
 
 /* Compare uint64_t for qsort and bsearch. */
 int compare_u64(const void *a, const void *b);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f27940acc3..1c3e88aaf5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8890,7 +8890,7 @@ static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
     }
 }
 
-static uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
+uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
 {
     uint32_t ret = cpsr_read(env);
 
@@ -8905,6 +8905,24 @@ static uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
     return ret;
 }
 
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val)
+{
+    uint32_t mask;
+
+    /* Save SPSR_ELx.SS into PSTATE. */
+    env->pstate = (env->pstate & ~PSTATE_SS) | (val & PSTATE_SS);
+    val &= ~PSTATE_SS;
+
+    /* Move DIT to the correct location for CPSR */
+    if (val & PSTATE_DIT) {
+        val &= ~PSTATE_DIT;
+        val |= CPSR_DIT;
+    }
+
+    mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
+    cpsr_write(env, val, mask, CPSRWriteRaw);
+}
+
 static bool syndrome_is_sync_extabt(uint32_t syndrome)
 {
     /* Return true if this syndrome value is a synchronous external abort */
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 6d77fd0113..eaea7859d3 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -615,26 +615,6 @@ static int el_from_spsr(uint32_t spsr)
     }
 }
 
-static void cpsr_write_from_spsr_elx(CPUARMState *env,
-                                     uint32_t val)
-{
-    uint32_t mask;
-
-    /* Save SPSR_ELx.SS into PSTATE. */
-    env->pstate = (env->pstate & ~PSTATE_SS) | (val & PSTATE_SS);
-    val &= ~PSTATE_SS;
-
-    /* Move DIT to the correct location for CPSR */
-    if (val & PSTATE_DIT) {
-        val &= ~PSTATE_DIT;
-        val |= CPSR_DIT;
-    }
-
-    mask = aarch32_cpsr_valid_mask(env->features, \
-        &env_archcpu(env)->isar);
-    cpsr_write(env, val, mask, CPSRWriteRaw);
-}
-
 void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
 {
     ARMCPU *cpu = env_archcpu(env);
-- 
2.43.0


