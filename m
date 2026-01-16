Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91483D4A5E4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 01:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgYvJ-0000wk-PK; Thu, 15 Jan 2026 20:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvG-0000ud-7O
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:47 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvC-0000NQ-RT
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:45 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 cad0cebcd768843fd51d305414832d0b6da05acbafe8094d47580c8c19531652 with SMTP id
 69699879588bf5e27b25d567; Fri, 16 Jan 2026 01:46:33 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768527993;
 bh=itrmGXYS2hXeVHcX4IdA5yYDi6xDh9sSyb12JTpWnMY=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:From:Reply-to:
 Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=bqHuZYLiPhr4uW42/2kX5DGEBkkJbALbVp4fUp50dnug4bBkkPmIvK3WpDM/+Nwzo
 5T5OnqcRUy0ZelgDTkQtR5/YEq+BSAI+ju90TPFA1u08c3woR7WSDfqHns+5st+A4Z
 jhbMem62LAwTKYMt/UhDUUW750ZjXtaJIub4GJbwRZawnOKJtrRvXVHrH3zDwd1V9D
 Dy3gp1Wrj2EGI7HC4+UHI1Ns2Xlexj4X97tP8ubXi3KZevUyZU15bslgPgdRCSUXtI
 BQl2AZ1uFDPw01MHrdVokUODZ5FyuVmJCY+Ievk3nBEFmjaqLQfjPrVuS6FLCb+UIX
 tzRy7H1s/vOfw==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Dominik Disconnect3d Czarnota <dominik.b.czarnota@gmail.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v3 2/3] gdbstub: Export host_to_gdb_errno File-I/O helper
 function
Date: Thu, 15 Jan 2026 19:46:11 -0600
Message-ID: <20260116014612.226183-3-yodel.eldar@yodel.dev>
In-Reply-To: <20260116014612.226183-1-yodel.eldar@yodel.dev>
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move host_to_gdb_errno from target/m68k/m68k-semi.c to
gdbstub/syscalls.c. Declare it in include/gdbstub/syscalls.h.

Add both newly added GDB File-I/O supported errno values, EIO and
ENOSYS, to the mapping.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/gdbstub/syscalls.h |  9 +++++++++
 target/m68k/m68k-semi.c    | 29 -----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index d8bb90cc1c..15050984a0 100644
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
diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index 6200416f77..a09559128b 100644
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
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 578a08dfee..bdc798a28c 100644
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
2.52.0


