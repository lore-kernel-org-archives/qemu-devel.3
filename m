Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A27CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfsd-0008VE-JE; Mon, 08 Jun 2026 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsK-0008SD-5H
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:08 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWfsI-0006Bl-78
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:43:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8413640B93;
 Mon,  8 Jun 2026 19:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A977D1F00893;
 Mon,  8 Jun 2026 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780947784;
 bh=MqB7UL4fPRYcru3EnbnH7S5G3PK67/sx3b0o2FxbdEo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f4VB0GK8g1fgpO9IcOi+OOyBglgCEoYaP10Ep/yKmw5TZDNLOPbhFzlAx0hdQ1BXb
 b7LFV0T8I8rM4orEXJVYfoMVPxYM6jwHwXBHtPNp53V1o4YMbyQ1dk2uUBn4rkzt7X
 cpJGadEVmTPNWPDwlKeczRiHrdcbAJ5a4ffCkFal/QJeJapvfyomf4XwfYbrdKoY2A
 Jra64dUG9ogTsYpYDJ2kcbeiN/XlxMeZHLYVEQ1gyQa4nvUvo7QDWbIILllkLbljzB
 9v6Vx1csLVfW6WXOLnw2qFPbapk8DC8fgCMnti5H1Ph80DXIW3FXA7lrunrr66t9T4
 QtzCBFpEToZ9Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Xinhui Yang <cyan@cyano.uk>
Subject: [PULL 2/8] linux-user/strace: add fsmount series of syscalls
Date: Mon,  8 Jun 2026 21:42:50 +0200
Message-ID: <20260608194256.13794-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194256.13794-1-deller@kernel.org>
References: <20260608194256.13794-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Xinhui Yang <cyan@cyano.uk>

Following the addition of fsmount(2) series of syscalls in the syscall
handler, strace support is added, with a dedicated function to print the
parameters of fsconfig(2), which contains parameters that can be
interpreted as multiple types.

Snippet of the strace dump when running `mount -t tmpfs tmpfs /media`:

18 fsopen(tmpfs,1) = 3
18 read(3,0x407fcf1c,8191) = -1 errno=61 (No data available)
18 fsconfig(3,FSCONFIG_SET_STRING,"source","tmpfs",0) = 0
18 read(3,0x407fce3c,8191) = -1 errno=61 (No data available)
18 fsconfig(3,FSCONFIG_CMD_CREATE,NULL,NULL,0) = 0
18 read(3,0x407fce3c,8191) = -1 errno=61 (No data available)
18 fsmount(3,1,0) = 4
18 read(3,0x407fce3c,8191) = -1 errno=61 (No data available)
18 statx(4,"",AT_EMPTY_PATH|AT_STATX_SYNC_AS_STAT,0x1000,0x407fee98) = 0
18 move_mount(4,,-100,/media,4) = 0
18 read(3,0x407fcfcc,8191) = -1 errno=61 (No data available)
18 close(3) = 0
18 close(4) = 0

