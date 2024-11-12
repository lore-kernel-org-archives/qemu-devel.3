Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81B3D42BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtK4-0005FY-Ox; Tue, 12 Nov 2024 11:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtEJ-0001vy-KQ; Tue, 12 Nov 2024 10:54:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtEG-00014u-UA; Tue, 12 Nov 2024 10:54:58 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFe5Pu002941;
 Tue, 12 Nov 2024 15:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JF57SERxc6d7FbPlD
 DZPwreiQlyyWmmMHrZKIm1SxPk=; b=S9Ld1x2HZGgwkvX7CTcO1MsbavTxca3Q6
 TUouus2RBM+2SNt4sPP6Vkhhbsu9fsJGyHr7oQH1ld4GZq0YPOAcoeVFygzmD0Hx
 tdYcaU3/zv8VD1i6fhhQXTKIjw907YUWtZxA05q3mUkmjJ58218Mx6ZCN0tkbqcm
 +mcIbYORqG/yxETy5IknHaNSetN7YFJ1xAMMV1BplYGoUcygxVsDarB1qYRhtyrN
 QaSc5l+8l0290cb+nLqpCJBISxlybbLeKk3AmGyxbCBmlgvVfNmEgn2feYRN0K//
 KqB/6d6i7ScwkZEjuBEGPmBKq20416iZvTxJuS5oaI/+eHLooMG2w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9uy820w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEmkdR008076;
 Tue, 12 Nov 2024 15:54:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjeyjyuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsZsG62980358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EAE320040;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6004420049;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 02/14] s390x/cpumodel: add msa11 subfunctions
Date: Tue, 12 Nov 2024 16:54:07 +0100
Message-ID: <20241112155420.42042-3-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GOd_TOH9BWz970VrjO6eXA5bvRn2ekcu
X-Proofpoint-GUID: GOd_TOH9BWz970VrjO6eXA5bvRn2ekcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=771 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
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

MSA11 introduces new HMAC subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_features_def.h.inc | 10 ++++++++++
 target/s390x/cpu_models.c           |  8 ++++++++
 target/s390x/gen-features.c         | 24 ++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index a3c239595a..36930feccd 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -254,6 +254,8 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa9_pckmo", MSA_EXT_9_PCKMO, "Message-security-assist-extension 9 PCKMO subfunctions"),
     FEAT_GROUP_INIT("msa10", MSA_EXT_10, "Message-security-assist-extension 10 facility"),
     FEAT_GROUP_INIT("msa10_pckmo", MSA_EXT_10_PCKMO, "Message-security-assist-extension 10 PCKMO subfunctions"),
