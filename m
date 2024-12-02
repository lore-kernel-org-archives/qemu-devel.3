Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB55D10DCF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2Sk-0006Ae-1E; Mon, 02 Dec 2024 04:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1tI2Sc-00069s-Ou; Mon, 02 Dec 2024 04:11:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1tI2Sb-0006p3-5n; Mon, 02 Dec 2024 04:11:18 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B23bLY4014033;
 Mon, 2 Dec 2024 09:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zhsp8mSWhFuapcoc/
 8Lyqxhgye/GcnVptf9lMJnYsnw=; b=PWQcGeJBXQ/wMkoU0RRpsnCfY6kA9UuA8
 rjhDxuniDrep36lzxU8/gaWgZ+ObCSfI7Ld1T8Fpf2ZXjbRd9+gPYXVClWe6vNXt
 SEnA4vQpJrBXx4o5RJiRLDSTytZ0sZkAXCTqt5lZktn+IoUsBCS82ENl/DtAbmVA
 rqZIifLOI2oY69kjuNKTiIPFRyIYQyq4X6mWMrMDo9oNGj6t4VY8WmIQogHyyo3J
 jJaqgrdx02b+lIRIS6szgmXy3WUWbPUPUAHzt6sW/vA9yjMZdlqCjnRke3cXazA1
 mjAVdAlDMiDjUAJMzGSVfxLt5Uu3/uyYtWoNCRWplZa4u6/LeBjXw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4hqs9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 09:11:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B2918SQ031217;
 Mon, 2 Dec 2024 09:11:09 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4hqs9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 09:11:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B25TKYV020366;
 Mon, 2 Dec 2024 09:11:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s24rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 09:11:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B29B7cg15401644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Dec 2024 09:11:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBC245805A;
 Mon,  2 Dec 2024 09:11:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2967A58068;
 Mon,  2 Dec 2024 09:11:07 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Dec 2024 09:11:07 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 2/2] hw/nvme: Add property for user-specified IEEE-OUI ID
Date: Mon,  2 Dec 2024 03:10:49 -0600
Message-Id: <20241202091049.2250-3-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202091049.2250-1-saif.abrar@linux.vnet.ibm.com>
References: <20241202091049.2250-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AtJd0yHU9lyZg1OtS88_GsrJdcHXKaVM
X-Proofpoint-ORIG-GUID: UbqbPl7gfJ0-h1GZSGVJEptrGpFUKSTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
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

User-specified IEEE-OUI ID (Identify Controller bytes 75:73)
is to be specified in LE format.
(e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD, Byte[75]=0xAB)

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
This is a new commit for setting IEEE-OUI ID.

 hw/nvme/ctrl.c | 24 ++++++++++++++++++++++++
 hw/nvme/nvme.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e1aaab01bc..cf7b487a67 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8708,6 +8708,10 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
         id->ieee[0] = 0xb3;
         id->ieee[1] = 0x02;
         id->ieee[2] = 0x00;
+    } else if (n->params.ieee_oui) {
+        id->ieee[0] = extract32(n->params.ieee_oui, 0,  8);
+        id->ieee[1] = extract32(n->params.ieee_oui, 8,  8);
+        id->ieee[2] = extract32(n->params.ieee_oui, 16, 8);
     } else {
         id->ieee[0] = 0x00;
         id->ieee[1] = 0x54;
@@ -8925,6 +8929,24 @@ static void nvme_exit(PCIDevice *pci_dev)
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
@@ -8968,6 +8990,8 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
                                                     params.id_subsys_vendor, 0),
     DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
+    DEFINE_PROP("ieee_oui", NvmeCtrl, params.ieee_oui, nvme_prop_ieee,
+                                                                      uint32_t),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 79404b3129..f26bf7052c 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -558,6 +558,8 @@ typedef struct NvmeParams {
     uint16_t id_device;
     uint16_t id_subsys_vendor;
     uint16_t id_subsys;
+
+    uint32_t ieee_oui;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
-- 
2.39.5


