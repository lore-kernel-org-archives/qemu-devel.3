Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8164CAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1Tp-0005r6-9K; Wed, 17 Sep 2025 19:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Te-0005gY-JM; Wed, 17 Sep 2025 19:22:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1Tb-0002Qu-7W; Wed, 17 Sep 2025 19:22:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIW9iT024719;
 Wed, 17 Sep 2025 23:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jhcDyquXiO0bnxb3n
 ji3453q8HHLeqFiYl/YQ/I4BiU=; b=WdAYzes74Y9fv0a5/NvRF3I0hEhs5dvXF
 d8jyHc0x1FvBJxCxhk0zr4N2jkpyZRZ5nP+NHqXLkEnunK1l4j7tDcqJGrDHFV83
 Rf/UG2+GdMEV3SwupqZkeZ7uQea1TQ5nPLyWSY8gxXRLE8z7leNmGQgVWe4Eyomb
 bJ3crbCunoSM5iFxRLCQBnh8BN+E5EESu8GiyIDtrOMJNRGFtepzaCzUjpwwS6sp
 1rOTOm5TVOJDIMKgYsQ043ETkgpDm1YIGsddEwq9W96mku+Q/I5e2t6dVLTYYZcx
 FfCpePBveQwEKPoR2E8y1V5RcoAXEYPk7xPenVYtrDaCbANwB82Lg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qpf21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMU6Mw018625;
 Wed, 17 Sep 2025 23:21:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mkma7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNLpOW12124784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:21:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC3F758051;
 Wed, 17 Sep 2025 23:21:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C36725805E;
 Wed, 17 Sep 2025 23:21:50 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:21:50 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 16/28] s390x: Guest support for Secure-IPL Facility
Date: Wed, 17 Sep 2025 19:21:18 -0400
Message-ID: <20250917232131.495848-17-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TyHUXxKuDmqpvLPOGl_LBzA6XzdbwWjl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXyAEVcdCb+Lvr
 111gshduw9CiWeBVkJ/UJGmivvB6vfyLDvfICZJtO8z3DFmgL8CUq1lJ0nb9YSWh4o4StqpxCDq
 ZmPigtLh3gsmcPLADu9g7zfJOJSLtuIvGC+GViL8ZKz8OpPBIw1GirguVZ8I87T3L7fx5YKEza/
 R7qfFOO8qz2uo4yqGfj4JzWHVf4meYxasSCLfE2G2/F8FQ9tV19K7pgsiCvZd8nuSijO9uBIfv4
 1CqpNBTQO4P+LXwhHFvqulXZ3lAgYXtgQKROm2hBnf3uU3RTlk5URsy4y3UZcFkcBiC7VpO+0ve
 g8hUEIwtGcTT46j7fMwI4ryurtCfyBlSReOX7bJGgqECJDMBYiUXDuRd7iBftzl7PR0QW06Og+s
 R0WbLDTy
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cb4291 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Bichc5AjJS213ZhIJUEA:9
X-Proofpoint-GUID: TyHUXxKuDmqpvLPOGl_LBzA6XzdbwWjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
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

Introduce Secure-IPL (SIPL) facility.

Use fac_ipl to represent bytes 136 and 137 for IPL device facilities
of the SCLP Read Info block.

Availability of SIPL facility is determined by byte 136 bit 1 of the
SCLP Read Info block. Byte 136's facilities cannot be represented
without the availability of the extended-length-SCCB, so add it as a
check for consistency.

Secure IPL is not available for guests under protected virtualization.

This feature is available starting with the gen16 CPU model.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/sclp.c                     | 2 ++
 include/hw/s390x/sclp.h             | 4 +++-
 target/s390x/cpu_features.c         | 4 ++++
 target/s390x/cpu_features.h         | 1 +
 target/s390x/cpu_features_def.h.inc | 3 +++
 target/s390x/cpu_models.c           | 2 ++
 target/s390x/gen-features.c         | 2 ++
 target/s390x/kvm/kvm.c              | 3 +++
 8 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9718564fa4..69d3328a3d 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -145,6 +145,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
         s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
                             &read_info->fac134);
+        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC_IPL,
+                            read_info->fac_ipl);
     }
 
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index d32f6180e0..bfd330c340 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -136,7 +136,9 @@ typedef struct ReadInfo {
     uint32_t hmfai;
     uint8_t  _reserved7[134 - 128];     /* 128-133 */
     uint8_t  fac134;
-    uint8_t  _reserved8[144 - 135];     /* 135-143 */
+    uint8_t  _reserved8;
+    uint8_t  fac_ipl[2];                /* 136-137 */
+    uint8_t  _reserved9[144 - 137];     /* 138-143 */
     struct CPUEntry entries[];
     /*
      * When the Extended-Length SCCB (ELS) feature is enabled the
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 436471f4b4..200bd8c15b 100644
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
     default:
         return;
     }
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 5635839d03..b038198555 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -24,6 +24,7 @@ typedef enum {
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
     S390_FEAT_TYPE_SCLP_FAC134,
+    S390_FEAT_TYPE_SCLP_FAC_IPL,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 941a69e013..55eef618b8 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -140,6 +140,9 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
 DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
 DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Provide Certificate Store functions")
 
+/* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
+DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
+
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
 DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 6b8471700e..f99536ef9a 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -263,6 +263,7 @@ bool s390_has_feat(S390Feat feat)
         case S390_FEAT_SIE_CMMA:
         case S390_FEAT_SIE_PFMFI:
         case S390_FEAT_SIE_IBS:
+        case S390_FEAT_SIPL:
         case S390_FEAT_CONFIGURATION_TOPOLOGY:
             return false;
             break;
@@ -507,6 +508,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6c20c3a862..bd2060ab93 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -721,6 +721,7 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_UV_FEAT_AP,
     S390_FEAT_UV_FEAT_AP_INTR,
     S390_FEAT_CERT_STORE,
+    S390_FEAT_SIPL,
 };
 
 static uint16_t full_GEN17_GA1[] = {
@@ -922,6 +923,7 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_PRNO_TRNG,
     S390_FEAT_EXTENDED_LENGTH_SCCB,
     S390_FEAT_CERT_STORE,
+    S390_FEAT_SIPL,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index ae6cd3d506..31bd574dec 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2520,6 +2520,9 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 
     set_bit(S390_FEAT_CERT_STORE, model->features);
 
+    /* Some Secure IPL facilities are emulated by QEMU */
+    set_bit(S390_FEAT_SIPL, model->features);
+
     /* Test for Ultravisor features that influence secure guest behavior */
     query_uv_feat_guest(model->features);
 
-- 
2.50.1


