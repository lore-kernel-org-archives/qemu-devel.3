Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AAECCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNs-0007ko-9e; Thu, 16 Oct 2025 07:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MNF-0007Gw-Ty; Thu, 16 Oct 2025 07:42:30 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MN9-0003WI-6G; Thu, 16 Oct 2025 07:42:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E413DC01E2;
 Thu, 16 Oct 2025 14:41:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-RYmLMXZs; Thu, 16 Oct 2025 14:41:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614898;
 bh=kdIFXuaPTp/BfbVEZsthEVutCRQg5Y0tS4H8w9udEPE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=e2Dxekh174wsHqceWBfHueJM2/cHPGf5UkiSTy8YbRha0/aq5vwelBvKSyfXdaFy2
 2ckuhk4l5CLHfTY+CF1LNfTJ8POh0Yi4whMgKNLdvirM4sFEHr84XHjpZGSo6KyeoY
 3YH61i/sQNJdG3+GAaRaUVIJchtL9bffsQsEYZKQ=
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
Subject: [PATCH v2 20/25] vhost-user: add vmstate
Date: Thu, 16 Oct 2025 14:40:57 +0300
Message-ID: <20251016114104.1384675-21-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c         | 95 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user.h |  4 ++
 2 files changed, 99 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c5cb5ed528..a820214188 100644
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
 
@@ -3137,6 +3139,99 @@ void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
         qmp_decode_protocols(u->protocol_features);
 }
 
+typedef struct VhostUserMigTmp {
+    struct vhost_dev *parent;
+    bool has_backend_channel;
+    int backend_fd;
+    uint32_t memory_slots;
+    uint64_t protocol_features;
+} VhostUserMigTmp;
+
+static int vhost_user_tmp_pre_save(void *opaque)
+{
+    VhostUserMigTmp *tmp = opaque;
+    struct vhost_dev *dev = tmp->parent;
+    struct vhost_user *u = dev->opaque;
+    QIOChannelSocket *sioc = u->backend_sioc;
+
+    if (sioc && sioc->fd < 0) {
+        return -EINVAL;
+    }
+
+    tmp->backend_fd = sioc ? sioc->fd : -1;
+    tmp->has_backend_channel = !!sioc;
+    tmp->memory_slots = u->user->memory_slots;
+    tmp->protocol_features = u->protocol_features;
+
+    return 0;
+}
+
+static int vhost_user_tmp_post_load(void *opaque, int version_id)
+{
+    struct VhostUserMigTmp *tmp = opaque;
+    struct vhost_dev *dev = tmp->parent;
+    struct vhost_user *u = dev->opaque;
+    Error *local_err = NULL;
+
+    if (tmp->has_backend_channel) {
+        u->backend_sioc = qio_channel_socket_new_fd(tmp->backend_fd,
+                                                    &local_err);
+        if (!u->backend_sioc) {
+            error_report_err(local_err);
+            return -EINVAL;
+        }
+        u->backend_src = qio_channel_add_watch_source(
+            QIO_CHANNEL(u->backend_sioc), G_IO_IN | G_IO_HUP,
+            backend_read, u->dev, NULL, NULL);
+    }
+
+    u->user->memory_slots = tmp->memory_slots;
+    u->protocol_features = tmp->protocol_features;
+
+    return 0;
+}
+
+static bool vhost_user_tmp_test_fd(void *opaque, int version_id)
+{
+    struct VhostUserMigTmp *tmp = opaque;
+
+    return tmp->has_backend_channel;
+}
+
+static const VMStateDescription vmstate_vhost_user_blk_tmp = {
+    .name = "vhost-user-blk-tmp",
+    .pre_save = vhost_user_tmp_pre_save,
+    .post_load = vhost_user_tmp_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(protocol_features, VhostUserMigTmp),
+        VMSTATE_UINT32(memory_slots, VhostUserMigTmp),
+        VMSTATE_BOOL(has_backend_channel, VhostUserMigTmp),
+        VMSTATE_FD_TEST(backend_fd, VhostUserMigTmp, vhost_user_tmp_test_fd),
+        VMSTATE_END_OF_LIST()
+   },
+};
+
+static int vhost_user_post_load(void *opaque, int version_id)
+{
+    struct vhost_dev *dev = opaque;
+    struct vhost_user *u = dev->opaque;
+
+    u->postcopy_notifier.notify = vhost_user_postcopy_notifier;
+    postcopy_add_notifier(&u->postcopy_notifier);
+
+    return 0;
+}
+
+const VMStateDescription vmstate_vhost_user = {
+    .name = "vhost-user",
+    .post_load = vhost_user_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_WITH_TMP(struct vhost_dev, VhostUserMigTmp,
+                         vmstate_vhost_user_blk_tmp),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 36d96296a3..fb89268de2 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -114,4 +114,8 @@ void vhost_user_async_close(DeviceState *d,
 
 void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
 
+extern const VMStateDescription vmstate_vhost_user;
+#define VMSTATE_BACKEND_TRANSFER_VHOST_USER(_field, _state) \
+    VMSTATE_STRUCT(_field, _state, 0, vmstate_vhost_user, struct vhost_dev)
+
 #endif
-- 
2.48.1


