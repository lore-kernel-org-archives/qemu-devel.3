Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D85C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb69-0005k4-G2; Mon, 29 Jan 2024 18:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5t-0005UC-L9
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:22 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5s-00052S-34
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:13 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d750660a0aso14296275ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571071; x=1707175871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WexDgLCM7IRsjNLi1wAJoGpQCSOk7DFJRsVIQhRYNU=;
 b=V4X37UqiYFgQMacj6ZogKkU/PG/YvQMsBdg7ZZ+rWOXNrrwpYXbdRoRiRoWUOlsZdd
 Uj9LdFeFPv5f8dfUboX9qVbdelotfsbqjyRKFpsJOZ7jVDuX9HcYDo4i8L8rzrj/9Vog
 wMviTUsHWBo2Kaih4EO+Yxv05iU0RXqbi/QqYXqVrvl7saRdsyIPpGiyi3fWyKg+4i67
 xDwdlX646ZgZ38sXGstYrkSVlXMCMkJDVlbTbLoG60dc+Dj26UkW4xA+gfOtXInvA3x5
 0yV24hS56+hOzt0m3OYzlUbgwnoXjAqsOKgRmONvg7ZuwQrrvevKSZ2jaI0HGbhnxH4i
 Je7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571071; x=1707175871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WexDgLCM7IRsjNLi1wAJoGpQCSOk7DFJRsVIQhRYNU=;
 b=CwZZLlS4hhHTqnfRgOQivlP/JOprKfWOmqqqzstdLlByiu6gY1CpUN3jX2gB9XWlvJ
 D0lp48iJJKW3RvbY69LA61Dqjgxaiu31chG7xVnTue+8p11MIT44u+IUY137J6XAsASP
 Nw9gi8JPkMxyThx71KIaYD6A4QAeViWZW/4Y/7eA7rJxBkTeo5K08LuYcRoew3ByIWDm
 BS+Q82pgcLs6b2yWRNI7vb9M8kpKd9Z8Ax3Vm8RhYBqSr/w6/lbjppBhSTU9BPrK2IjQ
 XZcFCJ6Dwj/ZaRHUUdsHXiM69GlecM9KlOzjMUTSwFuolri6jsRLfzaMMmG2IUJseKqQ
 3aNg==
X-Gm-Message-State: AOJu0YxF+3fd8+gr5klOeLHWLKPWf5Lw6ylsjnLtMbHrAcxjyGlG2QzT
 wNm9s4CVtxLv/XEtErCLDIsW57Y/ADLli/lW+EUGZfL+/hH984WkQ8r1Qclz8Sizd6wVEuzZbdy
 zVgA=
X-Google-Smtp-Source: AGHT+IGX4KunhRdM2W849kKN4U/oIfTk9Rslx/McIR9jCzUmlzGLmpW6+Ib5cr2rSDw1vcO2OU8IrQ==
X-Received: by 2002:a17:903:2449:b0:1d6:9bad:ff88 with SMTP id
 l9-20020a170903244900b001d69badff88mr5100660pls.110.1706571070891; 
 Mon, 29 Jan 2024 15:31:10 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 10/33] target/i386: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:20 +1000
Message-Id: <20240129233043.34558-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 target/i386/cpu.h | 13 ++++++-------
 target/i386/cpu.c | 10 ++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b9..62bdb02378 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2296,13 +2296,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define MMU_NESTED_IDX  3
 #define MMU_PHYS_IDX    4
 
-static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
-{
-    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
-        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
-}
-
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
     return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
@@ -2322,6 +2315,12 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
+int x86_cpu_mmu_index(CPUState *cs, bool ifetch);
+static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
+{
+    return x86_cpu_mmu_index(env_cpu(env), ifetch);
+}
+
 static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 03822d9ba8..280bcb7d00 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7720,6 +7720,15 @@ static bool x86_cpu_has_work(CPUState *cs)
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
 
+int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUX86State *env = cpu_env(cs);
+
+    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
+        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
+        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+}
+
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -7954,6 +7963,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->has_work = x86_cpu_has_work;
+    cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
     cc->get_pc = x86_cpu_get_pc;
-- 
2.34.1


