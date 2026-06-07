Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DF0CD8C92
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmg-0000VH-UX; Sun, 07 Jun 2026 13:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a884579a315b6e9c1bbbddf44ea200dded0af0ca@kylie.crudebyte.com>)
 id 1wWHmd-0000Re-Al; Sun, 07 Jun 2026 13:59:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a884579a315b6e9c1bbbddf44ea200dded0af0ca@kylie.crudebyte.com>)
 id 1wWHmb-0004O9-MO; Sun, 07 Jun 2026 13:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Aa5phmjF26iLIol4VbMlxdYrehVT63j6N+RZvPFfJUM=; b=vACs1
 XZxYcjomsYDeAoa26ZRyRJgVWmOTUGnFoc+nnqWXIu3NdUA5UZGD5p2DjUhRmpVEdQMMqDbr6M41C
 /RdmE3FHtDvffxbAa3BG7a+KGfYXQyaI34V8B7NAtfyMo1zTNA4G0oM6uSkepAGnnioNA57vSz/4/
 lx/qJVuvg+0CpwBm3j8wmzHu19AB0XjYek+3h643QrUenaIHWd6AhMzCeRm6Lh06/Z8Jajl06kJKr
 VQKS4BWWZ33T+/0XibUPhaXXcu7fPcX8nE7WVP9x8EIYZ6O5Tc1C7WwpE2SHGC6mC/Er3zjdV/YgC
 WFE0zv4Fys8111qb71/hEUHUxQ8uJrGTOpkRBwoajQTBeVoDyAykoDiPifMTe8gPe8lfNoeBxrm2f
 LifwUyLDjs9EuXMYup3z0ojUynSgBShUlQFpxzhc908XXE/i927Bix7nBpggo7I/W7u8NOedh2hY5
 7rRdJ7galSGSQrw5+MmoU09MVGRUvWXxJXs251kYNOmIWc5UcEBY29g8UC+MbObnvpyz7ZBk6Ymjl
 HX1ERq9R8qNlNt3UDiRztJouFtHNFKm+P76LrRAgGco2CsF2OmQYM1GNToyamlZUEK+fcE+VKJSRL
 wuHNbFM2hXwzwt8lsQbIwCX0PeYdx9UQTY9zk4vuUASVNtlrbAfhaNG6+nrnbw=;
Message-ID: <a884579a315b6e9c1bbbddf44ea200dded0af0ca.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 02/12] hw/9pfs: add max_xattr option
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=a884579a315b6e9c1bbbddf44ea200dded0af0ca@kylie.crudebyte.com;
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

Previous patch introduced a limit of max. 1024 simultanious xattr FIDs.

This patch introduces an option "max_attr" that allows to override this
limit, just for the case that some user might run into this limit for
some reason, even if unlikely; or for reducing the limit further down
(e.g. that default limit of 1024 would cap at max. 64 MiB host memory,
at least on Linux hosts where the limit per xattr is 64k).

This new "max_xattr" option can be specified with both -fsdev and
-virtfs command line options, with the "local" and the "synth" fs
drivers.

The previous limit of 1024 is preserved as default value.

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
index d67c4687b3..e8a0728c78 100644
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
index 10e2e53c01..46db172a0b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4464,8 +4464,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
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


