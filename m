Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4D4C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn2xT-0004qD-Rk; Thu, 23 Jul 2026 19:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wn2xS-0004o0-5z
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wn2xQ-0001bW-Ly
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 19:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784849763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AfJlX1tGhaTw01Rp5piHkBwod85V9kS02c+CRcFyx7w=;
 b=btrfXYRSLGHbDdECzJr/Jm4r5BzQXaxaYDdnOe7St8lowas1B2PWE5f2Tr35STK1ztRKSN
 aDgIPBarLUz4xvwDJo6zNGbxf8tTK7RfMoF0RKSq659uexcX2sWODNhUqHuGJDKg/UB1iE
 5eL9R85eCELAeBRdrfzb3NdptFw13EA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-Lm_NTdyVMjCeekAJxL5-mw-1; Thu,
 23 Jul 2026 19:36:00 -0400
X-MC-Unique: Lm_NTdyVMjCeekAJxL5-mw-1
X-Mimecast-MFC-AGG-ID: Lm_NTdyVMjCeekAJxL5-mw_1784849759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F48F1977654; Thu, 23 Jul 2026 23:35:59 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10F3718001CC; Thu, 23 Jul 2026 23:35:56 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 alxndr@bu.edu
Subject: [PATCH] hw/net/virtio-net: Protect from DMA re-entrancy bugs
Date: Fri, 24 Jul 2026 01:35:55 +0200
Message-ID: <20260723233555.2970619-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

This update was missing in CVE-2024-3446 fix.

Fixes: CVE-2026-66022
Cc: qemu-stable@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: alxndr@bu.edu
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4073
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/virtio-net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb29032..7033664ac0c8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2991,8 +2991,9 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
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
2.54.0


