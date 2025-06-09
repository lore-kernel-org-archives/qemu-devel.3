Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DD7C61DB2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 21:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOk14-00005n-8K; Mon, 09 Jun 2025 17:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk12-0008WJ-HF; Mon, 09 Jun 2025 17:26:48 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk10-0007dM-Di; Mon, 09 Jun 2025 17:26:48 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:722f:0:640:94d5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A2E8E60CF4;
 Tue, 10 Jun 2025 00:26:44 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6bf:8080:771::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VQpuLN5FZuQ0-iqrq8V2p; Tue, 10 Jun 2025 00:26:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749504404;
 bh=pOSrzwwHova+AKyw5BhzHtXPI3s5dRv75DsZ5g7EMz0=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fsMoyl2PadZU44G9BADbu/1EdWRUQlxj7VO4fMnHTR/yEYYJRjH0A2vDU3vltWNOg
 iuq+LHu8vFzsWR6nM8JjYfni7PjCM8IS8/N83QcQeM0K/c0S9KVl9WF8ht7YcyaMTJ
 DSOlq6/t5EL7oQOZr0hkBn1BG3lquFzzvwG5CIeA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 3/3] vhost-user-blk: add an option to skip GET_VRING_BASE for
 force shutdown
Date: Tue, 10 Jun 2025 00:25:47 +0300
Message-Id: <20250609212547.2859224-4-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
References: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

If we have a server running disk requests that is for whatever reason
hanging or not able to process any more IO requests but still has some
in-flight requests previously issued by the guest OS, QEMU will still
try to drain the vring before shutting down even if it was explicitly
asked to do a "force shutdown" via SIGTERM or QMP quit. This is not
useful since the guest is no longer running at this point since it was
killed by QEMU earlier in the process. At this point, we don't care
about whatever in-flight IO it might have pending, we just want QEMU
to shut down.

Add an option called "skip-get-vring-base-on-force-shutdown" to allow
SIGTERM/QMP quit() to actually act like a "force shutdown" at least
for vhost-user-blk devices since those require the drain operation
to shut down gracefully unlike, for example, network devices.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/block/vhost-user-blk.c          | 9 ++++++++-
 include/hw/virtio/vhost-user-blk.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 0eebbcd80d..c0cc5f6942 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -210,6 +210,7 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     int ret;
+    bool force_stop = false;
 
     if (!s->started_vu) {
         return 0;
@@ -220,7 +221,11 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
         return 0;
     }
 
-    ret = vhost_dev_stop(&s->dev, vdev, true);
+    force_stop = s->skip_get_vring_base_on_force_shutdown &&
+                 qemu_force_shutdown_requested();
+
+    ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
+                       vhost_dev_stop(&s->dev, vdev, true);
 
     if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
         error_report("vhost guest notifier cleanup failed: %d", ret);
@@ -584,6 +589,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_DISCARD, true),
     DEFINE_PROP_BIT64("write-zeroes", VHostUserBlk, parent_obj.host_features,
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
+    DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
+                     skip_get_vring_base_on_force_shutdown, false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index ea085ee1ed..a10f785672 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -50,6 +50,8 @@ struct VHostUserBlk {
     bool connected;
     /* vhost_user_blk_start/vhost_user_blk_stop */
     bool started_vu;
+
+    bool skip_get_vring_base_on_force_shutdown;
 };
 
 #endif
-- 
2.34.1


