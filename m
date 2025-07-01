Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1440DC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZRd-0005xJ-10; Tue, 01 Jul 2025 07:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQr-0005bb-B7
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQo-0003e1-BY
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=acljPY5jE8NaIoOEBBfWfxcfowfW4u2TZybdI7SjzQk=;
 b=KGpV9V2zThj0x59r2ujTbAp6vE5YBZ9TxwvdihxuQnHnUqBAekwQuKJiXF2l6PUIynb+hR
 6HwBN/PqYhLPttlqgnX5DVyOSXFd65bsHaBSkg+1vnl2W8P6tJ+CizR3zBpFZ+xPTrljNK
 eolA/Yq5USQzqYL+Msbb9FNHq8rvx80=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-rIGS4-ZiPhyA7EDY41A7jQ-1; Tue, 01 Jul 2025 07:45:44 -0400
X-MC-Unique: rIGS4-ZiPhyA7EDY41A7jQ-1
X-Mimecast-MFC-AGG-ID: rIGS4-ZiPhyA7EDY41A7jQ_1751370343
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso2024471f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370342; x=1751975142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acljPY5jE8NaIoOEBBfWfxcfowfW4u2TZybdI7SjzQk=;
 b=uu1OxSya/+jnWnt1mkO+RyYWJ/jiuooKAdWlbFoSPata4kd8f7l1lcBiafl0OFjXP0
 ImPnudj/cid+tp4Rzac4raeoAQ2zLzp2HDmlAjHqBjUn9CzwKvA2sws+wSvwWR7fRibT
 y9MS28PNLc8ppven2jcVRiXiBV+oaOgCQIsl56FWWukNBRGX0EKx+ixsZHEJjj5o++fW
 qhnpBdPLF/Pl6zL9cH3NnXFP8K0BgxsCrhg5nSgtGxjuGrztH8gTRynuz52RKkZZapXd
 JBtvMllpz4zqhbR457X8L6SBPlFaNbNXXK1fz16KXZg1QNgbM8ouaK2xyTRmk0wLWIYv
 /4wg==
X-Gm-Message-State: AOJu0YxOcih6E1n1EHkFKc5Qipe+D9hTcK0lLhe21HG0S8cD4k4F73pt
 AkTmGd+ODxGuX5jSouYwapWnqCnpFXxe9zSPtncRHL+NPIpT29pgpm6YA8/QZMjDIYLoQ0JAXAK
 H0PEHUguKf/9pyDvvMqu4k41GXA4rqZ7bUd8GIdggcBX6D8CMWAAAn4my7r1FaXWF
X-Gm-Gg: ASbGncs8HlXONFeHOZ9aYiatO9M87txmx8xujTovfbgEQjsi/ZcC9aENTQUQFduqpMT
 1tp7RGmK3jiI9emWa5OXRNc7WkDeZovWtDekJcOgm7jOjYUsoItRLK6IhL1UsYxIrNoNquNipX7
 qyD0XaD4dmuBaA1gMsQc1G2jzT52YCvdX+6EhZEsaYu/OyJFv0oiJ2HsBTioHOQieIaIieEljbT
 PDOealPWgUkVDawxouY3jHNd6ITR8sk07FIRSoMEcEQf5DEG0U69R+FwagznfzmO2M+lB8P2PJh
 1hstLXdTFKNFjZIcLl0Jvhgn/AJPRqqoooDM5qgo5qpDhEKzpRJzknuvDso3savLbS4UnoQ+Qrg
 9GfJd
X-Received: by 2002:a05:6000:2082:b0:3a5:2875:f985 with SMTP id
 ffacd0b85a97d-3a90066afb5mr15342907f8f.59.1751370341879; 
 Tue, 01 Jul 2025 04:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgV6NbBG7RkeUHZCua1hWta0uG/lP3mR2xcBuXtMzAa0rG3dRcGlDTO+5mHlI8iL14ldrtnA==
X-Received: by 2002:a05:6000:2082:b0:3a5:2875:f985 with SMTP id
 ffacd0b85a97d-3a90066afb5mr15342871f8f.59.1751370341237; 
 Tue, 01 Jul 2025 04:45:41 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fadf3sm13256625f8f.34.2025.07.01.04.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:39 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 18/21] fuse: Implement multi-threading
