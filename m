Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC05C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD8J-0000Ck-3T; Wed, 26 Aug 2026 08:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD88-0008SU-Fd; Wed, 26 Aug 2026 08:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7y-0002q1-Sy; Wed, 26 Aug 2026 08:53:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCVviu2127741; Wed, 26 Aug 2026 12:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=seEfB0
 e4OAYzI8TfBacX8QHo36myH1X0GDuBvkV8Jeo=; b=MfJXkB0jZShgi608osszeK
 ri4QQevbLnaBmLJoaO58Kupq3gFEr+XP2ToFoC5BwoU4rchmr0iJ3JmJ7u7+Ucoc
 h60KDzp+numCmozscVCxKRdvkzsXABD1F8QwRfvLaKHpz8zXdTFSpI5sYORtZ4me
 ls2KGvTyrEkhcr/CXZTXTDD6SuIjDKVmVmkvNA4UJ/qq1bfBzRABiTYNM34oIQy1
 54xpDNRNiRYd1ceEAE8cLS4CP2BM8eznqTCkbF0jkDCKXff7gVm+NyQ8XnJcH3uE
 jCJ/RN+6PdTwsWmXUO0qlTe0JsjSreAwZGaU+XD+CUb5rGMkDa72g4EQ0kGi72lA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqxma3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfHXq002980;
 Wed, 26 Aug 2026 12:52:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qa5np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqohP28115640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E95C5805B;
 Wed, 26 Aug 2026 12:52:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3CE358059;
 Wed, 26 Aug 2026 12:52:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:48 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 27/37] s390x: Guest support for Secure-IPL Code Loading
 Attributes Facility (SCLAF)
Date: Wed, 26 Aug 2026 08:52:02 -0400
Message-ID: <20260826125213.1901252-28-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Yrn8plYqk9h63meLCoX5Adg1BWMfSbP
X-Proofpoint-ORIG-GUID: 7Yrn8plYqk9h63meLCoX5Adg1BWMfSbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX6cdq8DDwHFSb
 dT+Qs/ShnS2viEjb6/oQOGb4iXrnPWtRFaqghbf++ArTfDeFhcD7cYBVBoEpmA7ZP2XsGAwmAoF
 /d4NIl8o3qLZh6/7lIUNp3UiwoZESpCHiHAWTH8s/P38AW60m73DnXOpRR6CopIt8o+UGHtW5zr
 XtMRAlwyipa+4kn2io7mOXKUSebl6oOJETwmLg3GYhsGwJPnt5ZUs/bHT6NMOwuXnwW8xdVc1IT
 nozn2GNrdFxRTOGpfGpMXgXKvaYMApInPTjT53U07qLJTPEfCmDPZBFX9RU8RJ5V6/mckIfromJ
 QihZK4kG1kj7r1c5AvTMhamhx0KYIRrEHwy/O3e3eipcQWFUiONH2qQLhBVa6GunKg3gJ9BWUmK
 5hJLjQOFIvkz5uQ7MMf/QYCcywVn3aGdhwND7ZWgANd1gDNXiz165NrZZ2Nt6R+lzCYzrmVKk6o
 incHcHiiBWTx+f2CNNw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8ee1a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aZI9m_ZHqXwCzBCL7hMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXyLktnaf6Xe55
 WQWdi9nsiWCmkAbqu7ra1+eLanMZxyAvP2llLHURXdxE86tGHe7Aq1zXD+3s1Z8YsidGbQ66rA5
 LvpTQ18TsP1kLgtx9qVFXdDO7Gwlxgc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

The secure-IPL-code-loading-attributes facility (SCLAF)
provides additional security during secure IPL.

Availability of SCLAF is determined by byte 136 bit 3 of the
SCLP Read SCP Info.

This feature is available starting with the gen16 CPU model.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-26-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst     | 18 ++++++++++++++++++
 target/s390x/cpu_features.c         |  2 ++
 target/s390x/cpu_features_def.h.inc |  1 +
 target/s390x/cpu_models.c           |  3 +++
 target/s390x/gen-features.c         |  2 ++
 target/s390x/kvm/kvm.c              |  1 +
 6 files changed, 27 insertions(+)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 113acbeda9..7a603eb956 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -122,3 +122,21 @@ The guest kernel uses the contents in the IIRB for:
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
index 27f38636a9..c634e74123 100644
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
     case S390_FEAT_TYPE_SCLP_FAC139:
         clear_be_bit(s390_feat_def(S390_FEAT_SIE_ASTFLEIE2)->bit, data);
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 0153a6aa67..a5aa19112a 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -142,6 +142,7 @@ DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Certificate Store functions")
 
 /* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
 DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
+DEF_FEAT(SCLAF, "sclaf", SCLP_FAC_IPL, 3, "Secure-IPL-code-loading-attributes facility")
 
 /* Features exposed via SCLP SCCB Facilities byte 139 (bit numbers relative to byte-139) */
 DEF_FEAT(SIE_ASTFLEIE2, "astfleie2", SCLP_FAC139, 1, "SIE: ASTFLE interpretation execution facility 2")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 97e77f2bfa..c41d629d68 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -264,6 +264,7 @@ bool s390_has_feat(S390Feat feat)
         case S390_FEAT_SIE_PFMFI:
         case S390_FEAT_SIE_IBS:
         case S390_FEAT_SIPL:
+        case S390_FEAT_SCLAF:
         case S390_FEAT_CONFIGURATION_TOPOLOGY:
         case S390_FEAT_SIE_ASTFLEIE2:
             return false;
@@ -510,6 +511,8 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_SCLAF, S390_FEAT_SIPL },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6bf61447de..a99a75d14e 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -723,6 +723,7 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_SIE_ASTFLEIE2,
     S390_FEAT_CERT_STORE,
     S390_FEAT_SIPL,
+    S390_FEAT_SCLAF,
 };
 
 static uint16_t full_GEN17_GA1[] = {
@@ -925,6 +926,7 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_EXTENDED_LENGTH_SCCB,
     S390_FEAT_CERT_STORE,
     S390_FEAT_SIPL,
+    S390_FEAT_SCLAF,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 70c9933d7f..b34a912714 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2504,6 +2504,7 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 
     /* Some Secure IPL facilities are emulated by QEMU */
     set_bit(S390_FEAT_SIPL, model->features);
+    set_bit(S390_FEAT_SCLAF, model->features);
 
     /* Test for Ultravisor features that influence secure guest behavior */
     query_uv_feat_guest(model->features);
-- 
2.55.0


