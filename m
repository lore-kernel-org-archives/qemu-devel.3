Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2FBCD1290
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 07:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq6OZ-0007DF-Q5; Fri, 29 Mar 2024 03:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6OX-0007C0-VP
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6OV-0001A7-To
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711696279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdGxAGmowhQSBuyeDBHIEceatJNwqQUFNtHDcNjSPU8=;
 b=hvwDsmtwiQd1ON1GE+HzofpXuLyK49leb7caypt/Fs3vI/8mPgjgariZAfHZzXs7M8Ca5j
 QKo2CrCL6T54OzoJRgYh6oJPJqrabWFfFuXss1kJY8+5KwO/tdHM3sXQPPLxoxcl6reP/G
 AXYXRZV5krGp3irQkUh7hC41KyiTtgI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-D2_JzKhxPvihyThN06-0lA-1; Fri, 29 Mar 2024 03:11:14 -0400
X-MC-Unique: D2_JzKhxPvihyThN06-0lA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BEEB101A526;
 Fri, 29 Mar 2024 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B8B1C423E0;
 Fri, 29 Mar 2024 07:11:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/5] virtio-net: Fix vhost virtqueue notifiers for RSS
Date: Fri, 29 Mar 2024 15:10:56 +0800
Message-ID: <20240329071100.31376-2-jasowang@redhat.com>
In-Reply-To: <20240329071100.31376-1-jasowang@redhat.com>
References: <20240329071100.31376-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

virtio_net_guest_notifier_pending() and virtio_net_guest_notifier_mask()
checked VIRTIO_NET_F_MQ to know there are multiple queues, but
VIRTIO_NET_F_RSS also enables multiple queues. Refer to n->multiqueue,
which is set to true either of VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is
enabled.

Fixes: 68b0a6395f36 ("virtio-net: align ctrl_vq index for non-mq guest for vhost_vdpa")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9959f1932b..a6ff000cd9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3426,7 +3426,7 @@ static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc;
     assert(n->vhost_started);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
+    if (!n->multiqueue && idx == 2) {
         /* Must guard against invalid features and bogus queue index
          * from being set by malicious guest, or penetrated through
          * buggy migration stream.
@@ -3458,7 +3458,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc;
     assert(n->vhost_started);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
+    if (!n->multiqueue && idx == 2) {
         /* Must guard against invalid features and bogus queue index
          * from being set by malicious guest, or penetrated through
          * buggy migration stream.
-- 
2.42.0


