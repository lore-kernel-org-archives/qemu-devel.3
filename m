Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EF5E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfj-0004JM-9T; Wed, 18 Feb 2026 08:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfg-0004Go-9n
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfT-0005hQ-81
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQRl9meOJuWdYVedpi7sUqHpEjV3sJFFswUPTEReFew=;
 b=ZKr8KnFjeE/ugpLzd3uTBToKUGKja3ovLKlMZVpt+OiZNdVfbRezbyk6rYYXgiIN+P8M/V
 Zyj7B8bK+klnoSU8vHSNzj1IP4Ng57WqC5hKMe7MWfQkB3wLTh3WhYr1oxA9sdlnSP+Rvt
 ecT/OA67c4Oza6WOAb32ySyrGe9PjF8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-In_BYx9ZMlO7iX1shLFmQA-1; Wed, 18 Feb 2026 08:27:26 -0500
X-MC-Unique: In_BYx9ZMlO7iX1shLFmQA-1
X-Mimecast-MFC-AGG-ID: In_BYx9ZMlO7iX1shLFmQA_1771421245
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4803e8b6007so45186055e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421245; x=1772026045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQRl9meOJuWdYVedpi7sUqHpEjV3sJFFswUPTEReFew=;
 b=Xar+vHFLUeHZu95nkhdCE/N70TptnrhVRNJ0fOAejPGJ4tp7FJ+jIBBExdqGjEabOl
 eSGDhnyQtq52gkAXAnvM1EXRj1XuiBPAFvKBuyzfYjlPvW4tboS0eQbZOg2aevlktafC
 TtKPP9qPtjgL9uaqYDcmTtAE7iP1SsEu3DfWdZ3ExhycBM4q1+1WrgbS9RBdTnKI+EwK
 WjhsTJcPGOexQ80YrU5NY9QPqGefIyfUPeqO+05217ugUhbfyaCuBgzNF42JdvyDRmZp
 yIOU2DhpD/FN0mlrdtYuwoMuCX8yfe0lEFGa+LrxL7a6Y2tVHmlxXGL2CNLDjm2zcqQE
 6b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421245; x=1772026045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQRl9meOJuWdYVedpi7sUqHpEjV3sJFFswUPTEReFew=;
 b=JETF7HCFCGVD2YjJeNsuKzwvOvK8pNmFXFT9+loau+7HobjiDe68tRIX4G2OAP+OcU
 Fh0HBQYRPNOwbF6HgJJtJbHgyGu5NjZ+PPQqcyhKIYB+r6QgXy4159hi1dkfMYpmMjCn
 BFQ3WWnx7xvP1MAONjOW3uMgkhVOxRH0lY62EvQwqu2/IcpnpMXODezCVHT0zZlBqQ5j
 lzQmasZ3UXGanFJ94KTeZ9i8VGUXuCvhCPvp3kp/j+FM7ayX9HIZ4GKma493Dc4x28RM
 RqL/JKg9rts24EBPYo1Gvof2HQYLkt5pKr9/Jfd2y5soMykvitZHRIR5EjY9pozI9/Ti
 hdNA==
X-Gm-Message-State: AOJu0YzoFzZC/vnAmziYyF5N8tWW4RcGpi/XaQixI9v2G+m8IxRiwia2
 JVtdv2sBeeTQ6HEahkz57V3d9QWnHSxV9d5GyUBYlxKXf3ZiVyXRvE9TQBSWMzwNfI2s7nxBpzG
 DbnddAn2sTT5RScpDLXOazdWGWuXPRlxt2xDJ3ixUZg2KR5HJA2Pb6zEv
X-Gm-Gg: AZuq6aLgfDOJPOwyUPQq4IuiYlWC4eqSp5nhmeo/KsJaja0N0HZPW0SW2IvXE82fUS9
 /p4lEkK1diW3uf2PilZCC8+eXEA229LqltMEt1NuUQfr3DocRviCw5SUoUUXWgKRnv22R9th7BB
 tSyDbj/YcEnlrBKaTnPOGfYRcOXrsR8dxE3eqh5cIci7zlLGJ75GJgdENsc0vnIBSXFFRgZK1gv
 RtpxkQZcOFfiv/MHGKS9uBBTLO8+vyh3gSXMdB+nG1nWUhzaVa4usoKZiiKet93Wln1aU+yOUDg
 zcJt/R0D0SDembAYK5PXPhOmQ0LsbL9+eixdDYHeLsCmN06PtKS8/vVdBh+orbUSj73K4wVOa5t
 j09GF86kT0V3QdMrpGIQAaTbcK5PyOw9WRlHogang2GN1mJgX0Z7J0IZuCvQRgSS8nEv3Y5FffC
 6Z1+Eb
X-Received: by 2002:a05:600c:3f14:b0:483:78e1:784 with SMTP id
 5b1f17b1804b1-48398a433abmr33612855e9.4.1771421244565; 
 Wed, 18 Feb 2026 05:27:24 -0800 (PST)
X-Received: by 2002:a05:600c:3f14:b0:483:78e1:784 with SMTP id
 5b1f17b1804b1-48398a433abmr33612205e9.4.1771421243781; 
 Wed, 18 Feb 2026 05:27:23 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839840f0a1sm17986285e9.32.2026.02.18.05.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:22 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 16/24] fuse: Manually process requests (without libfuse)
Date: Wed, 18 Feb 2026 14:26:25 +0100
Message-ID: <20260218132633.29748-17-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Manually read requests from the /dev/fuse FD and process them, without
using libfuse.  This allows us to safely add parallel request processing
in coroutines later, without having to worry about libfuse internals.
(Technically, we already have exactly that problem with
read_from_fuse_export()/read_from_fuse_fd() nesting.)

We will continue to use libfuse for mounting the filesystem; fusermount3
is a effectively a helper program of libfuse, so it should know best how
to interact with it.  (Doing it manually without libfuse, while doable,
is a bit of a pain, and it is not clear to me how stable the "protocol"
actually is.)

Take this opportunity of quite a major rewrite to update the Copyright
line with corrected information that has surfaced in the meantime.

Here are some benchmarks from before this patch (4k, iodepth=16, libaio;
except 'sync', which are iodepth=1 and pvsync2):

file:
  read:
    seq aio:    99.8k ±1.5k IOPS
    rand aio:   50.5k ±1.0k
    seq sync:   36.1k ±1.1k
    rand sync:  10.0k ±0.1k
  write:
    seq aio:    72.0k ±9.3k
    rand aio:   70.6k ±2.5k
    seq sync:   30.6k ±0.8k
    rand sync:  30.1k ±1.0k
