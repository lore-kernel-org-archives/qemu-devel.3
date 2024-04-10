Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DC1CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSQR-00058f-ED; Wed, 10 Apr 2024 03:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQ5-0004Yg-N0; Wed, 10 Apr 2024 03:30:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQ2-0005Pd-Of; Wed, 10 Apr 2024 03:30:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 696D65D6C1;
 Wed, 10 Apr 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0E938B0301;
 Wed, 10 Apr 2024 10:23:10 +0300 (MSK)
Received: (nullmailer pid 4191895 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 81/87] block/virtio-blk: Fix memory leak from
 virtio_blk_zone_report
Date: Wed, 10 Apr 2024 10:22:54 +0300
Message-Id: <20240410072303.4191455-81-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zheyu Ma <zheyuma97@gmail.com>

This modification ensures that in scenarios where the buffer size is
insufficient for a zone report, the function will now properly set an
error status and proceed to a cleanup label, instead of merely
returning.

The following ASAN log reveals it:

==1767400==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 312 byte(s) in 1 object(s) allocated from:
    #0 0x64ac7b3280cd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x735b02fb9738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x64ac7d23be96 in virtqueue_split_pop hw/virtio/virtio.c:1612:12
    #3 0x64ac7d23728a in virtqueue_pop hw/virtio/virtio.c:1783:16
    #4 0x64ac7cfcaacd in virtio_blk_get_request hw/block/virtio-blk.c:228:27
    #5 0x64ac7cfca7c7 in virtio_blk_handle_vq hw/block/virtio-blk.c:1123:23
    #6 0x64ac7cfecb95 in virtio_blk_handle_output hw/block/virtio-blk.c:1157:5

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Message-id: 20240404120040.1951466-1-zheyuma97@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit bbdf9023665f409113cb07b463732861af63fb47)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 31aac14581..59fb3e9a8e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -783,7 +783,8 @@ static void virtio_blk_handle_zone_report(VirtIOBlockReq *req,
             sizeof(struct virtio_blk_zone_report) +
             sizeof(struct virtio_blk_zone_descriptor)) {
         virtio_error(vdev, "in buffer too small for zone report");
-        return;
+        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        goto out;
     }
 
     /* start byte offset of the zone report */
-- 
2.39.2


