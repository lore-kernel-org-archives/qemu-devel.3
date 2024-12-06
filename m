Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A0CE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRz-00069F-Fi; Fri, 06 Dec 2024 07:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRO-0005xj-E0; Fri, 06 Dec 2024 07:28:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tJXRJ-00042X-2G; Fri, 06 Dec 2024 07:28:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B62ot9T030884;
 Fri, 6 Dec 2024 12:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pA5V7kLb2cAaJrYyH
 S+IhWvzPbap4OPrgoULzqh5lZ4=; b=FZu8z8bFWaTNuBuHL8Sdih002wooZKhVA
 vuRYCr31nhF32Nm4hgFmwzeogoGP7PqQ0ieeU1PXOJIzcPuT+OS+AIHr4bOKfGhe
 Xvo+Apj23LdsOlXhoMYtPRXd57b7zmQnjKTVPt3HSphoJvoVM8JXuoZMWWuxkhFU
 9kfgYhCxXdaFAXSHRe+ZrAANQwWIuseHtjPSUMmWOV7y1DHEQ5l9RAkq1JNEtdwS
 9ZRO736mzxWWVwpe/dhH01FgdMI9uwd8HpPs2JqndK9Cb+OdD8P4PlWHs8qO6kqL
 3uTpuTa3g07697UHAObcEMRhv6Jo3yaw68w1SniXR3tbTTiEpfY1g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb807y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6BwMF9031720;
 Fri, 6 Dec 2024 12:28:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ehmake9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Dec 2024 12:28:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B6CS1hG52232618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 12:28:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E134B20043;
 Fri,  6 Dec 2024 12:28:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73EE420040;
 Fri,  6 Dec 2024 12:28:01 +0000 (GMT)
Received: from vela.ibmuc.com (unknown [9.171.26.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Dec 2024 12:28:01 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH v2 07/15] s390x/cpumodel: add Concurrent-functions
 facility support
Date: Fri,  6 Dec 2024 13:27:43 +0100
Message-ID: <20241206122751.189721-8-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zx8hauh_AV5RQe-ZJ8FS9H5gKttK-FFk
X-Proofpoint-GUID: Zx8hauh_AV5RQe-ZJ8FS9H5gKttK-FFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060089
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The Concurrent-functions facility introduces the new instruction
Perform Functions with Concurrent Results (PFCR) with few subfunctions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  8 ++++++++
 target/s390x/cpu_models.c           |  5 +++++
 target/s390x/gen-features.c         | 13 +++++++++++++
 target/s390x/kvm/kvm.c              |  6 ++++++
 6 files changed, 35 insertions(+)

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
2.43.5


