Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C9E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbZ-00078c-2f; Wed, 11 Dec 2024 04:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIb8-0006KA-6U
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIb1-0007uN-1e
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fu/LvtdzCwT2Fu0AiZLnXbL1Bzp6sN77+N3GlzgLmF8=;
 b=V+zoD9zSHFeiPk6HH/df1sQvEM68eBANEJ4WmljqeVMisbdLbZ/ljWvixSnSq1DJ5JdWHk
 YFbrPg5JIb1DFe0a1VJPe0qgPx/zIcs59K5r/gqoKP5/24AJBRjHRfODnSG10T8l59xqI6
 Wuv44wE93vBcTi57kGA5FkXVh13KKEc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-YIFvl4R2N7yPOms6c6qXAQ-1; Wed,
 11 Dec 2024 04:01:21 -0500
X-MC-Unique: YIFvl4R2N7yPOms6c6qXAQ-1
X-Mimecast-MFC-AGG-ID: YIFvl4R2N7yPOms6c6qXAQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC6271956087; Wed, 11 Dec 2024 09:01:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 753FA1956089; Wed, 11 Dec 2024 09:01:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PULL 18/26] s390x/cpumodel: gen17 model
Date: Wed, 11 Dec 2024 10:00:02 +0100
Message-ID: <20241211090014.619351-19-thuth@redhat.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Hendrik Brueckner <brueckner@linux.ibm.com>

This commit introduces the definition of the gen17a/gen17b CPU model.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Message-ID: <20241206122751.189721-16-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.47.1


