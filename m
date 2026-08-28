Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA2FC61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpkt-0005bc-4S; Fri, 28 Aug 2026 02:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkr-0005XX-Sn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkp-0000qq-4a
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S23YQU680639
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3RDkPHhLW5FH+RL7l
 oKbMgF+u+v476SGSrD53E0tge4=; b=HkQJNAL2WNh+ppjlanbRfsLM/3mLq6UyU
 baKE8eKdNpa1HR+qhak668apUgzTDEqYhQ4mKlzbTnraw2x/pEoI0bBzHgNhwBDP
 n63hQ/Ss7NA3nEyYWuq7QuFii1DQ6Lbbs75QpTi7KeNpaLxY62SdCdW5AF9qtq9k
 7ZlieOXRbZwlWOV5vYiBmULv0sA6BuoVCbfvFtxz1utFtnaQktLQr8Sg+QVavE1z
 EK97V3xJfXkxf+JE0YV+xVAUVZoprVOi5iuc5KvSsPh9mJtg4YO4UcNHvKHJhqs0
 qNA1XAfFCRYgA4KA1teaigC7AN7mv91p8NYauHxXpWhcGevzWhang==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxt0jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uGaP005921
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qmv8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67npp42205490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 872282004B;
 Fri, 28 Aug 2026 06:07:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8E8B20040;
 Fri, 28 Aug 2026 06:07:46 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:46 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 09/41] target/ppc: Move vector pack instructions to decodetree
Date: Fri, 28 Aug 2026 11:36:44 +0530
Message-ID: <20260828060716.91672-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXxi5aFofSOH+Q
 p0QShXtZgEUHjkQT9Ja1bATMHuuMKROJXAtZPW5bTlj8v+0kFTXaD7XMnBLBp8fvpzNMfK5Xee9
 WGhCbvb6zR5/90BcKBYhf6GTFlDnzjc=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9125ba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Psjjt2TmAGzHRMpfQD0A:9
X-Proofpoint-ORIG-GUID: rnvVSsnRQgJFgRbjkmCT3AT7i7okMzHU
X-Proofpoint-GUID: rnvVSsnRQgJFgRbjkmCT3AT7i7okMzHU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX/wPZAfgdw5/h
 K2j7NwLmfE1jjfQOSAZzU38XyB9HIIbc2BN95aNf9Z7KikFTQ5aQzI6MRIv4kYKmsjJ0HYb1/vU
 5n92O/lOUOW3j9nCazkFCAecBpGldCa+DHHbhKIbtR+lUW6aGbQL6umhfUcni6i23tTHKxOjFA7
 S+VWG/L5TR/7K7UbjPOx85wYJA5cwTQdHX0gESafho+TtDfzzZI/kco3Zqb4enplR4tF2cahC08
 B9/RMwkOrRXamMp0vBPbgWZwqMRrwLZ6J5ahVi0k3qYpDEXcV2xkxjGp4z5Uo9mwV6+Vlwa1K1A
 HtEgadmGiEtIZP64b9tW+zSaqL2Kh2hFMFnDn/+qTMwICZgvqBSV8xUqpkRg/I6qXl6OrySek+X
 TBLY6hALt6VxDMdcVSB5cZmpkZ6IZMDQDejY7p/3CYGqqqyZWEW2f/GqaurzYxmWDdn/YPcEjf+
 hyFuef5BNUhZ8jkqSCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Aboorva Devarajan <aboorvad@linux.ibm.com>

Move below instructions to decodetree specification:

        vpkuhum, vpkuwum, vpkuhus, vpkuwus  : VX-form (PPC_ALTIVEC)
        vpkshus, vpkswus, vpkshss, vpkswss  : VX-form (PPC_ALTIVEC)
        vpkpx                                : VX-form (PPC_ALTIVEC)
        vpkudum, vpkudus, vpksdus, vpksdss  : VX-form (PPC2_ALTIVEC_207)

