Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA9ECD98F6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsQm-0003sy-Mb; Wed, 17 Jun 2026 11:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <116db2986b11c914217bbd1547815b6c7efb944a@kylie.crudebyte.com>)
 id 1wZsQi-0003s3-PF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:43:52 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <116db2986b11c914217bbd1547815b6c7efb944a@kylie.crudebyte.com>)
 id 1wZsQg-0002KA-BQ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=ydKD9ckopWFoZeAHR6Jgy9oNnMyCzK+l886VcxKDjv0=; b=QiakA
 6jJ8oHt6iCCfkowGBTy1mAMrGYT7xj3dOM9blpzltjAA7yzXpad29FXRCjAnbd9Xt4PmZMYQpF3PM
 e34T2ePdip7SeWJEL2WXRGVl5namnaiDvKXQ4xQq6KJFSIQG5CwHqeVD4PgIR8O+/qNQi+BgftqW/
 BuLtET3s4n1Ivikh2wTFKTEZ2d9a9sknMPU2wmVxC35dVjeVyzUSmEi5HlJ5B4nFqk3sGwM1SPQf6
 luawLdc3dhRmrZOa3viSFbmNdfnuFlEGcFjCk/sPexYj12CJs8lZt/LrQdLLtfmBvIYtJW3eh74G8
 dV1rAVy0S3SkcX5f59okT2ueVEp+rJEU5tJUSXsKZf38hss3BK7oqzdN6C29NmJ44JCU9p7DEm1TR
 koLjUNN26fiBYP1bdnl+/Y4KsaXFkMDJFITNanJBsObZierGRc2rk8zINM7h38bFMmpmXglZoCa2g
 kqezCtDJTOyBTNcOovSjQwyIyq+/64Y53gPsUERCAaxMiWlVoxwDuA3nOnlQuGKyPAhLcixjXcHEH
 ErjjTeKp49mcF2T2hnjl7kzn8PyHiX2GMa4+tM2P5OvN5MdIeOEaHGii/fhrV4hXOaFrnn5Oe4ZPj
 kUG7iUGAF3JzEkPaWciTmz3cO6ZjvKxk5skbC7qUZ4thdC/kOSevzFabwDYnm4=;
Message-ID: <116db2986b11c914217bbd1547815b6c7efb944a.1781710785.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781710785.git.qemu_oss@crudebyte.com>
References: <cover.1781710785.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 17 Jun 2026 17:39:46 +0200
Subject: [PULL 3/3] hw/9pfs: consolidate name validation with check_name()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=116db2986b11c914217bbd1547815b6c7efb944a@kylie.crudebyte.com;
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

Link: https://lore.kernel.org/qemu-devel/0573103880129eb543f07b68c77e86f2f572f6bf.1780072238.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 100 ++++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 61 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 936e4e9349..b486cce48a 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1823,6 +1823,25 @@ static bool name_is_illegal(const char *name)
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
@@ -2173,13 +2192,8 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
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
 
@@ -2861,13 +2875,8 @@ static void coroutine_fn v9fs_create(void *opaque)
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
 
@@ -3055,13 +3064,8 @@ static void coroutine_fn v9fs_symlink(void *opaque)
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
 
@@ -3148,13 +3152,8 @@ static void coroutine_fn v9fs_link(void *opaque)
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
 
@@ -3385,13 +3384,8 @@ static void coroutine_fn v9fs_rename(void *opaque)
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
 
@@ -3526,14 +3520,12 @@ static void coroutine_fn v9fs_renameat(void *opaque)
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
 
@@ -3638,12 +3630,8 @@ static void coroutine_fn v9fs_wstat(void *opaque)
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
 
@@ -3776,13 +3764,8 @@ static void coroutine_fn v9fs_mknod(void *opaque)
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
 
@@ -3938,13 +3921,8 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
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


