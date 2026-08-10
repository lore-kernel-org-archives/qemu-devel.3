Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F01C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtQzS-0005CG-Aj; Mon, 10 Aug 2026 10:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtQzQ-0005Bz-2Q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtQzO-0003vA-5Y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786372108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PwXJvxXfdpoe0AuULr3pB8wBVG+pV4+OtLh3k+JYCKU=;
 b=Jp3TU6sB0geUMT35bj+j3hqfyG9YsWUgBcW/rbjQxCYIho869aB/kQCH8TLb0mCDeoMiTy
 2fPDRO4ZGksvWQmnsaBIwDgHMLllC9gF/fpugLsHsulapUiRNS1LeXvOY50A0ayEHIq2Ty
 13ROUF06rXewUv2rv1fk+3LJQXEBpI4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-NHGu428iMtScK6OTjU-vxw-1; Mon,
 10 Aug 2026 10:28:25 -0400
X-MC-Unique: NHGu428iMtScK6OTjU-vxw-1
X-Mimecast-MFC-AGG-ID: NHGu428iMtScK6OTjU-vxw_1786372104
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7A841956095; Mon, 10 Aug 2026 14:28:23 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.144])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8E431800347; Mon, 10 Aug 2026 14:28:21 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Valentino Paulon <valentino.paulon88@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v4] qga: Change effective user/group ID in guest-ssh-* commands
Date: Mon, 10 Aug 2026 17:28:18 +0300
Message-ID: <20260810142818.170418-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v2: https://patchew.org/QEMU/20260810104659.82320-1-kkostiuk@redhat.com
v3 -> v2:
Deduplicate code.
Fail daemon when can't rollback effective user/group ID.

v3: https://patchew.org/QEMU/20260810140641.161728-1-kkostiuk@redhat.com/
v4 -> v3:
Added comment about assert in rollback_effective_info
Fix memory leak in rollback_effective_info

Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix-ssh.c | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 661972e34e..aa3411049f 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -8,11 +8,34 @@
 #include <glib/gstdio.h>
 #include <locale.h>
 #include <pwd.h>
+#include <grp.h>
 
 #include "commands-common-ssh.h"
 #include "qapi/error.h"
 #include "qga-qapi-commands.h"
 
+typedef struct EffectiveUserInfo {
+    uid_t uid;
+    gid_t gid;
+} EffectiveUserInfo;
+
+typedef EffectiveUserInfo *PEffectiveUserInfo;
+
+static void rollback_effective_info(PEffectiveUserInfo info)
+{
+    if (info) {
+        /* There is nothing to do in case  when rollback to original user/group IDs
+         * fails. In that case, the process will be terminated by the kernel
+         * and systemd should restart the daemon again.
+         */
+        assert(seteuid(info->uid) == 0);
+        assert(setegid(info->gid) == 0);
+        g_free(info);
+    }
+}
+
+G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PEffectiveUserInfo, rollback_effective_info, NULL);
+
 #ifdef QGA_BUILD_UNIT_TEST
 static struct passwd *
 test_get_passwd_entry(const gchar *user_name, GError **error)
@@ -112,6 +135,36 @@ write_authkeys(const char *path, const GStrv keys,
     return true;
 }
 
+static PEffectiveUserInfo set_privileges_to_user(const struct passwd *p, Error **errp)
+{
+    g_auto(PEffectiveUserInfo) info = g_new0(EffectiveUserInfo, 1);
+
+    info->uid = geteuid();
+    info->gid = getegid();
+
+#ifndef QGA_BUILD_UNIT_TEST
+    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
+    if (initgroups(p->pw_name, p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set group for user '%s'",
+                         p->pw_name);
+        return NULL;
+    }
+#endif
+
+    if (setegid(p->pw_gid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
+                         p->pw_name);
+        return NULL;
+    }
+    if (seteuid(p->pw_uid) == -1) {
+        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
+                         p->pw_name);
+        return NULL;
+    }
+
+    return g_steal_pointer(&info);
+}
+
 void
 qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
                                   bool has_reset, bool reset,
@@ -123,6 +176,7 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     g_auto(GStrv) authkeys = NULL;
     strList *k;
     size_t nkeys, nauthkeys;
+    g_auto(PEffectiveUserInfo) effective_user_info = NULL;
 
     reset = has_reset && reset;
 
@@ -135,6 +189,11 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
         return;
     }
 
+    effective_user_info = set_privileges_to_user(p, errp);
+    if (effective_user_info == NULL) {
+        return;
+    }
+
     ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
     authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
 
@@ -172,6 +231,7 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
     g_auto(GStrv) authkeys = NULL;
     GStrv a;
     size_t nkeys = 0;
+    g_auto(PEffectiveUserInfo) effective_user_info = NULL;
 
     if (!check_openssh_pub_keys(keys, NULL, errp)) {
         return;
@@ -182,6 +242,11 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
         return;
     }
 
+    effective_user_info = set_privileges_to_user(p, errp);
+    if (effective_user_info == NULL) {
+        return;
+    }
+
     authkeys_path = g_build_filename(p->pw_dir, ".ssh",
                                      "authorized_keys", NULL);
     if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
@@ -219,12 +284,18 @@ qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
     g_auto(GStrv) authkeys = NULL;
     g_autoptr(GuestAuthorizedKeys) ret = NULL;
     int i;
+    g_auto(PEffectiveUserInfo) effective_user_info = NULL;
 
     p = get_passwd_entry(username, errp);
     if (p == NULL) {
         return NULL;
     }
 
+    effective_user_info = set_privileges_to_user(p, errp);
+    if (effective_user_info == NULL) {
+        return NULL;
+    }
+
     authkeys_path = g_build_filename(p->pw_dir, ".ssh",
                                      "authorized_keys", NULL);
     authkeys = read_authkeys(authkeys_path, errp);
-- 
2.55.0


