Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBBAF459EE
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQW-00079K-N6; Fri, 10 Apr 2026 11:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQV-00078M-EF
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:43 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQT-0002XR-MT
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:43 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c76eea1672aso798083a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833540; x=1776438340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZF3Zfhgg1+dMZbKh+1FfG0J0Eo/81Bufn7es25E8QL8=;
 b=Jpj2arBbdkkXMQ37iSs19A3axuxn67y6YIqvu04KfxDs2Lo2LYYrs9JdkhemKVlap4
 sFPlGsZubmRZdJLbUYTgj+GDPPEYWdggpnvVGKzDZ8JPoXHd9frNPp3VkDCjtXnoh89m
 VaOmUoK0bWZXre3xHx9fntVmuqI1A+S3H7lFOY9LdOkP6Im3uoNAHS2inmlRXKkK/PVN
 MJl89wMtEgc2dF4y4zytlpk7iOLkR+NSm1Ls1GFFG0cpyjYqsq++1BN3laBNHbgkXF8f
 dlwoyICqZzG5KdIDJTH683fTmoch641cj9KuBifaHhevuILIQSJqCwK4sgm/BmF9P4Iw
 zzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833540; x=1776438340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZF3Zfhgg1+dMZbKh+1FfG0J0Eo/81Bufn7es25E8QL8=;
 b=d87e+Q1XqkHgJ8H6TIxr0MQsnkOJeBCGg4I5a5fPrApKp99g05WDKMfYTEh4osChsY
 /urCYz/N5+yINYsXiaPQf4v8xsGu5wAVAPZQUnseSftR7HMIFHJ+2GvkJw6McZHD1d+f
 fsskqtAt4FbfglGJcQTZ4DSoKBmYUtlqeMPH4MZ5n1SmHACnNaDmA9PLa7Ha6n2EuOxM
 GEBLYlIE+Zmg/J+iP0v2QuhZTmIXE1hT23t5PyK8efKo5B7W04uvpt4tGtPVBoFFE9pS
 I69YfHvG7Hwy/4WmQz38hVDoTGW/XC+JzmTD/20HXMhoxJeZnZPTJcYjdMtCH8G/zNY+
 /yVA==
X-Gm-Message-State: AOJu0YzK1aG7rIFTAeetPYGfzM8I0TCTn+5ao9DC0VtjZd0LS5cSkSix
 yHTE6lqdHxEK4saLPxF4lAhROJQomKgrT2+ZR3qS4gKn+W1SCDGzu2e2To9x3koQ
X-Gm-Gg: AeBDievSr15qzo3u2FhgaJ/oljyP07y0Be3zadxdioqT86Ax3gxtsl/qfRfjU5QpP0a
 XdVSnfbFTiWsSla5pqwWUMeFAJjdziXrIfrWNBP/KmYVU6xHqNZo7izDCAIRCB0LLy6zm67PjQ/
 wfjp//2SpKz2GfSIeaQgaSktU6Ih9LKFx3whtcjVijA6p8KKEmcWLhDmH0nz4KGVyP7OO55C2gf
 m0bUjMJo0ykMt2XQZsQF3Q/IQYC3zGoQW5RqTf2d91b4g/faQda+XsiUdub8PFT43vkKxwnldOg
 Z51aOvEdtlwho6x2QTTLXiwMY5kJFel77XJNMJFPZgKm2xjHOBvksPF6qcpo/qMiMPSHNODLUZF
 szBxdYdw/mjyJtCTGCO5f09cdJ2eacLKv9twm6gp8KU9baEADa03irtiH0fnfhwzLzmt8BTTD10
 SdBN8okSBUhfyMd3gNhmuY8oxlgLTMltA/fgX3M1Iv+gsdZiPxvqh1
X-Received: by 2002:a17:90b:3950:b0:35e:30bc:804d with SMTP id
 98e67ed59e1d1-35e42846535mr3353354a91.15.1775833539525; 
 Fri, 10 Apr 2026 08:05:39 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:38 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 08/14] virtio: use iothread_get/put_aio_context for thread
 pinning
Date: Fri, 10 Apr 2026 23:04:51 +0800
Message-ID: <20260410150457.85190-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52a.google.com
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

Refactor virtio-blk and virtio-scsi to use the new iothread_get/put
APIs for AioContext management. This ensures IOThread references
are tracked via the device's canonical QOM path.

Summary of changes:
- Lift 'path' scope to cover both vq_mapping and single iothread cases.
- Replace raw object_ref/unref with iothread_get/put_aio_context.
- Ensure consistent memory cleanup of the QOM path string.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c           | 16 +++++-----------
 hw/scsi/virtio-scsi-dataplane.c | 15 +++++----------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 762714f4ba..70fc85bdde 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1429,6 +1429,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (conf->iothread && conf->iothread_vq_mapping_list) {
         error_setg(errp,
@@ -1453,8 +1454,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
@@ -1465,13 +1464,11 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             return false;
         }
     } else if (conf->iothread) {
-        AioContext *ctx = iothread_get_aio_context(conf->iothread);
+        AioContext *ctx = iothread_ref_and_get_aio_context(conf->iothread,
+                                                           path);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
         }
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(conf->iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < conf->num_queues; i++) {
@@ -1486,21 +1483,18 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
 {
     VirtIOBlkConf *conf = &s->conf;
+    g_autofree char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(
-                                OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list, path);
     }
 
     if (conf->iothread) {
-        object_unref(OBJECT(conf->iothread));
+        iothread_put_aio_context(conf->iothread, path);
     }
 
-    g_free(s->vq_aio_context);
     s->vq_aio_context = NULL;
 }
 
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 26ecefd547..cc318162f5 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -28,6 +28,7 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (vs->conf.iothread && vs->conf.iothread_vq_mapping_list) {
         error_setg(errp,
@@ -65,8 +66,6 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
                     &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
                     vs->conf.num_queues, path, errp)) {
@@ -75,13 +74,11 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             return;
         }
     } else if (vs->conf.iothread) {
-        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
+        AioContext *ctx = iothread_ref_and_get_aio_context(vs->conf.iothread,
+                                                           path);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
-
-        /* Released in virtio_scsi_dataplane_cleanup() */
-        object_ref(OBJECT(vs->conf.iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < vs->conf.num_queues; i++) {
@@ -94,16 +91,14 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
 void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    g_autofree char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     if (vs->conf.iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(
-                                OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list, path);
     }
 
     if (vs->conf.iothread) {
-        object_unref(OBJECT(vs->conf.iothread));
+        iothread_put_aio_context(vs->conf.iothread, path);
     }
 
     g_free(s->vq_aio_context);
-- 
2.49.0


