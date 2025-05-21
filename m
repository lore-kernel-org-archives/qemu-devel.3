Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F7AC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhkB-0003qb-85; Wed, 21 May 2025 07:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhji-0003d5-Ry
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjd-00015E-PV
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxKz+6bpWitxKHfviy6aTNvEKI4WqbqkaK+pWRWEn0s=;
 b=YDOn73gdoq9m2+Oq8j08TL8J8j0Xi5dx46M+ysNEritKOlvHcxdxAPwJl5VbFvN8f7DX8K
 d79cMuO4LNevwf7NFU8YvSL/7h2kSdcE3w7vIdr/ntna9YAAqdoUZngqgIgIW89mNeyDjk
 TSlOZgdwmwyafkVC7muE7eg4W8rjGOk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-BjXBGQKLMsqjf5xASl9-mA-1; Wed,
 21 May 2025 07:35:41 -0400
X-MC-Unique: BjXBGQKLMsqjf5xASl9-mA-1
X-Mimecast-MFC-AGG-ID: BjXBGQKLMsqjf5xASl9-mA_1747827340
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 343001956089; Wed, 21 May 2025 11:35:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8544619560B7; Wed, 21 May 2025 11:35:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC 07/16] virtio-pci: implement support for extended features.
Date: Wed, 21 May 2025 13:34:01 +0200
Message-ID: <b91bba9115031af5c8b66eca737296ea5889dbec.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Allow the common read/write operation to access all the
available features space.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/virtio/virtio-pci.c         | 19 +++++++++++++------
 include/hw/virtio/virtio-pci.h |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0fa8fe4955..7815ef2d9b 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -123,7 +123,8 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
         VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
-        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
+        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy,
+                             VIRTIO_FEATURES_WORDS),
         VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
                              vmstate_virtio_pci_modern_queue_state,
                              VirtIOPCIQueue),
@@ -1490,10 +1491,10 @@ static uint64_t virtio_pci_common_read(void *opaque, hwaddr addr,
         val = proxy->dfselect;
         break;
     case VIRTIO_PCI_COMMON_DF:
-        if (proxy->dfselect <= 1) {
+        if (proxy->dfselect < VIRTIO_FEATURES_WORDS) {
             VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
 
-            val = (vdev->host_features & ~vdc->legacy_features) >>
+            val = (vdev->host_features_ex & ~vdc->legacy_features) >>
                 (32 * proxy->dfselect);
         }
         break;
@@ -1585,10 +1586,16 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         break;
     case VIRTIO_PCI_COMMON_GF:
         if (proxy->gfselect < ARRAY_SIZE(proxy->guest_features)) {
+            virtio_features_t features = 0;
+            int i;
+
             proxy->guest_features[proxy->gfselect] = val;
-            virtio_set_features(vdev,
-                                (((uint64_t)proxy->guest_features[1]) << 32) |
-                                proxy->guest_features[0]);
+            for (i = 0; i < VIRTIO_FEATURES_WORDS; ++i) {
+                virtio_features_t cur = proxy->guest_features[i];
+
+                features |= cur << (i * 32);
+            }
+            virtio_set_features(vdev, features);
         }
         break;
     case VIRTIO_PCI_COMMON_MSIX:
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 31ec144509..c20b289e64 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -165,7 +165,7 @@ struct VirtIOPCIProxy {
     uint32_t nvectors;
     uint32_t dfselect;
     uint32_t gfselect;
-    uint32_t guest_features[2];
+    uint32_t guest_features[VIRTIO_FEATURES_WORDS];
     VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
 
     VirtIOIRQFD *vector_irqfd;
-- 
2.49.0


