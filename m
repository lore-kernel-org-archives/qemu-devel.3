Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A14E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSN-0007Pf-JS; Fri, 06 Dec 2024 07:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRO-0005xh-Ba; Fri, 06 Dec 2024 07:28:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRI-00041p-I7; Fri, 06 Dec 2024 07:28:11 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Aokvv012087;
 Fri, 6 Dec 2024 12:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3CCW8EW/CVcSZQD7J
 fEySXBqYWpDsOjkm1NAj28EnOQ=; b=jhjRmEsE4E5U/obOlBHd0/veZo6xwfTPk
 1YANpFs9azXhi4kAxVFRNWxr88i/hWcAoKVv5uyokHP1tvPL6aX0jQtMk/M3lFdO
 0FhnDubjqrGmW0qNMQnYQ9wH8Zy1v0+cP0DXH03Gefz2W/NF3bIVcJXg5j7WUF8u
 6Iw6OAcSHS0A7fo8LsxicmuKIDwjcWFW4cLtu+nmyUzNfOLSbrLd/GqHoc6HnLxA
 iQaYAzA8RS0tCiCb1k9Udm9e9IlgB9Io4lWfyLYCnBTNkyj9KHmzXNrEpAN4Gs8b
 3iVyhKczjpsXvIw185Bau7QsPeU35KZCFAriTSCYmwWB6jFVhRhPQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bk99kc2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6APBpg005278;
 Fri, 6 Dec 2024 12:28:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1xmpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CRxhP61276556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:27:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CD622004B;
 Fri,  6 Dec 2024 12:27:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F7C920043;
 Fri,  6 Dec 2024 12:27:59 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:27:59 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 03/15] s390x/cpumodel: add msa12 changes
Date: Fri,  6 Dec 2024 13:27:39 +0100
Message-ID: <20241206122751.189721-4-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sYj2a84fbthD7hIOlrMf1EpXHjGhArsO
X-Proofpoint-ORIG-GUID: sYj2a84fbthD7hIOlrMf1EpXHjGhArsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=924 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060089
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

MSA12 changes the KIMD/KLMD instruction format for SHA3/SHAKE.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 target/s390x/cpu_features.c         | 1 +
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/gen-features.c         | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 36930feccd..0e0b37ab95 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -256,6 +256,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa10_pckmo", MSA_EXT_10_PCKMO, "Message-security-assist-extension 10 PCKMO subfunctions"),
     FEAT_GROUP_INIT("msa11", MSA_EXT_11, "Message-security-assist-extension 11 facility"),
     FEAT_GROUP_INIT("msa11_pckmo", MSA_EXT_11_PCKMO, "Message-security-assist-extension 11 PCKMO subfunctions"),
+    FEAT_GROUP_INIT("msa12", MSA_EXT_12, "Message-security-assist-extension 12 facility"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
     FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 15ea51fc54..2e5dc96984 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -90,6 +90,7 @@ DEF_FEAT(EDAT_2, "edat2", STFL, 78, "Enhanced-DAT facility 2")
 DEF_FEAT(DFP_PACKED_CONVERSION, "dfppc", STFL, 80, "Decimal-floating-point packed-conversion facility")
 DEF_FEAT(PPA15, "ppa15", STFL, 81, "PPA15 is installed")
 DEF_FEAT(BPB, "bpb", STFL, 82, "Branch prediction blocking")
+DEF_FEAT(MSA_EXT_12, "msa12-base", STFL, 86, "Message-security-assist-extension-12 facility (excluding subfunctions)")
 DEF_FEAT(VECTOR, "vx", STFL, 129, "Vector facility")
 DEF_FEAT(INSTRUCTION_EXEC_PROT, "iep", STFL, 130, "Instruction-execution-protection facility")
 DEF_FEAT(SIDE_EFFECT_ACCESS_ESOP2, "sea_esop2", STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index d6305f945a..ab9ad51d5e 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -270,6 +270,9 @@
     S390_FEAT_PCKMO_HMAC_512, \
     S390_FEAT_PCKMO_HMAC_1024
 
+#define S390_FEAT_GROUP_MSA_EXT_12 \
+    S390_FEAT_MSA_EXT_12
+
 #define S390_FEAT_GROUP_ENH_SORT \
     S390_FEAT_ESORT_BASE, \
     S390_FEAT_SORTL_SFLR, \
@@ -339,6 +342,10 @@ static uint16_t group_MSA_EXT_11[] = {
     S390_FEAT_GROUP_MSA_EXT_11,
 };
 
+static uint16_t group_MSA_EXT_12[] = {
+    S390_FEAT_GROUP_MSA_EXT_12,
+};
+
 static uint16_t group_MSA_EXT_9_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
@@ -902,6 +909,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_10_PCKMO),
     FEAT_GROUP_INITIALIZER(MSA_EXT_11),
     FEAT_GROUP_INITIALIZER(MSA_EXT_11_PCKMO),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_12),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
     FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
-- 
2.43.5


