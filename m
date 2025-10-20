Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B640CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAihX-0003JI-4m; Mon, 20 Oct 2025 01:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAihV-0003IX-JF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:44:57 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAihT-0007uF-NE
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:44:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 51E09807C6;
 Mon, 20 Oct 2025 08:44:53 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:803e:400:cd4:cafc:37a3:de4])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TiN4Nb4FbmI0-na5GOKoo; Mon, 20 Oct 2025 08:44:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760939092;
 bh=EOtLxjwgk1w0JEzaRIvF5AGcRQ+yAHOjpo8WXDwVCMg=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qJ5JmOHEIYVdOgt/6kAAT8DVRhQOT6aKQb/a3u0srwS102Uzvc55b2Uo9BZ/mKNOQ
 YNs2OuiAkpBuh/QAiJc5qWu++PauzQCfQNBymFcU8EAhJSyYW+F8WlErlV3kcMzV4W
 O3fJBM+3u5mUsKSlORvMR7SL7lBQFZwHXXwP9wL8=
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
Subject: [PATCH 2/2] vhost-user-blk: support inflight migration
Date: Mon, 20 Oct 2025 10:44:16 +0500
Message-Id: <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In vhost_user_blk_stop() on incoming migration make force_stop = true,
so GET_VRING_BASE will not be executed.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 52 +++++++++++++++++++++++++++++++++++++++
 migration/options.c       |  7 ++++++
 migration/options.h       |  1 +
 qapi/migration.json       |  9 +++++--
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c0cc5f6942..49f67d0451 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -31,6 +31,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "system/system.h"
 #include "system/runstate.h"
+#include "migration/options.h"
 
 static const int user_feature_bits[] = {
     VIRTIO_BLK_F_SIZE_MAX,
@@ -224,6 +225,11 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     force_stop = s->skip_get_vring_base_on_force_shutdown &&
                  qemu_force_shutdown_requested();
 
+    if (migrate_inflight_vhost_user_blk() &&
+        runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        force_stop = true;
+    }
+
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
                        vhost_dev_stop(&s->dev, vdev, true);
 
@@ -568,12 +574,58 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
+static int vhost_user_blk_save(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc)
+{
+    VirtIODevice *vdev = pv;
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    if (!migrate_inflight_vhost_user_blk()) {
+        return 0;
+    }
+
+    vhost_dev_save_inflight(s->inflight, f);
+
+    return 0;
+}
+
+static int vhost_user_blk_load(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field)
+{
+    VirtIODevice *vdev = pv;
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    int ret;
+
+    if (!migrate_inflight_vhost_user_blk()) {
+        return 0;
+    }
+
+    ret = vhost_dev_load_inflight(s->inflight, f);
+    if (ret < 0) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
+        error_report("%s [%s]: can't load in-flight requests",
+                     path, TYPE_VHOST_USER_BLK);
+        return ret;
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_vhost_user_blk = {
     .name = "vhost-user-blk",
     .minimum_version_id = 1,
     .version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
+        {
+            .name = "backend state",
+            .info = &(const VMStateInfo) {
+                .name = "vhost-user-blk backend state",
+                .get = vhost_user_blk_load,
+                .put = vhost_user_blk_save,
+            },
+            .flags = VMS_SINGLE,
+        },
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/migration/options.c b/migration/options.c
index 5183112775..fcae2b4559 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -262,6 +262,13 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_inflight_vhost_user_blk(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_INFLIGHT_VHOST_USER_BLK];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..eab1485d1a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -30,6 +30,7 @@ bool migrate_colo(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
+bool migrate_inflight_vhost_user_blk(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..c9fea59515 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -517,9 +517,13 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
+#    region for vhost-user-blk.  (since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-colo and @x-ignore-shared are experimental.
+# @unstable: Members @x-colo and @x-ignore-shared,
+#     @inflight-vhost-user-blk are experimental.
 # @deprecated: Member @zero-blocks is deprecated as being part of
 #     block migration which was already removed.
 #
@@ -536,7 +540,8 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram',
+           { 'name': 'inflight-vhost-user-blk', 'features': [ 'unstable' ] } ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.34.1