+    FEAT_GROUP_INIT("msa11", MSA_EXT_11, "Message-security-assist-extension 11 facility"),
+    FEAT_GROUP_INIT("msa11_pckmo", MSA_EXT_11_PCKMO, "Message-security-assist-extension 11 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
     FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 104d186c3f..15ea51fc54 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -200,6 +200,14 @@ DEF_FEAT(KMAC_AES_256, "kmac-aes-256", KMAC, 20, "KMAC AES-256")
 DEF_FEAT(KMAC_EAES_128, "kmac-eaes-128", KMAC, 26, "KMAC Encrypted-AES-128")
 DEF_FEAT(KMAC_EAES_192, "kmac-eaes-192", KMAC, 27, "KMAC Encrypted-AES-192")
 DEF_FEAT(KMAC_EAES_256, "kmac-eaes-256", KMAC, 28, "KMAC Encrypted-AES-256")
+DEF_FEAT(KMAC_HMAC_SHA_224, "kmac-hmac-sha-224", KMAC, 112, "KMAC HMAC-SHA-224")
+DEF_FEAT(KMAC_HMAC_SHA_256, "kmac-hmac-sha-246", KMAC, 113, "KMAC HMAC-SHA-256")
+DEF_FEAT(KMAC_HMAC_SHA_384, "kmac-hmac-sha-384", KMAC, 114, "KMAC HMAC-SHA-384")
+DEF_FEAT(KMAC_HMAC_SHA_512, "kmac-hmac-sha-512", KMAC, 115, "KMAC HMAC-SHA-512")
+DEF_FEAT(KMAC_HMAC_ESHA_224, "kmac-hmac-esha-224", KMAC, 120, "KMAC HMAC-Encrypted-SHA-224")
+DEF_FEAT(KMAC_HMAC_ESHA_256, "kmac-hmac-esha-246", KMAC, 121, "KMAC HMAC-Encrypted-SHA-256")
+DEF_FEAT(KMAC_HMAC_ESHA_384, "kmac-hmac-esha-384", KMAC, 122, "KMAC HMAC-Encrypted-SHA-384")
+DEF_FEAT(KMAC_HMAC_ESHA_512, "kmac-hmac-esha-512", KMAC, 123, "KMAC HMAC-Encrypted-SHA-512")
 
 /* Features exposed via the KMC instruction. */
 DEF_FEAT(KMC_DEA, "kmc-dea", KMC, 1, "KMC DEA")
@@ -275,6 +283,8 @@ DEF_FEAT(PCKMO_ECC_P384, "pckmo-ecc-p384", PCKMO, 33, "PCKMO Encrypt-ECC-P384-Ke
 DEF_FEAT(PCKMO_ECC_P521, "pckmo-ecc-p521", PCKMO, 34, "PCKMO Encrypt-ECC-P521-Key")
 DEF_FEAT(PCKMO_ECC_ED25519, "pckmo-ecc-ed25519", PCKMO, 40 , "PCKMO Encrypt-ECC-Ed25519-Key")
 DEF_FEAT(PCKMO_ECC_ED448, "pckmo-ecc-ed448", PCKMO, 41 , "PCKMO Encrypt-ECC-Ed448-Key")
+DEF_FEAT(PCKMO_HMAC_512, "pckmo-hmac-512", PCKMO, 118, "PCKMO Encrypt-HMAC-512-Key")
+DEF_FEAT(PCKMO_HMAC_1024, "pckmo-hmac-1024", PCKMO, 122, "PCKMO Encrypt-HMAC-1024-Key")
 
 /* Features exposed via the KMCTR instruction. */
 DEF_FEAT(KMCTR_DEA, "kmctr-dea", KMCTR, 1, "KMCTR DEA")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 3eb8276aee..a62a3c3771 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -477,6 +477,14 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
         { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
         { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
+        { S390_FEAT_KMAC_HMAC_SHA_224, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_KMAC_HMAC_SHA_256, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_KMAC_HMAC_SHA_384, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_KMAC_HMAC_SHA_512, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_KMAC_HMAC_ESHA_224, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_KMAC_HMAC_ESHA_256, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_KMAC_HMAC_ESHA_384, S390_FEAT_MSA_EXT_3 },
+        { S390_FEAT_KMAC_HMAC_ESHA_512, S390_FEAT_MSA_EXT_3 },
         { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
         { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
         { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 06c3bf64f3..d6305f945a 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -256,6 +256,20 @@
     S390_FEAT_PCKMO_AES_XTS_128_DK, \
     S390_FEAT_PCKMO_AES_XTS_256_DK
 
+#define S390_FEAT_GROUP_MSA_EXT_11 \
+    S390_FEAT_KMAC_HMAC_SHA_224, \
+    S390_FEAT_KMAC_HMAC_SHA_256, \
+    S390_FEAT_KMAC_HMAC_SHA_384, \
+    S390_FEAT_KMAC_HMAC_SHA_512, \
+    S390_FEAT_KMAC_HMAC_ESHA_224, \
+    S390_FEAT_KMAC_HMAC_ESHA_256, \
+    S390_FEAT_KMAC_HMAC_ESHA_384, \
+    S390_FEAT_KMAC_HMAC_ESHA_512
+
+#define S390_FEAT_GROUP_MSA_EXT_11_PCKMO \
+    S390_FEAT_PCKMO_HMAC_512, \
+    S390_FEAT_PCKMO_HMAC_1024
+
 #define S390_FEAT_GROUP_ENH_SORT \
     S390_FEAT_ESORT_BASE, \
     S390_FEAT_SORTL_SFLR, \
@@ -321,6 +335,10 @@ static uint16_t group_MSA_EXT_10[] = {
     S390_FEAT_GROUP_MSA_EXT_10,
 };
 
+static uint16_t group_MSA_EXT_11[] = {
+    S390_FEAT_GROUP_MSA_EXT_11,
+};
+
 static uint16_t group_MSA_EXT_9_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
@@ -329,6 +347,10 @@ static uint16_t group_MSA_EXT_10_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_10_PCKMO,
 };
 
+static uint16_t group_MSA_EXT_11_PCKMO[] = {
+    S390_FEAT_GROUP_MSA_EXT_11_PCKMO,
+};
+
 static uint16_t group_ENH_SORT[] = {
     S390_FEAT_GROUP_ENH_SORT,
 };
@@ -878,6 +900,8 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_9_PCKMO),
     FEAT_GROUP_INITIALIZER(MSA_EXT_10),
     FEAT_GROUP_INITIALIZER(MSA_EXT_10_PCKMO),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_11),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_11_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
     FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
-- 
2.43.5