null:
  read:
    seq aio:   157.9k ±4.7k
    rand aio:  158.7k ±4.8k
    seq sync:   80.2k ±2.8k
    rand sync:  77.5k ±3.8k
  write:
    seq aio:   154.3k ±3.6k
    rand aio:  154.3k ±4.2k
    seq sync:   76.1k ±5.2k
    rand sync:  72.9k ±4.0k

And with this patch applied:

file:
  read:
    seq aio:   106.8k ±1.9k (+7%)
    rand aio:   48.3k ±8.8k (-4%)
    seq sync:   35.5k ±1.4k (-2%)
    rand sync:  10.0k ±0.2k (±0%)
  write:
    seq aio:    76.3k ±6.6k (+6%)
    rand aio:   76.4k ±1.5k (+8%)
    seq sync:   31.6k ±0.6k (+3%)
    rand sync:  30.9k ±0.8k (+3%)
null:
  read:
    seq aio:   161.7k ±6.0k (+2%)
    rand aio:  165.6k ±7.1k (+4%)
    seq sync:   80.5k ±3.0k (±0%)
    rand sync:  78.5k ±3.1k (+1%)
  write:
    seq aio:   185.1k ±3.3k (+20%)
    rand aio:  186.7k ±4.8k (+21%)
    seq sync:   82.5k ±4.2k (+8%)
    rand sync:  78.7k ±3.2k (+8%)

So not much difference, aside from write AIO to a null-co export getting
a bit better.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 944 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 720 insertions(+), 224 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index af0a8de17b..c481fb72a2 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -1,7 +1,7 @@
 /*
  * Present a block device as a raw image through FUSE
  *
- * Copyright (c) 2020 Max Reitz <mreitz@redhat.com>
+ * Copyright (c) 2020, 2025 Hanna Czenczek <hreitz@redhat.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,12 +27,15 @@
 #include "block/qapi.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
+#include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/block-backend.h"
 
 #include <fuse.h>
 #include <fuse_lowlevel.h>
 
+#include "standard-headers/linux/fuse.h"
+
 #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
 #include <linux/falloc.h>
 #endif
@@ -42,17 +45,102 @@
 #endif
 
 /* Prevent overly long bounce buffer allocations */
-#define FUSE_MAX_BOUNCE_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
+#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
+/* Small enough to fit in the request buffer */
+#define FUSE_MAX_WRITE_BYTES (64 * 1024)
 
+/*
+ * fuse_init_in structure before 7.36.  We don't need the flags2 field added
+ * there, so we can work with the smaller older structure to stay compatible
+ * with older kernels.
+ */
+struct fuse_init_in_compat {
+    uint32_t major;
+    uint32_t minor;
+    uint32_t max_readahead;
+    uint32_t flags;
+};
+
+typedef struct FuseRequestInHeader {
+    struct fuse_in_header common;
+    /* All supported requests */
+    union {
+        struct fuse_init_in_compat init;
+        struct fuse_open_in open;
+        struct fuse_setattr_in setattr;
+        struct fuse_read_in read;
+        struct fuse_write_in write;
+        struct fuse_fallocate_in fallocate;
+#ifdef CONFIG_FUSE_LSEEK
+        struct fuse_lseek_in lseek;
+#endif
+    };
+} FuseRequestInHeader;
+
+typedef struct FuseRequestOutHeader {
+    struct fuse_out_header common;
+    /* All supported requests */
+    union {
+        struct fuse_init_out init;
+        struct fuse_statfs_out statfs;
+        struct fuse_open_out open;
+        struct fuse_attr_out attr;
+        struct fuse_write_out write;
+#ifdef CONFIG_FUSE_LSEEK
+        struct fuse_lseek_out lseek;
+#endif
+    };
+} FuseRequestOutHeader;
+
+typedef union FuseRequestInHeaderBuf {
+    struct FuseRequestInHeader structured;
+    struct {
+        /*
+         * Part of the request header that is filled for write requests
+         * (Needed because we want the data to go into a different buffer, to
+         * avoid having to use a bounce buffer)
+         */
+        char head[sizeof(struct fuse_in_header) +
+                  sizeof(struct fuse_write_in)];
+        /*
+         * Rest of the request header for requests that have a longer header
+         * than write requests
+         */
+        char tail[sizeof(FuseRequestInHeader) -
+                  (sizeof(struct fuse_in_header) +
+                   sizeof(struct fuse_write_in))];
+    };
+} FuseRequestInHeaderBuf;
+
+QEMU_BUILD_BUG_ON(sizeof(FuseRequestInHeaderBuf) !=
+                  sizeof(FuseRequestInHeader));
+QEMU_BUILD_BUG_ON(sizeof(((FuseRequestInHeaderBuf *)0)->head) +
+                  sizeof(((FuseRequestInHeaderBuf *)0)->tail) !=
+                  sizeof(FuseRequestInHeader));
 
 typedef struct FuseExport {
     BlockExport common;
 
     struct fuse_session *fuse_session;
-    struct fuse_buf fuse_buf;
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
+    /*
+     * Cached buffer to receive the data of WRITE requests.  Cached because:
+     * To read requests, we put a FuseRequestInHeaderBuf (FRIHB) object on the
+     * stack, and a (WRITE data) buffer on the heap.  We pass FRIHB.head and the
+     * data buffer to readv().  This way, for WRITE requests, we get exactly
+     * their data in the data buffer and can avoid bounce buffering.
+     * However, for non-WRITE requests, some of the header may end up in the
+     * data buffer, so we will need to copy that back into the FRIHB object, and
+     * then we don't need the heap buffer anymore.  That is why we cache it, so
+     * we can trivially reuse it between non-WRITE requests.
+     *
+     * Note that these data buffers and thus req_write_data_cached are allocated
+     * via blk_blockalign() and thus need to be freed via qemu_vfree().
+     */
+    void *req_write_data_cached;
+
     /*
      * Set when there was an unrecoverable error and no requests should be read
      * from the device anymore (basically only in case of something we would
@@ -60,6 +148,8 @@ typedef struct FuseExport {
      */
     bool halted;
 
+    int fuse_fd;
+
     char *mountpoint;
     bool writable;
     bool growable;
@@ -71,20 +161,31 @@ typedef struct FuseExport {
     gid_t st_gid;
 } FuseExport;
 
+/*
+ * Verify that the size of FuseRequestInHeaderBuf.head plus the data
+ * buffer are big enough to be accepted by the FUSE kernel driver.
+ */
+QEMU_BUILD_BUG_ON(sizeof(((FuseRequestInHeaderBuf *)0)->head) +
+                  FUSE_MAX_WRITE_BYTES <
+                  FUSE_MIN_READ_BUFFER);
+
 static GHashTable *exports;
-static const struct fuse_lowlevel_ops fuse_ops;
 
 static void fuse_export_shutdown(BlockExport *exp);
 static void fuse_export_delete(BlockExport *exp);
-static void fuse_export_halt(FuseExport *exp) G_GNUC_UNUSED;
+static void fuse_export_halt(FuseExport *exp);
 
 static void init_exports_table(void);
 
 static int mount_fuse_export(FuseExport *exp, Error **errp);
-static void read_from_fuse_export(void *opaque);
 
 static bool is_regular_file(const char *path, Error **errp);
 
+static void read_from_fuse_fd(void *opaque);
+static void fuse_process_request(FuseExport *exp,
+                                 const FuseRequestInHeader *in_hdr,
+                                 const void *data_buffer);
+static int fuse_write_err(int fd, const struct fuse_in_header *in_hdr, int err);
 
 static void fuse_inc_in_flight(FuseExport *exp)
 {
@@ -105,22 +206,26 @@ static void fuse_dec_in_flight(FuseExport *exp)
     }
 }
 
