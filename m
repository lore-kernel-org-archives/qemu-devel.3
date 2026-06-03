Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD60BCD6E71
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUuMY-0002MH-R9; Wed, 03 Jun 2026 18:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUuAy-0000Iy-Dq
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:35:04 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wUuAw-00078j-Br
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:35:04 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-137eb0d76beso691405c88.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780526101; x=1781130901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppZdqHcMgO+vgKbMmRf29BPISaSE+2k5F2+cTFDgyoY=;
 b=KHbneqlTN3VPiyYU6vcGDocXRkgqMnXsBMx6Y+G8zctwUhnJVErcWs/0V44Y3qflI+
 C8AC8LZmD5GdZKiZQUs3dMMB5DI0L4YhZnPfCZA6Cl/3yuEO1yQ8adJBOxh3txwV6dwk
 vCqRYq9zPojAIlKtsZRMyOFVWj4U1MDNpnbqlvRxtDcZXqMMWhBOV7otS+/Pc9CP34Vl
 nUeZ4mYx5x14b563ophtCPTTnNa1vKRKExmH2nuTf25yOu2HHo4ziWZWxTZxQThXB5pI
 Xg5L7cE4hRc+61ty0Bols5j1LrDWaQXw7zBpDQT81Zji3pATzqTXUl3v7xK+NscM4Q0W
 D7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780526101; x=1781130901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ppZdqHcMgO+vgKbMmRf29BPISaSE+2k5F2+cTFDgyoY=;
 b=JdEtqXp04WXOQ1ILrmBibd7SlIrnuSv7OhMeDnswTuBFqGX0Ple+AbLvArLAr0e512
 tmW2hgvfPkwHzRfH+Wahvob/dEdM94FO0JewqW/32GPc/bg/kZMfOxXf4qAPChjJGWqC
 BaQlruKXoOYoQ5vAPK/n5E7lxyZC9dhPFYA2DeSc6IDSOmBz3219QLecjtLN+BrrUk9/
 7H0s9ZbEwyE9SglTRVuHLEjUBWHiQfux+9OfwAUJnJnQo23SucZcxY/PpaV28yPIS5vA
 zBP9KQgXv0oq5BtlEXsVIR8ZUW+SEU23MqThCajuG09YcTR0GZRFDrH0x2hUc+nsWSz9
 mXjw==
X-Gm-Message-State: AOJu0Yxk+1puN2HqIZyWciuVPWGuObzccETOpOYYio3WI+qrWIT5TPja
 8PNSxKLHIJL2X/UYIAgCBWB4lfeM64ALmCQw2O+6VoI75erurtXCV6RJdHHC7tql
X-Gm-Gg: Acq92OFyaOGtsINNSIEAqhiNQNtogTytqaACgQs8sVoj70XkFnwewA3lxEQ2feooLD4
 SLxaRUXv6WbqGdxFhzd85WnwHn0Gt9GBNx2qi7/PqXrjUFMKTf3/DwpH4KYWfTk8Efww3VNzBL8
 5PmVtSejBxCuHuyr82sH65ERcNIy5bjDwFTZLDfIcHCrUEIk+B7qejWANT7pi9whVhNS4nfInMJ
 I9aItGCbQqJDcTgJ6v5u/eQJ+wRkkHoD5hNVWxeivQ14VGi3twHtwXCHuLhQORb2jFDIz1xk1Om
 PmRokOJhhWpNN2zoNKn8A1j6wNnYK8igncW5tljigIevxYRZqzdJFRe7cTOQY3rxD1wNULO7MRp
 YOfqnboqC7hSDhHxaktFqdVSQbvzV7tN+6xqA3iGzMMalNq7JAhYxlTI+DC0BibqZFUoxyB+Mq3
 ocvKSY+ac000pWOAD+zMtjY4pyTINRtLcisLsRpAw3MUoSlzLO
X-Received: by 2002:a05:7022:ff42:b0:136:4bbe:9523 with SMTP id
 a92af1059eb24-137fdef3661mr599645c88.8.1780526100669; 
 Wed, 03 Jun 2026 15:35:00 -0700 (PDT)
Received: from MacLin.attlocal.net ([2600:1700:e140:14d0:fad:648b:d3db:b403])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df349d8sm3492027eec.22.2026.06.03.15.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 15:35:00 -0700 (PDT)
From: ConKite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	hreitz@redhat.com,
	ConKite <connorkite@gmail.com>
Subject: [PATCH 2/2] vhost-user: Add memory-isolation qdev property
Date: Wed,  3 Jun 2026 15:33:55 -0700
Message-ID: <20260603223430.3311916-3-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603223430.3311916-1-connorkite@gmail.com>
References: <20260603223430.3311916-1-connorkite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=connorkite@gmail.com; helo=mail-dl1-x1236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Jun 2026 18:47:00 -0400
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

In support of future work to add a memory isolation mode to vhost-user devices, a
qdev property, "memory-isolation", is added to all vhost-user devices. This is
simply a bool representing whether the mode is active or not.

