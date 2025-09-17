Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A4CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1Tn-0005pf-NJ; Wed, 17 Sep 2025 19:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Tj-0005ks-GS; Wed, 17 Sep 2025 19:22:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Tg-0002S6-HC; Wed, 17 Sep 2025 19:22:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIal30011054;
 Wed, 17 Sep 2025 23:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Zdj2u+CTiNUhvSAdK
 8jn5XBSqi+D7YQyvOPVavTWbsw=; b=oRST/oi75RZW8/nbBmqDjOgG18neTFdZo
 Eee4T5J6k9QdvwbIDnZBU7kL3kowMjowTauEHlKEpjGAGVmiPne2azC+k0r1NVOI
 fcJq4eG0HVE+eZfv/uUcO6BVuqyu56EUlV2bDn7sRXVOthh/XUNFcDmLHI6AFB+e
 wnC/GiKnOvMMkUFsz6xbrZxlh7IiYXadg2gtC/KSmxLr7kHNSSvkZRGZGaAwJ6Bt
 5JlLuoUJSashkGGtPPsE4BH/SuFp6zNAqcZvpYowiEpfLvTfLHPik7MGBzu9Nusn
 imo8muhTYXURzJWIl677qH2fd20QsaawH9zca+5NI0mqUL6+fdkww==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4neg6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HLVSMv027276;
 Wed, 17 Sep 2025 23:21:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495menbqxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNLud416122464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:21:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 783755805A;
 Wed, 17 Sep 2025 23:21:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F6CC58062;
 Wed, 17 Sep 2025 23:21:55 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:21:55 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 20/28] s390x: Guest support for Secure-IPL Code Loading
 Attributes Facility (SCLAF)
Date: Wed, 17 Sep 2025 19:21:22 -0400
Message-ID: <20250917232131.495848-21-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cb4296 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=70PmlEAx-evh_fzWiGkA:9
X-Proofpoint-GUID: CQep38XuOri7rqJ9L6FeLwabAfNQgGAd
X-Proofpoint-ORIG-GUID: CQep38XuOri7rqJ9L6FeLwabAfNQgGAd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX/giMRivrF1dr
 S7QrJxpzIkmdzTlmTIZs1NWp6P9ALP2P7Bg1RRKG6I7hLq5S+mWAEGnw5NFxugw98MokRjyi+WH
 Xm09p99BzAYBpruy9bMU0jlB9CY4IgTNvt83PBpO2oaLInAKpoiToPv1hjWZhVmw1aly3hP+DUr
 INQV7oP3AyvbRjuq3D/V2VLTnZOelddYwakbfPrIzG5qSwnEyP/DjOwGMMDBVpXubEqrocZsT2e
 cycgAEdiVW+26NiyxaroQdtf5BWTfdrzV1qf1MoNaO9UQjVw0krUnJUKzH2PeoGqIjhxbn24l8i
 pXYo+oRu7KIjeHFIw5p1RdP+36Gv5RwNGKq4tmrjTBSuC9LizLIqmz2k7mZWwgPd2cYYnWs4hH7
 xV0CdUc9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The secure-IPL-code-loading-attributes facility (SCLAF)
provides additional security during secure IPL.

Availability of SCLAF is determined by byte 136 bit 3 of the
SCLP Read Info block.

This feature is available starting with the gen16 CPU model.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst     | 25 +++++++++++++++++++++++++
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_features_def.h.inc |  1 +
 target/s390x/cpu_models.c           |  3 +++
 target/s390x/gen-features.c         |  2 ++
 target/s390x/kvm/kvm.c              |  1 +
 6 files changed, 34 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 760a066084..a19b976e25 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -85,3 +85,28 @@ operations such as:
 * certificate data
 
 The guest kernel will inspect the IIRB and build the keyring.
+
+
+Secure Code Loading Attributes Facility
+---------------------------------
+
+The Secure Code Loading Attributes Facility (SCLAF) enhances system security during the
+IPL by enforcing additional verification rules.
+
+When SCLAF is available, its behavior depends on the IPL mode. It introduces verification
+of both signed and unsigned components to help ensure that only authorized code is loaded
+during the IPL process. Any errors detected by SCLAF are reported in the IIRB.
+
+Unsigned components are restricted to load addresses at or above absolute storage address
+``0x2000``.
+
+Signed components must include a Secure Code Loading Attribute Block (SCLAB), which is
+appended at the very end of the component. The SCLAB defines security attributes for
+handling the signed code. Specifically, it may:
+
+* Provide direction on how to process the rest of the component.
+
+* Provide further validation of information on where to load the signed binary code
+  from the load device.
+
+* Specify where to start the execution of the loaded OS code.
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 200bd8c15b..29ea3bfec2 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -120,6 +120,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
      * - All SIE facilities because SIE is not available
      * - DIAG318
      * - Secure IPL Facility
+     * - Secure IPL Code Loading Attributes Facility
      *
      * As VMs can move in and out of protected mode the CPU model
      * doesn't protect us from that problem because it is only
@@ -152,6 +153,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         break;
     case S390_FEAT_TYPE_SCLP_FAC_IPL:
         clear_be_bit(s390_feat_def(S390_FEAT_SIPL)->bit, data);
+        clear_be_bit(s390_feat_def(S390_FEAT_SCLAF)->bit, data);
         break;
     default:
         return;
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 55eef618b8..ecfca0faef 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -142,6 +142,7 @@ DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Provide Certificate Store functi
 
 /* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
 DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
+DEF_FEAT(SCLAF, "sclaf", SCLP_FAC_IPL, 3, "Secure-IPL-code-loading-attributes facility")
 
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index f99536ef9a..7d214b5f72 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -264,6 +264,7 @@ bool s390_has_feat(S390Feat feat)
         case S390_FEAT_SIE_PFMFI:
         case S390_FEAT_SIE_IBS:
         case S390_FEAT_SIPL:
+        case S390_FEAT_SCLAF:
         case S390_FEAT_CONFIGURATION_TOPOLOGY:
             return false;
             break;
@@ -509,6 +510,8 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_SCLAF, S390_FEAT_SIPL },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index bd2060ab93..c3e0c6ceff 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -722,6 +722,7 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_UV_FEAT_AP_INTR,
     S390_FEAT_CERT_STORE,
     S390_FEAT_SIPL,
+    S390_FEAT_SCLAF,
 };
 
 static uint16_t full_GEN17_GA1[] = {
@@ -924,6 +925,7 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_EXTENDED_LENGTH_SCCB,
     S390_FEAT_CERT_STORE,
     S390_FEAT_SIPL,
+    S390_FEAT_SCLAF,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 31bd574dec..2ed11fab52 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2522,6 +2522,7 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 
     /* Some Secure IPL facilities are emulated by QEMU */
     set_bit(S390_FEAT_SIPL, model->features);
+    set_bit(S390_FEAT_SCLAF, model->features);
 
     /* Test for Ultravisor features that influence secure guest behavior */
     query_uv_feat_guest(model->features);
-- 
2.50.1


