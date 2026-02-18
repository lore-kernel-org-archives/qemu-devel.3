Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9D9E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshgK-0004to-Ne; Wed, 18 Feb 2026 08:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshft-0004U2-Ai
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfp-0006Gl-PS
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxNqYftpopQBXsxGyECaF4EaTK+LIZo8y+vscZHFzIE=;
 b=JUDLrBPMT6GLHgxiqGG6TC/lURdmPkfx/19Jk8AjHPQqayEXVhJ4JptI6dkqylZ7u9dTbf
 YNj9ZmD0zNg9PdkGHEMEyw2YE220VBkdx1EHoz7BbAq3D1fYrjrZDd/0Qt7ekAtTTO19Ov
 /HvOyrQeYITYF0zV5sFDsNxVkbSWY7Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-HN-KJNKLOa64_eZtGyg8fw-1; Wed, 18 Feb 2026 08:27:40 -0500
X-MC-Unique: HN-KJNKLOa64_eZtGyg8fw-1
X-Mimecast-MFC-AGG-ID: HN-KJNKLOa64_eZtGyg8fw_1771421260
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso30014165e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421259; x=1772026059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxNqYftpopQBXsxGyECaF4EaTK+LIZo8y+vscZHFzIE=;
 b=tlZhqthQYBiijLh535hMEm9HsrD+UBxHZ5qTRhgEjQgIJO1f1i9tX62g9vv3okS/AK
 q4cwt9aBleXQvG42M6OJtfCKFvVHouKs50bCSvZ7VzWj/Y94zO0guhB0awXyWAUN0wGR
 acvVfYFbPrONUy2MEzRWpOp15zt5IvpauaS02+MGrf9M0RaP1Se3mwnL7PFO30svckBl
 gjJvdJgF/mTolPAMU/jirxNhxROf7m0DEHVErz5z6dkUf3LDE0BNvl0dDiKbTDO6IvGF
 PZPIm0xilI0399NBv5+m1qZnMkqIsW7SedngC09owlJQZrGcFhpKoe1zktrc4GLF46lf
 T/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421259; x=1772026059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IxNqYftpopQBXsxGyECaF4EaTK+LIZo8y+vscZHFzIE=;
 b=r37SnunEqXraDHm5s3ZDs8ztJdfLXeuxsXL7hJghbXQkyTiFugNVd/XHgoCbPNLQ/L
 nOnn0S0bF5ZHA1P0Z1zCv4tKy3V09WFKgf79G3zBmnjLsU0xt3eWnbg4Io618xk+dRvE
 25bYvUNrV3CCmdRN6h7f8ltypyK7TpwP9KAN86Jj0rPd+pOEA32MpTWWGm76COcVhtY9
 FPfnbrIaPzRVzgAwSoz/dZRyGAGIJVzbB67quzuDfFQ+UKNaiB1Bgihd9CAn3BIL8fGy
 dyDHeBSckvb6wI6LCXzrnFbuTouAR+E3fZD0nFKKmd3scNJK6EMaELYORog1Y/d6YMtA
 Woeg==
X-Gm-Message-State: AOJu0Yyl7IdFHwxd5gGcgdL8F7ZCYCtkTMliOE85svXyC1q0sWhCUin/
 7SF1YbFn0GIMPiDHYINeGiNGsLC5P4gXWKLunhqCkB4owvWMHF/ax+ea3VZamU9FiP4XyfleHUe
 xGXvPwU7nWHxALgvruOcf0vHVbZqiox1XDGrINevgjbUeslZ7bzxx+CPu
