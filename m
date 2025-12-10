Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42189D3B9AB
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTRDN-0004jW-5a; Wed, 10 Dec 2025 15:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDK-0004ho-Ih; Wed, 10 Dec 2025 15:55:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDI-0000hw-NE; Wed, 10 Dec 2025 15:55:10 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAILILL005894;
 Wed, 10 Dec 2025 20:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qADPa9eOmA7rIYvJ/
 wZ4uUQmvMRlJiCga7+UAXmGwK8=; b=j82DVwkAsrlAX+NNb3MF2RS7Mu9ryzALu
 33Ew3OiWwp1fvGkQj3fMLHnRFpCA/US6t2/lH84brRQ/AfacrkvWc5rrGHwmQHmN
 KcCNGU9E6+WUh85o4+WsAfA3aEA+H0hHICitWbgYbuzTEq816+auho/jP2GStO9I
 2PbiCPfPhpOgRGLL8dik+s4FBRYMt3lvJoVFxTE8f60UuXJodPFsut4vi4ne7Wfn
 Dr176nSNmNBd27+ZnbdQtlLtcZw7zEdG43GMITrIdj3P/D2a+HgcxafhHpv2uJ4I
 wPkcy+7aBNqNIEAn3DZr9ScoLrfU81vXDaj72iRDRz2wvn7PYLD6Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53kvsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAKCmFe002103;
 Wed, 10 Dec 2025 20:55:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jjma0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BAKt5Kw20120316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 20:55:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D9C758056;
 Wed, 10 Dec 2025 20:55:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF15B58052;
 Wed, 10 Dec 2025 20:55:04 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.53.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Dec 2025 20:55:04 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 08/10] s390x: Build IPLB for virtio-pci devices
Date: Wed, 10 Dec 2025 15:54:47 -0500
Message-ID: <20251210205449.2783111-9-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210205449.2783111-1-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX8JIqWcVv3VJp
 ldANk3U6DWgiQK3JZC0IVU6zTK3ZVt+vZ9AgE7RY3mLGuswgTtSqCZdm5rvBgZhWsFqPDIjEm2G
 8hq5JExUqQn5EagcB3Ap4Pi7Sekqs3vj6TkczC194GENTs5FciEeSAS2R0KPvMdPLSXt27Cn/I4
 FUY2ufEdvoL61aVHdfNdaPSSwJir2i2UNW1paJ5X2+ZU04FunOrpq72p1jzM7434MgSA70NWzc0
 RwZSvmHT6L7VLf7/wtH1Ygw/OUSgXIlQJoEz+KwPkgH/zy/K+8aA6BwE3WvrTYBmW1DqBWu/wVy
 rV3cePlKsLeIuR6oK6uGWZpEKWkRqHM9eeoDOeG1N5yizcBMzcAPci7+s6WbRfKwUFpOLq6N6mx
 lGdh3lG1FBFhCPbUCrb41so4KGFuPw==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=6939de2b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=FIndvaBErfhezouc_AYA:9
X-Proofpoint-ORIG-GUID: DiDaOiqJCxsHW2fpNqsXy-6s3KDEALEZ
X-Proofpoint-GUID: DiDaOiqJCxsHW2fpNqsXy-6s3KDEALEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
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
index f643e13057..6cbe26a0b8 100644
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
index 3843d2a850..cf423ac764 100644
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
@@ -339,7 +341,8 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     ipl->qipl.boot_menu_timeout = cpu_to_be32(splash_time);
 }
 
-#define CCW_DEVTYPE_NONE        0x00
+#define S390_DEVTYPE_NONE       0x00
+
 #define CCW_DEVTYPE_VIRTIO      0x01
 #define CCW_DEVTYPE_VIRTIO_NET  0x02
 #define CCW_DEVTYPE_SCSI        0x03
@@ -348,7 +351,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
 static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 {
     CcwDevice *ccw_dev = NULL;
-    int tmp_dt = CCW_DEVTYPE_NONE;
+    int tmp_dt = S390_DEVTYPE_NONE;
 
     if (dev_st) {
         VirtIONet *virtio_net_dev = (VirtIONet *)
@@ -395,6 +398,31 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
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
@@ -427,14 +455,12 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
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
@@ -484,6 +510,26 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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


