Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD54D4A5EA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 01:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgYvK-0000xf-MP; Thu, 15 Jan 2026 20:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvF-0000uR-MA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:47 -0500
Received: from k57.kb8c70eb.use4.send.mailgun.net ([204.220.184.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vgYvC-0000NV-Uh
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:46:45 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 cad0cebcd768843fd51d305414832d0b6da05acbafe8094d47580c8c19531652 with SMTP id
 6969987a834a10b0f0ab9013; Fri, 16 Jan 2026 01:46:34 GMT
X-Mailgun-Sending-Ip: 204.220.184.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1768527993;
 bh=gAN3Y5SV5SlPLFmcCVzEMCphX2dQx2LOgVwQXPYMOmc=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:From:Reply-to:
 Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=gaZxgqtT0eNavgx+DrrldhjCW4bqYirZhEoU74zQvYlQTDmaUCGsoZ4/wypmi3LWK
 eZlmPNJemVf+hzZ65nea15haiuvIa87q28Jtu+PDzUwD6yY1SDBNyJtC0xQ3ZYwOUd
 dpR2corv8gQZtsfBwUV0QK6jGlZ9NOUdsMmixvPHl5/aqrhMBDTCTASNhHZoFiY+BJ
 UmD7kGLkWUucB2pk+uSFG7Isjw0vNMz//h0yPfmXWRr0zzn+oUS9gaslLjj8FKZrAP
 EC0i3ARabpLBR4d8eigy8T90gLT3rAjjxt5HUP12rc99xpP/Rxevd7hsWxC5oP5J9f
 t/FHTwTDolLRg==
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
Subject: [PATCH v3 3/3] gdbstub/user-target: Convert host errno to GDB
 File-I/O errno
Date: Thu, 15 Jan 2026 19:46:12 -0600
Message-ID: <20260116014612.226183-4-yodel.eldar@yodel.dev>
In-Reply-To: <20260116014612.226183-1-yodel.eldar@yodel.dev>
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.57;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k57.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Use host_to_gdb_errno to convert host-supplied errnos to their GDB
File-I/O remote protocol values, and use them in F reply packets.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2751
Reported-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 gdbstub/user-target.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 43231e695e..7ef0282f70 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
+#include "gdbstub/syscalls.h"
 #include "qemu.h"
 #include "internals.h"
 #ifdef CONFIG_LINUX
@@ -315,7 +316,8 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
     int fd = open(filename, flags, mode);
 #endif
     if (fd < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
     } else {
         g_string_printf(gdbserver_state.str_buf, "F%x", fd);
     }
@@ -327,7 +329,8 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
     int fd = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (close(fd) == -1) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -350,7 +353,8 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
 
     ssize_t n = pread(fd, buf, bufsiz, offset);
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -373,7 +377,8 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
     ssize_t n = readlink(filename, buf, BUFSIZ);
 #endif
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
-- 
2.52.0