X-Gm-Gg: AZuq6aK3y3cXrGxWYblmWNB1R5/2fb22vd2dF4IMsKAX8/eAtAJKIS4E+YMO0YkRIxZ
 8kvHKUUY7KX51gGrJhERWc8CZAsIW+R1MVQYC49ucmhulsbcO5no84WiTk3GL/lK0BhQDfW22KW
 pAh6aF7HD8W2q1TvcU5ezB9xI3UuLyOWS6ZqA1F0Tw9xnsC8z4SY8BLn9ZDLYeqjw2O2m6YkFL1
 Ui8Sia4QbYwYKToExXeknSxKMJRWMKYcpfn8//WyixSjaGJ5v1VCKUqtQvgPIWB8FemfeNbEcS+
 NDi0OVXITvsZAgGTBBDd3vhuWoOjaXdZmKvvJm/KA/iXJFyUZwpaoMAyKz9YJ3+JZvdT6c8braA
 sbHbEDIXIProl1sDxkAPqblQCqswLNdR4ILErQbEgqnldCPoR92B1OfNfHwDuNqGCYav2eSlid2
 08BtdT
X-Received: by 2002:a05:600c:820d:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-48379b9f278mr267766085e9.10.1771421259331; 
 Wed, 18 Feb 2026 05:27:39 -0800 (PST)
X-Received: by 2002:a05:600c:820d:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-48379b9f278mr267765525e9.10.1771421258675; 
 Wed, 18 Feb 2026 05:27:38 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483801ff9b3sm303123835e9.13.2026.02.18.05.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:37 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 22/24] fuse: Implement multi-threading
Date: Wed, 18 Feb 2026 14:26:31 +0100
Message-ID: <20260218132633.29748-23-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
(via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).

We can use this to implement multi-threading.

For configuration, we don't need any more information beyond the simple
array provided by the core block export interface: The FUSE kernel
driver feeds these FDs in a round-robin fashion, so all of them are
equivalent and we want to have exactly one per thread.

These are the benchmark results when using four threads (compared to a
single thread); note that fio still only uses a single job, but
performance can still be improved because of said round-robin usage for
the queues.  (Not in the sync case, though, in which case I guess it
just adds overhead.)

file:
  read:
    seq aio:   261.7k ±1.7k  (+168%)
    rand aio:  129.2k ±14.3k (+35%)
    seq sync:   36.6k ±0.6k  (+6%)
    rand sync:  10.1k ±0.1k  (+2%)
  write:
    seq aio:   235.7k ±2.8k  (+243%)
    rand aio:  232.0k ±6.7k  (+237%)
    seq sync:   31.7k ±0.6k  (+4%)
    rand sync:  31.8k ±0.5k  (+4%)
null:
  read:
    seq aio:   253.8k ±12.3k (+45%)
    rand aio:  248.2k ±12.0k (+45%)
    seq sync:   91.6k ±2.4k  (+12%)
    rand sync:  91.3k ±2.1k  (+17%)
  write:
    seq aio:   208.2k ±9.8k  (+6%)
    rand aio:  207.0k ±7.4k  (+8%)
    seq sync:   91.2k ±1.9k  (+9%)
    rand sync:  90.4k ±2.5k  (+14%)

So moderate improvements in most cases, but quite improved AIO
performance with an actual underlying file.

Here's results for numjobs=4:

"Before", i.e. without multithreading in QSD/FUSE (results compared to
numjobs=1):

file:
  read:
    seq aio:    85.5k ±0.4k (-13%)
    rand aio:   92.5k ±0.5k (-3%)
    seq sync:   54.5k ±9.1k (+58%)
    rand sync:  38.0k ±0.2k (+283%)
  write:
    seq aio:    67.3k ±0.3k (-2%)
    rand aio:   67.6k ±0.3k (-2%)
    seq sync:   69.3k ±0.5k (+126%)
    rand sync:  69.3k ±0.3k (+126%)
null:
  read:
    seq aio:   170.6k ±0.8k (-2%)
    rand aio:  170.9k ±0.9k (±0%)
    seq sync:  187.6k ±1.3k (+129%)
    rand sync: 188.9k ±0.9k (+142%)
  write:
    seq aio:   191.5k ±1.2k (-2%)
    rand aio:  193.8k ±1.4k (-1%)
    seq sync:  206.1k ±1.3k (+147%)
    rand sync: 206.1k ±1.2k (+159%)

