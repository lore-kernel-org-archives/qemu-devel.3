Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80708C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3ox-0003XZ-8z; Wed, 05 Jun 2024 23:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3op-0003WY-Rf
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:40 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3ok-0003mF-3C
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:39 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c19bba897bso384822a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717644570; x=1718249370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24NTC+fN8JzFiuW9KudaNDXejfk5/YoKTwKq+1qKbsQ=;
 b=GPePFfqNGpw0Z7UCbbB9DOwlCHesdtDco0sJcyAhhE6AJ2jS+pNKHjnMXRmgX+NHQ9
 rlILIrIVZyNPU/rz/DM2kRNn+dbFUKNBD9LCDPU1j0fIoJ0mxQ955+pi+sSu1ta48WLB
 Jd2StjxoQzTy7gtZsRIprmOMOT3+QxtLIm9hodR9vgQQ+eXiKNTn4pDSiducU/i9REDN
 mJYEIw28rzKcQXYMk2/3S2DyemRtsI/DPCCmyRiG/jM1Othat6XxWxTqwzmam/JfPGw1
 wV/cVk/HqfW2s42obybbcVNgPRz0dbx8p+aBKXGHErUlu9upD7nUbF117sfdO/xBESy2
 gCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717644570; x=1718249370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24NTC+fN8JzFiuW9KudaNDXejfk5/YoKTwKq+1qKbsQ=;
 b=JIkBG4lZswPzN4DR3hf2M+tSxOP8CnuIKTn4IkK91NSEZNM9+1yvFqH2r6dMXMjHrR
 ejdZovpfz+6y7/c56FnjGQhpxVkRHkQYwPWntntuMBCYn2EYzAsjOI7YDod5EsHnAvAM
 ZR06vUeR+EP2lAFKMgzxW1UEem8gYBp/mNYBc7CPDQsS3FFA9Uu2OUy7Fg0UXsXQYRWd
 ZJ6Uu1QA6TeKlQDZ9WYQZhGhL104oXt/HH+EgKax5alg7kYbCeBpZgo5CbRjO1n6MMjf
 RcNqvxWCW1uDJiivzBv2rH1PE7o6wAvNHwwTbsVXqXlmwOLjwzndVVqDT2BKtnYSYYGz
 O3+g==
X-Gm-Message-State: AOJu0YyP8ZsXn+oKxUJ6zDG5GWE/s+kjVkeP1x004n6fe3NCiY5/BU9g
 5/Ulf6BwVYvsInXpZd2ek5HMgBYgJso0ulN0YHOLcYNjfLHdHRDds3PfEe28zSzCgF3kuy6Acq8
 +
X-Google-Smtp-Source: AGHT+IG0ysLn1nwVWmh9DmbDAuoGHY+/ihv70sNdjdfBbERwnCyrNGpfdwRiYrAlLGwP2lVyEq6CVw==
X-Received: by 2002:a17:90a:df91:b0:2c2:4114:fe35 with SMTP id
 98e67ed59e1d1-2c27db68097mr3849035a91.47.1717644570531; 
 Wed, 05 Jun 2024 20:29:30 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c254a76729sm4826265a91.0.2024.06.05.20.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 20:29:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 3/9] accel/tcg: Return the TranslationBlock from
 cpu_unwind_state_data
Date: Wed,  5 Jun 2024 20:29:20 -0700
Message-Id: <20240606032926.83599-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
References: <20240606032926.83599-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Adjust the i386 get_memio_eip function to use tb->cflags instead
of tcg_cflags_has, which is technically more correct.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 9 +++++----
 accel/tcg/translate-all.c | 9 +++++----
 target/i386/helper.c      | 6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 815342d043..c1887462e6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -189,12 +189,13 @@ uint32_t curr_cflags(CPUState *cpu);
  * @host_pc: the host pc within the translation
  * @data: output data
  *
- * Attempt to load the the unwind state for a host pc occurring in
- * translated code.  If @host_pc is not in translated code, the
- * function returns false; otherwise @data is loaded.
+ * Attempt to load the the unwind state for a host pc occurring in translated
+ * code.  If @host_pc is not in translated code, the function returns NULL;
+ * otherwise @data is loaded and the TranslationBlock is returned.
  * This is the same unwind info as given to restore_state_to_opc.
  */
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
+const TranslationBlock *cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc,
+                                              uint64_t *data);
 
 /**
  * cpu_restore_state:
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fdf6d8ac19..45a1cf57bc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -243,15 +243,16 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
     return false;
 }
 
-bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
+const TranslationBlock *
+cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data)
 {
     if (in_code_gen_buffer((const void *)(host_pc - tcg_splitwx_diff))) {
         TranslationBlock *tb = tcg_tb_lookup(host_pc);
-        if (tb) {
-            return cpu_unwind_data_from_tb(tb, host_pc, data) >= 0;
+        if (tb && cpu_unwind_data_from_tb(tb, host_pc, data) >= 0) {
+            return tb;
         }
     }
-    return false;
+    return NULL;
 }
 
 void page_init(void)
diff --git a/target/i386/helper.c b/target/i386/helper.c
index f9d1381f90..565e01a3a9 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -521,13 +521,15 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
 #ifdef CONFIG_TCG
     uint64_t data[TARGET_INSN_START_WORDS];
     CPUState *cs = env_cpu(env);
+    const TranslationBlock *tb;
 
-    if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
+    tb = cpu_unwind_state_data(cs, cs->mem_io_pc, data);
+    if (!tb) {
         return env->eip;
     }
 
     /* Per x86_restore_state_to_opc. */
-    if (tcg_cflags_has(cs, CF_PCREL)) {
+    if (tb->cflags & CF_PCREL) {
         return (env->eip & TARGET_PAGE_MASK) | data[0];
     } else {
         return data[0] - env->segs[R_CS].base;
-- 
2.34.1


