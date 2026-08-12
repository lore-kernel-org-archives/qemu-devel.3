Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A184C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8hj-0006bM-HB; Wed, 12 Aug 2026 09:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hE-00059U-5U; Wed, 12 Aug 2026 09:08:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8hC-0005XB-DA; Wed, 12 Aug 2026 09:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=+DExdsv9AqEXAJL/QR7LlbdAB3p6+5NMhr0eBznDRxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BdLXrE8feyLeXsWj4CHf2X8FIghNyNsGH2mL2f7m72fewIgqTNmo1nnclOzrEWv0G
 zOVd581fNDcXn3Ojbl76M5pp/qrj/8tEvumyM+b1HYscfY2Eur/G69rkHZ0iI8oYU9
 p8SyYd9JLppnaxI7p7p6QaUOsRmxn34oQe/cAE/IgjyLcAzNfquv/y1O3DUxyfxCRj
 guwNFx0o5e9gzHOd3jFv2ujHxwASBnf83GsuEHmakQa7PuTTGV6/AenNcwNaolx27+
 R9RRri/v5Kul5fSTYqVEvDcwu2oNzpXUnPzJbqnkNNKwsUTmW8fvnFsmpN1MNNfxzv
 s6dqWcal7eHoA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 296D51CA4BA;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FF40409B9D;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 65B052F90A; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Anatol Belski <anbelski@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 059/102] virtio: avoid packed vring
 virtio_queue_empty() infinite loops (CVE-2026-16457)
Date: Wed, 12 Aug 2026 16:01:34 +0300
Message-ID: <20260812130233.621965-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Virtqueue handler functions in device emulation code often look
something like this:

  while (!virtio_queue_empty(vq)) {
      ...pop and process virtqueue element...
  }

virtio-blk, virtio-scsi, virtio-crypto, and vhost-shadow-virtqueue use
this pattern.

The device may break (i.e. hit an error that requires device reset)
during the loop. virtio_queue_empty() returns 1 for broken split vrings
but not for broken packed vrings, leading to an infinite loop.

Adjust the packed vring behavior to match split vrings and avoid
infinite loops.

Fixes: CVE-2026-16457
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3968
Reported-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260721134424.196337-1-stefanha@redhat.com>
(cherry picked from commit 6682ea3391277e732a6d74c5758206ba834e1615)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index baad0aa571f..c20dc5767cd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -714,6 +714,10 @@ static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
     struct VRingPackedDesc desc;
     VRingMemoryRegionCaches *cache;
 
+    if (virtio_device_disabled(vq->vdev)) {
+        return 1;
+    }
+
     if (unlikely(!vq->vring.desc)) {
         return 1;
     }
-- 
2.47.3


