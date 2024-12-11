Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A949FE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbX-0006tF-6z; Wed, 11 Dec 2024 04:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIab-0005uA-6n
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaU-0007rF-M7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ojcwj2feqIZtLiS6KmK3Rba0HibaEqDkXjHGnN//D48=;
 b=jSmNsyLiHgJonraHLszea6EXNzXlMJOzOG19gkTRqmHhyyGVKJULUXC/DoILg1Gk6ADhD8
 t22eZ7cgN7xC/jmzdx0kFJu5X3AWEKAiVY0/c6rQsMK47RT5JmGrXPoktTTfLmOjSlhJOz
 HNaQDsfFcLwUXxelnliGf/+shMVX6Mo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-K_3IG4d-Pg2nU9GrKJi3Aw-1; Wed,
 11 Dec 2024 04:00:48 -0500
X-MC-Unique: K_3IG4d-Pg2nU9GrKJi3Aw-1
X-Mimecast-MFC-AGG-ID: K_3IG4d-Pg2nU9GrKJi3Aw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB6D219560AB; Wed, 11 Dec 2024 09:00:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E30C2195608A; Wed, 11 Dec 2024 09:00:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 08/26] s390x/cpumodel: Add ptff Query Time-Stamp Event (QTSE)
 support
Date: Wed, 11 Dec 2024 09:59:52 +0100
Message-ID: <20241211090014.619351-9-thuth@redhat.com>
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

Introduce a new PTFF subfunction to query-stamp events.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20241206122751.189721-6-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/cpu_features.c         | 1 +
 target/s390x/gen-features.c         | 9 +++++++++
 3 files changed, 11 insertions(+)

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
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 9ba127e386..385a2ff860 100644
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
2.47.1


