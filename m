Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EDEC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMXy-0004dO-Up; Thu, 18 Jul 2024 04:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sUMXw-0004Wt-MB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:31:28 -0400
Received: from va-2-39.ptr.blmpb.com ([209.127.231.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sUMXr-0003Ta-F8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1721291471;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Jpj4cApqlz/aKltcsLqRfycGk42ge3kpyUWn3mEGaTU=;
 b=fYs+fqGemFrF/AuKU2VZmL2IW212W1og+nwoUv290KGheUu/+jcS/WzHEYsZmm8RLHrPMv
 mErIqFe/Dq8WDJ9izfS6XWkqBVLX3YvbRbpA1jel7+5fURvysIi+v3fp+soGnxKnDeBoNz
 yE+DJpMgcULJ6wVhASAtZA8H0P+iDKxXqzVGA8rPwMF0vsi9hpEVEVlb2pYAWSTPWpKMPm
 omuJFTkCHtt1CI7IPeQLQVJA+N/AqgZD8KrkfAfeB8NhHF6NpeQvC9JoFuaXzVWCemxO19
 +N9tXXZuwr1n3H5l8UAQAcNFtXL2wO9RtzUylQVRs2tmxmTn7+mQbcmJSnU6nA==
Message-Id: <20240718083103.56214-1-xiangwencheng@dayudpu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.30.0
Subject: [PATCH v2] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
X-Lms-Return-Path: <lba+26698d2ce+9160f4+nongnu.org+xiangwencheng@dayudpu.com>
X-Original-From: xiangwencheng@dayudpu.com
Cc: <mst@redhat.com>, "BillXiang" <xiangwencheng@dayudpu.com>
To: <qemu-devel@nongnu.org>
From: "BillXiang" <xiangwencheng@dayudpu.com>
Date: Thu, 18 Jul 2024 16:31:03 +0800
Received: from localhost.localdomain ([221.216.117.177]) by smtp.feishu.cn
 with ESMTPS; Thu, 18 Jul 2024 16:31:09 +0800
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=209.127.231.39;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-39.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: BillXiang <xiangwencheng@dayudpu.com>

We have added VHOST_USER_SET_LOG_BASE to vhost_user_per_device_request
in https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg02559.html
and will send this message only for vq 0.

Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
---
V1[1] -> V2:
 - Refrain from appending flags to messages that could 
precipitate validation failures upon execution of the 
`vhost_user_read_header` function. 

[1]https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg01923.html
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
+    if (shmfd && (dev->vq_index == 0)) {
         msg.hdr.size = 0;
         ret = vhost_user_read(dev, &msg);
         if (ret < 0) {
-- 
2.30.0

