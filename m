Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C848E83EF9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 09:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnZ71-00037l-WF; Wed, 04 Feb 2026 04:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnZ6z-00033B-K6
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:23:49 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnZ6x-00038I-JV
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:23:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A09DF807E9;
 Wed, 04 Feb 2026 12:23:43 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fNlTbg0A58c0-UIls85fU; Wed, 04 Feb 2026 12:23:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770197023;
 bh=Pfq/QKPKp23MSJ6FjLKG3ExuRdNsMAjh3P4leBDAn1A=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=gLtTK3fo0Sy6XrgaccLAw+ADWbuqVZU8UUm7MSDD9Qk39qyyq8PCEwJmboNziiJxK
 B036fPQvW5WfkKQvyMwe9fiNcJxdErFZ9oG3ltFkcqOolWXs3yKmmtNHqXOGgpe/Xr
 yL/qMzU5nJlnjP7LFAAHM5fjRjztLFP/bwPtS9AU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH] vhost-user: pass GPA instead of UVA
Date: Wed,  4 Feb 2026 12:23:39 +0300
Message-ID: <20260204092339.211650-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Unlike the kernel, vhost-user backend knows nothing about QEMUs
userspace addresses. We can pass GPA instead and nothing changes.

The benefit: open the doors for further implementation of local
migration (live-update) with passing open vhost-releated FDs
through UNIX domain socket. This way the connection with backend
kept live and untouched.

Without this change, we'll have to communicate with backend to
inform it about UVA addresses change, but better is simply use
more stable GPA numbers, like it's done for VDPA.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 63fa9a1b4b..f379408c95 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -386,6 +386,24 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
     CharFrontend *chr = u->user->chr;
     int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
 
+    if (msg->hdr.request == VHOST_USER_REM_MEM_REG ||
+        msg->hdr.request == VHOST_USER_ADD_MEM_REG) {
+
+        /*
+         * In QEMU we pass guest physical addresses to vhost-user server
+         * instead of QEMUs virtual address. Server have no option to
+         * distinguesh, but we get a benefit: guest physical address is
+         * stable during migration, and we don't have to reset memory
+         * regions.
+         *
+         * Look also at vhost_user_vq_get_addr(): like in VDPA, we pass
+         * physical addresses instead of user.
+         */
+
+        msg->payload.mem_reg.region.userspace_addr =
+            msg->payload.mem_reg.region.guest_phys_addr;
+    }
+
     /*
      * Some devices, like virtio-scsi, are implemented as a single vhost_dev,
      * while others, like virtio-net, contain multiple vhost_devs. For
@@ -3021,6 +3039,17 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+static int vhost_user_vq_get_addr(struct vhost_dev *dev,
+                                  struct vhost_vring_addr *addr,
+                                  struct vhost_virtqueue *vq)
+{
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+    addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
+    addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
+    addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
+    return 0;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_backend_init,
@@ -3059,4 +3088,5 @@ const VhostOps user_ops = {
         .vhost_supports_device_state = vhost_user_supports_device_state,
         .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
         .vhost_check_device_state = vhost_user_check_device_state,
+        .vhost_vq_get_addr = vhost_user_vq_get_addr,
 };
-- 
2.52.0


