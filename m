Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE94C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBl-0000RM-Q0; Wed, 04 Jun 2025 09:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBA-0007Qm-KC
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoB6-0004nm-8v
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxZcR3AmpFUGdbohg8jsELKP2G8ON9IkaPBK/eNafiE=;
 b=MOEGbrvmhiaBFOPAxZHqjV+E8WiTN+WZHeN5UnpLOG2DiLHTxu81pdjrIDGKAhl/a/FwWO
 kgbxE/Xhnj94z04m944rMDQAoRApBgOLYFLY361FQmE/rMcjQkCSD2RVwVTwnSUy1ruf1A
 RlK9/RaNpLrSOuSrhLUaM08yMEDSPos=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-p_ey5G-8Mhi7EWNdluQI5g-1; Wed, 04 Jun 2025 09:29:09 -0400
X-MC-Unique: p_ey5G-8Mhi7EWNdluQI5g-1
X-Mimecast-MFC-AGG-ID: p_ey5G-8Mhi7EWNdluQI5g_1749043748
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso4684225e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043748; x=1749648548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxZcR3AmpFUGdbohg8jsELKP2G8ON9IkaPBK/eNafiE=;
 b=v9CanEyR+w7b4xiUx8pJQXA4lG9N/5O6UH86oor3psqU1jVVv7WRARPf6T63iL2rx/
 DrW+NWA5Y4prAkp8yKtrSOslT4z4fP+4ytZx5gi2eaF8H+a3O44BfunYVLJTrGutF2jZ
 hKELEXDLfhd7FbrjpvuMtrgLM68xYruOCmerqYAD0+p1ZLkgALxXHJWJHaYqDfO9lxQs
 dQ/H6PsPwMiICgwo5l9OajDdtB1/2gEUFCjO6XNVt80yUwRCkbL1ACg01MCopQb0N/yf
 JbIs9IOxJ16HQ1DxHH6lJAoiQXgMO5qq86mpn3FVreRwqt/5qCiD/awY5PwVXeBCiWNJ
 MMMQ==
X-Gm-Message-State: AOJu0YyfS9A3HyCfnpckyW7VYsk3aWrd2FRuhv/HNXLhVPaM/TyHU1QW
 gCGQQfySsWnbGAKfDXKAS7Z5hBmzaVAo8S15mIRGs/U4+Yo4J+Tr+zECTJrZWeEBRJKWoC0h6zm
 gvMVY0tZrTCf9S6ul5WZDKF5TngOsSskF6tZt/DkqQrdmC/ey/95ui3G1
X-Gm-Gg: ASbGnctW4V+qxfXLBrk+HdPK9qMTfLJSAJH6WrxfZTj7/qtkG1F3hQtnopQmwoPc/EE
 2C/ptyegnRQR4BkitxK+nuU1pOHNJNmo58p+g8y8dvs3fCqm3W1IDtuwSzxLivQBMDg+UY6xtn8
 UNlCbfI4kWGbRh7u8v8sUfQj2x8PkqOn1xG2ZdP68aNOWWHnV8qvcVC/SLqb6uZLs7iC4jpsbTM
 57bH8fiJE4rmixzF/wqZcjmQL0FrmglO5raPEVGn3URM/NMk5AG9VUdXc/1I5icwA+zviL7OV2X
 lGIsHHoIqDnee8aly8UeetEvJ/GJO4xT1vw3+XcfbzcKUtMhdcDJno5yaoYtBV92I5MZgiS29XU
 etkNb
X-Received: by 2002:a05:6000:288c:b0:3a4:e1f5:41f4 with SMTP id
 ffacd0b85a97d-3a514184a5bmr5959784f8f.17.1749043747005; 
 Wed, 04 Jun 2025 06:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwPuqjfU//mhQQ9YBjwl3c4dcVaOy+ulorj19jQB7vPXu27agXcme+bK88NGn9h3bzDQIwnw==
X-Received: by 2002:a05:6000:288c:b0:3a4:e1f5:41f4 with SMTP id
 ffacd0b85a97d-3a514184a5bmr5959740f8f.17.1749043746320; 
 Wed, 04 Jun 2025 06:29:06 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f167fe4fsm25282855e9.12.2025.06.04.06.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:03 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 13/21] fuse: Manually process requests (without libfuse)
