Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB87C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0GW-0002yO-LB; Tue, 12 Mar 2024 07:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GR-0002vZ-F6
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GJ-0000ja-Iy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e70d71756so2846395f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242737; x=1710847537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGMxfNWMqHxIajAfVs5LmcHHz96MvpgBL7/t14DrgrU=;
 b=nPjk5M14eWsVpzTAIWJseaIlvuGSrlh2LZUphkiZp9sgJhT71I1roCQFxuF3FTRiZ3
 khrY8PEZlA2htMXQNn4RPCrUbxEXWCR6HFNay/87LX8iz9+PibOjs4LqRnYfLWboeo87
 RhmnAyLd5hWHi1VqdfD3s7KqKpiBsxJn9OLMg57/ggDmEddMR9xJ88TlIGky9g3nSogO
 WNid3gi075TB3hWa8FO4CAsa7S1eflO0b9FaMQ7qqtefAUsMEiKeKnT1IZK2xH56Zu6+
 cQbhgK9b88RD6PARaxJvXmMHNJ9lv2IXb/sCR/58bst7sxEw0AkN6/KCW+FE2Fdmlamr
 z0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242737; x=1710847537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGMxfNWMqHxIajAfVs5LmcHHz96MvpgBL7/t14DrgrU=;
 b=d7vI+83+shHyf/2bIiS/6u/V195AuLs6xfBDPPMgTXhwG8/1TkTUjMRL4hfoi19jyR
 2bLGBp5/llyLxoYYryXUGTn21ri+68mskL/2umBXxabtityHiKZSmNGyxvJHSeimhbyh
 2my+3vDVpF3ig1Vv32ZiJVCMvUjIAHXbW4OCxCrpA6+EK5ZktZPa7SBj5k5TqK/+4z7Z
 eVVmAUswv3Tc1pXJf+AETX3MIz0az2C59kb/iVU1ebO/QDq3Mdrne6xVbSt1lprN+bgo
 fuPXFnxzgJQ8omKpofwhIajdmt2/K6tgVFnKl8uT26hLWZ+Kx1DHvIPIR7pDokY7TmUa
 ztcQ==
X-Gm-Message-State: AOJu0Yx62xYNOmXZGk0k2ktweT+/Rp+JppFoYVXgt+l9tRrHwP8TIllV
 6bRGEBN9UhgCf8DRZJExHGpGM9stIPOlHA2xrPYQrh7hoqfvqfR9DlZ0d2HnHxo=
X-Google-Smtp-Source: AGHT+IENTWigqwkP9Nfg7tJT8tfwwKXPRiyTsqMh/juct9RoNXoWCFvNIuyxuwLFcd4lo0v0rISn7Q==
X-Received: by 2002:adf:cb8f:0:b0:33e:a626:4046 with SMTP id
 q15-20020adfcb8f000000b0033ea6264046mr1310811wrh.16.1710242736651; 
 Tue, 12 Mar 2024 04:25:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h3-20020adf9cc3000000b0033e73c58678sm8839238wre.15.2024.03.12.04.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26B405F8E0;
 Tue, 12 Mar 2024 11:25:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 5/8] gdbstub: Save target's siginfo
Date: Tue, 12 Mar 2024 11:25:29 +0000
Message-Id: <20240312112532.1558319-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Save target's siginfo into gdbserver_state so it can be used later, for
example, in any stub that requires the target's si_signo and si_code.

This change affects only linux-user mode.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240309030901.1726211-4-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 4fc88f8a25..3b8358e3da 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -9,11 +9,15 @@
 #ifndef GDBSTUB_USER_H
 #define GDBSTUB_USER_H
 
