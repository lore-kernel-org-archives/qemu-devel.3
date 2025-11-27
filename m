Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED742CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 12:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOajX-0001LM-QT; Thu, 27 Nov 2025 07:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vOajU-0001Ka-QU; Thu, 27 Nov 2025 07:04:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vOajT-0007Ln-6K; Thu, 27 Nov 2025 07:04:20 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28EDd004883;
 Thu, 27 Nov 2025 12:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=92fOwJk7srCarpgC0
 m3RdISN4XCpWDKYrSP1HvpgqKk=; b=cjF1VmLaitV7zHPMQaQC1frQNvrrDNw2f
 UFbmpGyWDGP6jYa2U1z56aiCSvaULNafFMx0iYd5M4NmkBn24TIZdnyR2kuLH5qe
 3WdAcj3QAg4Saa9CsXN5rcDAbVfvRScV9UjHK0hGB8GpDfM2mPHuuwYTRondOYAY
 6FA6+R+i7aYHBHWmwcUVAZiSxSNXPyHcAW7IRe8fCoNRDYT8ILPPqIHE5kkYWXF/
 WEImx8o202c8pQ36+puZlxeO5eoZXR7aWR4FcqgQS+4MnvUiCkHTctE9K3CXo97K
 0rALd8gAfHu/+/17HbbJKRNJ3p6wW4ErcUstA75/VS5x1o8lD8JYg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u283up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ARC3knc023877;
 Thu, 27 Nov 2025 12:03:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u283uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARANmld016428;
 Thu, 27 Nov 2025 12:03:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0kfvwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 12:03:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ARC3ihb54133044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 12:03:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 783365805B;
 Thu, 27 Nov 2025 12:03:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 737B158058;
 Thu, 27 Nov 2025 12:03:43 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 12:03:43 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 saif.abrar@linux.vnet.ibm.com, nikhilks@linux.ibm.com,
 stefanha@redhat.com, fam@euphon.net, philmd@linaro.org
Subject: [PATCH v4 2/2] hw/nvme: Add property for user-specified IEEE-OUI ID
Date: Thu, 27 Nov 2025 06:02:51 -0600
Message-ID: <20251127120322.2997269-3-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
References: <20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX3nafrpTEc+Kx
 v07DyMF9pjdmqlHNjO/fFM6Q9sm/g0K6qm1rbfuyZyrAAJzCcHbIwWnfyNSpRBmtSQMQCBiFbVn
 wenj7Ojg+EFBV/HSmB/4WzxGslXUn8uhh0ahBscZkGlPvlc3QIUS653lXZjTkIf7RTC6y8Oh0Vg
 qJUt4uHlkTSU4kZYCt6RrjmwTvkcd7h37zs+G1w6dR2g+u4mN+5LOZGHohc0HUp7sGOdapfNK2y
 CcbmYBCIBE80y8GF85zaS4wC4P6VoUH7vwAErHpWJtJAZw2bgit1A2wfcrrAxcVsUhiSBDHK32P
 n5E8uK1x5Jsvj/VaJI5NgFdmuoIY9b1p6kBclvPl0cpmgnaf6s3m2c7zJ22gE/XzbEAUqO/QTVw
 E6E6DfERxVvAylL6VGvfjSn0yfGOFw==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=69283e23 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=KVMyRY1XTioQRLGtwEgA:9
X-Proofpoint-ORIG-GUID: NM5Mr2H0wd1U2lmaDfqmMZbsQtsbjzcl
X-Proofpoint-GUID: Gxdu1jxVrRh9Jqoy0JFcAHItAK4csB5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
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

User-specified IEEE-OUI ID (Identify Controller bytes 75:73)
is to be specified in LE format.
(e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD, Byte[75]=0xAB)

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
v3 -> v4: Resolve merge commits when moving to the latest repo.

 hw/nvme/ctrl.c | 24 ++++++++++++++++++++++++
 hw/nvme/nvme.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d857be5496..c66524c78c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9131,6 +9131,10 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
         id->ieee[0] = 0xb3;
         id->ieee[1] = 0x02;
         id->ieee[2] = 0x00;
+     } else if (n->params.ieee_oui) {
+        id->ieee[0] = extract32(n->params.ieee_oui, 0,  8);
+        id->ieee[1] = extract32(n->params.ieee_oui, 8,  8);
+        id->ieee[2] = extract32(n->params.ieee_oui, 16, 8);
     } else {
         id->ieee[0] = 0x00;
         id->ieee[1] = 0x54;
@@ -9384,6 +9388,24 @@ static void nvme_exit(PCIDevice *pci_dev)
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
+    .type = "uint32",
+    .description = "IEEE OUI: Identify Controller bytes 75:73\
+ in LE format. (e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD,\
+ Byte[75]=0xAB)",
+    .set = nvme_prop_ieee_set,
+};
+
 static const Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
@@ -9431,6 +9453,8 @@ static const Property nvme_props[] = {
     DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
                                                     params.id_subsys_vendor, 0),
     DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
+    DEFINE_PROP("ieee_oui", NvmeCtrl, params.ieee_oui, nvme_prop_ieee,
+                uint32_t),
 };
 
 static void nvme_get_smart_warning(Object *obj, Visitor *v, const char *name,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 65fb168bc9..be49acaec6 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -576,6 +576,8 @@ typedef struct NvmeParams {
     uint16_t id_device;
     uint16_t id_subsys_vendor;
     uint16_t id_subsys;
+
+    uint32_t ieee_oui;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
-- 
2.47.3


