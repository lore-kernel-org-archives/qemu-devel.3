Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AD3E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIcg-0000iO-Sn; Wed, 11 Dec 2024 04:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIb1-00069S-PU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIay-0007uA-OI
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cK7PW3Hf7FotHRGZ5Dj1s4FQIvoI7gd2tNBtuqZwbxM=;
 b=IeN/Z8NRLGEK6qBfsv8JgYkAXTBvPVDobCLGkB5iXZRhZpA/j41DAIhSREwKmUcUUCIA68
 UeaOCFb1f3uPA9VoFXbGaIayJZxMyaRsgFUdwP7QuRnRU5xTXU0EfG/zKUfpyOnjax5hjL
 BJ3REzbiJT8nOCsvOXWJ0R+LsPS9Tus=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-plKNXyzvPq2aVTlHAcTH2Q-1; Wed,
 11 Dec 2024 04:01:19 -0500
X-MC-Unique: plKNXyzvPq2aVTlHAcTH2Q-1
X-Mimecast-MFC-AGG-ID: plKNXyzvPq2aVTlHAcTH2Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0D5519560AE; Wed, 11 Dec 2024 09:01:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE0451956089; Wed, 11 Dec 2024 09:01:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 17/26] s390x/cpumodel: Add PLO-extension facility
Date: Wed, 11 Dec 2024 10:00:01 +0100
Message-ID: <20241211090014.619351-18-thuth@redhat.com>
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

The PLO-extension facility introduces numerous locking related
subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20241206122751.189721-15-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 39 +++++++++++++++++++++++++
 target/s390x/cpu_features.c         |  1 +
 target/s390x/cpu_models.c           | 38 ++++++++++++++++++++++++
 target/s390x/gen-features.c         | 45 +++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index fe7e1bd19c..e23e603a79 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -93,6 +93,7 @@ DEF_FEAT(BPB, "bpb", STFL, 82, "Branch prediction blocking")
 DEF_FEAT(MISC_INSTRUCTION_EXT4, "minste4", STFL, 84, "Miscellaneous-Instruction-Extensions Facility 4")
 DEF_FEAT(SIF, "sif", STFL, 85, "Sequential-instruction-fetching facility")
 DEF_FEAT(MSA_EXT_12, "msa12-base", STFL, 86, "Message-security-assist-extension-12 facility (excluding subfunctions)")
+DEF_FEAT(PLO_EXT, "plo-ext", STFL, 87, "PLO-extension facility")
 DEF_FEAT(VECTOR, "vx", STFL, 129, "Vector facility")
 DEF_FEAT(INSTRUCTION_EXEC_PROT, "iep", STFL, 130, "Instruction-execution-protection facility")
 DEF_FEAT(SIDE_EFFECT_ACCESS_ESOP2, "sea_esop2", STFL, 131, "Side-effect-access facility and Enhanced-suppression-on-protection facility 2")
