Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25C7CA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 03:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umlPc-0004bb-DM; Thu, 14 Aug 2025 23:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPb-0004b3-4I; Thu, 14 Aug 2025 23:47:27 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPY-0002tW-Q2; Thu, 14 Aug 2025 23:47:26 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-70a88db0416so16650126d6.0; 
 Thu, 14 Aug 2025 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755229643; x=1755834443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8w4Pu64unMhEvmaErPpREsaRP6ANziVJj5cm8exbtTA=;
 b=JkCPcmPqmxHgJnSGVwUIkoO4oQG4OYDp0hFvFJSJ3gLab+bTED79vE2QH6WbMFB5MI
 izSGbitCx0sKgqS9Gj316UIPHXWhDzT5+ScbbD8aHfDaxz/lcUpdI2OCh8ymWaAm7qtb
 vAU0Yyay3ZbC5xw1RsFIjSp/rL/ODifpdqHxDPf7enHPo/q3sWWqb/6UI7YMIOWsrkkj
 T/K1FY9/UXHvpE/0fPfFrFb49KJ8EyAWjOWv7ZwQi/YHw8ZEUwH9c4IAXDJXDoS8DgXh
 cWUR+Ve+eBen1UqGHS7ZkSIkt2BQvX2s8LVLx/JRW44nrjQUcAmn87WC4iPENlqxnWNR
 1jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755229643; x=1755834443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8w4Pu64unMhEvmaErPpREsaRP6ANziVJj5cm8exbtTA=;
 b=oXjM4GOQng6mZHYjIqbYgOcIuWL9vcborlmfk2BLB1w6DmVT+WB4NByP4hdi2PGX7w
 t5n80cvYxTBJ/TEWRs6+LSaxUIjg9+/jW4+HxAC/dNKhlw/Ild4acBxFLNXKYTV1LhuE
 txtT+ZBJAw46sE9cb/ml1s5ESG3XX2XbGGrDMOfWko8LEvnIDFa1bBlDgC1p02hPWCCq
 2H7G/TWsFfMPdiVAG9XhaUSMwHjZ17ExbApoK35021trvPxNjPAbb1vHZDmi+c7K68++
 mBFRdBjwNIVXUJzP0bvBZ2eNQe6OikB1scMhKPPXrrIZkA7DEiXiT0bGlULRmGf3vCK8
 IvWA==
X-Gm-Message-State: AOJu0YwQY3+S50gK4SYdVHJOXxnyhMRllCJ32Pa04VypQhyKtgUp3RiL
 YKwicbS6x2uz1whq7i7qC+v/bpd4mynsIskNbaNdh50JdK/IvK+IdTI/tozchA==
X-Gm-Gg: ASbGncthLuzmrburUQomf+hv0IxHnFN4CXATtwIUj4o9wAfXejhJn/Kfd00t1eN9hZC
 SQWsqSn0yv8tQPus9V7HCy5lwNAvmT4/w0FaUKnTo1kV1e67WDYws8w/WJQ20YXLzqCedUqgWcM
 tVVvViwBx55+bIHboNV2AHv2w9RB8fmGkhudzxopRHLi9DifpuHEp6rmMdffksDjeCyR25+Te3d
 rweyZCUb3Yvh3NbSCD6xuxXlByDIg/i7Ab3+VNcSRO0Rt5Yhvf5mkepLin7mG13c34xdSTGVRBe
 oj/wCOSlSrgpA+L/12of1oBbGoR1Mhhweq/iFhkoHgm+bEnbzCe7aPPGhRRCKj0t89gPetngjH+
 paqa44pgMufd4yfMv95nVb+mE6lDwdBaCDtMfZqV2oVWfRZ4AvyBZ/dBiN/dNgPygfJoiaCq7mc
 PieBcvLHN4FYh3
X-Google-Smtp-Source: AGHT+IFlS38TGb6HNa2vrZWfeyTf/zHiI1L9ttVM7YfEXsh+LyK9gJgdU4k1ECThWpa1SbUMAlpv2A==
X-Received: by 2002:ad4:5942:0:b0:70b:9b96:d751 with SMTP id
 6a1803df08f44-70ba7c92190mr4388816d6.44.1755229642793; 
 Thu, 14 Aug 2025 20:47:22 -0700 (PDT)
