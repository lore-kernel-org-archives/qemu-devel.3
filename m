Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267D3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmRW-0001Uq-P4; Thu, 09 Jul 2026 06:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1whmRV-0001U0-37
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1whmRS-0004P2-RM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783594636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HE5KFOnCzp23735KR1LCbTJaqRC1GzvULBi35G3mceQ=;
 b=bEO24VLtvWwh1/nprInBE5mKAv6x1wIV0G+lNSsnfFr+YqU2ovvctzJWUnT4/OyBQi02O0
 imPDIfCNr5RWQEJkQD9AqPWENFLTIKjRV/9C3owfTx6FHTiD9zQf/IYVhl3GIZ5WU/Ss2/
 Hfm8YIg99Q3QrunqiPWwAc0FeND/QHg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-4mRrgQ29PxySnEfMkFMXkQ-1; Thu,
 09 Jul 2026 06:57:13 -0400
X-MC-Unique: 4mRrgQ29PxySnEfMkFMXkQ-1
X-Mimecast-MFC-AGG-ID: 4mRrgQ29PxySnEfMkFMXkQ_1783594632
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DB261955F1E; Thu,  9 Jul 2026 10:57:12 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.33.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 703221955D71; Thu,  9 Jul 2026 10:57:10 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Valentino Paulon <valentino.paulon88@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
Date: Thu,  9 Jul 2026 13:57:07 +0300
Message-ID: <20260709105707.91209-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
it to obtain root

Fixes: CVE-2026-12080
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929

Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 661972e34e..4e717d8ae8 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const struct passwd *p,
         return false;
     }
 
-    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
+    if (lchown(path, p->pw_uid, p->pw_gid) == -1) {
         error_setg_errno(errp, errno,
                          "failed to set ownership of directory '%s'",
                          path);
@@ -96,7 +96,7 @@ write_authkeys(const char *path, const GStrv keys,
         return false;
     }
 
-    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
+    if (lchown(path, p->pw_uid, p->pw_gid) == -1) {
         error_setg_errno(errp, errno,
                          "failed to set ownership of directory '%s'",
                          path);
@@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     g_auto(GStrv) authkeys = NULL;
     strList *k;
     size_t nkeys, nauthkeys;
+    int fd;
 
     reset = has_reset && reset;
 
@@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
     ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
     authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
 
+    fd = open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
+    if (fd == -1) {
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "failed to open directory '%s'", ssh_path);
+            return;
+        }
+    }
+
     if (!reset) {
         authkeys = read_authkeys(authkeys_path, NULL);
     }
     if (authkeys == NULL) {
-        if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
-            !mkdir_for_user(ssh_path, p, 0700, errp)) {
+        if (fd == -1 && !mkdir_for_user(ssh_path, p, 0700, errp)) {
             return;
         }
     }
+    if (fd >= 0) {
+        close(fd);
+    }
 
     nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
     authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
@@ -167,11 +178,13 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
                                      Error **errp)
 {
     g_autofree struct passwd *p = NULL;
+    g_autofree char *ssh_path = NULL;
     g_autofree char *authkeys_path = NULL;
     g_autofree GStrv new_keys = NULL; /* do not own the strings */
     g_auto(GStrv) authkeys = NULL;
     GStrv a;
     size_t nkeys = 0;
+    int fd;
 
     if (!check_openssh_pub_keys(keys, NULL, errp)) {
         return;
@@ -182,8 +195,19 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
         return;
     }
 
-    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
-                                     "authorized_keys", NULL);
+    ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
+    authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
+
+    fd = open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
+    if (fd == -1) {
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "failed to open directory '%s'", ssh_path);
+            return;
+        }
+    } else {
+        close(fd);
+    }
+
     if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
         return;
     }
@@ -215,18 +239,31 @@ GuestAuthorizedKeys *
 qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
 {
     g_autofree struct passwd *p = NULL;
+    g_autofree char *ssh_path = NULL;
     g_autofree char *authkeys_path = NULL;
     g_auto(GStrv) authkeys = NULL;
     g_autoptr(GuestAuthorizedKeys) ret = NULL;
     int i;
+    int fd;
 
     p = get_passwd_entry(username, errp);
     if (p == NULL) {
         return NULL;
     }
 
-    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
-                                     "authorized_keys", NULL);
+    ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
+    authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
+
+    fd = open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
+    if (fd == -1) {
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "failed to open directory '%s'", ssh_path);
+            return NULL;
+        }
+    } else {
+        close(fd);
+    }
+
     authkeys = read_authkeys(authkeys_path, errp);
     if (authkeys == NULL) {
         return NULL;
-- 
2.53.0


