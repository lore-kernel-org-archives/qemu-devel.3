Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4457F33A70
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9dt-00040z-Q0; Thu, 05 Mar 2026 09:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9do-00040q-T8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:29 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dn-0001nE-6i
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:28 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so36844495ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720725; x=1773325525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmWibEfq3CH/Q/SvrYhWA5+P9/zT0VQeDdmFmhgM9j0=;
 b=HvqdUMX5N38RDsU3VWo1WvrpS8pJwTesPc7lDsID0Xt8MiAKQZTKbVZ6DgvxTa25MZ
 vF4CA2HZOC9Sf8HloKRheslvW6D6Tt0ZlyZvY98oc/8+FxqJoqr7g7Moo0Tx+ogNx67b
 6BuY8jhdnk0JZvCeugdkVGAigistLWzQpilcpD3pGO2ESCrZetTwWyHr3Uo9GNnpXMfs
 I90ine4/xsVv/Ez9A91bY7QJRWFoA8o8B0Kf320T3m5yGfaPGHkyOHCRcGKoLugDgsM8
 IjAzRcsvDlg2YlljocdzmEz9ZB3LpIbekdw6UUWil7uRSMG1o0Yb5YaAQd2qlBGkQOf+
 e/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720725; x=1773325525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmWibEfq3CH/Q/SvrYhWA5+P9/zT0VQeDdmFmhgM9j0=;
 b=bLIVFJOJTX2nDTlVP8yqXqRnpAAoYQUJGu8GditPTzabLVKHea8btItimOSQmprrfc
 W5coex1Nl5JS6VGgksM09mPRmOmf6cSIZHq+R4S0ABZSA5BZJHaYM8EJk0HQpOOGiCcX
 QCzOa9568q0TQK+vX20XkHKtdsw5eyEhPrbs3TNnsJJ44GfZYBe8fYRLCuod6UnpKcNI
 LzvDnh9HIMo7iQh1zlablw3wgjjrgSmoHS5N68LK5PcPh1xcopnCjKcVTfUF9COBSZBy
 sVR6sDksKdsKNTOHAPciRlKAxpEcX75oxWMsBs/O4JDzv5vFT1FlIpf8onY3+R+AoIyA
 9Fyg==
X-Gm-Message-State: AOJu0Yw5Mz/yfISnK9QedJ2L+/+y7LgFyByVouoy1wIf9OvJLlch1BEj
 J0yrCSXYTCk1wnokKZvJdY1YsSXbdTmo2CA1xr04Nspbb0vVlPjAnDTj5fggtj6l+EwFXQ==
X-Gm-Gg: ATEYQzxrz5YSSiC83tYJufv7T6x2qQKVtfRS/moyrbouA1nvXEM3oQgDUHpQbGpnPpm
 6b5I7C+8/vVPKVtaAK39MtphIsFUh7A7BhYrCDBeNNyA4SIH8uHKklQNnGeCmtyXjGXS6LfrZi2
 ih+eo6bJTWCc6u6UNOvgCvu8lB5UQOzSJbDhXSiOFpouogrq5MIMyDJ0qcrM8aSTINTYKKMNKZB
 ZmB0H8GcHdw/e4KveZXCrMXTXlZstaH8cUc3vtwzqkdz/qC4drhg66JiOTRKMuK7a5jZHbrWbI7
 H8xVINaA6A9htED/rgmhABfEJnICz2K9esMa8yjfbRDhY5aPDUllke/TWa0cd4Eh3c0mR//Ni4m
 la7ePQDus1mMEiLUgi1GCkt5wYp+PiwmjGhU2bAOXH6qJTQOELqlduXMJtPu7U+0zYngIFzYhoW
 SU4Rv+Dr1WhwwWJu9RJqK9+b6U21hV2g2RKZSSP2vUtnxfjBU8AeZG4Rtaaf1y3wqu29A=
X-Received: by 2002:a17:902:e5c2:b0:2ae:4ebc:71d5 with SMTP id
 d9443c01a7336-2ae6ab72925mr49779625ad.52.1772720725394; 
 Thu, 05 Mar 2026 06:25:25 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:24 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 05/13] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Date: Thu,  5 Mar 2026 22:24:51 +0800