Received: from zzzhi.uwaterloo.ca
 (wn-campus-nat-129-97-124-101.dynamic.uwaterloo.ca. [129.97.124.101])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba906706esm1402346d6.17.2025.08.14.20.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 20:47:22 -0700 (PDT)
From: Zhi Song <hibriansong@gmail.com>
X-Google-Original-From: Zhi Song <hizhisong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 1/3] fuse: add FUSE-over-io_uring enable opt and init
Date: Thu, 14 Aug 2025 23:46:17 -0400
Message-ID: <20250815034619.51980-2-hizhisong@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815034619.51980-1-hizhisong@gmail.com>
References: <20250815034619.51980-1-hizhisong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Song <hibriansong@gmail.com>

This patch adds a new export option for storage-export-daemon to enable
or disable FUSE-over-io_uring via the switch io-uring=on|off (disable
by default). It also implements the protocol handshake with the Linux
kernel during the FUSE-over-io_uring initialization phase.

See: https://docs.kernel.org/filesystems/fuse-io-uring.html

The kernel documentation describes in detail how FUSE-over-io_uring
works. This patch implements the Initial SQE stage shown in thediagram:
it initializes one queue per IOThread, each currently supporting a
single submission queue entry (SQE). When the FUSE driver sends the
first FUSE request (FUSE_INIT), storage-export-daemon calls
fuse_uring_start() to complete initialization, ultimately submitting
the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
successful initialization with the kernel.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c                  | 161 ++++++++++++++++++++++++---
 docs/tools/qemu-storage-daemon.rst   |  11 +-
 qapi/block-export.json               |   5 +-
 storage-daemon/qemu-storage-daemon.c |   1 +
 util/fdmon-io_uring.c                |   5 +-
 5 files changed, 159 insertions(+), 24 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c0ad4696ce..59fa79f486 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -48,6 +48,11 @@
 #include <linux/fs.h>
 #endif

+#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
+
+/* room needed in buffer to accommodate header */
+#define FUSE_BUFFER_HEADER_SIZE 0x1000
+
 /* Prevent overly long bounce buffer allocations */
 #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 /*
@@ -63,12 +68,31 @@
     (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)

 typedef struct FuseExport FuseExport;
+typedef struct FuseQueue FuseQueue;
+
+typedef struct FuseRingEnt {
+    /* back pointer */
+    FuseQueue *q;
+
+    /* commit id of a fuse request */
+    uint64_t req_commit_id;
+
+    /* fuse request header and payload */
+    struct fuse_uring_req_header req_header;
+    void *op_payload;
+    size_t req_payload_sz;
+
+    /* The vector passed to the kernel */
+    struct iovec iov[2];
+
+    CqeHandler fuse_cqe_handler;
+} FuseRingEnt;

 /*
  * One FUSE "queue", representing one FUSE FD from which requests are fetched
  * and processed.  Each queue is tied to an AioContext.
  */
-typedef struct FuseQueue {
+struct FuseQueue {
     FuseExport *exp;

     AioContext *ctx;
@@ -109,7 +133,12 @@ typedef struct FuseQueue {
      * Free this buffer with qemu_vfree().
      */
     void *spillover_buf;
-} FuseQueue;
+
+#ifdef CONFIG_LINUX_IO_URING
+    int qid;
+    FuseRingEnt ent;
+#endif
+};

 /*
  * Verify that FuseQueue.request_buf plus the spill-over buffer together
@@ -148,6 +177,7 @@ struct FuseExport {
     bool growable;
     /* Whether allow_other was used as a mount option or not */
     bool allow_other;
+    bool is_uring;

     mode_t st_mode;
     uid_t st_uid;
@@ -257,6 +287,93 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
     .drained_poll  = fuse_export_drained_poll,
 };