+#define MAX_SIGINFO_LENGTH 128
+
 /**
  * gdb_handlesig() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
  * @reason: stop reason for stop reply packet or NULL
+ * @siginfo: target-specific siginfo struct
+ * @siginfo_len: target-specific siginfo struct length
  *
  * This function yields control to gdb, when a user-mode-only target
  * needs to stop execution. If @sig is non-zero, then we will send a
@@ -25,7 +29,7 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig(CPUState *, int, const char *);
+int gdb_handlesig(CPUState *, int, const char *, void *, int);
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 3dc285e5b7..01b313756e 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -606,7 +606,7 @@ int main(int argc, char **argv)
 
     if (gdbstub) {
         gdbserver_start(gdbstub);
-        gdb_handlesig(cpu, 0);
+        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
     cpu_loop(env);
     /* never exits */
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index e9f80a06d3..2936eeb7a8 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -27,6 +27,9 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "host-signal.h"
 
+/* target_siginfo_t must fit in gdbstub's siginfo save area. */
+QEMU_BUILD_BUG_ON(sizeof(target_siginfo_t) > MAX_SIGINFO_LENGTH);
+
 static struct target_sigaction sigact_table[TARGET_NSIG];
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc);
 static void target_to_host_sigset_internal(sigset_t *d,
@@ -890,7 +893,7 @@ static void handle_pending_signal(CPUArchState *env, int sig,
 
     k->pending = 0;
 
-    sig = gdb_handlesig(cpu, sig);
+    sig = gdb_handlesig(cpu, sig, NULL, &k->info, sizeof(k->info));
     if (!sig) {
         sa = NULL;
         handler = TARGET_SIG_IGN;
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 520987fddc..cf693bfbc4 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -95,6 +95,8 @@ typedef struct {
     enum GDBForkState fork_state;
     int fork_sockets[2];
     pid_t fork_peer_pid, fork_peer_tid;
+    uint8_t siginfo[MAX_SIGINFO_LENGTH];
+    unsigned long siginfo_len;
 } GDBUserState;
 
 static GDBUserState gdbserver_user_state;
@@ -190,7 +192,8 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
+int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
+                  int siginfo_len)
 {
     char buf[256];
     int n;
@@ -199,6 +202,18 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
         return sig;
     }
 
+    if (siginfo) {
+        /*
+         * Save target-specific siginfo.
+         *
+         * siginfo size, i.e. siginfo_len, is asserted at compile-time to fit in
+         * gdbserver_user_state.siginfo, usually in the source file calling
+         * gdb_handlesig. See, for instance, {linux,bsd}-user/signal.c.
+         */
+        memcpy(gdbserver_user_state.siginfo, siginfo, siginfo_len);
+        gdbserver_user_state.siginfo_len = siginfo_len;
+    }
+
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
     tb_flush(cpu);
@@ -746,7 +761,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
 void gdb_syscall_handling(const char *syscall_packet)
 {
     gdb_put_packet(syscall_packet);
-    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
+    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL, NULL, 0);
 }
 
 static bool should_catch_syscall(int num)
@@ -764,7 +779,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
-        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
     }
 }
 
@@ -772,7 +787,7 @@ void gdb_syscall_return(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
-        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
     }
 }
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 55aa11c9b4..9277df2e9d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1018,7 +1018,7 @@ int main(int argc, char **argv, char **envp)
                     gdbstub);
             exit(EXIT_FAILURE);
         }
-        gdb_handlesig(cpu, 0, NULL);
+        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
 #ifdef CONFIG_SEMIHOSTING
diff --git a/linux-user/signal.c b/linux-user/signal.c
index c769675e68..8355105dd7 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -34,6 +34,9 @@
 #include "user/safe-syscall.h"
 #include "tcg/tcg.h"
 
+/* target_siginfo_t must fit in gdbstub's siginfo save area. */
+QEMU_BUILD_BUG_ON(sizeof(target_siginfo_t) > MAX_SIGINFO_LENGTH);
+
 static struct target_sigaction sigact_table[TARGET_NSIG];
 
 static void host_signal_handler(int host_signum, siginfo_t *info,
@@ -1186,7 +1189,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
      */
     tswap_siginfo(&k->info, &k->info);
 
-    sig = gdb_handlesig(cpu, sig, NULL);
+    sig = gdb_handlesig(cpu, sig, NULL, &k->info, sizeof(k->info));
     if (!sig) {
         sa = NULL;
         handler = TARGET_SIG_IGN;
-- 
2.39.2


