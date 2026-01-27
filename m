Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C60D34097
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkg-0004VC-Mo; Tue, 27 Jan 2026 11:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljr-0003gF-7s; Tue, 27 Jan 2026 11:16:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljo-0000ot-IP; Tue, 27 Jan 2026 11:16:22 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R8OYXq016222;
 Tue, 27 Jan 2026 16:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=a74Mts9RjF9Deik8y
 OyFFLkw+yBMo4UV4ILakJpRQQQ=; b=AhISqjl3iBZFzxuzafioDIyp49Zj1jrC8
 rewQvPlM39QmMJmR6lzws/9suJsb+n1DwvZLfUug0uwhXpRcVcsj+u3MHjWSXfYH
 mhHLgLrkTG5mEzyc51/nNTzzZHi8/Ko4hN/eRoBS1P2A2QzxjRYtBT9YJnJu79Qs
 W6HnvCHprf7VbnzMFm9BlejJq4Kut0O6piVaBF47QNyzULBXj3rt6G4VlPmsh2VI
 lHFYVoyMrPT9QwbkwBsNYLmfkt93VAzw0boenG7b9NmoGZ5DsJgxAB0Hn6QIIXd0
 zC+PZMRJgm7uOgw7eCd73HHv0aJr6HiuMgMGY5HbFzG1DaKO0wdqg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr64hf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD6KMI019646;
 Tue, 27 Jan 2026 16:16:17 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn1b4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGGG3q22938138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E7565805A;
 Tue, 27 Jan 2026 16:16:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00D325805F;
 Tue, 27 Jan 2026 16:16:15 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:14 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 12/14] s390x: Build IPLB for virtio-pci devices
Date: Tue, 27 Jan 2026 11:15:45 -0500
Message-ID: <20260127161547.459443-13-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX6gqQh+nQq7hL
 tAwIn+ZXikGaaZvO29pPecfZSBdkvvE8DXF/TRTPjYSLcqDKS9iN20E98F86+AhZltytTbacbMf
 nIJ8hGXILKxIarCcKG0k2rzr9o8JhVsKulJEL5bBSVTn7TJqc2a3HbFQOtycEoB7GqCd+FSsxo4
 bNrynFXCS0N/RZtB7q+1vKXFocPXYD+09N0dIIYg9y6GjIl+uKir+SHzvLQbsS7rJjcHhyDtZ2V
 7COvMor7ydjwpOREiwVo+57jUJ6OgffhEzZHNbDT91WatQzgP4tl/IQdweO8m/WsY4jafr3aatI
 CM4sqO/bHueIkzN2dHwLpPpuS73nMJ9Jxi2Penb814DmO3fdbzc8Mds4E/0JYmm6FEvkDLF76Tb
 /sL/qXfhYrcCAgsesANojFCV7Zfis2z0V2nbT39mZL0XBM4AvvNwHJpl0R1JPkSOW2KVW5C2I7R
 DTFk8Q9bhLE0hghYyfA==
X-Proofpoint-GUID: 0WXbqt0s5AOlN0RryNVKEwglFTYxNdvw
X-Proofpoint-ORIG-GUID: 0WXbqt0s5AOlN0RryNVKEwglFTYxNdvw
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=6978e4d2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=urF6NN474TAylNp3iV8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


