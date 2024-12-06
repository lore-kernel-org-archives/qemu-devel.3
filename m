Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C18E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRk-000683-D0; Fri, 06 Dec 2024 07:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRR-000608-ID; Fri, 06 Dec 2024 07:28:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRO-00043l-FE; Fri, 06 Dec 2024 07:28:16 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5MYYVW010709;
 Fri, 6 Dec 2024 12:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Bgmp4422IWrElhB6J
 EbzGh5td0btEOPpfE3YSVhLVD4=; b=EDEkRms5HQxDmFvYKaO20CZSSAbVgXAMh
 ykclf1hphjSfjDoRs/Xng7VTQ1CZ//gV0jpQs08eNEqou3hAB3WGYiV8VMNYoT0H
 NXL33Pnwttzt+ay3DEelm8ayVYSXFnTCTtInRfyF3eJIMH7YyEi5HRp9yDPbPLQx
 upO1/B5+2nj1mCLSXMrNmGC036Hfc9GBCN3/Uj9WUEx5AzbXXy3yl1idLlTXTKb6
 gxhJrWbPck8tujBKJd6qH+KJXfs4af9rrkzsNVVUPpdcwyrbArc+1pEBIT4o2yXK
 uB3tzUET8n2+jCd0lGlEsPdB3eCrBKF9MfFLfzCIrfbeFbgLrBsLw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24rgxg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6APBpi005278;
 Fri, 6 Dec 2024 12:28:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1xmq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CS6mc62456142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:28:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5607420040;
 Fri,  6 Dec 2024 12:28:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC2A52004D;
 Fri,  6 Dec 2024 12:28:05 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:28:05 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 15/15] s390x/cpumodel: gen17 model
Date: Fri,  6 Dec 2024 13:27:51 +0100
Message-ID: <20241206122751.189721-16-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DsdYa3c43vCY6ybeEXaftPhCK7J1SaLZ
X-Proofpoint-ORIG-GUID: DsdYa3c43vCY6ybeEXaftPhCK7J1SaLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=891 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060089
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit introduces the definition of the gen17a/gen17b CPU model.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_models.c   |  2 ++
 target/s390x/gen-features.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c169c080d1..beb50b5300 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -94,6 +94,8 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "gen15b", "IBM z15 T02 GA1"),
     CPUDEF_INIT(0x3931, 16, 1, 47, 0x08000000U, "gen16a", "IBM 3931 GA1"),
     CPUDEF_INIT(0x3932, 16, 1, 47, 0x08000000U, "gen16b", "IBM 3932 GA1"),
+    CPUDEF_INIT(0x9175, 17, 1, 47, 0x08000000U, "gen17a", "IBM 9175 GA1"),
+    CPUDEF_INIT(0x9176, 17, 1, 47, 0x08000000U, "gen17b", "IBM 9176 GA1"),
 };
 
 #define QEMU_MAX_CPU_TYPE 0x8561
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 680d45d303..41840677ce 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -561,6 +561,13 @@ static uint16_t base_GEN15_GA1[] = {
 
 #define base_GEN16_GA1 EmptyFeat
 
+static uint16_t base_GEN17_GA1[] = {
+    S390_FEAT_MISC_INSTRUCTION_EXT4,
+    S390_FEAT_SIF,
+    S390_FEAT_GROUP_MSA_EXT_12,
+    S390_FEAT_GROUP_PLO_EXT,
+};
+
 /* Full features (in order of release)
  * Automatically includes corresponding base features.
  * Full features are all features this hardware supports even if kvm/QEMU do not
@@ -715,6 +722,20 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_UV_FEAT_AP_INTR,
 };
 
+static uint16_t full_GEN17_GA1[] = {
+    S390_FEAT_VECTOR_ENH3,
+    S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3,
+    S390_FEAT_INEFF_NC_TX,
+    S390_FEAT_GROUP_GEN17_PTFF,
+    S390_FEAT_GROUP_MSA_EXT_10,
+    S390_FEAT_GROUP_MSA_EXT_10_PCKMO,
+    S390_FEAT_GROUP_MSA_EXT_11,
+    S390_FEAT_GROUP_MSA_EXT_11_PCKMO,
+    S390_FEAT_GROUP_MSA_EXT_13,
+    S390_FEAT_GROUP_MSA_EXT_13_PCKMO,
+    S390_FEAT_GROUP_CONCURRENT_FUNCTIONS,
+};
+
 
 /* Default features (in order of release)
  * Automatically includes corresponding base features.
@@ -810,6 +831,17 @@ static uint16_t default_GEN16_GA1[] = {
     S390_FEAT_PAIE,
 };
 
+static uint16_t default_GEN17_GA1[] = {
+    S390_FEAT_VECTOR_ENH3,
+    S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3,
+    S390_FEAT_GROUP_MSA_EXT_10,
+    S390_FEAT_GROUP_MSA_EXT_10_PCKMO,
+    S390_FEAT_GROUP_MSA_EXT_11,
+    S390_FEAT_GROUP_MSA_EXT_11_PCKMO,
+    S390_FEAT_GROUP_MSA_EXT_13,
+    S390_FEAT_GROUP_MSA_EXT_13_PCKMO,
+};
+
 /* QEMU (CPU model) features */
 
 static uint16_t qemu_V2_11[] = {
@@ -958,6 +990,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
     CPU_FEAT_INITIALIZER(GEN14_GA2),
     CPU_FEAT_INITIALIZER(GEN15_GA1),
     CPU_FEAT_INITIALIZER(GEN16_GA1),
+    CPU_FEAT_INITIALIZER(GEN17_GA1),
 };
 
 #define FEAT_GROUP_INITIALIZER(_name)                  \
-- 
2.43.5


