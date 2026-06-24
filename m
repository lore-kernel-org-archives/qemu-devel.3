Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF048CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFoX-0007P3-CR; Wed, 24 Jun 2026 01:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFoO-0007Am-VJ; Wed, 24 Jun 2026 01:06:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFoM-0005da-Ut; Wed, 24 Jun 2026 01:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277465; bh=hcSqPayhHKO9FrbMDEwuAQ+tkuDKFw4krcFRw1pUuaE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RjfqNnkYazbPP0rol5efvkOf4eZ+uH+5bnDG4nFockZLM6jMs5kXz0DCTFsUlqtkJ
 Fr28Uutk0XUs60BMQ7asjRVCAFYesGWWw4MlhDmlLm+jyQlM2daP2pw5CUEKaSCBcC
 H0Wf9b6G+I44yeVzm0SypnYQm0nS7x3eohWPc467UfwJM4QLZaVq48JF7nHxbzoZQ7
 BYJPujf6WclYHGOuHMC9RfxtGuPe3fLZ9AuGu/dX7BUj9wndfoWTqUliAb/PWfF+7t
 JblrAiOKHmpySWMwdypyf3GwKSXfJbMWw5DtP+we5AcRyZU6xCVkIZq6T/gS9jmZzX
 KSX+RxqHkscYw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B205E1BA642;
 Wed, 24 Jun 2026 08:04:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9CD933DDACD;
 Wed, 24 Jun 2026 08:04:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 79/86] hw/9pfs: consolidate name validation with
 check_name()
Date: Wed, 24 Jun 2026 08:02:50 +0300
Message-ID: <20260624050404.394225-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add a new, shared helper function check_name() that consolidates the name
validation logic (illegal name check and "." / ".." rejection) currently
spread over multiple 9p handlers, unnecessarily duplicating code.

This is pure refactoring with no behavior change. The existing error code
semantics are preserved: rename operations return -EISDIR, create
operations return -EEXIST.

Note: These current error codes actually differ from native Linux system
calls (e.g. rename() returns -EBUSY, open(O_CREAT) returns -EISDIR). The 9P
protocol does not mandate specific error codes for these validation errors.
Hence consolidating to a single error code (e.g., -EINVAL) for all cases
could be considered in the future for simplicity reason.

This change reduces code duplication across 9 functions:

- v9fs_lcreate
- v9fs_create
- v9fs_symlink
- v9fs_link
- v9fs_rename
- v9fs_renameat
- v9fs_wstat
- v9fs_mknod
- v9fs_mkdir

Link: https://lore.kernel.org/qemu-devel/0573103880129eb543f07b68c77e86f2f572f6bf.1780072238.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 116db2986b11c914217bbd1547815b6c7efb944a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 34ac2c3c9a..9718daab61 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1802,6 +1802,25 @@ static bool name_is_illegal(const char *name)
     return !*name || strchr(name, '/') != NULL;
 }
 
+static int check_name(const char *name, V9fsPDU *pdu)
+{
+    int request_type = pdu->id;
+
+    if (name_is_illegal(name)) {
+        return -ENOENT;
+    }
+    if (!strcmp(name, ".") || !strcmp(name, "..")) {
+        /*
+         * TODO: The different error codes here are just there to preserve
+         * pre-existing behaviour of 9p server. In future it might make sense to
+         * consolidate this and e.g. just return -EINVAL for everyone.
+         */
+        return (request_type == P9_TRENAME || request_type == P9_TRENAMEAT ||
+                request_type == P9_TWSTAT) ? -EISDIR : -EEXIST;
+    }
+    return 0;
+}
+
 static bool same_stat_id(const struct stat *a, const struct stat *b)
 {
     return a->st_dev == b->st_dev && a->st_ino == b->st_ino;
@@ -2152,13 +2171,8 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
     }
     trace_v9fs_lcreate(pdu->tag, pdu->id, dfid, flags, mode, gid);
 
-    if (name_is_illegal(name.data)) {
-        err = -ENOENT;
-        goto out_nofid;
-    }
-
-    if (!strcmp(".", name.data) || !strcmp("..", name.data)) {
-        err = -EEXIST;
+    err = check_name(name.data, pdu);
+    if (err < 0) {
         goto out_nofid;
     }
 
@@ -2840,13 +2854,8 @@ static void coroutine_fn v9fs_create(void *opaque)
     }
     trace_v9fs_create(pdu->tag, pdu->id, fid, name.data, perm, mode);
 
