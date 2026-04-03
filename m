Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95734E85389
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 20:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8lTc-0001MX-C0; Fri, 03 Apr 2026 16:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w8lTa-0001M1-AG
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 16:50:46 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w8lTV-000093-11
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 16:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1775249428; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=S0gH1RNVZ2+dFXuhhk/p/ALCB/w4E8iigHAamMgF1fA=;
 b=KRd3V7Tq7twL5/XZS5am9rGYgrgZSDtflH0IFP+AHm7RxCX/kYzf6ebkI9KIA2sj8eAvZMongoyQfzDCoyqX5xkkj4RRtUNWiCmGEfZL8Sbsx9PyxfAoocv+LQeeX2XpQcfeKotgBdKpIpLH1LEfbZ35NNNDzGKkCExtOPrW0ms=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X0L1tvp_1775249411; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X0L1tvp_1775249411 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 04 Apr 2026 04:50:27 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [PATCH] vhost: return early when memslots overflow in
 vhost_get_free_memslots()
Date: Sat,  4 Apr 2026 04:50:11 +0800
Message-ID: <20260403205011.15962-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=guobin@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

The vhost_get_free_memslots() function continues iterating through all
vhost devices even after detecting a memslot overflow, which is
unnecessary since the result is already determined to be 0.

Use early return to immediately exit the loop when overflow is detected,
avoiding redundant iterations and unnecessary arithmetic operations.
This optimizes the best case from O(n) to O(1) when the first device
overflows, and saves n-k iterations on average where k is the position
of the overflowing device.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/virtio/vhost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9dc4ed13b..9d1b56fa34 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -70,15 +70,16 @@ unsigned int vhost_get_free_memslots(void)
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
         unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-        unsigned int cur_free = r - hdev->mem->nregions;
+        unsigned int cur_free;
 
         if (unlikely(r < hdev->mem->nregions)) {
             warn_report_once("used (%u) vhost backend memory slots exceed"
                              " the device limit (%u).", hdev->mem->nregions, r);
-            free = 0;
-        } else {
-            free = MIN(free, cur_free);
+            return 0;
         }
+
+        cur_free = r - hdev->mem->nregions;
+        free = MIN(free, cur_free);
     }
     return free;
 }
-- 
2.50.1 (Apple Git-155)


