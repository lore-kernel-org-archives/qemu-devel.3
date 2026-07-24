Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82354C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCY5-0007ZO-Jo; Fri, 24 Jul 2026 05:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCMK-0008I9-8d
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:38:24 -0400
Received: from m16.mail.163.com ([220.197.31.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCMF-00047C-Bo
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tQ
 MTIxoYrelHX8Jqxj2vSJnnEKo5gsE1tXu7qnSMN1Q=; b=NRgTfxh0dR+uwTXld3
 FG3EGWqkhkmvbx/Qsta+gEiVI03XhSbpAAh8/dAF1tIN0hBjnDhTg1LG3FjJ/6y9
 YTDJfXQZh9dDKIFgGTUIxfab33gvM3biNOZwu6q6Xa95Yl4IPg8tetmxBLoyzbwA
 Ry9rTt/SVEGb/Hp+4YDUmawTI=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgA3D6V3MmNq+dVkHg--.9949S3;
 Fri, 24 Jul 2026 17:37:59 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 3/3] hw/virtio: Add error handling for vhost_virtqueue_mask
 failure
Date: Fri, 24 Jul 2026 17:37:59 +0800
Message-ID: <20260724093759.810108-2-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724093759.810108-1-xiongwm2026@163.com>
References: <20260724093759.810108-1-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgA3D6V3MmNq+dVkHg--.9949S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF45tF1fXr1DJr17JF4xJFb_yoWfKFX_ZF
 1Uu3s7Ww4qkFn0kFsrCF15Zr18Ka1DGFyUWFsYkr1kZw1DJw15G34vyrnrGF4xurs09Fy3
 uw4kuryqqr1S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeZNVPUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8BcdrGpjMndHYAAA39
Received-SPF: pass client-ip=220.197.31.5; envelope-from=xiongwm2026@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 05:50:27 -0400
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

From: Xiong Weimin <xiongweimin@kylinos.cn>

In vhost_virtqueue_start(), the call to vhost_virtqueue_mask() has a
TODO comment indicating errors are not handled. Add proper error
checking and propagate errors to the caller.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/virtio/vhost.c | 10 +++++++--
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1467,9 +1467,13 @@ static int vhost_virtqueue_start(struct VirtIODevice *vdev,
      * will do it later.
      */
     if (!vdev->use_guest_notifier_mask) {
-        /* TODO: check and handle errors. */
-        vhost_virtqueue_mask(dev, vdev, idx, false);
+        int r = vhost_virtqueue_mask(dev, vdev, idx, false);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_virtqueue_mask failed");
+            r = -1;
+            goto fail;
+        }
     }
 
     if (k->query_guest_notifiers &&


