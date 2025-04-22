Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB6FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR9-0001Sz-Gv; Tue, 22 Apr 2025 15:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOp-00053t-Mw
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:25 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOm-000717-7f
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2255003f4c6so63586215ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350513; x=1745955313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSsKhIFR7U782mMw16oJTtddZogsTKruKpBxDjg9WE0=;
 b=oerO1tZVaMf34yX/J7eiwa1OYPWlnpVr7aKctDtEt+QhNFZvMqma0f15/h62wi5+XX
 ajGy/VSflvKNkNXTtIn4vNXHBYlgyyN8IIrnkIeEysRGubRMJXyh+hqZmq20bx+aS/hf
 h5OlWnAU/QIkz3bkS7IHrJgV27Qhe6HjlLJOlbvwz4QfJUSD+WfSIX/HT7MKFxVn09t9
 l9lTujPD80LBr231DeIz28c/SwcV62kbHdwnHhE2Raf1bkoGrbhNkVVcffnVHzbobOZN
 zXMVD8Zh1berJbhA9ngrnFO5KNTRfzf89DtTZUkY3Eeuj2pt89ESKR6XThTa6mIwBJ4j
 EFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350513; x=1745955313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSsKhIFR7U782mMw16oJTtddZogsTKruKpBxDjg9WE0=;
 b=pl/byG9PzwvSMRipdkXcgVug/OwLza98nZl6j7w0J+TAmil9jYvUkfsvWw8Ntk16U8
 uVkV7Y6M/9DgiQ7vGf3WuUFPxbh0cbvayTHpvy7GSxH1SFF5c4uy0bIDTX9fd9oUCe+3
 wEjRpBKgzJznnPr37lEcTjDHzWMstS1V8E/tWjbsA7rKwZdCnqQpcQ8IQ5pjZs85HL8J
 1FXxF0ZaAvgYtvuxA1CcyXvqGlCavAtluROT3ZTRTn4Uhjf1oe5i04WX+RB6DsN80X9d
 F2jLyyCdlBXdThuQpYF68orOPkytWwSXfHHyNu247ouxFufxEvmcOq+hOlPW2jPY/8ns
 MO1w==
X-Gm-Message-State: AOJu0YyAwpKHh/0rcA+CXRQ7yFyI07/TxUn+JkVJ490T0rAQ+ut63t2c
 iaDAl3yQDdRHSE7wad2pWhYhPj7A1yg22DrTk/TOFrLMMKMuMDdfwz24H1385Z7BsZfBbm2teMf
 t
X-Gm-Gg: ASbGncvwjeRbBiDPJTjw4POwZOitYnWsoBg33Xye+CqWJtgcfkWZgnV4uDxGyZvP8Ue
 PCWw7U6aDRkicl2FJNPUBkxIJNIj/KeX0MMNw+ccwkzoGPhYJIp095jxpfl10SuMn6gvgmiKIxZ
 U8xjsR8vT+mPexxyValoXykv3bbCfca83gBbSxnm3OJNbuSOL72fDiGLqAXqqjydVSpuy15ilBV
 rWKugpnOdJPk/WluupTRHRQE8ivqr+RpYgZL1Ut7q69I/locel+E2T5/2hxQXvKALAlDdRO3Jfi
 XHMjmxE1PE2FKcM32CzlHZ2cCWhrS+UEP2chUpe3fptoQ6JfyaT+aQ8IJW+GpeAX0VP91AFSfTD
 tJ2OGuG72yw==
X-Google-Smtp-Source: AGHT+IGjQm0GKWw570XVulBwAzB6pftW75kzjSpnZQPFipm06E/R/8PY+CYJUd7pLEG2A/lIExx4+g==
X-Received: by 2002:a17:902:d58c:b0:224:1579:5e8e with SMTP id
 d9443c01a7336-22c5356e19fmr281295735ad.1.1745350513441; 
 Tue, 22 Apr 2025 12:35:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 080/147] target/i386: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:09 -0700
Message-ID: <20250422192819.302784-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move x86_cpu_mmu_index() to tcg-cpu.c, convert
CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-10-philmd@linaro.org>
---
 target/i386/cpu.h            |  2 --
 target/i386/tcg/tcg-cpu.h    |  2 ++
 target/i386/cpu.c            | 18 ------------------
 target/i386/tcg/seg_helper.c |  1 +
 target/i386/tcg/tcg-cpu.c    | 18 ++++++++++++++++++
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index db9f01a11b..9b8b962e0a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2597,8 +2597,6 @@ static inline bool is_mmu_index_32(int mmu_index)
     return mmu_index & 1;
 }
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
-
 #define CC_DST  (env->cc_dst)
 #define CC_SRC  (env->cc_src)
 #define CC_SRC2 (env->cc_src2)
diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 53a8494455..7580f8afb4 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -78,4 +78,6 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, pkru_state) != XSAVE_PKRU_OFFSET);
 
 bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
 
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
+
 #endif /* TCG_CPU_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b74b9a375..d930ebd262 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8652,23 +8652,6 @@ static bool x86_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
-{
-    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
-    int mmu_index_base =
-        pl == 3 ? MMU_USER64_IDX :
-        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
-        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
-
-    return mmu_index_base + mmu_index_32;
-}
-
-static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    CPUX86State *env = cpu_env(cs);
-    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
-}
-
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -8910,7 +8893,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
-    cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
     cc->get_pc = x86_cpu_get_pc;
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index f4370202fe..9dfbc4208c 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -28,6 +28,7 @@
 #include "helper-tcg.h"
 #include "seg_helper.h"
 #include "access.h"
+#include "tcg-cpu.h"
 
 #ifdef TARGET_X86_64
 #define SET_ESP(val, sp_mask)                                   \
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b8aff825ee..818653ee6d 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -94,6 +94,23 @@ static void x86_restore_state_to_opc(CPUState *cs,
     }
 }
 
+int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
+{
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
+    int mmu_index_base =
+        pl == 3 ? MMU_USER64_IDX :
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
+
+    return mmu_index_base + mmu_index_32;
+}
+
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool x86_debug_check_breakpoint(CPUState *cs)
 {
@@ -112,6 +129,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .translate_code = x86_translate_code,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
+    .mmu_index = x86_cpu_mmu_index,
     .cpu_exec_enter = x86_cpu_exec_enter,
     .cpu_exec_exit = x86_cpu_exec_exit,
 #ifdef CONFIG_USER_ONLY
-- 
2.43.0