Signed-off-by: Xinhui Yang <cyan@cyano.uk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.c    | 105 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  15 ++++++
 2 files changed, 120 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2cbaf94c89..d861f311f6 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4344,6 +4344,111 @@ print_statx(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_fsconfig
+static void
+print_fsconfig_cmd_name(int cmd)
+{
+    switch (cmd) {
+    case FSCONFIG_SET_FLAG:
+        qemu_log("%s%s", "FSCONFIG_SET_FLAG", get_comma(0));
+        break;
+    case FSCONFIG_SET_STRING:
+        qemu_log("%s%s", "FSCONFIG_SET_STRING", get_comma(0));
+        break;
+    case FSCONFIG_SET_BINARY:
+        qemu_log("%s%s", "FSCONFIG_SET_BINARY", get_comma(0));
+        break;
+    case FSCONFIG_SET_PATH:
+        qemu_log("%s%s", "FSCONFIG_SET_PATH", get_comma(0));
+        break;
+    case FSCONFIG_SET_PATH_EMPTY:
+        qemu_log("%s%s", "FSCONFIG_SET_PATH_EMPTY", get_comma(0));
+        break;
+    case FSCONFIG_SET_FD:
+        qemu_log("%s%s", "FSCONFIG_SET_FD", get_comma(0));
+        break;
+    case FSCONFIG_CMD_CREATE:
+        qemu_log("%s%s", "FSCONFIG_CMD_CREATE", get_comma(0));
+        break;
+    case FSCONFIG_CMD_RECONFIGURE:
+        qemu_log("%s%s", "FSCONFIG_CMD_RECONFIGURE", get_comma(0));
+        break;
+#ifdef FSCONFIG_CMD_CREATE_EXCL
+    case FSCONFIG_CMD_CREATE_EXCL:
+        /* Only available since Linux 6.6. */
+        qemu_log("%s%s", "FSCONFIG_CMD_CREATE_EXCL", get_comma(0));
+        break;
+#endif
+    default:
+        qemu_log("%s (%d)%s", "UNKNOWN_CMD", cmd, get_comma(0));
+        break;
+    }
+}
+
+static void
+print_fsconfig(CPUArchState *cpu_env, const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    /*
+     * fsconfig(int fd, int cmd, char* key, void* value, int aux)
+     * Where:
+     * fd: file descriptor returned by fsopen().
+     * cmd: integer constant specifying a command.
+     * key: a string, can be NULL on certain commands.
+     * value: any data in a buffer, can be NULL, raw buffer or a string.
+     * aux: axillary values such as flags for FSCONFIG_SET_PATH.
+     */
+    int cmd = (int) arg1;
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_fsconfig_cmd_name(cmd);
+    /* Process arg2 (key). */
+    switch (cmd) {
+    case FSCONFIG_SET_FLAG:
+    case FSCONFIG_SET_STRING:
+    case FSCONFIG_SET_BINARY:
+    case FSCONFIG_SET_PATH:
+    case FSCONFIG_SET_PATH_EMPTY:
+    case FSCONFIG_SET_FD:
+        print_string(arg2, 0);
+        break;
+    default:
+        print_pointer(arg2, 0);
+        break;
+    }
+    /* Process arg3 (value). */
+    switch (cmd) {
+    case FSCONFIG_SET_STRING:
+    case FSCONFIG_SET_PATH:
+    case FSCONFIG_SET_PATH_EMPTY:
+        print_string(arg3, 0);
+        break;
+    default:
+        print_pointer(arg3, 0);
+        break;
+    }
+    /*
+     * Process arg4 (aux).
+     * On FSCONFIG_SET_PATH and FSCONFIG_SET_PATH_EMPTY, aux can
+     * be either 0 or AT_FDCWD.
+     * On FSCONFIG_SET_BINARY, aux is an integer to state the length
+     * of the buffer pointed by arg3.
+     * Otherwise, it must be 0.
+     */
+    switch (cmd) {
+    case FSCONFIG_SET_PATH:
+    case FSCONFIG_SET_PATH_EMPTY:
+        print_at_dirfd(arg4, 1);
+        break;
+    default:
+        print_raw_param("%d", arg4, 1);
+        break;
+    }
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_ioctl
 static void
 print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 6162a407f9..3a366b8cac 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1722,3 +1722,18 @@
 #ifdef TARGET_NR_rseq
 { TARGET_NR_rseq, "rseq" , "%s(%p,%u,%d,%#x)", NULL, NULL },
 #endif
+#ifdef TARGET_NR_fsopen
+{ TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
+#endif
+#ifdef TARGET_NR_fsconfig
+{ TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
+#endif
+#ifdef TARGET_NR_fsmount
+{ TARGET_NR_fsmount, "fsmount", "%s(%d,%d,%d)", NULL, NULL },
+#endif
+#ifdef TARGET_NR_move_mount
+{ TARGET_NR_move_mount, "move_mount", "%s(%d,%s,%d,%s,%d)", NULL, NULL },
+#endif
+#ifdef TARGET_NR_fspick
+{ TARGET_NR_fspick, "fspick", "%s(%d,%s,%d)", NULL, NULL },
+#endif
-- 
2.54.0


