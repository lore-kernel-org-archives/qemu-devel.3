Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC51710ED679
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67hg-0003jC-J2; Fri, 27 Mar 2026 09:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cathy.hu@suse.com>) id 1w64Rn-0000GF-4N
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:29:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cathy.hu@suse.com>) id 1w64Rk-0004Cp-OZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:29:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7F2D5BD8A;
 Fri, 27 Mar 2026 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1774607379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5zkz6jkP14jMftfP/gifRHwfT26GdKn69dqy76cSVg=;
 b=LkveOLzqPJqxbbrQUeixYZSJShbueOMFOVucrXpBG2huzA9u0H95ZY2NGRwTP1CVkSSZ3j
 6O7rciLrSe3yV5JXjHraH/ukOqV3SoBFIKuLc1oROHM7JrBR1OOL3yuPkkbUhhmFS2jx/G
 9a2jy1/35X4QHjmw4mw7T7I+A5v2nnE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1774607379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=H5zkz6jkP14jMftfP/gifRHwfT26GdKn69dqy76cSVg=;
 b=LkveOLzqPJqxbbrQUeixYZSJShbueOMFOVucrXpBG2huzA9u0H95ZY2NGRwTP1CVkSSZ3j
 6O7rciLrSe3yV5JXjHraH/ukOqV3SoBFIKuLc1oROHM7JrBR1OOL3yuPkkbUhhmFS2jx/G
 9a2jy1/35X4QHjmw4mw7T7I+A5v2nnE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82CBE4A0A2;
 Fri, 27 Mar 2026 10:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B3GlHhNcxmkwXAAAD6G6ig
 (envelope-from <cathy.hu@suse.com>); Fri, 27 Mar 2026 10:29:39 +0000
From: Cathy Hu <cathy.hu@suse.com>
To: qemu-devel@nongnu.org
Cc: Cathy Hu <cahu@suse.de>, Fabiano Rosas <fabiano.rosas@suse.com>,
 KVM Bugs <kvm-bugs@suse.de>
Subject: [PATCH RFC] qga: Add selinux-helper for guest-exec subcommand
 (bsc#1237450)
Date: Fri, 27 Mar 2026 11:25:19 +0100
Message-ID: <20260327102515.502822-5-cathy.hu@suse.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:url,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=cathy.hu@suse.com;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Mar 2026 09:58:17 -0400
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

From: Cathy Hu <cahu@suse.de>

Problem:

ATM the QEMU Guest Agent and SELinux are not working together properly.
The fedora (and therefor also the openSUSE) policy confine the qemu-guest-agent
service in the domain `qemu_ga_t`. That means, qemu-guest-agent
is only allowed to do what the policy says.

However, the `guest-exec` command allows arbitrary execution
of code from a privileged service, which conflicts with the
notion of SELinux confinement.

ATM, the policy allows only some accesses that are used
by other qemu-guest-agent commands.
That means, the qemu-guest-agent fails sporadically, depending
on what is allowed for other commands.
However, `guest-exec` would need to allow everything.

see https://bugzilla.suse.com/show_bug.cgi?id=1237450

Solution:

This is not an great solution, but it works like this:
We add a "wrapper" which is executed instead of the program
that is called via `guest-exec`. The "wrapper" just
re-executes the command given by `guest-exec`.
This way, on the SELinux policy side we can give that
wrapper executable a label on the file system.
With that label, we can transition into a more broader
unconfined domain _and_ toggle that transition with a
SELinux boolean. That would make `guest-exec`
consistently allowed to execute or not by policy.

This needs a change on the SELinux policy side to
accompany this with:
https://github.com/fedora-selinux/selinux-policy/pull/3122

What other options have been tried unsuccessfully:

- Fixing via SELinux policy: It is not possible for
  one domain to have different permissions depending on
  code path. It is also not possible to toggle the permissive
  state via a SELinux boolean, so users would need
  to add it via semanage.
- Setting the domain of the executed commands directly
  to a broader domain with setcon/setexeccon.
  The SELinux kernel does not allow to spawn a process
  directly with those that has broader privileges than the parent.

What other options are there to solve this issue:

- Making the qemu-guest-agent unconfined by default
- Document the workaround to use semanage to make the domain permissive
  if `exec-guest` is needed as works as intended and ignore the problem

Signed-off-by: Cathy Hu <cahu@suse.de>
---
 qga/commands.c               | 13 +++++++++++++
 qga/meson.build              |  7 +++++++
 qga/qemu-ga-selinux-helper.c | 17 +++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 qga/qemu-ga-selinux-helper.c

diff --git a/qga/commands.c b/qga/commands.c
index 5f20af25d3..29c092630b 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -30,6 +30,10 @@
  */
 #define GUEST_FILE_READ_COUNT_MAX (48 * MiB)
 
+#ifdef CONFIG_SELINUX
+#define GUEST_EXEC_SELINUX_HELPER CONFIG_QEMU_HELPERDIR "/qemu-ga-selinux-helper"
+#endif
+
 /* Note: in some situations, like with the fsfreeze, logging may be
  * temporarily disabled. if it is necessary that a command be able
  * to log for accounting purposes, check ga_logging_enabled() beforehand.
@@ -418,6 +422,9 @@ GuestExec *qmp_guest_exec(const char *path,
     GuestExecInfo *gei;
     char **argv, **envp;
     strList arglist;
+#ifdef CONFIG_SELINUX
+    strList helper_arg;
+#endif
     gboolean ret;
     GError *gerr = NULL;
     gint in_fd, out_fd, err_fd;
@@ -439,7 +446,13 @@ GuestExec *qmp_guest_exec(const char *path,
         }
     }
 
+#ifdef CONFIG_SELINUX
+    helper_arg.value = get_relocated_path(GUEST_EXEC_SELINUX_HELPER);
+    helper_arg.next = &arglist;
+    argv = guest_exec_get_args(&helper_arg, true);
+#else
     argv = guest_exec_get_args(&arglist, true);
+#endif
     envp = has_env ? guest_exec_get_args(env, false) : NULL;
 
     flags = G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REAP_CHILD |
diff --git a/qga/meson.build b/qga/meson.build
index 89a4a8f713..61f60fba26 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -125,6 +125,13 @@ qga = executable('qemu-ga', qga_ss.sources() + qga_objs,
                  install: true)
 all_qga += qga
 
+if selinux.found()
+  qga_selinux_helper = executable('qemu-ga-selinux-helper', files('qemu-ga-selinux-helper.c'),
+             install: true,
+             install_dir: get_option('libexecdir'))
+  all_qga += qga_selinux_helper
+endif
+
 if host_os == 'windows'
   qemu_ga_msi_arch = {
     'x86': ['-D', 'Arch=32'],
diff --git a/qga/qemu-ga-selinux-helper.c b/qga/qemu-ga-selinux-helper.c
new file mode 100644
index 0000000000..a184e74ede
--- /dev/null
+++ b/qga/qemu-ga-selinux-helper.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <stdio.h>
+#include <glib.h>
+
+int main(int argc, char **argv)
+{
+    if (argc < 2) {
+        return EXIT_FAILURE;
+    }
+
+    execvp(argv[1], argv + 1);
+
+    int err = errno;
+    fprintf(stderr, "%s: %s\n", argv[1], strerror(err));
+
+    exit(EXIT_FAILURE);
+}
-- 
2.53.0


