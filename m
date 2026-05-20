Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0C6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjTN-0008VQ-Qa; Wed, 20 May 2026 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjT4-0008Eu-NL; Wed, 20 May 2026 12:08:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjT1-0002aT-L5; Wed, 20 May 2026 12:08:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KAA8VH3417833; Wed, 20 May 2026 16:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xp18PCL0TsI5YX9I/
 aksAaMMG5W1qTNBAf+U+OaMiR4=; b=er+OAUF2loOSSaF1G2BtD78ogXrkl4GLB
 Hl0Xyoy2mQn93OmcD9cKK0IotlMsUMtEHOmGTMTuDV3pwK3GZqcW6mMsFa2wLZ5m
 unBqAmPMaKUB/63uNOnKnzKUVSCvkEfIfMQ1PFJ9EuWzoCL7aHEN5p+RIrNRA18T
 oXlZ74UG/UULFqXezAdGe+N5uOWgS7wrTxXhizad4shHY73YKLbGeMmAg6m/3CYp
 S6D0ZhI5IEnHmxcnbufsJOhpHINHiJGs47RXos+QwQLJLNSQCk0LvhP8Xqkewxry
 CALnOfzIJvNBMCIlwIP2HvRuuWGIVffd+eA2OhBLo2noROFs9NjBA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8hw6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFs4Y8007969;
 Wed, 20 May 2026 16:08:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8ad9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG8Cmi58130750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:08:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2C2720043;
 Wed, 20 May 2026 16:08:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F401E20040;
 Wed, 20 May 2026 16:08:06 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:08:06 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 04/28] target/ppc: Move vector merge instructions to
 decodetree
Date: Wed, 20 May 2026 21:37:04 +0530
Message-ID: <20260520160728.2283628-5-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX3e6yCWxB0R2R
 qwkRNI6L8fvpuouZCzK2c01xgKl9RAOe4m0hNE6JGMjbdCw5N3Av31JaIsq01Dz/vbSukjmubeM
 7wX/M+nc/a6bBK/HgLmFOGfCANUTzZgSDX05SKlY0H7AAiIKKw82MXG3FWCsqTjrHsXpPp9kS0L
 6dwwf2Bszu6vdoriNzR7LE7aYfwqNNidWx2r27waFtnHJ0lATjiCH8L9fChciUZlj67fbnwTbBj
 782ThALGZOi/Scr0W5xzCQPp/+M6EoNRn4aBYKznJ+lCBUhTx39rc+JaOTIWwGs2KDO4ggbrhFh
 1eHZp0LJ3e9WVPjuLvqTO03K0j4PESgKXHrZEDKpO/cAouhib7Y53hJaa3kcPOMFeics62AydMR
 2wgs9Cj1PplIHYt6K7jA2NCDrJnTPTvSeQVKCtznHTNbS7JZJsXhjw2IByZdxd0af9VjP/EmsPf
 BDM0yNrKBuLgU5etqfQ==
X-Proofpoint-GUID: 9TsRevkDgZ-ve1Ape0uXAM4aNLYXHYW2
X-Proofpoint-ORIG-GUID: DbU9hoQCJwkcDR9-gwBUC24l6nnTdI0x
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ddc71 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YDSVkQF2zo_WAcV0FwIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

From: Aboorva Devarajan <aboorvad@linux.ibm.com>

Move below instructions to decodetree specification:

        vmrg{hb, hh, hw, lb, lh, lw}           : VX-form

The individual gen_vmrg* functions generated by GEN_VXFORM are
replaced by a shared do_vmrg() helper dispatching to the existing
gen_helper_VMRG* TCG helpers via the TRANS_FLAGS() macro, which
also handles the ALTIVEC facility check.

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                 | 12 ++++++------
 target/ppc/insn32.decode            |  9 +++++++++
 target/ppc/int_helper.c             | 12 ++++++------
 target/ppc/translate/vmx-impl.c.inc | 25 +++++++++++++++++++------
 target/ppc/translate/vmx-ops.c.inc  |  6 ------
 5 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 37803ebb17..d23260ddd0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -174,12 +174,12 @@ DEF_HELPER_4(vcmpeqfp_dot, void, env, avr, avr, avr)
 DEF_HELPER_4(vcmpgefp_dot, void, env, avr, avr, avr)
 DEF_HELPER_4(vcmpgtfp_dot, void, env, avr, avr, avr)
 DEF_HELPER_4(vcmpbfp_dot, void, env, avr, avr, avr)
