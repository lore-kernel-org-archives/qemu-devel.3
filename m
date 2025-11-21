Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3E2CFA753
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNb3-0005ds-4S; Fri, 21 Nov 2025 04:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNaz-0005cl-80
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNax-0004EE-G8
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763717901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/ixhXhR+CrA8nu7nsFvLBm5U+Vy9Xhe2mKEVAMZ184=;
 b=aLJ4Mwj8fDkXc3jJq2L6o26JLNFHff0sS/x30Os5zqFPkWHpBZ85/iJzLZ20+hzmv2m9+N
 BmAFY6+HqA3+RDu1IY4zTl+v4UmfFBQsvbdAbu+aooICk6pafPCtJOJcCr8L6cSiyEg4tf
 nooMnOdtjJ0asjwU9T5gnCzO/epfx4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-0gal5EwbNZCi47_7XO3xGw-1; Fri,
 21 Nov 2025 04:38:19 -0500
X-MC-Unique: 0gal5EwbNZCi47_7XO3xGw-1
X-Mimecast-MFC-AGG-ID: 0gal5EwbNZCi47_7XO3xGw_1763717898
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 540321954B14; Fri, 21 Nov 2025 09:38:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EB3930044DB; Fri, 21 Nov 2025 09:38:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 01/10] hw/s390x: Fix a possible crash with passed-through
 virtio devices
Date: Fri, 21 Nov 2025 10:38:03 +0100
Message-ID: <20251121093812.280911-2-thuth@redhat.com>
In-Reply-To: <20251121093812.280911-1-thuth@redhat.com>
References: <20251121093812.280911-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
refuse all devices that are not our own virtio devices. Like in the
other branches that detect wrong settings, we return -EINVAL from the
function, which will later be placed in GPR2 to inform the guest about
the error.

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251118174047.73103-1-thuth@redhat.com>
---
 hw/s390x/s390-hypercall.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index ac1b08b2cd5..508dd97ca0d 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
@@ -42,6 +43,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
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
+        warn_report_once("Got virtio notification for unsupported device "
+                         "on subchannel %02x.%1x.%04x!", cssid, ssid, schid);
+        return -EINVAL;
+    }
 
     vdev = virtio_ccw_get_vdev(sch);
     if (vq_idx >= VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_idx)) {
-- 
2.51.1


