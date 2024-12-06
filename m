Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA4E7717D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRh-00066T-6b; Fri, 06 Dec 2024 07:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRO-0005xd-Ap; Fri, 06 Dec 2024 07:28:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRI-00042F-KW; Fri, 06 Dec 2024 07:28:12 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6ALD1I010831;
 Fri, 6 Dec 2024 12:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wIAMV2ID/AdvX8BJ4
 US3JQ/iLJeaKscTezA7exiV1A0=; b=nmzgiA/k4stXpDWKnAlTkSHSbyurxLQPj
 zW7JG9wSFY7awNgb/OlZCLAB0hNDe5e/2LUH0fX9RMwH1wDbzwUl9jA2SDTaX1S6
 xEE5xUZQJNMnWO7KS0+clAZSSeiDQnJoT9ItJ5cOz+cghEyJrmI1yIr8PX1AcTGV
 CS7Fe0xfYJHMm6n52IM0C1o4kgNCbWaYMpOZZlXlWpQQWH4CPk0HCh+ecD9JjEK2
 xi1w9LIbKBwt5+6szHTlbIwmM1y8W8L+n/d4L+FL3geL6AUsKrcIffUA3b6BQQNL
 xWYnLFRlrPsaw4wOMI/5QXlhhg4UvE/pZzXmU2xjCFIXEbEwM+s8w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24rgxfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6A3MOd023551;
 Fri, 6 Dec 2024 12:28:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1ndjdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CS0oK56689018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:28:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF9C32004B;
 Fri,  6 Dec 2024 12:28:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4254C2004D;
 Fri,  6 Dec 2024 12:28:00 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:28:00 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 05/15] s390x/cpumodel: Add ptff Query Time-Stamp Event
 (QTSE) support
Date: Fri,  6 Dec 2024 13:27:41 +0100
Message-ID: <20241206122751.189721-6-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QHLrB-TKOTiYwm5NtoVCOkdlXT-X1A5_
X-Proofpoint-ORIG-GUID: QHLrB-TKOTiYwm5NtoVCOkdlXT-X1A5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=1 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=977 classifier=spam adjust=0 reason=mlx scancount=1
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

Introduce a new PTFF subfunction to query-stamp events.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features.c         | 1 +
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/gen-features.c         | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 9ba127e386..385a2ff860 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -241,6 +241,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("plo", PLO, "Perform-locked-operation facility"),
     FEAT_GROUP_INIT("tods", TOD_CLOCK_STEERING, "Tod-clock-steering facility"),
     FEAT_GROUP_INIT("gen13ptff", GEN13_PTFF, "PTFF enhancements introduced with z13"),
+    FEAT_GROUP_INIT("gen17ptff", GEN17_PTFF, "PTFF enhancements introduced with gen17"),
     FEAT_GROUP_INIT("msa", MSA, "Message-security-assist facility"),
     FEAT_GROUP_INIT("msa1", MSA_EXT_1, "Message-security-assist-extension 1 facility"),
     FEAT_GROUP_INIT("msa2", MSA_EXT_2, "Message-security-assist-extension 2 facility"),
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 2132837ffe..f96cb5a7d8 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -181,6 +181,7 @@ DEF_FEAT(PTFF_QSI, "ptff-qsi", PTFF, 2, "PTFF Query Steering Information")
 DEF_FEAT(PTFF_QPT, "ptff-qpc", PTFF, 3, "PTFF Query Physical Clock")
 DEF_FEAT(PTFF_QUI, "ptff-qui", PTFF, 4, "PTFF Query UTC Information")
 DEF_FEAT(PTFF_QTOU, "ptff-qtou", PTFF, 5, "PTFF Query TOD Offset User")
+DEF_FEAT(PTFF_QTSE, "ptff-qtse", PTFF, 6, "PTFF Query Time-Stamp Event")
 DEF_FEAT(PTFF_QSIE, "ptff-qsie", PTFF, 10, "PTFF Query Steering Information Extended")
 DEF_FEAT(PTFF_QTOUE, "ptff-qtoue", PTFF, 13, "PTFF Query TOD Offset User Extended")
 DEF_FEAT(PTFF_STO, "ptff-sto", PTFF, 65, "PTFF Set TOD Offset")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 3326e7df43..302b653214 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -64,6 +64,9 @@
     S390_FEAT_PTFF_STOE, \
     S390_FEAT_PTFF_STOUE
 
+#define S390_FEAT_GROUP_GEN17_PTFF \
+    S390_FEAT_PTFF_QTSE
+
 #define S390_FEAT_GROUP_MSA \
     S390_FEAT_MSA, \
     S390_FEAT_KMAC_DEA, \
@@ -318,6 +321,11 @@ static uint16_t group_GEN13_PTFF[] = {
 static uint16_t group_MULTIPLE_EPOCH_PTFF[] = {
     S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
 };
+
+static uint16_t group_GEN17_PTFF[] = {
+    S390_FEAT_GROUP_GEN17_PTFF,
+};
+
 static uint16_t group_MSA[] = {
     S390_FEAT_GROUP_MSA,
 };
@@ -918,6 +926,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(PLO),
     FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
     FEAT_GROUP_INITIALIZER(GEN13_PTFF),
+    FEAT_GROUP_INITIALIZER(GEN17_PTFF),
     FEAT_GROUP_INITIALIZER(MSA),
     FEAT_GROUP_INITIALIZER(MSA_EXT_1),
     FEAT_GROUP_INITIALIZER(MSA_EXT_2),
-- 
2.43.5


