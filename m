Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EADD42BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtK0-0004xt-4O; Tue, 12 Nov 2024 11:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE7-0001sQ-24; Tue, 12 Nov 2024 10:54:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE3-00014n-Km; Tue, 12 Nov 2024 10:54:46 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFA4Kd000304;
 Tue, 12 Nov 2024 15:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=R3IJfYpXLMfGIC75P
 ZWbnfKN5nXw8Rj2CPTKmRSspuM=; b=n79gEyeAQGxjAS0E7AuqsCt9wB6V5MiGp
 wVwnSFwLMu8/gT8X/WH8CzaFStRR6k/nqnTNHHKhC9DGUX93TL5TkcKAmt/+MDAU
 Edy/smCg1m5PVn4vpMUWWH8fAVv7EYzErwoKp7kaIbCKB8i00EdUvdITGkZygcY8
 PjsDz5invqyWSL3+PfijCY/FXFu1u7j4nr6XlWPwEiV/fzE0DCvUfyl+WBjlnL1L
 O4yZK4c4kuRoWtcpCYWZikxq2kJPyQln63o4BHOp/5ypIbncue1viCf3mWpq5c6N
 5QoAl3Z1ZcZ8CRKc898pKLmvN1+CcTbTF8pivLKSxkRGYJ6r3b2bw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9dv06tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC7B4R4006674;
 Tue, 12 Nov 2024 15:54:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jcdhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsZ2L62980356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56BFE20040;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2816D2004E;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 01/14] s390x/cpumodel: add msa10 subfunctions
Date: Tue, 12 Nov 2024 16:54:06 +0100
Message-ID: <20241112155420.42042-2-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vS3OQQ86jr7fNqbRimV2L7E9q1DZzBTq
X-Proofpoint-ORIG-GUID: vS3OQQ86jr7fNqbRimV2L7E9q1DZzBTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=761 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 11:00:36 -0500
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

MSA10 introduces new AES XTS subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_features_def.h.inc |  6 ++++++
 target/s390x/cpu_models.c           |  4 ++++
 target/s390x/gen-features.c         | 20 ++++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index cb4e2b8920..a3c239595a 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -252,6 +252,8 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa8", MSA_EXT_8, "Message-security-assist-extension 8 facility"),
     FEAT_GROUP_INIT("msa9", MSA_EXT_9, "Message-security-assist-extension 9 facility"),
     FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
