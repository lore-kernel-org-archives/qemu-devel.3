Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32F2EA8537
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHx7-0003hR-JY; Sun, 08 Mar 2026 13:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwu-0003f5-69
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:54 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHws-0003ng-ED
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:51 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E8204341E;
 Sun,  8 Mar 2026 17:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E6AC116C6;
 Sun,  8 Mar 2026 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772990988;
 bh=0nM1s+NQvWZ8mFk4qsfcfN21HkyWkiji/p4/PrOht4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AziDDGDerWm1xBk/O+KjWJzrqd2US+WzXVAZNp/mGMI5v5XrksmNjNcBfIMGQU7lX
 yimX13tj2L0u6gR3WmnuwXZoAAF1j+iXH0LXk5JOvzJw2NNo7VFVakgiSYA/OFwjb5
 7eYH2qofpZPwsCJUBSWtJEMJNADzdlhGFJ0XZTPXtMiTdntHdpAlibcCg56fZibaUK
 X4pwm4T/jp4ImfwRDWSf7cGSvbm7Sg7UszQoUow/53aSqUqJ5bfGSTZs8B0LylGyom
 CIAXCXhumvS9VD40aMAB07n6OV9b6dkyEu/8ulrPUjwmd6g3YqwaTQurjwMVsJguY+
 J3+42/ExQDZMQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/12] linux-user/strace: fix printing of file offsets
Date: Sun,  8 Mar 2026 18:29:27 +0100
Message-ID: <20260308172936.2835-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>

Previously, 64-bit file offsets (loff_t) were printed using `print_raw_param()`
function, which led to silent truncation of the upper part. This commit fixes
this issue by adding two helper functions:

1. print_file_offset32(): prints 32-bit file offsets (off_t)
2. print_file_offset64(): prints 64-bit file offsets (loff_t)

Changelog v2:

1. Make `print_file_offset32()` static.
2. Use `last` parameter in `print_file_offset32()`.
3. Rename `low` and `high` parameters of `print_file_offset64()` to `word0`,
`word1` respectively
4. Convert `last` to bool for `print_file_offset[32,64]()`
5. Use `PRId64` instead of `PRIu64` for `print_file_offset64()`
6. Fix `print__llseek()`

Signed-off-by: Jean-Christian CÎRSTEA <jean.christian.cirstea@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index ca67cfd09d..d253b522bf 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -85,6 +85,10 @@ UNUSED static void print_enums(const struct enums *, abi_long, int);
 UNUSED static void print_at_dirfd(abi_long, int);
 UNUSED static void print_file_mode(abi_long, int);
 UNUSED static void print_open_flags(abi_long, int);
+UNUSED static void print_file_offset32(abi_long offset, bool last);
+UNUSED static void print_file_offset64(abi_long word0,
+                                       abi_long word1,
+                                       bool last);
 UNUSED static void print_syscall_prologue(const struct syscallname *);
 UNUSED static void print_syscall_epilogue(const struct syscallname *);
 UNUSED static void print_string(abi_long, int);
@@ -1664,6 +1668,20 @@ print_open_flags(abi_long flags, int last)
     print_flags(open_flags, flags, last);
 }
 
+/* Prints 32-bit file offset (off_t) */
+static void
+print_file_offset32(abi_long offset, bool last)
+{
+    print_raw_param(TARGET_ABI_FMT_ld, offset, last);
+}
+
+/* Prints 64-bit file offset (loff_t) */
+static void
+print_file_offset64(abi_long word0, abi_long word1, bool last)
+{
+    print_raw_param64("%" PRId64, target_offset64(word0, word1), last);
+}
+
 static void
 print_syscall_prologue(const struct syscallname *sc)
 {
@@ -2256,11 +2274,13 @@ print_fallocate(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_flags(falloc_flags, arg1, 0);
 #if TARGET_ABI_BITS == 32
-    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
-    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
+    /* On 32-bit targets, two registers are used for `loff_t` */
+    print_file_offset64(arg2, arg3, false);
+    print_file_offset64(arg4, arg5, true);
 #else
-    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
+    /* On 64-bit targets, one register is used for `loff_t` */
+    print_file_offset64(arg2, 0, false);
+    print_file_offset64(arg3, 0, true);
 #endif
     print_syscall_epilogue(name);
 }
@@ -2666,8 +2686,7 @@ print__llseek(CPUArchState *cpu_env, const struct syscallname *name,
     const char *whence = "UNKNOWN";
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_raw_param("%ld", arg1, 0);
-    print_raw_param("%ld", arg2, 0);
+    print_file_offset64(arg1, arg2, false);
     print_pointer(arg3, 0);
     switch(arg4) {
     case SEEK_SET: whence = "SEEK_SET"; break;
@@ -2688,7 +2707,7 @@ print_lseek(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    print_file_offset32(arg1, false);
     switch (arg2) {
     case SEEK_SET:
         qemu_log("SEEK_SET"); break;
@@ -2719,7 +2738,7 @@ print_truncate(CPUArchState *cpu_env, const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_string(arg0, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_file_offset32(arg1, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2736,7 +2755,7 @@ print_truncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -2753,7 +2772,7 @@ print_ftruncate64(CPUArchState *cpu_env, const struct syscallname *name,
         arg1 = arg2;
         arg2 = arg3;
     }
-    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_file_offset64(arg1, arg2, true);
     print_syscall_epilogue(name);
 }
 #endif
@@ -3308,7 +3327,7 @@ print_stat(CPUArchState *cpu_env, const struct syscallname *name,
     print_syscall_epilogue(name);
 }
 #define print_lstat     print_stat
-#define print_stat64	print_stat
+#define print_stat64    print_stat
 #define print_lstat64   print_stat
 #endif
 
@@ -4302,7 +4321,7 @@ print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
     print_raw_param("%d", arg0, 0);
     print_pointer(arg1, 0);
     print_raw_param("%d", arg2, 0);
-    print_raw_param("%" PRIu64, target_offset64(arg3, arg4), 1);
+    print_file_offset64(arg3, arg4, true);
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.53.0


