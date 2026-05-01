Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B44ECD3423
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 20:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIu6E-0001r3-Fh; Fri, 01 May 2026 16:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu6B-0001k6-FS; Fri, 01 May 2026 16:04:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu69-0001ei-NF; Fri, 01 May 2026 16:04:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641EjivY2840313; Fri, 1 May 2026 20:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1Mthas14dUCzArtmP
 BHd0kOVwbr1CPycXWbV3rNFn9E=; b=NcmrTnxXIgN0jgRp5cZSBR3nZyFXHcebN
 Mjw/N3W6mr+NbZOaeH8giEGDuHC1s41DGeTRxC8vcBorX49rZ1IYLvKuqJ+MD8Af
 sSYwyUDn+uIrf3wCUvpPFWRbnLnaak1tMYVijm0I7HTSA38AZX7L9/rVUZ66AXuI
 lI8D5pZprW8wq9aUCbTCypwWCnrBrOM4jPcZiMocjXFrkSAOKp7k7fy/LoOtEV6e
 /zkpW8oWcicGqCzOikdWz+COQ697wNr68no6w7+r6NvL07mURgmySb1N7wsLUu0J
 L9wF5dizI/CIJKYnCjifgmB2v6b/5Pkh++N4KsTjVGQfmcC2ofAzw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vv63q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:04:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641JcjSM023096;
 Fri, 1 May 2026 20:04:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyrqrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:04:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641K4MFf32244260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 20:04:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5714B58043;
 Fri,  1 May 2026 20:04:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 399CA58059;
 Fri,  1 May 2026 20:04:21 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 20:04:21 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: oelghoul@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com, clg@redhat.com
Subject: [RFC PATCH v1 5/5] hw/s390x: Report FMB passthrough and/or FMB DMA
 counters to the guest
Date: Fri,  1 May 2026 16:00:26 -0400
Message-ID: <20260501200026.22784-6-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501200026.22784-1-oelghoul@linux.ibm.com>
References: <20260501200026.22784-1-oelghoul@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f5074a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=i_3ZhW82j95uuV7xZWQA:9
X-Proofpoint-ORIG-GUID: X75OfkJzypko5NRi3CMG-1B3je4RkAGK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfXz4H/9MW1LOHI
 HnII2MpVDCK8yl6GGUuwxFVBEh/qDKLD4vhlEsnUGJtgehJ7LQ5LYipm1+Ir3xUBCetxmgR7V8F
 e4DbDVEuY0jpcPlwOrtHjRYhHj9252oREg2cdsq3fpbu/nrMlH1064P0zfKRzQBHPyDfCiLfKTs
 3AJ2vH2zE24zimcAqMdC2nWEcsBD1yu0sYpYTJCPACAnD4Go1OhrOiir4TDFRiWSB8g5bexfSkl
 VpK521WaXOQMbB8ccKyZBhKaMiAE5SshVfL9QrdQJSBtQ5B2HsK4wDnb2wVBG0xnROmf94/tJm9
 Otzrh8D4qfuFP/uYJBRt7mwabkJGq/bJ1Ar1VEAQYfByJ5b4KGFgLtvrOqgG8dTf/sGpuLYAwH2
 cmswwdLzeLNCZXA92E/zS6VS4cW8cADNneTc0gbe/TdRz92uNIAXQI+Hhd4mZF+3aojIkZBc5o2
 zpDmvtc8zj5/spejWNA==
X-Proofpoint-GUID: X75OfkJzypko5NRi3CMG-1B3je4RkAGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
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

Report the correct FMB length to the guest and report a more accurate
snapshot of the FMB using the VFIO feature in the PCI passthrough case or
the emulated counters in the emulated case. To preserve the behavior of
earlier QEMU versions, do not report the PFT or the FMB length to the guest
in the case where FMB passthrough is unavailable.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 58 +++++++++++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-vfio.c |  5 ++--
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b22144751e..767c5b5cef 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -20,6 +20,7 @@
 #include "system/hw_accel.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci_device.h"
+#include "hw/vfio/pci.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-kvm.h"
@@ -296,8 +297,13 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         stw_be_p(&resquery->vfn, pbdev->zpci_fn.vfn);
         resquery->flags = pbdev->zpci_fn.flags;
         resquery->pfgid = pbdev->zpci_fn.pfgid;