As probably expected, little difference in the AIO case, but great
improvements in the sync cases because it kind of gives it an artificial
iodepth of 4.

"After", i.e. with four threads in QSD/FUSE (now results compared to the
above):

file:
  read:
    seq aio:   198.7k ±2.7k (+132%)
    rand aio:  317.3k ±0.6k (+243%)
    seq sync:   55.9k ±8.9k (+3%)
    rand sync:  39.1k ±0.0k (+3%)
  write:
    seq aio:   229.0k ±0.8k (+240%)
    rand aio:  227.0k ±1.3k (+235%)
    seq sync:  102.5k ±0.2k (+48%)
    rand sync: 101.7k ±0.2k (+47%)
null:
  read:
    seq aio:   584.0k ±1.5k (+242%)
    rand aio:  581.9k ±1.9k (+240%)
    seq sync:  270.6k ±0.9k (+44%)
    rand sync: 270.4k ±0.7k (+43%)
  write:
    seq aio:   598.4k ±2.0k (+212%)
    rand aio:  605.2k ±2.0k (+212%)
    seq sync:  274.0k ±0.8k (+33%)
    rand sync: 275.0k ±0.7k (+33%)

So this helps mainly for the AIO cases, but also in the null sync cases,
because null is always CPU-bound, so more threads help.

One unsolved mystery: When using a multithreaded export, running fio
with 1 job (benchmark at the top of this commit) yields better seqread
performance than doing so with 4 jobs.  Actually, with 4 jobs, it's
significantly than randread, which is quite strange.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 193 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 153 insertions(+), 40 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 162cbdacfc..6777a7651b 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -31,11 +31,13 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/block-backend.h"
+#include "system/iothread.h"
 
 #include <fuse.h>
 #include <fuse_lowlevel.h>
 
 #include "standard-headers/linux/fuse.h"
+#include <sys/ioctl.h>
 
 #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
 #include <linux/falloc.h>
@@ -119,12 +121,17 @@ QEMU_BUILD_BUG_ON(sizeof(((FuseRequestInHeaderBuf *)0)->head) +
                   sizeof(((FuseRequestInHeaderBuf *)0)->tail) !=
                   sizeof(FuseRequestInHeader));
 
