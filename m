Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CC7CCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squJH-0003wU-N2; Wed, 18 Sep 2024 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ubuntu@ubuntu>) id 1sqp4q-0007Rf-1G
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:26:16 -0400
Received: from [222.128.9.250] (helo=ubuntu)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ubuntu@ubuntu>) id 1sqp4n-0000TG-Tq
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 03:26:15 -0400
Received: by ubuntu (Postfix, from userid 1000)
 id 5E7E242E1; Wed, 18 Sep 2024 07:19:55 +0000 (UTC)
From: xiangwencheng@gmail.com
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	BillXiang <xiangwencheng@gmail.com>
Subject: [PATCH v4] vhsot-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
Date: Wed, 18 Sep 2024 07:19:30 +0000
Message-ID: <20240918071930.28771-1-xiangwencheng@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 222.128.9.250 (failed)
Received-SPF: none client-ip=222.128.9.250; envelope-from=ubuntu@ubuntu;
 helo=ubuntu
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 FSL_HELO_NON_FQDN_1=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 HELO_NO_DOMAIN=0.166, NML_ADSP_CUSTOM_MED=0.9, RDNS_NONE=0.793, SPF_NONE=0.001,
 SPOOFED_FREEMAIL=0.001, SPOOFED_FREEMAIL_NO_RDNS=0.001,
 SPOOF_GMAIL_MID=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Sep 2024 09:01:29 -0400
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

From: BillXiang <xiangwencheng@gmail.com>

Clean up commit 7c211eb078c4 ("vhost-user: Skip unnecessary duplicated 
VHOST_USER_SET_LOG_BASE requests") which has added VHOST_USER_SET_LOG_BASE
to vhost_user_per_device_request and will not send it in vhost_user_write
when vq_index != 0 but still wait for replies in vhost_user_set_log_base
for those not sent msgs which will cause qemu hangs up.
So we add check in this patch to read reply only when vq_index == 0.


Signed-off-by: BillXiang <xiangwencheng@gmail.com>
---
V3[1] -> V4:
 - rewrite the commit log to make it clear

[1]https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg01852.html
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..fd12992d15 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
         return ret;
     }
 
-    if (shmfd) {
+    if (shmfd && dev->vq_index == 0) {
         msg.hdr.size = 0;
         ret = vhost_user_read(dev, &msg);
         if (ret < 0) {
-- 
2.30.0