The legacy GEN_VXFORM_ENV/GEN_VXFORM macros that generated gen_vpk*()
functions reading register fields from ctx->opcode are replaced by new
do_vpk_env()/do_vpk() helpers in vmx-impl.c.inc that use the
pre-extracted decodetree argument fields (a->vrt, a->vra, a->vrb)
directly.  The existing gen_helper_vpk*() implementations in
int_helper.c are reused without changes.

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' option before and after the patch.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-6-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/helper.h                 | 26 +++++++--------
 target/ppc/insn32.decode            | 16 +++++++++
 target/ppc/int_helper.c             | 28 ++++++++--------
 target/ppc/translate/vmx-impl.c.inc | 51 +++++++++++++++++++++--------
 target/ppc/translate/vmx-ops.c.inc  | 13 --------
 5 files changed, 81 insertions(+), 53 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5517d2950f..a0d08d6192 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -249,19 +249,19 @@ DEF_HELPER_FLAGS_4(VMSUMUBM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VMSUMMBM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VPERM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VPERMR, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
-DEF_HELPER_4(vpkshss, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkshus, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkswss, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkswus, void, env, avr, avr, avr)
-DEF_HELPER_4(vpksdss, void, env, avr, avr, avr)
-DEF_HELPER_4(vpksdus, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkuhus, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkuwus, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkudus, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkuhum, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkuwum, void, env, avr, avr, avr)
-DEF_HELPER_4(vpkudum, void, env, avr, avr, avr)
-DEF_HELPER_FLAGS_3(vpkpx, TCG_CALL_NO_RWG, void, avr, avr, avr)
+DEF_HELPER_4(VPKSHSS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKSHUS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKSWSS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKSWUS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKSDSS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKSDUS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKUHUS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKUWUS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKUDUS, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKUHUM, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKUWUM, void, env, avr, avr, avr)
+DEF_HELPER_4(VPKUDUM, void, env, avr, avr, avr)
+DEF_HELPER_FLAGS_3(VPKPX, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_5(VMHADDSHS, void, env, avr, avr, avr, avr)
 DEF_HELPER_5(VMHRADDSHS, void, env, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_4(VMSUMUHM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 99f7421e77..d6f1875532 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1054,6 +1054,22 @@ VSTRIHR         000100 ..... 00011 ..... . 0000001101   @VX_tb_rc
 VCLRLB          000100 ..... ..... ..... 00110001101    @VX
 VCLRRB          000100 ..... ..... ..... 00111001101    @VX
 
+## Vector Pack Instructions
+
+VPKUHUM         000100 ..... ..... ..... 0000000111 0    @VX
+VPKUWUM         000100 ..... ..... ..... 0000100111 0    @VX
+VPKUDUM         000100 ..... ..... ..... 1000100111 0    @VX
+VPKUHUS         000100 ..... ..... ..... 0001000111 0    @VX
+VPKUWUS         000100 ..... ..... ..... 0001100111 0    @VX
+VPKUDUS         000100 ..... ..... ..... 1001100111 0    @VX
+VPKSHUS         000100 ..... ..... ..... 0010000111 0    @VX
+VPKSWUS         000100 ..... ..... ..... 0010100111 0    @VX
+VPKSDUS         000100 ..... ..... ..... 1010100111 0    @VX
+VPKSHSS         000100 ..... ..... ..... 0011000111 0    @VX
+VPKSWSS         000100 ..... ..... ..... 0011100111 0    @VX
+VPKSDSS         000100 ..... ..... ..... 1011100111 0    @VX
+VPKPX           000100 ..... ..... ..... 0110000111 0    @VX
+
 # VSX Load/Store Instructions
 
 LXSD            111001 ..... ..... .............. 10    @DS
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index a3adf746bd..dc55ccadf7 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1465,7 +1465,7 @@ void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #else
 #define PKBIG 0
 #endif
-void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+void helper_VPKPX(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i, j;
     ppc_avr_t result;
@@ -1488,7 +1488,7 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 }
 
 #define VPK(suffix, from, to, cvt, dosat)                               \
-    void helper_vpk##suffix(CPUPPCState *env, ppc_avr_t *r,             \
+    void helper_VPK##suffix(CPUPPCState *env, ppc_avr_t *r,             \
                             ppc_avr_t *a, ppc_avr_t *b)                 \
     {                                                                   \
         int i;                                                          \
@@ -1507,18 +1507,18 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
         }                                                               \
     }
 #define I(x, y) (x)
-VPK(shss, s16, s8, cvtshsb, 1)
-VPK(shus, s16, u8, cvtshub, 1)
-VPK(swss, s32, s16, cvtswsh, 1)
-VPK(swus, s32, u16, cvtswuh, 1)
-VPK(sdss, s64, s32, cvtsdsw, 1)
-VPK(sdus, s64, u32, cvtsduw, 1)
-VPK(uhus, u16, u8, cvtuhub, 1)
-VPK(uwus, u32, u16, cvtuwuh, 1)
-VPK(udus, u64, u32, cvtuduw, 1)
-VPK(uhum, u16, u8, I, 0)
-VPK(uwum, u32, u16, I, 0)
-VPK(udum, u64, u32, I, 0)
+VPK(SHSS, s16, s8, cvtshsb, 1)
+VPK(SHUS, s16, u8, cvtshub, 1)
+VPK(SWSS, s32, s16, cvtswsh, 1)
+VPK(SWUS, s32, u16, cvtswuh, 1)
+VPK(SDSS, s64, s32, cvtsdsw, 1)
+VPK(SDUS, s64, u32, cvtsduw, 1)
+VPK(UHUS, u16, u8, cvtuhub, 1)
+VPK(UWUS, u32, u16, cvtuwuh, 1)
+VPK(UDUS, u64, u32, cvtuduw, 1)
+VPK(UHUM, u16, u8, I, 0)
+VPK(UWUM, u32, u16, I, 0)
+VPK(UDUM, u64, u32, I, 0)
 #undef I
 #undef VPK
 #undef PKBIG
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 00b359f031..65230f3461 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -1070,19 +1070,44 @@ TRANS(VRLQMI, do_vector_rotl_quad, false, true)
 
 GEN_VXFORM_TRANS(vsl, 2, 7);
 GEN_VXFORM_TRANS(vsr, 2, 11);
-GEN_VXFORM_ENV(vpkuhum, 7, 0);
-GEN_VXFORM_ENV(vpkuwum, 7, 1);
-GEN_VXFORM_ENV(vpkudum, 7, 17);
-GEN_VXFORM_ENV(vpkuhus, 7, 2);
-GEN_VXFORM_ENV(vpkuwus, 7, 3);
-GEN_VXFORM_ENV(vpkudus, 7, 19);
-GEN_VXFORM_ENV(vpkshus, 7, 4);
-GEN_VXFORM_ENV(vpkswus, 7, 5);
-GEN_VXFORM_ENV(vpksdus, 7, 21);
-GEN_VXFORM_ENV(vpkshss, 7, 6);
-GEN_VXFORM_ENV(vpkswss, 7, 7);
-GEN_VXFORM_ENV(vpksdss, 7, 23);
-GEN_VXFORM(vpkpx, 7, 12);
+static bool do_vpk_env(DisasContext *ctx, arg_VX *a,
+                       void (*gen_helper)(TCGv_ptr, TCGv_ptr,
+                                          TCGv_ptr, TCGv_ptr))
+{
+    TCGv_ptr ra, rb, rd;
+    REQUIRE_VECTOR(ctx);
+    ra = gen_avr_ptr(a->vra);
+    rb = gen_avr_ptr(a->vrb);
+    rd = gen_avr_ptr(a->vrt);
+    gen_helper(tcg_env, rd, ra, rb);
+    return true;
+}
+
+static bool do_vpk(DisasContext *ctx, arg_VX *a,
+                   void (*gen_helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr))
+{
+    TCGv_ptr ra, rb, rd;
+    REQUIRE_VECTOR(ctx);
+    ra = gen_avr_ptr(a->vra);
+    rb = gen_avr_ptr(a->vrb);
+    rd = gen_avr_ptr(a->vrt);
+    gen_helper(rd, ra, rb);
+    return true;
+}
+
+TRANS_FLAGS(ALTIVEC, VPKUHUM, do_vpk_env, gen_helper_VPKUHUM)
+TRANS_FLAGS(ALTIVEC, VPKUWUM, do_vpk_env, gen_helper_VPKUWUM)
+TRANS_FLAGS2(ALTIVEC_207, VPKUDUM, do_vpk_env, gen_helper_VPKUDUM)
+TRANS_FLAGS(ALTIVEC, VPKUHUS, do_vpk_env, gen_helper_VPKUHUS)
+TRANS_FLAGS(ALTIVEC, VPKUWUS, do_vpk_env, gen_helper_VPKUWUS)
+TRANS_FLAGS2(ALTIVEC_207, VPKUDUS, do_vpk_env, gen_helper_VPKUDUS)
+TRANS_FLAGS(ALTIVEC, VPKSHUS, do_vpk_env, gen_helper_VPKSHUS)
+TRANS_FLAGS(ALTIVEC, VPKSWUS, do_vpk_env, gen_helper_VPKSWUS)
+TRANS_FLAGS2(ALTIVEC_207, VPKSDUS, do_vpk_env, gen_helper_VPKSDUS)
+TRANS_FLAGS(ALTIVEC, VPKSHSS, do_vpk_env, gen_helper_VPKSHSS)
+TRANS_FLAGS(ALTIVEC, VPKSWSS, do_vpk_env, gen_helper_VPKSWSS)
+TRANS_FLAGS2(ALTIVEC_207, VPKSDSS, do_vpk_env, gen_helper_VPKSDSS)
+TRANS_FLAGS(ALTIVEC, VPKPX, do_vpk, gen_helper_VPKPX)
 GEN_VXFORM_ENV(vsum4ubs, 4, 24);
 GEN_VXFORM_ENV(vsum4sbs, 4, 28);
 GEN_VXFORM_ENV(vsum4shs, 4, 25);
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index b8f77d3d2c..2820976c0f 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -59,19 +59,6 @@ GEN_VXFORM_300(bcdtrunc, 0, 20),
 GEN_VXFORM_300(bcdutrunc, 0, 21),
 GEN_VXFORM(vsl, 2, 7),
 GEN_VXFORM(vsr, 2, 11),
-GEN_VXFORM(vpkuhum, 7, 0),
-GEN_VXFORM(vpkuwum, 7, 1),
-GEN_VXFORM_207(vpkudum, 7, 17),
-GEN_VXFORM(vpkuhus, 7, 2),
-GEN_VXFORM(vpkuwus, 7, 3),
-GEN_VXFORM_207(vpkudus, 7, 19),
-GEN_VXFORM(vpkshus, 7, 4),
-GEN_VXFORM(vpkswus, 7, 5),
-GEN_VXFORM_207(vpksdus, 7, 21),
-GEN_VXFORM(vpkshss, 7, 6),
-GEN_VXFORM(vpkswss, 7, 7),
-GEN_VXFORM_207(vpksdss, 7, 23),
-GEN_VXFORM(vpkpx, 7, 12),
 GEN_VXFORM(vsum4ubs, 4, 24),
 GEN_VXFORM(vsum4sbs, 4, 28),
 GEN_VXFORM(vsum4shs, 4, 25),
-- 
2.52.0


