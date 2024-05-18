Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628ACC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 06:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Dgq-0006dX-HW; Sat, 18 May 2024 02:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1s8Dgo-0006d3-5o; Sat, 18 May 2024 02:37:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1s8Dgi-0006D0-6s; Sat, 18 May 2024 02:37:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44I6SPnC016632; Sat, 18 May 2024 06:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=V94ovN2QAHUOhSqu7wtXXx03b9WlXMUjlz7MJtaGDmA=;
 b=my46HZ5R/XSxsEWnkzT7hWVrvXyhHGieRSNM6JeWRQmK1+Uq6K50dlqgIzxptvh9WJLc
 cE+wYr6rH7F8FbM2/U7K61PMHJOLyrEWGvOXSQnc4kyiVQnifexn/Qh0+a3oLXPpwmv6
 GJ9C0T+e3o2mYlx0cIXZjqqLOD/UCG3CidT8qSBm+HtQEBzBBxCrwwBqoe+5AKvGUe4z
 Nj/Bm/rWK+Kdb/VMNCPYqusE9SnRbf7WPNQ3BdkViZEVOGJ0mt++dadIJoErw3RyIb92
 BXvkxJm/7ww4ZYYL3IY4Y7+MMgQnDE/7EWaXi8he3pvdVYu9HTT0utwnsp4luM2BWRv8 SA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6jrp0dw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 May 2024 06:35:45 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44I6ZjLM026003;
 Sat, 18 May 2024 06:35:45 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6jrp0dw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 May 2024 06:35:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44I46oV0018764; Sat, 18 May 2024 06:35:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0u4mc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 May 2024 06:35:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44I6Zflq24904416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 May 2024 06:35:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D04A458064;
 Sat, 18 May 2024 06:35:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DC8A58068;
 Sat, 18 May 2024 06:35:41 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 May 2024 06:35:41 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2] hw/nvme: Add properties for PCI vendor/device IDs and
 IEEE-OUI ID
Date: Sat, 18 May 2024 01:35:32 -0500
Message-Id: <20240518063532.19219-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fBubfJbJkR8pDVO-diKIMjPW5OlK6K9J
X-Proofpoint-ORIG-GUID: hrpjFF-O5o9If1aYGE2AGRxx4enGNBfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_02,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405180048
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add properties for user specified
- PCI vendor, device, subsystem vendor and subsystem IDs
- IEEE-OUI ID

e.g. PCI IDs to be specified as follows:
-device nvme,id_vendor=0xABCD,id_device=0xA0B0,id_subsys_vendor=0xEF00,id_subsys=0xEF01

IEEE-OUI ID (Identify Controller bytes 75:73) is to be
specified in LE format.
(e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD, Byte[75]=0xAB).

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
v1 -> v2: Updated the commit message to mention 'properties' instead of 'CLI options'.

 hw/nvme/ctrl.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 hw/nvme/nvme.h |  5 +++++
 2 files changed, 45 insertions(+), 4 deletions(-)

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
-- 
2.39.3


