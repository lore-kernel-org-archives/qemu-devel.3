Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B3CC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riISV-0001CB-B9; Thu, 07 Mar 2024 13:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riIST-0001Bm-Oh
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:09 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISS-0000ad-4j
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc09556599so11040655ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709836026; x=1710440826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IZpmqKkC/6jXIwMfBnBHrJzkGHHB70zum6jLXtu3a9I=;
 b=cEAoI8QuKQhkI6Id130yoe8YtYTtAozvPh5Qb52a12tV+gA0X84tG2/hxXHV1dtfor
 Yw3sfsHsrsm2WkqvcTL0uVwa3mOF35RQN0wYYOUFAiT8Z/E32KD4eglNVGyXI5yl6gQT
 yJbOqZSQcPgj6Mj/G+7dAZxKwuB4FTvuItozeLXloMBmOtIESqiaYmuHez8MyBGQVAD2
 +e8lwjZqZVzio3SSCLXsmQzSJ9gFZuW1TCJXQjDNJ0yrOja0RxscZDi2r1/QqWsSwnu2
 jj+ivtcG1FI6wbtfnK9BcdpoUhkAJumxB2e8ZJUzCF4ExHcKENUza930kPdJskPey/3t
 YiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709836026; x=1710440826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IZpmqKkC/6jXIwMfBnBHrJzkGHHB70zum6jLXtu3a9I=;
 b=fXGUX0ocxUaTEK2gNGyCblcua5Pw8CJgpnVTlfY95677NmWLyVR/OSKEca1ZCltanX
 D3Msba95OD7dcFuG6OdjMQ1a7iqopxxn5Kn/PPhrFzFk2bmYDcaqt4OB/59zMQ8x25lW
 XiAyHAlHMPmOQmEI4bG8NtW5mOZhCaP+r/P/gLZ2/OYY6TgQc5FU+s3ygcWy+cKy5Ndq
 vU6WYDOTKquRwZn+cMPcm/+PjRrIIr8RQQZsztzYZIgVCdBbnRZvpce/a1CJ2nIbjpD4
 8HWhN4XlSSPYzxkhZA5yHXxH/4/n2EVXzoL0EuHrRdA5ZX8tk4UzpuFLTpwmbcsoNEIj
 3yTg==
X-Gm-Message-State: AOJu0Ywo5rE9LMSjgAD16bhGoobYiJ50NJsxXduzU3STwzVlDohht4ur
 1DnWVhh6oUEn9BnS8nJP2JVL6Mr5ElqYSJZOjR6jYtUXyvLMKa75hbgmHyIXpw2MZDDMOfK/Ph0
 vvhU=
X-Google-Smtp-Source: AGHT+IFB4IGX9RCfx7n6gQbxAtKsckgUaZAErEDTW6STVqHqfXeSBqQh8jmQ/i8retDxX35oFySBuQ==
X-Received: by 2002:a17:902:e84f:b0:1dc:3c3f:c64b with SMTP id
 t15-20020a170902e84f00b001dc3c3fc64bmr10655856plg.24.1709836025959; 
 Thu, 07 Mar 2024 10:27:05 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:120f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 mm12-20020a1709030a0c00b001dc96d1a662sm14939068plb.197.2024.03.07.10.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:27:05 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v2 1/5] gdbstub: Rename back gdb_handlesig
Date: Thu,  7 Mar 2024 18:26:19 +0000
Message-Id: <20240307182623.1450717-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Rename gdb_handlesig_reason back to gdb_handlesig. There is no need to
add a wrapper for gdb_handlesig and rename it when a new parameter is
added.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/user.c         |  8 ++++----
 include/gdbstub/user.h | 15 ++-------------
 linux-user/main.c      |  2 +-
 linux-user/signal.c    |  2 +-
 4 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 14918d1a21..a157e67f95 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -131,7 +131,7 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
+int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
 {
     char buf[256];
     int n;
@@ -510,7 +510,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
 void gdb_syscall_handling(const char *syscall_packet)
 {
     gdb_put_packet(syscall_packet);
-    gdb_handlesig(gdbserver_state.c_cpu, 0);
+    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
 }
 
 static bool should_catch_syscall(int num)
@@ -528,7 +528,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
-        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
     }
 }
 
@@ -536,7 +536,7 @@ void gdb_syscall_return(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
-        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
     }
 }
 
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 68b6534130..6647af2123 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -10,7 +10,7 @@
 #define GDBSTUB_USER_H
 
 /**
- * gdb_handlesig_reason() - yield control to gdb
+ * gdb_handlesig() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
  * @reason: stop reason for stop reply packet or NULL
@@ -25,18 +25,7 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig_reason(CPUState *, int, const char *);
-
-/**
- * gdb_handlesig() - yield control to gdb
- * @cpu CPU
- * @sig: if non-zero, the signal number which caused us to stop
- * @see gdb_handlesig_reason()
- */
-static inline int gdb_handlesig(CPUState *cpu, int sig)
-{
-    return gdb_handlesig_reason(cpu, sig, NULL);
-}
+int gdb_handlesig(CPUState *, int, const char *);
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
diff --git a/linux-user/main.c b/linux-user/main.c
index 551acf1661..049fd85a2a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1014,7 +1014,7 @@ int main(int argc, char **argv, char **envp)
                     gdbstub);
             exit(EXIT_FAILURE);
         }
-        gdb_handlesig(cpu, 0);
+        gdb_handlesig(cpu, 0, NULL);
     }
 
 #ifdef CONFIG_SEMIHOSTING
diff --git a/linux-user/signal.c b/linux-user/signal.c
index d3e62ab030..a57c45de35 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1180,7 +1180,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     /* dequeue signal */
     k->pending = 0;
 
-    sig = gdb_handlesig(cpu, sig);
+    sig = gdb_handlesig(cpu, sig, NULL);
     if (!sig) {
         sa = NULL;
         handler = TARGET_SIG_IGN;
-- 
2.34.1


