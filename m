Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DF6E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbZ-00078d-2d; Wed, 11 Dec 2024 04:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIab-0005u9-6W
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaT-0007rD-AJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RX0g7vuXQ8zo5k1BKnp/M+9uNqn1NEAbCP3JerlmXoU=;
 b=W+uUeekKlgQdHuAUL+UtBCgpXXl0r2W5tmsGjMl5vpVt6MkLqhb2mRqEOEmvxppXIRD8wy
 SIfJ48IvsfVffnK6AEvBSvXzJz+KXkbwl7QeAHKHA2lWv7fGSgQTiBW+Sp7Kgh0TglhtT3
 oFkt/lXewouNyb+k+SNzmKvWky0ljJY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-Hzo9z9nrNp6cyCK3n3T8yw-1; Wed,
 11 Dec 2024 04:00:46 -0500
X-MC-Unique: Hzo9z9nrNp6cyCK3n3T8yw-1
X-Mimecast-MFC-AGG-ID: Hzo9z9nrNp6cyCK3n3T8yw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AAEF1955F28; Wed, 11 Dec 2024 09:00:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 585181956089; Wed, 11 Dec 2024 09:00:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 07/26] s390x/cpumodel: add msa13 subfunctions
Date: Wed, 11 Dec 2024 09:59:51 +0100
Message-ID: <20241211090014.619351-8-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hendrik Brueckner <brueckner@linux.ibm.com>

