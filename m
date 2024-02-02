Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60E8C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSZ-0001He-Lg; Fri, 02 Feb 2024 00:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSS-0001GL-9f
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:25 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSP-0001o1-ME
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:22 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bea8d764d8so1042639b6e.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853080; x=1707457880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfNpPvlkxn2D3fI9cYf9hBQTlB/c6mteAgGLiKm11to=;
 b=U+bi+0jsO2Ph593Und3MkaG3KC71v+jFg5gwyHaDbyiom+nTpFaibZkH0qJRuTbSmj
 Toj0KIp0/x71uzH7iX6xmPwUpag6xIHSl9D70itvKl0jfLsFEbuW/FFNkEWUYIW+gqoH
 GTxh0wSSvvc4jJBx/kht+srJuG+BlleunkJNSBIpznh/wDkFFPKHSRs5yJOwbQ/J9fIq
 z/espw1IAm5gyFbOGNqZjJ5qSRei/GI70fdEFXt6qPI+aXUbrr/am9iTxqhrvxnwjHQ8
 nJ1YJkVNI5hJ3s0jP2ZghMOqorhNgIWrqex7c1stOxPx8JsRcWtrrbua8VckYU1oAbNS
 nRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853080; x=1707457880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfNpPvlkxn2D3fI9cYf9hBQTlB/c6mteAgGLiKm11to=;
 b=BoRuJfqM/aWvlikilOAm7mA6p70AeQSdx9cDYAg7mVbqPjBj8eMv6adWAyW3rbG6oJ
 NxQnCq0jKPwnDY0xQoh0DDP/2raXQ+7uLFikf1grvg7DFVL9wDRw2PQdIY/xcB4YlR9y
 oEO4TO7G3E3RAlE1eiIsIG4PM3/tWG2ShI/BMzx+9+CPbfLkKMccbJ5dOrF8JnwsNaBw
 8k7FufRfr2NuIALzxswIPE4OVvS49SnGg7UYJxL5h9qFFpc3+hx/JunALr5VSdgy3xsb
 DE7KQvmxxMAnDLT14KG/USUcz3dsIkhvF/s8PdUrg/2hEnIdyWlxC6vwGO3+9mCNbLvh
 7U6w==
X-Gm-Message-State: AOJu0YwUBnhSa+iBnxH87fPwZLRJVSO3VHmgAKTCHXSp5CZWLcRIVkJR
 9PRWT+VWq8D+LEtshv6rPXUzgJrSrmn6djpVgZYwgz80E7zYIUQomC0eY4AlpAGZe/yxt2hPoyw
 25Wo=
X-Google-Smtp-Source: AGHT+IF1q4Qp7PjjxROAZU8HylUgy+BBcILnA3oAGU/3XeUrUQaW4ivuZmiEZlPxBMM6P3iU921WAQ==
X-Received: by 2002:aca:1702:0:b0:3be:ba3c:809a with SMTP id
 j2-20020aca1702000000b003beba3c809amr7136093oii.34.1706853080222; 
 Thu, 01 Feb 2024 21:51:20 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/57] target/nios2: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:57 +1000
Message-Id: <20240202055036.684176-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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
 target/nios2/cpu.h | 12 ++++++------
 target/nios2/cpu.c |  7 +++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 2d79b5b298..9965ff74c1 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -270,12 +270,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
-{
-    return (env->ctrl[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
-                                                  MMU_SUPERVISOR_IDX;
-}
-
 #ifndef CONFIG_USER_ONLY
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
@@ -292,6 +286,12 @@ FIELD(TBFLAGS, CRS0, 0, 1)  /* Set if CRS == 0. */
 FIELD(TBFLAGS, U, 1, 1)     /* Overlaps CR_STATUS_U */
 FIELD(TBFLAGS, R0_0, 2, 1)  /* Set if R0 == 0. */
 
+int nios2_cpu_mmu_index(CPUState *cs, bool ifetch);
+static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
+{
+    return nios2_cpu_mmu_index(env_cpu(env), ifetch);
+}
+
 static inline void cpu_get_tb_cpu_state(CPUNios2State *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 596c0c5617..e42885997e 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -57,6 +57,12 @@ static bool nios2_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
+int nios2_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return (cpu_env(cs)->ctrl[CR_STATUS] & CR_STATUS_U
+            ? MMU_USER_IDX : MMU_SUPERVISOR_IDX);
+}
+
 static void nios2_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -381,6 +387,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
+    cc->mmu_index = nios2_cpu_mmu_index;
     cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
     cc->get_pc = nios2_cpu_get_pc;
-- 
2.34.1


