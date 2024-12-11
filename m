Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575D7E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbC-0006OC-PN; Wed, 11 Dec 2024 04:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaN-0005sg-Aj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaJ-0007qQ-GY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zx7fXv/qBsH2u1RpZJKZ0Javo/qosHvNkQsQz/L2w6w=;
 b=i9RRC7DvQoWox8mczyTCvrmaTzG/3ziwzHxb5JdaZ/83x57hd0O/nVpiFWlrMKOJmrS3H5
 1eE/8MtWzfrcktFrIGJMq3S1iG1gbZykZWYwggJ2gGtvzxGurNy3hoddjol07HoHf2j+3j
 HJqlRujhSZ7gPIgziBtP2dkTWbLQBss=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-dvBSZG4fM_uu0BFywUh4MA-1; Wed,
 11 Dec 2024 04:00:38 -0500
X-MC-Unique: dvBSZG4fM_uu0BFywUh4MA-1
X-Mimecast-MFC-AGG-ID: dvBSZG4fM_uu0BFywUh4MA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38E31955DC7; Wed, 11 Dec 2024 09:00:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02E601956089; Wed, 11 Dec 2024 09:00:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 05/26] s390x/cpumodel: add msa11 subfunctions
Date: Wed, 11 Dec 2024 09:59:49 +0100
Message-ID: <20241211090014.619351-6-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

MSA11 introduces new HMAC subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20241206122751.189721-3-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 10 ++++++++++
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_models.c           |  8 ++++++++
 target/s390x/gen-features.c         | 24 ++++++++++++++++++++++++
 4 files changed, 44 insertions(+)

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
2.47.1