-        resquery->pft = pbdev->zpci_fn.pft;
-        resquery->fmbl = pbdev->zpci_fn.fmbl;
+        if (pbdev->has_vfio_fmb) {
+            resquery->pft = pbdev->zpci_fn.pft;
+            resquery->fmbl = pbdev->zpci_fn.fmbl >> 2;
+        } else {
+            resquery->pft = 0;
+            resquery->fmbl = 0;
+        }
         stl_be_p(&resquery->fid, pbdev->zpci_fn.fid);
         stl_be_p(&resquery->uid, pbdev->zpci_fn.uid);
         memcpy(resquery->pfip, pbdev->zpci_fn.pfip, CLP_PFIP_NR_SEGMENTS);
@@ -1096,6 +1102,9 @@ static void fmb_update(void *opaque)
 {
     S390PCIBusDevice *pbdev = opaque;
     int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    VFIOPCIDevice *vpdev;
+    PCIDevice *pci = pbdev->pdev;
+    uint8_t format = ZPCI_FMB_FORMAT(pbdev->fmb.format);
     int i;
 
     /* Update U bit */
@@ -1107,6 +1116,48 @@ static void fmb_update(void *opaque)
         return;
     }
 
+    /* Check for VFIO device */
+    vpdev = (VFIOPCIDevice *) object_dynamic_cast(OBJECT(pbdev->pdev),
+        TYPE_VFIO_PCI_DEVICE);
+
+    if (vpdev && pbdev->has_vfio_fmb) {
+        s390_pci_update_vfio_fmb(pbdev);
+        goto update_timer;
+    }
+
+    /* Update FMB format-specific counters */
+    switch (format) {
+    case 0:
+        if (pci->dma_rbytes || pci->dma_wbytes) {
+            pbdev->fmb.fmt0.dma_rbytes = pci->dma_rbytes;
+            pbdev->fmb.fmt0.dma_wbytes = pci->dma_wbytes;
+            pbdev->fmb.format |= ZPCI_FMB_DMA_COUNTER_VALID;
+        }
+
+        if (fmb_do_update(pbdev,
+            offsetof(ZpciFmbFmt0, dma_rbytes) + offsetof(ZpciFmb, fmt0),
+            pbdev->fmb.fmt0.dma_rbytes,
+            sizeof(pbdev->fmb.fmt0.dma_rbytes))) {
+            return;
+        }
+
+        if (fmb_do_update(pbdev,
+            offsetof(ZpciFmbFmt0, dma_wbytes) + offsetof(ZpciFmb, fmt0),
+            pbdev->fmb.fmt0.dma_wbytes,
+            sizeof(pbdev->fmb.fmt0.dma_wbytes))) {
+            return;
+        }
+    default:
+        break;
+    }
+
+    /* Update format and DMA validity bit */
+    if (fmb_do_update(pbdev, offsetof(ZpciFmb, format),
+                      pbdev->fmb.format,
+                      sizeof(pbdev->fmb.format))) {
+        return;
+    }
+
     /* Update FMB sample count */
     if (fmb_do_update(pbdev, offsetof(ZpciFmb, sample),
                       pbdev->fmb.sample++,
@@ -1114,7 +1165,7 @@ static void fmb_update(void *opaque)
         return;
     }
 
-    /* Update FMB counters */
+    /* Update FMB generic counters */
     for (i = 0; i < ZPCI_FMB_CNT_MAX; i++) {
         if (fmb_do_update(pbdev, offsetof(ZpciFmb, counter[i]),
                           pbdev->fmb.counter[i],
@@ -1123,6 +1174,7 @@ static void fmb_update(void *opaque)
         }
     }
 
+update_timer:
     /* Clear U bit and update the time */
     pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
     pbdev->fmb.last_update *= 2;
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index d749c8c80a..da630b23be 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -127,9 +127,8 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     pbdev->zpci_fn.pchid = cap->pchid;
     pbdev->zpci_fn.vfn = cap->vfn;
     pbdev->zpci_fn.pfgid = cap->gid;
-    /* The following values remain 0 until we support other FMB formats */
-    pbdev->zpci_fn.fmbl = 0;
-    pbdev->zpci_fn.pft = 0;
+    pbdev->zpci_fn.fmbl = cap->fmb_length;
+    pbdev->zpci_fn.pft = cap->pft;
     /* Store function type separately for type-specific behavior */
     pbdev->pft = cap->pft;
 
-- 
2.52.0