Signed-of-by: Connor Kite <connorkite@gmail.com>

---
 hw/block/vhost-user-blk.c            | 1 +
 hw/display/vhost-user-gpu.c          | 1 +
 hw/scsi/vhost-user-scsi.c            | 1 +
 hw/virtio/vhost-user-base.c          | 3 ++-
 hw/virtio/vhost-user-fs.c            | 1 +
 hw/virtio/vhost-user-scmi.c          | 1 +
 hw/virtio/vhost-user-vsock.c         | 1 +
 include/hw/virtio/vhost-user-base.h  | 1 +
 include/hw/virtio/vhost-user-blk.h   | 1 +
 include/hw/virtio/vhost-user-fs.h    | 1 +
 include/hw/virtio/vhost-user-scmi.h  | 1 +
 include/hw/virtio/vhost-user-vsock.h | 1 +
 include/hw/virtio/virtio-gpu.h       | 1 +
 include/hw/virtio/virtio-scsi.h      | 1 +
 14 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c151e83677..80a0572030 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -605,6 +605,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
 
 static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBlk, memory_isolation, false),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 6e5e6540a4..e52d16dd45 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -664,6 +664,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_BOOL("memory-isolation", VhostUserGPU, memory_isolation, false),
 };
 
 static void
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 3612897d4b..bdf6d3fdde 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -347,6 +347,7 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
 
 static const Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VirtIOSCSICommon, conf.memory_isolation, false),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index a3d5a9cd99..dff6d76365 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -355,7 +355,8 @@ static void vub_device_unrealize(DeviceState *dev)
 
 /*Define common qdev properties.  Inherited by all children*/
 static const Property vub_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memory_isolation, false)
 };
 
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index ad6fcacf06..f13a8b985c 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -409,6 +409,7 @@ static const VMStateDescription vuf_backend_vmstate = {
 
 static const Property vuf_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserFS, conf.memory_isolation, false),
     DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
     DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
                        conf.num_request_queues, 1),
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index f9264c4374..4595261f03 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -282,6 +282,7 @@ static const VMStateDescription vu_scmi_vmstate = {
 
 static const Property vu_scmi_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserSCMI, memory_isolation, false),
 };
 
 static void vu_scmi_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index c2cd376e73..89aa789e22 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -154,6 +154,7 @@ static void vuv_device_unrealize(DeviceState *dev)
 
 static const Property vuv_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserVSock, conf.memory_isolation, false),
 };
 
 static void vuv_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
index d5d2f081ae..29bc40736c 100644
--- a/include/hw/virtio/vhost-user-base.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -25,6 +25,7 @@ struct VHostUserBase {
     uint32_t num_vqs;
     uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
     uint32_t config_size;
+    bool memory_isolation;
     /* State tracking */
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vq;
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 1e41a2bcdf..42c21ab1c8 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -30,6 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserBlk, VHOST_USER_BLK)
 struct VHostUserBlk {
     VirtIODevice parent_obj;
     CharFrontend chardev;
+    bool memory_isolation;
     int32_t bootindex;
     struct virtio_blk_config blkcfg;
     uint16_t num_queues;
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
index 5699ea03a1..bf71990b9c 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -28,6 +28,7 @@ typedef struct {
     char *tag;
     uint16_t num_request_queues;
     uint16_t queue_size;
+    bool memory_isolation;
 } VHostUserFSConf;
 
 struct VHostUserFS {
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
index 30ab0d7ab7..d346b42ed8 100644
--- a/include/hw/virtio/vhost-user-scmi.h
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -19,6 +19,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCMI, VHOST_USER_SCMI);
 struct VHostUserSCMI {
     VirtIODevice parent;
     CharFrontend chardev;
+    bool memory_isolation;
     struct vhost_virtqueue *vhost_vqs;
     struct vhost_dev vhost_dev;
     VhostUserState vhost_user;
diff --git a/include/hw/virtio/vhost-user-vsock.h b/include/hw/virtio/vhost-user-vsock.h
index 5db6938b8b..6288b26fa4 100644
--- a/include/hw/virtio/vhost-user-vsock.h
+++ b/include/hw/virtio/vhost-user-vsock.h
@@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserVSock, VHOST_USER_VSOCK)
 
 typedef struct {
     CharFrontend chardev;
+    bool memory_isolation;
 } VHostUserVSockConf;
 
 struct VHostUserVSock {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f69fc19462..98af73cd2b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -276,6 +276,7 @@ struct VhostUserGPU {
     CharFrontend vhost_chr;
     QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
     bool backend_blocked;
+    bool memory_isolation;
 };
 
 #define MAX_SLOTS 4096
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index b6028bb5cd..47fdc3785c 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -59,6 +59,7 @@ struct VirtIOSCSIConf {
     char *vhostfd;
     char *wwpn;
     CharFrontend chardev;
+    bool memory_isolation;
     uint32_t boot_tpgt;
     IOThread *iothread;
     IOThreadVirtQueueMappingList *iothread_vq_mapping_list;
-- 
2.43.0