Date: Wed,  4 Jun 2025 15:28:05 +0200
Message-ID: <20250604132813.359438-14-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
    seq aio:   78.6k ±1.3k IOPS
    rand aio:  39.3k ±2.9k
    seq sync:  32.5k ±0.7k
    rand sync:  9.9k ±0.1k
  write:
    seq aio:   61.9k ±0.5k
    rand aio:  61.2k ±0.6k
    seq sync:  27.9k ±0.2k
    rand sync: 27.6k ±0.4k
null:
  read:
    seq aio:   214.0k ±5.9k
    rand aio:  212.7k ±4.5k
    seq sync:   90.3k ±6.5k
    rand sync:  89.7k ±5.1k
  write:
    seq aio:   203.9k ±1.5k
    rand aio:  201.4k ±3.6k
    seq sync:   86.1k ±6.2k
    rand sync:  84.9k ±5.3k

And with this patch applied:

file:
  read:
    seq aio:   76.6k ±1.8k (- 3 %)
    rand aio:  26.7k ±0.4k (-32 %)
    seq sync:  47.7k ±1.2k (+47 %)
    rand sync: 10.1k ±0.2k (+ 2 %)
  write:
    seq aio:   58.1k ±0.5k (- 6 %)
    rand aio:  58.1k ±0.5k (- 5 %)
    seq sync:  36.3k ±0.3k (+30 %)
    rand sync: 36.1k ±0.4k (+31 %)
null:
  read:
    seq aio:   268.4k ±3.4k (+25 %)
    rand aio:  265.3k ±2.1k (+25 %)
    seq sync:  134.3k ±2.7k (+49 %)
    rand sync: 132.4k ±1.4k (+48 %)
  write:
    seq aio:   275.3k ±1.7k (+35 %)
    rand aio:  272.3k ±1.9k (+35 %)
    seq sync:  130.7k ±1.6k (+52 %)
    rand sync: 127.4k ±2.4k (+50 %)

So clearly the AIO file results are actually not good, and random reads
are indeed quite terrible.  On the other hand, we can see from the sync
and null results that request handling should in theory be quicker.  How
does this fit together?

I believe the bad AIO results are an artifact of the accidental parallel
request processing we have due to nested polling: Depending on how the
actual request processing is structured and how long request processing
takes, more or less requests will be submitted in parallel.  So because
of the restructuring, I think this patch accidentally changes how many
requests end up being submitted in parallel, which decreases
performance.

(I have seen something like this before: In RSD, without having
implemented a polling mode, the debug build tended to have better
performance than the more optimized release build, because the debug
build, taking longer to submit requests, ended up processing more
requests in parallel.)

In any case, once we use coroutines throughout the code, performance
will improve again across the board.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 754 +++++++++++++++++++++++++++++++-------------
 1 file changed, 535 insertions(+), 219 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index fd7887889c..926f97a885 100644
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
@@ -42,17 +45,27 @@
 #endif
 
 /* Prevent overly long bounce buffer allocations */
-#define FUSE_MAX_BOUNCE_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
-
+#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
+/* Small enough to fit in the request buffer */
+#define FUSE_MAX_WRITE_BYTES (4 * 1024)
 
 typedef struct FuseExport {
     BlockExport common;
 
     struct fuse_session *fuse_session;
-    struct fuse_buf fuse_buf;
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
+    /*
+     * The request buffer must be able to hold a full write, and/or at least
+     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes
+     */
+    char request_buf[MAX_CONST(
+        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
+             FUSE_MAX_WRITE_BYTES,
+        FUSE_MIN_READ_BUFFER
+    )];
+
     /*
      * Set when there was an unrecoverable error and no requests should be read
      * from the device anymore (basically only in case of something we would
@@ -60,6 +73,8 @@ typedef struct FuseExport {
      */
     bool halted;
 
+    int fuse_fd;
+
     char *mountpoint;
     bool writable;
     bool growable;
@@ -72,19 +87,19 @@ typedef struct FuseExport {
 } FuseExport;
 
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
+static void fuse_process_request(FuseExport *exp);
 
 static void fuse_inc_in_flight(FuseExport *exp)
 {
@@ -105,22 +120,26 @@ static void fuse_dec_in_flight(FuseExport *exp)
     }
 }
 
