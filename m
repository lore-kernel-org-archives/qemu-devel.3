Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBDECDE004
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNpr-0006Zr-Tf; Wed, 24 Jun 2026 09:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNpq-0006Yb-Du; Wed, 24 Jun 2026 09:40:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNpk-0001Nm-T0; Wed, 24 Jun 2026 09:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308000; bh=m5IAU8IqElonT7fQAjsY3AIw/X/Ijl9y7o08uPY1MMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DnP8R4BOiS66L0FC0MRycRrToA3G5BO6KYgsbPYUWlMPpEuDSgEP4dYz/9fvFT5o6
 giZLNW1m/KWXIzZgkBWNiBV5kjTlYWevuEPCh/JNzs2bfPCzB/bOo21oEr50RPhUpx
 SWl7s4dEKvuYfzbOjtMCG1EwIiQyh8wpumUp5gBhMq4uB42z/OJrZ8WqVxsGkqzv4n
 2ss5CTRBaObJzeyev+XSnLC2Sfj8IMJf3zpSQ9VwBAd9lqPHM+YuTtBl47RaIumpIs
 YeKIL+mbU0pKXNVY4oO+FevTEO50BidXgGhFwYSyE4yGRd7Dckv0W4QpE7VkPmG2Rl
 fQqfgt0qCSz9A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 444821BA9FA;
 Wed, 24 Jun 2026 16:33:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D52123DEA49;
 Wed, 24 Jun 2026 16:33:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xinhui Yang <cyan@cyano.uk>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 072/107] linux-user/strace: add fsmount series of
 syscalls
Date: Wed, 24 Jun 2026 16:31:17 +0300
Message-ID: <20260624133301.403266-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

v2: Fixed build on RHEL9 due to missing syscalls (Helge)

Signed-off-by: Xinhui Yang <cyan@cyano.uk>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 6e0aa9f6c731df3f8d1071cfd5ec63fe7b923713)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2cbaf94c89..3a81cc95f4 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4344,6 +4344,111 @@ print_statx(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
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
index 6162a407f9..e363892e0a 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1722,3 +1722,18 @@
 #ifdef TARGET_NR_rseq
 { TARGET_NR_rseq, "rseq" , "%s(%p,%u,%d,%#x)", NULL, NULL },
 #endif
+#ifdef TARGET_NR_fsopen
+{ TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
+#endif
+#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
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
2.47.3