+    FEAT_GROUP_INIT("msa10", MSA_EXT_10, "Message-security-assist-extension 10 facility"),
+    FEAT_GROUP_INIT("msa10_pckmo", MSA_EXT_10_PCKMO, "Message-security-assist-extension 10 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
     FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index c53ac13352..104d186c3f 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -233,6 +233,10 @@ DEF_FEAT(KM_XTS_AES_128, "km-xts-aes-128", KM, 50, "KM XTS-AES-128")
 DEF_FEAT(KM_XTS_AES_256, "km-xts-aes-256", KM, 52, "KM XTS-AES-256")
 DEF_FEAT(KM_XTS_EAES_128, "km-xts-eaes-128", KM, 58, "KM XTS-Encrypted-AES-128")
 DEF_FEAT(KM_XTS_EAES_256, "km-xts-eaes-256", KM, 60, "KM XTS-Encrypted-AES-256")
+DEF_FEAT(KM_FULL_XTS_AES_128, "km-full-xts-aes-128", KM, 82, "KM Full-XTS-AES-128")
+DEF_FEAT(KM_FULL_XTS_AES_256, "km-full-xts-aes-256", KM, 84, "KM Full-XTS-AES-256")
+DEF_FEAT(KM_FULL_XTS_EAES_128, "km-full-xts-eaes-128", KM, 90, "KM Full-XTS-Encrypted-AES-128")
+DEF_FEAT(KM_FULL_XTS_EAES_256, "km-full-xts-eaes-256", KM, 92, "KM Full-XTS-Encrypted-AES-256")
 
 /* Features exposed via the KIMD instruction. */
 DEF_FEAT(KIMD_SHA_1, "kimd-sha-1", KIMD, 1, "KIMD SHA-1")
@@ -264,6 +268,8 @@ DEF_FEAT(PCKMO_ETDEA_256, "pckmo-etdea-192", PCKMO, 3, "PCKMO Encrypted-TDEA-192
 DEF_FEAT(PCKMO_AES_128, "pckmo-aes-128", PCKMO, 18, "PCKMO Encrypted-AES-128-Key")
 DEF_FEAT(PCKMO_AES_192, "pckmo-aes-192", PCKMO, 19, "PCKMO Encrypted-AES-192-Key")
 DEF_FEAT(PCKMO_AES_256, "pckmo-aes-256", PCKMO, 20, "PCKMO Encrypted-AES-256-Key")
+DEF_FEAT(PCKMO_AES_XTS_128_DK, "pckmo-aes-xts-128-dk", PCKMO, 21, "PCKMO Encrypt-AES-XTS-128-Double-Key")
+DEF_FEAT(PCKMO_AES_XTS_256_DK, "pckmo-aes-xts-256-dk", PCKMO, 22, "PCKMO Encrypt-AES-XTS-256-Double-Key")
 DEF_FEAT(PCKMO_ECC_P256, "pckmo-ecc-p256", PCKMO, 32, "PCKMO Encrypt-ECC-P256-Key")
 DEF_FEAT(PCKMO_ECC_P384, "pckmo-ecc-p384", PCKMO, 33, "PCKMO Encrypt-ECC-P384-Key")
 DEF_FEAT(PCKMO_ECC_P521, "pckmo-ecc-p521", PCKMO, 34, "PCKMO Encrypt-ECC-P521-Key")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index a27f4b6f79..3eb8276aee 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -477,6 +477,10 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
         { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
         { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
+        { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
+        { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
+        { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
+        { S390_FEAT_KM_FULL_XTS_EAES_256, S390_FEAT_MSA_EXT_4 },
         { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
         { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
         { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 2b2bfc3736..06c3bf64f3 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -246,6 +246,16 @@
     S390_FEAT_PCKMO_ECC_ED25519, \
     S390_FEAT_PCKMO_ECC_ED448
 
+#define S390_FEAT_GROUP_MSA_EXT_10 \
+    S390_FEAT_KM_FULL_XTS_AES_128, \
+    S390_FEAT_KM_FULL_XTS_AES_256, \
+    S390_FEAT_KM_FULL_XTS_EAES_128, \
+    S390_FEAT_KM_FULL_XTS_EAES_256
+
+#define S390_FEAT_GROUP_MSA_EXT_10_PCKMO \
+    S390_FEAT_PCKMO_AES_XTS_128_DK, \
+    S390_FEAT_PCKMO_AES_XTS_256_DK
+
 #define S390_FEAT_GROUP_ENH_SORT \
     S390_FEAT_ESORT_BASE, \
     S390_FEAT_SORTL_SFLR, \
@@ -307,10 +317,18 @@ static uint16_t group_MSA_EXT_9[] = {
     S390_FEAT_GROUP_MSA_EXT_9,
 };
 
+static uint16_t group_MSA_EXT_10[] = {
+    S390_FEAT_GROUP_MSA_EXT_10,
+};
+
 static uint16_t group_MSA_EXT_9_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
 
+static uint16_t group_MSA_EXT_10_PCKMO[] = {
+    S390_FEAT_GROUP_MSA_EXT_10_PCKMO,
+};
+
 static uint16_t group_ENH_SORT[] = {
     S390_FEAT_GROUP_ENH_SORT,
 };
@@ -858,6 +876,8 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_8),
     FEAT_GROUP_INITIALIZER(MSA_EXT_9),
     FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_10),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_10_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
     FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
-- 
2.43.5


