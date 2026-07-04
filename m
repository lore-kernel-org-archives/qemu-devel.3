Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E44C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 21:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg86P-0007aB-IY; Sat, 04 Jul 2026 17:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86N-0007ZU-W4; Sat, 04 Jul 2026 17:40:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wg86L-0007ta-PZ; Sat, 04 Jul 2026 17:40:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KmcCD2594454; Sat, 4 Jul 2026 21:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vEJ0cIslkhzsFangb
 jDTHF15nceQUPz871CrhYYa+t8=; b=njlQ96TJ6lXzKpyKRaO3yWrWmvHqzX3ac
 c2n2egh40GxV9s+BemaWP75ORJU484uMrnGf/YMU1hdraystRvWjde5aJcLn8Bm4
 ub9Ndj7dYYakm++SFpR7CLbRcVqZ9NwAtNoPqBChpoqp0m/vzSOQiub9A5uYdQME
 /FIq9dQm5Y1QP0pPYmVDokwPS2S/gvleMh70Cpc/m0BOpu0k+1F1gr0tqRRhZMif
 W7qKUAxLOWOgGy145fZhr37fcBK+i5fGrqfJeHvGaxcBuSMFPZq40XvfD0g/UCS/
 zBJ1TM1IMedVy4VSFjCN8ig2flbN82hTPSkf0xzVHVeIV1Orq7txA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3b92a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664LYYkY013404;
 Sat, 4 Jul 2026 21:40:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqxq8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 21:40:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664LeZKR8192754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 21:40:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C71FA58054;
 Sat,  4 Jul 2026 21:40:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D324158052;
 Sat,  4 Jul 2026 21:40:33 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.17.215])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 21:40:33 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v15 19/33] s390x: Guest support for Secure-IPL Facility
Date: Sat,  4 Jul 2026 17:39:35 -0400
Message-ID: <20260704213950.2118823-20-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704213950.2118823-1-zycai@linux.ibm.com>
References: <20260704213950.2118823-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a497dd6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Bichc5AjJS213ZhIJUEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX0q26tJAZ3j9R
 El60obEQkPQwmx43hIdeudUehIwkuITtH17+FLJ1CPaaxxBzZX1O60U9gCwLMpRk7E7WjrwpE6Y
 cwtbKpnrVvPsqMVfKn++hKSjV8z3pNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDIyNCBTYWx0ZWRfX/MxlN2FTAYan
 nrbPR45j55flrCbpLkW3BAjggppOdf/meqG8dKEroAf1k1K/Q8BPJQzH9f9vPnM+zSc2b64hMYM
 e8VlRiXAKs8qf4vjqi2pm8fGOGwFmYlmjjpQRyXlb10AVnxQx/8ryRRANt8/HNj3RLly43/S101
 9cEDGfO3OosHv4XwUbqAnMXsEIhuQVaA/6onjMOty+R+t8XDrAC2de82+wJNIxAGw3mBFUv7HMj
 hBDNk38AAT4pPfE8f7sRWQMPpyLp5oMdFpu7FC51QnssZoYxPeRzD7aIgRlV9u+MSNt6miV7bMh
 Rbz+2x2wpa6wmFbtF9Xc4T5bm2Cum0a69/cPLSmOG+4bxxSUGLqk/fxgAb9CfGnLARv8IsG084P
 9x/H5iCgCfCl8tZg9a+OqL9Cwt42sxk33mhV/9lmEUPbZA24qi4TegLgPw3Gal3s6VbX7Ao8bfj
 LW5vbhQp4OZN79B9hdQ==
X-Proofpoint-ORIG-GUID: i9eoJ6JgCZkSrlhdX4RxZ9A-LUTemG3K
X-Proofpoint-GUID: i9eoJ6JgCZkSrlhdX4RxZ9A-LUTemG3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040224
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce Secure-IPL (SIPL) facility.

Use fac_ipl to represent bytes 136 and 137 for IPL device facilities
of the SCLP Read SCP Info.

Availability of SIPL facility is determined by byte 136 bit 1 of the
SCLP Read SCP Info. Byte 136's facilities cannot be represented
without the availability of the extended-length-SCCB, so add it as a
check for consistency.

Secure IPL is not available for guests under protected virtualization.

