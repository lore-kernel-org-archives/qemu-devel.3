Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7782DC54E58
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riISZ-0001Ct-PW; Thu, 07 Mar 2024 13:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISY-0001CV-Fz
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:14 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISW-0000bc-TP
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:14 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso9549055ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709836031; x=1710440831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJRyVmau9ruD0qJjHtVWvNsb9E69SYPlhZ6E6+1O2KM=;
 b=mHCD6hzpO/GtSmVTiRElm/LOVxcgmpJhz6Xn3hpDE/IRyyJ4qJFpCkzZ2LVe5O8+dq
 9TzNfd1etUCkGuY+//ii6hOP2lNhw3U3PtBtUoVqz5upamsSp+rhtogTp3CfsulIZaTN
 6Xpp1gUJBCukx/nfQnjSSLkFdEKRhWEu25/nkP24cF8CaswlJ4U+Xl92BEdIxSPxqFSS
 BsL+3UIULmMubZ7HSvJq6VnawiSD0hbCQW0jyrQq+/beoO6EXOV2rMvo3s219BuleCfj
 eP7IH+IQyZfIh4mMVl5f7XE6E483tfUPGo1HRlQbR3HsmCPxROj6KLnzq34VSB/rD9z6
 gUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709836031; x=1710440831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJRyVmau9ruD0qJjHtVWvNsb9E69SYPlhZ6E6+1O2KM=;
 b=KA3VE5e5V+oIquvHSFNFuaGVu+lJW6PYMivvmcXlo8Od3c68/Jp5YfEWncfoKRVZkM
 apCn42+ncjdSO6i7Ax8cpcer7n+tL8Xraw9Q/P3j4os6C5RgRHe6yJtUXUy6SpkNey88
 Z5hlzcC4XXapZND1gczNt5sySDX5LCpvKfVP/UsxouWLA0lXh0Oo1XSqxpztz7gOKEc7
 xWET46Iah4nHQhjTtFw5VL15AKS8Bdqpe6SO9g3CylChn9GYScOJZqMrlBi1K+IP2k5N
 BDgeV9rUe1U9g4oh9OQnZMhFizmanG1O7FQ0UwSVr2U7hOuAyymN0yUPlfZOtDQKyQrv
 7d4A==
X-Gm-Message-State: AOJu0YykoVPtS5GX2eTShrYKa30A3V8bYOnf2yVf4V9v8+eGO6OQqQ9S
 0jP9tAnU7JxowL6V5kMLaIHeoSF6GgBT4Ta6E2uZslkob+9VDWhxyN3e5n3e6wiLfvu5ZW5zmvD
 qM+s=
X-Google-Smtp-Source: AGHT+IGnCXYvM4P+lmxIf9G0vNTgySsA2WBUPWkgkYKmwaojDlmMlGUo1xOBWPtP+36f6igCpdL5EA==
X-Received: by 2002:a17:902:e847:b0:1dc:75ea:8562 with SMTP id
 t7-20020a170902e84700b001dc75ea8562mr9166374plg.32.1709836031390; 
 Thu, 07 Mar 2024 10:27:11 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:120f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 mm12-20020a1709030a0c00b001dc96d1a662sm14939068plb.197.2024.03.07.10.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:27:10 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v2 3/5] gdbstub: Save target's siginfo
Date: Thu,  7 Mar 2024 18:26:21 +0000
Message-Id: <20240307182623.1450717-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307182623.1450717-1-gustavo.romero@linaro.org>
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Save target's siginfo into gdbserver_state so it can be used later, for
example, in any stub that requires the target's si_signo and si_code.

This change affects only linux-user mode.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/internals.h    |  3 +++
 gdbstub/user-target.c  |  3 ++-
 gdbstub/user.c         | 14 ++++++++++----
 include/gdbstub/user.h |  6 +++++-
 linux-user/main.c      |  2 +-
 linux-user/signal.c    |  5 ++++-
 6 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 56b7c13b75..a7cc69dab3 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -58,6 +58,9 @@ typedef struct GDBState {
     int line_csum; /* checksum at the end of the packet */
     GByteArray *last_packet;
     int signal;
+#ifdef CONFIG_USER_ONLY
+    uint8_t siginfo[MAX_SIGINFO_LENGTH];
+#endif
     bool multiprocess;
     GDBProcess *processes;
     int process_num;
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index b7d4c37cd8..215bf33ab3 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -10,11 +10,12 @@
 #include "qemu/osdep.h"
 #include "exec/gdbstub.h"
 #include "qemu.h"
-#include "internals.h"
 #ifdef CONFIG_LINUX
 #include "linux-user/loader.h"
 #include "linux-user/qemu.h"
+#include "gdbstub/user.h"
 #endif
+#include "internals.h"
 
 /*
  * Map target signal numbers to GDB protocol signal numbers and vice
diff --git a/gdbstub/user.c b/gdbstub/user.c
index a157e67f95..777fa78ef4 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -131,7 +131,8 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
+int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
+                  int siginfo_len)
 {
     char buf[256];
     int n;
@@ -140,6 +141,11 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
         return sig;
     }
 
+    if (siginfo) {
+        /* Save target-specific siginfo. */
+        memcpy(gdbserver_state.siginfo, siginfo, siginfo_len);
+    }
+
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
     tb_flush(cpu);
@@ -510,7 +516,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
 void gdb_syscall_handling(const char *syscall_packet)
 {
     gdb_put_packet(syscall_packet);
-    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
+    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL, NULL, 0);
 }
 
 static bool should_catch_syscall(int num)
@@ -528,7 +534,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
-        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
     }
 }
 
@@ -536,7 +542,7 @@ void gdb_syscall_return(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
-        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
     }
 }
 
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 6647af2123..0ec9a7e596 100644
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
diff --git a/linux-user/main.c b/linux-user/main.c
index 049fd85a2a..3187be48d6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1014,7 +1014,7 @@ int main(int argc, char **argv, char **envp)
                     gdbstub);
             exit(EXIT_FAILURE);
         }
-        gdb_handlesig(cpu, 0, NULL);
+        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
 #ifdef CONFIG_SEMIHOSTING
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 7a4c8e416e..98d1eacffe 100644
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
2.34.1


