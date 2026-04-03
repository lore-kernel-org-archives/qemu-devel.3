Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5978CE7E358
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ae3-0005LW-KU; Fri, 03 Apr 2026 05:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w8ae0-0005Kc-Nb
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:16:48 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w8ady-0005QE-Jo
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 05:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1775207790; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=5hm8I+JbM6PGG1mMVTB6bqbuy7AeKFvxXupmSTgLp/4=;
 b=Zb91/yBBdFcoTbHF+qr2O0RjWiMCThGYZmPVjlipWjvaMzHzZK7NiKf5LKbUsLZcCBD5SrkWf+fvFO6dFnYkxumOAJjut3BJwB6D13iCAJ1rWwx4r8znqBuTlSAAld2sCrXR8yCfiA2QShFLY7r44esZHoDwygpVKGKx31y3xwg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X0JsEZX_1775207782; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X0JsEZX_1775207782 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 03 Apr 2026 17:16:29 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [PATCH] hw/virtio/vhost: simplify ring mapping verification with loop
Date: Fri,  3 Apr 2026 17:16:21 +0800
Message-ID: <20260403091621.88914-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
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

Replace the three nearly-identical vhost_verify_ring_part_mapping() calls
with a simple loop over arrays. This eliminates code duplication while
maintaining identical behavior and error reporting.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/virtio/vhost.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9dc4ed13b..7b5bfc86e6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -525,31 +525,21 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
             continue;
         }
 
-        j = 0;
-        r = vhost_verify_ring_part_mapping(
-                vq->desc, vq->desc_phys, vq->desc_size,
-                reg_hva, reg_gpa, reg_size);
-        if (r) {
-            break;
-        }
-
-        j++;
-        r = vhost_verify_ring_part_mapping(
-                vq->avail, vq->avail_phys, vq->avail_size,
-                reg_hva, reg_gpa, reg_size);
-        if (r) {
-            break;
-        }
-
-        j++;
-        r = vhost_verify_ring_part_mapping(
-                vq->used, vq->used_phys, vq->used_size,
-                reg_hva, reg_gpa, reg_size);
-        if (r) {
-            break;
+        void *ring_addrs[] = {vq->desc, vq->avail, vq->used};
+        uint64_t ring_phys[] = {vq->desc_phys, vq->avail_phys, vq->used_phys};
+        uint64_t ring_sizes[] = {vq->desc_size, vq->avail_size, vq->used_size};
+
+        for (j = 0; j < 3; j++) {
+            r = vhost_verify_ring_part_mapping(
+                    ring_addrs[j], ring_phys[j], ring_sizes[j],
+                    reg_hva, reg_gpa, reg_size);
+            if (r) {
+                goto out;
+            }
         }
     }
 
+out:
     if (r == -ENOMEM) {
         error_report("Unable to map %s for ring %d", part_name[j], i);
     } else if (r == -EBUSY) {
-- 
2.50.1 (Apple Git-155)


