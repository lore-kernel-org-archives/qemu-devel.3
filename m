Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D6CCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lt5-0003uy-3K; Mon, 22 Sep 2025 15:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v0iZU-0002Gf-Gu
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:35:20 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhaoxin04@baidu.com>)
 id 1v0iZR-0001tR-Hj
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:35:20 -0400
To: qemu-devel <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Li Zhaoxin <lizhaoxin04@baidu.com>, Gao Shiyuan
 <gaoshiyuan@baidu.com>
Subject: [PATCH] vhost: Do not actively send a config interrupt
Date: Mon, 22 Sep 2025 23:19:32 +0800
Message-ID: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjhj-exc9.internal.baidu.com (172.31.3.19) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
X-FEAS-Client-IP: 172.31.4.16
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=lizhaoxin04@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Sep 2025 15:07:33 -0400
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
Reply-to:  Li Zhaoxin <lizhaoxin04@baidu.com>
From:  Li Zhaoxin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: lizhaoxin <lizhaoxin04@baidu.com>

After the VM is suspended/resumed or live-migrated,
we do not want the guest to output information such as
the capacity of the block device, as this is noticeable to the tenant.
Also, there is no need to immediately send a config notifier
for the virtio device after vhost_dev_start.

Co-developed-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>
---
 hw/virtio/vhost.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12..1f8a495ef8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1847,15 +1847,10 @@ static void vhost_stop_config_intr(struct vhost_dev *dev)
 
 static void vhost_start_config_intr(struct vhost_dev *dev)
 {
-    int r;
-
     assert(dev->vhost_ops);
     int fd = event_notifier_get_fd(&dev->vdev->config_notifier);
     if (dev->vhost_ops->vhost_set_config_call) {
-        r = dev->vhost_ops->vhost_set_config_call(dev, fd);
-        if (!r) {
-            event_notifier_set(&dev->vdev->config_notifier);
-        }
+        dev->vhost_ops->vhost_set_config_call(dev, fd);
     }
 }
 
-- 
2.34.1


