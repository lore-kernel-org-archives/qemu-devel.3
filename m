Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3652CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAscw-0003p5-La; Mon, 20 Oct 2025 12:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAsck-0003jY-94; Mon, 20 Oct 2025 12:20:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAsci-0000tB-10; Mon, 20 Oct 2025 12:20:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7Jg8o025774;
 Mon, 20 Oct 2025 16:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iOLemRhpy9jygC6HQ
 BQlpKiDPxmooQPNig/YMzs6GHU=; b=l7ZHpSk3SLg8CYgR3KWvI7AgagE+MJspX
 YCWy+uv15D4UHplmfTzpCiA1X3Ft09PF4wIAw/KaSV6JIwJJUCQUDFMDo7/igbPN
 hGG1plNU7l9sHHOZ2EhtYJQFah3rQGEt7Oyy+2V0fTs9EIh9XUfvA5OILwykHcaW
 GwUOBNRFDkwI3xeSz5OMWE4HUNcOu+kBYfCO7ocQHcyr5uzonC257x5VRZ9D8kwh
 SHDIQY210px9/CCIPRnDwJA4NTn5slXN+HZzbCpgWQkSdKJCF7tf3pgG0PXTDXEk
 nwikMUmXj6nTW1kS3VVNcSxfoii6ppnNz9ADGjnLQR3Bo29wsRKQw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h9b95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KEJJk0017066;
 Mon, 20 Oct 2025 16:20:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxpmwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KGKaDr42140068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 16:20:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A223058065;
 Mon, 20 Oct 2025 16:20:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B1B958052;
 Mon, 20 Oct 2025 16:20:36 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.78.141])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 16:20:35 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 6/7] s390x: Build IPLB for virtio-pci devices
Date: Mon, 20 Oct 2025 12:20:22 -0400
Message-ID: <20251020162023.3649165-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251020162023.3649165-1-jrossi@linux.ibm.com>
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+b/QEdKw9IED
 W1oB+IgeDpgLBWMTatuqMa15WuicReRqWBbwHOw8ArZxV534NaseSpkBHEQFRNXZUQyQ0sDxVFl
 W7cHdJDPXORcMA3c/ytGykhlpB6hy5W7Ch/Oh7kg7IJZtR4U243AMD6VJfXxOQrZ1sJGzuC8GF+
 y5Zc/9VvTe35syAwTIHcqItYTcBC8vdEbmZM6CyXVL+Lz8vHkHsYL4KEkunRMwvIS+johVTTgR5
 gMy75UrOVTFmVwHZlz6SuEGgl2HEpo3PaiVZ7ZiERHYG+rtdqZwoatk9ocHbmhP+eJ8tkVDJxyr
 U8gxSDmcM4u0NTHEkyM31rL9lUF7YsGThwgEeSzFBrO1MzMBWD8FEzqSH1F8mspfNG0Il7uD55r
 gKFxT9F/l/WDlmpONs+ICI7g0/xubg==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f66156 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=kXybejxr6HjCZ4bXjZsA:9
X-Proofpoint-GUID: TEKaNRAEaIY0r_hxP-iGLEmb5dHEXsy0
X-Proofpoint-ORIG-GUID: TEKaNRAEaIY0r_hxP-iGLEmb5dHEXsy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Search for a corresponding S390PCIBusDevice and build an IPLB if a device has
been indexed for boot but does not identify as a CCW device,

PCI devices are not yet included in boot probing (they must have a boot index).
Per-device loadparm is not yet supported for PCI devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.h                  |  3 ++
 include/hw/s390x/s390-pci-bus.h |  2 ++
 hw/s390x/ipl.c                  | 56 ++++++++++++++++++++++++++++++---
 hw/s390x/s390-pci-bus.c         |  2 +-
 4 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index aec2244321..5396d4ed91 100644
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
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 04944d4fed..18c6a6d6d5 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -402,6 +402,8 @@ S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
 S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
 S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
                                               const char *target);
+S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
+                                               PCIDevice *pci_dev);
 S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2f082396c7..4d0ff25816 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -22,12 +22,14 @@
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
+#include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/virtio-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ebcdic.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
@@ -337,7 +339,8 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     ipl->qipl.boot_menu_timeout = cpu_to_be32(splash_time);
 }
 
-#define CCW_DEVTYPE_NONE        0x00
+#define S390_DEVTYPE_NONE       0x00
+
 #define CCW_DEVTYPE_VIRTIO      0x01
 #define CCW_DEVTYPE_VIRTIO_NET  0x02
 #define CCW_DEVTYPE_SCSI        0x03
@@ -346,7 +349,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
 static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 {
     CcwDevice *ccw_dev = NULL;
-    int tmp_dt = CCW_DEVTYPE_NONE;
+    int tmp_dt = S390_DEVTYPE_NONE;
 
     if (dev_st) {
         VirtIONet *virtio_net_dev = (VirtIONet *)
@@ -393,6 +396,31 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
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
+                                                           TYPE_PCI_DEVICE);
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
@@ -425,14 +453,12 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
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
@@ -482,6 +508,26 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
 
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 52820894fa..615974851b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -249,7 +249,7 @@ S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
     return NULL;
 }
 
-static S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
+S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
                                                   PCIDevice *pci_dev)
 {
     S390PCIBusDevice *pbdev;
-- 
2.49.0


