Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3567ECD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbdk-0006xR-3p; Tue, 19 Mar 2024 11:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdL-00060C-B6
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdD-00053F-42
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41413f7b2dfso14209355e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863040; x=1711467840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7owAJrs+Pq1wtN5iEuRd7D9oJWUcLUFndnuD7FxVak=;
 b=CxT1DYqduBuo7jh1s3Atk2ea4hwd8bl8FQSlasG5Y+TlwP4GAYi+1WLElSpNoyQcZW
 Xv8NGDFynY7Z3qn2M0Vmd8N3OXgOI61TknkB+nsZhU7tFGmtF2Kt6BQVfRs4OfIZS8/y
 8e9mDs0bOu7YpNSH0aoNBn1ZOU+aRr0izAql0IPzz3DuWu5x4B7ENr5MBJdcQcLpGkk8
 AkGswTh1gJYKdLnqaq/VzhZQlcAQPrI0Yunww/ukLO6CAwYZcgY/Mz0JUA2yIK7+2dfk
 NJZr64zCl15Fjwik4qJxGderB3uZoqi1jLQjE6+b3d/r/spEQhJ4ZWzRd0uWIyWhNVpE
 hLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863040; x=1711467840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7owAJrs+Pq1wtN5iEuRd7D9oJWUcLUFndnuD7FxVak=;
 b=Svg9aCGu6EBCY2Puuv/pQNtQqPHLZBL02PtI6o/Mb8KwWOsZ7r2vd0ogU9C7wyUtcQ
 AGZqpAb14W6SQ/ZwcfpIB6slmm+9t8JkVk/Oy1+8W8yd9qcBuxgtaESH1zRqRQQR4NiF
 gB/50iUmA9Dpa6E+y32rxX7xfp6eC/1z7CqreMoVmeaVVFIWKNBY2Ll+p28S1aVVPS3I
 igeNSFFknnW8SIN5FQ0RSYgfRKeri6afsDykQ5WzrfD4Q2PtZN2WCWJx52SPGfEB8S2p
 kt5K0tDhpdtQeI4uLgYSkwrJvifSlz8BWa+aFWlXGjBiVjPh+SvORGKhxkZ/Nij5M98c
 ebYQ==
X-Gm-Message-State: AOJu0YxSVUwu0pdZHD9Ryzp3MjNUJkp0LQixnRMXdQUR8GtxUFzgrr6w
 jxfehYKQGrRobGuCcTXDynWLfIXhXKRy/7DCcsnvCcxnDa0+q3fYyLe/2LWP3ekQaENWN9p/LCj
 h
X-Google-Smtp-Source: AGHT+IEr3tvQQ2BJ2uYpQtPQOGMw73oJkZ/bY430DOKgy7XAnwwBkzdu2JHE8CMGs3vSVnNfNiaa7w==
X-Received: by 2002:a05:6000:bc6:b0:33e:c974:1294 with SMTP id
 dm6-20020a0560000bc600b0033ec9741294mr10840337wrb.17.1710863039961; 
 Tue, 19 Mar 2024 08:43:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 b16-20020adfee90000000b0033ec7182673sm12742529wro.52.2024.03.19.08.43.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.1 10/27] target/i386: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:39 +0100
Message-ID: <20240319154258.71206-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert cpu_get_tb_cpu_state() to TCGCPUOps::get_cpu_state().

Note, now x86_get_cpu_state() is restricted to TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h         | 16 ----------------
 target/i386/cpu.c         |  2 +-
 target/i386/tcg/tcg-cpu.c | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 954495fff0..390abc969e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2354,22 +2354,6 @@ static inline int cpu_mmu_index_kernel(CPUX86State *env)
 #include "hw/i386/apic.h"
 #endif
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    *flags = env->hflags |
-        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
-    if (env->hflags & HF_CS64_MASK) {
-        *cs_base = 0;
-        *pc = env->eip;
-    } else {
-        *cs_base = env->segs[R_CS].base;
-        *pc = (uint32_t)(*cs_base + env->eip);
-    }
-}
-
 void do_cpu_init(X86CPU *cpu);
 
 #define MCE_INJECT_BROADCAST    1
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9a210d8d92..249b6fe0bb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7679,7 +7679,7 @@ static vaddr x86_cpu_get_pc(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
-    /* Match cpu_get_tb_cpu_state. */
+    /* Match x86_get_cpu_state. */
     return cpu->env.eip + cpu->env.segs[R_CS].base;
 }
 
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e..a89c11a34b 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -93,6 +93,20 @@ static void x86_restore_state_to_opc(CPUState *cs,
     }
 }
 
+static inline void x86_get_cpu_state(CPUX86State *env, vaddr *pc,
+                                     uint64_t *cs_base, uint32_t *flags)
+{
+    *flags = env->hflags |
+        (env->eflags & (IOPL_MASK | TF_MASK | RF_MASK | VM_MASK | AC_MASK));
+    if (env->hflags & HF_CS64_MASK) {
+        *cs_base = 0;
+        *pc = env->eip;
+    } else {
+        *cs_base = env->segs[R_CS].base;
+        *pc = (uint32_t)(*cs_base + env->eip);
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool x86_debug_check_breakpoint(CPUState *cs)
 {
@@ -110,6 +124,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .initialize = tcg_x86_init,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
+    .get_cpu_state = x86_get_cpu_state,
     .cpu_exec_enter = x86_cpu_exec_enter,
     .cpu_exec_exit = x86_cpu_exec_exit,
 #ifdef CONFIG_USER_ONLY
-- 
2.41.0


