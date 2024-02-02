Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06109C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSw-0001z6-4f; Fri, 02 Feb 2024 00:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSr-0001gp-Hp
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSn-00022S-3G
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d8df2edd29so1400108a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853104; x=1707457904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZopJS6n3q/61pFFTS+CrIcUuDwZWn1ir79UoNqgUhuU=;
 b=C9p3YHOL5k3UCUN77HHDofI+KPDLWwjZqwB61H7Uuj7cvsKd6ZNFL43/p4rEDjeFGy
 OuvEjfmLK7r8nh9rzb9zw3LFcshHa+m59t+BNoMVd1XxSMmFJzhWJyoU1YB8s3Vw0ftU
 ZxwmA8pL00EULvMuPvm/PbnsuSYN4wQiSj0xlHxQYs4JVRhjWGDPANwJ+OhrT+TUorJ6
 JwOw4c8FGXzzWG/gt675gqq+cTUUAGCWhdvA571egKC4Wc29cBMp2reUt7Pj1dHddklX
 TORIc5uOb/7fOLNPQd7VNU3sDhIFhS3ZHeQpkNy78sDzlb0Aaeyq9WKaRVG3HFVLGyJY
 3Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853104; x=1707457904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZopJS6n3q/61pFFTS+CrIcUuDwZWn1ir79UoNqgUhuU=;
 b=hBN8gJq1dx8PgDMYxdWK8IDVkBNXzHIV2uaavZWLgcGd/4cXMccLaWX8aBBaGuj61R
 KCL/ZIX75sZO17C7GPQV4jlu+4lPVQBqccIEkMv53rMbTl1MoTict8bYPHO2NzDy9SH9
 s2wN4xkIS2ySj4FErkKK1P8CVzvEaWCuODMMW+5nclvnBY5OW0ERJULP1uPbW2KMBFoG
 cmvzdgwZINJSlp65/FZj2jEYGKbe24jm++F+eZBITbbzT1vmGs1XOXMF5SaRKCJZdYvG
 FxbGiCc05ogPIT0Mzl4KWqmVnynhMgZZz3KBOZK14dqWLHB78wsHajsYscG0/iBqiBFd
 I5MA==
X-Gm-Message-State: AOJu0YyBv2U8jhk/AwguHuU6dmcf4vbAzvNWJXBx1x5CnIcuMhf5Z/jZ
 zMkSAAIG08tmMoz7vT96huZOky1Hg+1KaNsSR0ip5vaW0NwCerujjUkykpVCrDNcGAS/w8YAaZ3
 MQb4=
X-Google-Smtp-Source: AGHT+IHJ4s5JkbRIYBtmn1Xz6YrULqQCBjObvQu9XNv7psD2u/8bZpvhBrnxZCCp4CepXGrYfYQOdw==
X-Received: by 2002:a05:6a20:1e60:b0:19e:3343:43c4 with SMTP id
 cy32-20020a056a201e6000b0019e334343c4mr4350156pzb.36.1706853103931; 
 Thu, 01 Feb 2024 21:51:43 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/57] target/sparc: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:50:08 +1000
Message-Id: <20240202055036.684176-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


