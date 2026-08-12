Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA55BC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQB-0008Gm-Gr; Wed, 12 Aug 2026 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPy-0007o4-Jt; Wed, 12 Aug 2026 10:58:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAPv-0001Hv-B7; Wed, 12 Aug 2026 10:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=AAbptm0AF4jGQuSmyLzP25yTFvb4uGnfwu/Z/nzdhpU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R6gtEwpb5ciNGkcXqBPalUTP1QYMUoGlJaa/nPjed1wVO4H3AT2lL7qyWaFDmgi3n
 u3x+f1h5Cnv0xJIJCOY9rEswZUIXT8Insp0flWnBtB3oXNt41N7kxYQe3pmjg0LS4r
 qg6cx3f5GuVNXlOJyTHy9TCvW6JmjXs1pWVXbnuyt1piKrRjEHu7pjBV0w3uftumYs
 G+oOJJ7kCCcdIzKLkxeFmudzDdB5Q75vFCUbxFOXnrqKRt+OWxzV8Z3wINJgAFTSeR
 WSrksAnW9K4RzV+TPWc/M8QGkr4pUX9f/23cRewX9mafMCQlrbW/T6VI1J4bi7jBH/
 zXd5NyUFYhmmg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E7531CA656;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 694AA409D98;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C71BF2FA07; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 082/120] virtio-mmio: fix QUEUE_NUM_MAX
Date: Wed, 12 Aug 2026 17:49:05 +0300
Message-ID: <20260812144955.649205-82-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Michael S. Tsirkin" <mst@redhat.com>

virtio-mmio reports VIRTQUEUE_MAX_SIZE (1024) as QUEUE_NUM_MAX for every
queue, regardless of the size the device passes to virtio_add_queue().

This works by accident because QEMU mostly does not care about the ring
size - the guest is the one allocating memory here.  But this changes
with in-order vqs where qemu is the one allocating resources.
Now, specifying a larger vq than allocated causes an OOB memory access.

To fix:
- for new machine types, report the actual max queue size to guest
- for old machine types, use a compat property to allocate 1k sized
  queues

Fixes: CVE-2026-50626
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <8715acbb9516e67e2a776cda6f9edf105343f788.1784930765.git.mst@redhat.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reported-by: Miku Hatsune <anznu1l@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a5cff318f06cd06b37224e15ee74d64d1df8b12b)
(Mjt: for qemu versions <11.1, always allocate 1k-sized queues,  so whole
 change reduces to one-liner queue size override.  This becomes sufficient to
 fix CVE-2026-50626 for <11.1.  See discussin after this patch pull request at
 https://lore.kernel.org/qemu-devel/a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com/
)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d6fe6019a74..b2b2f5843ed 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2572,6 +2572,12 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
         abort();
 
+    /*
+     * Always set to max queue size for qemu <11.1.  See discussion starting
+     * https://lore.kernel.org/qemu-devel/a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com/
+     */
+    queue_size = VIRTQUEUE_MAX_SIZE;
+
     vdev->vq[i].vring.num = queue_size;
     vdev->vq[i].vring.num_default = queue_size;
     vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
-- 
2.47.3