+/**
+ * Attach FUSE FD read handler.
+ */
 static void fuse_attach_handlers(FuseExport *exp)
 {
     if (exp->halted) {
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
@@ -247,6 +266,13 @@ static int fuse_export_create(BlockExport *blk_exp,
 
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
 
@@ -292,7 +318,7 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     mount_opts = g_strdup_printf("%s,nosuid,nodev,noatime,max_read=%zu,"
                                  "default_permissions%s",
                                  exp->writable ? "rw" : "ro",
-                                 FUSE_MAX_BOUNCE_BYTES,
+                                 FUSE_MAX_READ_BYTES,
                                  exp->allow_other ? ",allow_other" : "");
 
     fuse_argv[0] = ""; /* Dummy program name */
@@ -301,8 +327,8 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     fuse_argv[3] = NULL;
     fuse_args = (struct fuse_args)FUSE_ARGS_INIT(3, (char **)fuse_argv);
 
-    exp->fuse_session = fuse_session_new(&fuse_args, &fuse_ops,
-                                         sizeof(fuse_ops), exp);
+    /* We just create the session for mounting/unmounting, no need to set ops */
+    exp->fuse_session = fuse_session_new(&fuse_args, NULL, 0, NULL);
     g_free(mount_opts);
     if (!exp->fuse_session) {
         error_setg(errp, "Failed to set up FUSE session");
@@ -320,36 +346,54 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
 }
 
 /**
- * Callback to be invoked when the FUSE session FD can be read from.
- * (This is basically the FUSE event loop.)
+ * Try to read and process a single request from the FUSE FD.
  */
-static void read_from_fuse_export(void *opaque)
+static void read_from_fuse_fd(void *opaque)
 {
     FuseExport *exp = opaque;
-    int ret;
+    int fuse_fd = exp->fuse_fd;
+    ssize_t ret;
+    const struct fuse_in_header *in_hdr;
+
+    fuse_inc_in_flight(exp);
 
     if (unlikely(exp->halted)) {
-        return;
+        goto no_request;
     }
 
-    fuse_inc_in_flight(exp);
+    ret = RETRY_ON_EINTR(read(fuse_fd, exp->request_buf,
+                              sizeof(exp->request_buf)));
+    if (ret < 0 && errno == EAGAIN) {
+        /* No request available */
+        goto no_request;
+    } else if (unlikely(ret < 0)) {
+        error_report("Failed to read from FUSE device: %s", strerror(-ret));
+        goto no_request;
+    }
 
-    do {
-        ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
-    } while (ret == -EINTR);
-    if (ret < 0) {
-        goto out;
+    if (unlikely(ret < sizeof(*in_hdr))) {
+        error_report("Incomplete read from FUSE device, expected at least %zu "
+                     "bytes, read %zi bytes; cannot trust subsequent "
+                     "requests, halting the export",
+                     sizeof(*in_hdr), ret);
+        fuse_export_halt(exp);
+        goto no_request;
     }
 
-    /*
-     * Note that aio_poll() in any request-processing function can lead to a
-     * nested read_from_fuse_export() call, which will overwrite the contents of
-     * exp->fuse_buf.  Anything that takes a buffer needs to take care that the
-     * content is copied before potentially polling via aio_poll().
-     */
-    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
+    in_hdr = (const struct fuse_in_header *)exp->request_buf;
+    if (unlikely(ret != in_hdr->len)) {
+        error_report("Number of bytes read from FUSE device does not match "
+                     "request size, expected %" PRIu32 " bytes, read %zi "
+                     "bytes; cannot trust subsequent requests, halting the "
+                     "export",
+                     in_hdr->len, ret);
+        fuse_export_halt(exp);
+        goto no_request;
+    }
+
+    fuse_process_request(exp);
 
-out:
+no_request:
     fuse_dec_in_flight(exp);
 }
 
@@ -357,18 +401,14 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
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
@@ -386,7 +426,6 @@ static void fuse_export_delete(BlockExport *blk_exp)
         fuse_session_destroy(exp->fuse_session);
     }
 
-    free(exp->fuse_buf.mem);
     g_free(exp->mountpoint);
 }
 
@@ -428,46 +467,57 @@ static bool is_regular_file(const char *path, Error **errp)
 }
 
 /**
- * A chance to set change some parameters supplied to FUSE_INIT.
+ * Process FUSE INIT.
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_init(void *userdata, struct fuse_conn_info *conn)
+static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
+                         uint32_t max_readahead, uint32_t flags)
 {
-    /*
-     * MIN_NON_ZERO() would not be wrong here, but what we set here
-     * must equal what has been passed to fuse_session_new().
-     * Therefore, as long as max_read must be passed as a mount option
-     * (which libfuse claims will be changed at some point), we have
-     * to set max_read to a fixed value here.
-     */
-    conn->max_read = FUSE_MAX_BOUNCE_BYTES;
+    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
 
-    conn->max_write = MIN_NON_ZERO(BDRV_REQUEST_MAX_BYTES, conn->max_write);
-}
+    *out = (struct fuse_init_out) {
+        .major = FUSE_KERNEL_VERSION,
+        .minor = FUSE_KERNEL_MINOR_VERSION,
+        .max_readahead = max_readahead,
+        .max_write = FUSE_MAX_WRITE_BYTES,
+        .flags = flags & supported_flags,
+        .flags2 = 0,
 
-/**
- * Let clients look up files.  Always return ENOENT because we only
- * care about the mountpoint itself.
- */
-static void fuse_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
-{
-    fuse_reply_err(req, ENOENT);
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
@@ -477,21 +527,24 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
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
@@ -544,159 +597,151 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
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
-    int64_t length;
+    int64_t blk_len;
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
      * Clients will expect short reads at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
-        return;
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        return blk_len;
     }
 
-    if (offset + size > length) {
-        size = length - offset;
+    if (offset + size > blk_len) {
+        size = blk_len - offset;
     }
 
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
+ * Handle client writes to the exported image.  @buf has the data to be written
+ * and will be copied to a bounce buffer before polling for the first time.
+ * Return the number of bytes written to *out on success, and -errno on error.
  */
-static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
-                       size_t size, off_t offset, struct fuse_file_info *fi)
+static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
+                          uint64_t offset, uint32_t size, const void *buf)
 {
-    FuseExport *exp = fuse_req_userdata(req);
     void *copied;
     int64_t blk_len;
     int ret;
 
     /* Limited by max_write, should not happen */
     if (size > BDRV_REQUEST_MAX_BYTES) {
-        fuse_reply_err(req, EINVAL);
-        return;
+        return -EINVAL;
     }
 
     if (!exp->writable) {
-        fuse_reply_err(req, EACCES);
-        return;
+        return -EACCES;
     }
 
     /*
-     * Heed the note on read_from_fuse_export(): If we call aio_poll() (which
-     * any blk_*() I/O function may do), read_from_fuse_export() may be nested,
-     * overwriting the request buffer content.  Therefore, we must copy it here.
+     * Must copy to bounce buffer before calling aio_poll() (to allow nesting)
      */
     copied = blk_blockalign(exp->common.blk, size);
     memcpy(copied, buf, size);
@@ -707,16 +752,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
      */
     blk_len = blk_getlength(exp->common.blk);
     if (blk_len < 0) {
-        fuse_reply_err(req, -blk_len);
-        goto free_buffer;
+        ret = blk_len;
+        goto fail_free_buffer;
     }
 
     if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
-                fuse_reply_err(req, -ret);
-                goto free_buffer;
+                goto fail_free_buffer;
             }
         } else {
             size = blk_len - offset;
@@ -724,36 +768,39 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
     }
 
     ret = blk_pwrite(exp->common.blk, offset, size, copied, 0);
