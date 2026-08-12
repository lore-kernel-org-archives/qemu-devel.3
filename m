Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D0AC5DF60
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAP8-0005vA-TD; Wed, 12 Aug 2026 10:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAO8-0004K8-CE; Wed, 12 Aug 2026 10:57:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAO6-0000l3-2H; Wed, 12 Aug 2026 10:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=31Hsac1KSUIyuwAvt5m2V0BuYyjpUbQDqYLVPhvvkWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fdLmY7W5i4yffKsMZexMN62ZLoJpasQAbyhgO16HSaUR5VE1sG/m+lpQXyGbiB8Vs
 S37ppHE0sXXMSjQMgc9E1wZHqCtOV7WaN/PdeUIVnjTvc8kDTkEHhwR6OeQGvVnPdm
 USk0S44SnA0PvgEqjtjM5mg/5F+OSTCXIDUJx1jbVuR09b8/s0uI0rbQH5pOH9OsQ9
 s8udP+noQI7j88jt4IkMk8rxisK8QCo+ElLK2PV6k+XD+LIw+qvzzmnWGRdqC3m9Fh
 KoHtf02+NApVrIdjCcSIGriqduEpHi/laFVnnSsS5frqlzzyM9Ffz3c+Pey7gCp6hq
 RwgakiFDHi5kQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 90E521CA646;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EAA59409D88;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 562C62F9E7; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 alxndr@bu.edu, Giovanni Vignone <gio@octane.security>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 066/120] hw/net/virtio-net: Protect from DMA
 re-entrancy bugs
Date: Wed, 12 Aug 2026 17:48:49 +0300
Message-ID: <20260812144955.649205-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Laurent Vivier <lvivier@redhat.com>

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

This update was missing in CVE-2024-3446 fix.

Fixes: CVE-2026-66022
Cc: qemu-stable@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: alxndr@bu.edu
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4073
Reported-by: Giovanni Vignone <gio@octane.security>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260723233555.2970619-1-lvivier@redhat.com>
(cherry picked from commit df12999cc81339ffb252875608919c72ccc37bcd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7e0c984ec64..814b99a43d2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3009,8 +3009,9 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
         n->vqs[index].tx_vq =
             virtio_add_queue(vdev, n->net_conf.tx_queue_size,
                              virtio_net_handle_tx_bh);
-        n->vqs[index].tx_bh = qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
-                                                  &DEVICE(vdev)->mem_reentrancy_guard);
+        n->vqs[index].tx_bh = virtio_bh_new_guarded(DEVICE(vdev),
+                                                    virtio_net_tx_bh,
+                                                    &n->vqs[index]);
     }
 
     n->vqs[index].tx_waiting = 0;
-- 
2.47.3


