Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B57CED25C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIBy-0001oY-1j; Tue, 18 Nov 2025 04:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIBs-0001hv-Gb
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:40:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIBp-0001Lg-Cj
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763458796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h1b1xIoJdM4QgPff5mNcN7peLXUgt7XjUir0p5dRnGA=;
 b=HrGQwjauYhIu5yWZbKy3zWG8kIgavOZhVs9EQYVpjGKXX1b9clXwOSyunP5r0KMozhnnFy
 4FD25wLmQXIEWqy5Jz4kigqHhUtuWalXAhslk3yTT+X5jvrm+y2pO13DFndkSFaiKpzt9v
 E8Nhjkfo3rJSNjdYjG3LxC/OWB/8uxo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-mZ8CvQE8NByDErfspWrv_g-1; Tue,
 18 Nov 2025 04:39:53 -0500
X-MC-Unique: mZ8CvQE8NByDErfspWrv_g-1
X-Mimecast-MFC-AGG-ID: mZ8CvQE8NByDErfspWrv_g_1763458791
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 932121956089; Tue, 18 Nov 2025 09:39:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA7551800877; Tue, 18 Nov 2025 09:39:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2] hw/s390x: Fix a possible crash with passed-through virtio
 devices
Date: Tue, 18 Nov 2025 10:39:45 +0100
Message-ID: <20251118093945.35062-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Consider the following nested setup: An L1 host uses some virtio device
(e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
device through to the L3 guest. Since the L3 guest sees a virtio device,
it might send virtio notifications to the QEMU in L2 for that device.
But since the QEMU in L2 defined this device as vfio-ccw, the function
handle_virtio_ccw_notify() cannot handle this and crashes: It calls
virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
but since "sch" belongs to a vfio-ccw device, that driver_data rather
points to a CcwDevice instead. So as soon as QEMU tries to use some
VirtioCcwDevice specific data from that device, we've lost.

We must not take virtio notifications for such devices. Thus fix the
issue by adding a check to the handle_virtio_ccw_notify() handler to
refuse all devices that are not our own virtio devices.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Now with the required #include statement

 hw/s390x/s390-hypercall.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index ac1b08b2cd5..38f1c6132e0 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
@@ -42,6 +43,18 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
     if (!sch || !css_subch_visible(sch)) {
         return -EINVAL;
     }
+    if (sch->id.cu_type != VIRTIO_CCW_CU_TYPE) {
+        /*
+         * This might happen in nested setups: If the L1 host defined the
+         * L2 guest with a virtio device (e.g. virtio-keyboard), and the
+         * L2 guest passes this device through to the L3 guest, the L3 guest
+         * might send virtio notifications to the QEMU in L2 for that device.
+         * But since the QEMU in L2 defined this device as vfio-ccw, it's not
+         * a VirtIODevice that we can handle here!
+         */
+        warn_report_once("Got virtio notification for unsupported device!");
+        return -EINVAL;
+    }
 
     vdev = virtio_ccw_get_vdev(sch);
     if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {
-- 
2.51.1