+#ifdef CONFIG_LINUX_IO_URING
+
+static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
+                    const unsigned int qid,
+                    const unsigned int commit_id)
+{
+    req->qid = qid;
+    req->commit_id = commit_id;
+    req->flags = 0;
+}
+
+static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
+               __u32 cmd_op)
+{
+    sqe->opcode = IORING_OP_URING_CMD;
+
+    sqe->fd = q->fuse_fd;
+    sqe->rw_flags = 0;
+    sqe->ioprio = 0;
+    sqe->off = 0;
+
+    sqe->cmd_op = cmd_op;
+    sqe->__pad1 = 0;
+}
+
+static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
+{
+    FuseQueue *q = opaque;
+    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
+
+    fuse_uring_sqe_prepare(sqe, q, FUSE_IO_URING_CMD_REGISTER);
+
+    sqe->addr = (uint64_t)(q->ent.iov);
+    sqe->len = 2;
+
+    fuse_uring_sqe_set_req_data(req, q->qid, 0);
+}
+
+static void fuse_uring_submit_register(void *opaque)
+{
+    FuseQueue *q = opaque;
+    FuseExport *exp = q->exp;
+
+
+    aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q->ent.fuse_cqe_handler));
+}
+
+static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
+{
+    /*
+     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
+     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is set by
+     * the kernel by default. Also, max_write should not exceed
+     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
+     */
+    size_t bufsize = out->max_write + FUSE_BUFFER_HEADER_SIZE;
+
+    if (!(out->flags & FUSE_MAX_PAGES)) {
+        bufsize = FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page_size()
+                         + FUSE_BUFFER_HEADER_SIZE;
+    }
+
+    for (int i = 0; i < exp->num_queues; i++) {
+        FuseQueue *q = &exp->queues[i];
+        FuseRingEnt *ent = &q->ent;
+
+        ent->q = q;
+
+        ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
+        ent->op_payload = g_malloc0(ent->req_payload_sz);
+
+        ent->iov[0] = (struct iovec) {
+            &(ent->req_header),
+            sizeof(struct fuse_uring_req_header)
+        };
+        ent->iov[1] = (struct iovec) {
+            ent->op_payload,
+            ent->req_payload_sz
+        };
+
+        ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
+
+        aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_register, q);
+    }
+}
+#endif
+
 static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
                               AioContext *const *multithread,
