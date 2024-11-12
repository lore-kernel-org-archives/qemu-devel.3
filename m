Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB760D42BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtKJ-0005kQ-VM; Tue, 12 Nov 2024 11:01:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtEp-0002AP-O9; Tue, 12 Nov 2024 10:55:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtEo-000156-9h; Tue, 12 Nov 2024 10:55:31 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFeJVr003229;
 Tue, 12 Nov 2024 15:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4G2xq9ta9KHkaA5Cm
 oyqaPLxCf6lyixnuF4mgqizr+0=; b=ScZkZggsKCTOu7J/OrTVMLsVGr0ka8DjZ
 3L5mnG7xp9XdcnH9bSvLZnHszbFyMW7SfKhZyrU9zN0OzI+u/3O/HO9GxEOFicIR
 8pVz7A69alMT3eXP4BpHO6m0hIooamVgD11XqKT+Fp3F9iP4uZRZYjm4KuDvXZrn
 SX3j8YRI0FcPe6vhwqn91ZKrNTpYTC7Vc9mRz05vaIWMzeWe2CAPgiV38EKweTlP
 9Spt1x40PTIgbFt+YCyQ+46IbfNiK81D7Kwb7WEhoRtrFW+TJFGmlvsBEjyvWPZw
 a168L5Pk93K4x0sN32d5cxRmc5pluVDLVekmINS77TEOIpnGXX09g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9uy820y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFnOG7010568;
 Tue, 12 Nov 2024 15:54:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s4jjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsawX58851598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A2FF2004D;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F0892004B;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 05/14] s390x/cpumodel: Add ptff Query Time-Stamp Event
 (QTSE) support
Date: Tue, 12 Nov 2024 16:54:10 +0100
Message-ID: <20241112155420.42042-6-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0oJytQlcdLgIsfsBOskIZ3wD8cK38YDN
X-Proofpoint-GUID: 0oJytQlcdLgIsfsBOskIZ3wD8cK38YDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=968 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 11:00:38 -0500
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
index ed0266ede1..5a85d24bb8 100644
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


