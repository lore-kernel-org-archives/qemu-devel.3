Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632DCC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0GK-0002pr-WF; Tue, 12 Mar 2024 07:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GI-0002ku-Q9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GF-0000gp-N7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:37 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412e784060cso37658925e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242734; x=1710847534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/TnnwpHa6+cyA8uGT7QNYUXfL4ZfkLpAJU45+MsrCA=;
 b=n4uJV1YiLWsgQgp1dY+laz1pcbL9o9J0xdvCGCbS8/ihSrKCEuB23kMtt6H0ER5A2w
 Nl6Fg/auvQlQ8Pabn2nlNuThZ5q8fSD5zI1hDb0mahC44AZN2mEEtPkrTt0E8+rg3M2U
 WCLurpzHyWgcQ4jI5Of1wq/qYOIdxXf0iUN5ktllkT2vB0c8wwcAE0pXxdmfCN5otlWk
 ULGpziuda6xDQpuwk2sb3y+bUDy/b0sI68saWk2syL+bL6R+2L6vT/rT8zo5vGLDteTQ
 BFNBH70Vnkknk7VeCs5CzZNzLRUYBDLEF50szAKBqJGCgnOtF5MEl9YZSPJI6XAdW0FH
 Z2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242734; x=1710847534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/TnnwpHa6+cyA8uGT7QNYUXfL4ZfkLpAJU45+MsrCA=;
 b=XkNrRJQMnKJChzhLXaR7SbEw+ABMuXXKWoIyRlBESXNrgGgt8dqGPdAE5ucejjb0xg
 4Nkj7p+OTDu5+CNHuaio2/Mpe9Walqz3H+V4RpyS51tdfwWjOmrANxPDecS6GEB/ak9L
 mFvC6qdB/jyYt2q1+bzHlkKjTYbQYvY83JNPoE+mcrqsltDbrMQCimqoohg1Y88AgMVP
 jZsvbrKUUyvbo8hms+CmLvcerxWJMc8gzqzoho7c45P8M8RoblghSSWxgg78OIfuSPEs
 SAdDf4huOkIX5a5/nwDZaru0uytrrDjsvtH0tqOb+GuMoi9BWOo3A9vYzNfa+kBJPuRX
 L5nQ==
X-Gm-Message-State: AOJu0YwLv9LBHjS5x3Tz+wyn525VGnkZHdjJczcoULTGq73uQYPcHm+m
 6sYuXH0IVcIXKHji0dmAU/8taqrX01yFPp2MdZu9Tey3x2kxZsK62o8qnKP3Oz2AG81KC9oHhgM
 p
X-Google-Smtp-Source: AGHT+IEWcScdWkZZSFA3fhfyySTZM6qshOpTGB7e9ilrLU/nlvoATnJYwNdFnP+6FHZj8HpUDomcGQ==
X-Received: by 2002:a05:600c:35c8:b0:413:1619:a78 with SMTP id
 r8-20020a05600c35c800b0041316190a78mr8585316wmq.4.1710242733914; 
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s13-20020a5d6a8d000000b0033d202abf01sm8785691wru.28.2024.03.12.04.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D715C5F8DA;
 Tue, 12 Mar 2024 11:25:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 3/8] gdbstub: Rename back gdb_handlesig
Date: Tue, 12 Mar 2024 11:25:27 +0000
Message-Id: <20240312112532.1558319-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Rename gdb_handlesig_reason back to gdb_handlesig. There is no need to
add a wrapper for gdb_handlesig and rename it when a new parameter is
added.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240309030901.1726211-2-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 4c4e5c4c58..4fc88f8a25 100644
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
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 7f9f19a124..520987fddc 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -190,7 +190,7 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
+int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
 {
     char buf[256];
     int n;
@@ -746,7 +746,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
 void gdb_syscall_handling(const char *syscall_packet)
 {
     gdb_put_packet(syscall_packet);
-    gdb_handlesig(gdbserver_state.c_cpu, 0);
+    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
 }
 
 static bool should_catch_syscall(int num)
@@ -764,7 +764,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
-        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
     }
 }
 
@@ -772,7 +772,7 @@ void gdb_syscall_return(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
-        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
     }
 }
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 41caa77cb5..55aa11c9b4 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1018,7 +1018,7 @@ int main(int argc, char **argv, char **envp)
                     gdbstub);
             exit(EXIT_FAILURE);
         }
-        gdb_handlesig(cpu, 0);
+        gdb_handlesig(cpu, 0, NULL);
     }
 
 #ifdef CONFIG_SEMIHOSTING
diff --git a/linux-user/signal.c b/linux-user/signal.c
index cc7dd78e41..bca44c295d 100644
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
2.39.2


