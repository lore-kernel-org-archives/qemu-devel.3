Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3D4C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL9n-00076s-Ln; Fri, 07 Feb 2025 05:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9k-0006zF-Kz; Fri, 07 Feb 2025 05:00:16 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9i-00026E-MD; Fri, 07 Feb 2025 05:00:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 33FA7E734D;
 Fri, 07 Feb 2025 12:59:18 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9DA981B09D1;
 Fri,  7 Feb 2025 12:59:59 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8BF1152D83; Fri, 07 Feb 2025 12:59:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 49/49] gdbstub/user-target: fix gdbserver int format
 (%d -> %x)
Date: Fri,  7 Feb 2025 12:59:51 +0300
Message-Id: <20250207095956.2238705-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>

This commit fixes an incorrect format string for formatting integers
provided to GDB when debugging a target run in QEMU user mode.

The correct format is hexadecimal for both success and errno values,
some of which can be seen here [0].

[0] https://github.com/bminor/binutils-gdb/blob/e65a355022d0dc6b5707310876a72b5693ec0aa5/gdbserver/hostio.cc#L196-L213

Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: e282010b2e1e ("gdbstub: Add support for info proc mappings")
Cc: qemu-stable@nongnu.org
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 8b647bd352505234cab2acd2422aba183a1aa1fd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 22bf4008c0..4bfcf78aaa 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -317,9 +317,9 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
     int fd = open(filename, flags, mode);
 #endif
     if (fd < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
     } else {
-        g_string_printf(gdbserver_state.str_buf, "F%d", fd);
+        g_string_printf(gdbserver_state.str_buf, "F%x", fd);
     }
     gdb_put_strbuf();
 }
@@ -329,7 +329,7 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
     int fd = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (close(fd) == -1) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
         gdb_put_strbuf();
         return;
     }
@@ -352,7 +352,7 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
 
     ssize_t n = pread(fd, buf, bufsiz, offset);
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
         gdb_put_strbuf();
         return;
     }
@@ -375,7 +375,7 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
     ssize_t n = readlink(filename, buf, BUFSIZ);
 #endif
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
         gdb_put_strbuf();
         return;
     }
-- 
2.39.5


