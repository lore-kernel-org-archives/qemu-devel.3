Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC73CD3423
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 20:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIu68-0001W2-0Y; Fri, 01 May 2026 16:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu5w-0001K4-E1; Fri, 01 May 2026 16:04:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu5s-0001VB-Qq; Fri, 01 May 2026 16:04:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641F1BxZ3060766; Fri, 1 May 2026 20:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KlGpvEC4RDK74fAGE
 yEIgsDl+lYkwifLPb2H0Dd9tLY=; b=I/llce4RLFMSnf0nfRinO6R9njgkgUNL2
 TXBv2EgTdHRBs8Qk08UyfeI7t5qUmS1Zxp4POLCZx7O4EGQ2poUUVEeymxhkm4fB
 9wbSQ2J5QJkkWWhYtAGRrYCB3uOjl786CZ/LOLiCbyTw4sfvVqAnezyAz1jLmIuM
 IgyGViyjzjMLcPtEOCOlDaRy+jCCjZ14Tfg9LecHUYKcXMTZEsf6/tplj0NredSy
 YoYeueW/+DC0hOR44OF4Ro76sh3FNTGc7ulYEeqmQ64c5b5E1f1dSV480rJlOoJJ
 28tD3Rri+RJ4W7oQnZ46f8mKX40dUoM2JtDvHmO8stL44xX3xpOOQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rp5uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:04:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641Jrs3G000757;
 Fri, 1 May 2026 20:04:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehrucg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:04:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641K438Z31916704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 20:04:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B23D58043;
 Fri,  1 May 2026 20:04:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DA7C58055;
 Fri,  1 May 2026 20:04:02 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 20:04:02 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: oelghoul@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com, clg@redhat.com
Subject: [RFC PATCH v1 4/5] hw/s390x: Internal support for FMB passthrough
Date: Fri,  1 May 2026 16:00:25 -0400
Message-ID: <20260501200026.22784-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501200026.22784-1-oelghoul@linux.ibm.com>
References: <20260501200026.22784-1-oelghoul@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QCgjdcwJE6JZFuXGzB2h9KzUVfNCWFze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfX9RN79WnRGezD
 3DERqgp+H6BOq3s/oTU+IFuWxyZ0c1kZ5fGmtEpW5DB/qIU7ajU0lRS6tq4/EkjZ3MBEhCxiwPv
 2VwiCSlPScLWm64IJ18mgghxpgA8t+W5MMk0Yp6LL7JOch+tAtBQu/yd/ApYT7MI4G+MeXOn9ki
 M6Z3y5yTQ5bHuvqVBmSiTq+m7VJGYl9XVI/S723kmZ7gzMT6os3y5N2ghxzoke8CTJuEg+D/riN
 372AYHOm4sO2A+JJ+jpBnA4aHkf3LWLj1l/GKVQdtg289XfsbrZim70jmqqx8O5QJC2/B0rNzrx
 Djku8wWTvAgwIlEZ/ANwIgoSsdmtrw0GZeTTNsHgzKFXyBHolNoJB2Bh3Ja+nCvDKmz2J5s5Ba+
 zqQyo4qVe+W0bKoYPWuXEcxi6T/GvuvMSLQsnZKYtvvD6Q9gPSoHZUx+iG8gT4qwGjeCZG6xGtv
 1Ee1G3b6ewrKo4ew+Sg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f50737 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=47rX_IKMaOKvU8u4J60A:9
X-Proofpoint-ORIG-GUID: QCgjdcwJE6JZFuXGzB2h9KzUVfNCWFze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010195
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Detect the FMB passthrough at runtime by probing for the VFIO FMB device
feature and setting a flag indicating its presence. If present, during an
FMB update cycle, read the device feature and add the VFIO-provided
counters to QEMU's intercepted statistics, to account for operations that
may be run without interpretation.

