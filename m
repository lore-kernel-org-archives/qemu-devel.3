Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEAFC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 12:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s53Ba-0006KB-I8; Thu, 09 May 2024 08:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1s53BX-0006Jb-To; Thu, 09 May 2024 08:47:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1s53BW-0004LQ-0L; Thu, 09 May 2024 08:47:43 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4499enqM023143; Thu, 9 May 2024 12:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/g8SNACxoKYF4gqlVJ0Oa/d743GgeWqnhl5U466S8cU=;
 b=JOraUqsbFurAFGxMZ+ZJhtvf4C6SZyEqNjPJ1+GYpOTQPVzoWz759n5nzLxpevS0JxUs
 vu6jZ/jQvk1koGDlzfDO+XaMQRdXHwQfkVtwLiFoVk1cLzZ0MO2ESHleAg3eY0kr4uDU
 lfE1PSk41UDfXGJH/uP0G3tJLS5hNJ2GSNKUmm2mNZiuzbEpmuRPRBmS/iKqIYEa5F62
 ewLGW0HFOM3X9WQ9yx88W00vDLzA/g0tEhzKjzjMrQiPxcuzDP+oMxPRtx5WcP7YJuUE
 lhvLY61ZLggtoNfUilW5cvxfsv3a7JgQeMR4JgctPpq540NzlXpjVuDrumH+paCAaqtZ xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0uxkggdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 May 2024 12:47:33 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 449ClWj8026528;
 Thu, 9 May 2024 12:47:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0uxkggdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 May 2024 12:47:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 449BXRPf009268; Thu, 9 May 2024 12:47:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xyshtaw1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 May 2024 12:47:30 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 449ClSW111928304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 May 2024 12:47:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F242A58061;
 Thu,  9 May 2024 12:47:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A35AD58057;
 Thu,  9 May 2024 12:47:27 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 May 2024 12:47:27 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH] hw/nvme: Add CLI options for PCI vendor/device IDs and
 IEEE-OUI ID
Date: Thu,  9 May 2024 07:47:23 -0500
Message-Id: <20240509124723.3930-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Eyw-x0NdaLd47T5iftBUftfj0eapzEpI
X-Proofpoint-GUID: gvU4qIRM4CspPjuQd_hDdmV5rxKQmTIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090085
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add CLI options for user specified
- PCI vendor, device, subsystem vendor and subsystem IDs
- IEEE-OUI ID

e.g. PCI IDs to be specified as follows:
-device nvme,id_vendor=0xABCD,id_device=0xA0B0,id_subsys_vendor=0xEF00,id_subsys=0xEF01

IEEE-OUI ID (Identify Controller bytes 75:73) is to be
specified in LE format.
(e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD, Byte[75]=0xAB).

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
 hw/nvme/nvme.h |  5 +++++
 hw/nvme/ctrl.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..6e19a479d1 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -537,6 +537,11 @@ typedef struct NvmeParams {
     uint8_t  sriov_max_vq_per_vf;
     uint8_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
+    uint16_t id_vendor;
+    uint16_t id_device;
+    uint16_t id_subsys_vendor;
+    uint16_t id_subsys;
+    uint32_t ieee_oui;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..35aeb48e0b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8050,8 +8050,9 @@ out:
 
 static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
 {
-    uint16_t vf_dev_id = n->params.use_intel_id ?
-                         PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
+    uint16_t vf_dev_id = n->params.id_device ? n->params.id_device :
+                        (n->params.use_intel_id ?
+                         PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME);
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
     uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
                                       le16_to_cpu(cap->vifrsm),
@@ -8098,7 +8099,13 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
 
-    if (n->params.use_intel_id) {
+    if (n->params.id_vendor) {
+        pci_config_set_vendor_id(pci_conf, n->params.id_vendor);
+        pci_config_set_device_id(pci_conf, n->params.id_device);
+        pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID,
+                                                    n->params.id_subsys_vendor);
+        pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, n->params.id_subsys);
+    } else if (n->params.use_intel_id) {
         pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
         pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_INTEL_NVME);
     } else {
@@ -8206,7 +8213,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->rab = 6;
 
-    if (n->params.use_intel_id) {
+    if (n->params.ieee_oui) {
+        id->ieee[0] = extract32(n->params.ieee_oui, 0,  8);
+        id->ieee[1] = extract32(n->params.ieee_oui, 8,  8);
+        id->ieee[2] = extract32(n->params.ieee_oui, 16, 8);
+    } else if (n->params.use_intel_id) {
         id->ieee[0] = 0xb3;
         id->ieee[1] = 0x02;
         id->ieee[2] = 0x00;
@@ -8419,6 +8430,24 @@ static void nvme_exit(PCIDevice *pci_dev)
     memory_region_del_subregion(&n->bar0, &n->iomem);
 }
 
+static void nvme_prop_ieee_set(Object *obj, Visitor *v, const char *name,
+        void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    uint32_t *val = object_field_prop_ptr(obj, prop);
+    if (!visit_type_uint32(v, name, val, errp)) {
+        return;
+    }
+}
+
+static const PropertyInfo nvme_prop_ieee = {
+    .name  = "uint32",
+    .description = "IEEE OUI: Identify Controller bytes 75:73\
+ in LE format. (e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD,\
+ Byte[75]=0xAB)",
+    .set = nvme_prop_ieee_set,
+};
+
 static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
@@ -8451,6 +8480,13 @@ static Property nvme_props[] = {
                       params.sriov_max_vq_per_vf, 0),
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
+    DEFINE_PROP_UINT16("id_vendor", NvmeCtrl, params.id_vendor, 0),
+    DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device, 0),
+    DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
+                                                    params.id_subsys_vendor, 0),
+    DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
+    DEFINE_PROP("ieee_oui", NvmeCtrl, params.ieee_oui, nvme_prop_ieee,
+                                                                      uint32_t),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.39.3


