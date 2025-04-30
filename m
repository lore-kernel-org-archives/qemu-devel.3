Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B66C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcs-0006ZL-LR; Wed, 30 Apr 2025 12:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcK-0004zD-L2
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcI-0001uP-Pq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso173468b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031741; x=1746636541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5f/+riQnhACWMUBAaDr1xpPHpL32m6PvI3+ANicr5Rs=;
 b=AQv3rNEq9uVWX4N4khWo9+Gjuj6mOvXk4shVdZiYUjV9+q+YGmelQnwBEFtlE/elnG
 25ePBdinMIUJWU1+JO2znumyFi6bfmXnUYuiRlLmwwZonTJSm45gx7b3j2SPurm0bvz4
 KoZ2YgfvP5f7YMJfnZDcv/gRve0bFWortSVxJcAZNe+7XvBfYrSR5IBcJX8wh31rMgO8
 iQIHJXWOCMxXeL3KLyLv1uC5DF9OxzOdWYZOQ41DBkq2O+K7wwQiDRAeRMXdiC3BLW8A
 sGtNbl+tokGFg62KeDbJNQiDjauDJL6Js4Ua1e4XkWShavwbuEdgT17pkonefx69mhdd
 JCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031741; x=1746636541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5f/+riQnhACWMUBAaDr1xpPHpL32m6PvI3+ANicr5Rs=;
 b=WGmmpDTJJnGdce0qw3BtVWfVidaIZDEp9Dyf/LHdqrq8tj25UiChjAO4AipDzdW3oC
 JkSfKE2H6zVpYnqMQot3qu3IIvFeQo//X+U0IyBoRcIV0EE1uL1WHdpcRgeQulE072pI
 kS2M7Wg6Dd9/Z89S69a2kOjnwyIc4yku96rVfuPpHXwYRVm7EAsBVmCTy5OPIypJXDa/
 5FKpaGZW2QYQjkkBfEFnEi+5jKrtzCpw7wbVLkUAC1hXs1FknSHbugBFbEnBJkqDfuQU
 WF/ESCdE1D8dwdC1ujb0562KxURafEC+o+WqlBBN0m0MLVMa43oEVzWoWC6RkJoKUwZA
 eyBA==
X-Gm-Message-State: AOJu0YxvZ95ObrQWZsk9Hqq/zYExPppyKHrOFMtTM8WDz+yPk5zx6h0i
 hYoRvIlJBuJM1XfY1VO6BLvC1iCxPXmSk2MR16cqRNQoGNuuOycmwvEzou3xMU7phw/CKLbliCi
 z
X-Gm-Gg: ASbGncs7SwgSy9j2vzwZSyri8W0O7wqhic16hwsy0DHWe9Hh066MrTxIH5KyRuPoEX/
 HllFwXkT9u8tWVYy0qEU2oJG7ttvX58D0eynmUE9x13qpZobl1fRpSm0/V8Ps1+4ha3EV+Op+Fr
 GmQQ2IfUAy2X5/gXTFrG3ABki/0Ierh9r4V9LMjMARBn7XsRD54HMCctLCI1UQs/wpV29nvEKJ8
 TS7R8aDP7ydDkkujRSaaifiwW5d5resJIAyujVFB7EWs36SrbfH+E0dg+nSPOGrEtuufXFy8UC4
 jLyCvf4rfiykL+2+r1N9EoFJmmCbiVmP9JOgXKbWGB0+yBLZVJjDiWNKAKBuH9PAW10GoFwjHcs
 =
X-Google-Smtp-Source: AGHT+IHAUFLOalQwmsptYaqhImyWpM3L2Juli4ZF+qGkGy92TbQMptBm7ngzny10ECh7zQebBR5i7g==
X-Received: by 2002:aa7:8c05:0:b0:73b:ac3d:9d6b with SMTP id
 d2e1a72fcca58-7404616d99amr209914b3a.4.1746031741268; 
 Wed, 30 Apr 2025 09:49:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:49:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 07/16] target/arm: Unexport assert_hflags_rebuild_correctly
Date: Wed, 30 Apr 2025 09:48:45 -0700
Message-ID: <20250430164854.2233995-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

This function is no longer used outside of hflags.c.
We can remove the stub as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h  | 2 --
 target/arm/tcg-stubs.c  | 4 ----
 target/arm/tcg/hflags.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d3d84ffeb..382a4d1015 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1906,8 +1906,6 @@ static inline bool arm_fgt_active(CPUARMState *env, int el)
         (!arm_feature(env, ARM_FEATURE_EL3) || (env->cp15.scr_el3 & SCR_FGTEN));
 }
 
-void assert_hflags_rebuild_correctly(CPUARMState *env);
-
 /*
  * Although the ARM implementation of hardware assisted debugging
  * allows for different breakpoints per-core, the current GDB
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 93a15cad61..5e5166c049 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -21,10 +21,6 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
 {
     g_assert_not_reached();
 }
-/* Temporarily while cpu_get_tb_cpu_state() is still in common code */
-void assert_hflags_rebuild_correctly(CPUARMState *env)
-{
-}
 
 /* TLBI insns are only used by TCG, so we don't need to do anything for KVM */
 void define_tlb_insn_regs(ARMCPU *cpu)
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index e530f65ed7..5315264c28 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -499,7 +499,7 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
     env->hflags = rebuild_hflags_a64(env, el, fp_el, mmu_idx);
 }
 
-void assert_hflags_rebuild_correctly(CPUARMState *env)
+static void assert_hflags_rebuild_correctly(CPUARMState *env)
 {
 #ifdef CONFIG_DEBUG_TCG
     CPUARMTBFlags c = env->hflags;
-- 
2.43.0


