Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DF0E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfil-0003ox-4L; Fri, 20 Dec 2024 11:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiJ-0001eN-6I
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiH-0008Cu-BQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:54 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436341f575fso22781965e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711531; x=1735316331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySncAU20DLIPtQBH3XLZd0BEdgpTbpYKBukLqC+aRo0=;
 b=siuiBF49udzuJeKPE7n308Tu7YuYdLgqJvb3KuqTI5xcLDAxj3IjRSPzqmdct3tnsa
 CCJlvRMBJH31Hc2RUHfnI0Qbret7SsM+4YLDt/UY9+YYp6Ure1tNzVa6xgGZtKsXH79l
 0CEHu3sIsf72roxCektX19KUS0VwUJm9TRd90UNyUASrMIocrzDezP5hoYWlgVZ7U0VW
 /1EdhYE7IybPr4M8003SQqXx3VOg3Yuhqo5N70AWJY3tJHGUY/pco3n2gE2iazhDwtta
 yBJfBfjjXGxMR/b8laTu0edVmp/51vq9zuHOZ0082LZGgYGSRGLlwj/poOW4EUQfCE3p
 YBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711531; x=1735316331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySncAU20DLIPtQBH3XLZd0BEdgpTbpYKBukLqC+aRo0=;
 b=vXvCP360R1mL1OGh4kwNdadu+I6XmDJf9XERPhBNLXXngoi0i6Xg/6yRIfQekvjY3w
 09upuhNxDcZ/kkXWk2+7Jvtg9Ekt437/epGBCJSPm6pRVncvTm+S/jwbPTjm8Po+79Kp
 7pBYLNf/1awRJDQHrhcWa69MvUJQg8yjupEFDRezoqgiNg4DFOGSxXkZm/31H8EElB2O
 9/QWQosyym6P5xDRsopuGLLthVtd+cGCtbT5GqaTUxdRNBsFPx5Lx01JnbDR32nqu2i0
 Mp26/bJ7k0ncecBOcC1CO7jfrHwjgGDAsMcype/qm54i/tt+Gkmn0x8ETW7eC5aO887X
 0qqw==
X-Gm-Message-State: AOJu0YxEdzzViLbRFN1/ye/2qOQLho2aYmGTZGp/JxegkkAqZTdAu1kj
 0tdDVKdxTgeZttxIMmYpzvYDHV9SdtrgiYIjp498jzwRIK2mk+rlvsCCkztdK3AUaJyoiQ56Vbr
 n
X-Gm-Gg: ASbGnctgsqgnPnkphSdLz5H7499I3mfzde834kVRCzyhlryMFM+Ay9mp1CIuCXD04kg
 fzCDhdcQW7+8ygTRRE+H4/nV1jBrBFcOH5hBqGV+xjmkXkaEFxywH9AUAwibprakhx+tz04Ikpj
 QG4Astd3GUM3MsgCsgDbFgO/dwnvLLq/SnS2EXqDmAazcMHd1QlqEfDqlJanEsezTotWizyeB42
 Js2/INmoP++yO8bpzsuoQgiDmeLVh41HRyZzVe0FTV73oeZCrhlI8brW+l6bFirLg0am4TRevo=
X-Google-Smtp-Source: AGHT+IENLO0LeQA8UuQvxmVTi6bZbrSpLeh/7W4UnDmqZOOkav8AUogDnDuhjK+PA3GCvREbUyIgHw==
X-Received: by 2002:a5d:47cc:0:b0:386:144d:680f with SMTP id
 ffacd0b85a97d-38a223ff30cmr3604669f8f.54.1734711531528; 
 Fri, 20 Dec 2024 08:18:51 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661218f43sm49922625e9.19.2024.12.20.08.18.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 39/59] user: Declare cpu_loop() once in 'user/cpu_loop.h'
Date: Fri, 20 Dec 2024 17:15:30 +0100
Message-ID: <20241220161551.89317-40-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Declare cpu_loop() once in "user/cpu_loop.h".
bsd-user gets the G_NORETURN attribute.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-18-philmd@linaro.org>
---
 bsd-user/aarch64/target_arch_cpu.h | 2 +-
 bsd-user/arm/target_arch_cpu.h     | 2 +-
 bsd-user/i386/target_arch_cpu.h    | 2 +-
 bsd-user/qemu.h                    | 2 +-
 bsd-user/riscv/target_arch_cpu.h   | 2 +-
 bsd-user/x86_64/target_arch_cpu.h  | 2 +-
 include/user/cpu_loop.h            | 2 ++
 linux-user/user-internals.h        | 1 -
 8 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index b288e0d069b..87fbf6d6775 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -43,7 +43,7 @@ static inline void target_cpu_init(CPUARMState *env,
 }
 
 
-static inline void target_cpu_loop(CPUARMState *env)
+static inline G_NORETURN void target_cpu_loop(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr, ec, fsc, si_code, si_signo;
diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.h
index 517d0087644..bc2eaa0bf4e 100644
--- a/bsd-user/arm/target_arch_cpu.h
+++ b/bsd-user/arm/target_arch_cpu.h
@@ -37,7 +37,7 @@ static inline void target_cpu_init(CPUARMState *env,
     }
 }
 
-static inline void target_cpu_loop(CPUARMState *env)
+static inline G_NORETURN void target_cpu_loop(CPUARMState *env)
 {
     int trapnr, si_signo, si_code;
     CPUState *cs = env_cpu(env);
diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
index 9bf2c4244b7..5d4c931decd 100644
--- a/bsd-user/i386/target_arch_cpu.h
+++ b/bsd-user/i386/target_arch_cpu.h
@@ -102,7 +102,7 @@ static inline void target_cpu_init(CPUX86State *env,
     env->segs[R_FS].selector = 0;
 }
 
-static inline void target_cpu_loop(CPUX86State *env)
+static inline G_NORETURN void target_cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 04faee459df..3eaa14f3f56 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 
 #include "user/abitypes.h"
+#include "user/cpu_loop.h"
 #include "user/page-protection.h"
 
 extern char **environ;
@@ -187,7 +188,6 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
                             abi_long arg5, abi_long arg6);
 void gemu_log(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 extern __thread CPUState *thread_cpu;
-void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
 int get_osversion(void);
 void fork_start(void);
diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index a93ea3915a1..ef92f004803 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -37,7 +37,7 @@ static inline void target_cpu_init(CPURISCVState *env,
     env->pc = regs->sepc;
 }
 
-static inline void target_cpu_loop(CPURISCVState *env)
+static inline G_NORETURN void target_cpu_loop(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr;
diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arch_cpu.h
index 4094d61da1a..f82042e30af 100644
--- a/bsd-user/x86_64/target_arch_cpu.h
+++ b/bsd-user/x86_64/target_arch_cpu.h
@@ -110,7 +110,7 @@ static inline void target_cpu_init(CPUX86State *env,
     cpu_x86_load_seg(env, R_GS, 0);
 }
 
-static inline void target_cpu_loop(CPUX86State *env)
+static inline G_NORETURN void target_cpu_loop(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
     int trapnr;
diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index 8e2df232758..b0d4704018d 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -23,6 +23,8 @@
 #include "exec/log.h"
 #include "special-errno.h"
 
+G_NORETURN void cpu_loop(CPUArchState *env);
+
 void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 46ffc093f40..b9b05c1d11f 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -65,7 +65,6 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
 extern __thread CPUState *thread_cpu;
-G_NORETURN void cpu_loop(CPUArchState *env);
 abi_long get_errno(abi_long ret);
 const char *target_strerror(int err);
 int get_osversion(void);
-- 
2.47.1


