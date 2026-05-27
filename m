Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17408CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7Zg-00049H-KM; Wed, 27 May 2026 02:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZM-0003wg-IY
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:46 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZJ-00040Q-KI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2CC4180773;
 Wed, 27 May 2026 09:16:40 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QGSCNG0ZtGk0-1QA2gkap; Wed, 27 May 2026 09:16:39 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779862599;
 bh=DVN2E1fV05CJbMdBv0cpyI66en0JLWifnhyATE8IemA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=A7iMHsEkVqfYC45zlXHib4ZECklDO4L5Y/dP+r6WuIkHmZUdVczumxxRPkzTUEiUR
 VBCG6DDTnkoB2eaTlAWVzR/v+7IX/U2FdYDpREE6oiw/SH8nhzOsg7HkT9ZnsLVuIu
 Zo4uj4ytOcfhBt9yJ0zfsGFFsuzINTBMER8KqrHY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v7 12/22] vhost: simplify calls to vhost_memory_unmap()
Date: Wed, 27 May 2026 09:16:13 +0300
Message-ID: <20260527061625.11167-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

No reason to calculate memory size again, as we have corresponding
variable for each vring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9b7a984e33..f43e563f0de 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1383,12 +1383,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     return 0;
 
 fail:
-    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
-                       0, 0);
-    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, 0);
-    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, 0);
+    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
+    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
+    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
     return r;
 }
 
@@ -1435,12 +1432,9 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
-                       1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, virtio_queue_get_desc_size(vdev, idx));
+    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
+    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_size);
+    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
     return r;
 }
 
-- 
2.52.0