@@ -280,6 +397,9 @@ static int fuse_export_create(BlockExport *blk_exp,

         for (size_t i = 0; i < mt_count; i++) {
             exp->queues[i] = (FuseQueue) {
+#ifdef CONFIG_LINUX_IO_URING
+                .qid = i,
+#endif
                 .exp = exp,
                 .ctx = multithread[i],
                 .fuse_fd = -1,
@@ -293,6 +413,9 @@ static int fuse_export_create(BlockExport *blk_exp,
         exp->num_queues = 1;
         exp->queues = g_new(FuseQueue, 1);
         exp->queues[0] = (FuseQueue) {
+#ifdef CONFIG_LINUX_IO_URING
+            .qid = 0,
+#endif
             .exp = exp,
             .ctx = exp->common.ctx,
             .fuse_fd = -1,
@@ -312,6 +435,8 @@ static int fuse_export_create(BlockExport *blk_exp,
         }
     }

+    exp->is_uring = args->io_uring ? true : false;
+
     blk_set_dev_ops(exp->common.blk, &fuse_export_blk_dev_ops, exp);

     /*
@@ -687,15 +812,22 @@ static ssize_t coroutine_fn
 fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
              uint32_t max_readahead, uint32_t flags)
 {
-    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO
+                                     | FUSE_INIT_EXT;
+    uint64_t outargflags = flags;
+
+#ifdef CONFIG_LINUX_IO_URING
+    if (exp->is_uring)
+        outargflags |= FUSE_OVER_IO_URING;
+#endif

     *out = (struct fuse_init_out) {
         .major = FUSE_KERNEL_VERSION,
         .minor = FUSE_KERNEL_MINOR_VERSION,
         .max_readahead = max_readahead,
         .max_write = FUSE_MAX_WRITE_BYTES,
-        .flags = flags & supported_flags,
-        .flags2 = 0,
+        .flags = outargflags & supported_flags,
+        .flags2 = outargflags >> 32,

         /* libfuse maximum: 2^16 - 1 */
         .max_background = UINT16_MAX,
@@ -1393,22 +1525,17 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
     struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
     /* For read requests: Data to be returned */
     void *out_data_buffer = NULL;
-    ssize_t ret;

-    /* Limit scope to ensure pointer is no longer used after yielding */
-    {
-        const struct fuse_in_header *in_hdr =
-            (const struct fuse_in_header *)q->request_buf;
-
-        opcode = in_hdr->opcode;
-        req_id = in_hdr->unique;
-    }
+    bool is_uring = exp->is_uring;

     switch (opcode) {
     case FUSE_INIT: {
-        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, q);
-        ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
-                           in->max_readahead, in->flags);
+#ifdef CONFIG_LINUX_IO_URING
+        /* FUSE-over-io_uring enabled && start from the tradition path */
+        if (is_uring) {
+            fuse_uring_start(exp, out);
+        }
+#endif
         break;
     }

diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
index 35ab2d7807..c5076101e0 100644
--- a/docs/tools/qemu-storage-daemon.rst
+++ b/docs/tools/qemu-storage-daemon.rst
@@ -78,7 +78,7 @@ Standard options:
 .. option:: --export [type=]nbd,id=<id>,node-name=<node-name>[,name=<export-name>][,writable=on|off][,bitmap=<name>]
   --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=unix,addr.path=<socket-path>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
   --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=fd,addr.str=<fd>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
-  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto]
+  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto][,io-uring=on|off]
   --export [type=]vduse-blk,id=<id>,node-name=<node-name>,name=<vduse-name>[,writable=on|off][,num-queues=<num-queues>][,queue-size=<queue-size>][,logical-block-size=<block-size>][,serial=<serial-number>]

   is a block export definition. ``node-name`` is the block node that should be
@@ -111,10 +111,11 @@ Standard options:
   that enabling this option as a non-root user requires enabling the
   user_allow_other option in the global fuse.conf configuration file.  Setting
   ``allow-other`` to auto (the default) will try enabling this option, and on
-  error fall back to disabling it.
-
-  The ``vduse-blk`` export type takes a ``name`` (must be unique across the host)
-  to create the VDUSE device.
+  error fall back to disabling it. Once ``io-uring`` is enabled (off by default),
+  the FUSE-over-io_uring-related settings will be initialized to bypass the
+  traditional /dev/fuse communication mechanism and instead use io_uring to
+  handle FUSE operations. The ``vduse-blk`` export type takes a ``name``
+  (must be unique across the host) to create the VDUSE device.
   ``num-queues`` sets the number of virtqueues (the default is 1).
   ``queue-size`` sets the virtqueue descriptor table size (the default is 256).

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 9ae703ad01..37f2fc47e2 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -184,12 +184,15 @@
 #     mount the export with allow_other, and if that fails, try again
 #     without.  (since 6.1; default: auto)
 #
+# @io-uring: Use FUSE-over-io-uring.  (since 10.2; default: false)
+#
 # Since: 6.0
 ##
 { 'struct': 'BlockExportOptionsFuse',
   'data': { 'mountpoint': 'str',
             '*growable': 'bool',
-            '*allow-other': 'FuseExportAllowOther' },
+            '*allow-other': 'FuseExportAllowOther',
+            '*io-uring': 'bool' },
   'if': 'CONFIG_FUSE' }

 ##
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index eb72561358..0cd4cd2b58 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -107,6 +107,7 @@ static void help(void)
 #ifdef CONFIG_FUSE
 "  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>\n"
 "           [,growable=on|off][,writable=on|off][,allow-other=on|off|auto]\n"
+"           [,io-uring=on|off]"
 "                         export the specified block node over FUSE\n"
 "\n"
 #endif /* CONFIG_FUSE */
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index d2433d1d99..68d3fe8e01 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -452,10 +452,13 @@ static const FDMonOps fdmon_io_uring_ops = {
 void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
     int ret;
+    int flags;

     ctx->io_uring_fd_tag = NULL;
+    flags = IORING_SETUP_SQE128;

-    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
+    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES,
+                            &ctx->fdmon_io_uring, flags);
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Failed to initialize io_uring");
         return;
--
2.45.2


