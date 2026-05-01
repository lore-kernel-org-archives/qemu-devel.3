Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0011DCCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 20:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIu67-0001TA-Jw; Fri, 01 May 2026 16:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu5M-0001C9-EP; Fri, 01 May 2026 16:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu5J-0001QO-DL; Fri, 01 May 2026 16:03:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641EkLAq2006058; Fri, 1 May 2026 20:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IwvvP9MY8WoGYhdgJ
 WzLy3S2sw6QZcbw07ZcxAXwF0I=; b=orD4z5+arMyNKir+beBy1SzHib6xjAfUd
 ABeVKu5cJRWkM0zRjXl7eMkmHc5csg8sHJdglin/DU0CVGI/gD1mzNkS8gfykPQt
 2rRUY2P5g4EX3FKMM8Hb2x0Zs7VFKC4OJZH7KdRPRjgsvYFe6g40A7K/vU/lP8n+
 MaODRc2wJhZ/zpl+VltwxEs4mtxw0PjU8yR9L4FhaWpwo1wahfLYEEb8ae07bSRZ
 ehpCZBH0XElLBq0Pf/l4RPmM06azyHerbvR8h6CZRtzrYcfmSuKa+7nJWseusQR1
 g3P5z9AMvcN0s1oWzKKVPKcfQTVQCjkI41xHYAUuuGxc0S+yoAPrw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vv61p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:03:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641Js0Jo019209;
 Fri, 1 May 2026 20:03:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw91kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:03:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641K3T9b63242744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 20:03:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87BCA58043;
 Fri,  1 May 2026 20:03:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 629E158059;
 Fri,  1 May 2026 20:03:28 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 20:03:28 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: oelghoul@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com, clg@redhat.com
Subject: [RFC PATCH v1 3/5] hw/virtio: Add DMA counters for virtio-pci devices
Date: Fri,  1 May 2026 16:00:24 -0400
Message-ID: <20260501200026.22784-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501200026.22784-1-oelghoul@linux.ibm.com>
References: <20260501200026.22784-1-oelghoul@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f50715 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=456z7t5ePv1a_L0t-noA:9
X-Proofpoint-ORIG-GUID: jUlSoWcWBnFT_KLsUJPayO9F9xhYjKfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfXyGg/RRSSQxjs
 dBwExYQDxtalSUcB4LnfalVhB/hQLfgnzOMtDiilkdlBNzX1mcHo/U0qjz93uNnuvMs6ngcwUG2
 9iXaXn3KIXnp9L5qcKQWoDq9GCfmKhXrx9Nv9WekHPvMR4GVdZwLRkThPmdqFYV5q+8LHj7q3wW
 ypBUgabiYGOg/I7gJEvklVRqc1rQeZMraPzs4zrP3S9Ol2uFJAWTGRuW9ZxdoSNCjNWR+jH/CYZ
 lb8GggUBrHvSY1WczqJG4tDiCwbE/Zbm+uS3tOvMyRC4mhqyrOgZ2EDFLtROx3KBCRxoOcugVnM
 eyQvQkR6I1pSVFo8/bu5LIB1Rft83I/rl9bWjh2A5v6ABckO7dyra8BAJgE+Pr5Q1AH4SbOI+T5
 yc7Nal88cuxjXVcZr6bsyUE9+s1UnNjwOi7X/IX/smx7MfwcwD0y4Pw/mksycvkj+iGmTceETRL
 8LPxB1Lkn+8O7ntQBpw==
X-Proofpoint-GUID: jUlSoWcWBnFT_KLsUJPayO9F9xhYjKfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010195
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Internally track DMA read/write byte counters for virtio-pci devices by
assigning them a DMA owner bus. This will allow an implementation of the
FMB format-0 for zPCI. The assignment of an owner bus is also done from
s390x-specific realization such that other architectures do not need to
internally track unutilized counters.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c     |  7 +++++++
 hw/virtio/virtio.c          | 16 ++++++++++++++++
 include/hw/pci/pci_device.h |  4 ++++
 include/hw/virtio/virtio.h  |  1 +
 4 files changed, 28 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 128814f4c5..7eee1efeb7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -20,6 +20,7 @@
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/core/qdev-properties.h"
@@ -1192,6 +1193,12 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             pbdev->rtr_avail = false;
         }
 
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PCI)) {
+            VirtIOPCIProxy *virtio_proxy = VIRTIO_PCI(pbdev->pdev);
+            VirtIODevice *vdev = virtio_bus_get_device(&virtio_proxy->bus);
+            vdev->dma_owner = OBJECT(virtio_proxy);
+        }
+
         if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8fcf6cfd0b..f61ad57821 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -24,6 +24,7 @@
 #include "qom/object_interfaces.h"
 #include "hw/core/cpu.h"
 #include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/vhost.h"
 #include "migration/qemu-file-types.h"
 #include "qemu/atomic.h"
@@ -1617,9 +1618,16 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
                                hwaddr pa, size_t sz)
 {
     bool ok = false;
+    PCIDevice *pdev = NULL;
     unsigned num_sg = *p_num_sg;
     assert(num_sg <= max_num_sg);
 
+    if (vdev->dma_owner &&
+        object_dynamic_cast(vdev->dma_owner, TYPE_VIRTIO_PCI)) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(vdev->dma_owner);
+        pdev = &proxy->pci_dev;
+    }
+
     if (!sz) {
         virtio_error(vdev, "virtio: zero sized buffers are not allowed");
         goto out;
@@ -1650,6 +1658,14 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
         sz -= len;
         pa += len;
         num_sg++;
+
+        if (pdev) {
+            if (is_write) {
+                pdev->dma_wbytes += len;
+            } else {
+                pdev->dma_rbytes += len;
+            }
+        }
     }
     ok = true;
 
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..5a4fd4f605 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -98,6 +98,10 @@ struct PCIDevice {
     MemoryRegion bus_master_container_region;
     MemoryRegion bus_master_enable_region;
 
+    /* DMA statistics */
+    uint64_t dma_rbytes;
+    uint64_t dma_wbytes;
+
     /* do not access the following fields */
     PCIConfigReadFunc *config_read;
     PCIConfigWriteFunc *config_write;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6344bd7b68..e9e7e437f9 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -161,6 +161,7 @@ struct VirtIODevice
      */
     bool use_guest_notifier_mask;
     AddressSpace *dma_as;
+    Object *dma_owner;
     QLIST_HEAD(, VirtQueue) *vector_queues;
     QTAILQ_ENTRY(VirtIODevice) next;
     /**
-- 
2.52.0