This feature is available starting with the gen16 CPU model.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/sclp.c                     | 2 ++
 include/hw/s390x/sclp.h             | 6 ++++--
 target/s390x/cpu_features.c         | 4 ++++
 target/s390x/cpu_features.h         | 1 +
 target/s390x/cpu_features_def.h.inc | 3 +++
 target/s390x/cpu_models.c           | 2 ++
 target/s390x/gen-features.c         | 2 ++
 target/s390x/kvm/kvm.c              | 3 +++
 8 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 2d2cde7803..87371749e2 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -146,6 +146,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
         s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
                             &read_info->fac134);
+        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC_IPL,
+                            read_info->fac_ipl);
         s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC139,
                             &read_info->fac139);
     }
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index e1f9b0f6bc..dba9d8d463 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -136,9 +136,11 @@ typedef struct ReadInfo {
     uint32_t hmfai;
     uint8_t  _reserved7[134 - 128];     /* 128-133 */
     uint8_t  fac134;
-    uint8_t  _reserved8[139 - 135];     /* 135-138 */
+    uint8_t  _reserved8;
+    uint8_t  fac_ipl[2];                /* 136-137 */
+    uint8_t  _reserved9;
     uint8_t  fac139;
-    uint8_t  _reserved9[144 - 140];     /* 140-143 */
+    uint8_t  _reserved10[144 - 140];    /* 140-143 */
     struct CPUEntry entries[];
     /*
      * When the Extended-Length SCCB (ELS) feature is enabled the
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index c6cd411e04..27f38636a9 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -119,6 +119,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
      * Some facilities are not available for CPUs in protected mode:
      * - All SIE facilities because SIE is not available
      * - DIAG318
+     * - Secure IPL Facility
      *
      * As VMs can move in and out of protected mode the CPU model
      * doesn't protect us from that problem because it is only
@@ -149,6 +150,9 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
         clear_be_bit(s390_feat_def(S390_FEAT_CERT_STORE)->bit, data);
         break;
+    case S390_FEAT_TYPE_SCLP_FAC_IPL:
+        clear_be_bit(s390_feat_def(S390_FEAT_SIPL)->bit, data);
+        break;
     case S390_FEAT_TYPE_SCLP_FAC139:
         clear_be_bit(s390_feat_def(S390_FEAT_SIE_ASTFLEIE2)->bit, data);
         break;
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 52a82da751..421978faa4 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -24,6 +24,7 @@ typedef enum {
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
     S390_FEAT_TYPE_SCLP_FAC134,
+    S390_FEAT_TYPE_SCLP_FAC_IPL,
     S390_FEAT_TYPE_SCLP_FAC139,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index ae96f2381f..0153a6aa67 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -140,6 +140,9 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
 DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
 DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Certificate Store functions")
 
+/* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
+DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
+
 /* Features exposed via SCLP SCCB Facilities byte 139 (bit numbers relative to byte-139) */
 DEF_FEAT(SIE_ASTFLEIE2, "astfleie2", SCLP_FAC139, 1, "SIE: ASTFLE interpretation execution facility 2")
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 14db9c085e..b22841c2bc 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -263,6 +263,7 @@ bool s390_has_feat(S390Feat feat)
         case S390_FEAT_SIE_CMMA:
         case S390_FEAT_SIE_PFMFI:
         case S390_FEAT_SIE_IBS:
+        case S390_FEAT_SIPL:
         case S390_FEAT_CONFIGURATION_TOPOLOGY:
         case S390_FEAT_SIE_ASTFLEIE2:
             return false;
@@ -508,6 +509,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index e6a586bce7..6bf61447de 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -722,6 +722,7 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_UV_FEAT_AP_INTR,
     S390_FEAT_SIE_ASTFLEIE2,
     S390_FEAT_CERT_STORE,
+    S390_FEAT_SIPL,
 };
 
 static uint16_t full_GEN17_GA1[] = {
@@ -923,6 +924,7 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_PRNO_TRNG,
     S390_FEAT_EXTENDED_LENGTH_SCCB,
     S390_FEAT_CERT_STORE,
+    S390_FEAT_SIPL,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 42417bb1c7..fb42d8c132 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2502,6 +2502,9 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 
     set_bit(S390_FEAT_CERT_STORE, model->features);
 
+    /* Some Secure IPL facilities are emulated by QEMU */
+    set_bit(S390_FEAT_SIPL, model->features);
+
     /* Test for Ultravisor features that influence secure guest behavior */
     query_uv_feat_guest(model->features);
 
-- 
2.54.0


