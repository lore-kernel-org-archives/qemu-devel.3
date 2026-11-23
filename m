Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F8606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=peg8hOVU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWH3-00015r-Ke; Mon, 23 Nov 2026 10:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2525cce7794e82737cd6596e553d37f998e39b1f@kylie.crudebyte.com>)
 id 1xVWH1-00010I-KR
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:48:07 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2525cce7794e82737cd6596e553d37f998e39b1f@kylie.crudebyte.com>)
 id 1xVWGz-0005cA-Pr
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=DpuMby5JmPGf9ugBPQOlwNtIieH2Ifzc9cKjS+Hm/aY=; b=peg8h
 OVUnDLgh2NMaNXd/u0QL3J4NQpldqYogGfxhHEvcLpSmQDvPFwGtaP0hc3w+82OEHNG2guCMSHGlx
 qEAXOS85Z+R5ThdSQ4J3E2h/fpMVxARHQk12g/NFaLdbFQTXXgYwOAt3noCYgSt0rWNnBCyf0M5Ya
 RCbw1gd/9fZcokIx4jaSP2N5N0V96M+CkeuOfiWDvqu8fmHgQXg4LJqpOZ8+DFhsO6+eduFYKTbBx
 6z1FmILjbb8cjhBTsy72wJFOJNnS+zNpVzwKzoSu2A0fluv23KWvwZiJOFilHjDybg/Zh6A9ly69g
 q23MW7dOtBqWTMXSN4QMvNXbK3lBFzKdrJC/CycIbWfmWR5/PoY1qnGPvHtXpwVBT796qQAZ8wAXu
 H0nmAtFvjQXzPxZBRkz2o08gGepIyOPUWtYppi66Tl8Um0Pe+V5F+gwXiqS+NdEsObKVRBb5bw/wy
 7bRka1b6iBaL0Auvic90NP3uwdk/n7YLLR7AqvpJF/AsHpcGygsXfQ3Ek1iD7H47+DfEeLlYjETpq
 4HS4/Mz2wADKtsgJ254zBxkp0OZviMd2/ZcxQhI84e5Wlolk8NkEsgc9leiulQDeDV3IFiTHmYv1G
 +z3hjTO8DTNCkMbGxKaejATkAfwomC+6J+TxfOriI0kmTvvDDxqLginTFhmBJI=;
Message-ID: <2525cce7794e82737cd6596e553d37f998e39b1f.1795447869.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1795447869.git.qemu_oss@crudebyte.com>
References: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:25:04 +0100
Subject: [PATCH 6/7] hw/9pfs: local: abort on corrupt V9fsPath objects
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=2525cce7794e82737cd6596e553d37f998e39b1f@kylie.crudebyte.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Harden several local fs backend driver functions against
corrupted paths.

This is another hardening patch as a consequence of
CVE-2026-93834 (fixed by fe9e30899ff).

 - Add a new function local_path_sanity_check() which checks
   the passed V9fsPath object for corruption, and abort the
   QEMU process if a corrupted path was detected.

 - Call local_path_sanity_check() from exactly 4 functions
   that verify V9fsPath objects: local_lstat(), local_open(),
   local_open2() and local_opendir().

A V9fsPath object consists of exactly two fields:

  struct V9fsPath {
      size_t size;
      char *data;
  };

In the local fs driver backend `data` is the path string, and
`size` is the size of the path string including the terminating
NUL character.

The mentioned CVE exploited an incorrectly synchronized
concurrency window to mutate the two fields in a diverging way,
such that `size` would no longer reflect the correct size of
string stored by `data`, and it additionally tricked a mutation
of a sub-portion of the string only (in order to bypass
validation of the actual string content).

The check is placed at exactly these 4 functions, because in them
the path's contents turn into actions on the host file system:
they open files or directory streams, or they look file attributes
up by path. The CVE's exploit acted at these places.

Plus, for local_lstat() specifically: making a path copy
(v9fs_path_copy()) during Twalk is the only code that uses the
path's size field to make a decision, and such a copy enters the
local backend at local_lstat() first.

The other local backend functions receive a V9fsPath argument,
too, but never use its size field, so a diverged pair cannot do
damage at their entrances. The path elements they walk get
checked inside local_open_nofollow() anyway.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-local.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 8c8cf53bad..83658ce39d 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -54,6 +54,46 @@
 #define BTRFS_SUPER_MAGIC 0x9123683E
 #endif
 
+/* Hardening: check path, abort if corrupted path detected */
+void local_path_sanity_check(const V9fsPath *path)
+{
+    const char *data = path->data;
+    const size_t size = path->size;
+    size_t len;
+
+    if (!data) {
+        error_report("9pfs: FATAL: corrupted state detected: fid path "
+                     "has size %zu but no data", size);
+        abort();
+    }
+    /*
+     * 4 MiB is hard-coded and deliberately not PATH_MAX (usually
+     * 4k). The latter is the max. path size for a Linux syscall,
+     * which we legally surpass as we always walk and openat() paths
+     * element-wise.
+     */
+    if (size > 4 * 1024 * 1024) {
+        error_report("9pfs: FATAL: corrupted state detected: implausibly "
+                     "large fid path size %zu", size);
+        abort();
+    }
+    len = strnlen(data, size);
+    if (len != size - 1) {
+        /* Do not print the path, it is corrupted. */
+        if (len == size) {
+            error_report("9pfs: FATAL: corrupted state detected: fid "
+                         "path size %zu: no terminating NUL within the "
+                         "claimed window, string is at least %zu long",
+                         size, len);
+        } else {
+            error_report("9pfs: FATAL: corrupted state detected: fid "
+                         "path size %zu diverges from its actual "
+                         "string length %zu", size, len);
+        }
+        abort();
+    }
+}
+
 int local_open_nofollow(FsContext *fs_ctx, const char *_path, int flags,
                         mode_t mode)
 {
@@ -246,6 +286,7 @@ static void local_mapped_file_attr(int dirfd, const char *name,
 
 static int local_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
 {
+    local_path_sanity_check(fs_path);
     int err = -1;
     char *dirpath = g_path_get_dirname(fs_path->data);
     char *name = g_path_get_basename(fs_path->data);
@@ -571,6 +612,7 @@ static int local_closedir(FsContext *ctx, V9fsFidOpenState *fs)
 static int local_open(FsContext *ctx, V9fsPath *fs_path,
                       int flags, V9fsFidOpenState *fs)
 {
+    local_path_sanity_check(fs_path);
     int fd;
 
     fd = local_open_nofollow(ctx, fs_path->data, flags, 0);
@@ -584,6 +626,7 @@ static int local_open(FsContext *ctx, V9fsPath *fs_path,
 static int local_opendir(FsContext *ctx,
                          V9fsPath *fs_path, V9fsFidOpenState *fs)
 {
+    local_path_sanity_check(fs_path);
     int dirfd;
     DIR *stream;
 
@@ -886,6 +929,7 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
 static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
                        int flags, FsCred *credp, V9fsFidOpenState *fs)
 {
+    local_path_sanity_check(dir_path);
     int fd = -1;
     int err = -1;
     int dirfd;
diff --git a/hw/9pfs/9p-local.h b/hw/9pfs/9p-local.h
index b61f894195..b523017099 100644
--- a/hw/9pfs/9p-local.h
+++ b/hw/9pfs/9p-local.h
@@ -17,6 +17,7 @@ typedef struct {
     int mountfd;
 } LocalData;
 
+void local_path_sanity_check(const V9fsPath *path);
 int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
                         mode_t mode);
 int local_opendir_nofollow(FsContext *fs_ctx, const char *path);
-- 
2.47.3


