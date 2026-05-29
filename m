Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67D1CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0fg-00069A-4A; Fri, 29 May 2026 13:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0573103880129eb543f07b68c77e86f2f572f6bf@kylie.crudebyte.com>)
 id 1wT0fZ-00068X-JD
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:06:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0573103880129eb543f07b68c77e86f2f572f6bf@kylie.crudebyte.com>)
 id 1wT0fW-0005uz-L0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=gvgoP/DgFItr+dDpBQNnzHxIlewLZzV9f9f39ccdEQY=; b=v76Kb
 LyynOByhW1PDlIU8cW+Q+zZwerfyd5+vu6BH4//bszPTcTDzM6WpDROchSQXtaRi/SBfY+yLTnco0
 hnxAkrHqbipe82SD9D3mNcLgaYVeJXGoAc8qQKJSHpHG26eZ/ynDS29CwxxSQLdgz+YFo4fgSAljD
 8j5HvUTcYUGAcIEjKy4fRUhMwhEBo3AJRijeuEhcZzYhqgXEEYrCdEV1ErdjTgUFZCrTVlVJhymbK
 l7Sdrt9/D9ZmH4zqSAnASMn0B2ZRbzUycgT/B4ApE/V6j8pxngyfbgEKGexGM6ewxMascTAORRPW3
 dq6FPASdwC04Oudq274d0rP1f5bV9+sKYPGxZjh/DjgjMkAo6L3MTwD75U6s0gQ2LNreNUPMiFdtH
 uADgdqZ2nMUjyaSjSBcuIpSGx28NncLq1cpkES06UTdE5glIlEW3zL9+muqTbjvoXTqCkjdAqQwcs
 gb9jzfE3ucuYnYlv6CrtwzHcdj+NzWfhYk+ukDJWlFRveEVx+d8lH3Jtizspjz+WlmiXVY6JjY+Td
 8QWb44kPmDR2BR+gOrawHllJKvvXXgjEYHaGyCNgP842ZTFKEOyE6CSeCG7rj9ylQUdCRSX8YbzA7
 QqwDM9SvPeWThlkSAlFhA9f/jvSg9H/8Pdb94n4E60Eri4xdBR90MlJHynFsPM=;
Message-ID: <0573103880129eb543f07b68c77e86f2f572f6bf.1780072238.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780072238.git.qemu_oss@crudebyte.com>
References: <cover.1780072238.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 29 May 2026 18:29:44 +0200
Subject: [PATCH 3/3] hw/9pfs: consolidate name validation with check_name()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=0573103880129eb543f07b68c77e86f2f572f6bf@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 100 ++++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 61 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index a09f99537d..9b46b33ba8 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1810,6 +1810,25 @@ static bool name_is_illegal(const char *name)
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
@@ -2160,13 +2179,8 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
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
 
@@ -2848,13 +2862,8 @@ static void coroutine_fn v9fs_create(void *opaque)
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
 
@@ -3042,13 +3051,8 @@ static void coroutine_fn v9fs_symlink(void *opaque)
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
 
@@ -3135,13 +3139,8 @@ static void coroutine_fn v9fs_link(void *opaque)
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
 
@@ -3367,13 +3366,8 @@ static void coroutine_fn v9fs_rename(void *opaque)
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