Date: Tue,  1 Jul 2025 13:44:34 +0200
Message-ID: <20250701114437.207419-19-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
    seq aio:   264.8k ±0.8k (+120 %)
    rand aio:  143.8k ±0.4k (+ 27 %)
    seq sync:   49.9k ±0.5k (-  5 %)
    rand sync:  10.3k ±0.1k (-  1 %)
  write:
    seq aio:   226.6k ±2.1k (+184 %)
    rand aio:  225.9k ±1.8k (+186 %)
    seq sync:   36.9k ±0.6k (- 11 %)
    rand sync:  36.9k ±0.2k (- 11 %)
null:
  read:
    seq aio:   315.2k ±11.0k (+18 %)
    rand aio:  300.5k ±10.8k (+14 %)
    seq sync:  114.2k ± 3.6k (-16 %)
    rand sync: 112.5k ± 2.8k (-16 %)
  write:
    seq aio:   222.6k ±6.8k (-21 %)
    rand aio:  220.5k ±6.8k (-23 %)
    seq sync:  117.2k ±3.7k (-18 %)
    rand sync: 116.3k ±4.4k (-18 %)

(I don't know what's going on in the null-write AIO case, sorry.)

Here's results for numjobs=4:

"Before", i.e. without multithreading in QSD/FUSE (results compared to
numjobs=1):

file:
  read:
    seq aio:   104.7k ± 0.4k (- 13 %)
    rand aio:  111.5k ± 0.4k (-  2 %)
    seq sync:   71.0k ±13.8k (+ 36 %)
    rand sync:  41.4k ± 0.1k (+297 %)
  write:
    seq aio:    79.4k ±0.1k (-  1 %)
    rand aio:   78.6k ±0.1k (±  0 %)
    seq sync:   83.3k ±0.1k (+101 %)
    rand sync:  82.0k ±0.2k (+ 98 %)
null:
  read:
    seq aio:   260.5k ±1.5k (-  2 %)
    rand aio:  260.1k ±1.4k (-  2 %)
    seq sync:  291.8k ±1.3k (+115 %)
    rand sync: 280.1k ±1.7k (+115 %)
  write:
    seq aio:   280.1k ±1.7k (±  0 %)
    rand aio:  279.5k ±1.4k (-  3 %)
    seq sync:  306.7k ±2.2k (+116 %)
    rand sync: 305.9k ±1.8k (+117 %)

(As probably expected, little difference in the AIO case, but great
improvements in the sync case because it kind of gives it an artificial
iodepth of 4.)

"After", i.e. with four threads in QSD/FUSE (now results compared to the
above):

file:
  read:
    seq aio:   193.3k ± 1.8k (+ 85 %)
    rand aio:  329.3k ± 0.3k (+195 %)
    seq sync:   66.2k ±13.0k (-  7 %)
    rand sync:  40.1k ± 0.0k (-  3 %)
  write:
    seq aio:   219.7k ±0.8k (+177 %)
    rand aio:  217.2k ±1.5k (+176 %)
    seq sync:   92.5k ±0.2k (+ 11 %)
    rand sync:  91.9k ±0.2k (+ 12 %)
null:
  read:
    seq aio:   706.7k ±2.1k (+171 %)
    rand aio:  714.7k ±3.2k (+175 %)
    seq sync:  431.7k ±3.0k (+ 48 %)
    rand sync: 435.4k ±2.8k (+ 50 %)
  write:
    seq aio:   746.9k ±2.8k (+167 %)
    rand aio:  749.0k ±4.9k (+168 %)
    seq sync:  420.7k ±3.1k (+ 37 %)
    rand sync: 419.1k ±2.5k (+ 37 %)

So this helps mainly for the AIO cases, but also in the null sync cases,
because null is always CPU-bound, so more threads help.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 205 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 159 insertions(+), 46 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 0e3fa028d3..4ae448bc14 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -31,11 +31,14 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "system/block-backend.h"
+#include "system/block-backend.h"
+#include "system/iothread.h"
 
 #include <fuse.h>
 #include <fuse_lowlevel.h>
 
 #include "standard-headers/linux/fuse.h"
+#include <sys/ioctl.h>
 
 #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
 #include <linux/falloc.h>
@@ -50,12 +53,17 @@
 /* Small enough to fit in the request buffer */
 #define FUSE_MAX_WRITE_BYTES (4 * 1024)
 
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
      * The request buffer must be able to hold a full write, and/or at least