MSA13 introduces query authentication information (QAI) subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20241206122751.189721-5-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 12 ++++++++++++
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/gen-features.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 2e5dc96984..2132837ffe 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -209,6 +209,7 @@ DEF_FEAT(KMAC_HMAC_ESHA_224, "kmac-hmac-esha-224", KMAC, 120, "KMAC HMAC-Encrypt
 DEF_FEAT(KMAC_HMAC_ESHA_256, "kmac-hmac-esha-246", KMAC, 121, "KMAC HMAC-Encrypted-SHA-256")
 DEF_FEAT(KMAC_HMAC_ESHA_384, "kmac-hmac-esha-384", KMAC, 122, "KMAC HMAC-Encrypted-SHA-384")
 DEF_FEAT(KMAC_HMAC_ESHA_512, "kmac-hmac-esha-512", KMAC, 123, "KMAC HMAC-Encrypted-SHA-512")
+DEF_FEAT(KMAC_QAI, "kmac-qai", KMAC, 127, "KMAC Query-Authentication-Information")
 
 /* Features exposed via the KMC instruction. */
 DEF_FEAT(KMC_DEA, "kmc-dea", KMC, 1, "KMC DEA")
@@ -246,6 +247,7 @@ DEF_FEAT(KM_FULL_XTS_AES_128, "km-full-xts-aes-128", KM, 82, "KM Full-XTS-AES-12
 DEF_FEAT(KM_FULL_XTS_AES_256, "km-full-xts-aes-256", KM, 84, "KM Full-XTS-AES-256")
 DEF_FEAT(KM_FULL_XTS_EAES_128, "km-full-xts-eaes-128", KM, 90, "KM Full-XTS-Encrypted-AES-128")
 DEF_FEAT(KM_FULL_XTS_EAES_256, "km-full-xts-eaes-256", KM, 92, "KM Full-XTS-Encrypted-AES-256")
+DEF_FEAT(KM_QAI, "km-qai", KM, 127, "KM Query-Authentication-Information")
 
 /* Features exposed via the KIMD instruction. */
 DEF_FEAT(KIMD_SHA_1, "kimd-sha-1", KIMD, 1, "KIMD SHA-1")
@@ -258,6 +260,7 @@ DEF_FEAT(KIMD_SHA3_512, "kimd-sha3-512", KIMD, 35, "KIMD SHA3-512")
 DEF_FEAT(KIMD_SHAKE_128, "kimd-shake-128", KIMD, 36, "KIMD SHAKE-128")
 DEF_FEAT(KIMD_SHAKE_256, "kimd-shake-256", KIMD, 37, "KIMD SHAKE-256")
 DEF_FEAT(KIMD_GHASH, "kimd-ghash", KIMD, 65, "KIMD GHASH")
+DEF_FEAT(KIMD_QAI, "kimd-qai", KIMD, 127, "KIMD Query-Authentication-Information")
 
 /* Features exposed via the KLMD instruction. */
 DEF_FEAT(KLMD_SHA_1, "klmd-sha-1", KLMD, 1, "KLMD SHA-1")
@@ -269,6 +272,7 @@ DEF_FEAT(KLMD_SHA3_384, "klmd-sha3-384", KLMD, 34, "KLMD SHA3-384")
 DEF_FEAT(KLMD_SHA3_512, "klmd-sha3-512", KLMD, 35, "KLMD SHA3-512")
 DEF_FEAT(KLMD_SHAKE_128, "klmd-shake-128", KLMD, 36, "KLMD SHAKE-128")
 DEF_FEAT(KLMD_SHAKE_256, "klmd-shake-256", KLMD, 37, "KLMD SHAKE-256")
+DEF_FEAT(KLMD_QAI, "klmd-qai", KLMD, 127, "KLMD Query-Authentication-Information")
 
 /* Features exposed via the PCKMO instruction. */
 DEF_FEAT(PCKMO_EDEA, "pckmo-edea", PCKMO, 1, "PCKMO Encrypted-DEA-Key")
@@ -286,6 +290,7 @@ DEF_FEAT(PCKMO_ECC_ED25519, "pckmo-ecc-ed25519", PCKMO, 40 , "PCKMO Encrypt-ECC-
 DEF_FEAT(PCKMO_ECC_ED448, "pckmo-ecc-ed448", PCKMO, 41 , "PCKMO Encrypt-ECC-Ed448-Key")
 DEF_FEAT(PCKMO_HMAC_512, "pckmo-hmac-512", PCKMO, 118, "PCKMO Encrypt-HMAC-512-Key")
 DEF_FEAT(PCKMO_HMAC_1024, "pckmo-hmac-1024", PCKMO, 122, "PCKMO Encrypt-HMAC-1024-Key")
+DEF_FEAT(PCKMO_QAI, "pckmo-qai", PCKMO, 127, "PCKMO Query-Authentication-Information")
 
 /* Features exposed via the KMCTR instruction. */
 DEF_FEAT(KMCTR_DEA, "kmctr-dea", KMCTR, 1, "KMCTR DEA")
@@ -300,6 +305,7 @@ DEF_FEAT(KMCTR_AES_256, "kmctr-aes-256", KMCTR, 20, "KMCTR AES-256")
 DEF_FEAT(KMCTR_EAES_128, "kmctr-eaes-128", KMCTR, 26, "KMCTR Encrypted-AES-128")
 DEF_FEAT(KMCTR_EAES_192, "kmctr-eaes-192", KMCTR, 27, "KMCTR Encrypted-AES-192")
 DEF_FEAT(KMCTR_EAES_256, "kmctr-eaes-256", KMCTR, 28, "KMCTR Encrypted-AES-256")
+DEF_FEAT(KMCTR_QAI, "kmctr-qai", KMCTR, 127, "KMCTR Query-Authentication-Information")
 
 /* Features exposed via the KMF instruction. */
 DEF_FEAT(KMF_DEA, "kmf-dea", KMF, 1, "KMF DEA")
@@ -314,6 +320,7 @@ DEF_FEAT(KMF_AES_256, "kmf-aes-256", KMF, 20, "KMF AES-256")
 DEF_FEAT(KMF_EAES_128, "kmf-eaes-128", KMF, 26, "KMF Encrypted-AES-128")
 DEF_FEAT(KMF_EAES_192, "kmf-eaes-192", KMF, 27, "KMF Encrypted-AES-192")
 DEF_FEAT(KMF_EAES_256, "kmf-eaes-256", KMF, 28, "KMF Encrypted-AES-256")
+DEF_FEAT(KMF_QAI, "kmf-qai", KMF, 127, "KMF Query-Authentication-Information")
 
 /* Features exposed via the KMO instruction. */
 DEF_FEAT(KMO_DEA, "kmo-dea", KMO, 1, "KMO DEA")
@@ -328,6 +335,7 @@ DEF_FEAT(KMO_AES_256, "kmo-aes-256", KMO, 20, "KMO AES-256")
 DEF_FEAT(KMO_EAES_128, "kmo-eaes-128", KMO, 26, "KMO Encrypted-AES-128")
 DEF_FEAT(KMO_EAES_192, "kmo-eaes-192", KMO, 27, "KMO Encrypted-AES-192")
 DEF_FEAT(KMO_EAES_256, "kmo-eaes-256", KMO, 28, "KMO Encrypted-AES-256")
+DEF_FEAT(KMO_QAI, "kmo-qai", KMO, 127, "KMO Query-Authentication-Information")
 
 /* Features exposed via the PCC instruction. */
 DEF_FEAT(PCC_CMAC_DEA, "pcc-cmac-dea", PCC, 1, "PCC Compute-Last-Block-CMAC-Using-DEA")
@@ -353,11 +361,13 @@ DEF_FEAT(PCC_SCALAR_MULT_ED25519, "pcc-scalar-mult-ed25519", PCC, 72, "PCC Scala
 DEF_FEAT(PCC_SCALAR_MULT_ED448, "pcc-scalar-mult-ed448", PCC, 73, "PCC Scalar-Multiply-Ed448")
 DEF_FEAT(PCC_SCALAR_MULT_X25519, "pcc-scalar-mult-x25519", PCC, 80, "PCC Scalar-Multiply-X25519")
 DEF_FEAT(PCC_SCALAR_MULT_X448, "pcc-scalar-mult-x448", PCC, 81, "PCC Scalar-Multiply-X448")
+DEF_FEAT(PCC_QAI, "pcc-qai", PCC, 127, "PCC Query-Authentication-Information")
 
 /* Features exposed via the PPNO/PRNO instruction. */
 DEF_FEAT(PPNO_SHA_512_DRNG, "ppno-sha-512-drng", PPNO, 3, "PPNO SHA-512-DRNG")
 DEF_FEAT(PRNO_TRNG_QRTCR, "prno-trng-qrtcr", PPNO, 112, "PRNO TRNG-Query-Raw-to-Conditioned-Ratio")
 DEF_FEAT(PRNO_TRNG, "prno-trng", PPNO, 114, "PRNO TRNG")
+DEF_FEAT(PRNO_QAI, "prno-qai", PPNO, 127, "PRNO Query-Authentication-Information")
 
 /* Features exposed via the KMA instruction. */
 DEF_FEAT(KMA_GCM_AES_128, "kma-gcm-aes-128", KMA, 18, "KMA GCM-AES-128")
@@ -366,6 +376,7 @@ DEF_FEAT(KMA_GCM_AES_256, "kma-gcm-aes-256", KMA, 20, "KMA GCM-AES-256")
 DEF_FEAT(KMA_GCM_EAES_128, "kma-gcm-eaes-128", KMA, 26, "KMA GCM-Encrypted-AES-128")
 DEF_FEAT(KMA_GCM_EAES_192, "kma-gcm-eaes-192", KMA, 27, "KMA GCM-Encrypted-AES-192")
 DEF_FEAT(KMA_GCM_EAES_256, "kma-gcm-eaes-256", KMA, 28, "KMA GCM-Encrypted-AES-256")
+DEF_FEAT(KMA_QAI, "kma-qai", KMA, 127, "KMA Query-Authentication-Information")
 
 /* Features exposed via the KDSA instruction. */
 DEF_FEAT(KDSA_ECDSA_VERIFY_P256, "kdsa-ecdsa-verify-p256", KDSA, 1, "KDSA ECDSA-Verify-P256")
@@ -383,6 +394,7 @@ DEF_FEAT(KDSA_EDDSA_SIGN_ED25519, "kdsa-eddsa-sign-ed25519", KDSA, 40, "KDSA EdD
 DEF_FEAT(KDSA_EDDSA_SIGN_ED448, "kdsa-eddsa-sign-ed448", KDSA, 44, "KDSA EdDSA-Sign-Ed448")
 DEF_FEAT(KDSA_EEDDSA_SIGN_ED25519, "kdsa-eeddsa-sign-ed25519", KDSA, 48, "KDSA Encrypted-EdDSA-Sign-Ed25519")
 DEF_FEAT(KDSA_EEDDSA_SIGN_ED448, "kdsa-eeddsa-sign-ed448", KDSA, 52, "KDSA Encrypted-EdDSA-Sign-Ed448")
+DEF_FEAT(KDSA_QAI, "kdsa-qai", KDSA, 127, "KDSA Query-Authentication-Information")
 
 /* Features exposed via the SORTL instruction. */
 DEF_FEAT(SORTL_SFLR, "sortl-sflr", SORTL, 1, "SORTL SFLR")
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 0e0b37ab95..9ba127e386 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -257,6 +257,8 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("msa11", MSA_EXT_11, "Message-security-assist-extension 11 facility"),
     FEAT_GROUP_INIT("msa11_pckmo", MSA_EXT_11_PCKMO, "Message-security-assist-extension 11 PCKMO subfunctions"),
     FEAT_GROUP_INIT("msa12", MSA_EXT_12, "Message-security-assist-extension 12 facility"),
+    FEAT_GROUP_INIT("msa13", MSA_EXT_13, "Message-security-assist-extension 13 facility"),
+    FEAT_GROUP_INIT("msa13_pckmo", MSA_EXT_13_PCKMO, "Message-security-assist-extension 13 PCKMO subfunctions"),
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
     FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index ab9ad51d5e..3326e7df43 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -273,6 +273,22 @@
 #define S390_FEAT_GROUP_MSA_EXT_12 \
     S390_FEAT_MSA_EXT_12
 
+#define S390_FEAT_GROUP_MSA_EXT_13 \
+    S390_FEAT_KDSA_QAI, \
+    S390_FEAT_KIMD_QAI, \
+    S390_FEAT_KLMD_QAI, \
+    S390_FEAT_KMAC_QAI, \
+    S390_FEAT_KMA_QAI, \
+    S390_FEAT_KMCTR_QAI, \
+    S390_FEAT_KMF_QAI, \
+    S390_FEAT_KMO_QAI, \
+    S390_FEAT_KM_QAI, \
+    S390_FEAT_PCC_QAI, \
+    S390_FEAT_PRNO_QAI
+
+#define S390_FEAT_GROUP_MSA_EXT_13_PCKMO \
+    S390_FEAT_PCKMO_QAI
+
 #define S390_FEAT_GROUP_ENH_SORT \
     S390_FEAT_ESORT_BASE, \
     S390_FEAT_SORTL_SFLR, \
@@ -346,6 +362,10 @@ static uint16_t group_MSA_EXT_12[] = {
     S390_FEAT_GROUP_MSA_EXT_12,
 };
 
+static uint16_t group_MSA_EXT_13[] = {
+    S390_FEAT_GROUP_MSA_EXT_13,
+};
+
 static uint16_t group_MSA_EXT_9_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
 };
@@ -358,6 +378,10 @@ static uint16_t group_MSA_EXT_11_PCKMO[] = {
     S390_FEAT_GROUP_MSA_EXT_11_PCKMO,
 };
 
+static uint16_t group_MSA_EXT_13_PCKMO[] = {
+    S390_FEAT_GROUP_MSA_EXT_13_PCKMO,
+};
+
 static uint16_t group_ENH_SORT[] = {
     S390_FEAT_GROUP_ENH_SORT,
 };
@@ -910,6 +934,8 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_11),
     FEAT_GROUP_INITIALIZER(MSA_EXT_11_PCKMO),
     FEAT_GROUP_INITIALIZER(MSA_EXT_12),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_13),
+    FEAT_GROUP_INITIALIZER(MSA_EXT_13_PCKMO),
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
     FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
-- 
2.47.1