If the device feature is not found, gracefully and silently fall back to
QEMU's pre-existing intercepted FMB implementation.

Introduce helper functions to allow enabling or disabling the FMB of the
host device. These functions will allow QEMU to cascade FMB state and
guarantee that the counters restart from zero when the guest expects them
to after a new FMB (re-)enablement.

Finally, remove the reduced aperture size for PCI ISM devices. This is
necessary due to the kernel working around a firmware bug and incrementing
the DMA limit by one full page when the PFT is reported correctly.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          |   2 +
 hw/s390x/s390-pci-inst.c         |   7 ++
 hw/s390x/s390-pci-vfio-stubs.c   |  16 ++++
 hw/s390x/s390-pci-vfio.c         | 128 ++++++++++++++++++++++++++-----
 include/hw/s390x/s390-pci-bus.h  |  27 ++++++-
 include/hw/s390x/s390-pci-vfio.h |   4 +
 6 files changed, 165 insertions(+), 19 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 7eee1efeb7..88540a9eb6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1185,6 +1185,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                 pbdev->shutdown_notifier.notify = s390_pci_shutdown_notifier;
                 qemu_register_shutdown_notifier(&pbdev->shutdown_notifier);
             }
+            /* Detect VFIO FMB passthrough */
+            s390_pci_get_fmb_info(pbdev);
         } else {
             pbdev->fh |= FH_SHM_EMUL;
             /* Always intercept emulated devices */
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 10066ca618..b22144751e 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1313,9 +1313,16 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (!fmb_addr) {
             /* Stop updating FMB. */
             fmb_timer_free(pbdev);
+            if (pbdev->has_vfio_fmb) {
+                s390_pci_disable_vfio_fmb(pbdev);
+            }
             break;
         }
 
+        if (pbdev->has_vfio_fmb) {
+            s390_pci_enable_vfio_fmb(pbdev);
+        }
+
         if (!pbdev->fmb_timer) {
             pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                             fmb_update, pbdev);
diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
index d9882b7aad..774a6615c6 100644
--- a/hw/s390x/s390-pci-vfio-stubs.c
+++ b/hw/s390x/s390-pci-vfio-stubs.c
@@ -30,3 +30,19 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
 {
 }
+
+void s390_pci_get_fmb_info(S390PCIBusDevice *pbdev)
+{
+}
+
+void s390_pci_update_vfio_fmb(S390PCIBusDevice *pbdev)
+{
+}
+
+void s390_pci_disable_vfio_fmb(S390PCIBusDevice *pbdev)
+{
+}
+
+void s390_pci_enable_vfio_fmb(S390PCIBusDevice *pbdev)
+{
+}
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7c754b656d..d749c8c80a 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -110,7 +111,6 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
     VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
-    uint64_t vfio_size;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
 
@@ -140,22 +140,6 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     if (pbdev->pft == ZPCI_PFT_ISM) {
         pbdev->rtr_avail = false;
     }
-
-    /*
-     * If appropriate, reduce the size of the supported DMA aperture reported
-     * to the guest based upon the vfio DMA limit.  This is applicable for
-     * devices that are guaranteed to not use relaxed translation.  If the
-     * device is capable of relaxed translation then we must advertise the
-     * full aperture.  In this case, if translation is used then we will
-     * rely on the vfio DMA limit counting and use RPCIT CC1 / status 16
-     * to request that the guest free DMA mappings as necessary.
-     */
-    if (!pbdev->rtr_avail) {
-        vfio_size = pbdev->iommu->max_dma_limit << qemu_target_page_bits();
-        if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
-            pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
-        }
-    }
 }
 
 static bool get_host_fh(S390PCIBusDevice *pbdev, struct vfio_device_info *info,
@@ -248,7 +232,7 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
         }
         resgrp->dasm = cap->dasm;
         resgrp->msia = cap->msi_addr;
