Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB3CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNc5-0002bY-PE; Thu, 04 Apr 2024 09:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rsNc3-0002aI-L2
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rsNc2-0006B6-5Q
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712239121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U78P+c+Y09VAuZb+FNDJxWeD52AjyEYHQTDsJZ90EII=;
 b=YZ4GWoZHAHQiUnFUEF97sYKmbfRTuDUWAS0QsyCHh87l8Xbn40Gl0O+suAuI9EWSHEyUkM
 3LodSO5uUCvImn8WmRETxA6ZWKQQUKC6GAkTHlWpeR0ObP3O9v4cT6UU4PtP+jKPWjFgsd
 0cTca6agpOOtjxHP7C0WDtn4vQ77gvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ROUZs59QOiO1U9oOeA_cvA-1; Thu, 04 Apr 2024 09:58:37 -0400
X-MC-Unique: ROUZs59QOiO1U9oOeA_cvA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF0E885A5B6;
 Thu,  4 Apr 2024 13:58:36 +0000 (UTC)
Received: from localhost (unknown [10.39.195.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA70D492BCA;
 Thu,  4 Apr 2024 13:58:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PULL for-9.0 1/1] block/virtio-blk: Fix memory leak from
 virtio_blk_zone_report
Date: Thu,  4 Apr 2024 09:58:23 -0400
Message-ID: <20240404135823.2654261-2-stefanha@redhat.com>
In-Reply-To: <20240404135823.2654261-1-stefanha@redhat.com>
References: <20240404135823.2654261-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/block/virtio-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 92de315f17..bb86e65f65 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -768,7 +768,8 @@ static void virtio_blk_handle_zone_report(VirtIOBlockReq *req,
             sizeof(struct virtio_blk_zone_report) +
             sizeof(struct virtio_blk_zone_descriptor)) {
         virtio_error(vdev, "in buffer too small for zone report");
-        return;
+        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        goto out;
     }
 
     /* start byte offset of the zone report */
-- 
2.44.0


