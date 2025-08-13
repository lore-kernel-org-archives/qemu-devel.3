Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B318CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEg1-00035g-Qh; Wed, 13 Aug 2025 12:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfg-0002lz-EF; Wed, 13 Aug 2025 12:49:54 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfN-0007sa-Sb; Wed, 13 Aug 2025 12:49:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D7E3C81293;
 Wed, 13 Aug 2025 19:49:22 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-AjtT8153; Wed, 13 Aug 2025 19:49:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103762;
 bh=ZP0m2iDnfarTInOhw140IrfQHwLhKgCJqmsVxIbp4EI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vq+LyZby3Ac3qLJHar+od0dCVnu23OvoImoXuSipzu2Fz6pnCIw7PA8edeKaCS7jv
 JJW8UBaVK6ippz9ORw7ZvI1A7v31nEdwqRyxpGy5NubXJG/1bMPZWf8hVzVMO5RaVz
 2PJui5tkB4KHvb7UQPAR/JF4fJUU6Tdivkubxz00=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 25/33] virtio: introduce .skip_vhost_migration_log() handler
Date: Wed, 13 Aug 2025 19:48:46 +0300
Message-ID: <20250813164856.950363-26-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

For vhost user backend migration we'll need to disable memory
logging on the device. Let's prepare a corresponding handler for
the device.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c          | 10 ++++++++++
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e7c809400b..0427fc29b2 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1134,6 +1134,16 @@ static int vhost_migration_log(MemoryListener *listener, bool enable)
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
index 8b9db08ddf..9a4a0a94aa 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -234,6 +234,8 @@ struct VirtioDeviceClass {
     /* May be called even when vdev->vhost_started is false */
     struct vhost_dev *(*get_vhost)(VirtIODevice *vdev);
     void (*toggle_device_iotlb)(VirtIODevice *vdev);
+
+    bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
 };
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
-- 
2.48.1