+/**
+ * Attach FUSE FD read handler.
+ */
 static void fuse_attach_handlers(FuseExport *exp)
 {
     if (qatomic_read(&exp->halted)) {
         return;
     }
 
-    aio_set_fd_handler(exp->common.ctx,
-                       fuse_session_fd(exp->fuse_session),
-                       read_from_fuse_export, NULL, NULL, NULL, exp);
+    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
+                       read_from_fuse_fd, NULL, NULL, NULL, exp);
     exp->fd_handler_set_up = true;
 }
 
+/**
+ * Detach FUSE FD read handler.
+ */
 static void fuse_detach_handlers(FuseExport *exp)
 {
-    aio_set_fd_handler(exp->common.ctx,
-                       fuse_session_fd(exp->fuse_session),
+    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
                        NULL, NULL, NULL, NULL, NULL);
     exp->fd_handler_set_up = false;
 }
@@ -247,6 +352,13 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
 
+    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
+    ret = qemu_fcntl_addfl(exp->fuse_fd, O_NONBLOCK);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to make FUSE FD non-blocking");
+        goto fail;
+    }
+
     fuse_attach_handlers(exp);
     return 0;
 
@@ -278,6 +390,17 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     char *mount_opts;
     struct fuse_args fuse_args;
     int ret;
+    /*
+     * We just create the session for mounting/unmounting, no need to provide
+     * any operations.  However, since libfuse commit 52a633a5d, we have to
+     * provide some op struct and cannot just pass NULL (even though the commit
+     * message ("allow passing ops as NULL") seems to imply the exact opposite,
+     * as does the comment added to fuse_session_new_fn() ("To create a no-op
+     * session just for mounting pass op as NULL.").
+     * This is how said libfuse commit implements a no-op session internally, so
+     * do it the same way.
+     */
+    static const struct fuse_lowlevel_ops null_ops = { 0 };
 
     /*
      * Note that these mount options differ from what we would pass to a direct
@@ -292,7 +415,7 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     mount_opts = g_strdup_printf("%s,nosuid,nodev,noatime,max_read=%zu,"
                                  "default_permissions%s",
                                  exp->writable ? "rw" : "ro",
-                                 FUSE_MAX_BOUNCE_BYTES,
+                                 FUSE_MAX_READ_BYTES,
                                  exp->allow_other ? ",allow_other" : "");
 
     fuse_argv[0] = ""; /* Dummy program name */
@@ -301,8 +424,8 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     fuse_argv[3] = NULL;
     fuse_args = (struct fuse_args)FUSE_ARGS_INIT(3, (char **)fuse_argv);
 
-    exp->fuse_session = fuse_session_new(&fuse_args, &fuse_ops,
-                                         sizeof(fuse_ops), exp);
+    exp->fuse_session = fuse_session_new(&fuse_args, &null_ops,
+                                         sizeof(null_ops), NULL);
     g_free(mount_opts);
     if (!exp->fuse_session) {
         error_setg(errp, "Failed to set up FUSE session");
@@ -326,36 +449,163 @@ fail:
 }
 
 /**
- * Callback to be invoked when the FUSE session FD can be read from.
- * (This is basically the FUSE event loop.)
+ * Allocate a buffer to receive WRITE data, or take the cached one.
  */
-static void read_from_fuse_export(void *opaque)
+static void *get_write_data_buffer(FuseExport *exp)
 {
-    FuseExport *exp = opaque;
-    int ret;
+    if (exp->req_write_data_cached) {
+        void *cached = exp->req_write_data_cached;
+        exp->req_write_data_cached = NULL;
+        return cached;
+    } else {
+        return blk_blockalign(exp->common.blk, FUSE_MAX_WRITE_BYTES);
+    }
+}
 