-        resgrp->mui = cap->mui;
+        resgrp->mui = cap->mui > DEFAULT_MUI ? cap->mui : DEFAULT_MUI;
         resgrp->i = cap->noi;
         if (pbdev->interp && hdr->version >= 2) {
             resgrp->maxstbl = cap->imaxstbl;
@@ -370,3 +354,111 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
     s390_pci_read_util(pbdev, info);
     s390_pci_read_pfip(pbdev, info);
 }
+
+void s390_pci_get_fmb_info(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
+    int fd = vpdev->vbasedev.fd;
+    int ret;
+    struct vfio_device_feature probe = {
+        .argsz = sizeof(probe),
+        .flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_FMB
+    };
+
+    ret = ioctl(fd, VFIO_DEVICE_FEATURE, &probe);
+    pbdev->has_vfio_fmb = !ret;
+}
+
+static void s390_pci_set_vfio_fmb(S390PCIBusDevice *pbdev, int enabled)
+{
+    VFIOPCIDevice *vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
+    size_t size = sizeof(struct vfio_device_feature_zpci_fmb)
+        + sizeof(struct vfio_device_feature);
+    g_autofree struct vfio_device_feature *set = g_malloc(size);
+    struct vfio_device_feature_zpci_fmb *set_fmb;
+
+    set->argsz = size;
+    set->flags = VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_ZPCI_FMB;
+    set_fmb = (struct vfio_device_feature_zpci_fmb *) set->data;
+    if (enabled) {
+        set_fmb->flags |= VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
+    } else {
+        set_fmb->flags &= ~VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
+    }
+    ioctl(vpdev->vbasedev.fd, VFIO_DEVICE_FEATURE, set);
+}
+
+void s390_pci_enable_vfio_fmb(S390PCIBusDevice *pbdev)
+{
+    s390_pci_set_vfio_fmb(pbdev, 1);
+}
+
+void s390_pci_disable_vfio_fmb(S390PCIBusDevice *pbdev)
+{
+    s390_pci_set_vfio_fmb(pbdev, 0);
+}
+
+void s390_pci_update_vfio_fmb(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
+    size_t size = sizeof(struct vfio_device_feature_zpci_fmb)
+        + sizeof(struct vfio_device_feature);
+    g_autofree struct vfio_device_feature *get = g_malloc(size);
+    struct vfio_device_feature_zpci_fmb *get_fmb;
+    ZpciFmb fmb;
+    int ret;
+    MemTxResult memtx_ret;
+
+    get->argsz = size;
+    get->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_ZPCI_FMB;
+    ret = ioctl(vpdev->vbasedev.fd, VFIO_DEVICE_FEATURE, get);
+    if (ret < 0) {
+        return;
+    }
+
+    get_fmb = (struct vfio_device_feature_zpci_fmb *) get->data;
+    if (!get_fmb->flags & VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED) {
+        error_report_once("s390-pci-vfio: FMB is disabled on the host device.");
+        return;
+    }
+    fmb.format = (get_fmb->format << 24) | get_fmb->fmt_ind;
+    fmb.sample = get_fmb->samples;
+    fmb.last_update = get_fmb->last_update;
+    fmb.counter[ZPCI_FMB_CNT_LD] = get_fmb->ld_ops;
+    fmb.counter[ZPCI_FMB_CNT_ST] = get_fmb->st_ops;
+    fmb.counter[ZPCI_FMB_CNT_STB] = get_fmb->stb_ops;
+    fmb.counter[ZPCI_FMB_CNT_RPCIT] = get_fmb->rpcit_ops;
+
+    switch (get_fmb->format) {
+    case 0:
+        fmb.fmt0.dma_rbytes = get_fmb->fmt0.dma_rbytes;
+        fmb.fmt0.dma_wbytes = get_fmb->fmt0.dma_wbytes;
+        break;
+    case 1:
+        fmb.fmt1.rx_bytes = get_fmb->fmt1.rx_bytes;
+        fmb.fmt1.rx_packets = get_fmb->fmt1.rx_packets;
+        fmb.fmt1.tx_bytes = get_fmb->fmt1.tx_bytes;
+        fmb.fmt1.tx_packets = get_fmb->fmt1.tx_packets;
+        break;
+    case 2:
+        fmb.fmt2.consumed_work_units = get_fmb->fmt2.consumed_work_units;
+        fmb.fmt2.max_work_units = get_fmb->fmt2.max_work_units;
+        break;
+    case 3:
+        fmb.fmt3.tx_bytes = get_fmb->fmt3.tx_bytes;
+        break;
+    }
+
+    for (int i = 0; i < ZPCI_FMB_CNT_MAX; i++) {
+        fmb.counter[i] += pbdev->fmb.counter[i];
+    }
+
+    for (int i = 0; i < pbdev->zpci_fn.fmbl >> 2; i++) {
+        address_space_stl_be(&address_space_memory, pbdev->fmb_addr + (i << 2),
+            ((uint32_t *) &fmb)[i], MEMTXATTRS_UNSPECIFIED, &memtx_ret);
+
+        if (memtx_ret != MEMTX_OK) {
+            break;
+        }
+    }
+}
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index feaf6d4863..050e7fda99 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -302,6 +302,22 @@ typedef struct ZpciFmbFmt0 {
     uint64_t dma_wbytes;
 } ZpciFmbFmt0;
 