-typedef struct FuseExport {
-    BlockExport common;
+typedef struct FuseExport FuseExport;
 
-    struct fuse_session *fuse_session;
-    unsigned int in_flight; /* atomic */
-    bool mounted, fd_handler_set_up;
+/*
+ * One FUSE "queue", representing one FUSE FD from which requests are fetched
+ * and processed.  Each queue is tied to an AioContext.
+ */
+typedef struct FuseQueue {
+    FuseExport *exp;
+
+    AioContext *ctx;
+    int fuse_fd;
 
     /*
      * Cached buffer to receive the data of WRITE requests.  Cached because:
@@ -141,6 +148,14 @@ typedef struct FuseExport {
      * via blk_blockalign() and thus need to be freed via qemu_vfree().
      */
     void *req_write_data_cached;
+} FuseQueue;
+
+struct FuseExport {
+    BlockExport common;
+
+    struct fuse_session *fuse_session;
+    unsigned int in_flight; /* atomic */
+    bool mounted, fd_handler_set_up;
 
     /*
      * Set when there was an unrecoverable error and no requests should be read
@@ -149,7 +164,15 @@ typedef struct FuseExport {
      */
     bool halted;
 
-    int fuse_fd;
+    int num_queues;
+    FuseQueue *queues;
+    /*
+     * True if this export should follow the generic export's AioContext.
+     * Will be false if the queues' AioContexts have been explicitly set by the
+     * user, i.e. are expected to stay in those contexts.
+     * (I.e. is always false if there is more than one queue.)
+     */
+    bool follow_aio_context;
 
     char *mountpoint;
     bool writable;
@@ -161,7 +184,7 @@ typedef struct FuseExport {
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
-} FuseExport;
+};
 
 /*
  * Verify that the size of FuseRequestInHeaderBuf.head plus the data
@@ -180,12 +203,13 @@ static void fuse_export_halt(FuseExport *exp);
 static void init_exports_table(void);
 
 static int mount_fuse_export(FuseExport *exp, Error **errp);
+static int clone_fuse_fd(int fd, Error **errp);
 
 static bool is_regular_file(const char *path, Error **errp);
 
 static void read_from_fuse_fd(void *opaque);
 static void coroutine_fn
-fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
+fuse_co_process_request(FuseQueue *q, const FuseRequestInHeader *in_hdr,
                         const void *data_buffer);
 static int fuse_write_err(int fd, const struct fuse_in_header *in_hdr, int err);
 
@@ -217,8 +241,11 @@ static void fuse_attach_handlers(FuseExport *exp)
         return;
     }
 
-    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
-                       read_from_fuse_fd, NULL, NULL, NULL, exp);
+    for (int i = 0; i < exp->num_queues; i++) {
+        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
+                           read_from_fuse_fd, NULL, NULL, NULL,
+                           &exp->queues[i]);
+    }
     exp->fd_handler_set_up = true;
 }
 
@@ -227,8 +254,10 @@ static void fuse_attach_handlers(FuseExport *exp)
  */
 static void fuse_detach_handlers(FuseExport *exp)
 {
-    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
-                       NULL, NULL, NULL, NULL, NULL);
+    for (int i = 0; i < exp->num_queues; i++) {
+        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
+                           NULL, NULL, NULL, NULL, NULL);
+    }
     exp->fd_handler_set_up = false;
 }
 
@@ -243,6 +272,11 @@ static void fuse_export_drained_end(void *opaque)
 
     /* Refresh AioContext in case it changed */
     exp->common.ctx = blk_get_aio_context(exp->common.blk);
+    if (exp->follow_aio_context) {
+        assert(exp->num_queues == 1);
+        exp->queues[0].ctx = exp->common.ctx;
+    }
+
     fuse_attach_handlers(exp);
 }
 
@@ -274,8 +308,32 @@ static int fuse_export_create(BlockExport *blk_exp,
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
 
     if (multithread) {
-        error_setg(errp, "FUSE export does not support multi-threading");
-        return -EINVAL;
+        /* Guaranteed by common export code */
+        assert(mt_count >= 1);
+
+        exp->follow_aio_context = false;
+        exp->num_queues = mt_count;
+        exp->queues = g_new(FuseQueue, mt_count);
+
+        for (size_t i = 0; i < mt_count; i++) {
+            exp->queues[i] = (FuseQueue) {
+                .exp = exp,
+                .ctx = multithread[i],
+                .fuse_fd = -1,
+            };
+        }
+    } else {
+        /* Guaranteed by common export code */
+        assert(mt_count == 0);
+
+        exp->follow_aio_context = true;
+        exp->num_queues = 1;
+        exp->queues = g_new(FuseQueue, 1);
+        exp->queues[0] = (FuseQueue) {
+            .exp = exp,
+            .ctx = exp->common.ctx,
+            .fuse_fd = -1,
+        };
     }
 
     /* For growable and writable exports, take the RESIZE permission */
@@ -287,7 +345,7 @@ static int fuse_export_create(BlockExport *blk_exp,
         ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
                            blk_shared_perm, errp);
         if (ret < 0) {
-            return ret;
+            goto fail;
         }
     }
 
@@ -363,13 +421,23 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
 
