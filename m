Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD3CD34097
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkI-00043j-IY; Tue, 27 Jan 2026 11:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljl-0003eH-6q; Tue, 27 Jan 2026 11:16:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljg-0000nA-Pz; Tue, 27 Jan 2026 11:16:16 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6bs9e011850;
 Tue, 27 Jan 2026 16:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4rc8jZJoWOB6Q/0Ff
 7CpZVtsA9kkUM3ZWeZ1cJAfo+Q=; b=LfE+yQRfMxoJviaRCzld3I6C9uAUG7bmM
 bQNpbRL6eF+ydGsGj4hgpOnyrg9V4DcaK6XW0A+s5A+MOYhEeponcGOqk4ZfmQcC
 Li/b+WlqIuy0RpMrYFuhkJYqyBPkgSOcrhbGp/qTU95vcd2uYEm9JjUu8ojnbgCz
 2W9HFTtw4e1ACFsijEig0yNmcQi88jw5d7a/c3wBDSccONP9waV8OlehJTQfvMYn
 Jy502jQCgzwQ6rU772wkgzKwpVrI2EsV++Jzw4aqSos3I100g57ixes8kDeNefQ8
 zBQ4g2hs5cMOYlr6HbtnH6TSkWWk8FUTbYw3u1yE313gy/YuDccag==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmv52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE0GJ5026319;
 Tue, 27 Jan 2026 16:16:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk9953-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:09 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGG84Q28705524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FA9D5805C;
 Tue, 27 Jan 2026 16:16:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AA6D58054;
 Tue, 27 Jan 2026 16:16:07 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:06 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 08/14] s390x: Add definitions for PCI IPL type
Date: Tue, 27 Jan 2026 11:15:41 -0500
Message-ID: <20260127161547.459443-9-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978e4ca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=0qm_gR34U64S8nBTP2UA:9
X-Proofpoint-GUID: 1LMWebY790csmqgthKCiREnPwSF9gFbp
X-Proofpoint-ORIG-GUID: 1LMWebY790csmqgthKCiREnPwSF9gFbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX28MGTZalZx1D
 RCD6WdPD6SF7C9Nsj/L1ap0visOKm6q2d+q0M/Ll41E92KcUCs8mr8NuUAkFsRZy8UDcg8uoJVj
 w7/zkEGv2VY+0iriWE7+MhUPLC+NdTFFXM9xTnJkC6LOKWr0VJEwAjZPcoAi+jruoMLlFzrao+L
 xkOrXVkS3o6QSC8pJl37ZaifaCUo5nL6K6wZlblJlWJrmpnCEPN7n2fmmzWn0Gj+yrdNp0/da8Y
 b6+urI1b5d82plb/X5V5PhWtcSSnA/inZPMC6I91YoNPl7JABxJEmtn1hQVrQ+hmbF9bW+QXtu+
 sXuvKoACIOAU4n9CnsbeMTw1X5sSLK7AjFoXuOWtpnnOMl+LRC1SrePC38ORdM/NuEBoh0G+4nX
 v9CuwoYIOEkloq5rTjeEn+pqyoBbwneBXYdSE5eLBDPFomJylDzCEu8xICUfSHF1mjpMVtHHZrV
 UYQjNKhYObeNekOkNbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
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

Define a new PBT code and IPLB layout in preperation for supporting PCI device
IPL on s390x.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6dc12dd859..8d3c83a80b 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -23,6 +23,7 @@
 enum S390IplType {
     S390_IPL_TYPE_FCP = 0x00,
     S390_IPL_TYPE_CCW = 0x02,
+    S390_IPL_TYPE_PCI = 0x04,
     S390_IPL_TYPE_PV = 0x05,
     S390_IPL_TYPE_QEMU_SCSI = 0xff
 };
@@ -108,6 +109,14 @@ struct IplBlockQemuScsi {
 } QEMU_PACKED;
 typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
+struct IplBlockPci {
+    uint32_t reserved0[76];
+    uint8_t  opt;
+    uint8_t  reserved1[3];
+    uint32_t fid;
+} QEMU_PACKED;
+typedef struct IplBlockPci IplBlockPci;
+
 union IplParameterBlock {
     struct {
         uint32_t len;
@@ -123,6 +132,7 @@ union IplParameterBlock {
             IplBlockFcp fcp;
             IPLBlockPV pv;
             IplBlockQemuScsi scsi;
+            IplBlockPci pci;
         };
     } QEMU_PACKED;
     struct {
-- 
2.52.0


