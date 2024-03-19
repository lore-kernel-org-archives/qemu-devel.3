Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3389CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbcd-0005Oe-Po; Tue, 19 Mar 2024 11:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbca-0005Mo-Dq
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcY-0004oy-1a
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41412411622so15723495e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863000; x=1711467800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQ0F9e1tiLbg+1mSpsh71oFSOMQcPQZFv/kc9q+gvBc=;
 b=U3+Hk1+1IjfFgD9aUYE90eQUkdWhVW7+WQckOfPjvpH2kLWDDBY266+fl9Ic9II09V
 AQPHxh4jYUboYmFXULIrNLfvr8VA0bPwMqrO3iZwe6BXskLp8lthxNNEdGhcSByFn4cD
 R+09jq68w/x3ZYk2cX+nXKwUbbwG0tll+Fcico3pdySZyuynb1rBaGEh9qdrkzRqQxjX
 xW1cVi+KhUQEAGleQzcL47orwYrsUWQqDLqOZ6rtw8fyZv2VP3tBU+jGmXXQqNNAQ9/o
 jSEiD4ieZWNXeQ1XatVYbz0OxDvEL7TCgyb6FZVHPc1qcjJ8xkBlOZK1mKt0whmV6uKN
 nn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863000; x=1711467800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQ0F9e1tiLbg+1mSpsh71oFSOMQcPQZFv/kc9q+gvBc=;
 b=ub0q9CeXdYaCWcJ2AyS1DUxjuosngPpKuZiLeV2BE/lDNslKkEH76SfoQ0R4B2vOGi
 ESddTomFYw5AoRLVCJI3n0aZRYtNcbyeHrAxF96FnrSG8WIrx6MdTHkORMgBOOoOBD8s
 ZOi4+nOLukGGaKtJEyuxy5kr7LcxzOqZRHoI2U+eowq3FDe5SHIZNXzDzEtg/rUy62Hi
 PJbe0R7W5NzKyyo8AYTkZrM2qoRd5fs6H+ESS3jh8brQV908BZUOG/KSKaDVrf7aCsbF
 CZ8KK85xybok2je5aOS2JAFMF+nh7oMlvRGN0iI0r6u7rcl6LsyYjaGkNntcCxdW4w16
 P3YQ==
X-Gm-Message-State: AOJu0YxDRP3AnyNI3+w4PSoRR3tlgEc/XTvAEBPBBcyhG9d42p/rzZh2
 iDyC7tdh/wpkqZLbf8/4QBQfATGjHiYael7ECtWApSaXWNQt7uwZrSTyQOrm+v0BuzLLLEXWFCX
 D
X-Google-Smtp-Source: AGHT+IHNkIwxgTmLvtVpyDQh9Jev5XDRlN3i5jmRdH9rVkzOnNPPl32YeVx/fJc8BU8Spf6Qr6HJBA==
X-Received: by 2002:a05:6000:184b:b0:33f:8e6d:ab7c with SMTP id
 c11-20020a056000184b00b0033f8e6dab7cmr8021706wri.71.1710863000174; 
 Tue, 19 Mar 2024 08:43:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033e9fca1e49sm12609575wro.60.2024.03.19.08.43.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 03/27] target/alpha: Convert to
 TCGCPUOps::get_cpu_state()
Date: Tue, 19 Mar 2024 16:42:32 +0100
Message-ID: <20240319154258.71206-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.h | 13 -------------
 target/alpha/cpu.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 16b0f8a097..b7f294d08a 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -467,19 +467,6 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      MemTxResult response, uintptr_t retaddr);
 #endif
 
-#define TARGET_HAS_CPU_GET_TB_CPU_STATE
-
-static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    *pc = env->pc;
-    *cs_base = 0;
-    *pflags = env->flags & ENV_FLAG_TB_MASK;
-#ifdef CONFIG_USER_ONLY
-    *pflags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#endif
-}
-
 #ifdef CONFIG_USER_ONLY
 /* Copied from linux ieee_swcr_to_fpcr.  */
 static inline uint64_t alpha_ieee_swcr_to_fpcr(uint64_t swcr)
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 05f9ee41e9..7efeda02dc 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -49,6 +49,17 @@ static void alpha_restore_state_to_opc(CPUState *cs,
     cpu->env.pc = data[0];
 }
 
+static void alpha_get_cpu_state(CPUAlphaState *env, vaddr *pc,
+                                uint64_t *cs_base, uint32_t *pflags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *pflags = env->flags & ENV_FLAG_TB_MASK;
+#ifdef CONFIG_USER_ONLY
+    *pflags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#endif
+}
+
 static bool alpha_cpu_has_work(CPUState *cs)
 {
     /* Here we are checking to see if the CPU should wake up from HALT.
@@ -194,6 +205,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 static const TCGCPUOps alpha_tcg_ops = {
     .initialize = alpha_translate_init,
     .restore_state_to_opc = alpha_restore_state_to_opc,
+    .get_cpu_state = alpha_get_cpu_state,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
-- 
2.41.0


