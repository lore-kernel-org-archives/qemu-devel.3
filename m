Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D091C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnwM-0006Gq-7y; Mon, 03 Aug 2026 04:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wqnwJ-0006GX-Jc; Mon, 03 Aug 2026 04:22:28 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wqnwE-0004yU-Ba; Mon, 03 Aug 2026 04:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785745321; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=y1Q8i2iYq0RjyKWrT6Ztl3CM44wiJ0LqRiZoy8IoF2U=;
 b=tZTFHnL35RRAbh6RnmwYa/bzekIXUUu3LVOSORpGYZ+ZTuYIKHz/HErwCSrKot2d6B78LSTi0T3qlluTNbSsBuermqiYW3fTSJKSJSHdOYqJOgTavh3VxRIht1FR3Z7AhcxwUV6yGKdYSQZUctZO0/N1iNqovOt2ony5R565zos=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X8HSVZC_1785745319; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X8HSVZC_1785745319 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 03 Aug 2026 16:22:00 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/display/virtio-gpu: Unmap DMA regions on reset
Date: Mon,  3 Aug 2026 16:21:58 +0800
Message-ID: <20260803082158.62998-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

virtio_gpu_reset() freed in-flight commands without unmapping the
DMA regions acquired by virtqueue_pop().  Call virtqueue_detach_element()
before g_free() in both drain loops.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3467
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/display/virtio-gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 4d46a4eb10..96c0d15930 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1687,12 +1687,14 @@ void virtio_gpu_reset(VirtIODevice *vdev)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd = QTAILQ_FIRST(&g->cmdq);
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
         g_free(cmd);
     }
 
     while (!QTAILQ_EMPTY(&g->fenceq)) {
         cmd = QTAILQ_FIRST(&g->fenceq);
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
+        virtqueue_detach_element(cmd->vq, &cmd->elem, 0);
         g->inflight--;
         g_free(cmd);
     }
-- 
2.50.1 (Apple Git-155)


