Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D8E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbc-0007N5-3g; Wed, 11 Dec 2024 04:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIag-0005ue-CR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaa-0007rq-Vh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZvBfI9c0OVWSnX9OzNeRIurNUC8uM9xBkegzOk3w+Y=;
 b=ZfwEl+c2ro6HTI8YnjkDTXTTxoOGPUqnzdepZFE2TO0HVt4kHqsMwCz2Y5IQWOJE0HeHtv
 oH49kWWOgid/YGOOikpEjjEEL3DfDrBlgIO5ZM/7mmbzUTneDy14P9fdxWR8rMTx+za/N4
 AQH8AS0FdDw1nCPZZCP9y+1r0+Jbktw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-aFTqSP8-MG6zD01PDuk6OA-1; Wed,
 11 Dec 2024 04:00:55 -0500
X-MC-Unique: aFTqSP8-MG6zD01PDuk6OA-1
X-Mimecast-MFC-AGG-ID: aFTqSP8-MG6zD01PDuk6OA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DAA01955F45; Wed, 11 Dec 2024 09:00:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14BEB1956089; Wed, 11 Dec 2024 09:00:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 10/26] s390x/cpumodel: add Concurrent-functions facility support
Date: Wed, 11 Dec 2024 09:59:54 +0100
Message-ID: <20241211090014.619351-11-thuth@redhat.com>
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

The Concurrent-functions facility introduces the new instruction
Perform Functions with Concurrent Results (PFCR) with few subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20241206122751.189721-8-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  8 ++++++++
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_models.c           |  5 +++++
 target/s390x/gen-features.c         | 13 +++++++++++++
 target/s390x/kvm/kvm.c              |  6 ++++++
 6 files changed, 35 insertions(+)

diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 661a8cd6db..5635839d03 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -44,6 +44,7 @@ typedef enum {
     S390_FEAT_TYPE_SORTL,
     S390_FEAT_TYPE_DFLTCC,
     S390_FEAT_TYPE_UV_FEAT_GUEST,
+    S390_FEAT_TYPE_PFCR,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index f96cb5a7d8..09872ab3d8 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -116,6 +116,7 @@ DEF_FEAT(BEAR_ENH, "beareh", STFL, 193, "BEAR-enhancement facility")
 DEF_FEAT(RDP, "rdp", STFL, 194, "Reset-DAT-protection facility")
 DEF_FEAT(PAI, "pai", STFL, 196, "Processor-Activity-Instrumentation facility")
 DEF_FEAT(PAIE, "paie", STFL, 197, "Processor-Activity-Instrumentation extension-1")
+DEF_FEAT(CCF_BASE, "ccf-base", STFL, 201, "Concurrent-Functions facility")
 
 /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
 DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility")
@@ -413,3 +414,10 @@ DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block"
 /* Features exposed via the UV-CALL instruction */
 DEF_FEAT(UV_FEAT_AP, "appv", UV_FEAT_GUEST, 4, "AP instructions installed for secure guests")
 DEF_FEAT(UV_FEAT_AP_INTR, "appvi", UV_FEAT_GUEST, 5, "AP instructions interruption support for secure guests")
+
+/* Features exposed via the PFCR instruction (concurrent-functions facility). */
+DEF_FEAT(PFCR_QAF, "pfcr-qaf", PFCR, 0, "PFCR Query-Available-Functions")
+DEF_FEAT(PFCR_CSDST, "pfcr-csdst", PFCR, 1, "PFCR Compare-and-Swap-and-Double-Store (32)")
+DEF_FEAT(PFCR_CSDSTG, "pfcr-csdstg", PFCR, 2, "PFCR Compare-and-Swap-and-Double-Store (64)")
+DEF_FEAT(PFCR_CSTST, "pfcr-cstst", PFCR, 3, "PFCR Compare-and-Swap-and-Triple-Store (32)")
+DEF_FEAT(PFCR_CSTSTG, "pfcr-cststg", PFCR, 4, "PFCR Compare-and-Swap-and-Triple-Store (64)")
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 385a2ff860..5f8b02f12c 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -93,6 +93,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_KDSA:
     case S390_FEAT_TYPE_SORTL:
     case S390_FEAT_TYPE_DFLTCC:
+    case S390_FEAT_TYPE_PFCR:
         set_be_bit(0, data); /* query is always available */
         break;
     default:
@@ -263,6 +264,7 @@ static S390FeatGroupDef s390_feature_groups[] = {
     FEAT_GROUP_INIT("mepochptff", MULTIPLE_EPOCH_PTFF, "PTFF enhancements introduced with Multiple-epoch facility"),
     FEAT_GROUP_INIT("esort", ENH_SORT, "Enhanced-sort facility"),
     FEAT_GROUP_INIT("deflate", DEFLATE_CONVERSION, "Deflate-conversion facility"),
+    FEAT_GROUP_INIT("ccf", CONCURRENT_FUNCTIONS, "Concurrent-functions facility"),
 };
 
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index a62a3c3771..117434b9a8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -504,6 +504,11 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
         { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
+        { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
+        { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 302b653214..6d00ffcda7 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -308,6 +308,14 @@
     S390_FEAT_DEFLATE_XPND, \
     S390_FEAT_DEFLATE_F0
 
+#define S390_FEAT_GROUP_CONCURRENT_FUNCTIONS \
+    S390_FEAT_CCF_BASE, \
+    S390_FEAT_PFCR_QAF, \
+    S390_FEAT_PFCR_CSDST, \
+    S390_FEAT_PFCR_CSDSTG, \
+    S390_FEAT_PFCR_CSTST, \
+    S390_FEAT_PFCR_CSTSTG
+
 /* cpu feature groups */
 static uint16_t group_PLO[] = {
     S390_FEAT_GROUP_PLO,
@@ -398,6 +406,10 @@ static uint16_t group_DEFLATE_CONVERSION[] = {
     S390_FEAT_GROUP_DEFLATE_CONVERSION,
 };
 
+static uint16_t group_CONCURRENT_FUNCTIONS[] = {
+    S390_FEAT_GROUP_CONCURRENT_FUNCTIONS,
+};
+
 /* Base features (in order of release)
  * Only non-hypervisor managed features belong here.
  * Base feature sets are static meaning they do not change in future QEMU
@@ -948,6 +960,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MULTIPLE_EPOCH_PTFF),
     FEAT_GROUP_INITIALIZER(ENH_SORT),
     FEAT_GROUP_INITIALIZER(DEFLATE_CONVERSION),
+    FEAT_GROUP_INITIALIZER(CONCURRENT_FUNCTIONS),
 };
 
 #define QEMU_FEAT_INITIALIZER(_name)                   \
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 8ffe0159d8..dd0322c43a 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2195,6 +2195,9 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
         s390_add_from_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
     }
+    if (test_bit(S390_FEAT_CCF_BASE, features)) {
+        s390_add_from_feat_block(features, S390_FEAT_TYPE_PFCR, prop.pfcr);
+    }
     return 0;
 }
 
@@ -2248,6 +2251,9 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     if (test_bit(S390_FEAT_DEFLATE_BASE, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_DFLTCC, prop.dfltcc);
     }
+    if (test_bit(S390_FEAT_CCF_BASE, features)) {
+        s390_fill_feat_block(features, S390_FEAT_TYPE_PFCR, prop.pfcr);
+    }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
-- 
2.47.1


