Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C4CC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50J4-0001wE-BO; Fri, 11 Sep 2026 08:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md17080B843A=lirongqing@baidu.com>)
 id 1x4wRR-0006MO-PC
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:17:02 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md17080B843A=lirongqing@baidu.com>)
 id 1x4wRM-0007en-Gl
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:17:01 -0400
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 <qemu-devel@nongnu.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] vhost: fix off-by-one in vhost_svq_next_desc with IN_ORDER
Date: Fri, 11 Sep 2026 16:16:35 +0800
Message-ID: <20260911081635.1872-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1789114603;
 bh=NestDftSsnUYTgU67bOf5rFPh02N75F3TDKyOEZraYE=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=XBtaI3+fdgWXl+A5iRJn6t9C7k4LY7Bh7PKVeAsI7EePZV5Uv3VA+EMxUJ+yV6YAn
 CEFZutNKtvi0TynCZTJdGSvqZkld0OAqZVLM4HzPhyrN7vpGTTK/f41LLvRT83kPJT
 RpC4B7ZMgkesAMWNx0xUzqJOwiQXA7ispz5TK59D4u70zSEIVFmh38VQk5WpfAHDnD
 ECpLgkAqlQWN54B2G3m/fYGDE5VUpenlBCSqB7cKVBa+1uUkKBDigZjsavldeBagpK
 BNoAKH0sOT8eH12XqxiRa6STN7y+KxfPRgxz87c4u2p47/f6EsUYGfjZqKFICtnazr
 FfT3NgPqjo0AA==
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=prvs=md17080B843A=lirongqing@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 11 Sep 2026 08:24:34 -0400
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

From: Li RongQing <lirongqing@baidu.com>

vhost_svq_next_desc checks id against vring.num before incrementing,
so when id == vring.num - 1 the function returns vring.num instead of
0.  This causes vhost_svq_vring_write_descs to write descs[num-1].next
= num (an invalid descriptor index) and, on the next iteration, to
access descs[num] — which lies past the descriptor ring and into the
avail ring, corrupting it.

The bug triggers whenever an IN_ORDER descriptor chain wraps around the
end of the SVQ ring.

Fix by incrementing id first, then checking for wrap-around.

Fixes: 485c9e69ef6e ("vhost: add in_order feature to shadow virtqueue")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 9404762..d4f5299 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -155,7 +155,7 @@ static uint16_t vhost_svq_next_desc(const VhostShadowVirtqueue *svq,
                                     uint16_t id)
 {
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
-        return (id == svq->vring.num) ? 0 : ++id;
+        return (++id == svq->vring.num) ? 0 : id;
     } else {
         return svq->desc_state[id].next;
     }
-- 
2.9.4


