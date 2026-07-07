Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F47C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5OH-0006N3-Dt; Tue, 07 Jul 2026 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OG-0006MU-6M
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OE-0006p5-Kd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGKwFipSbKqAjFDhDL9UTMfRaEuYvJceC5CSkvod+vU=;
 b=OO6maVaPH/8NrxzNGDVQ85rkq0gGCPXQw7RSMiMiFcNpbchTG6VJTnI/V1w3p+D6jyjfMo
 iBpOKjwzvfEQnWejIleyDjfaSN9xuPCSe8nwhpO1oWH2Eu+D7xhxH5rYlhvs0gvQEvQSxT
 SpZtCT0zIzI8pWWKmtm+0LIvmtGaH+U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-g9fMK4AeM0md_zg35cZaDw-1; Tue,
 07 Jul 2026 08:59:04 -0400
X-MC-Unique: g9fMK4AeM0md_zg35cZaDw-1
X-Mimecast-MFC-AGG-ID: g9fMK4AeM0md_zg35cZaDw_1783429142
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ABA91805C1E; Tue,  7 Jul 2026 12:59:02 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA8621956040; Tue,  7 Jul 2026 12:59:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 04/15] pc-bios/s390-ccw: Verify virtio support when booting
 from virtio PCI device on s390x
Date: Tue,  7 Jul 2026 14:58:36 +0200
Message-ID: <20260707125847.1785168-5-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

The virtio specification requires that each PCI device has a vendor ID of
0x1af4.  Verify this value before continuing with boot process.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260630141917.673995-5-jrossi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/main.c       |  1 +
 pc-bios/s390-ccw/virtio-pci.c | 19 +++++++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h |  3 +++
 pc-bios/s390-ccw/virtio.c     |  2 ++
 pc-bios/s390-ccw/virtio.h     |  1 +
 5 files changed, 26 insertions(+)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 26287cfd8112..fb47d29bb1f2 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -163,6 +163,7 @@ static bool find_fid(uint32_t fid)
     }
 
     vdev->pci_fh = entry.fh;
+    vdev->vendor_id = entry.vendor_id;
     virtio_pci_id2type(vdev, entry.device_id);
 
     return vdev->dev_type != 0;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 2c83ec4f1316..f501252c8199 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -325,6 +325,20 @@ static int enable_pci_bus_master(void)
     return 0;
 }
 
+bool virtio_pci_is_supported(VDev *vdev)
+{
+    if (vdev->vendor_id == PCI_VENDOR_VIRTIO) {
+        switch (vdev->dev_type) {
+        case VIRTIO_ID_BLOCK:
+            return true;
+        default:
+            return false;
+        }
+    }
+
+    return false;
+}
+
 int virtio_pci_setup(VDev *vdev)
 {
     VRing *vr;
@@ -335,6 +349,11 @@ int virtio_pci_setup(VDev *vdev)
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
     vdev->cmd_vr_idx = 0;
 
+    if (!virtio_pci_is_supported(vdev)) {
+        puts("Virtio PCI unsupported for this device ID");
+        return -ENODEV;
+    }
+
     if (virtio_pci_read_pci_cap_config()) {
         puts("Invalid virtio PCI capabilities");
         return -EIO;
diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
index 2494df161988..33b683bd922c 100644
--- a/pc-bios/s390-ccw/virtio-pci.h
+++ b/pc-bios/s390-ccw/virtio-pci.h
@@ -56,6 +56,8 @@
 
 #define VIRTIO_F_VERSION_1          1   /* Feature bit 32 */
 
+#define PCI_VENDOR_VIRTIO           0x1af4
+
 struct VirtioPciCap {
     uint8_t bar;     /* Which PCIAS it's in */
     uint32_t off;    /* Offset within bar */
@@ -65,6 +67,7 @@ typedef struct VirtioPciCap  VirtioPciCap;
 void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
 int virtio_pci_reset(VDev *vdev);
 long virtio_pci_notify(VRing *vr);
+bool virtio_pci_is_supported(VDev *vdev);
 int virtio_pci_setup(VDev *vdev);
 int virtio_pci_setup_device(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index df04479aa69c..a0d249db2408 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -247,6 +247,8 @@ bool virtio_is_supported(VDev *vdev)
     case S390_IPL_TYPE_QEMU_SCSI:
     case S390_IPL_TYPE_CCW:
         return virtio_ccw_is_supported(vdev);
+    case S390_IPL_TYPE_PCI:
+        return virtio_pci_is_supported(vdev);
     default:
         return false;
     }
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 75ae5bdbc229..aa307025e0f5 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -259,6 +259,7 @@ struct VDev {
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
     uint32_t pci_fh;
+    uint16_t vendor_id;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
-- 
2.54.0


