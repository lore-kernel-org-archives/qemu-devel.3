Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66705CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 21:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rkb-0003qT-2r; Fri, 17 Oct 2025 17:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkX-0003pZ-M0
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:34 -0400
Received: from pc232-55.mailgun.net ([143.55.232.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkT-0005ku-33
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1760735540; x=1760742740; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=V2QwT0iEj1rNE2XxLHsxUmoaqZnzVqzzJbOqYQWXuv8=;
 b=YQ+EK4JZS7Q2KmfpvTSD7e0+RvLtaAoyNX3FE9Rwiu/+xXsxpRQ1SVZkHTN3c51RJBV+Jj62sJXXElKpgfr0iIl2L8RtBLIsEG0r7pQQERxnQBd10gxZsXA/Mx1n2Vv27+7KyrECZd3NvhPV1Vg8F6vxPjlib4VzzEOAaDWqjoHH8eYW+QBlxKQWGYhvA65+gDd93gsFjjt3NVS1rrbN4Ddx5GcXfHRzHli8tLIrqie4GGBKSu0U72ze+FDTA/imFPutafCFA0xhr9FBO6m1OacjiQHIFFEuoMwXi4+O7FpF6YBdkigNpUAdRUu1kngMGDHLHcBjnTlpg5UtzUo8JA==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 ab8633fbac176f2aee457eaa601272b9130470064ab5fa536c6b5351319b4c45 with SMTP id
 68f2b1337813828cce311e11; Fri, 17 Oct 2025 21:12:19 GMT
X-Mailgun-Sending-Ip: 143.55.232.55
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] gdbstub/user-target: Convert host errno to GDB
 File-I/O errno
Date: Fri, 17 Oct 2025 16:11:45 -0500
Message-ID: <20251017211149.163762-4-yodel.eldar@yodel.dev>
In-Reply-To: <20251017211149.163762-1-yodel.eldar@yodel.dev>
References: <20251017211149.163762-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2469; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=fRlpSe6mPp7oCWAdGXRMZBW1yxjFM0brX70zX9dxEDw=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI+reDhi/66ZCW/9afpmlcKO3c1//upFXv3o9SWrJ2dk
 8tt6hbbdZSyMIhxMciKKbJcPitx1iF3d1fayh/3YeawMoEMYeDiFICJbJvK8L+8T8s5M/k17/9t
 OoZs+ktrj0etX5vfH/u6kuutiNxMpouMDFfixTq/Hm488ap2UkT/xuthmbseTPr9e9Gxqc9FD6S
 ZT+QAAA==
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
2.51.1.dirty


