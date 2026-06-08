Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286CECD8CAB
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdDE-00017u-8U; Mon, 08 Jun 2026 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdDB-000161-LJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdD9-0007RK-Jn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780937547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDiqQrC3nUP4exfyx8PeHDHHKOZJHe0VpF/uyZDrUlA=;
 b=Ni/nfsT9nBEslXqIaxAliw8yXks5VhDQoU3FnY9vJOKZ6oQUP4zcqkGNHQdKmHXVhrsp52
 oKUWB0/JqS5pyKjh/a48OM9o9pLPz+I/dzyvXb4NEe+zfqiLhOEJDseflaJLOFKEfsNGrL
 H8SvlONufW3pq5vDsgIjmDh4/bO39DY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-kchEgXYeNt6xPA-ESevHSQ-1; Mon,
 08 Jun 2026 12:52:22 -0400
X-MC-Unique: kchEgXYeNt6xPA-ESevHSQ-1
X-Mimecast-MFC-AGG-ID: kchEgXYeNt6xPA-ESevHSQ_1780937541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACF3519560BC; Mon,  8 Jun 2026 16:52:21 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.50.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5030D19540CD; Mon,  8 Jun 2026 16:52:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 5/8] block/export/fuse: use struct fuse_init_in
Date: Mon,  8 Jun 2026 18:52:04 +0200
Message-ID: <20260608165207.307488-6-kwolf@redhat.com>
In-Reply-To: <20260608165207.307488-1-kwolf@redhat.com>
References: <20260608165207.307488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

The code is switched to use the current 'struct fuse_init_in' in
preparation to use the FUSE_DIRECT_IO_ALLOW_MMAP feature, which is
part of the flags2 member that got added in protocol version 5.36.

To not break compatibility with older kernels, the check for whether
the full header of an operation was read in co_read_from_fuse_fd()
needs to be adapted. In particular, for a FUSE_INIT operation, the
protocol version must be considered, because the length of the header
changed with protocol version 7.36. Always using the length of the
old, shorter struct was inaccurate, since for newer protocol versions
this might mean accepting a truncated read for FUSE_INIT.

Users of the init header that want to use parts of the extended
structure must check with the using_old_fuse_init_in() helper function
if they may do so.

Cc: qemu-stable@nongnu.org
Fixes: a94a1d7699 ("fuse: Manually process requests (without libfuse)")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260506145424.10249-2-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 56 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index a2a478d2934..35218e31976 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -51,23 +51,16 @@
 #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 #define FUSE_MAX_WRITE_BYTES (64 * 1024)
 
-/*
- * fuse_init_in structure before 7.36.  We don't need the flags2 field added
- * there, so we can work with the smaller older structure to stay compatible
- * with older kernels.
- */
-struct fuse_init_in_compat {
-    uint32_t major;
-    uint32_t minor;
-    uint32_t max_readahead;
-    uint32_t flags;
-};
-
 typedef struct FuseRequestInHeader {
     struct fuse_in_header common;
     /* All supported requests */
     union {
-        struct fuse_init_in_compat init;
+        /*
+         * When using_old_fuse_init_in() is true, then the smaller older struct
+         * is used by the kernel. The flags2 member and other new members must
+         * be treated as absent then.
+         */
+        struct fuse_init_in init;
         struct fuse_open_in open;
         struct fuse_setattr_in setattr;
         struct fuse_read_in read;
@@ -629,6 +622,16 @@ static int clone_fuse_fd(int fd, Error **errp)
     return new_fd;
 }
 
+/**
+ * Check whether the smaller older fuse_init_in structure from before protocol
+ * version 7.36 is used. The flags2 member and other new members must be treated
+ * as absent then.
+ */
+static bool using_old_fuse_init_in(const struct fuse_init_in *in)
+{
+    return in->major < 7 || (in->major == 7 && in->minor < 36);
+}
+
 /**
  * Try to read a single request from the FUSE FD.
  * Takes a FuseQueue pointer in `opaque`.
@@ -693,6 +696,31 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
+    /*
+     * If the request is of type FUSE_INIT, need to check the version to
+     * actually determine the length of the fuse_init_in structure used by the
+     * kernel. In protocol version 7.36, the structure was extended.
+     */
+    if (in_hdr->common.opcode == FUSE_INIT) {
+        /* Length of the fuse_init_in structure before 7.36. */
+        size_t old_init_hdr_len = 16;
+
+        /*
+         * Expect at least the size of the smaller older structure to ensure the
+         * version can be checked.
+         */
+        if (unlikely(ret < sizeof(in_hdr->common) + old_init_hdr_len)) {
+            error_report("FUSE_INIT request truncated, read only %zi bytes",
+                         ret);
+            fuse_write_err(fuse_fd, &in_hdr->common, -EINVAL);
+            goto no_request;
+        }
+
+        if (using_old_fuse_init_in(&in_hdr->init)) {
+            op_hdr_len = old_init_hdr_len;
+        }
+    }
+
     if (unlikely(ret < sizeof(in_hdr->common) + op_hdr_len)) {
         error_report("FUSE request truncated, expected %zu bytes, read %zi "
                      "bytes",
@@ -826,7 +854,7 @@ static bool is_regular_file(const char *path, Error **errp)
  */
 static ssize_t coroutine_fn GRAPH_RDLOCK
 fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
-             const struct fuse_init_in_compat *in)
+             const struct fuse_init_in *in)
 {
     const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
 
-- 
2.54.0


