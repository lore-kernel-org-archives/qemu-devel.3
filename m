Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970A2C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jA-0000Sr-MP; Wed, 12 Aug 2026 09:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ic-0008JK-AM; Wed, 12 Aug 2026 09:10:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8iZ-0005kE-Dz; Wed, 12 Aug 2026 09:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=JLB0XF+fgU/gH+1fEvdNn6QH1Cva8eg9N4UvEqaXAzg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q15asX9qtdwbAuGpOZyq3WfW1UmNUkPDI2AF9QpIavdas6bJPz9QT1uCifINDDHiu
 k31oD3/V8uNxC/ixN/wCgMDIrI8VWoEc7Qo52WmGeGSkG1dXvOtQGOKrnk75BsHG4z
 clq1CkDga46Udsh+avve9YHznztZ+sp5SrZJhlVM66VuoBEe3h6KEWves2caqHxB5z
 MR/R0Oqccd3h/jg5uVKk1U/TKtIK/yCm8hia+6zd8IZYMZHJU85BDAvzswkHZxhngB
 iIfi4cerFfSNjHn7NIHB486HyEVNDLehmL74uA/Ervj1vLGvQOCmT8SAuuIv0i5tp8
 6ULubZFun8dGg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5CA6D1CA4C6;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 92F05409BA9;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 87F802F922; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 071/102] virtio-mmio: fix QUEUE_NUM_MAX
Date: Wed, 12 Aug 2026 16:01:46 +0300
Message-ID: <20260812130233.621965-71-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
index c20dc5767cd..b2ac868a4b9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2561,6 +2561,12 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
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


