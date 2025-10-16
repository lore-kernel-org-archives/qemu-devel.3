Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C40CCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNY-0007QO-L7; Thu, 16 Oct 2025 07:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMq-00078i-HS; Thu, 16 Oct 2025 07:42:00 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMf-0003Vh-Hm; Thu, 16 Oct 2025 07:41:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AC05AC01D5;
 Thu, 16 Oct 2025 14:41:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-3b7thUw0; Thu, 16 Oct 2025 14:41:33 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614893;
 bh=xg5rt25IH6Si30MHS9JyIgSHUQPJwjGNETHZfmCEbZ4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XLs9mjPTUIwnQpx98i8Pwv5R+czk+e2FjvkWagPDIrJFq8TBTIOgc70jBjHvyT3i1
 O3o4/ixHalogJg4C3rWbzxjR/WUd3j8EEGoyKE94kZhibr7xFP6T209DqLYfkZ8FuL
 VxN7Fvq/T6jNpKoHj23Uo60pAY+borwqyxdSCCBQ=
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
Subject: [PATCH v2 13/25] vhost-user-blk: postpone connect to pre-incoming
Date: Thu, 16 Oct 2025 14:40:50 +0300
Message-ID: <20251016114104.1384675-14-vsementsov@yandex-team.ru>
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

That's a preparation for further backend-transfer migration for
vhost-user-blk. At initialization time we don't know will
user enable backent-transfer (by setting migration parameter) or
not. At time of pre-incoming, we know all migration parameters and
capabilities. So, now, let's postpone connecting up to pre-incoming
for incoming migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index af4a97b8e4..ffdd600526 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -577,8 +577,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
         goto fail;
     }
 
-    if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
-        goto fail;
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
+            goto fail;
+        }
     }
 
     trace_vhost_user_blk_device_realize_out(vdev);
@@ -636,10 +638,18 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
+static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(opaque);
+
+    return vhost_user_blk_realize_connect(s, errp) == 0;
+}
+
 static const VMStateDescription vmstate_vhost_user_blk = {
     .name = "vhost-user-blk",
     .minimum_version_id = 1,
     .version_id = 1,
+    .pre_incoming = vhost_user_blk_pre_incoming,
     .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
@@ -647,7 +657,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
 };
 
 static const Property vhost_user_blk_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
+    DEFINE_PROP_CHR_NO_CONNECT("chardev", VHostUserBlk, chardev),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
-- 
2.48.1


