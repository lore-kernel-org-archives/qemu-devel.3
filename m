Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F82C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 10:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTJCu-0005Lu-IT; Fri, 26 Jan 2024 05:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenh@yusur.tech>) id 1rTJCr-0005Lk-DU
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 05:13:05 -0500
Received: from out28-145.mail.aliyun.com ([115.124.28.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenh@yusur.tech>) id 1rTJCo-0005gc-N1
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 05:13:05 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08249918|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00253355-0.000422707-0.997044;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047211; MF=chenh@yusur.tech; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---.WG6x5gm_1706263658; 
Received: from localhost.localdomain(mailfrom:chenh@yusur.tech
 fp:SMTPD_---.WG6x5gm_1706263658) by smtp.aliyun-inc.com;
 Fri, 26 Jan 2024 18:07:43 +0800
From: Hao Chen <chenh@yusur.tech>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: huangml@yusur.tech,
	zy@yusur.tech
Subject: [PATCH] vhost-user: fix the issue of vhost deadlock in nested
 virtualization
Date: Fri, 26 Jan 2024 18:07:37 +0800
Message-Id: <20240126100737.2509847-1-chenh@yusur.tech>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.145; envelope-from=chenh@yusur.tech;
 helo=out28-145.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

I run "dpdk-vdpa" and "qemur-L2" in "qemu-L1".

In a nested virtualization environment, "qemu-L2" vhost-user socket sends
a "VHOST_USER_IOTLB_MSG" message to "dpdk-vdpa" and blocks waiting for
"dpdk-vdpa" to process the message.
If "dpdk-vdpa" doesn't complete the processing of the "VHOST_USER_IOTLB_MSG"
message and sends a message that needs to be replied in another thread,
such as "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", "dpdk-vdpa" will also
block and wait for "qemu-L2" to process this message. However, "qemu-L2"
vhost-user's socket is blocking while waiting for a reply from "dpdk-vdpa"
after processing the message "VHOSTr_USER_IOTLB_MSG", and
"VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" will not be processed.
In this case, both "dpdk-vdpa" and "qemu-L2" are blocked on the
vhost read, resulting in a deadlock.

You can modify "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" or
"VHOST_USER_IOTLB_MSG" to "no need reply" to fix this issue.
There are too many messages in dpdk that are similar to
"VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", and I would prefer the latter.

Fixes: 24e34754eb78 ("vhost-user: factor out msg head and payload")

Signed-off-by: Hao Chen <chenh@yusur.tech>
---
 hw/virtio/vhost-user.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f214df804b..02caa94b6c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2371,20 +2371,14 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
 static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
                                             struct vhost_iotlb_msg *imsg)
 {
-    int ret;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_IOTLB_MSG,
         .hdr.size = sizeof(msg.payload.iotlb),
-        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+        .hdr.flags = VHOST_USER_VERSION,
         .payload.iotlb = *imsg,
     };
 
-    ret = vhost_user_write(dev, &msg, NULL, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return process_message_reply(dev, &msg);
+    return vhost_user_write(dev, &msg, NULL, 0);
 }
 
 
-- 
2.27.0


