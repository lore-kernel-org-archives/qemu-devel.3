Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625D7EDEC05
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcTI-0002lR-T7; Tue, 03 Mar 2026 22:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSn-0002Sg-QI; Tue, 03 Mar 2026 21:59:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSm-0000Ym-3I; Tue, 03 Mar 2026 21:59:53 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623Ha7L91900488; Wed, 4 Mar 2026 02:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SKyveLSqvPa7yNoWL
 6mm/OjyjFmosIBGX8quLHRpiWo=; b=FrmzNkZwjbgXQsD+Xrv5nFxywXpn4mnNW
 t1LsXi89CtXDatNzhBy+StwjkTuxI8xS+A/JAWLjIUmp/a3cr0KuRtiQ9zW618FA
 4E7KqJKtJ+2lK1jRqIRLPOxkFD5WPCdv4RnGks/k1xq80iMwuziOD+SZwvq7IS63
 EAe5YRw+nwS+yjWNUBucFf8uBZ77WJOWHMVd3FnhlBduX20wQdQjXJwer8QYmSiK
 lw8cUlATUCQzuwBb0jMVSDCMZwHtCgtM0zl6szcoRLd13UuYMlWJ1A7wILF+Qn8b
 foM3pu6Kvw2jEdWD9c+iZysuJAbO8JxBhBjIiGk0MV16U8H6pEcLw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj5qhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623MGCYZ003284;
 Wed, 4 Mar 2026 02:59:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y54tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xlEm19333728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A025158053;
 Wed,  4 Mar 2026 02:59:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E8FA58043;
 Wed,  4 Mar 2026 02:59:46 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:46 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 13/15] s390x: Build IPLB for virtio-pci devices
Date: Tue,  3 Mar 2026 21:59:15 -0500
Message-ID: <20260304025917.2157032-14-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a7a026 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=urF6NN474TAylNp3iV8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX78dr2cs47svU
 PA10jtRikkeUDq9vhWSP1Sn1uN5STe5i9J/cnXXEcidTex5FwfLAbtZoNbNTkOKqQQRKkiFRJ3o
 alRFdNf/j+MJWvInJ97zJfohOrCKdYMy6p4Z1a7t7e8tYXTFC/25NoQAYEbAs0bV9fyhjWF0QYh
 Rp0i3q/ZiEND16MxX8HPXIlayuEz8nPgSbBsXfHc9MgU/R6kTFewWqQGY+sxBbbbUFmvrxlCVGD
 XGvfkxMuzLnmYH2I3iq4fbBuyXQAu4XFJNi7y7msgl5R7sHE7FBdvXQKfe/lrXAi7ynEzp/bHnz
 6cDmJKgo5jdXcWlZESBW/lvRrf33Ih/iFKue/3nZO/s4SLsyv7juAcraZaQAl+vk7qVHkoRh8GM
 pFSNjQtaWanaDDTnpD6U1dQWLA5CabJt/LV5wPMJzw7RgjQw6TfgGulVG/9gPnY0lbozqLVFuFj
 M6hpeDMzCS9Y5tE85aA==
X-Proofpoint-GUID: dUzWKXhn-MJGThYzedFKvjpTMH_3Gb1Z
X-Proofpoint-ORIG-GUID: dUzWKXhn-MJGThYzedFKvjpTMH_3Gb1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Search for a corresponding S390PCIBusDevice and build an IPLB if a device has
been indexed for boot but does not identify as a CCW device,

PCI devices are not yet included in boot probing (they must have a boot index).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c                  | 56 ++++++++++++++++++++++++++++++---
 hw/s390x/ipl.h                  |  3 ++
 hw/s390x/s390-pci-bus.c         |  3 +-
 include/hw/s390x/s390-pci-bus.h |  2 ++
 4 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d34adb5522..53dd3deafa 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -28,6 +28,8 @@
 #include "hw/s390x/ebcdic.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/s390x/s390-pci-bus.h"
 #include "exec/cpu-common.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