Message-ID: <20260305142459.52559-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x631.google.com
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context
in iothread-vq-mapping. This allows tracking IOThread users via
the device's canonical QOM path, improving lifecycle traceability
for virtio-blk and virtio-scsi devices.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c                   | 10 +++++++++-
 hw/scsi/virtio-scsi-dataplane.c         | 11 +++++++++--
 hw/virtio/iothread-vq-mapping.c         | 11 +++++------
 include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ddf0e9ee53..b6f74df68f 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1453,14 +1453,19 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
+        char *path = object_get_canonical_path(OBJECT(vdev));
+
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
+                                       path,
                                        errp)) {
+            g_free(path);
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
             return false;
         }
+        g_free(path);
     } else if (conf->iothread) {
         AioContext *ctx = iothread_get_aio_context(conf->iothread);
         for (unsigned i = 0; i < conf->num_queues; i++) {
@@ -1487,7 +1492,10 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list);
+        char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
+
+        iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list, path);
+        g_free(path);
     }
 
     if (conf->iothread) {
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 95f13fb7c2..ed5304c6a9 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -65,13 +65,17 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
+        char *path = object_get_canonical_path(OBJECT(vdev));
+
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
                     &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
-                    vs->conf.num_queues, errp)) {
+                    vs->conf.num_queues, path, errp)) {
+            g_free(path);
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
             return;
         }
+        g_free(path);
     } else if (vs->conf.iothread) {
         AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
@@ -94,7 +98,10 @@ void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
 
     if (vs->conf.iothread_vq_mapping_list) {
-        iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list);
+        char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
+
+        iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list, path);
+        g_free(path);
     }
 
     if (vs->conf.iothread) {
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
index 55ce62986c..7dadc43c44 100644
--- a/hw/virtio/iothread-vq-mapping.c
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -77,6 +77,7 @@ bool iothread_vq_mapping_apply(
         IOThreadVirtQueueMappingList *list,
         AioContext **vq_aio_context,
         uint16_t num_queues,
+        const char *holder,
         Error **errp)
 {
     IOThreadVirtQueueMappingList *node;
@@ -93,10 +94,7 @@ bool iothread_vq_mapping_apply(
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_get_aio_context(iothread);
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(iothread));
+        AioContext *ctx = iothread_get_aio_context(iothread, holder);
 
         if (node->value->vqs) {
             uint16List *vq;
@@ -120,13 +118,14 @@ bool iothread_vq_mapping_apply(
     return true;
 }
 
-void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
+                                 const char *holder)
 {
     IOThreadVirtQueueMappingList *node;
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        object_unref(OBJECT(iothread));
+        iothread_put_aio_context(iothread, holder);
     }
 }
 
diff --git a/include/hw/virtio/iothread-vq-mapping.h b/include/hw/virtio/iothread-vq-mapping.h
index 57335c3703..0d39caddf3 100644
--- a/include/hw/virtio/iothread-vq-mapping.h
+++ b/include/hw/virtio/iothread-vq-mapping.h
@@ -17,6 +17,7 @@
  * @list: The mapping of virtqueues to IOThreads.
  * @vq_aio_context: The array of AioContext pointers to fill in.
  * @num_queues: The length of @vq_aio_context.
+ * @holder: The QOM paths for attached device.
  * @errp: If an error occurs, a pointer to the area to store the error.
  *
  * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
@@ -31,15 +32,18 @@ bool iothread_vq_mapping_apply(
         IOThreadVirtQueueMappingList *list,
         AioContext **vq_aio_context,
         uint16_t num_queues,
+        const char *holder,
         Error **errp);
 
 /**
  * iothread_vq_mapping_cleanup:
  * @list: The mapping of virtqueues to IOThreads.
+ * @holder: The QOM paths for attached device.
  *
  * Release IOThread object references that were acquired by
  * iothread_vq_mapping_apply().
  */
-void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list);
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
+                                 const char *holder);
 
 #endif /* HW_VIRTIO_IOTHREAD_VQ_MAPPING_H */
-- 
2.49.0


