Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27030CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbbUB-0001vc-Pg; Mon, 22 Jun 2026 06:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md16272BC2AF=lizhaoxin04@baidu.com>)
 id 1wbbTt-0001uo-B5; Mon, 22 Jun 2026 06:02:19 -0400
Received: from mx21.baidu.com ([220.181.3.85] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md16272BC2AF=lizhaoxin04@baidu.com>)
 id 1wbbTo-0003PL-Tp; Mon, 22 Jun 2026 06:02:16 -0400
X-MD-Sfrom: lizhaoxin04@baidu.com
X-MD-SrcIP: 172.31.4.16
From: Li Zhaoxin <lizhaoxin04@baidu.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Longpeng
 <longpeng2@huawei.com>, miaokezhan <miaokezhan@baidu.com>, lizhaoxin04
 <lizhaoxin04@baidu.com>
Subject: [PATCH] vdpa: fix use-after-free of vqs in vhost_vdpa_device_unrealize
Date: Mon, 22 Jun 2026 18:01:45 +0800
Message-ID: <20260622100145.18924-1-lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1782122522;
 bh=crwQ1DMzva9qW+D1ZNuZR9rfJakIT7qqCBbUd0xzbCI=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=F8dDeFvgdyVN8gNohOf8C9U4RAnnqqATEpz1Knq4lRJ03sXdjuLyYOfT/yRar0Mx+
 sI/gEoYll5Hya0pkYfTVVE4JDlvPWdFsQGMabauAgJlnm5YTCIsoV/27h2wBKYNWMq
 E2sZK7Eub5jpsgvG0iPd4C/ewkmv4PccGVDQqkbKmdSitL/2HMUUSl0pOSI2aMQ0Kw
 Fn6gc+msDCKMA/MGJjB6duDSnuiDXkeNAh0pnWVoZSEhtHCBEZ/4lZ5sHQ6nGhFq7B
 G2wn/eShKKyTyvNb1q1gJ5JNx5560Db5956bA3ovtwr7UAjc9j8EkPMSisIqcambc1
 i7gT///Cny0Ig==
Received-SPF: pass client-ip=220.181.3.85;
 envelope-from=prvs=md16272BC2AF=lizhaoxin04@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/virtio/vdpa-dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 94188d37bb..089a77f4d0 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -172,6 +172,7 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
+    struct vhost_virtqueue *vqs = s->dev.vqs;
     int i;
 
     virtio_set_status(vdev, 0);
@@ -183,8 +184,8 @@ static void vhost_vdpa_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 
     g_free(s->config);
-    g_free(s->dev.vqs);
     vhost_dev_cleanup(&s->dev);
+    g_free(vqs);
     g_free(s->vdpa.shared);
     qemu_close(s->vhostfd);
     s->vhostfd = -1;
-- 
2.17.1


