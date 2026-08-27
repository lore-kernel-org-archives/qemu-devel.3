Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CC7C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaCK-0000Jn-2b; Thu, 27 Aug 2026 09:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCH-0000Hw-Kw; Thu, 27 Aug 2026 09:31:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaCF-0001T4-Ck; Thu, 27 Aug 2026 09:31:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVXo41126053; Thu, 27 Aug 2026 13:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jrvLLw1pCzFHGqzkF
 YMAe6Hq9LSD5PaVQW6Vy6BprS8=; b=HECCGn/pJjWlS24r6HBRhgUTmGsQijyI6
 Ij31SHEEb7NMDl/KYnTexPs5lPRmvH9TKJ+Hmf1MBUHnOw80x2s5STyMIULebvzD
 oEPmXNsjEItXedUA96WOCVWrhiflTUXuFK0mYOeeB/oKD4ws/0jej/mTub3JUrNY
 FjknxBa6HwdG16EtQLd0V/ds+04KGjucxQxgAek4A7Oin2YDynMVf4nYGzjE0rYS
 r/zKFPk+oD5/JdV/X+K6XCS3e/v85T/qgGQjrjcDOJaOv3q1nBNV2N0knZekPrCZ
 8dlp56sH5ViMuZVWKjgUkC6SYe30lg4p6bAwQmndtoFqQIdHlrMHw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er5jrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQMKM013321;
 Thu, 27 Aug 2026 13:31:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qggy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:31:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDV3h249807790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:31:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47E8420040;
 Thu, 27 Aug 2026 13:31:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55C1F20043;
 Thu, 27 Aug 2026 13:30:57 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:30:57 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 05/37] target/ppc: Move vector pack instructions to
 decodetree
Date: Thu, 27 Aug 2026 18:59:20 +0530
Message-ID: <20260827133010.278889-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: N7Ed38pvwopBFjazSMuEuJxviMRH2zu4
X-Proofpoint-ORIG-GUID: hWJWYnizOpxjAr3qdq8dDnBZy9EGnyoX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX6jDCgKH/2oAL
 4SFNpEJl+795ebb2v2uf7UvTQ5WSaDx8yGDVU8bur/gqmoJs7KT1D5hm7wkD0UoG2RSBX7SoEUq
 PjPt8KuV6kQqTuEU4KqRtXfPCODDnsc9AZpXcnfgCGTBi+VJVTv2mn9TVZK7p24RFc7tK5xSVy/
 d6hOz1tjcylEqx0TDgkK7SwyP9x/6pLu0piToOHjcclb3rbb0JNeyDh1FfRnC2dB31Ve4xqs9FH
 LxX+Qhf9SzZxdAL1wFWKcnwdhcNbBG8eKAUOhHzO0zbfJzbhJeH1qD9isOuElgv1bQZiXo0vjN4
 FWymHcBcpQruJn2WbR9Ms3oHXjrhAXcNVqVFKFvchCRxfLj97UyYXzwhB+sJ6TeQHjnSZMGMjJ0
 oHaNBzCNrfkiROh2nh3y8GPwsyG7FndhMX0RqHZTQX4QYLewW95OddtKonzXCzewp3Jp3rkkdZL
 9anqyp1JsC1ZS/VlEUg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a903c1c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=FELJdoV6w5lAa41aMJIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX84g7JxaVURG3
 zAgFSGG7PlWvPTIdoxdy5+NJHLiSUTyvIoYA7FyRpns5eCO06bb1iVlWTUJZir933WXUbOp4+oA
 vjMhQF5L/Zbsu6UoWqYwjX89rAi8aK4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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
2.55.0