@@ -66,6 +74,14 @@ typedef struct FuseExport {
              FUSE_MAX_WRITE_BYTES,
         FUSE_MIN_READ_BUFFER
     )];
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
@@ -74,7 +90,15 @@ typedef struct FuseExport {
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
@@ -85,11 +109,11 @@ typedef struct FuseExport {
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
-} FuseExport;
+};
 
 /* Parameters to the request processing coroutine */
 typedef struct FuseRequestCoParam {
-    FuseExport *exp;
+    FuseQueue *q;
     int got_request;
 } FuseRequestCoParam;
 
@@ -102,11 +126,12 @@ static void fuse_export_halt(FuseExport *exp);
 static void init_exports_table(void);
 
 static int mount_fuse_export(FuseExport *exp, Error **errp);
+static int clone_fuse_fd(int fd, Error **errp);
 
 static bool is_regular_file(const char *path, Error **errp);
 
 static void read_from_fuse_fd(void *opaque);
-static void coroutine_fn fuse_co_process_request(FuseExport *exp);
+static void coroutine_fn fuse_co_process_request(FuseQueue *q);
 
 static void fuse_inc_in_flight(FuseExport *exp)
 {
@@ -136,8 +161,11 @@ static void fuse_attach_handlers(FuseExport *exp)
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
 
@@ -146,8 +174,10 @@ static void fuse_attach_handlers(FuseExport *exp)
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
 
@@ -162,6 +192,11 @@ static void fuse_export_drained_end(void *opaque)
 
     /* Refresh AioContext in case it changed */
     exp->common.ctx = blk_get_aio_context(exp->common.blk);
+    if (exp->follow_aio_context) {
+        assert(exp->num_queues == 1);
+        exp->queues[0].ctx = exp->common.ctx;
+    }
+
     fuse_attach_handlers(exp);
 }
 
