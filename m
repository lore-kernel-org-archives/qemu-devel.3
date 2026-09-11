Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE15C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8o-0001nX-2u; Fri, 11 Sep 2026 05:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8V-0001aC-EJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8T-00080k-VB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cztzzK3RRsXNvSO1Mj0DbxdXP/qmCz45hPp6THADzZ0=;
 b=GVuRLuHU4uMiW+Df9ZqF/59+sWio9wSrVJSOvtzPRp4F6tkCRTBYX/ZFG2MjSy7A0L0scf
 NTLxXnxd2LyrU4m9XGIE1n74MfxMq6LePrEGetOzgtZ28xr4nGXPFQuXQvtuYKQiSVMAt2
 8mFbvcm+o8QQgJjxMDuo1j0Tc5kHVAY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-7daRJ0bvOQi_Ufi6DnhEiA-1; Fri, 11 Sep 2026 05:01:27 -0400
X-MC-Unique: 7daRJ0bvOQi_Ufi6DnhEiA-1
X-Mimecast-MFC-AGG-ID: 7daRJ0bvOQi_Ufi6DnhEiA_1789117287
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c29466736e3so77959266b.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117286; x=1789722086; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cztzzK3RRsXNvSO1Mj0DbxdXP/qmCz45hPp6THADzZ0=;
 b=KcYkn9xqDRVhhmeeFpcAr9a6r+3schAihduhMPM5A5jHNjyHQHqs3fRksxSfrKdEqj
 fvOUOGJQVscGufm+yr/ZuS7WV6EXYvpZhNxyV130HOXdQwLoHtTP7NwG1zIgcJE7l4Wc
 f3DZuMuqKQGnh5TRP7zrtIG/P6zINWZxFcc8thdehH5X4Hi+tXT7lHnfBwGA8uMyNjPo
 R0Vlx5AAaZ1AnG57f+hiP5oYyqxz4wZay1YcH0uFIucsS4nPRK+6uQ7Yd1R7o8QwDIas
 9bTpmLQcY257F80Ew2vNqbv0nJlG6FNDSKsdrA9JlsLEZYLRwVYxQ4IBuPdq46sOLYcV
 kzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117286; x=1789722086;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cztzzK3RRsXNvSO1Mj0DbxdXP/qmCz45hPp6THADzZ0=;
 b=eISa98iRmJDBCOjzAwe/zjU1OsMP2Hic3kMdaytJrMuj2szAglRC+aj9RN9mZ1sh9W
 CG9JjaHuAXYlFX79hEgDIRLVXzdoJwKSMnGiPtBwDKDVCeNFN5iSTxlZR61tQZNbEYQu
 4qFASQ3XH58rN8YRWZ2FXyk0aTPE2/tkUKEBJoT6XbopKhRRrK6vpPlXpR7MlFWIEp0O
 4jC2O65FrBTytqYUkJLBbZwrkzqY9SEuz0Nl9/OzCd3DDAncg8MuHAdlClLHdxXeXkMQ
 wkaALWaUqAY42p+HpXfur7wuLMA0MRMZ9VvuUlivmZBLVzkN84N0TW6tPquEg7O5ydQW
 5UJA==
X-Gm-Message-State: AFuF++nCAElY+uL414yFVXI5Qcf2BgC/LC4JL/hKFr9dpmJU6/ai34uX
 6BbL7RMoqgf18Ah/OKHd2xB/pD5hfH8KgnnBHsX4M+hyMhwN3tFoKS6sKh8wS9WordWRKMZPmeM
 dxktilbkJu0dAsCL3u9ZK/YUCfVKbw+/H6MeX3MCTvRmwfFa6tNghwWhZy2wJO1uRn0Po1WreWM
 S24T2cYfEU/ALqicCgGKGXPrVcxqyUJLaYGg==
X-Gm-Gg: AYBFou0U2V5C2Nz4rvwVNiz1y4xjm5ezqmpQgOPIu9JMz4riI90mCkr2IJCSzb2uS6M
 yJgMoh0XfNqX0VSZLn8DwRlH3zNQkdqNTDglyGx9bKrQvYrHDiuWv5MCM+D7WXyX+bQB/epPYOx
 Y5mnaiZVP6PyI2qVhbL8wv2zkolwWIGlxFtBLHoV9o8H0S0uvyuVr6coqpu5fHNyrtlmmR+KG+I
 c3wyqAuq/3V/SbNS6cR/gS88vAXd7nkMGLnd90o0tzt9k5S5CDLGDZVdk0P6Ly4Ia3my2qdqHVa
 lZZ5OLWe0R/+4P000uPxlEihiLiDbEY3/AIupy0clzPJqpI5eF5yWUu5asvpfMCe8FTbdoRanMX
 eviECUwGVCgnF56gWGLAyQfM=
X-Received: by 2002:a17:907:a396:b0:c25:4b9c:5ed1 with SMTP id
 a640c23a62f3a-c29665502efmr119484566b.12.1789117286150; 
 Fri, 11 Sep 2026 02:01:26 -0700 (PDT)
X-Received: by 2002:a17:907:a396:b0:c25:4b9c:5ed1 with SMTP id
 a640c23a62f3a-c29665502efmr119477966b.12.1789117285116; 
 Fri, 11 Sep 2026 02:01:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c296608dc91sm56569066b.39.2026.09.11.02.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:24 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kangjie Xu <kangjie.xu@linux.alibaba.com>
Subject: [PULL v2 03/75] virtio-pci: reject Q_ENABLE write on already-enabled
 queue
Message-ID: <62976e8a2ea7fcc8c635754739fbaf2c499dc754.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

When the guest writes 1 to the VIRTIO_PCI_COMMON_Q_ENABLE field of a
queue that is already enabled, QEMU re-applies the ring geometry stored
in the PCI proxy shadow registers by calling virtio_queue_set_num() and
virtio_queue_set_rings().  Those functions update the vring descriptor,
available, and used addresses and the region cache, but they do not
touch the host-side progress fields - last_avail_idx, shadow_avail_idx,
used_idx, inuse, and the packed-ring wrap counters - which are only
zeroed by __virtio_queue_reset().

Because the progress indices are stale while the ring layout is new, the
host can treat the new ring as though there are up to 65535 pending
descriptors already waiting, causing virtqueue_pop() to iterate far
beyond what the guest actually posted.  On virtio-iommu this translates
into a stream of ATTACH/DETACH/MAP/UNMAP commands, driving the QEMU
process toward OOM from guest-controlled BAR writes.

The virtio specification requires the driver to complete a full queue
reset cycle before re-enabling a queue.  Fix this by checking the
proxy's per-queue enabled flag before processing the write.  If the
queue is already enabled, log the violation as a guest error and ignore
the write.

Fixes: d1060e3dc5 ("virtio-pci: support queue enable")
Cc: Kangjie Xu <kangjie.xu@linux.alibaba.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6f5db5fc42..c73f1f546c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1692,6 +1692,13 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
         if (val == 1) {
+            if (proxy->vqs[vdev->queue_sel].enabled) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: queue %d already enabled - "
+                              "reset queue before re-enabling\n",
+                              __func__, vdev->queue_sel);
+                break;
+            }
             virtio_queue_set_num(vdev, vdev->queue_sel,
                                  proxy->vqs[vdev->queue_sel].num);
             virtio_queue_set_rings(vdev, vdev->queue_sel,
-- 
MST