-    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
-    ret = qemu_fcntl_addfl(exp->fuse_fd, O_NONBLOCK);
+    assert(exp->num_queues >= 1);
+    exp->queues[0].fuse_fd = fuse_session_fd(exp->fuse_session);
+    ret = qemu_fcntl_addfl(exp->queues[0].fuse_fd, O_NONBLOCK);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to make FUSE FD non-blocking");
         goto fail;
     }
 
+    for (int i = 1; i < exp->num_queues; i++) {
+        int fd = clone_fuse_fd(exp->queues[0].fuse_fd, errp);
+        if (fd < 0) {
+            ret = fd;
+            goto fail;
+        }
+        exp->queues[i].fuse_fd = fd;
+    }
+
     fuse_attach_handlers(exp);
     return 0;
 
@@ -462,28 +530,28 @@ fail:
 /**
  * Allocate a buffer to receive WRITE data, or take the cached one.
  */
-static void *get_write_data_buffer(FuseExport *exp)
+static void *get_write_data_buffer(FuseQueue *q)
 {
-    if (exp->req_write_data_cached) {
-        void *cached = exp->req_write_data_cached;
-        exp->req_write_data_cached = NULL;
+    if (q->req_write_data_cached) {
+        void *cached = q->req_write_data_cached;
+        q->req_write_data_cached = NULL;
         return cached;
     } else {
-        return blk_blockalign(exp->common.blk, FUSE_MAX_WRITE_BYTES);
+        return blk_blockalign(q->exp->common.blk, FUSE_MAX_WRITE_BYTES);
     }
 }
 
 /**
  * Release a WRITE data buffer, possibly reusing it for a subsequent request.
  */
-static void release_write_data_buffer(FuseExport *exp, void **buffer)
+static void release_write_data_buffer(FuseQueue *q, void **buffer)
 {
     if (!*buffer) {
         return;
     }
 
-    if (!exp->req_write_data_cached) {
-        exp->req_write_data_cached = *buffer;
+    if (!q->req_write_data_cached) {
+        q->req_write_data_cached = *buffer;
     } else {
         qemu_vfree(*buffer);
     }
@@ -529,9 +597,42 @@ static ssize_t req_op_hdr_len(const FuseRequestInHeader *in_hdr)
     }
 }
 
+/**
+ * Clone the given /dev/fuse file descriptor, yielding a second FD from which
+ * requests can be pulled for the associated filesystem.  Returns an FD on
+ * success, and -errno on error.
+ */
+static int clone_fuse_fd(int fd, Error **errp)
+{
+    uint32_t src_fd = fd;
+    int new_fd;
+    int ret;
+
+    /*
+     * The name "/dev/fuse" is fixed, see libfuse's lib/fuse_loop_mt.c
+     * (fuse_clone_chan()).
+     */
+    new_fd = open("/dev/fuse", O_RDWR | O_CLOEXEC | O_NONBLOCK);
+    if (new_fd < 0) {
+        ret = -errno;
+        error_setg_errno(errp, errno, "Failed to open /dev/fuse");
+        return ret;
+    }
+
+    ret = ioctl(new_fd, FUSE_DEV_IOC_CLONE, &src_fd);
+    if (ret < 0) {
+        ret = -errno;
+        error_setg_errno(errp, errno, "Failed to clone FUSE FD");
+        close(new_fd);
+        return ret;
+    }
+
+    return new_fd;
+}
+
 /**
  * Try to read a single request from the FUSE FD.
- * Takes a FuseExport pointer in `opaque`.
+ * Takes a FuseQueue pointer in `opaque`.
  *
  * Assumes the export's in-flight counter has already been incremented.
  *
@@ -539,8 +640,9 @@ static ssize_t req_op_hdr_len(const FuseRequestInHeader *in_hdr)
  */
 static void coroutine_fn co_read_from_fuse_fd(void *opaque)
 {
-    FuseExport *exp = opaque;
-    int fuse_fd = exp->fuse_fd;
+    FuseQueue *q = opaque;
+    int fuse_fd = q->fuse_fd;
+    FuseExport *exp = q->exp;
     ssize_t ret;
     FuseRequestInHeaderBuf in_hdr_buf;
     const FuseRequestInHeader *in_hdr;
@@ -552,7 +654,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    data_buffer = get_write_data_buffer(exp);
+    data_buffer = get_write_data_buffer(q);
 
     /* Construct the I/O vector to hold the FUSE request */
     iov[0] = (struct iovec) { &in_hdr_buf.head, sizeof(in_hdr_buf.head) };
@@ -613,29 +715,29 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
             memcpy(in_hdr_buf.tail, data_buffer, len);
         }
 
-        release_write_data_buffer(exp, &data_buffer);
+        release_write_data_buffer(q, &data_buffer);
     }
 
