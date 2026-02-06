Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0348EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQDD-0008Hn-NO; Fri, 06 Feb 2026 13:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCv-00080S-Gp
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:29 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCt-0001UD-L7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:29 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8860d6251bso319551366b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401126; x=1771005926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z414qbu3KY7qWY009bsyWelCEU/9PsgauzjNkRD3FqE=;
 b=nTdQpZ17Y3FKejvmCiqxC3N7WLDg9uEi8tVT0qBc4h0JsDY3+UZNQ823zaXwY3RXCT
 8W2MNTQbmP6ZoOexAYnQsOF3x236yJ9jgzJeBjx5qgbFGfJP5vlbqRw5L0l16/pY01hS
 kvVOT+I6wFJ+os7iokZNLN1Ivz9ZH3PYuAVm2yMyLNzynDCymAD3ye/dzUCQWz7+Dk9Z
 RDbf8x/Nk9h1crCQ8+X2daGQkI24rM64beVRYg7oQXxc6bQ4YtqpDwYBw3TMXcvlUx5q
 hb2zGXciz+ZX0DNYL3arwbLBBZZNTv5Pw33H8lG7pD5K009FZyNOmHTAJ/bFd1yqrgU5
 aSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401126; x=1771005926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z414qbu3KY7qWY009bsyWelCEU/9PsgauzjNkRD3FqE=;
 b=wuxO8qc/SG7L2xX0HG0tf/LtO7gL5dxjZkkwrzFcddtNKce9pVDxNVgTO577uchG/j
 LKRSkXmbhddwqkKJEU1SQyekv1w5o6TtbF6ndqqbN5ZH/n1AeefxIX9FYbADr8vrzBU8
 AzSZxH+0UOECVgMu3OZfgsErKK+c60tF/xf7fr620mrPu+DpXFTWS/E13X7rTUA/nq2N
 vB5qZ/35W5dS0EnXmwU01BI5pGUk2bdMQANKCzXHN444wpIizjH8CYGL5vikg11ohmvb
 dFWZnVXFCUidNTsdOb/QzuZSJxeq299SsChvonhv5t11145lxIHKb1svPs/06j9IO4cf
 wflg==
X-Gm-Message-State: AOJu0YwA5OS3IDvx6Abjnllb1Hy9FRVDAF6UHwhYc0tgMxqOqh36njWx
 KohoQgnDL/lKsocDfEJ3Hep8W7Uo3To+FpaxnKgrMEI04wARUJqoCpnhjNqHJ64zzvkcMzvxHZY
 EKFfh+g0=
X-Gm-Gg: AZuq6aK+yT87khJvxfcRz13g8z+T/V6GwSg98BxhUbMSedWks6YrcTHvlyLIpInvrMo
 jQ36g9PgSo4G9poy5wKua89ySWO/b43tBZaPmU9YWDHpaVKfpEYyu6FptUOlmHikutr1Eb3avWT
 8atoAdSxsbkaZpupgmHc/SsgGaTZUZt7VL+Ea8b3tg/ef+I6qwen3PqcIAr3ERYsatiUWzTF4dS
 9mGzqGywCGYVPyWCq53qLPbnFA+MSD1Udpk+RWLhike6hDSPjlS6d6NW+wfB5bXLGwnyc1xoG7o
 1lX3XB6ntEFOX6Iw5Pa3IcLB94y9uLF8v0MY0fxg2XzB0eas8LbKkWPfHuuFWnjDHI5w+xvhyWw
 a66f24rYO4XIU+fHShZtb3ZzIuoic1TgYk//D+6UCg7ggKjV9OfsZqUdobdHucALYm3DxadwWeo
 A9HwSoW3EINr4=
X-Received: by 2002:a17:906:478b:b0:b80:149b:badd with SMTP id
 a640c23a62f3a-b8edf34b329mr196658966b.37.1770401125979; 
 Fri, 06 Feb 2026 10:05:25 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacb18c5sm103615366b.43.2026.02.06.10.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6DF26607D4;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 07/10] gdbstub: Export host_to_gdb_errno File-I/O helper
 function
Date: Fri,  6 Feb 2026 18:05:14 +0000
Message-ID: <20260206180517.1335861-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yodel Eldar <yodel.eldar@yodel.dev>

Move host_to_gdb_errno from target/m68k/m68k-semi.c to
gdbstub/syscalls.c. Declare it in include/gdbstub/syscalls.h.

Add both newly added GDB File-I/O supported errno values, EIO and
ENOSYS, to the mapping.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116014612.226183-3-yodel.eldar@yodel.dev>
Message-ID: <20260203115201.2387721-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index 6200416f77a..a09559128b1 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -102,6 +102,15 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...);
  */
 int use_gdb_syscalls(void);
 
+/**
+ * host_to_gdb_errno: convert host errno to GDB errno value
+ * @err: errno from host
+ *
+ * Given an error number from the host, this helper function returns
+ * its GDB File-I/O specified representation.
+ */
+int host_to_gdb_errno(int err);
+
 /**
  * gdb_exit: exit gdb session, reporting inferior status
  * @code: exit code reported
diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index d8bb90cc1c7..15050984a04 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -145,6 +145,42 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
     gdb_syscall_handling(gdbserver_syscall_state.syscall_buf);
 }
 
+/*
+ * Map host error numbers to their GDB protocol counterparts.
+ * For the list of GDB File-I/O supported error numbers, please consult:
+ * https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html
+ */
+int host_to_gdb_errno(int err)
+{
+#define E(X)  case E##X: return GDB_E##X
+    switch (err) {
+    E(PERM);
+    E(NOENT);
+    E(INTR);
+    E(IO);
+    E(BADF);
+    E(ACCES);
+    E(FAULT);
+    E(BUSY);
+    E(EXIST);
+    E(NODEV);
+    E(NOTDIR);
+    E(ISDIR);
+    E(INVAL);
+    E(NFILE);
+    E(MFILE);
+    E(FBIG);
+    E(NOSPC);
+    E(SPIPE);
+    E(ROFS);
+    E(NOSYS);
+    E(NAMETOOLONG);
+    default:
+        return GDB_EUNKNOWN;
+    }
+#undef E
+}
+
 /*
  * GDB Command Handlers
  */
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 578a08dfee8..bdc798a28cb 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -46,35 +46,6 @@
 #define HOSTED_ISATTY 12
 #define HOSTED_SYSTEM 13
 
-static int host_to_gdb_errno(int err)
-{
-#define E(X)  case E##X: return GDB_E##X
-    switch (err) {
-    E(PERM);
-    E(NOENT);
-    E(INTR);
-    E(BADF);
-    E(ACCES);
-    E(FAULT);
-    E(BUSY);
-    E(EXIST);
-    E(NODEV);
-    E(NOTDIR);
-    E(ISDIR);
-    E(INVAL);
-    E(NFILE);
-    E(MFILE);
-    E(FBIG);
-    E(NOSPC);
-    E(SPIPE);
-    E(ROFS);
-    E(NAMETOOLONG);
-    default:
-        return GDB_EUNKNOWN;
-    }
-#undef E
-}
-
 static void m68k_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 {
     CPUM68KState *env = cpu_env(cs);
-- 
2.47.3


