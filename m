Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2EBC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSZ-0001Hl-NE; Fri, 02 Feb 2024 00:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmST-0001GN-FX
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:25 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSS-0001os-1m
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:25 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3beb504c985so909887b6e.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853082; x=1707457882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tz+hZT+/jj7B5V0fs8mig9BK9nxx7zGxdWkFBgn124=;
 b=WdJEf4dzq4RaTvYC6zJkQgSq89K5j2/aGr2hWPPnsPkjhTOivr+m1R+LI0j7VMai73
 HpuHU9r1t2E6oa1fl+ZKyjOLAGiBdOBZYo0gtQ9H4VanpksyYP+Wy87X0J7rIzor7M6Z
 OxeUiX/aUbgjYz2gqwYRIEHLyEBVliuPw6+5c6AZDENAFRySsxOy8mBrZXso5+tXMXGy
 o+x6RsxFgFYH+stoAqY6lRNS2nRhsBuZDOT9qNOft+5vE/UN6lSLzMmX4Tm1JQkihYi2
 9LrM9MCaU+piwXuZb2i+a/X1Z6XXCdQx2fx+KM2TNibjbZuMgd3yttsbVr2o0HXl6WyR
 b0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853082; x=1707457882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tz+hZT+/jj7B5V0fs8mig9BK9nxx7zGxdWkFBgn124=;
 b=KKd2UMvgRDj241GgQJ4+213J/y+33jzeMe0ImFD7UJ2u7W1T/jhu1uItWRTdVN62tl
 nppDZ1lGhFM3Bskla9k8f3jc38j86JainxrWrQO9rYIaJ+aBz/gGX3UVpCk4LLnj9/WM
 g7PKxRHMaMJxjB+RGPSXnS7Zr6AvnjOdpxSB3ibzrwl99XxkIQCKPA/3nnn0uY9RtCJe
 w0TBi97/yYEdftUsytcslahi0N1eLlt1QAoVxrYmE4Fl+UeLtelBSE7Yvta6Cu8Zp1ar
 7K++mlYjB4k7EQ7PWAqEEbj38DW8xeAL+G524v2aP3+tJfkfeQcfJA0Xp4f5Ni/Eyzec
 WTNA==
X-Gm-Message-State: AOJu0YyUdFBUq+AOEmx3sur2dwasbyYRA/LkmIvcBuE0muBExSAUswGs
 5EhOZcyzhylehDBgUIS62fWOZnhM7u0vO2jk6t95HhYg8nexLlPFS4JhlriaoOOz+8ZuXh7Jbv+
 TjH4=
X-Google-Smtp-Source: AGHT+IFn5LB9C5Z8+1h902WWekza8vND9DBwFzX6tGKRPAe1+zHdIAv5qyp3+iLsyxGHJhJUhVM/4g==
X-Received: by 2002:a05:6808:2098:b0:3be:c43a:97c7 with SMTP id
 s24-20020a056808209800b003bec43a97c7mr7787786oiw.24.1706853082234; 
 Thu, 01 Feb 2024 21:51:22 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/57] target/openrisc: Populate CPUClass.mmu_index
Date: Fri,  2 Feb 2024 15:49:58 +1000
Message-Id: <20240202055036.684176-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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
 target/openrisc/cpu.h | 10 ++--------
 target/openrisc/cpu.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b454014ddd..7dbed8d8be 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -361,16 +361,10 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
            | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
 }
 
+int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
 {
-    int ret = MMU_NOMMU_IDX;  /* mmu is disabled */
-
-    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
-        /* The mmu is enabled; test supervisor state.  */
-        ret = env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
-    }
-
-    return ret;
+    return openrisc_cpu_mmu_index(env_cpu(env), ifetch);
 }
 
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 477d49d4bc..8670152c84 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -68,6 +68,18 @@ static bool openrisc_cpu_has_work(CPUState *cs)
                                     CPU_INTERRUPT_TIMER);
 }
 
+int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUOpenRISCState *env = cpu_env(cs);
+
+    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
+        /* The mmu is enabled; test supervisor state.  */
+        return env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
+    }
+
+    return MMU_NOMMU_IDX;  /* mmu is disabled */
+}
+
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->print_insn = print_insn_or1k;
@@ -239,6 +251,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
+    cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
-- 
2.34.1