-    if (name_is_illegal(name.data)) {
-        err = -ENOENT;
-        goto out_nofid;
-    }
-
-    if (!strcmp(".", name.data) || !strcmp("..", name.data)) {
-        err = -EEXIST;
+    err = check_name(name.data, pdu);
+    if (err < 0) {
         goto out_nofid;
     }
 
@@ -3034,13 +3043,8 @@ static void coroutine_fn v9fs_symlink(void *opaque)
     }
     trace_v9fs_symlink(pdu->tag, pdu->id, dfid, name.data, symname.data, gid);
 
-    if (name_is_illegal(name.data)) {
-        err = -ENOENT;
-        goto out_nofid;
-    }
-
-    if (!strcmp(".", name.data) || !strcmp("..", name.data)) {
-        err = -EEXIST;
+    err = check_name(name.data, pdu);
+    if (err < 0) {
         goto out_nofid;
     }
 
@@ -3127,13 +3131,8 @@ static void coroutine_fn v9fs_link(void *opaque)
     }
     trace_v9fs_link(pdu->tag, pdu->id, dfid, oldfid, name.data);
 
-    if (name_is_illegal(name.data)) {
-        err = -ENOENT;
-        goto out_nofid;
-    }
-
-    if (!strcmp(".", name.data) || !strcmp("..", name.data)) {
-        err = -EEXIST;
+    err = check_name(name.data, pdu);
+    if (err < 0) {
         goto out_nofid;
     }
 
@@ -3364,13 +3363,8 @@ static void coroutine_fn v9fs_rename(void *opaque)
         goto out_nofid;
     }
 
-    if (name_is_illegal(name.data)) {
-        err = -ENOENT;
-        goto out_nofid;
-    }
-
-    if (!strcmp(".", name.data) || !strcmp("..", name.data)) {
-        err = -EISDIR;
+    err = check_name(name.data, pdu);
+    if (err < 0) {
         goto out_nofid;
     }
 
@@ -3505,14 +3499,12 @@ static void coroutine_fn v9fs_renameat(void *opaque)
         goto out_err;
     }
 
-    if (name_is_illegal(old_name.data) || name_is_illegal(new_name.data)) {
-        err = -ENOENT;
+    err = check_name(old_name.data, pdu);
+    if (err < 0) {
         goto out_err;
     }
-
-    if (!strcmp(".", old_name.data) || !strcmp("..", old_name.data) ||
-        !strcmp(".", new_name.data) || !strcmp("..", new_name.data)) {
-        err = -EISDIR;
+    err = check_name(new_name.data, pdu);
+    if (err < 0) {
         goto out_err;
     }
 
@@ -3617,12 +3609,8 @@ static void coroutine_fn v9fs_wstat(void *opaque)
             err = -EOPNOTSUPP;
             goto out;
         }
-        if (name_is_illegal(v9stat.name.data)) {
-            err = -ENOENT;
-            goto out;
-        }
-        if (!strcmp(".", v9stat.name.data) || !strcmp("..", v9stat.name.data)) {
-            err = -EISDIR;
+        err = check_name(v9stat.name.data, pdu);
+        if (err < 0) {
             goto out;
         }
 
@@ -3755,13 +3743,8 @@ static void coroutine_fn v9fs_mknod(void *opaque)
     }
     trace_v9fs_mknod(pdu->tag, pdu->id, fid, mode, major, minor);
 
-    if (name_is_illegal(name.data)) {
-        err = -ENOENT;
-        goto out_nofid;
-    }
-
-    if (!strcmp(".", name.data) || !strcmp("..", name.data)) {
-        err = -EEXIST;
+    err = check_name(name.data, pdu);
+    if (err < 0) {
         goto out_nofid;
     }
 
@@ -3917,13 +3900,8 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
     }
     trace_v9fs_mkdir(pdu->tag, pdu->id, fid, name.data, mode, gid);
 
-    if (name_is_illegal(name.data)) {
-        err = -ENOENT;
-        goto out_nofid;
-    }
-
-    if (!strcmp(".", name.data) || !strcmp("..", name.data)) {
-        err = -EEXIST;
+    err = check_name(name.data, pdu);
+    if (err < 0) {
         goto out_nofid;
     }
 
-- 
2.47.3


