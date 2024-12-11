Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A0BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIar-0005uv-RI; Wed, 11 Dec 2024 04:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaN-0005sS-BK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaH-0007qG-FE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yG5RjmlwSmiqq/NisGGmIQK6kx6D8eNixP4lmq/bq/U=;
 b=im8ktLxQGjF2zVpo4vUlsxId0rCs9Ih0XgQ1B4BFVR1MOGTedo8m03M4+Dcm5jVVy/2iPR
 r5sZR/A7wgu/c42yxgTDXDRE9kwaKwjtqSnl6DaZudZlmUhB1NigTlJoEs8337Tmgpt7Fr
 HPzN7gW/ehGOOd7A2+sfVktqyBWwcnM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-K5T3tAPPPGCf_VxXUFUulQ-1; Wed,
 11 Dec 2024 04:00:35 -0500
X-MC-Unique: K5T3tAPPPGCf_VxXUFUulQ-1
X-Mimecast-MFC-AGG-ID: K5T3tAPPPGCf_VxXUFUulQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A3E919560B2; Wed, 11 Dec 2024 09:00:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9345C195608A; Wed, 11 Dec 2024 09:00:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 04/26] s390x/cpumodel: add msa10 subfunctions
Date: Wed, 11 Dec 2024 09:59:48 +0100
Message-ID: <20241211090014.619351-5-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

MSA10 introduces new AES XTS subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20241206122751.189721-2-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc |  6 ++++++
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_models.c           |  4 ++++
 target/s390x/gen-features.c         | 20 ++++++++++++++++++++
 4 files changed, 32 insertions(+)

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
2.47.1


