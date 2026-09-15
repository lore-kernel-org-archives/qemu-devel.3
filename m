Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C35C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vqp-0003FX-BW; Tue, 15 Sep 2026 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6Vqg-0003FB-Fo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:17:35 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6Vqe-0007O7-7t
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:17:34 -0400
Message-ID: <13ad0871-44dd-40eb-aad1-d08cc2d7dfe5@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1789489048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2DjEtRCtdauQXNDedT+2xLAS27KLrQEkzuO1dLWhZaQ=;
 b=HaovFGlm2/JNgp/vCao6aLB+yUx74xJLAeNteqAGwHgCjo8uNxE9GQOAa3I5uXB8AZ7P8/
 XuiQ1n++kb35clGnMox0N5FinEY6kapY3b0YFr5unXht2D/i9Dr10ReSkaz+2H+aONMLFP
 /N7di+oC1UAT5AHYCqSMn+MnsQ1yBNM=
Date: Tue, 15 Sep 2026 19:17:28 +0300
MIME-Version: 1.0
Content-Language: en-US, ru-RU
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Subject: PATCH] hw/s390x/s390-hypercall: fix potential NULL dereference in
 handle_virtio_ccw_notify
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=zorin@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SWSA#4992cdf0-415c-45c1-be1a-71213467347d

The `virtio_ccw_get_vdev()` function can return a `NULL` pointer if the
corresponding subchannel driver data (`sch->driver_data`) is not initialized
or has been cleared.

If `vdev` is `NULL`, passing it directly into 
`virtio_queue_get_num(vdev, vq_idx)`
results in a `NULL` pointer dereference, which can lead to a hypervisor
crash or unexpected termination of the QEMU process.

Fix this by adding an explicit check for `!vdev` before verifying the
queue index and its capacity, returning `-EINVAL` early if the device
is missing or not bound to the subchannel.

Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
---
  hw/s390x/s390-hypercall.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index ac1b08b2..fd2972c0 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -44,7 +44,7 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, 
uint64_t data)
      }

      vdev = virtio_ccw_get_vdev(sch);
-    if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, 
vq_idx)) {
+    if (!vdev || vq_idx >= VIRTIO_QUEUE_MAX || 
!virtio_queue_get_num(vdev, vq_idx)) {
          return -EINVAL;
      }
-- 
2.43.0


