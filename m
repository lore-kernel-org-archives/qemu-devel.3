Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22572EB28FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIXB-0001tc-48; Fri, 06 Feb 2026 04:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWk-0001mW-V8
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:30 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWj-0000IN-6z
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 35F2F80790;
 Fri, 06 Feb 2026 12:53:23 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2rKPQc0AN0U0-2SnROiBM; Fri, 06 Feb 2026 12:53:22 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770371602;
 bh=EHU0JtzEchd2tV2O83FiXLcbjEVvWFHw9hLrSrRDHzc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=w+UytmzhkUwQ/ArGOou0hKt4xjMP0DPqM01TDfJCnFxYi9zgM4496wowpVJ8Wa271
 ki4yBdK+o5xnacf94RP22dMUhfPGd66ofLSVfO4PcegI1sRFEHkQeS/GDxyw29tB2w
 lIZz0XZAG7NCbCJNywxo8vgNaWY2h2H31Ra9mkXE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v5 13/23] vhost: simplify calls to vhost_memory_unmap()
Date: Fri,  6 Feb 2026 12:52:47 +0300
Message-ID: <20260206095258.894504-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206095258.894504-1-vsementsov@yandex-team.ru>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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
index ef39eab743..52453b36e3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1385,12 +1385,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
 
@@ -1437,12 +1434,9 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
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


