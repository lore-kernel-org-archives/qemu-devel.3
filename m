Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B496DC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Be5-0006sM-1K; Tue, 08 Apr 2025 12:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIa-0005Ta-JT; Tue, 08 Apr 2025 11:55:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIY-0005ra-Kp; Tue, 08 Apr 2025 11:55:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5386cJc4005911;
 Tue, 8 Apr 2025 15:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FJnO2dqRlCaTjkBm+
 G7APP1JvRrPE8M1ijhbxvIAyg0=; b=MkmmdviCLUKZwKMKcfxbcuE5vAwpe8mzz
 eMpjYW28SVTprEu1wmFywS3KfVyve7YsgF/AHbSNzLKMLwo8j0yV2bolvFM8jrfb
 m3X8SlZGNIRwru5kTgfLP0AGHEsQDHLF4lfgIKxD4rIdaVNorcsZdkaacHqTZ0eb
 GccFDFjLYimJWo2QizOaCMuvoH6i74zHFZDr6GHqaPddTYIgY+Z884i1d46+v/jF
 Nx2f8Jb5+kqI8wqItaYT9xz+OBhLXFKNrVaOrifldjN+kT2TqXrqjnUoJKx4Ik0n
 HJIb52f+ZuXIUNbeGkSuwN6zw53MjOpqrR9X0fEAniVZ20YWfw5aA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vjvxnbsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538CJVQs013860;
 Tue, 8 Apr 2025 15:55:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunkb9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538FtYFh25625102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E06DB5803F;
 Tue,  8 Apr 2025 15:55:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F0225804E;
 Tue,  8 Apr 2025 15:55:33 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:33 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 03/24] s390x: Guest support for Certificate Store Facility
 (CS)
Date: Tue,  8 Apr 2025 11:55:05 -0400
Message-ID: <20250408155527.123341-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xd9UICR7suTnfYsWS0c-MrD_-eN3lwTZ
X-Proofpoint-GUID: xd9UICR7suTnfYsWS0c-MrD_-eN3lwTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:33 -0400
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

DIAG 320 is supported when the certificate-store (CS) facility
is installed.

Availability of CS facility is determined by byte 134 bit 5 of the
SCLP Read Info block.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 target/s390x/cpu_features.c         | 1 +
 target/s390x/cpu_features_def.h.inc | 1 +
 target/s390x/cpu_models.c           | 2 ++
 target/s390x/gen-features.c         | 1 +
 target/s390x/kvm/kvm.c              | 2 ++
 5 files changed, 7 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 4b5be6798e..99089ab3f5 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -147,6 +147,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         break;
     case S390_FEAT_TYPE_SCLP_FAC134:
         clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
+        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_320)->bit, data);
         break;
     default:
         return;
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index e23e603a79..65d38f546d 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
 
 /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
 DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
+DEF_FEAT(DIAG_320, "diag320", SCLP_FAC134, 5, "Provide Certificate Store functions")
 
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 93a05e43d7..7d65c40bd1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -248,6 +248,7 @@ bool s390_has_feat(S390Feat feat)
     if (s390_is_pv()) {
         switch (feat) {
         case S390_FEAT_DIAG_318:
+        case S390_FEAT_DIAG_320:
         case S390_FEAT_HPMA2:
         case S390_FEAT_SIE_F2:
         case S390_FEAT_SIE_SKEY:
@@ -505,6 +506,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_DIAG_320, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 41840677ce..52c649adcd 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -696,6 +696,7 @@ static uint16_t full_GEN14_GA1[] = {
     S390_FEAT_HPMA2,
     S390_FEAT_SIE_KSS,
     S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
+    S390_FEAT_DIAG_320,
 };
 
 #define full_GEN14_GA2 EmptyFeat
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4d56e653dd..d07ca879a3 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2487,6 +2487,8 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         set_bit(S390_FEAT_DIAG_318, model->features);
     }
 
+    set_bit(S390_FEAT_DIAG_320, model->features);
+
     /* Test for Ultravisor features that influence secure guest behavior */
     query_uv_feat_guest(model->features);
 
-- 
2.49.0


