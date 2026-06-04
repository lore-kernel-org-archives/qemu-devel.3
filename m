Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92F0CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7RB-0005Li-1V; Thu, 04 Jun 2026 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV7R9-0005I8-0g
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:44:39 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV7R6-0000pk-4k
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780577064; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=FNoeXF/q9SSX6kIjlgmqW0EI5NGb078n4sgyRcBa0ks=;
 b=j4IhclK7k7SqoNi8chmSv5BRvwRxVWIQUNb2pB6IqwiujgK5QMwhczMRR0AwerRdlwpKVsF22ujvEC6sqwKkvhFdteAtPUlOR0qCpZJrv6uagmtYVv7dxOsNzQURMZj2vp/tFc65EH6gjODz9WX3Ld8AOjmvw0Jcnoxvvjm0Q5A=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R611e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0X4ALFiu_1780577061; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X4ALFiu_1780577061 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 04 Jun 2026 20:44:22 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/virtio: propagate vhost_virtqueue_mask() errors from start
 path
Date: Thu,  4 Jun 2026 20:44:20 +0800
Message-ID: <20260604124420.82450-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

vhost_virtqueue_start() unmasks the call notifier by calling
vhost_virtqueue_mask(), whose vhost_set_vring_call ioctl can fail
(closed vhost-user socket, kernel ENOMEM, revoked guest_notifier fd)
but whose void signature throws the error away. vhost_dev_start()
then reports success while the backend has no valid call eventfd for
that vq, leaving the guest with a working kick path but no virtqueue
interrupts -- a half-up state harder to diagnose than a clean failure.

Make vhost_virtqueue_mask() return int and handle the error in the
start path via the existing fail_vector unwind. Other callers reach
the function through VirtioDeviceClass.guest_notifier_mask, whose
void signature offers no upward error channel; they invoke it as a
statement and remain source-compatible.

Resolves a long-standing TODO at the unmask call.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/virtio/vhost.c         | 12 +++++++++---
 include/hw/virtio/vhost.h |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9dc4ed13b..42e2fc9952 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1351,8 +1351,11 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
      * will do it later.
      */
     if (!vdev->use_guest_notifier_mask) {
-        /* TODO: check and handle errors. */
-        vhost_virtqueue_mask(dev, vdev, idx, false);
+        r = vhost_virtqueue_mask(dev, vdev, idx, false);
+        if (r < 0) {
+            /* No call eventfd means no interrupts; bail out. */
+            goto fail_vector;
+        }
     }
 
     if (k->query_guest_notifiers &&
@@ -1815,7 +1818,7 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n)
 }
 
 /* Mask/unmask events from this vq. */
-void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
+int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
                          bool mask)
 {
     struct VirtQueue *vvq = virtio_get_queue(vdev, n);
@@ -1836,7 +1839,10 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
     r = hdev->vhost_ops->vhost_set_vring_call(hdev, &file);
     if (r < 0) {
         error_report("vhost_set_vring_call failed %d", -r);
+        return r;
     }
+
+    return 0;
 }
 
 bool vhost_config_pending(struct vhost_dev *hdev)
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 89817bd848..96cc261822 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -317,8 +317,8 @@ bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n);
 
 /* Mask/unmask events from this vq.
  */
-void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
-                          bool mask);
+int vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
+                         bool mask);
 
 /**
  * vhost_get_features_ex() - sanitize the extended features set
-- 
2.50.1 (Apple Git-155)


