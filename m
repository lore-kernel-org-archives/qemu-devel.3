Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D32AC4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 07:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWA7H-0007Fj-Ce; Sat, 03 Feb 2024 02:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7F-0007FJ-CD
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:05 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7D-0002Ye-Gv
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:04 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-59a31c14100so1647302eaf.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 23:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706944021; x=1707548821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feIMwZZuJaZeuQQNwrSNZ0xC8edpfaps/dCYuWi4Jd8=;
 b=hOxkuPaPI6jCscsWV/ZDWfhMxIDR9ZiDNJDu+9nTBBN2gws6nOqFRbJOtS5c09bJkm
 qDh/clPq9aDpLQBGCkJ10wC+eLrC895a+x83wODwjJLBKn7RwnvZYFA4wHEugZXAja6y
 NdTbc/mnjTxrnvUD5jq/TIz8r+X53FbS615Vr0ac5pROwNL59x5YIWw/+pTZqazyVJbU
 TX0Kv9gJAnLap0liUCTs6j54oKi/Noq6f5LaxRoJ5yq2gzvw6/IcLrTxT2PpjhIiXIMF
 2U8nzneF209MSx0gLysRjEVCLx/7ki4CcZ+osYpP2F9CJ0TTklFCBuybkDXoyM817Ihl
 oX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706944021; x=1707548821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feIMwZZuJaZeuQQNwrSNZ0xC8edpfaps/dCYuWi4Jd8=;
 b=LSXlj4DPSqOJknCHuzA7S1rJ8SUqeZQPdCH1on1PCvTmsvcaWp6oYWgREmuCfOmu79
 dVmZrdhQvwXmykvVZkdBhQjLl6f1WLTVQJTeqyZILMoiRnZNSvwdJ+Co/Jh5OKZfp0Cq
 7WZtq1+yJemSPVj0K+tUFUcUEr60LNjOl3HSGXO7Ph6hnt7eDbseCUbhJlTeIi6YlfbL
 h8XxdOOy0P9Yazo7xEEkQTMvFY1rpC9rrnAS9cwEghOzThgjMyXEFQrn6q38OybidUbw
 wa0lIVEPHHTDDpbGHu0I3/nJafBsUFzOzjeQl7qN+VRTmQZr2eZSKn3QyaXaiKOW7leI
 W0Iw==
X-Gm-Message-State: AOJu0Yy5DRNtPK8QzWCvVQiCDxOE+nicj7wh0Vqx3tj+ZQ7CTRD3L26E
 vPjJMW1w9iCpqm2DmBU1o7JrYLSc5B1AGDneJhopA1ebvr8V+N31jN01JPwaCNo5X+0kvVQEERL
 eB0s=
X-Google-Smtp-Source: AGHT+IF/hNzPldqsGZJETSACJ3XlFwVZKE4LOh4DjswToTzR5ENW4v9TzblXp74i5RYLScuJWHfCLA==
X-Received: by 2002:a05:6359:4c0b:b0:176:543c:8ef0 with SMTP id
 kj11-20020a0563594c0b00b00176543c8ef0mr11682486rwc.21.1706944021428; 
 Fri, 02 Feb 2024 23:07:01 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d08b00b001d94665e9d3sm2658034plv.45.2024.02.02.23.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 23:07:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 12/58] target/loongarch: Rename MMU_IDX_*
Date: Sat,  3 Feb 2024 17:06:52 +1000
Message-Id: <20240203070654.982407-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203070654.982407-1-richard.henderson@linaro.org>
References: <20240203070654.982407-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The expected form is MMU_FOO_IDX, not MMU_IDX_FOO.
Rename to match generic code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.h                                 | 8 ++++----
 target/loongarch/cpu.c                                 | 2 +-
 target/loongarch/cpu_helper.c                          | 4 ++--
 target/loongarch/tcg/translate.c                       | 2 +-
 target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5dfcfeb3a4..47fd110e81 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -404,15 +404,15 @@ struct LoongArchCPUClass {
  */
 #define MMU_PLV_KERNEL   0
 #define MMU_PLV_USER     3
-#define MMU_IDX_KERNEL   MMU_PLV_KERNEL
-#define MMU_IDX_USER     MMU_PLV_USER
-#define MMU_IDX_DA       4
+#define MMU_KERNEL_IDX   MMU_PLV_KERNEL
+#define MMU_USER_IDX     MMU_PLV_USER
+#define MMU_DA_IDX       4
 
 int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
-    return MMU_IDX_USER;
+    return MMU_USER_IDX;
 #else
     return loongarch_cpu_mmu_index(env_cpu(env), ifetch);
 #endif
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e96159943a..49ced9888e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -382,7 +382,7 @@ int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
         return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
     }
-    return MMU_IDX_DA;
+    return MMU_DA_IDX;
 }
 
 static void loongarch_la464_initfn(Object *obj)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index f68d63f466..b0658773b0 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -171,8 +171,8 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                          int *prot, target_ulong address,
                          MMUAccessType access_type, int mmu_idx)
 {
-    int user_mode = mmu_idx == MMU_IDX_USER;
-    int kernel_mode = mmu_idx == MMU_IDX_KERNEL;
+    int user_mode = mmu_idx == MMU_USER_IDX;
+    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 235515c629..58674cb268 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -125,7 +125,7 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
         ctx->mem_idx = ctx->plv;
     } else {
-        ctx->mem_idx = MMU_IDX_DA;
+        ctx->mem_idx = MMU_DA_IDX;
     }
 
     /* Bound the number of insns to execute to those left on the page.  */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 01d457212b..7e4ec93edb 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -323,7 +323,7 @@ TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
-    if (ctx->mem_idx != MMU_IDX_DA) {
+    if (ctx->mem_idx != MMU_DA_IDX) {
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
         ctx->base.is_jmp = DISAS_EXIT;
     }
-- 
2.34.1


