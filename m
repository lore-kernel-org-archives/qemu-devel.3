Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA063CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPew-0000EI-Cp; Mon, 10 Nov 2025 06:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vIPJz-0008CQ-1Q
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:40:27 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vIPJx-0002tN-7e
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:40:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CDFEE804D1;
 Mon, 10 Nov 2025 13:40:23 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8011:f00:439c:fb8b:9c87:386c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ndKaU81FteA0-6OhXgPv0; Mon, 10 Nov 2025 13:40:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762771223;
 bh=WWaIfGLxmB79niuepFPqr1PNMfJA3+W6jLKuoFumxpc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=S/niCiMfN0h0RRgOtjHfznHYgAMjXsj/yZKYlFzb7tFcRQvwvyCwZ0hjgGD7C03di
 Pm3OJ9/abhfm24dYRsVXZ/MUTs6VF15INQLdOd2rVZR0wghFKynZc5J6tmvBMXHNL9
 JK2BTolwzAiEzGLbL4bmOsG5kvsJuPwFC/v1oRbQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v3 3/3] vhost-user-blk: support inter-host inflight migration
Date: Mon, 10 Nov 2025 15:39:41 +0500
Message-Id: <20251110103937.1944486-4-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During inter-host migration, waiting for disk requests to be drained
in the vhost-user backend can incur significant downtime.

This can be avoided if QEMU migrates the inflight region in
vhost-user-blk.
Thus, during the qemu migration, the vhost-user backend can cancel all
inflight requests and
then, after migration, they will be executed on another host.

In vhost_user_blk_stop() on incoming inter-host migration make
force_stop = true,
so GET_VRING_BASE will not be executed.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/block/vhost-user-blk.c          | 29 +++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user-blk.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a8fd90480a..2d9b398de6 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -139,6 +139,14 @@ const VhostDevConfigOps blk_ops = {
     .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
 };
 
+static bool vhost_user_blk_inflight_needed(void *opaque)
+{
+    struct VHostUserBlk *s = opaque;
+
+    return s->skip_get_vring_base_inflight_migration &&
+           !migrate_local_vhost_user_blk();
+}
+
 static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
 {
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
@@ -242,6 +250,11 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     force_stop = s->skip_get_vring_base_on_force_shutdown &&
                  qemu_force_shutdown_requested();
 
+    if (vhost_user_blk_inflight_needed(s) &&
+        runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        force_stop = true;
+    }
+
     s->dev.backend_transfer = s->dev.backend_transfer ||
         (runstate_check(RUN_STATE_FINISH_MIGRATE) &&
          migrate_local_vhost_user_blk());
@@ -656,6 +669,16 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
+static const VMStateDescription vmstate_vhost_user_blk_inflight = {
+    .name = "vhost-user-blk/inflight",
+    .version_id = 1,
+    .needed = vhost_user_blk_inflight_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
 {
     VHostUserBlk *s = VHOST_USER_BLK(opaque);
@@ -678,6 +701,10 @@ static const VMStateDescription vmstate_vhost_user_blk = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_vhost_user_blk_inflight,
+        NULL
+    }
 };
 
 static bool vhost_user_needed(void *opaque)
@@ -751,6 +778,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
                      skip_get_vring_base_on_force_shutdown, false),
+    DEFINE_PROP_BOOL("skip-get-vring-base-inflight-migration", VHostUserBlk,
+                     skip_get_vring_base_inflight_migration, false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index b06f55fd6f..859fb96956 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -52,6 +52,7 @@ struct VHostUserBlk {
     bool started_vu;
 
     bool skip_get_vring_base_on_force_shutdown;
+    bool skip_get_vring_base_inflight_migration;
 
     bool incoming_backend;
 };
-- 
2.34.1