@@ -180,6 +181,44 @@ DEF_FEAT(PLO_CSTST, "plo-cstst", PLO, 20, "PLO Compare and swap and triple store
 DEF_FEAT(PLO_CSTSTG, "plo-cststg", PLO, 21, "PLO Compare and swap and triple store (64 bit in parameter list)")
 DEF_FEAT(PLO_CSTSTGR, "plo-cststgr", PLO, 22, "PLO Compare and swap and triple store (64 bit in general registers)")
 DEF_FEAT(PLO_CSTSTX, "plo-cststx", PLO, 23, "PLO Compare and swap and triple store (128 bit in parameter list)")
+DEF_FEAT(PLO_CLO, "plo-clo", PLO, 24, "PLO Compare and load (256 bit in parameter list)")
+DEF_FEAT(PLO_CSO, "plo-cso", PLO, 25, "PLO Compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_DCSO, "plo-dcso", PLO, 26, "PLO Double compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_CSSTO, "plo-cssto", PLO, 27, "PLO Compare and swap and store (256 bit in parameter list)")
+DEF_FEAT(PLO_CSDSTO, "plo-csdsto", PLO, 28, "PLO Compare and swap and double store (256 bit in parameter list)")
+DEF_FEAT(PLO_CSTSTO, "plo-cststo", PLO, 29, "PLO Compare and swap and trible store (256 bit in parameter list)")
+DEF_FEAT(PLO_TCS, "plo-tcs", PLO, 30, "Triple compare and swap (32 bit in parameter list)")
+DEF_FEAT(PLO_TCSG, "plo-tcsg", PLO, 31, "Triple compare and swap (64 bit in parameter list)")
+DEF_FEAT(PLO_TCSX, "plo-tcsx", PLO, 32, "Triple compare and swap (128 bit in parameter list)")
+DEF_FEAT(PLO_TCSO, "plo-tcso", PLO, 33, "Triple compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_QCS, "plo-qcs", PLO, 34, "Quadruple compare and swap (32 bit in parameter list)")
+DEF_FEAT(PLO_QCSG, "plo-qcsg", PLO, 35, "Quadruple compare and swap (64 bit in parameter list)")
+DEF_FEAT(PLO_QCSX, "plo-qcsx", PLO, 36, "Quadruple compare and swap (128 bit in parameter list)")
+DEF_FEAT(PLO_QCSO, "plo-qcso", PLO, 37, "Quadruple compare and swap (256 bit in parameter list)")
+DEF_FEAT(PLO_LO, "plo-lo", PLO, 38, "Load (256 bit in parameter list)")
+DEF_FEAT(PLO_DLX, "plo-dlx", PLO, 39, "Double load (128 bit in parameter list)")
+DEF_FEAT(PLO_DLO, "plo-dlo", PLO, 40, "Double load (256 bit in parameter list)")
+DEF_FEAT(PLO_TL, "plo-tl", PLO, 41, "Triple load (32 bit in parameter list)")
+DEF_FEAT(PLO_TLG, "plo-tlg", PLO, 42, "Triple load (64 bit in parameter list)")
+DEF_FEAT(PLO_TLX, "plo-tlx", PLO, 43, "Triple load (128 bit in parameter list)")
+DEF_FEAT(PLO_TLO, "plo-tlo", PLO, 44, "Triple load (256 bit in parameter list)")
+DEF_FEAT(PLO_QL, "plo-ql", PLO, 45, "Quadruple load (32 bit in parameter list)")
+DEF_FEAT(PLO_QLG, "plo-qlg", PLO, 46, "Quadruple load (64 bit in parameter list)")
+DEF_FEAT(PLO_QLX, "plo-qlx", PLO, 47, "Quadruple load (128 bit in parameter list)")
+DEF_FEAT(PLO_QLO, "plo-qlo", PLO, 48, "Quadruple load (256 bit in parameter list)")
+DEF_FEAT(PLO_STO, "plo-sto", PLO, 49, "Store (256 bit in parameter list)")
+DEF_FEAT(PLO_DST, "plo-dst", PLO, 50, "Double store (32 bit in parameter list)")
+DEF_FEAT(PLO_DSTG, "plo-dstg", PLO, 51, "Double store (64 bit in parameter list)")
+DEF_FEAT(PLO_DSTX, "plo-dstx", PLO, 52, "Double store (128 bit in parameter list)")
+DEF_FEAT(PLO_DSTO, "plo-dsto", PLO, 53, "Double store (256 bit in parameter list)")
+DEF_FEAT(PLO_TST, "plo-tst", PLO, 54, "Triple store (32 bit in parameter list)")
+DEF_FEAT(PLO_TSTG, "plo-tstg", PLO, 55, "Triple store (64 bit in parameter list)")
+DEF_FEAT(PLO_TSTX, "plo-tstx", PLO, 56, "Triple store (128 bit in parameter list)")
+DEF_FEAT(PLO_TSTO, "plo-tsto", PLO, 57, "Triple store (256 bit in parameter list)")
+DEF_FEAT(PLO_QST, "plo-qst", PLO, 58, "Quadruple store (32 bit in parameter list)")
+DEF_FEAT(PLO_QSTG, "plo-qstg", PLO, 59, "Quadruple store (64 bit in parameter list)")
+DEF_FEAT(PLO_QSTX, "plo-qstx", PLO, 60, "Quadruple store (128 bit in parameter list)")
+DEF_FEAT(PLO_QSTO, "plo-qsto", PLO, 61, "Quadruple store (256 bit in parameter list)")
 
 /* Features exposed via the PTFF instruction. */
 DEF_FEAT(PTFF_QTO, "ptff-qto", PTFF, 1, "PTFF Query TOD Offset")
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 5f8b02f12c..4b5be6798e 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -240,6 +240,7 @@ void s390_get_deprecated_features(S390FeatBitmap features)
 /* indexed by feature group number for easy lookup */
 static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("plo", PLO, "Perform-locked-operation facility"),
+    FEAT_GROUP_INIT("plo_ext", PLO_EXT, "PLO-extension facility"),
     FEAT_GROUP_INIT("tods", TOD_CLOCK_STEERING, "Tod-clock-steering facility"),
     FEAT_GROUP_INIT("gen13ptff", GEN13_PTFF, "PTFF enhancements introduced with z13"),
     FEAT_GROUP_INIT("gen17ptff", GEN17_PTFF, "PTFF enhancements introduced with gen17"),
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7fa1712d78..c169c080d1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -513,6 +513,44 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
         { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
         { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
+        { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
+        { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6d00ffcda7..680d45d303 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -46,6 +46,47 @@
     S390_FEAT_PLO_CSTSTGR, \
     S390_FEAT_PLO_CSTSTX
 
+#define S390_FEAT_GROUP_PLO_EXT \
+    S390_FEAT_PLO_EXT, \
+    S390_FEAT_PLO_CLO, \
+    S390_FEAT_PLO_CSO, \
+    S390_FEAT_PLO_DCSO, \
+    S390_FEAT_PLO_CSSTO, \
+    S390_FEAT_PLO_CSDSTO, \
+    S390_FEAT_PLO_CSTSTO, \
+    S390_FEAT_PLO_TCS, \
+    S390_FEAT_PLO_TCSG, \
+    S390_FEAT_PLO_TCSX, \
+    S390_FEAT_PLO_TCSO, \
+    S390_FEAT_PLO_QCS, \
+    S390_FEAT_PLO_QCSG, \
+    S390_FEAT_PLO_QCSX, \
+    S390_FEAT_PLO_QCSO, \
+    S390_FEAT_PLO_LO, \
+    S390_FEAT_PLO_DLX, \
+    S390_FEAT_PLO_DLO, \
+    S390_FEAT_PLO_TL, \
+    S390_FEAT_PLO_TLG, \
+    S390_FEAT_PLO_TLX, \
+    S390_FEAT_PLO_TLO, \
+    S390_FEAT_PLO_QL, \
+    S390_FEAT_PLO_QLG, \
+    S390_FEAT_PLO_QLX, \
+    S390_FEAT_PLO_QLO, \
+    S390_FEAT_PLO_STO, \
+    S390_FEAT_PLO_DST, \
+    S390_FEAT_PLO_DSTG, \
+    S390_FEAT_PLO_DSTX, \
+    S390_FEAT_PLO_DSTO, \
+    S390_FEAT_PLO_TST, \
+    S390_FEAT_PLO_TSTG, \
+    S390_FEAT_PLO_TSTX, \
+    S390_FEAT_PLO_TSTO, \
+    S390_FEAT_PLO_QST, \
+    S390_FEAT_PLO_QSTG, \
+    S390_FEAT_PLO_QSTX, \
+    S390_FEAT_PLO_QSTO
+
 #define S390_FEAT_GROUP_TOD_CLOCK_STEERING \
     S390_FEAT_TOD_CLOCK_STEERING, \
     S390_FEAT_PTFF_QTO, \
@@ -320,6 +361,9 @@
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
 };
+static uint16_t group_PLO_EXT[] = {
+    S390_FEAT_GROUP_PLO_EXT,
+};
 static uint16_t group_TOD_CLOCK_STEERING[] = {
     S390_FEAT_GROUP_TOD_CLOCK_STEERING,
 };
@@ -936,6 +980,7 @@ typedef struct {
  *******************************/
 static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(PLO),
+    FEAT_GROUP_INITIALIZER(PLO_EXT),
     FEAT_GROUP_INITIALIZER(TOD_CLOCK_STEERING),
     FEAT_GROUP_INITIALIZER(GEN13_PTFF),
     FEAT_GROUP_INITIALIZER(GEN17_PTFF),
-- 
2.47.1


