Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A23606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=ckVy+qUQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWGV-0000Wy-DC; Mon, 23 Nov 2026 10:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8af000b5aee54ed5672f151f7080810b7b40f59b@kylie.crudebyte.com>)
 id 1xVWGT-0000Wj-Lc
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:33 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8af000b5aee54ed5672f151f7080810b7b40f59b@kylie.crudebyte.com>)
 id 1xVWGR-0004Bh-JS
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=u7A1h4Lm5G03bZw4ERu1x8Pa8jZcUX6HpIBGEVrkZOA=; b=ckVy+
 qUQN0DH56VYDYypJh8eCYmndFi/FWHQWxyFbml9pozCZ+enbXBKvPmzNQQOzMdmtQrhBwDVYceQzY
 GxuZ6LgLBTgRGfW2GxWRS2EwvZfyGlbbVWpOYhC12KQUzcJryTxIe+zksxNgX+bqj3XT0O/BwWrMe
 72AMKTtKW3mitYHjePEPLXuniBGzxBRBuZqWiKDevJEcOPnyYgCfI8Z6THCQ8kdsO/NGq/xDMd9mb
 gPAiV94fK/KkrojLc/3QJZfT2Kl8SpALz1IbLTAQwNWttkg32KC0EgPJJSDNKTWUQVEh7zn0CNHC2
 w31IbOoAH4T1Y+RmQdNd3QKgNFiJMCvxxkvvqXHIdiTyTAKZMUdnO2rM98oxJran19bcWe3bcILya
 UCkB36y4AReYfp+BcMGxi5Du4vF8b4yaZnsLiNVjOqrZY3KHfzQQHBLyrc6LdxOUpFrxFJn9vaYRq
 DyOIGlYtdxWiMAIxweQy09l2b5WcOGl/BySSBS/vl1AtG1OImZCNTXs6JMkTvpq1nCSYpZgfSvyGy
 K9gE9WbPaRAiAvLeZGuxtAsVTvduk4xH872TgyR16jcKbgNt4cx3i+rohTRtADGTtwuDlXPtQaPT+
 gaCRhGq0mK9IARbOhMleV7GpeVzMGr3DtAUmZwujHgWREn+zvfF+Co2uYGpl6U=;
Message-ID: <8af000b5aee54ed5672f151f7080810b7b40f59b.1795447869.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1795447869.git.qemu_oss@crudebyte.com>
References: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:24:51 +0100
Subject: [PATCH 1/7] hw/9pfs: local_open_nofollow(): abort on illegal FID path
 components
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=8af000b5aee54ed5672f151f7080810b7b40f59b@kylie.crudebyte.com;
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

Harden local_open_nofollow() against potentially corrupted,
malicious paths.

CVE-2026-93834 (fixed by fe9e30899ff) allowed guests to escape from
9p server's export root. Due to that severe impact, it is therefore
worth hardening the 9p server at relevant, affected code locations.

The target victim of that CVE was local_open_nofollow(), which is
9p server's central place for opening files and directories. This
function opens the passed FID path by walking and opening one path
element at a time, starting from the 9p export root directory. And
the key mechanism exploited by the CVE was to smuggle ".." elements
into the path, which eventually caused local_open_nofollow() to
open files outside of the allowed 9p exported root directory.

That could be exploited by the CVE this way, because so far
local_open_nofollow() relied on local_name_to_path() having
translated a client-side path into a safe host-side path
representation (which especially includes having stripped all ".."
path elements already), before that path was ever passed to
local_open_nofollow().

And that assumption of local_open_nofollow() was actually valid,
because the code structure guaranteed that local_name_to_path()
was always called before the (translated / defused) path would
eventually reach local_open_nofollow().

However the CVE used a side effect, by exploiting a concurrency
issue, which allowed it to mutate the path after the path has
already been translated by local_name_to_path(), eventually
causing local_open_nofollow() to blindly follow a crafted,
malicious path.

Since local_open_nofollow() is such a fragile place, and since
concurrency issues can be complex for being completely ruled out
(especially with C), we no longer blindly rely on a path that
has been passed to local_open_nofollow() to be always sane, so:

 - Copy the passed path as very first action, so nobody else
   could mutate it while we are checking and processing it.

Then from there, by using the path copy only:

 - Check the path for any ".." element.

 - Check the path for not being an absolute path.

 - Check the path to not contain any empty path element.

If the path fails any of these checks, abort the QEMU process
deliberately loudly instead of trying to return a regular error
to client. Because if we detected a bad path at this point of
the code, it means somebody already managed to corrupt the overall
server state. So better to die immediately and loudly with a clear
admin message, than giving an attacker the chance to make the
situation even worse.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 71 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ee592b62f8..710652dbca 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -58,24 +58,89 @@ typedef struct {
     int mountfd;
 } LocalData;
 
-int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
+int local_open_nofollow(FsContext *fs_ctx, const char *_path, int flags,
                         mode_t mode)
 {
     LocalData *data = fs_ctx->private;
     int fd = data->mountfd;
 
+    /*
+     * Hardening: snapshot the FID path to prevent any mutations (by
+     * another thread) during the checks and individual directory
+     * walks below (i.e. preventing TOCTOU issues). This is usually
+     * not expected to happen, as we are holding a read lock on the
+     * path, but the impact of CVE-2026-93834 deserves more robust
+     * handling.
+     */
+    g_autofree char *snap = g_strdup(_path);
+    const char *path = snap;
+
+    if (!*path) {
+        /*
+         * Hardening: check for empty string.
+         *
+         * An empty string means the FID path is corrupted (the
+         * export's root FID path is a single "."), so stop with a
+         * loud failure instead of serving a corrupted state.
+         */
+        error_report("9pfs: FATAL: corrupted state detected: empty FID "
+                     "path");
+        abort();
+    }
+
     while (*path && fd != -1) {
         const char *c;
         int next_fd;
         char *head;
 
-        /* Only relative paths without consecutive slashes */
-        assert(*path != '/');
+        /*
+         * Hardening: check for leading slash.
+         *
+         * An absolute path or an empty path element at this point
+         * means the path is corrupted (the client supplied path was
+         * already translated by local_name_to_path() to a safe host
+         * path before).
+         */
+        if (*path == '/') {
+            /* Do not print this path: it is corrupted. */
+            error_report("9pfs: FATAL: corrupted state detected: FID "
+                         "path contains a leading or empty path "
+                         "component");
+            abort();
+        }
 
         head = g_strdup(path);
         c = qemu_strchrnul(path, '/');
+        /*
+         * Hardening: check for "..".
+         *
+         * Relative ".." path elements were already translated by
+         * local_name_to_path() before, so a ".." element at this
+         * point means a corrupted path.
+         */
+        if (c - path == 2 && head[0] == '.' && head[1] == '.') {
+            /* Do not print this path: it is corrupted. */
+            error_report("9pfs: FATAL: corrupted state detected: FID "
+                         "path contains a '..' component");
+            abort();
+        }
         if (*c) {
             /* Intermediate path element */
+
+            /*
+             * Hardening: check for trailing slash.
+             *
+             * Prevents calling openat() with an empty string (""). It
+             * would not actually be fatal, but this can only happen
+             * with a corrupted path. So abort, just to be sure.
+             */
+            if (c[1] == '\0') {
+                /* Do not print this path: it is corrupted. */
+                error_report("9pfs: FATAL: corrupted state detected: "
+                             "FID path ends with a '/' (empty final "
+                             "component)");
+                abort();
+            }
             head[c - path] = 0;
             path = c + 1;
             next_fd = openat_dir(fd, head);
-- 
2.47.3


