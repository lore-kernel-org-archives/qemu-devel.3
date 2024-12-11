Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD0E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbO-0006Pn-C7; Wed, 11 Dec 2024 04:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaX-0005td-OK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaM-0007qa-My
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3AnszLWQaAdYqna5Dl51it187Hg3cTqpQOvOmrgq0I=;
 b=Dgr6WYLZqpM0Mhqnq41qRCd85P3o9ggh3a3LBfDX4SN799qkJqCFE4ZaK575Ex+sx4Qzr6
 0+awMGpo1wRtLOxxDYxU3V4ANupY0fMhQEpV34r7e5DcdoJ/Cv9SMc/abhurKeE32CkKaT
 tTq8dIqgUxEIZebEuUHzKNu+7LfpErs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-7LeKgsj2OsunQ3-wXvzMIA-1; Wed,
 11 Dec 2024 04:00:41 -0500
X-MC-Unique: 7LeKgsj2OsunQ3-wXvzMIA-1
X-Mimecast-MFC-AGG-ID: 7LeKgsj2OsunQ3-wXvzMIA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 973C519560B5; Wed, 11 Dec 2024 09:00:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F7261956089; Wed, 11 Dec 2024 09:00:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 06/26] s390x/cpumodel: add msa12 changes
Date: Wed, 11 Dec 2024 09:59:50 +0100
Message-ID: <20241211090014.619351-7-thuth@redhat.com>
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

MSA12 changes the KIMD/KLMD instruction format for SHA3/SHAKE.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20241206122751.189721-4-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/cpu_features.c         | 1 +
 target/s390x/gen-features.c         | 8 ++++++++
 3 files changed, 10 insertions(+)

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
2.47.1