@@ -340,7 +342,8 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     ipl->qipl.boot_menu_timeout = cpu_to_be32(splash_time);
 }
 
-#define CCW_DEVTYPE_NONE        0x00
+#define S390_DEVTYPE_NONE       0x00
+
 #define CCW_DEVTYPE_VIRTIO      0x01
 #define CCW_DEVTYPE_VIRTIO_NET  0x02
 #define CCW_DEVTYPE_SCSI        0x03
@@ -349,7 +352,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
 static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 {
     CcwDevice *ccw_dev = NULL;
-    int tmp_dt = CCW_DEVTYPE_NONE;
+    int tmp_dt = S390_DEVTYPE_NONE;
 
     if (dev_st) {
         VirtIONet *virtio_net_dev = (VirtIONet *)
@@ -396,6 +399,31 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
     return ccw_dev;
 }
 
+#define PCI_DEVTYPE_VIRTIO       0x05
+
+static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
+{
+    S390PCIBusDevice *pbdev = NULL;
+    int tmp_dt = S390_DEVTYPE_NONE;
+
+    if (dev_st) {
+        PCIDevice *pci_dev = (PCIDevice *)
+            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
+                                       TYPE_VIRTIO_PCI);
+        if (pci_dev) {
+            pbdev = s390_pci_find_dev_by_pci(s390_get_phb(), pci_dev);
+            if (pbdev) {
+                tmp_dt = PCI_DEVTYPE_VIRTIO;
+            }
+        }
+    }
+    if (devtype) {
+        *devtype = tmp_dt;
+    }
+
+    return pbdev;
+}
+
 static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -428,14 +456,12 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
+    S390PCIBusDevice *pbdev = NULL;
     SCSIDevice *sd;
     int devtype;
     uint8_t *lp;
     g_autofree void *scsi_lp = NULL;
 
-    /*
-     * Currently allow IPL only from CCW devices.
-     */
     ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     if (ccw_dev) {
         lp = ccw_dev->loadparm;
@@ -485,6 +511,26 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         return true;
     }
 
+    pbdev = s390_get_pci_device(dev_st, &devtype);
+    if (pbdev) {
+        switch (devtype) {
+        case PCI_DEVTYPE_VIRTIO:
+            iplb->len = S390_IPLB_MIN_PCI_LEN;
+            iplb->pbt = S390_IPL_TYPE_PCI;
+            iplb->pci.fid = pbdev->fid;
+            break;
+        default:
+            return false;
+        }
+
+        /* Per-device loadparm not yet supported for non-ccw IPL */
+        lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
+        s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
+        iplb->flags |= DIAG308_FLAGS_LP_VALID;
+
+        return true;
+    }
+
     return false;
 }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index c542d30ce2..403cd08450 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -107,6 +107,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
+#define S390_IPLB_MIN_PCI_LEN 376
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 
 static inline bool iplb_valid_len(IplParameterBlock *iplb)
@@ -179,6 +180,8 @@ static inline bool iplb_valid(IplParameterBlock *iplb)
         return len >= S390_IPLB_MIN_FCP_LEN;
     case S390_IPL_TYPE_CCW:
         return len >= S390_IPLB_MIN_CCW_LEN;
+    case S390_IPL_TYPE_PCI:
+        return len >= S390_IPLB_MIN_PCI_LEN;
     case S390_IPL_TYPE_QEMU_SCSI:
     default:
         return false;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b438d63c44..ddf6efdc28 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -250,8 +250,7 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
     return NULL;
 }
 
-static S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
-                                                  PCIDevice *pci_dev)
+S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s, PCIDevice *pci_dev)
 {
     S390PCIBusDevice *pbdev;
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index f643e13057..9228523ce8 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -402,6 +402,8 @@ S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
 S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
 S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
                                               const char *target);
+S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
+                                           PCIDevice *pci_dev);
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
-- 
2.52.0


