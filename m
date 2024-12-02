Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA13D10DD7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2Se-0006A4-Hc; Mon, 02 Dec 2024 04:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1tI2Sb-00069S-1K; Mon, 02 Dec 2024 04:11:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1tI2SY-0006ov-FK; Mon, 02 Dec 2024 04:11:15 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1KZvTY025439;
 Mon, 2 Dec 2024 09:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AfPfLRpI0P69COptG
 3hJTxdEPTesTiqhnE/FNN0y+iU=; b=LCJqhE/qDVZGxKgqhulfyv6nIrDl89uBS
 0C60qzzkxddMsHhymF/+Difm6SnldrD92QyYXandbEW1UnS/W/iBkMRvqZNK5U6C
 sIfTJLdwMb6toDqzvVshsB7Rye/JI+UzThOgXtlG3brjxDsAQB53X9eeKt5yvmER
 tAJsPrCiW8ESvrH0fhMXCyV9lVC/KQbK8nTZgskL4/xag/22KD/zgbMybKxplwga
 opkUGhU7J96MTLPqgpZypdywbL+BeaKz1CDROS6xvORa7u425INVbINddGmzfOIF
 JND+QF9RMdTbrYBMdOvb4Pl7O6XUNjvGm6vdm8odR49j4wIz9mb6Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbx7jq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 09:11:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B293w7Q015256;
 Mon, 2 Dec 2024 09:11:07 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbx7jpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 09:11:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B27duCr008156;
 Mon, 2 Dec 2024 09:11:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8j9yrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 09:11:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B29B6jV40829542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Dec 2024 09:11:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F162F58062;
 Mon,  2 Dec 2024 09:11:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F08258054;
 Mon,  2 Dec 2024 09:11:05 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Dec 2024 09:11:05 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 1/2] hw/nvme: Add properties for PCI vendor/device IDs
Date: Mon,  2 Dec 2024 03:10:48 -0600
Message-Id: <20241202091049.2250-2-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202091049.2250-1-saif.abrar@linux.vnet.ibm.com>
References: <20241202091049.2250-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YIy_pr3vfeotnQmdwAd89NcOILfhjdcY
X-Proofpoint-GUID: BlJBPvgbQdx2peSLQ0_-2XjThcSGKzXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020079
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add properties for user specified PCI vendor,
device, subsystem vendor and subsystem IDs.

e.g. PCI IDs to be specified as follows:
-device nvme,id_vendor=0xABCD,id_device=0xA0B0,id_subsys_vendor=0xEF00,id_subsys=0xEF01

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
v2 -> v3:
- User-specified PCI properties are used only when use_intel_id is not set.
- PCI properties can be set independently of each other.
- Setting IEEE-OUI moved to a different commit.

 hw/nvme/ctrl.c | 28 +++++++++++++++++++++++++---
 hw/nvme/nvme.h |  5 +++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 69bce20f66..e1aaab01bc 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8477,7 +8477,10 @@ out:
 static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
 {
     uint16_t vf_dev_id = n->params.use_intel_id ?
-                         PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
+                         PCI_DEVICE_ID_INTEL_NVME :
+                         (n->params.id_device ?
+                          n->params.id_device : PCI_DEVICE_ID_REDHAT_NVME);
+
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
     uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
                                       le16_to_cpu(cap->vifrsm),
@@ -8550,8 +8553,22 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
         pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_INTEL_NVME);
     } else {
-        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
-        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
+        uint16_t id_vendor = n->params.id_vendor ?
+                             n->params.id_vendor : PCI_VENDOR_ID_REDHAT;
+        pci_config_set_vendor_id(pci_conf, id_vendor);
+
+        uint16_t id_device = n->params.id_device ?
+                             n->params.id_device : PCI_DEVICE_ID_REDHAT_NVME;
+        pci_config_set_device_id(pci_conf, id_device);
+
+        if (n->params.id_subsys_vendor) {
+            pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID,
+                                                    n->params.id_subsys_vendor);
+        }
+
+        if (n->params.id_subsys) {
+            pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, n->params.id_subsys);
+        }
     }
 
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
@@ -8946,6 +8963,11 @@ static Property nvme_props[] = {
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
     DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
+    DEFINE_PROP_UINT16("id_vendor", NvmeCtrl, params.id_vendor, 0),
+    DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device, 0),
+    DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
+                                                    params.id_subsys_vendor, 0),
+    DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 7242206910..79404b3129 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -553,6 +553,11 @@ typedef struct NvmeParams {
     uint16_t atomic_awun;
     uint16_t atomic_awupf;
     bool     atomic_dn;
+
+    uint16_t id_vendor;
+    uint16_t id_device;
+    uint16_t id_subsys_vendor;
+    uint16_t id_subsys;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
-- 
2.39.5


