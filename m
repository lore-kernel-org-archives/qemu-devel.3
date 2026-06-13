Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DBACD98D8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJb-00083G-FL; Sat, 13 Jun 2026 11:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b7631ac0d8dde0629bc7c4f2c4185d9f57b962b4@kylie.crudebyte.com>)
 id 1wYQJa-00082x-0y; Sat, 13 Jun 2026 11:30:30 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b7631ac0d8dde0629bc7c4f2c4185d9f57b962b4@kylie.crudebyte.com>)
 id 1wYQJY-0005P0-9d; Sat, 13 Jun 2026 11:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=EI+AkBjx1TiTmWuRC4iIGqhkKvsK0mc9umkW2C8ve8c=; b=vIFhs
 Zh+rkBbU3GsSyKcIttQhpnA0OSD5RpHRkiy/kK30I/XukcVixyYO72nyAe7qODL+86QbiLN3l51fm
 x48F6PFRhnc7iugEvO0+WN+QMpuKWSkrWOazuMB8qpvxUTA9exIy8VPvqGR+Yj10EXQK6TAc6UEGq
 tGKAhBGznYlarC65a27AYJzo7CJaErnr3il2I0qqBWAN1b4GFRfrIBoOa4CPL0XWNW/DFrSRBFM7o
 w2f9HKAybNG0gY+LBY9dZWChY8gkbLZkXvPIk4x6aKmcGTPlsHeN5Acw4vXzgzOXgAH1RadopGrw4
 +dTS4Ct+WpnBl3AwfA69LXOjh+rgsHYjAgIW5uxyNxNzjLivq4zf6KXt4MUh2vggxRH02q4cwDhkL
 NrN9E2sJiuB5/EKPuGU1EumBUTXzLdJu9OtKXYMe8ugiNPfQx6A9AMkmI47GejS4ObVQ4rQJO5a7h
 gckcnowl3RvcIShltDI6ufheUJiAWeo3+gKQdSZDjMUpJwINm3Kolvk17fTijVVQy6o8Sv6TBVTT1
 6yBGhZJQptX4rX4RJJyuJwb67eZiTle1jxFgnfhlIhYz93FrP2mhQ2WxjRSWvZc9yvdqEAPk73948
 01vh5lvnTMRtMwHUzhTGYijhArUERRJlfVwXBD8SpZBIXZob57mqHTxrSRvrBw=;
Message-ID: <b7631ac0d8dde0629bc7c4f2c4185d9f57b962b4.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 02/12] hw/9pfs: add max_xattr option
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=b7631ac0d8dde0629bc7c4f2c4185d9f57b962b4@kylie.crudebyte.com;
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

Previous patch introduced a limit of max. 1024 simultaneous xattr FIDs.

This patch introduces an option "max_attr" that allows to override this
limit, just for the case that some user might run into this limit for
some reason, even if unlikely; or for reducing the limit further down
(e.g. that default limit of 1024 would cap at max. 64 MiB host memory,
at least on Linux hosts where the limit per xattr is 64k).

This new "max_xattr" option can be specified with both -fsdev and
-virtfs command line options, with the "local" and the "synth" fs
drivers.

The previous limit of 1024 is preserved as the default value.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h      |  2 ++
 fsdev/qemu-fsdev-opts.c |  6 ++++++
 fsdev/qemu-fsdev.c      |  2 +-
 hw/9pfs/9p-local.c      |  9 +++++++++
 hw/9pfs/9p-synth.c      | 17 +++++++++++++++++
 hw/9pfs/9p.c            |  4 ++--
 system/vl.c             |  7 ++++++-
 7 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 454761d81d..1d931144f4 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -101,6 +101,8 @@ typedef struct FsDriverEntry {
     FsThrottle fst;
     mode_t fmode;
     mode_t dmode;
+    /* temporary storage for parse_opts only */
+    uint32_t max_xattr;
 } FsDriverEntry;
 
 struct FsContext {
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 07a18c6e48..c2c1e83611 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -46,6 +46,9 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "max_xattr",
+            .type = QEMU_OPT_NUMBER,
         },
 
         THROTTLE_OPTS,