-DEF_HELPER_FLAGS_3(vmrglb, TCG_CALL_NO_RWG, void, avr, avr, avr)
-DEF_HELPER_FLAGS_3(vmrglh, TCG_CALL_NO_RWG, void, avr, avr, avr)
-DEF_HELPER_FLAGS_3(vmrglw, TCG_CALL_NO_RWG, void, avr, avr, avr)
-DEF_HELPER_FLAGS_3(vmrghb, TCG_CALL_NO_RWG, void, avr, avr, avr)
-DEF_HELPER_FLAGS_3(vmrghh, TCG_CALL_NO_RWG, void, avr, avr, avr)
-DEF_HELPER_FLAGS_3(vmrghw, TCG_CALL_NO_RWG, void, avr, avr, avr)
+DEF_HELPER_FLAGS_3(VMRGLB, TCG_CALL_NO_RWG, void, avr, avr, avr)
+DEF_HELPER_FLAGS_3(VMRGLH, TCG_CALL_NO_RWG, void, avr, avr, avr)
+DEF_HELPER_FLAGS_3(VMRGLW, TCG_CALL_NO_RWG, void, avr, avr, avr)
+DEF_HELPER_FLAGS_3(VMRGHB, TCG_CALL_NO_RWG, void, avr, avr, avr)
+DEF_HELPER_FLAGS_3(VMRGHH, TCG_CALL_NO_RWG, void, avr, avr, avr)
+DEF_HELPER_FLAGS_3(VMRGHW, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(VMULESB, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(VMULESH, TCG_CALL_NO_RWG, void, avr, avr, avr)
 DEF_HELPER_FLAGS_3(VMULESW, TCG_CALL_NO_RWG, void, avr, avr, avr)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 0fbabefba9..d9cc191de5 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -795,6 +795,15 @@ VNOR            000100 ..... ..... ..... 10100000100    @VX
 VXOR            000100 ..... ..... ..... 10011000100    @VX
 VEQV            000100 ..... ..... ..... 11010000100    @VX
 
+## Vector Merge Instructions
+
+VMRGHB          000100 ..... ..... ..... 00000001100    @VX
+VMRGHH          000100 ..... ..... ..... 00001001100    @VX
+VMRGHW          000100 ..... ..... ..... 00010001100    @VX
+VMRGLB          000100 ..... ..... ..... 00100001100    @VX
+VMRGLH          000100 ..... ..... ..... 00101001100    @VX
+VMRGLW          000100 ..... ..... ..... 00110001100    @VX
+
 ## Vector Integer Average Instructions
 
 VAVGSB          000100 ..... ..... ..... 10100000010    @VX
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ef4b2e75d6..a3adf746bd 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -950,7 +950,7 @@ void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
 }
 
 #define VMRG_DO(name, element, access, ofs)                                  \
-    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
+    void helper_V##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
     {                                                                        \
         ppc_avr_t result;                                                    \
         int i, half = ARRAY_SIZE(r->element) / 2;                            \
@@ -963,11 +963,11 @@ void helper_VMLADDUHM(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c,
     }
 
 #define VMRG(suffix, element, access)          \
-    VMRG_DO(mrgl##suffix, element, access, half)   \
-    VMRG_DO(mrgh##suffix, element, access, 0)
-VMRG(b, u8, VsrB)
-VMRG(h, u16, VsrH)
-VMRG(w, u32, VsrW)
+    VMRG_DO(MRGL##suffix, element, access, half)   \
+    VMRG_DO(MRGH##suffix, element, access, 0)
+VMRG(B, u8, VsrB)
+VMRG(H, u16, VsrH)
+VMRG(W, u32, VsrW)
 #undef VMRG_DO
 #undef VMRG
 
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 92d6e8c603..00b359f031 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -350,12 +350,25 @@ GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
 GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
 GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
 GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
-GEN_VXFORM(vmrghb, 6, 0);
-GEN_VXFORM(vmrghh, 6, 1);
-GEN_VXFORM(vmrghw, 6, 2);
-GEN_VXFORM(vmrglb, 6, 4);
-GEN_VXFORM(vmrglh, 6, 5);
-GEN_VXFORM(vmrglw, 6, 6);
+
+static bool do_vmrg(DisasContext *ctx, arg_VX *a,
+                    void (*helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr))
+{
+    TCGv_ptr ra, rb, rd;
+    REQUIRE_VECTOR(ctx);
+    ra = gen_avr_ptr(a->vra);
+    rb = gen_avr_ptr(a->vrb);
+    rd = gen_avr_ptr(a->vrt);
+    helper(rd, ra, rb);
+    return true;
+}
+
+TRANS_FLAGS(ALTIVEC, VMRGHB, do_vmrg, gen_helper_VMRGHB);
+TRANS_FLAGS(ALTIVEC, VMRGHH, do_vmrg, gen_helper_VMRGHH);
+TRANS_FLAGS(ALTIVEC, VMRGHW, do_vmrg, gen_helper_VMRGHW);
+TRANS_FLAGS(ALTIVEC, VMRGLB, do_vmrg, gen_helper_VMRGLB);
+TRANS_FLAGS(ALTIVEC, VMRGLH, do_vmrg, gen_helper_VMRGLH);
+TRANS_FLAGS(ALTIVEC, VMRGLW, do_vmrg, gen_helper_VMRGLW);
 
 static void trans_vmrgew(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index e28958a126..b8f77d3d2c 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -33,12 +33,6 @@ GEN_VXFORM_DUAL(vsubuhm, bcdsub, 0, 17, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM_DUAL(vsubuwm, bcdus, 0, 18, PPC_ALTIVEC, PPC2_ISA300),
 GEN_VXFORM_DUAL(vsubudm, bcds, 0, 19, PPC2_ALTIVEC_207, PPC2_ISA300),
 GEN_VXFORM_300(bcds, 0, 27),
-GEN_VXFORM(vmrghb, 6, 0),
-GEN_VXFORM(vmrghh, 6, 1),
-GEN_VXFORM(vmrghw, 6, 2),
-GEN_VXFORM(vmrglb, 6, 4),
-GEN_VXFORM(vmrglh, 6, 5),
-GEN_VXFORM(vmrglw, 6, 6),
 GEN_VXFORM_300(vextublx, 6, 24),
 GEN_VXFORM_300(vextuhlx, 6, 25),
 GEN_VXFORM_DUAL(vmrgow, vextuwlx, 6, 26, PPC_NONE, PPC2_ALTIVEC_207),
-- 
2.53.0


