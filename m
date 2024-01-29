Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7372C47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6z-0006eP-Ps; Mon, 29 Jan 2024 18:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6d-0006BE-JI
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:32:03 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6a-0005As-A0
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:57 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-290b1e19101so3281998a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571114; x=1707175914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUpbcCo1Gwdi5RtgiHT0o/+TLFpXSWoQp1ADmvaIAeE=;
 b=eRr3aR97g1P5+ySHFEy/kK+B9hqTXLOA/Ia1x7v10uVy04UdifUX+40RaboUvdMonw
 L+SyEs1rvMKZk+FE1FXk8MWa7C5hQXzd80FOPVIbY183RfAav4XHCeY+eWSEr8iHefG/
 NtydjIIAPacTMDxrR28ue9RAS2XuZodLJsdESMEvvPFqzDqyvruJAJmFdVsfQa3sbJLW
 gSNCGDe63ZzIgqv9sNABf7H8YHSgrGJuyLCTozARgnTIlJcZzpC5i5lsX3bKBmgP/IZ5
 02Dzw+JjVCOXY9zzniXm81oVCSd2Y3V2gk8ZgYsCAvXLFVhj6nVx07HHmEy7kJkGUfAC
 B09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571114; x=1707175914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUpbcCo1Gwdi5RtgiHT0o/+TLFpXSWoQp1ADmvaIAeE=;
 b=bqqggRF89UpetZkM6/+xrfbabqWEU3at+araHKSih1JulZuA8GbL0LwyN+VuFQEeIx
 zUCh8BGDDFx2Afd47bD1YCs5LgLhhlGFT5Z3ZPucMcQvVdBkJYYDTvLcshWvKU8z2gs/
 JyEBETZ4uNMI2VbmapDPpDD7pmjqPsKLAlsW4yxZUmJrSfpH/xmA1T/67EhzLbPIFJ6i
 7JY/bBqlpZuGk18VlBaV+HoyvUTcaILCXGErTdfeSozXPcM6fk3BnkM/Jz/7R9aSTGwS
 CUzfEvGb68qTi0y0Sauv4//RGJsW93CgfSduWN7mZnZaqQoNQ4BwM/kL7SMAJHnqCzUR
 seMw==
X-Gm-Message-State: AOJu0YztWzoYiO/hm93vkgLV/f1/Z80Etos9KQZFbLciaXyH0/S7u0zK
 TskuclxY0YmJxolhUtXD6uocx9FK/cyza5T8Xlklat3odCqmWtrbypbhAmyY1hpVvh6uAnfbZHS
 hLsY=
X-Google-Smtp-Source: AGHT+IFW+/JiwHFFTRiKhroGzPNS5wC66nCN9prVjIt2Dm20vB3Nsj5WmAszJv8ufKbie9yyMSDA4A==
X-Received: by 2002:a17:90a:f0d7:b0:290:c94b:6667 with SMTP id
 fa23-20020a17090af0d700b00290c94b6667mr49378pjb.48.1706571114361; 
 Mon, 29 Jan 2024 15:31:54 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 29/33] target/sparc: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:39 +1000
Message-Id: <20240129233043.34558-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 target/sparc/cpu.h | 34 ++++++----------------------------
 target/sparc/cpu.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 12a11ecb26..92c58c92c1 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -708,34 +708,6 @@ static inline int cpu_supervisor_mode(CPUSPARCState *env1)
 }
 #endif
 
-static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
-{
-#if defined(CONFIG_USER_ONLY)
-    return MMU_USER_IDX;
-#elif !defined(TARGET_SPARC64)
-    if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
-        return MMU_PHYS_IDX;
-    } else {
-        return env->psrs;
-    }
-#else
-    /* IMMU or DMMU disabled.  */
-    if (ifetch
-        ? (env->lsu & IMMU_E) == 0 || (env->pstate & PS_RED) != 0
-        : (env->lsu & DMMU_E) == 0) {
-        return MMU_PHYS_IDX;
-    } else if (cpu_hypervisor_mode(env)) {
-        return MMU_PHYS_IDX;
-    } else if (env->tl > 0) {
-        return MMU_NUCLEUS_IDX;
-    } else if (cpu_supervisor_mode(env)) {
-        return MMU_KERNEL_IDX;
-    } else {
-        return MMU_USER_IDX;
-    }
-#endif
-}
-
 static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
 {
 #if !defined (TARGET_SPARC64)
@@ -777,6 +749,12 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_HYPER        (1 << 7)
 #define TB_FLAG_ASI_SHIFT    24
 
+int sparc_cpu_mmu_index(CPUState *cs, bool ifetch);
+static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
+{
+    return sparc_cpu_mmu_index(env_cpu(env), ifetch);
+}
+
 static inline void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *pflags)
 {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 7d0d629a3d..7a3b815737 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -718,6 +718,34 @@ static bool sparc_cpu_has_work(CPUState *cs)
            cpu_interrupts_enabled(env);
 }
 
+int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUSPARCState *env = cpu_env(cs);
+
+#ifndef TARGET_SPARC64
+    if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
+        return MMU_PHYS_IDX;
+    } else {
+        return env->psrs;
+    }
+#else
+    /* IMMU or DMMU disabled.  */
+    if (ifetch
+        ? (env->lsu & IMMU_E) == 0 || (env->pstate & PS_RED) != 0
+        : (env->lsu & DMMU_E) == 0) {
+        return MMU_PHYS_IDX;
+    } else if (cpu_hypervisor_mode(env)) {
+        return MMU_PHYS_IDX;
+    } else if (env->tl > 0) {
+        return MMU_NUCLEUS_IDX;
+    } else if (cpu_supervisor_mode(env)) {
+        return MMU_KERNEL_IDX;
+    } else {
+        return MMU_USER_IDX;
+    }
+#endif
+}
+
 static char *sparc_cpu_type_name(const char *cpu_model)
 {
     char *name = g_strdup_printf(SPARC_CPU_TYPE_NAME("%s"), cpu_model);
@@ -906,6 +934,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
     cc->has_work = sparc_cpu_has_work;
+    cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
-- 
2.34.1


