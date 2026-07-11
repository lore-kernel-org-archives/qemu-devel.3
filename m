Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48051C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifoY-0003Y0-9A; Sat, 11 Jul 2026 18:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoW-0003Vx-JE; Sat, 11 Jul 2026 18:04:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifoU-0000N8-UU; Sat, 11 Jul 2026 18:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=FbLxTK3dK0Ntfc0GcAK6KQwuQ6t1UT4nBw08tUjanLI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ntiUsc/8baZ/Gr0foerPunaVO2vkLGqFSFHiY2tNyADtmz8eK/BovmbwTQ4XsK7jv
 +V8C+jYYCF+3Gm3soY7DodBQsNUGAeflHjYgOGZNv9fBQl+OzqI1BSkUOMLGf/bse2
 /DAIimG/cYyurrYO67BUV+k5WAO+yOd3HbhYfNHu1+pkK+GkYfoQahhjJPxFlNO2Qg
 XyQVkW92WWrmKQt6OjXf7yTDgHsjiE4fdjjwnXl2Ro09BvsuhaOWr3aPiE2hmTFnx4
 44nbJvPeIMl0CeiTcHIPdcjxEXCNJvixnSkIA3xmd73iiT3EFqYfT0AD8LQsJJuvZ7
 ZhJfOkDLb9Oow==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 594CE1C0AC1;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 105773EAF4C;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B977C1334F; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, lizhaoxin04 <lizhaoxin04@baidu.com>,
 Miao Kezhan <miaokezhan@baidu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 54/81] vdpa: fix use-after-free of vqs in
 vhost_vdpa_device_unrealize
Date: Sun, 12 Jul 2026 00:58:32 +0300
Message-ID: <20260711215904.3757-54-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
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

From: lizhaoxin04 <lizhaoxin04@baidu.com>

vhost_vdpa_device_unrealize() frees s->dev.vqs before
vhost_dev_cleanup(), but vhost_dev_cleanup() still accesses hdev->vqs
while tearing down virtqueues. This leads to a use-after-free and may
crash QEMU with SIGSEGV during vDPA hot-unplug.

Save the vqs pointer in a local variable, call vhost_dev_cleanup(),
and free it afterward. This matches the cleanup pattern used by
vhost-scsi.

Fixes: b430a2bd23 ("vdpa: add vdpa-dev support")
Co-developed-by: Miao Kezhan <miaokezhan@baidu.com>
Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260622100145.18924-1-lizhaoxin04@baidu.com>
(cherry picked from commit e03463812e74d1befc8d7f6f158eca531e2d6406)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 4532d63653e..7d98b23b471 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -173,6 +173,7 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+    struct vhost_virtqueue *vqs = s->dev.vqs;
     int i;
 
     virtio_set_status(vdev, 0);
@@ -184,8 +185,8 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 
     g_free(s->config);
-    g_free(s->dev.vqs);
     vhost_dev_cleanup(&s->dev);
+    g_free(vqs);
     g_free(s->vdpa.shared);
     qemu_close(s->vhostfd);
     s->vhostfd = -1;
-- 
2.47.3