-    if (unlikely(qatomic_read(&exp->halted))) {
+/**
+ * Release a WRITE data buffer, possibly reusing it for a subsequent request.
+ */
+static void release_write_data_buffer(FuseExport *exp, void **buffer)
+{
+    if (!*buffer) {
         return;
     }
 
+    if (!exp->req_write_data_cached) {
+        exp->req_write_data_cached = *buffer;
+    } else {
+        qemu_vfree(*buffer);
+    }
+    *buffer = NULL;
+}
+
+/**
+ * Return the length of the specific operation's own in_header.
+ * Return -ENOSYS if the operation is not supported.
+ */
+static ssize_t req_op_hdr_len(const FuseRequestInHeader *in_hdr)
+{
+    switch (in_hdr->common.opcode) {
+    case FUSE_INIT:
+        return sizeof(in_hdr->init);
+    case FUSE_OPEN:
+        return sizeof(in_hdr->open);
+    case FUSE_SETATTR:
+        return sizeof(in_hdr->setattr);
+    case FUSE_READ:
+        return sizeof(in_hdr->read);
+    case FUSE_WRITE:
+        return sizeof(in_hdr->write);
+    case FUSE_FALLOCATE:
+        return sizeof(in_hdr->fallocate);
+#ifdef CONFIG_FUSE_LSEEK
+    case FUSE_LSEEK:
+        return sizeof(in_hdr->lseek);
+#endif
+    case FUSE_DESTROY:
+    case FUSE_STATFS:
+    case FUSE_RELEASE:
+    case FUSE_LOOKUP:
+    case FUSE_FORGET:
+    case FUSE_BATCH_FORGET:
+    case FUSE_GETATTR:
+    case FUSE_FSYNC:
+    case FUSE_FLUSH:
+        /* These requests don't have their own header or we don't care */
+        return 0;
+    default:
+        return -ENOSYS;
+    }
+}
+
+/**
+ * Try to read and process a single request from the FUSE FD.
+ */
+static void read_from_fuse_fd(void *opaque)
+{
+    FuseExport *exp = opaque;
+    int fuse_fd = exp->fuse_fd;
+    ssize_t ret;
+    FuseRequestInHeaderBuf in_hdr_buf;
+    const FuseRequestInHeader *in_hdr;
+    void *data_buffer = NULL;
+    struct iovec iov[2];
+    ssize_t op_hdr_len;
+
     fuse_inc_in_flight(exp);
 
-    do {
-        ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
-    } while (ret == -EINTR);
-    if (ret < 0) {
-        goto out;
+    if (unlikely(qatomic_read(&exp->halted))) {
+        goto no_request;
+    }
+
+    data_buffer = get_write_data_buffer(exp);
+
+    /* Construct the I/O vector to hold the FUSE request */
+    iov[0] = (struct iovec) { &in_hdr_buf.head, sizeof(in_hdr_buf.head) };
+    iov[1] = (struct iovec) { data_buffer, FUSE_MAX_WRITE_BYTES };
+    ret = RETRY_ON_EINTR(readv(fuse_fd, iov, ARRAY_SIZE(iov)));
+    if (ret < 0 && errno == EAGAIN) {
+        /* No request available */
+        goto no_request;
+    } else if (unlikely(ret < 0)) {
+        error_report("Failed to read from FUSE device: %s", strerror(errno));
+        goto no_request;
+    }
+
+    if (unlikely(ret < sizeof(in_hdr->common))) {
+        error_report("Incomplete read from FUSE device, expected at least %zu "
+                     "bytes, read %zi bytes; cannot trust subsequent "
+                     "requests, halting the export",
+                     sizeof(in_hdr->common), ret);
+        fuse_export_halt(exp);
+        goto no_request;
+    }
+    in_hdr = &in_hdr_buf.structured;
+
+    if (unlikely(ret != in_hdr->common.len)) {
+        error_report("Number of bytes read from FUSE device does not match "
+                     "request size, expected %" PRIu32 " bytes, read %zi "
+                     "bytes; cannot trust subsequent requests, halting the "
+                     "export",
+                     in_hdr->common.len, ret);
+        fuse_export_halt(exp);
+        goto no_request;
+    }
+
+    op_hdr_len = req_op_hdr_len(in_hdr);
+    if (op_hdr_len < 0) {
+        fuse_write_err(fuse_fd, &in_hdr->common, op_hdr_len);
+        goto no_request;
+    }
+
+    if (unlikely(ret < sizeof(in_hdr->common) + op_hdr_len)) {
+        error_report("FUSE request truncated, expected %zu bytes, read %zi "
+                     "bytes",
+                     sizeof(in_hdr->common) + op_hdr_len, ret);
+        fuse_write_err(fuse_fd, &in_hdr->common, -EINVAL);
+        goto no_request;
     }
 
     /*
-     * Note that aio_poll() in any request-processing function can lead to a
-     * nested read_from_fuse_export() call, which will overwrite the contents of
-     * exp->fuse_buf.  Anything that takes a buffer needs to take care that the
-     * content is copied before potentially polling via aio_poll().
+     * Only WRITE uses the write data buffer, so for non-WRITE requests longer
+     * than .head, we need to copy any data that spilled into data_buffer into
+     * .tail.  Then we can release the write data buffer.
      */
-    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
+    if (in_hdr->common.opcode != FUSE_WRITE) {
+        if (ret > sizeof(in_hdr_buf.head)) {
+            size_t len;
+            /* Limit size to prevent overflow */
+            len = MIN(ret - sizeof(in_hdr_buf.head), sizeof(in_hdr_buf.tail));
+            memcpy(in_hdr_buf.tail, data_buffer, len);
+        }
 
-out:
+        release_write_data_buffer(exp, &data_buffer);
+    }
+
+    fuse_process_request(exp, in_hdr, data_buffer);
+
+no_request:
+    release_write_data_buffer(exp, &data_buffer);
     fuse_dec_in_flight(exp);
 }
 
@@ -363,18 +613,14 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
 
-    if (exp->fuse_session) {
-        fuse_session_exit(exp->fuse_session);
-
-        if (exp->fd_handler_set_up) {
-            fuse_detach_handlers(exp);
-        }
+    if (exp->fd_handler_set_up) {
+        fuse_detach_handlers(exp);
     }
 
     if (exp->mountpoint) {
         /*
-         * Safe to drop now, because we will not handle any requests
-         * for this export anymore anyway.
+         * Safe to drop now, because we will not handle any requests for this
+         * export anymore anyway (at least not from the main thread).
          */
         g_hash_table_remove(exports, exp->mountpoint);
     }
@@ -392,7 +638,7 @@ static void fuse_export_delete(BlockExport *blk_exp)
         fuse_session_destroy(exp->fuse_session);
     }
 
-    free(exp->fuse_buf.mem);
+    qemu_vfree(exp->req_write_data_cached);
     g_free(exp->mountpoint);
 }
 
@@ -434,46 +680,101 @@ static bool is_regular_file(const char *path, Error **errp)
 }
 
 /**
- * A chance to set change some parameters supplied to FUSE_INIT.
+ * Process FUSE INIT.
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_init(void *userdata, struct fuse_conn_info *conn)
+static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
+                         const struct fuse_init_in_compat *in)
 {
+    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+
+    if (in->major != 7) {
+        error_report("FUSE major version mismatch: We have 7, but kernel has %"
+                     PRIu32, in->major);
+        return -EINVAL;
+    }
+
+    /* 2007's 7.9 added fuse_attr.blksize; working around that would be hard */
+    if (in->minor < 9) {
+        error_report("FUSE minor version too old: 9 required, but kernel has %"
+                     PRIu32, in->minor);
+        return -EINVAL;
+    }
+
+    *out = (struct fuse_init_out) {
+        .major = 7,
+        .minor = MIN(FUSE_KERNEL_MINOR_VERSION, in->minor),
+        .max_readahead = in->max_readahead,
+        .max_write = FUSE_MAX_WRITE_BYTES,
+        .flags = in->flags & supported_flags,
+        .flags2 = 0,
+
+        /* libfuse maximum: 2^16 - 1 */
+        .max_background = UINT16_MAX,
+
+        /* libfuse default: max_background * 3 / 4 */
+        .congestion_threshold = (int)UINT16_MAX * 3 / 4,
+
+        /* libfuse default: 1 */
+        .time_gran = 1,
+
+        /*
+         * probably unneeded without FUSE_MAX_PAGES, but this would be the
+         * libfuse default
+         */
+        .max_pages = DIV_ROUND_UP(FUSE_MAX_WRITE_BYTES,
+                                  qemu_real_host_page_size()),
+
+        /* Only needed for mappings (i.e. DAX) */
+        .map_alignment = 0,
+    };
+
     /*
-     * MIN_NON_ZERO() would not be wrong here, but what we set here
-     * must equal what has been passed to fuse_session_new().
-     * Therefore, as long as max_read must be passed as a mount option
-     * (which libfuse claims will be changed at some point), we have
-     * to set max_read to a fixed value here.
+     * Before 7.23, fuse_init_out is shorter.
+     * Drop the tail (time_gran, max_pages, map_alignment).
      */
