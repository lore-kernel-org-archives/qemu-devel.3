Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21BCD11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 12:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOajF-00017S-Qx; Thu, 27 Nov 2025 07:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vOaj9-000156-Na; Thu, 27 Nov 2025 07:03:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vOaj6-0007KV-In; Thu, 27 Nov 2025 07:03:58 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28A2V004610;
 Thu, 27 Nov 2025 12:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9/9RY+AJiR1810Bp0
 eGg9E/43MQJrVzCzZvF7krZX3o=; b=Aw2C+hVCt/AKSFLxHTs0s6lzQKqgPzVgP
 CIoa6JZV4E7hm6Gk8pDE9DveAjdO1Wst3O8ZhYVnWEYmFHDmEq2tylLdhAoPoWZA
 7J4viHwaPRFiA3y2RAOCaLIP9JbPcr5+wxsTYZ/L68g/n76eRMWFQBIAQWwotahd
 7Vnx+7VkjzBGWwqR4+g9+vxbZG3uwlSuHTwRpms2rQOwdlSSSzzhZAI0rbHg86Xn
 nIzSOXO/GgTjRGVSA/RxFTJbHFs6ZPx33zjnBJ4MECW1MCqCge5hdsXF03AXQruv
 8/OmZxBHC0CNqNTqBfH3A3VcIMlJ5kM9/mrkDM92iBL+q/SYRHw7Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u283uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ARBuSQo008110;
 Thu, 27 Nov 2025 12:03:45 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u283ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR9EtZw027466;
 Thu, 27 Nov 2025 12:03:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4anq4h8tux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ARC3Soo21692980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 12:03:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 517CC5805D;
 Thu, 27 Nov 2025 12:03:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C0BE58058;
 Thu, 27 Nov 2025 12:03:42 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 12:03:42 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 saif.abrar@linux.vnet.ibm.com, nikhilks@linux.ibm.com,
 stefanha@redhat.com, fam@euphon.net, philmd@linaro.org
Subject: [PATCH v4 1/2] hw/nvme: Add properties for PCI vendor/device IDs
Date: Thu, 27 Nov 2025 06:02:50 -0600
Message-ID: <20251127120322.2997269-2-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
References: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX0xx4DmQkjBBE
 Z7g72loa6EFcIjVDpE9KE7AfxR6g/TwtkXIIAVG+Ux8w9pztoUkIPZbhUcM7OnLmEPaMRPvI07P
 4r1ld8eTr1mRj3U417AJtyfeZfYQhHU5agdGUqq20cZiW6RmBm75BaP0GfWvdIuIKG7Zv+3gyRi
 EdKqKuCNhB3GEsf3wKuXAyJakscivCN12Kpxl9KDpKNQixng1XXaoUn87BOmr/weNEEvFCRuACM
 wC0cBXiY2nGJBkC1H9EV8/6crgBEi/QnstObwpoAiZylVcp2rIZ244Gz4lOwONpOHqOksfG+dnz
 smRfF34Ds+WZITt34OOjKfq7Knic83Vk/QCkMiNusE3pZ3JfUOfDnyWfmyyTs4FSvKtVX5jrxYl
 TIF9LYWTxMYyxdgQR4qiJN0GhpOPGw==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=69283e22 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=FTkMjhDs4hphi1U76KgA:9
X-Proofpoint-ORIG-GUID: BqNdrmfxvZzlQF0WjLZ2HvpTwflgCnqy
X-Proofpoint-GUID: dmAHsxnAQnw-8-ew4PypO0K_KO_c9142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add properties for user specified PCI vendor, device, subsystem vendor
and subsystem IDs.

e.g. PCI IDs to be specified as follows:
-device nvme,id_vendor=0xABCD,id_device=0xA0B0,id_subsys_vendor=0xEF00,id_subsys=0xEF01

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
v3 -> v4: Resolve merge commits when moving to the latest repo.

 hw/nvme/ctrl.c | 28 +++++++++++++++++++++++++---
 hw/nvme/nvme.h |  5 +++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd42..d857be5496 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8877,7 +8877,10 @@ static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
                             Error **errp)
 {
     uint16_t vf_dev_id = n->params.use_intel_id ?
-                         PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
+                         PCI_DEVICE_ID_INTEL_NVME :
+                         (n->params.id_device ?
+                         n->params.id_device : PCI_DEVICE_ID_REDHAT_NVME);
+
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
     uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
                                       le16_to_cpu(cap->vifrsm),
@@ -8953,8 +8956,22 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
+                                                   n->params.id_subsys_vendor);
+        }
+
+        if (n->params.id_subsys) {
+            pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, n->params.id_subsys);
+        }
     }
 
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
@@ -9409,6 +9426,11 @@ static const Property nvme_props[] = {
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
     DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
     DEFINE_PROP_BOOL("ocp", NvmeCtrl, params.ocp, false),
+    DEFINE_PROP_UINT16("id_vendor", NvmeCtrl, params.id_vendor, 0),
+    DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device, 0),
+    DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
+                                                    params.id_subsys_vendor, 0),
+    DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
 };
 
 static void nvme_get_smart_warning(Object *obj, Visitor *v, const char *name,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 8f8c78c850..65fb168bc9 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -571,6 +571,11 @@ typedef struct NvmeParams {
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
2.47.3


