Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE6C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 04:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQgNv-0002aX-Kb; Mon, 08 Jul 2024 00:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sQgNs-0002Zv-N5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 00:53:52 -0400
Received: from va-1-19.ptr.blmpb.com ([209.127.230.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sQgNo-00061u-LV
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 00:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1720414413;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=IjebSU2V/HBvnzPP+7/jsXjfRTnXczB2Xne9UyY+2iE=;
 b=q7UVTbLtu4syFkWqZIPRo/tVWai/zAiZ//oT8K4GZK+myry5/RLCK8OYJVkS2ukMMtqoea
 8WAHnex/iKqLqJR6rr0NMPNhGpAuVmrykgK+7yFvxVUcVMSq3iCxXCSIdAuLmndXhsQ4aB
 7q1OWmvnwa7rLeP9gnOx5OjwEjobCsaWJXEITDp9LF9d0WRnnRhBLBRv4DXpF6b96OZGeH
 PpcgAW3x7Dit3XmEAHw9uOGmFh3i4pNB25PJQWUUssA3gQY8ilYFFWO8RFG+56JgMfFwAt
 HKADhtwYKnFLUBjk0UaLDftf6eBQyKzfWD5GxCBRRZaibj2UM1fsBKVw89wqHQ==
X-Mailer: git-send-email 2.30.0
To: <qemu-devel@nongnu.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from localhost.localdomain ([221.216.117.144]) by smtp.feishu.cn
 with ESMTPS; Mon, 08 Jul 2024 12:53:32 +0800
Subject: [PATCH] vhsot-user: Do not wait for replay for not sent
 VHOST_USER_SET_LOG_BASE
X-Lms-Return-Path: <lba+2668b70cd+cea2f7+nongnu.org+xiangwencheng@dayudpu.com>
Date: Mon,  8 Jul 2024 12:50:54 +0800
Message-Id: <20240708045054.65040-1-xiangwencheng@dayudpu.com>
Content-Type: text/plain; charset=UTF-8
Cc: <mst@redhat.com>, <alex.bennee@linaro.org>, 
 "BillXiang" <xiangwencheng@dayudpu.com>
From: "BillXiang" <xiangwencheng@dayudpu.com>
X-Original-From: xiangwencheng@dayudpu.com
Received-SPF: pass client-ip=209.127.230.19;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-1-19.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Hello, there are some code that must be added to my last
commit 7c211eb078c42146ee9a441cc028fbc4c378ef5a of
'Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests'.
We can not wait for replies from those duplicated VHOST_USER_SET_LOG_BASE that not really sent.

Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
---
 hw/virtio/vhost-user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..8451d9019a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -440,7 +440,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     int ret;
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_LOG_BASE,
-        .hdr.flags = VHOST_USER_VERSION,
+        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
         .payload.log.mmap_size = log->size * sizeof(*(log->log)),
         .payload.log.mmap_offset = 0,
         .hdr.size = sizeof(msg.payload.log),
@@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
         return ret;
     }
 
-    if (shmfd) {
+    if (shmfd && (msg.hdr.flags & VHOST_USER_NEED_REPLY_MASK)) {
         msg.hdr.size = 0;
         ret = vhost_user_read(dev, &msg);
         if (ret < 0) {
-- 
2.30.0

