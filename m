Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2758C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb70-0006pG-KO; Mon, 29 Jan 2024 18:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6a-00067G-IA
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:01 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6X-0005Ad-Fk
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:55 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d75ea3a9b6so27846465ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571112; x=1707175912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNNENKH/HQj+hw6JTH28lUCmFQmGh5or2lvTAvTEZkw=;
 b=T2Uavm53nWw++xcqq73mP5KT7OM6qbF6z88B3NbCUFLeYLoVT7UYqkQ6EyK2Fknt9S
 6xJaqAS6qesioodjSDhEvzp2yUfzVrNtS7xMuyyjQwaNwagrVnCtf1ZfnZMDW8uk/cT9
 mYDtRbqlA8CGlZ9ZPbiL602IpbORvO9/waI884+D+lFU37b8C4pknZ5ujkgvy2phFLvY
 LJknPyOSwn5nCEo90K41Ftahj/A3HTIMbSXMf4Y6vysRkCxOdxZWtO9qOwMnQxYoCGMh
 jhKspJLfqOc4W7cofJyG7OGeavFVLGlH3coJc/9prsq5MhWIERzTcbdOPKnDm+jrYvVc
 4aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571112; x=1707175912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNNENKH/HQj+hw6JTH28lUCmFQmGh5or2lvTAvTEZkw=;
 b=ABAlH/A57X0f3VY6YOuHHxzoJV3JYcZb9XPrdou1vWuAkVK1D6lrjH9Mv0rU8x+cPI
 G/08oUdDjbwZT7DNiNsTLQ8Ed6ie6oTcsWlWbgbYtMS7USKsI5kDcqr13nlYActF+Ta0
 /DYhYsES52TodJKb3yY5nWeSJTh4W5jCNwPh7RYHtLMAlm/628Z7TjU5vgcT/aB6QVR9
 g5T2HAlmkWuG0yhmdOZpsQEnpZPIuuPU0c0sFZyUJNYOu2oEGtrZVqDZXlTBbBE6IBNp
 I+mbsENBozBrLweWoGxuw8rimmRwL23RXO1dlwiCT2fIC/IkG1dnFczwMb606fhxPQF/
 MXfg==
X-Gm-Message-State: AOJu0Yyc7peRGMdMiG57KurPEcBeBbFicl5KXRsx1E5hO2bZNi9pLax7
 5kKUjEp+0lLRp5bXVSMWoUxr6NCDFHAmhKaOcbtaChuShfmnJ9BJz2FUq3/pPYVKxAy/dUyZWo/
 chcU=
X-Google-Smtp-Source: AGHT+IEA8s3zPLl5CgEhOaWD8vCynTc+bHpj0vi+QeYfCMX2RAAMGsmPDFKousDVnaVic4GBcVC7BQ==
X-Received: by 2002:a17:903:2351:b0:1d7:428f:50fd with SMTP id
 c17-20020a170903235100b001d7428f50fdmr7656338plh.31.1706571112105; 
 Mon, 29 Jan 2024 15:31:52 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 28/33] target/sh4: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:38 +1000
Message-Id: <20240129233043.34558-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h | 16 ++++++----------
 target/sh4/cpu.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 0e6fa65bae..9c5e2b349e 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -273,16 +273,6 @@ void cpu_load_tlb(CPUSH4State * env);
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
-static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
-{
-    /* The instruction in a RTE delay slot is fetched in privileged
-       mode, but executed in user mode.  */
-    if (ifetch && (env->flags & TB_FLAG_DELAY_SLOT_RTE)) {
-        return 0;
-    } else {
-        return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
-    }
-}
 
 #include "exec/cpu-all.h"
 
@@ -380,6 +370,12 @@ static inline void cpu_write_sr(CPUSH4State *env, target_ulong sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
+int sh4_cpu_mmu_index(CPUState *cs, bool ifetch);
+static inline int cpu_mmu_index(CPUSH4State *env, bool ifetch)
+{
+    return sh4_cpu_mmu_index(env_cpu(env), ifetch);
+}
+
 static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 39772955b5..6fead5655f 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -89,6 +89,21 @@ static bool superh_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
+int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUSH4State *env = cpu_env(cs);
+
+    /*
+     * The instruction in a RTE delay slot is fetched in privileged mode,
+     * but executed in user mode.
+     */
+    if (ifetch && (env->flags & TB_FLAG_DELAY_SLOT_RTE)) {
+        return 0;
+    } else {
+        return (env->sr & (1u << SR_MD)) == 0 ? 1 : 0;
+    }
+}
+
 static void superh_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
@@ -266,6 +281,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = superh_cpu_class_by_name;
     cc->has_work = superh_cpu_has_work;
+    cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->get_pc = superh_cpu_get_pc;
-- 
2.34.1


