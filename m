Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD4C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSu-0001nu-8J; Fri, 02 Feb 2024 00:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSq-0001aM-87
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:48 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSl-00021j-G8
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:47 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6dfebe2ed0bso324442b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853102; x=1707457902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oklbVSJHBuHU9hGmj0c6860U12/l0p2//g5ungqfTvk=;
 b=otiZEslkfmF/83oDlvRF6XIFN1bIY42qpi/0gxWUOs+zYul9hu13EVASxG2U6xBn3A
 pCWZwHd+BaFALtwOmDHp3iQMKJwyh74Pu7cQ3isEJxM48Mch4e4oIy23poGtTv7dacC/
 c106LaQ7DGhm6qDPxFFD9+t3o0J5UauAkIUMqc5sX0yWKkV5bCO+EUrEsk7+EgtsjwwU
 CEQqjnIkKAf1bTSKIbsbxwkiBh589uknbQz1PjfJse4j3Q9x+mBLuvdelZxeiZKhbPuk
 25iQ6XNvTyAvO3B+OCYotJttNtf029yjSXWIFN9Q1Sgnny68g3N5rNYKa0YmZf3TNmwd
 i9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853102; x=1707457902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oklbVSJHBuHU9hGmj0c6860U12/l0p2//g5ungqfTvk=;
 b=Y0uI/RqYHJcy4FaVBlzqaGSDEkcekYAm2dvQLgTpooQQcv28qBjlo9enNChZz8QlQ9
 7kIS74hDseLeVG4Bb7Ul+6DC46kx4HLvxvJsfVxOijwiBtLGsUMc1GmdeMh/2N+EQ3q8
 95Lml0jYyGOPbEg3dQP63kXK5ul59DHkmW2j1x38407WeXF5a/tbMXfJu4Tv+qBgxDEM
 191TMJ9xdiby5iJ5cWBHCc1sKZVflgKy1oZRtBHBbSKmc2IauO/SR9kIcLq+jpmuIiyz
 +uoBezjaCaWZbJJEkcYeqRqz3CbdGU2UBR/YAaM5ZCR55bNU1Z8uiN58YSVwiLkNcFjf
 3gpQ==
X-Gm-Message-State: AOJu0YxM/pGsrl2zvWnQ2/lq5SWayXPJzSSeqgg/f0y947x48GX01KwF
 si4ahGWcppQJFTkyyCAAVSjouoeIdHu75t7nEpqGmb19Hnb1mJZWfsm9Iu5Zp86c/jbqiJfb8Z4
 xpPU=
X-Google-Smtp-Source: AGHT+IH9G8eTVAi4dV+r/7JaqNaQr3qT8glARJtiYQV32X1GOHs3RZkuJwlOD4qVJlQVLI1L/r4XhQ==
X-Received: by 2002:a05:6a00:9291:b0:6d9:955a:d3bb with SMTP id
 jw17-20020a056a00929100b006d9955ad3bbmr2047067pfb.10.1706853101893; 
 Thu, 01 Feb 2024 21:51:41 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/57] target/sh4: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:07 +1000
Message-Id: <20240202055036.684176-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