@@ -192,8 +227,32 @@ static int fuse_export_create(BlockExport *blk_exp,
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
@@ -280,13 +339,23 @@ static int fuse_export_create(BlockExport *blk_exp,
 
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
 
@@ -359,9 +428,42 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     return 0;
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
@@ -369,8 +471,9 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
  */
 static void coroutine_fn co_read_from_fuse_fd(void *opaque)
 {
-    FuseExport *exp = opaque;
-    int fuse_fd = exp->fuse_fd;
+    FuseQueue *q = opaque;
+    int fuse_fd = q->fuse_fd;
+    FuseExport *exp = q->exp;
     ssize_t ret;
     const struct fuse_in_header *in_hdr;
 
@@ -378,8 +481,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    ret = RETRY_ON_EINTR(read(fuse_fd, exp->request_buf,
-                              sizeof(exp->request_buf)));
+    ret = RETRY_ON_EINTR(read(fuse_fd, q->request_buf, sizeof(q->request_buf)));
     if (ret < 0 && errno == EAGAIN) {
         /* No request available */
         goto no_request;
@@ -397,7 +499,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    in_hdr = (const struct fuse_in_header *)exp->request_buf;
+    in_hdr = (const struct fuse_in_header *)q->request_buf;
     if (unlikely(ret != in_hdr->len)) {
         error_report("Number of bytes read from FUSE device does not match "
                      "request size, expected %" PRIu32 " bytes, read %zi "
@@ -408,7 +510,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
-    fuse_co_process_request(exp);
+    fuse_co_process_request(q);
 
 no_request:
     fuse_dec_in_flight(exp);
@@ -417,16 +519,16 @@ no_request:
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
 
@@ -451,6 +553,16 @@ static void fuse_export_delete(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
 
+    for (int i = 0; i < exp->num_queues; i++) {
+        FuseQueue *q = &exp->queues[i];
+
+        /* Queue 0's FD belongs to the FUSE session */
+        if (i > 0 && q->fuse_fd >= 0) {
+            close(q->fuse_fd);
+        }
+    }
+    g_free(exp->queues);
+
     if (exp->fuse_session) {
         if (exp->mounted) {
             fuse_session_unmount(exp->fuse_session);
@@ -1108,23 +1220,23 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
 /*
  * For use in fuse_co_process_request():
  * Returns a pointer to the parameter object for the given operation (inside of
- * export->request_buf, which is assumed to hold a fuse_in_header first).
- * Verifies that the object is complete (export->request_buf is large enough to
+ * queue->request_buf, which is assumed to hold a fuse_in_header first).
+ * Verifies that the object is complete (queue->request_buf is large enough to
  * hold it in one piece, and the request length includes the whole object).
  *
- * Note that export->request_buf may be overwritten after yielding, so the
+ * Note that queue->request_buf may be overwritten after yielding, so the
  * returned pointer must not be used across a function that may yield!
  */
-#define FUSE_IN_OP_STRUCT(op_name, export) \
+#define FUSE_IN_OP_STRUCT(op_name, queue) \
     ({ \
         const struct fuse_in_header *__in_hdr = \
-            (const struct fuse_in_header *)(export)->request_buf; \
+            (const struct fuse_in_header *)(queue)->request_buf; \
         const struct fuse_##op_name##_in *__in = \
             (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
         const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
         uint32_t __req_len; \
         \
-        QEMU_BUILD_BUG_ON(sizeof((export)->request_buf) < __param_len); \
+        QEMU_BUILD_BUG_ON(sizeof((queue)->request_buf) < __param_len); \
         \
         __req_len = __in_hdr->len; \
         if (__req_len < __param_len) { \
@@ -1161,11 +1273,12 @@ static int fuse_write_buf_response(int fd, uint32_t req_id,
  * Process a FUSE request, incl. writing the response.
  *
  * Note that yielding in any request-processing function can overwrite the
- * contents of exp->request_buf.  Anything that takes a buffer needs to take
+ * contents of q->request_buf.  Anything that takes a buffer needs to take
  * care that the content is copied before yielding.
  */
-static void coroutine_fn fuse_co_process_request(FuseExport *exp)
+static void coroutine_fn fuse_co_process_request(FuseQueue *q)
 {
+    FuseExport *exp = q->exp;
     uint32_t opcode;
     uint64_t req_id;
     /*
@@ -1188,7 +1301,7 @@ static void coroutine_fn fuse_co_process_request(FuseExport *exp)
     /* Limit scope to ensure pointer is no longer used after yielding */
     {
         const struct fuse_in_header *in_hdr =
-            (const struct fuse_in_header *)exp->request_buf;
+            (const struct fuse_in_header *)q->request_buf;
 
         opcode = in_hdr->opcode;
         req_id = in_hdr->unique;
@@ -1196,7 +1309,7 @@ static void coroutine_fn fuse_co_process_request(FuseExport *exp)
 
     switch (opcode) {
     case FUSE_INIT: {
-        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, exp);
+        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, q);
         ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
                            in->max_readahead, in->flags);
         break;
@@ -1219,23 +1332,23 @@ static void coroutine_fn fuse_co_process_request(FuseExport *exp)
         break;
 
     case FUSE_SETATTR: {
-        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, exp);
+        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, q);
         ret = fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
                               in->valid, in->size, in->mode, in->uid, in->gid);
         break;
     }
 
     case FUSE_READ: {
-        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, exp);
+        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, q);
         ret = fuse_co_read(exp, &out_data_buffer, in->offset, in->size);
         break;
     }
 
     case FUSE_WRITE: {
-        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, exp);
+        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, q);
         uint32_t req_len;
 
-        req_len = ((const struct fuse_in_header *)exp->request_buf)->len;
+        req_len = ((const struct fuse_in_header *)q->request_buf)->len;
         if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
                                in->size)) {
             warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
@@ -1264,7 +1377,7 @@ static void coroutine_fn fuse_co_process_request(FuseExport *exp)
     }
 
     case FUSE_FALLOCATE: {
-        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, exp);
+        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, q);
         ret = fuse_co_fallocate(exp, in->offset, in->length, in->mode);
         break;
     }
@@ -1279,7 +1392,7 @@ static void coroutine_fn fuse_co_process_request(FuseExport *exp)
 
 #ifdef CONFIG_FUSE_LSEEK
     case FUSE_LSEEK: {
-        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, exp);
+        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, q);
         ret = fuse_co_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
                             in->offset, in->whence);
         break;
@@ -1293,11 +1406,11 @@ static void coroutine_fn fuse_co_process_request(FuseExport *exp)
     /* Ignore errors from fuse_write*(), nothing we can do anyway */
     if (out_data_buffer) {
         assert(ret >= 0);
-        fuse_write_buf_response(exp->fuse_fd, req_id, out_hdr,
+        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
                                 out_data_buffer, ret);
         qemu_vfree(out_data_buffer);
     } else {
-        fuse_write_response(exp->fuse_fd, req_id, out_hdr,
+        fuse_write_response(q->fuse_fd, req_id, out_hdr,
                             ret < 0 ? ret : 0,
                             ret < 0 ? 0 : ret);
     }
-- 
2.49.0