-    conn->max_read = FUSE_MAX_BOUNCE_BYTES;
-
-    conn->max_write = MIN_NON_ZERO(BDRV_REQUEST_MAX_BYTES, conn->max_write);
+    return out->minor >= 23 ? sizeof(*out) : FUSE_COMPAT_22_INIT_OUT_SIZE;
 }
 
 /**
- * Let clients look up files.  Always return ENOENT because we only
- * care about the mountpoint itself.
+ * Return some filesystem information, just to not break e.g. `df`.
  */
-static void fuse_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
+static ssize_t fuse_statfs(FuseExport *exp, struct fuse_statfs_out *out)
 {
-    fuse_reply_err(req, ENOENT);
+    BlockDriverState *root_bs;
+    uint32_t opt_transfer = 512;
+
+    root_bs = blk_bs(exp->common.blk);
+    if (root_bs) {
+        opt_transfer = root_bs->bl.opt_transfer;
+        if (!opt_transfer) {
+            opt_transfer = root_bs->bl.request_alignment;
+        }
+        opt_transfer = MAX(opt_transfer, 512);
+    }
+
+    *out = (struct fuse_statfs_out) {
+        /* These are the fields libfuse sets by default */
+        .st = {
+            .namelen = 255,
+            .bsize = opt_transfer,
+        },
+    };
+    return sizeof(*out);
 }
 
 /**
  * Let clients get file attributes (i.e., stat() the file).
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
-                         struct fuse_file_info *fi)
+static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
 {
-    struct stat statbuf;
     int64_t length, allocated_blocks;
     time_t now = time(NULL);
-    FuseExport *exp = fuse_req_userdata(req);
 
     length = blk_getlength(exp->common.blk);
     if (length < 0) {
-        fuse_reply_err(req, -length);
-        return;
+        return length;
     }
 
     allocated_blocks = bdrv_get_allocated_file_size(blk_bs(exp->common.blk));
@@ -483,21 +784,24 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
         allocated_blocks = DIV_ROUND_UP(allocated_blocks, 512);
     }
 
-    statbuf = (struct stat) {
-        .st_ino     = 1,
-        .st_mode    = exp->st_mode,
-        .st_nlink   = 1,
-        .st_uid     = exp->st_uid,
-        .st_gid     = exp->st_gid,
-        .st_size    = length,
-        .st_blksize = blk_bs(exp->common.blk)->bl.request_alignment,
-        .st_blocks  = allocated_blocks,
-        .st_atime   = now,
-        .st_mtime   = now,
-        .st_ctime   = now,
+    *out = (struct fuse_attr_out) {
+        .attr_valid = 1,
+        .attr = {
+            .ino        = 1,
+            .mode       = exp->st_mode,
+            .nlink      = 1,
+            .uid        = exp->st_uid,
+            .gid        = exp->st_gid,
+            .size       = length,
+            .blksize    = blk_bs(exp->common.blk)->bl.request_alignment,
+            .blocks     = allocated_blocks,
+            .atime      = now,
+            .mtime      = now,
+            .ctime      = now,
+        },
     };
 
-    fuse_reply_attr(req, &statbuf, 1.);
+    return sizeof(*out);
 }
 
 static int fuse_do_truncate(const FuseExport *exp, int64_t size,
@@ -550,101 +854,98 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
  * permit access: Read-only exports cannot be given +w, and exports
  * without allow_other cannot be given a different UID or GID, and
  * they cannot be given non-owner access.
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
-                         int to_set, struct fuse_file_info *fi)
+static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
+                            uint32_t to_set, uint64_t size, uint32_t mode,
+                            uint32_t uid, uint32_t gid)
 {
-    FuseExport *exp = fuse_req_userdata(req);
     int supported_attrs;
     int ret;
 
-    supported_attrs = FUSE_SET_ATTR_SIZE | FUSE_SET_ATTR_MODE;
+    /* SIZE and MODE are actually supported, the others can be safely ignored */
+    supported_attrs = FATTR_SIZE | FATTR_MODE |
+        FATTR_FH | FATTR_LOCKOWNER | FATTR_KILL_SUIDGID;
     if (exp->allow_other) {
-        supported_attrs |= FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID;
+        supported_attrs |= FATTR_UID | FATTR_GID;
     }
 
     if (to_set & ~supported_attrs) {
-        fuse_reply_err(req, ENOTSUP);
-        return;
+        return -ENOTSUP;
     }
 
     /* Do some argument checks first before committing to anything */