@@ -92,6 +95,9 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "dmode",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "max_xattr",
+            .type = QEMU_OPT_NUMBER,
         },
 
         { /*End of list */ }
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 57877dad0a..f97103cf44 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -45,7 +45,7 @@ typedef struct FsDriverListEntry {
 static QTAILQ_HEAD(, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
 
-#define COMMON_FS_DRIVER_OPTIONS "id", "fsdriver", "readonly"
+#define COMMON_FS_DRIVER_OPTIONS "id", "fsdriver", "readonly", "max_xattr"
 
 static FsDriverTable FsDrivers[] = {
     {
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index aa48306b0e..4708e170a4 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1527,6 +1527,15 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
     const char *path = qemu_opt_get(opts, "path");
     const char *multidevs = qemu_opt_get(opts, "multidevs");
 
+    uint64_t val = qemu_opt_get_number(opts, "max_xattr",
+                                       V9FS_MAX_XATTR_DEFAULT);
+    if (val > UINT32_MAX) {
+        error_setg(errp, "max_xattr value '%s' too large",
+                   qemu_opt_get(opts, "max_xattr"));
+        return -1;
+    }
+    fse->max_xattr = val;
+
     if (!sec_model) {
         error_setg(errp, "security_model property not set");
         error_append_security_model_hint(errp);
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index b3743f6169..322dc3bb69 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -25,6 +25,8 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/cutils.h"
 #include "system/qtest.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
 
 /* Root node for synth file system */
 static V9fsSynthNode synth_root = {
@@ -629,12 +631,27 @@ static int synth_init(FsContext *ctx, Error **errp)
     return 0;
 }
 
+static int synth_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
+{
+    uint64_t val = qemu_opt_get_number(opts, "max_xattr",
+                                       V9FS_MAX_XATTR_DEFAULT);
+    if (val > UINT32_MAX) {
+        error_setg(errp, "max_xattr value '%s' too large",
+                   qemu_opt_get(opts, "max_xattr"));
+        return -1;
+    }
+    fse->max_xattr = val;
+
+    return 0;
+}
+
 static bool synth_has_valid_file_handle(int fid_type, V9fsFidOpenState *fs)
 {
     return false;
 }
 
 FileOperations synth_ops = {
+    .parse_opts   = synth_parse_opts,
     .init         = synth_init,
     .lstat        = synth_lstat,
     .readlink     = synth_readlink,
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 053f0cc64b..fb8c7439f7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4466,8 +4466,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->reclaiming = false;
 
-    /* init xattr FID limit */
-    s->ctx.xattr_fid_limit = V9FS_MAX_XATTR_DEFAULT;
+    /* init xattr FID limit from fsdev config */
+    s->ctx.xattr_fid_limit = fse->max_xattr;
     s->ctx.xattr_fid_count = 0;
 
     rc = 0;
diff --git a/system/vl.c b/system/vl.c
index dbdd4f2257..eb86d725bd 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3259,7 +3259,7 @@ void qemu_init(int argc, char **argv)
                 QemuOpts *fsdev;
                 QemuOpts *device;
                 const char *writeout, *sock_fd, *socket, *path, *security_model,
-                           *multidevs;
+                           *multidevs, *max_xattr_str;
 
                 olist = qemu_find_opts("virtfs");
                 if (!olist) {
@@ -3323,6 +3323,11 @@ void qemu_init(int argc, char **argv)
                 if (multidevs) {
                     qemu_opt_set(fsdev, "multidevs", multidevs, &error_abort);
                 }
+                max_xattr_str = qemu_opt_get(opts, "max_xattr");
+                if (max_xattr_str) {
+                    qemu_opt_set(fsdev, "max_xattr", max_xattr_str,
+                                 &error_abort);
+                }
                 device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
                                           &error_abort);
                 qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
-- 
2.47.3


