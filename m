Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D3ECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMFh-0000yq-Or; Tue, 05 May 2026 16:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFe-0000hW-Lw; Tue, 05 May 2026 16:20:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFb-0000Jr-BQ; Tue, 05 May 2026 16:20:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645DxNDj1011760; Tue, 5 May 2026 20:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MEYpTY
 7jWNlc+J0rTGX1o0obC6qojnLZrejtfpPutr4=; b=ANWLxErCmnFvLDTKBunFAo
 GM+bzwQJy21EDEa+I5AHHNUt+9nonzM6W735YR9IJeyPdZUoTBhRSK+ZbwFAmaoY
 kf7GzosPPMyb97L1ItQfzChytB8RuBpKARY4mAw06e2MWsWkiMIt5odHnCWfkGTr
 3OvmFDtHEetSwwrZPC+TrlG+wo1u5zYMMAF1MYfFToOKKUkzAbOGNKP+BWVxaA8J
 NW/yW2hqWaBv1e7FgfZC5RDehryr9sUOfVkywVraiEcOjcpJoShhDh7nF4+7PF1l
 HjwX7dznwgq+IvwpatTtHAOwD9J5UoDZneKf/BbDZHAJTyRjOS+j8rTKSt5QCcGw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4n72w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9Y8Z026723;
 Tue, 5 May 2026 20:19:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h38km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJnqV11469476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5645F5805C;
 Tue,  5 May 2026 20:19:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B02B458059;
 Tue,  5 May 2026 20:19:47 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:47 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 23/32] s390x: Guest support for Secure-IPL Code Loading
 Attributes Facility (SCLAF)
Date: Tue,  5 May 2026 16:18:55 -0400
Message-ID: <20260505201905.997996-24-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfX1Qxn6zpjXMU/
 zB+Pm71djfrfWhMn5r9nsfgOXonNhJ6rBMRtaZ4CbSleVi0Z3TaLrCmiF6vKzohbIqbYyXy8RcF
 7Ezb8e/tCAlTSMlenZlr2OYLC3ChRqWofny35RuYgkzNMjyHVrqmzlO0zPsEJYh7Lgcig1uFZqT
 Cfku+1ZQirwnUm/1XLpPe4+FqsfpY8iYrRtPM6RI3EC7GqyXoTxWIvOdMzwGd3XSlpjN7W8NAmM
 sekts+fHMgZdTHLW8xZldSX0gZYVhFxvKAci74INcMpgbUbHyTJYA+f/QSCbdrpi2gsBS/DFyWB
 zcNjs+l/WG6PiiAwC5MLJm9xj8Q4TG00EKkWKk0o8LRF20YK46faoyX33vXCwMk5F5FhDn0FTIX
 P0Xy2V9XFmCRyjVtcoldgHqeuYN16ovj5lcrXLb80W8qOqvUpmEnoW8N3rZHK7ydxwrJRVZd/eQ
 b4lCKsTo2vlrIGbLl/w==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa50e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=s2GHSiDfQs-ooOV4uGMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rqCorioFzfWSuTLsmZgm9uGyP9cRHhzY
X-Proofpoint-ORIG-GUID: rqCorioFzfWSuTLsmZgm9uGyP9cRHhzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The secure-IPL-code-loading-attributes facility (SCLAF)
provides additional security during secure IPL.

Availability of SCLAF is determined by byte 136 bit 3 of the
SCLP Read Info block.

This feature is available starting with the gen16 CPU model.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst     | 18 ++++++++++++++++++
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_features_def.h.inc |  1 +
 target/s390x/cpu_models.c           |  3 +++
 target/s390x/gen-features.c         |  2 ++
 target/s390x/kvm/kvm.c              |  1 +
 6 files changed, 27 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index c858d5b74b..5fc15be99c 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -118,3 +118,21 @@ The guest kernel uses the contents in the IIRB for:
 * Boot logging: reports which components were loaded and verified.
 * kexec operations: builds the next kernel’s IPL report from the existing one.
 * Keying: installs IPL certificates into the platform trusted keyring.
+
+Secure Code Loading Attributes Facility
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The Secure Code Loading Attributes Facility (SCLAF) enhances system security
+during the IPL by enforcing additional verification rules.
+
+When SCLAF is available, its behavior depends on the IPL mode. It introduces
+verification of both signed and unsigned components to help ensure that only
+authorized code is loaded during the IPL process. Any errors detected by SCLAF
+are reported in the IIRB.
+
+Unsigned components are restricted to load addresses at or above absolute
+storage address ``0x2000``.
+
+Signed components must include a Secure Code Loading Attribute Block (SCLAB),
+which is appended at the very end of the component. The SCLAB defines security
+attributes for handling the signed code.
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
index bcf8a666e4..f6ba9e87e1 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -142,6 +142,7 @@ DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Certificate Store functions")
 
 /* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
 DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
+DEF_FEAT(SCLAF, "sclaf", SCLP_FAC_IPL, 3, "Secure-IPL-code-loading-attributes facility")
 
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index a52e34aa95..7de727a256 100644
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
index e76ff37cc3..5417eb9b09 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2494,6 +2494,7 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 
     /* Some Secure IPL facilities are emulated by QEMU */
     set_bit(S390_FEAT_SIPL, model->features);
+    set_bit(S390_FEAT_SCLAF, model->features);
 
     /* Test for Ultravisor features that influence secure guest behavior */
     query_uv_feat_guest(model->features);
-- 
2.54.0


