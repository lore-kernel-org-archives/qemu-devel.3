Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD7AC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEgG-0003CD-Gs; Wed, 13 Aug 2025 12:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfz-00031K-27; Wed, 13 Aug 2025 12:50:11 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfl-0007tO-IU; Wed, 13 Aug 2025 12:50:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1D1CE813B7;
 Wed, 13 Aug 2025 19:49:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-BXvnPBfe; Wed, 13 Aug 2025 19:49:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103765;
 bh=ZqwjUtz1Fm9Op2W/FGi59SOWO4q8FsJ64eme844Jh7E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iKOCjq5xNP9AhG9fGwVtNMYgeMqZI/YCNto3h869woiD77SVF15WewCnJTJtQ8K/H
 PgtqjwkEFMzUAPQ7VQ+Lz2b0+vHZ2kbkvTEWR6XNtXfbKLJGOHwXRfvzRhP/JllkVM
 Jxd4UCUreczclxkmENtZrgHKxdghc39OIrcPht5I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 29/33] vhost-user: support backend migration
Date: Wed, 13 Aug 2025 19:48:50 +0300
Message-ID: <20250813164856.950363-30-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In case of local backend migration, skip backend-related
initialization, but instead get the state from migration
channel (including secondary channel file descriptor).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3979582975..f220af270e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -28,6 +28,8 @@
 #include "system/runstate.h"
 #include "system/cryptodev.h"
 #include "migration/postcopy-ram.h"
+#include "migration/qemu-file-types.h"
+#include "migration/qemu-file.h"
 #include "trace.h"
 #include "system/ramblock.h"
 
@@ -2273,6 +2275,10 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     u->dev = dev;
     dev->opaque = u;
 
+    if (dev->migrating_backend) {
+        goto out;
+    }
+
     err = vhost_user_get_features(dev, &features);
     if (err < 0) {
         error_setg_errno(errp, -err, "vhost_backend_init failed");
@@ -2387,6 +2393,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
         }
     }
 
+out:
     u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
     postcopy_add_notifier(&u->postcopy_notifier);
 
@@ -2936,6 +2943,10 @@ void vhost_user_async_close(DeviceState *d,
 
 static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
 {
+    if (dev->migrating_backend) {
+        return 0;
+    }
+
     if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
         return 0;
     }
@@ -3105,6 +3116,55 @@ static void vhost_user_qmp_status(struct vhost_dev *dev, VhostStatus *status)
     status->protocol_features = qmp_decode_protocols(u->protocol_features);
 }
 
+static void vhost_user_save(struct vhost_dev *dev, QEMUFile *f)
+{
+    struct vhost_user *u = dev->opaque;
+    bool has_backend_channel = !!u->backend_sioc;
+    qemu_put_be64(f, u->protocol_features);
+    qemu_put_be32(f, u->user->memory_slots);
+
+    qemu_put_byte(f, has_backend_channel);
+    if (u->backend_sioc) {
+        qemu_file_put_fd(f, u->backend_sioc->fd);
+    }
+}
+
+static int vhost_user_load(struct vhost_dev *dev, QEMUFile *f)
+{
+    struct vhost_user *u = dev->opaque;
+    uint8_t has_backend_channel;
+    uint32_t memory_slots;
+
+    qemu_get_be64s(f, &u->protocol_features);
+    qemu_get_be32s(f, &memory_slots);
+    qemu_get_8s(f, &has_backend_channel);
+
+    u->user->memory_slots = memory_slots;
+
+    if (has_backend_channel) {
+        int fd = qemu_file_get_fd(f);
+        Error *local_err = NULL;
+
+        u->backend_sioc = qio_channel_socket_new_fd(fd, &local_err);
+        if (!u->backend_sioc) {
+            error_report_err(local_err);
+            return -ECONNREFUSED;
+        }
+        u->backend_src = qio_channel_add_watch_source(
+            QIO_CHANNEL(u->backend_sioc), G_IO_IN | G_IO_HUP,
+            backend_read, dev, NULL, NULL);
+    }
+
+    if (dev->migration_blocker == NULL &&
+        !vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
+        error_setg(&dev->migration_blocker,
+                   "Migration disabled: vhost-user backend lacks "
+                   "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
+    }
+
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -3146,4 +3206,6 @@ const VhostOps user_ops = {
         .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
         .vhost_check_device_state = vhost_user_check_device_state,
         .vhost_qmp_status = vhost_user_qmp_status,
+        .vhost_save_backend = vhost_user_save,
+        .vhost_load_backend = vhost_user_load,
 };
-- 
2.48.1