-    if (ret >= 0) {
-        fuse_reply_write(req, size);
-    } else {
-        fuse_reply_err(req, -ret);
+    if (ret < 0) {
+        goto fail_free_buffer;
     }
 
-free_buffer:
     qemu_vfree(copied);
+
+    *out = (struct fuse_write_out) {
+        .size = size,
+    };
+    return sizeof(*out);
+
+fail_free_buffer:
+    qemu_vfree(copied);
+    return ret;
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
@@ -765,16 +812,14 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
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
 
@@ -784,8 +829,7 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     else if (mode & FALLOC_FL_PUNCH_HOLE) {
         if (!(mode & FALLOC_FL_KEEP_SIZE)) {
-            fuse_reply_err(req, EINVAL);
-            return;
+            return -EINVAL;
         }
 
         do {
@@ -813,8 +857,7 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
             ret = fuse_do_truncate(exp, offset + length, false,
                                    PREALLOC_MODE_OFF);
             if (ret < 0) {
-                fuse_reply_err(req, -ret);
-                return;
+                return ret;
             }
         }
 
@@ -832,44 +875,38 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
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
@@ -879,8 +916,7 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
         ret = bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
                                       offset, INT64_MAX, &pnum, NULL, NULL);
         if (ret < 0) {
-            fuse_reply_err(req, -ret);
-            return;
+            return ret;
         }
 
         if (!pnum && (ret & BDRV_BLOCK_EOF)) {
@@ -897,34 +933,38 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
 
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
@@ -932,21 +972,297 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
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
+ * Write a FUSE response to the given @fd, using a single buffer consecutively
+ * containing both the response header and data: Initialize *out_hdr, and write
+ * it plus @response_data_length consecutive bytes to @fd.
+ *
+ * @fd: FUSE file descriptor
+ * @req_id: Corresponding request ID
+ * @out_hdr: Pointer to buffer that will hold the output header, and
+ *           additionally already contains @response_data_length data bytes
+ *           starting at *out_hdr + 1.
+ * @err: Error code (-errno, or 0 in case of success)
+ * @response_data_length: Length of data to return (following *out_hdr)
+ */
+static int fuse_write_response(int fd, uint32_t req_id,
+                               struct fuse_out_header *out_hdr, int err,
+                               size_t response_data_length)
+{
+    void *write_ptr = out_hdr;
+    size_t to_write = sizeof(*out_hdr) + response_data_length;
+    ssize_t ret;
+
+    *out_hdr = (struct fuse_out_header) {
+        .len = to_write,
+        .error = err,
+        .unique = req_id,
+    };
+
+    while (true) {
+        ret = RETRY_ON_EINTR(write(fd, write_ptr, to_write));
+        if (ret < 0) {
+            ret = -errno;
+            error_report("Failed to write to FUSE device: %s", strerror(-ret));
+            return ret;
+        } else {
+            to_write -= ret;
+            if (to_write > 0) {
+                write_ptr += ret;
+            } else {
+                return 0; /* success */
+            }
+        }
+    }
+}
+
+/**
+ * Write a FUSE response to the given @fd, using separate buffers for the
+ * response header and data: Initialize *out_hdr, and write it plus the data in
+ * *buf to @fd.
+ *
+ * In contrast to fuse_write_response(), this function cannot return errors, and
+ * will always return success (error code 0).
+ *
+ * @fd: FUSE file descriptor
+ * @req_id: Corresponding request ID
+ * @out_hdr: Pointer to buffer that will hold the output header
+ * @buf: Pointer to response data
+ * @buflen: Length of response data
+ */
+static int fuse_write_buf_response(int fd, uint32_t req_id,
+                                   struct fuse_out_header *out_hdr,
+                                   const void *buf, size_t buflen)
+{
+    struct iovec iov[2] = {
+        { out_hdr, sizeof(*out_hdr) },
+        { (void *)buf, buflen },
+    };
+    struct iovec *iovp = iov;
+    unsigned iov_count = ARRAY_SIZE(iov);
+    size_t to_write = sizeof(*out_hdr) + buflen;
+    ssize_t ret;
+
+    *out_hdr = (struct fuse_out_header) {
+        .len = to_write,
+        .unique = req_id,
+    };
+
+    while (true) {
+        ret = RETRY_ON_EINTR(writev(fd, iovp, iov_count));
+        if (ret < 0) {
+            ret = -errno;
+            error_report("Failed to write to FUSE device: %s", strerror(-ret));
+            return ret;
+        } else {
+            to_write -= ret;
+            if (to_write > 0) {
+                iov_discard_front(&iovp, &iov_count, ret);
+            } else {
+                return 0; /* success */
+            }
+        }
+    }
+}
+
+/*
+ * For use in fuse_process_request():
+ * Returns a pointer to the parameter object for the given operation (inside of
+ * exp->request_buf, which is assumed to hold a fuse_in_header first).
+ * Verifies that the object is complete (exp->request_buf is large enough to
+ * hold it in one piece, and the request length includes the whole object).
+ *
+ * Note that exp->request_buf may be overwritten after polling, so the returned
+ * pointer must not be used across a function that may poll!
+ */
+#define FUSE_IN_OP_STRUCT(op_name, export) \
+    ({ \
+        const struct fuse_in_header *__in_hdr = \
+            (const struct fuse_in_header *)(export)->request_buf; \
+        const struct fuse_##op_name##_in *__in = \
+            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
+        const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
+        uint32_t __req_len; \
+        \
+        QEMU_BUILD_BUG_ON(sizeof((export)->request_buf) < __param_len); \
+        \
+        __req_len = __in_hdr->len; \
+        if (__req_len < __param_len) { \
+            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
+                        __req_len, __param_len); \
+            ret = -EINVAL; \
+            break; \
+        } \
+        __in; \
+    })
+
+/*
+ * For use in fuse_process_request():
+ * Returns a pointer to the return object for the given operation (inside of
+ * out_buf, which is assumed to hold a fuse_out_header first).
+ * Verifies that out_buf is large enough to hold the whole object.
+ *
+ * (out_buf should be a char[] array.)
+ */
+#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
+    ({ \
+        struct fuse_out_header *__out_hdr = \
+            (struct fuse_out_header *)(out_buf); \
+        struct fuse_##op_name##_out *__out = \
+            (struct fuse_##op_name##_out *)(__out_hdr + 1); \
+        \
+        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
+                          sizeof(out_buf)); \
+        \
+        __out; \
+    })
+
+/**
+ * Process a FUSE request, incl. writing the response.
+ *
+ * Note that polling in any request-processing function can lead to a nested
+ * read_from_fuse_fd() call, which will overwrite the contents of
+ * exp->request_buf.  Anything that takes a buffer needs to take care that the
+ * content is copied before potentially polling.
+ */
+static void fuse_process_request(FuseExport *exp)
+{
+    uint32_t opcode;
+    uint64_t req_id;
+    /*
+     * Return buffer.  Must be large enough to hold all return headers, but does
+     * not include space for data returned by read requests.
+     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is indeed
+     * large enough.)
+     */
+    char out_buf[sizeof(struct fuse_out_header) +
+                 MAX_CONST(sizeof(struct fuse_init_out),
+                 MAX_CONST(sizeof(struct fuse_open_out),
+                 MAX_CONST(sizeof(struct fuse_attr_out),
+                 MAX_CONST(sizeof(struct fuse_write_out),
+                           sizeof(struct fuse_lseek_out)))))];
+    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
+    /* For read requests: Data to be returned */
+    void *out_data_buffer = NULL;
+    ssize_t ret;
+
+    /* Limit scope to ensure pointer is no longer used after polling */
+    {
+        const struct fuse_in_header *in_hdr =
+            (const struct fuse_in_header *)exp->request_buf;
+
+        opcode = in_hdr->opcode;
+        req_id = in_hdr->unique;
+    }
+
+    switch (opcode) {
+    case FUSE_INIT: {
+        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, exp);
+        ret = fuse_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
+                        in->max_readahead, in->flags);
+        break;
+    }
+
+    case FUSE_OPEN:
+        ret = fuse_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
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
+    case FUSE_GETATTR:
+        ret = fuse_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
+        break;
+
+    case FUSE_SETATTR: {
+        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, exp);
+        ret = fuse_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
+                           in->valid, in->size, in->mode, in->uid, in->gid);
+        break;
+    }
+
+    case FUSE_READ: {
+        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, exp);
+        ret = fuse_read(exp, &out_data_buffer, in->offset, in->size);
+        break;
+    }
+
+    case FUSE_WRITE: {
+        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, exp);
+        uint32_t req_len;
+
+        req_len = ((const struct fuse_in_header *)exp->request_buf)->len;
+        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
+                               in->size)) {
+            warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
+                        req_len - sizeof(struct fuse_in_header) - sizeof(*in),
+                        in->size);
+            ret = -EINVAL;
+            break;
+        }
+
+        /*
+         * poll_fuse_fd() has checked that in_hdr->len matches the number of
+         * bytes read, which cannot exceed the max_write value we set
+         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
+         * in_hdr->len >= in->size + X, so this assertion must hold.
+         */
+        assert(in->size <= FUSE_MAX_WRITE_BYTES);
+
+        /*
+         * Passing a pointer to `in` (i.e. the request buffer) is fine because
+         * fuse_write() takes care to copy its contents before potentially
+         * polling.
+         */
+        ret = fuse_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
+                         in->offset, in->size, in + 1);
+        break;
+    }
+
+    case FUSE_FALLOCATE: {
+        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, exp);
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
+        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, exp);
+        ret = fuse_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
+                         in->offset, in->whence);
+        break;
+    }
 #endif
-};
+
+    default:
+        ret = -ENOSYS;
+    }
+
+    /* Ignore errors from fuse_write*(), nothing we can do anyway */
+    if (out_data_buffer) {
+        assert(ret >= 0);
+        fuse_write_buf_response(exp->fuse_fd, req_id, out_hdr,
+                                out_data_buffer, ret);
+        qemu_vfree(out_data_buffer);
+    } else {
+        fuse_write_response(exp->fuse_fd, req_id, out_hdr,
+                            ret < 0 ? ret : 0,
+                            ret < 0 ? 0 : ret);
+    }
+}
 
 const BlockExportDriver blk_exp_fuse = {
     .type               = BLOCK_EXPORT_TYPE_FUSE,
-- 
2.49.0


