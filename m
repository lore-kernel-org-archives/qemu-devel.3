Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECE606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=aYaEtiYQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQInk-00023T-7O; Mon, 09 Nov 2026 01:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xQInf-000233-9u
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:24:17 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1xQInb-0002h5-04
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:24:14 -0500
Received: from mail-nwsmtp-smtp-corp-main-68
 (mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 2D18480844;
 Mon, 09 Nov 2026 09:24:07 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru
 by mail-nwsmtp-smtp-corp-main-68 with ESMTPSA id nNKLppCamiE0-HKe8ksFt;
 Mon, 09 Nov 2026 09:24:06 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1794205446;
 bh=54Yt/HRHUf73M1ZeOD79PJvJP775P4DcRNSZq34Dw+o=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=aYaEtiYQPsf0eCxIz0iBy2oElQFaUnCvxxPvXx7oQUJlUT78MGlTayMYn1LVKArVf
 tlKXRzIDiqCD8UKCegw9VACD37zPweQdHVuOfnZcIMmvHnBXm+u7/+9TwA6e7O/uwR
 5DAFlSt6Wz4yoaGv9ot7BcIGndf1GBeVJnHlGlQc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@lists.linux.dev,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v2] vhost-user-fs: fix virtqueue array leak on realize failure
Date: Mon,  9 Nov 2026 11:24:01 +0500
Message-Id: <20261109062401.81161-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On failure, vhost_dev_init() clears vhost_dev, so the error path frees
NULL instead of the virtqueue array. Keep the pointer in the existing
vhost_vqs field and use it to free the array on failure and unrealize.

Fixes: 98fc1ada4cf7 ("virtio: add vhost-user-fs base device")
Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
v1 -> v2:
 - use the existing VHostUserFS.vhost_vqs field in realize and unrealize
   instead of local vars.

 hw/virtio/vhost-user-fs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 0d8842817a..f26b5b611a 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -255,7 +255,8 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
 
     /* 1 high prio queue, plus the number configured */
     fs->vhost_dev.nvqs = 1 + fs->conf.num_request_queues;
-    fs->vhost_dev.vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
+    fs->vhost_vqs = g_new0(struct vhost_virtqueue, fs->vhost_dev.nvqs);
+    fs->vhost_dev.vqs = fs->vhost_vqs;
     ret = vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0, errp);
     if (ret < 0) {
@@ -272,14 +273,14 @@ err_virtio:
     }
     g_free(fs->req_vqs);
     virtio_cleanup(vdev);
-    g_free(fs->vhost_dev.vqs);
+    g_free(fs->vhost_vqs);
+    fs->vhost_vqs = NULL;
 }
 
 static void vuf_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserFS *fs = VHOST_USER_FS(dev);
-    struct vhost_virtqueue *vhost_vqs = fs->vhost_dev.vqs;
     int i;
 
     /* This will stop vhost backend if appropriate. */
@@ -295,7 +296,8 @@ static void vuf_device_unrealize(DeviceState *dev)
     }
     g_free(fs->req_vqs);
     virtio_cleanup(vdev);
-    g_free(vhost_vqs);
+    g_free(fs->vhost_vqs);
+    fs->vhost_vqs = NULL;
 }
 
 static struct vhost_dev *vuf_get_vhost(VirtIODevice *vdev)
-- 
2.34.1


