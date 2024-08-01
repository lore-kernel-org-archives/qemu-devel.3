Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E78C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVCF-00026T-Kk; Thu, 01 Aug 2024 08:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sZVC8-0001si-H9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:46:12 -0400
Received: from va-2-32.ptr.blmpb.com ([209.127.231.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@dayudpu.com>)
 id 1sZVC2-0004wr-MY
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dayudpu-com.20200927.dkim.feishu.cn; t=1722516357;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=qQPQSCLdpGd+ZkKO2i/qo4nGvPM3halWZA8Mlxztrqs=;
 b=esnkDK2tjlps1IQGEHGwTnbENCzXKeMbuOqSAZytcHHO0izv9qR3LeIdQM3x5AjYHQtrt9
 SJHrOIy7TBAC/NBy4ymOTUONMBUlCn667zV9cLJIdd5JLgq1kXpMA/DJszIWq8QlF3Hx1d
 p5Fav1uQdxz2lg4tpjQpl5rIFhJR2qM250dpMyseSIrG5WfixVSepRTSZZylHbyhigFQb5
 AwqR4n0dmZzvE/YBeg+C+LEDITVqLt//uPEOwQv6M9jWi7Vw8XPsXM4bsGcGLRnORJ+MJE
 yhhVioC5j8LgT4iNRU3fbDPAzGFus8I8rDyOfyZf4CrXipLpwahwqdD8YRuDaw==
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
Content-Transfer-Encoding: 7bit
Message-Id: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
X-Mailer: git-send-email 2.30.0
Received: from localhost.localdomain ([124.64.23.165]) by smtp.feishu.cn with
 ESMTPS; Thu, 01 Aug 2024 20:45:56 +0800
Date: Thu,  1 Aug 2024 20:45:40 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <mst@redhat.com>, "BillXiang" <xiangwencheng@dayudpu.com>
From: "BillXiang" <xiangwencheng@dayudpu.com>
Mime-Version: 1.0
X-Original-From: xiangwencheng@dayudpu.com
X-Lms-Return-Path: <lba+266ab8385+ea05c4+nongnu.org+xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=209.127.231.32;
 envelope-from=xiangwencheng@dayudpu.com; helo=va-2-32.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
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

From: BillXiang <xiangwencheng@dayudpu.com>

Currently, we have added VHOST_USER_SET_LOG_BASE to 
vhost_user_per_device_request in commit 7c211eb078c4 
("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests"), 
as a result, VHOST_USER_SET_LOG_BASE will be sent only once 
when 'vq_index == 0'.
In this patch we add the check of 'vq_index == 0' before 
vhost_user_read, such that we do not wait for reply for not
sent VHOST_USER_SET_LOG_BASE.

Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
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

