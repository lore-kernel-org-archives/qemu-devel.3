Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDD0C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7D8B-0001qZ-LJ; Thu, 17 Sep 2026 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D82-0001nn-P1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x7D7y-0007f1-Td
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:30:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 156FBC09A2;
 Thu, 17 Sep 2026 17:30:16 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b33::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id DUXfb20WRqM0-zbIGvtFc; Thu, 17 Sep 2026 17:30:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789655415;
 bh=30gY0D+cOmoXAiLOdYt0Hf63YU23qkYi5n8B76CUyJo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LR99UGOv30j+mC/EgzbQSfXdQSUIvohaphl+I27ZSC1/doz4X7RDpr+wNljSVBDsQ
 MF5hHR5eGPsh3hLMtRtVdao/8pCMN6aKRRbgOQZIcS3tWmqyJMISiGa2fj3ydznwM0
 4lIQgOxAZHfWbto7WAsgOz9HpvOYKinopM1KaMXE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 3/8] vhost-user: store into shadow_regions only regions we
 sent to backend
Date: Thu, 17 Sep 2026 17:30:06 +0300
Message-ID: <20260917143011.881361-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143011.881361-1-vsementsov@yandex-team.ru>
References: <20260917143011.881361-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

No reason to store regions, which we actually don't send. We do
nothing with them.

Feature: vhost-user-blk-fd-mig
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8eaa65392a7..61208597c25 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -730,8 +730,7 @@ static int send_remove_regions(struct vhost_dev *dev,
 {
     struct vhost_user *u = dev->opaque;
     struct vhost_memory_region *shadow_reg;
-    int i, fd, shadow_reg_idx, ret;
-    ram_addr_t offset;
+    int i, shadow_reg_idx, ret;
 
     /*
      * The regions in remove_reg appear in the same order they do in the
@@ -742,13 +741,9 @@ static int send_remove_regions(struct vhost_dev *dev,
         shadow_reg = remove_reg[i].region;
         shadow_reg_idx = remove_reg[i].reg_idx;
 
-        vhost_user_get_mr_data(shadow_reg->userspace_addr, &offset, &fd);
-
-        if (fd > 0) {
-            ret = send_add_rem_mem_reg(dev, shadow_reg, false, 0, 0);
-            if (ret < 0) {
-                return ret;
-            }
+        ret = send_add_rem_mem_reg(dev, shadow_reg, false, 0, 0);
+        if (ret < 0) {
+            return ret;
         }
 
         /*
@@ -777,12 +772,13 @@ static int send_add_regions(struct vhost_dev *dev,
         reg = add_reg[i].region;
 
         vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
+        if (fd <= 0) {
+            continue;
+        }
 
-        if (fd > 0) {
-            ret = send_add_rem_mem_reg(dev, reg, true, offset, fd);
-            if (ret < 0) {
-                return ret;
-            }
+        ret = send_add_rem_mem_reg(dev, reg, true, offset, fd);
+        if (ret < 0) {
+            return ret;
         }
 
         /*
-- 
2.43.0