+typedef struct ZpciFmbFmt1 {
+    uint64_t rx_bytes;
+    uint64_t rx_packets;
+    uint64_t tx_bytes;
+    uint64_t tx_packets;
+} ZpciFmbFmt1;
+
+typedef struct ZpciFmbFmt2 {
+    uint64_t consumed_work_units;
+    uint64_t max_work_units;
+} ZpciFmbFmt2;
+
+typedef struct ZpciFmbFmt3 {
+    uint64_t tx_bytes;
+} ZpciFmbFmt3;
+
 #define ZPCI_FMB_CNT_LD    0
 #define ZPCI_FMB_CNT_ST    1
 #define ZPCI_FMB_CNT_STB   2
@@ -309,13 +325,21 @@ typedef struct ZpciFmbFmt0 {
 #define ZPCI_FMB_CNT_MAX   4
 
 #define ZPCI_FMB_DEFAULT_FORMAT     0
+#define ZPCI_FMB_COMMON_SIZE        48
+#define ZPCI_FMB_FORMAT(f)          ((f >> 24) & 0xFF)
+#define ZPCI_FMB_DMA_COUNTER_VALID  (1 << 23)
 
 typedef struct ZpciFmb {
     uint32_t format;
     uint32_t sample;
     uint64_t last_update;
     uint64_t counter[ZPCI_FMB_CNT_MAX];
-    ZpciFmbFmt0 fmt0;
+    union {
+        ZpciFmbFmt0 fmt0;
+        ZpciFmbFmt1 fmt1;
+        ZpciFmbFmt2 fmt2;
+        ZpciFmbFmt3 fmt3;
+    };
 } ZpciFmb;
 QEMU_BUILD_BUG_MSG(offsetof(ZpciFmb, fmt0) != 48, "padding in ZpciFmb");
 
@@ -364,6 +388,7 @@ struct S390PCIBusDevice {
     bool forwarding_assist;
     bool aif;
     bool rtr_avail;
+    bool has_vfio_fmb;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index f7d6149daf..4a19747d7c 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -20,5 +20,9 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
+void s390_pci_get_fmb_info(S390PCIBusDevice *pbdev);
+void s390_pci_update_vfio_fmb(S390PCIBusDevice *pbdev);
+void s390_pci_disable_vfio_fmb(S390PCIBusDevice *pbdev);
+void s390_pci_enable_vfio_fmb(S390PCIBusDevice *pbdev);
 
 #endif
-- 
2.52.0


