Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EACC5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtNXM-00033h-VS; Mon, 10 Aug 2026 06:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtNXC-00032a-Tg
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtNXA-0001Xi-Ju
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786358827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ls7Wt/NTEkIWZn7C0lYJ3GnGfni2njLnErB2N1AdkUk=;
 b=RMliF3pCZtcc6scP1EC/kaEKjSX/kJV8ZEQYw0jA1R86bjXK6enHfQ7ROVnpPHuuCOOPut
 p2Sa4xtum9+H7BYPpIruqbcc4K7wp46VM+cfR1C2ay3kOKMMJzEMsS1uIpRM5uM1P3OAwO
 nKdd4PeuRnXN6Iy7Yqbneti/9k9iP70=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-bRYp6ploNBqOZP3FFZnoGg-1; Mon,
 10 Aug 2026 06:47:05 -0400
X-MC-Unique: bRYp6ploNBqOZP3FFZnoGg-1
X-Mimecast-MFC-AGG-ID: bRYp6ploNBqOZP3FFZnoGg_1786358824
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE1218004BB; Mon, 10 Aug 2026 10:47:04 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.144])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86BB83001DAF; Mon, 10 Aug 2026 10:47:02 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Valentino Paulon <valentino.paulon88@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2] qga: Change effective user/group ID in guest-ssh-* commands
Date: Mon, 10 Aug 2026 13:46:59 +0300
Message-ID: <20260810104659.82320-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
SSH key for an existing local user, the agent (running as root) decides
whether to create the user's .ssh directory with a symlink-following
directory test, and then writes and chowns the authorized_keys file.
A local unprivileged user who owns their home directory can pre-stage
their .ssh directory (or the authorized_keys file) as a symbolic link
so that, when the host or operator triggers a key add for that user,
the root agent follows the link and transfers ownership of an arbitrary
root-owned file or directory to the unprivileged user, who can then rewrite
it to obtain root.

Fixes: CVE-2026-12080
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929

v1: https://patchew.org/QEMU/20260709105707.91209-1-kkostiuk@redhat.com/
v2 -> v1:
Change effective user/group ID instead of checking for symlinks and
changing ownership of the file.

Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix-ssh.c | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 661972e34e..9a3507fda4 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -8,6 +8,7 @@
 #include <glib/gstdio.h>
 #include <locale.h>
 #include <pwd.h>
+#include <grp.h>

 #include "commands-common-ssh.h"
 #include "qapi/error.h"
@@ -123,6 +124,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     g_auto(GStrv) authkeys = NULL;
     strList *k;
     size_t nkeys, nauthkeys;
+    uid_t euid, egid;
+    __attribute__((unused)) uid_t unused_euid;
+    __attribute__((unused)) uid_t unused_egid;

     reset = has_reset && reset;

@@ -135,6 +139,29 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
         return;
     }

+    euid = geteuid();
+    egid = getegid();
+#ifndef QGA_BUILD_UNIT_TEST
+    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
+    if (initgroups(p->pw_name, p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set group for user '%s'",
+                         p->pw_name);
+        return;
+    }
+#endif
+    if (setegid(p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
+                         p->pw_name);
+        return;
+    }
+    if (seteuid(p->pw_uid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
+                         p->pw_name);
+        /* Ignore errors, we can't do anything in this case */
+        unused_egid = setegid(egid);
+        return;
+    }
+
     ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
     authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);

@@ -144,6 +171,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     if (authkeys == NULL) {
         if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
             !mkdir_for_user(ssh_path, p, 0700, errp)) {
+            /* Ignore errors, we can't do anything in this case */
+            unused_euid = seteuid(euid);
+            unused_egid = setegid(egid);
             return;
         }
     }
@@ -160,6 +190,9 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     }

     write_authkeys(authkeys_path, authkeys, p, errp);
+    /* Ignore errors, we can't do anything in this case */
+    unused_euid = seteuid(euid);
+    unused_egid = setegid(egid);
 }

 void
@@ -172,6 +205,9 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
     g_auto(GStrv) authkeys = NULL;
     GStrv a;
     size_t nkeys = 0;
+    uid_t euid, egid;
+    __attribute__((unused)) uid_t unused_euid;
+    __attribute__((unused)) uid_t unused_egid;

     if (!check_openssh_pub_keys(keys, NULL, errp)) {
         return;
@@ -182,6 +218,29 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
         return;
     }

+    euid = geteuid();
+    egid = getegid();
+#ifndef QGA_BUILD_UNIT_TEST
+    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
+    if (initgroups(p->pw_name, p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set group for user '%s'",
+                         p->pw_name);
+        return;
+    }
+#endif
+    if (setegid(p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
+                         p->pw_name);
+        return;
+    }
+    if (seteuid(p->pw_uid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
+                         p->pw_name);
+        /* Ignore errors, we can't do anything in this case */
+        unused_egid = setegid(egid);
+        return;
+    }
+
     authkeys_path = g_build_filename(p->pw_dir, ".ssh",
                                      "authorized_keys", NULL);
     if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
@@ -209,6 +268,9 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
     }

     write_authkeys(authkeys_path, new_keys, p, errp);
+    /* Ignore errors, we can't do anything in this case */
+    unused_euid = seteuid(euid);
+    unused_egid = setegid(egid);
 }

 GuestAuthorizedKeys *
@@ -219,16 +281,45 @@ qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
     g_auto(GStrv) authkeys = NULL;
     g_autoptr(GuestAuthorizedKeys) ret = NULL;
     int i;
+    uid_t euid, egid;
+    __attribute__((unused)) uid_t unused_euid;
+    __attribute__((unused)) uid_t unused_egid;

     p = get_passwd_entry(username, errp);
     if (p == NULL) {
         return NULL;
     }

+    euid = geteuid();
+    egid = getegid();
+#ifndef QGA_BUILD_UNIT_TEST
+    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
+    if (initgroups(p->pw_name, p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set group for user '%s'",
+                         p->pw_name);
+        return NULL;
+    }
+#endif
+    if (setegid(p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
+                         p->pw_name);
+        return NULL;
+    }
+    if (seteuid(p->pw_uid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
+                         p->pw_name);
+        /* Ignore errors, we can't do anything in this case */
+        unused_egid = setegid(egid);
+        return NULL;
+    }
+
     authkeys_path = g_build_filename(p->pw_dir, ".ssh",
                                      "authorized_keys", NULL);
     authkeys = read_authkeys(authkeys_path, errp);
     if (authkeys == NULL) {
+        /* Ignore errors, we can't do anything in this case */
+        unused_euid = seteuid(euid);
+        unused_egid = setegid(egid);
         return NULL;
     }

@@ -242,6 +333,9 @@ qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
         QAPI_LIST_PREPEND(ret->keys, g_strdup(authkeys[i]));
     }

+    /* Ignore errors, we can't do anything in this case */
+    unused_euid = seteuid(euid);
+    unused_egid = setegid(egid);
     return g_steal_pointer(&ret);
 }

--
2.55.0


