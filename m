Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E2AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5OI-0006NO-5l; Tue, 07 Jul 2026 08:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OG-0006MY-BQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OE-0006pZ-Mm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=as45FMgPC/EAdv1UJC4SuTL7F8DyT3XVV4d4m5Ik7Ho=;
 b=LeDQI+5vY4zMTJKV7FLWMGk7YouwhqREWYissApAqW7SDo6IgJZCnbZw0bCQ7jYfdgO8jp
 L3GtwFgwzOlsAK4Cx9CI6HDOzX361upMRzMtsbu1Z0uSXcfAK1qSuc6ddzyJm8JM2qqI50
 Vie7IY8k21emfTZZGK+fESB5gD8xrA0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-g5qWYYZFMde6C0WIkLrOAg-1; Tue,
 07 Jul 2026 08:59:02 -0400
X-MC-Unique: g5qWYYZFMde6C0WIkLrOAg-1
X-Mimecast-MFC-AGG-ID: g5qWYYZFMde6C0WIkLrOAg_1783429140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46FFD1954128; Tue,  7 Jul 2026 12:59:00 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AF401956040; Tue,  7 Jul 2026 12:58:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 03/15] pc-bios/s390-ccw: Add per-queue notification offset for
 multi-queue virtio configurations
Date: Tue,  7 Jul 2026 14:58:35 +0200
Message-ID: <20260707125847.1785168-4-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhuoying Cai <zycai@linux.ibm.com>

The initial support for virtio-blk-pci IPL devices used a single virt-queue, but
other device types require multiple queues, and for PCI device types this also
requires a per-queue notification offset.

Add a PCI notify field to the VRing struct so that each queue has a unique
notify offset as defined in the virtio spec.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260630141917.673995-4-jrossi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/virtio-pci.c | 38 +++++++++++++++++++++--------------
 pc-bios/s390-ccw/virtio-pci.h |  2 +-
 pc-bios/s390-ccw/virtio.c     |  2 +-
 pc-bios/s390-ccw/virtio.h     |  1 +
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 53bdb52e76ab..2c83ec4f1316 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -21,7 +21,6 @@ VirtioPciCap c_cap; /* Common capabilities  */
 VirtioPciCap d_cap; /* Device capabilities  */
 VirtioPciCap n_cap; /* Notify capabilities  */
 uint32_t notify_mult;
-uint16_t q_notify_offset;
 
 static int virtio_pci_set_status(uint8_t status)
 {
@@ -74,10 +73,10 @@ int virtio_pci_reset(VDev *vdev)
     return 0;
 }
 
-long virtio_pci_notify(int vq_id)
+long virtio_pci_notify(VRing *vr)
 {
-    uint32_t offset = n_cap.off + notify_mult * q_notify_offset;
-    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vq_id);
+    uint32_t offset = n_cap.off + notify_mult * vr->pci_notify;
+    return vpci_bswap16_write(offset, n_cap.bar, (uint16_t) vr->id);
 }
 
 /*
@@ -301,8 +300,7 @@ static int virtio_pci_read_pci_cap_config(void)
     }
 
     rc = vpci_read_bswap32(pos + VPCI_N_CAP_MULT, PCI_CFGBAR, &notify_mult);
-    if (rc || vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar,
-                                &q_notify_offset)) {
+    if (rc) {
         puts("Failed to read notification queue configuration");
         return -EIO;
     }
@@ -332,7 +330,6 @@ int virtio_pci_setup(VDev *vdev)
     VRing *vr;
     int rc;
     uint8_t status;
-    uint16_t vq_size;
     int i = 0;
 
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
@@ -380,28 +377,39 @@ int virtio_pci_setup(VDev *vdev)
         return -EIO;
     }
 
-    if (vpci_read_bswap16(VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
-        puts("Failed to read virt-queue configuration");
-        return -EIO;
-    }
-
     /* Configure virt-queues for pci */
     for (i = 0; i < vdev->nr_vqs; i++) {
+        uint16_t vq_size;
+        uint16_t vq_notify;
         VqInfo info = {
             .queue = (unsigned long long) virtio_get_ring_area(i),
             .align = KVM_S390_VIRTIO_RING_ALIGN,
             .index = i,
-            .num = vq_size,
+            .num = 0,
         };
 
         vr = &vdev->vrings[i];
-        vring_init(vr, &info);
 
-        if (vpci_set_selected_vq(vr->id)) {
+        if (vpci_set_selected_vq(i)) {
             puts("Failed to set selected virt-queue");
             return -EIO;
         }
 
+        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_SIZE, c_cap.bar, &vq_size)) {
+            printf("Failed to read virt-queue %d size\n", i);
+            return -EIO;
+        }
+
+        info.num = vq_size;
+
+        if (vpci_read_bswap16(c_cap.off + VPCI_C_OFFSET_Q_NOFF, c_cap.bar, &vq_notify)) {
+            printf("Failed to read virt-queue %d notify offset\n", i);
+            return -EIO;
+        }
+
+        vr->pci_notify = vq_notify;
+        vring_init(vr, &info);
+
         rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
         rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
         rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 90d07cb9a76a..2494df161988 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -64,7 +64,7 @@ typedef struct VirtioPciCap  VirtioPciCap;
 
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
-long virtio_pci_notify(int vq_id);
+long virtio_pci_notify(VRing *vr);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 7883871033c4..df04479aa69c 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -114,7 +114,7 @@ bool vring_notify(VRing *vr)
         vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
         break;
     case S390_IPL_TYPE_PCI:
-        vr->cookie = virtio_pci_notify(vr->id);
+        vr->cookie = virtio_pci_notify(vr);
         break;
     default:
         return 1;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index d32a4830cad1..75ae5bdbc229 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -107,6 +107,7 @@ struct VRing {
     VRingUsed *used;
     long cookie;
     int id;
+    uint16_t pci_notify;
 };
 typedef struct VRing VRing;
 
-- 
2.54.0


