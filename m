Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C836CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNc-0007UM-Bg; Thu, 16 Oct 2025 07:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMu-000797-3p; Thu, 16 Oct 2025 07:42:04 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMi-0003Vi-7E; Thu, 16 Oct 2025 07:42:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 559D7C01D6;
 Thu, 16 Oct 2025 14:41:34 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-uHz8I142; Thu, 16 Oct 2025 14:41:33 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614893;
 bh=oKQA85QXzsIVZqTNV9A3NCvsSHAUSiUk1m05STP30Ks=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=omjAXTmUHf8Ltm7WpU+/GrDokWXI3xDuHIHDkPvYoaduwMG6jyUmvYKeXXhQyF/8a
 j4b/mdPn+8aXYKJufXzXEK71D29VCRh9d8wsPT0eJah7v4TxOLawYhnm5C50CsT0AU
 I4TTydTJbP+U41xn8I7QlI8/SeH6D5UkJB/tRbyg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 14/25] virtio: introduce .skip_vhost_migration_log() handler
Date: Thu, 16 Oct 2025 14:40:51 +0300
Message-ID: <20251016114104.1384675-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

For vhost user backend migration we'll need to disable memory
logging on the device. Let's prepare a corresponding handler for
the device.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c          | 10 ++++++++++
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 09d00e4d98..3e5192ec23 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1138,6 +1138,16 @@ static int vhost_migration_log(MemoryListener *listener, bool enable)
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
     int r;
+
+    if (dev->vdev) {
+        VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev->vdev);
+
+        if (vdc->skip_vhost_migration_log &&
+            vdc->skip_vhost_migration_log(dev->vdev)) {
+            return 0;
+        }
+    }
+
     if (enable == dev->log_enabled) {
         return 0;
     }
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7db8046766..620ee4e389 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -238,6 +238,8 @@ struct VirtioDeviceClass {
     /* May be called even when vdev->vhost_started is false */
     struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
     void (*toggle_device_iotlb)(VirtIODevice *vdev);
+
+    bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
 };
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
-- 
2.48.1


