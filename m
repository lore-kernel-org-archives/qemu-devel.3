Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E2ACCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 21:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rkZ-0003pk-AC; Fri, 17 Oct 2025 17:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkW-0003pO-E2
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:32 -0400
Received: from pc232-55.mailgun.net ([143.55.232.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkT-0005kq-2u
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1760735539; x=1760742739; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=7RaMqVq9LVHB5AkvPy1Ho3/qstErFKHAfQLACcNmNO4=;
 b=F+zIiUSMzhMczlPV13uOHzhAtrkLlQs1StT5rKpF2p+5Lz57KzhNUwZfQ8FJzzt0fNrwQk0oIFSWYP4zmicojPuzcT8zOaKUdTEo2c4mlRCQWMAhJdBGrZ2okq4a0gomSM28e2IrsicEE3YzIDb0o3eAmt5G6kCEKeZ6lxqNzHN45q0ylIIMNsicN+ag1HjUUZwUYTHUGWmAUpUNecqiGRDiXZotqFQA4K67/TR0lzMUteC/D3uRI0Lif9U6Czs3RpcvyRzd8vZYuDtRQtbORrJevXD6YCjaCf0R6EW4aQRLYE6sT0ZqIOihE/g1fbYc2wwr0bJE7IfoKuLiLQFkng==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 1001765c7195ef6bfe8cebbd019a8be688a4339ff96cc184dd076cac1911cda9 with SMTP id
 68f2b13393f3c68ae8e65114; Fri, 17 Oct 2025 21:12:19 GMT
X-Mailgun-Sending-Ip: 143.55.232.55
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 2/3] gdbstub: Export host_to_gdb_errno File-I/O helper
 function
Date: Fri, 17 Oct 2025 16:11:44 -0500
Message-ID: <20251017211149.163762-3-yodel.eldar@yodel.dev>
In-Reply-To: <20251017211149.163762-1-yodel.eldar@yodel.dev>
References: <20251017211149.163762-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=ALPbEMOWcHQOXutuQFJZ4q+7mixc5saDwW84TXMMKCc=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI+reB5IKSecTpN73XWYY3dZzNNWpa19L8Lmr/d40lOw
 LyQxi2LOkpZGMS4GGTFFFkun5U465C7uytt5Y/7MHNYmUCGMHBxCsBEWD4z/DPLZG3tqrtXsF5f
 qNwj1nDWv1gjn/n/ZodUzvXotDe90M3I0Lt2nkGXxK/d58y1DjsrbYq/FK+jFnJU9PiepGVL1x0
 zYQUA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.55;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-55.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move host_to_gdb_errno from target/m68k/m68k-semi.c to
gdbstub/syscalls.c. Declare it in include/gdbstub/syscalls.h.

Add both newly added GDB File-I/O supported errno values, EIO and
ENOSYS, to the mapping.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/gdbstub/syscalls.h |  9 +++++++++
 target/m68k/m68k-semi.c    | 29 -----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index e855df21ab..b166f4cc77 100644
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
index 6fbbd140f3..e33fd6fedd 100644
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
2.51.1.dirty


