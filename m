Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43C3C44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmAm4-0000n9-9k; Tue, 21 Jul 2026 09:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmAlz-0000cp-0F
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wmAlw-0001UP-4c
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 09:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784641472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cx8vLMJg9zXjhYyWKskgl/CVpCD47uOslPzrLgIp52M=;
 b=dT4tfyOn4CtjVVbVzIxd8c/YNiLoaH/KH5r7Jx4apgqH+xVLpx9LSw9jkp5VpjQjUwn2zB
 J2bCS7JXnMYbVWAKtgdQlLQ7EDDbdRLbNjcO+QFWw3fmUxdW8ztcjhKdKAiG2bCuuOymFT
 93MDog3ZIa3hf3MTBkJyY1fZxI+ezeI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-KKDI551uMEmXrxSTtl1wVQ-1; Tue,
 21 Jul 2026 09:44:28 -0400
X-MC-Unique: KKDI551uMEmXrxSTtl1wVQ-1
X-Mimecast-MFC-AGG-ID: KKDI551uMEmXrxSTtl1wVQ_1784641467
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B98CC195F17D; Tue, 21 Jul 2026 13:44:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.155])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E36F73003EFD; Tue, 21 Jul 2026 13:44:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anatol Belski <anbelski@linux.microsoft.com>
Subject: [PATCH for-11.1] virtio: avoid packed vring virtio_queue_empty()
 infinite loops (CVE-2026-16457)
Date: Tue, 21 Jul 2026 09:44:24 -0400
Message-ID: <20260721134424.196337-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
---
 hw/virtio/virtio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a36553..3795e3c8c68 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -763,6 +763,10 @@ static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
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
2.55.0


