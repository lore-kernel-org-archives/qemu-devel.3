Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C5606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKmQ-0003dJ-Gz; Fri, 23 Oct 2026 15:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKll-0003Aj-DC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:38 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKli-00026g-Jz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:36 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlf-00000007BGU-116M; Fri, 23 Oct 2026 21:17:31 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] virtio: Split VM state change handler into start and
 stop parts
Date: Fri, 23 Oct 2026 21:16:23 +0200
Message-ID: <0fac083d9ef687849bddde691aebc2cafe182d79.1792758436.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This will allow moving the VM stop part of this handler into
VM_CHANGE_STATE_PRI_HIGH.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/virtio/virtio.c         | 32 +++++++++++++++++++++++++++-----
 include/hw/virtio/virtio.h |  3 ++-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c9f9e5b51168..9eefb2e2e670 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3733,12 +3733,12 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 
 void virtio_cleanup(VirtIODevice *vdev)
 {
-    qemu_del_vm_change_state_handler(vdev->vmstate);
+    qemu_del_vm_change_state_handler(vdev->vmstate_start);
+    qemu_del_vm_change_state_handler(vdev->vmstate_stop);
 }
 
-static int virtio_vmstate_change(void *opaque, bool running, RunState state)
+static int virtio_vmstate_change(VirtIODevice *vdev, bool running)
 {
-    VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     bool backend_run = running && virtio_device_started(vdev, vdev->status);
@@ -3761,6 +3761,26 @@ static int virtio_vmstate_change(void *opaque, bool running, RunState state)
     return 0;
 }
 
+static int virtio_vmstate_change_start(void *opaque, bool running,
+                                     RunState state)
+{
+    if (!running) {
+        return 0;
+    }
+
+    return virtio_vmstate_change(opaque, true);
+}
+
+static int virtio_vmstate_change_stop(void *opaque, bool running,
+                                    RunState state)
+{
+    if (running) {
+        return 0;
+    }
+
+    return virtio_vmstate_change(opaque, false);
+}
+
 void virtio_instance_init_common(Object *proxy_obj, void *data,
                                  size_t vdev_size, const char *vdev_name)
 {
@@ -3809,8 +3829,10 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
     } else {
         vdev->config = NULL;
     }
-    vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
-            NULL, virtio_vmstate_change, vdev);
+    vdev->vmstate_start = qdev_add_vm_change_state_handler(DEVICE(vdev),
+            NULL, virtio_vmstate_change_start, vdev);
+    vdev->vmstate_stop = qdev_add_vm_change_state_handler(DEVICE(vdev),
+            NULL, virtio_vmstate_change_stop, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
     QSIMPLEQ_INIT(&vdev->shmem_list);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27c5fe3a6b48..ab7fdd6e0e42 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -191,7 +191,8 @@ struct VirtIODevice
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
     bool disable_legacy_check;
     bool vhost_started;
-    VMChangeStateEntry *vmstate;
+    VMChangeStateEntry *vmstate_start;
+    VMChangeStateEntry *vmstate_stop;
     char *bus_name;
     uint8_t device_endian;
     /**