-    if (to_set & FUSE_SET_ATTR_MODE) {
+    if (to_set & FATTR_MODE) {
         /*
          * Without allow_other, non-owners can never access the export, so do
          * not allow setting permissions for them
          */
-        if (!exp->allow_other &&
-            (statbuf->st_mode & (S_IRWXG | S_IRWXO)) != 0)
-        {
-            fuse_reply_err(req, EPERM);
-            return;
+        if (!exp->allow_other && (mode & (S_IRWXG | S_IRWXO)) != 0) {
+            return -EPERM;
         }
 
         /* +w for read-only exports makes no sense, disallow it */
-        if (!exp->writable &&
-            (statbuf->st_mode & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0)
-        {
-            fuse_reply_err(req, EROFS);
-            return;
+        if (!exp->writable && (mode & (S_IWUSR | S_IWGRP | S_IWOTH)) != 0) {
+            return -EROFS;
         }
     }
 
-    if (to_set & FUSE_SET_ATTR_SIZE) {
+    if (to_set & FATTR_SIZE) {
         if (!exp->writable) {
-            fuse_reply_err(req, EACCES);
-            return;
+            return -EACCES;
         }
 
-        ret = fuse_do_truncate(exp, statbuf->st_size, true, PREALLOC_MODE_OFF);
+        ret = fuse_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
         if (ret < 0) {
-            fuse_reply_err(req, -ret);
-            return;
+            return ret;
         }
     }
 
-    if (to_set & FUSE_SET_ATTR_MODE) {
+    if (to_set & FATTR_MODE) {
         /* Ignore FUSE-supplied file type, only change the mode */
-        exp->st_mode = (statbuf->st_mode & 07777) | S_IFREG;
+        exp->st_mode = (mode & 07777) | S_IFREG;
     }
 
-    if (to_set & FUSE_SET_ATTR_UID) {
-        exp->st_uid = statbuf->st_uid;
+    if (to_set & FATTR_UID) {
+        exp->st_uid = uid;
     }
 
-    if (to_set & FUSE_SET_ATTR_GID) {
-        exp->st_gid = statbuf->st_gid;
+    if (to_set & FATTR_GID) {
+        exp->st_gid = gid;
     }
 
-    fuse_getattr(req, inode, fi);
+    return fuse_getattr(exp, out);
 }
 
 /**
- * Let clients open a file (i.e., the exported image).
+ * Open an inode.  We only have a single inode in our exported filesystem, so we
+ * just acknowledge the request.
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_open(fuse_req_t req, fuse_ino_t inode,
-                      struct fuse_file_info *fi)
+static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
 {
-    fi->direct_io = true;
-    fi->parallel_direct_writes = true;
-    fuse_reply_open(req, fi);
+    *out = (struct fuse_open_out) {
+        .open_flags = FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES,
+    };
+    return sizeof(*out);
 }
 
 /**
- * Handle client reads from the exported image.
+ * Handle client reads from the exported image.  Allocates *bufptr and reads
+ * data from the block device into that buffer.
+ * Returns the buffer (read) size on success, and -errno on error.
+ * After use, *bufptr must be freed via qemu_vfree().
  */
-static void fuse_read(fuse_req_t req, fuse_ino_t inode,
-                      size_t size, off_t offset, struct fuse_file_info *fi)
+static ssize_t fuse_read(FuseExport *exp, void **bufptr,
+                         uint64_t offset, uint32_t size)
 {
-    FuseExport *exp = fuse_req_userdata(req);
     int64_t blk_len;
     void *buf;
     int ret;
 
     /* Limited by max_read, should not happen */
-    if (size > FUSE_MAX_BOUNCE_BYTES) {
-        fuse_reply_err(req, EINVAL);
-        return;
+    if (size > FUSE_MAX_READ_BYTES) {
+        return -EINVAL;
     }
 
     /**
@@ -653,18 +954,12 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
      */
     blk_len = blk_getlength(exp->common.blk);
     if (blk_len < 0) {
-        fuse_reply_err(req, -blk_len);
-        return;
+        return blk_len;
     }
 
     if (offset >= blk_len) {
-        /*
-         * Technically libfuse does not allow returning a zero error code for
-         * read requests, but in practice this is a 0-length read (and a future
-         * commit will change this code anyway)
-         */
-        fuse_reply_err(req, 0);
-        return;
+        *bufptr = NULL;
+        return 0;
     }
 
     if (offset + size > blk_len) {
@@ -673,108 +968,96 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
 
     buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
     if (!buf) {
-        fuse_reply_err(req, ENOMEM);
-        return;
+        return -ENOMEM;
     }
 
     ret = blk_pread(exp->common.blk, offset, size, buf, 0);
-    if (ret >= 0) {
-        fuse_reply_buf(req, buf, size);
-    } else {
-        fuse_reply_err(req, -ret);
+    if (ret < 0) {
+        qemu_vfree(buf);
+        return ret;
     }
 
-    qemu_vfree(buf);
+    *bufptr = buf;
+    return size;
 }
 
 /**
- * Handle client writes to the exported image.
+ * Handle client writes to the exported image.  @buf has the data to be written.
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
-                       size_t size, off_t offset, struct fuse_file_info *fi)
+static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
+                          uint64_t offset, uint32_t size, const void *buf)
 {
-    FuseExport *exp = fuse_req_userdata(req);
-    QEMU_AUTO_VFREE void *copied = NULL;
     int64_t blk_len;
     int ret;
 
+    QEMU_BUILD_BUG_ON(FUSE_MAX_WRITE_BYTES > BDRV_REQUEST_MAX_BYTES);
     /* Limited by max_write, should not happen */
-    if (size > BDRV_REQUEST_MAX_BYTES) {
-        fuse_reply_err(req, EINVAL);
-        return;
+    if (size > FUSE_MAX_WRITE_BYTES) {
+        return -EINVAL;
     }
 
     if (!exp->writable) {
-        fuse_reply_err(req, EACCES);
-        return;
+        return -EACCES;
     }
 
-    /*
-     * Heed the note on read_from_fuse_export(): If we call aio_poll() (which
-     * any blk_*() I/O function may do), read_from_fuse_export() may be nested,
-     * overwriting the request buffer content.  Therefore, we must copy it here.
-     */
-    copied = blk_blockalign(exp->common.blk, size);
-    memcpy(copied, buf, size);
-
     /**
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
     blk_len = blk_getlength(exp->common.blk);
     if (blk_len < 0) {
-        fuse_reply_err(req, -blk_len);
-        return;
+        return blk_len;
     }
 
     if (offset >= blk_len && !exp->growable) {
-        fuse_reply_write(req, 0);
-        return;
+        *out = (struct fuse_write_out) {
+            .size = 0,
+        };
+        return sizeof(*out);
     }
 
     if (offset + size < offset) {
-        fuse_reply_err(req, EINVAL);
-        return;
+        return -EINVAL;
     } else if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
-                fuse_reply_err(req, -ret);
-                return;
+                return ret;
             }
         } else {
             size = blk_len - offset;
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, copied, 0);
-    if (ret >= 0) {
-        fuse_reply_write(req, size);
-    } else {
-        fuse_reply_err(req, -ret);
+    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
+    if (ret < 0) {
+        return ret;
     }
+
+    *out = (struct fuse_write_out) {
+        .size = size,
+    };
+    return sizeof(*out);
 }
 
 /**
  * Let clients perform various fallocate() operations.
+ * Return 0 on success (no 'out' object), and -errno on error.
  */
-static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
-                           off_t offset, off_t length,
-                           struct fuse_file_info *fi)
+static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t length,
+                              uint32_t mode)
 {
-    FuseExport *exp = fuse_req_userdata(req);
     int64_t blk_len;
     int ret;
 
     if (!exp->writable) {
-        fuse_reply_err(req, EACCES);
-        return;
+        return -EACCES;
     }
 
     blk_len = blk_getlength(exp->common.blk);
     if (blk_len < 0) {
-        fuse_reply_err(req, -blk_len);
-        return;
+        return blk_len;
     }
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -786,16 +1069,14 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
     if (!mode) {
         /* We can only fallocate at the EOF with a truncate */
         if (offset < blk_len) {
-            fuse_reply_err(req, EOPNOTSUPP);
-            return;
+            return -EOPNOTSUPP;
         }
 
         if (offset > blk_len) {
             /* No preallocation needed here */
             ret = fuse_do_truncate(exp, offset, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
-                fuse_reply_err(req, -ret);
-                return;
+                return ret;
             }
         }
 
@@ -805,8 +1086,7 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     else if (mode & FALLOC_FL_PUNCH_HOLE) {
         if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-            fuse_reply_err(req, EINVAL);
-            return;
+            return -EINVAL;
         }
 
         do {
@@ -834,8 +1114,7 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
             ret = fuse_do_truncate(exp, offset + length, false,
                                    PREALLOC_MODE_OFF);
             if (ret < 0) {
-                fuse_reply_err(req, -ret);
-                return;
+                return ret;
             }
         }
 
@@ -853,44 +1132,38 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
         ret = -EOPNOTSUPP;
     }
 
-    fuse_reply_err(req, ret < 0 ? -ret : 0);
+    return ret < 0 ? ret : 0;
 }
 
 /**
  * Let clients fsync the exported image.
+ * Return 0 on success (no 'out' object), and -errno on error.
  */
-static void fuse_fsync(fuse_req_t req, fuse_ino_t inode, int datasync,
-                       struct fuse_file_info *fi)
+static ssize_t fuse_fsync(FuseExport *exp)
 {
-    FuseExport *exp = fuse_req_userdata(req);
-    int ret;
-
-    ret = blk_flush(exp->common.blk);
-    fuse_reply_err(req, ret < 0 ? -ret : 0);
+    return blk_flush(exp->common.blk);
 }
 
 /**
  * Called before an FD to the exported image is closed.  (libfuse
  * notes this to be a way to return last-minute errors.)
+ * Return 0 on success (no 'out' object), and -errno on error.
  */
-static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
-                        struct fuse_file_info *fi)
+static ssize_t fuse_flush(FuseExport *exp)
 {
-    fuse_fsync(req, inode, 1, fi);
+    return blk_flush(exp->common.blk);
 }
 
 #ifdef CONFIG_FUSE_LSEEK
 /**
  * Let clients inquire allocation status.
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
-                       int whence, struct fuse_file_info *fi)
+static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
+                          uint64_t offset, uint32_t whence)
 {
-    FuseExport *exp = fuse_req_userdata(req);
-
     if (whence != SEEK_HOLE && whence != SEEK_DATA) {
-        fuse_reply_err(req, EINVAL);
-        return;
+        return -EINVAL;
     }
 
     while (true) {
@@ -900,8 +1173,7 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
         ret = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
                                       offset, INT64_MAX, &pnum, NULL, NULL);
         if (ret < 0) {
-            fuse_reply_err(req, -ret);
-            return;
+            return ret;
         }
 
         if (!pnum && (ret & BDRV_BLOCK_EOF)) {
@@ -918,34 +1190,38 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
 
             blk_len = blk_getlength(exp->common.blk);
             if (blk_len < 0) {
-                fuse_reply_err(req, -blk_len);
-                return;
+                return blk_len;
             }
 
             if (offset > blk_len || whence == SEEK_DATA) {
-                fuse_reply_err(req, ENXIO);
-            } else {
-                fuse_reply_lseek(req, offset);
+                return -ENXIO;
             }
-            return;
+
+            *out = (struct fuse_lseek_out) {
+                .offset = offset,
+            };
+            return sizeof(*out);
         }
 
         if (ret & BDRV_BLOCK_DATA) {
             if (whence == SEEK_DATA) {
-                fuse_reply_lseek(req, offset);
-                return;
+                *out = (struct fuse_lseek_out) {
+                    .offset = offset,
+                };
+                return sizeof(*out);
             }
         } else {
             if (whence == SEEK_HOLE) {
-                fuse_reply_lseek(req, offset);
-                return;
+                *out = (struct fuse_lseek_out) {
+                    .offset = offset,
+                };
+                return sizeof(*out);
             }
         }
 
         /* Safety check against infinite loops */
         if (!pnum) {
-            fuse_reply_err(req, ENXIO);
-            return;
+            return -ENXIO;
         }
 
         offset += pnum;
@@ -953,21 +1229,241 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
 }
 #endif
 
-static const struct fuse_lowlevel_ops fuse_ops = {
-    .init       = fuse_init,
-    .lookup     = fuse_lookup,
-    .getattr    = fuse_getattr,
-    .setattr    = fuse_setattr,
-    .open       = fuse_open,
-    .read       = fuse_read,
-    .write      = fuse_write,
-    .fallocate  = fuse_fallocate,
-    .flush      = fuse_flush,
-    .fsync      = fuse_fsync,
+/**
+ * Write a FUSE response to the given @fd.
+ *
+ * Effectively, writes out_hdr->common.len bytes of the buffer that is *out_hdr.
+ *
+ * @fd: FUSE file descriptor
+ * @out_hdr: Request response header and request-specific response data
+ */
+static int fuse_write_response(int fd, FuseRequestOutHeader *out_hdr)
+{
+    size_t to_write = out_hdr->common.len;
+    ssize_t ret;
+
+    /* Must at least write fuse_out_header */
+    assert(to_write >= sizeof(out_hdr->common));
+
+    ret = RETRY_ON_EINTR(write(fd, out_hdr, to_write));
+    if (ret < 0) {
+        ret = -errno;
+        error_report("Failed to write to FUSE device: %s", strerror(-ret));
+        return ret;
+    }
+
+    /* Short writes are unexpected, treat them as errors */
+    if (ret != to_write) {
+        error_report("Short write to FUSE device, wrote %zi of %zu bytes",
+                     ret, to_write);
+        return -EIO;
+    }
+
+    return 0;
+}
+
+/**
+ * Write a FUSE error response to @fd.
+ *
+ * @fd: FUSE file descriptor
+ * @in_hdr: Incoming request header to which to respond
+ * @err: Error code (-errno, must be negative!)
+ */
+static int fuse_write_err(int fd, const struct fuse_in_header *in_hdr, int err)
+{
+    FuseRequestOutHeader out_hdr = {
+        .common = {
+            .len = sizeof(out_hdr.common),
+            /* FUSE expects negative error values */
+            .error = err,
+            .unique = in_hdr->unique,
+        },
+    };
+
+    return fuse_write_response(fd, &out_hdr);
+}
+
+/**
+ * Write a FUSE response to the given @fd, using separate buffers for the
+ * response header and data.
+ *
+ * In contrast to fuse_write_response(), this function cannot return a full
+ * FuseRequestOutHeader (i.e. including request-specific response structs),
+ * but only FuseRequestOutHeader.common.  The remaining data must be in
+ * *buf.
+ *
+ * (Total length must be set in out_hdr->len.)
+ *
+ * @fd: FUSE file descriptor
+ * @out_hdr: Request response header
+ * @buf: Pointer to response data
+ */
+static int fuse_write_buf_response(int fd,
+                                   const struct fuse_out_header *out_hdr,
+                                   const void *buf)
+{
+    size_t to_write = out_hdr->len;
+    struct iovec iov[2] = {
+        { (void *)out_hdr, sizeof(*out_hdr) },
+        { (void *)buf, to_write - sizeof(*out_hdr) },
+    };
+    ssize_t ret;
+
+    /* *buf length must not be negative */
+    assert(to_write >= sizeof(*out_hdr));
+
+    ret = RETRY_ON_EINTR(writev(fd, iov, ARRAY_SIZE(iov)));
+    if (ret < 0) {
+        ret = -errno;
+        error_report("Failed to write to FUSE device: %s", strerror(-ret));
+        return ret;
+    }
+
+    /* Short writes are unexpected, treat them as errors */
+    if (ret != to_write) {
+        error_report("Short write to FUSE device, wrote %zi of %zu bytes",
+                     ret, to_write);
+        return -EIO;
+    }
+
+    return 0;
+}
+
+/**
+ * Process a FUSE request, incl. writing the response.
+ */
+static void fuse_process_request(FuseExport *exp,
+                                 const FuseRequestInHeader *in_hdr,
+                                 const void *data_buffer)
+{
+    FuseRequestOutHeader out_hdr;
+    /* For read requests: Data to be returned */
+    void *out_data_buffer = NULL;
+    ssize_t ret;
+
+    switch (in_hdr->common.opcode) {
+    case FUSE_INIT:
+        ret = fuse_init(exp, &out_hdr.init, &in_hdr->init);
+        break;
+
+    case FUSE_DESTROY:
+        ret = 0;
+        break;
+
+    case FUSE_STATFS:
+        ret = fuse_statfs(exp, &out_hdr.statfs);
+        break;
+
+    case FUSE_OPEN:
+        ret = fuse_open(exp, &out_hdr.open);
+        break;
+
+    case FUSE_RELEASE:
+        ret = 0;
+        break;
+
+    case FUSE_LOOKUP:
+        ret = -ENOENT; /* There is no node but the root node */
+        break;
+
+    case FUSE_FORGET:
+    case FUSE_BATCH_FORGET:
+        /* These have no response, and there is nothing we need to do */
+        return;
+
+    case FUSE_GETATTR:
+        ret = fuse_getattr(exp, &out_hdr.attr);
+        break;
+
+    case FUSE_SETATTR: {
+        const struct fuse_setattr_in *in = &in_hdr->setattr;
+        ret = fuse_setattr(exp, &out_hdr.attr,
+                           in->valid, in->size, in->mode, in->uid, in->gid);
+        break;
+    }
+
+    case FUSE_READ: {
+        const struct fuse_read_in *in = &in_hdr->read;
+        ret = fuse_read(exp, &out_data_buffer, in->offset, in->size);
+        break;
+    }
+
+    case FUSE_WRITE: {
+        const struct fuse_write_in *in = &in_hdr->write;
+        uint32_t req_len = in_hdr->common.len;
+
+        if (unlikely(req_len < sizeof(in_hdr->common) + sizeof(*in) +
+                               in->size)) {
+            warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
+                        req_len - sizeof(in_hdr->common) - sizeof(*in),
+                        in->size);
+            ret = -EINVAL;
+            break;
+        }
+
+        /*
+         * read_from_fuse_fd() has checked that in_hdr->len matches the number
+         * of bytes read, which cannot exceed the max_write value we set
+         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
+         * in_hdr->len >= in->size + X, so this assertion must hold.
+         */
+        assert(in->size <= FUSE_MAX_WRITE_BYTES);
+
+        ret = fuse_write(exp, &out_hdr.write,
+                         in->offset, in->size, data_buffer);
+        break;
+    }
+
+    case FUSE_FALLOCATE: {
+        const struct fuse_fallocate_in *in = &in_hdr->fallocate;
+        ret = fuse_fallocate(exp, in->offset, in->length, in->mode);
+        break;
+    }
+
+    case FUSE_FSYNC:
+        ret = fuse_fsync(exp);
+        break;
+
+    case FUSE_FLUSH:
+        ret = fuse_flush(exp);
+        break;
+
 #ifdef CONFIG_FUSE_LSEEK
-    .lseek      = fuse_lseek,
+    case FUSE_LSEEK: {
+        const struct fuse_lseek_in *in = &in_hdr->lseek;
+        ret = fuse_lseek(exp, &out_hdr.lseek, in->offset, in->whence);
+        break;
+    }
 #endif
-};
+
+    default:
+        ret = -ENOSYS;
+    }
+
+    if (ret >= 0) {
+        out_hdr.common = (struct fuse_out_header) {
+            .len = sizeof(out_hdr.common) + ret,
+            .unique = in_hdr->common.unique,
+        };
+    } else {
+        /* fuse_read() must not return a buffer in case of error */
+        assert(out_data_buffer == NULL);
+
+        out_hdr.common = (struct fuse_out_header) {
+            .len = sizeof(out_hdr.common),
+            /* FUSE expects negative errno values */
+            .error = ret,
+            .unique = in_hdr->common.unique,
+        };
+    }
+
+    if (out_data_buffer) {
+        fuse_write_buf_response(exp->fuse_fd, &out_hdr.common, out_data_buffer);
+        qemu_vfree(out_data_buffer);
+    } else {
+        fuse_write_response(exp->fuse_fd, &out_hdr);
+    }
+}
 
 const BlockExportDriver blk_exp_fuse = {
     .type               = BLOCK_EXPORT_TYPE_FUSE,
-- 
2.53.0


