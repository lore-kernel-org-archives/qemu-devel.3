Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88611CCD19D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v94K6-0003tB-LJ; Wed, 15 Oct 2025 12:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v94K3-0003rq-B0
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:25:56 -0400
Received: from m228-13.mailgun.net ([159.135.228.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v94Jw-0006zk-3v
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:25:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1760545532; x=1760552732; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject:
 Cc: To: To: From: From: Sender: Sender; 
 bh=5d6S802Fv3BJtY5FgntR1mdjGl+gAP0dIqcIOXSbF4Q=;
 b=iEbaKTFjqXsH3a17jUJRjSankjolS4swi8C4IAFzFMzexPitD5sc4Gt3T+toZq8WAG3aBTdaJL/i0dy0QGt3q60AYMyUS95Yh2cpFaYWPDUqHSISmHo0T3v/Sc1dLF5SndwOlSWgAKTi7Z+twRxmLmvkhkcXZAoTSq0/FWFTw5gEsGbW4e0U6ShkUubyndP1C6yOhwSbR/NP5P38efaXc7ot1m8Wfmp7sjXA/KUvO/9UUXH7LQohbATZpBKEjQd9zLXh6mIEoCcwOaH5vJG3uaV/Py5GQV118/7P2KnjJ2rU5n80FMGs58jFJdmvN6i7aEVjlaDdwVyJUbMlm7gGQg==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 99fc67f222b20ff159392bcc92f1073236929c587be6427412e8a6613476bc35 with SMTP id
 68efcafc51cb16734be8c16b; Wed, 15 Oct 2025 16:25:32 GMT
X-Mailgun-Sending-Ip: 159.135.228.13
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] gdbstub/user-target: Map errno values from the host OS to GDB
Date: Wed, 15 Oct 2025 11:25:20 -0500
Message-ID: <20251015162520.15736-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4949; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=ZfdeKOSSvsrONVLxpiUfwlfwPOUMTNMX2FW7k8/V2Cg=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDLempl+nZuz70+PjMFfD6MPPAYCD5aETVjJZXf4fnuTw
 o+wmR2qHaUsDGJcDLJiiiyXz0qcdcjd3ZW28sd9mDmsTCBDGLg4BWAiWUoMf3i/KvW+KI/8NGuT
 3yFH5SzBGglu+et7GCYJz9nbk1Lq7cPwVzjEZ8aOoq1TJ5RUlHsr2tXEvk8/eaiV/XhHe+izqOL
 jjAA=
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=159.135.228.13;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=m228-13.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch introduces the function "gdb_host_errno_to_gdb" that maps
host-dependent errno values to their GDB protocol-specific
representations as listed in the GDB manual [1].

The stub now uses the correct GDB errno values in F reply packets.

[1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2751
Reported-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 gdbstub/user-target.c | 93 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 43231e695e..29feb0509c 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -302,6 +302,87 @@ static void hostio_reply_with_data(const void *buf, size_t n)
                           gdbserver_state.str_buf->len, true);
 }
 
+/*
+ * Map host error numbers to their GDB protocol counterparts.
+ * For the list of GDB File-I/O supported error numbers, please consult:
+ * https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html
+ */
+
+static int gdb_host_errno_to_gdb(int errnum)
+{
+    enum {
+        GDB_EPERM        =    1,
+        GDB_ENOENT       =    2,
+        GDB_EINTR        =    4,
+        GDB_EIO          =    5,
+        GDB_EBADF        =    9,
+        GDB_EACCES       =   13,
+        GDB_EFAULT       =   14,
+        GDB_EBUSY        =   16,
+        GDB_EEXIST       =   17,
+        GDB_ENODEV       =   19,
+        GDB_ENOTDIR      =   20,
+        GDB_EISDIR       =   21,
+        GDB_EINVAL       =   22,
+        GDB_ENFILE       =   23,
+        GDB_EMFILE       =   24,
+        GDB_EFBIG        =   27,
+        GDB_ENOSPC       =   28,
+        GDB_ESPIPE       =   29,
+        GDB_EROFS        =   30,
+        GDB_ENOSYS       =   88,
+        GDB_ENAMETOOLONG =   91,
+        GDB_EUNKNOWN     = 9999,
+    };
+
+    switch (errnum) {
+    case EPERM:
+        return GDB_EPERM;
+    case ENOENT:
+        return GDB_ENOENT;
+    case EINTR:
+        return GDB_EINTR;
+    case EIO:
+        return GDB_EIO;
+    case EBADF:
+        return GDB_EBADF;
+    case EACCES:
+        return GDB_EACCES;
+    case EFAULT:
+        return GDB_EFAULT;
+    case EBUSY:
+        return GDB_EBUSY;
+    case EEXIST:
+        return GDB_EEXIST;
+    case ENODEV:
+        return GDB_ENODEV;
+    case ENOTDIR:
+        return GDB_ENOTDIR;
+    case EISDIR:
+        return GDB_EISDIR;
+    case EINVAL:
+        return GDB_EINVAL;
+    case ENFILE:
+        return GDB_ENFILE;
+    case EMFILE:
+        return GDB_EMFILE;
+    case EFBIG:
+        return GDB_EFBIG;
+    case ENOSPC:
+        return GDB_ENOSPC;
+    case ESPIPE:
+        return GDB_ESPIPE;
+    case EROFS:
+        return GDB_EROFS;
+    case ENOSYS:
+        return GDB_ENOSYS;
+    case ENAMETOOLONG:
+        return GDB_ENAMETOOLONG;
+    default:
+        return GDB_EUNKNOWN;
+    }
+}
+
 void gdb_handle_v_file_open(GArray *params, void *user_ctx)
 {
     const char *filename = get_filename_param(params, 0);
@@ -315,7 +396,8 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
     int fd = open(filename, flags, mode);
 #endif
     if (fd < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = gdb_host_errno_to_gdb(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
     } else {
         g_string_printf(gdbserver_state.str_buf, "F%x", fd);
     }
@@ -327,7 +409,8 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
     int fd = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (close(fd) == -1) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = gdb_host_errno_to_gdb(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -350,7 +433,8 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
 
     ssize_t n = pread(fd, buf, bufsiz, offset);
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = gdb_host_errno_to_gdb(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -373,7 +457,8 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
     ssize_t n = readlink(filename, buf, BUFSIZ);
 #endif
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = gdb_host_errno_to_gdb(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
-- 
2.51.0