-    fuse_co_process_request(exp, in_hdr, data_buffer);
+    fuse_co_process_request(q, in_hdr, data_buffer);
 
 no_request:
-    release_write_data_buffer(exp, &data_buffer);
+    release_write_data_buffer(q, &data_buffer);
     fuse_dec_in_flight(exp);
 }
 
 /**
  * Try to read and process a single request from the FUSE FD.
  * (To be used as a handler for when the FUSE FD becomes readable.)
- * Takes a FuseExport pointer in `opaque`.
+ * Takes a FuseQueue pointer in `opaque`.
  */
 static void read_from_fuse_fd(void *opaque)
 {
-    FuseExport *exp = opaque;
+    FuseQueue *q = opaque;
     Coroutine *co;
 
-    co = qemu_coroutine_create(co_read_from_fuse_fd, exp);
+    co = qemu_coroutine_create(co_read_from_fuse_fd, q);
     /* Decremented by co_read_from_fuse_fd() */
-    fuse_inc_in_flight(exp);
+    fuse_inc_in_flight(q->exp);
     qemu_coroutine_enter(co);
 }
 
@@ -660,6 +762,17 @@ static void fuse_export_delete(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
 
+    for (int i = 0; i < exp->num_queues; i++) {
+        FuseQueue *q = &exp->queues[i];
+
+        /* Queue 0's FD belongs to the FUSE session */
+        if (i > 0 && q->fuse_fd >= 0) {
+            close(q->fuse_fd);
+        }
+        qemu_vfree(q->req_write_data_cached);
+    }
+    g_free(exp->queues);
+
     if (exp->fuse_session) {
         if (exp->mounted) {
             fuse_session_unmount(exp->fuse_session);
@@ -668,7 +781,6 @@ static void fuse_export_delete(BlockExport *blk_exp)
         fuse_session_destroy(exp->fuse_session);
     }
 
-    qemu_vfree(exp->req_write_data_cached);
     g_free(exp->mountpoint);
 }
 
@@ -1373,10 +1485,11 @@ static int fuse_write_buf_response(int fd,
  * Process a FUSE request, incl. writing the response.
  */
 static void coroutine_fn
-fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
+fuse_co_process_request(FuseQueue *q, const FuseRequestInHeader *in_hdr,
                         const void *data_buffer)
 {
     FuseRequestOutHeader out_hdr;
+    FuseExport *exp = q->exp;
     /* For read requests: Data to be returned */
     void *out_data_buffer = NULL;
     ssize_t ret;
@@ -1498,10 +1611,10 @@ fuse_co_process_request(FuseExport *exp, const FuseRequestInHeader *in_hdr,
     }
 
     if (out_data_buffer) {
-        fuse_write_buf_response(exp->fuse_fd, &out_hdr.common, out_data_buffer);
+        fuse_write_buf_response(q->fuse_fd, &out_hdr.common, out_data_buffer);
         qemu_vfree(out_data_buffer);
     } else {
-        fuse_write_response(exp->fuse_fd, &out_hdr);
+        fuse_write_response(q->fuse_fd, &out_hdr);
     }
 }
 
-- 
2.53.0


