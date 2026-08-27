Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0104C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaDu-0005vg-ET; Thu, 27 Aug 2026 09:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaDr-0005jX-PH; Thu, 27 Aug 2026 09:32:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzaDp-0001rb-2X; Thu, 27 Aug 2026 09:32:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCVcC93056420; Thu, 27 Aug 2026 13:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JSv/KLof2lIIQnJwF
 4g+usV0OXBdd9l74NUEFIWSBiU=; b=WmUNHD7/13Woq9FsFX7c9XtJq+N4meAn3
 VKlKkjG43K5aCpd9qfiwsEDgV53tjexvuTKmJJSuS7ufrcc6B9WlsZ5F+AZ340Sm
 qa8SOLq+FLcaT/sO6ldnddycwDyrye+lciiINA42DrY/hZbekXHPxbTXJmt4QsWc
 +zebJFt7M7pliMVMIrN6Ia8j4o+DDAwkOLTrlhnAnDMZ+CNfaEJmNSdRk/YSZgh/
 OYPIzkumA5d9O1SxiNpA1WfJseCZHwZp6YMZtbJMJZJxCYrIra7RhS2kBLPQR9G6
 DWr8AiPeBy4v0lsRHSgdJ/E8zAp4SPxRjy/pfpeC4Ui1q/E3EdNNg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxn9qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQJcb024836;
 Thu, 27 Aug 2026 13:32:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragr4p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 13:32:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67RDWf9N46530840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 13:32:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7021320043;
 Thu, 27 Aug 2026 13:32:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C99EE20040;
 Thu, 27 Aug 2026 13:32:35 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.12.1]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Aug 2026 13:32:35 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 20/37] target/ppc: Move Condition Register access
 instructions to decodetree.
Date: Thu, 27 Aug 2026 18:59:35 +0530
Message-ID: <20260827133010.278889-21-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827133010.278889-1-rathc@linux.ibm.com>
References: <20260827133010.278889-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX3FXr1b7yhaQd
 c62KORJ5h/OMerFmzAocdrue0bpQWNujTVrY8YhgpHj+fDM3Ys0v3Vb8I5okRDg9CLCwoKc8QDR
 HJ4DK+tMMgHW7rLbnnoTeTcr3IislgU=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a903c7f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pKujU25TKs9URF08bPwA:9
X-Proofpoint-ORIG-GUID: MGC56w7VfcVhS1JPrGsFnDHVsLYfOldo
X-Proofpoint-GUID: 7s7_F-mlDTctCYWhrDZR-gVNc5i3vtRl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXxY46Cz1zTu/e
 N8c4IS46b7OE9m/Z/j2QvX5/am+cDQ6km9Nn07JbDeGB9iLN2JDWbEIaThzMAO7DX0TbmQ+eo+Y
 bItFFdgvT2j8OXCvLxAUEQT0SzhUXvsVr/nLC3VynT2Qa0Q3+8I4/e7YYXZgRoboNfwFHHxmG51
 OuNQ87W9Kkn37LYJcXXWwg3vTasptFoL9tDUCVeXB+Xaps8iZkXbyl+Ymw6lqDmsXqYkEeQ89Vt
 D9H1QlUuCV16RD+4/GeI+ph1v1H2nFZjUh1krmFewFPdzi6vjZhzM2yY6olJbhkW7fatu7HVnOY
 ZcBzsDwKItoYFddFQTGND/YepXoOWkhxCSO6rlpNhkSOFPY/ZAS90EyzvLMUMEbRnmpVYxR7MAS
 ERlIcrg65oYwOjptgwtlUcA+EHZYe+nbiO9CRaCzwS8AQK7Q9UMiSTK4BSxmoaZsLrau00DLP3/
 SpDccgynbYxXH3qtj7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Move below instructions to decodetree specification :

        mfcr, mfocr,
        mtcrf, mtocrf                    : XFX-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   |  8 +++
 target/ppc/translate.c                     | 62 -----------------
 target/ppc/translate/fixedpoint-impl.c.inc | 78 ++++++++++++++++++++++
 3 files changed, 86 insertions(+), 62 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index b833244932..137432ed96 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -70,6 +70,9 @@
 %dx_d           6:s10 16:5 0:1
 @DX             ...... rt:5  ..... .......... ..... .           &DX d=%dx_d
 
+&XFX            rt fxm
+@XFX            ...... rt:5  . fxm:8 ...... ..... .             &XFX
+
 %md_sh          1:1 11:5
 %md_mb          5:1 6:5
 &MD             rs ra sh mb rc
@@ -648,6 +651,11 @@ FSEL            111111 ..... ..... ..... ..... 10111 .  @A
 
 ### Move To/From System Register Instructions
 
+MFCR            011111 ..... 0.... ....- 0000010011 -   @XFX
+MFOCR           011111 ..... 1.... ....- 0000010011 -   @XFX
+MTCRF           011111 ..... 0.... ....- 0010010000 -   @XFX
+MTOCRF          011111 ..... 1.... ....- 0010010000 -   @XFX
+
 SETBC           011111 ..... ..... ----- 0110000000 -   @X_bi
 SETBCR          011111 ..... ..... ----- 0110100000 -   @X_bi
 SETNBC          011111 ..... ..... ----- 0111000000 -   @X_bi
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9d9823f92d..59e8ecb262 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3131,40 +3131,6 @@ static void gen_mcrxrx(DisasContext *ctx)
 }
 #endif
 
-/* mfcr mfocrf */
-static void gen_mfcr(DisasContext *ctx)
-{
-    uint32_t crm, crn;
-
-    if (likely(ctx->opcode & 0x00100000)) {
-        crm = CRM(ctx->opcode);
-        if (likely(crm && ((crm & (crm - 1)) == 0))) {
-            crn = ctz32(crm);
-            tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], cpu_crf[7 - crn]);
-            tcg_gen_shli_tl(cpu_gpr[rD(ctx->opcode)],
-                            cpu_gpr[rD(ctx->opcode)], crn * 4);
-        }
-    } else {
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        tcg_gen_mov_i32(t0, cpu_crf[0]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[1]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[2]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[3]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[4]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[5]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[6]);
-        tcg_gen_shli_i32(t0, t0, 4);
-        tcg_gen_or_i32(t0, t0, cpu_crf[7]);
-        tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t0);
-    }
-}
-
 /* mfmsr */
 static void gen_mfmsr(DisasContext *ctx)
 {
@@ -3245,32 +3211,6 @@ static void gen_mftb(DisasContext *ctx)
     gen_op_mfspr(ctx);
 }
 
-/* mtcrf mtocrf*/
-static void gen_mtcrf(DisasContext *ctx)
-{
-    uint32_t crm, crn;
-
-    crm = CRM(ctx->opcode);
-    if (likely((ctx->opcode & 0x00100000))) {
-        if (crm && ((crm & (crm - 1)) == 0)) {
-            TCGv_i32 temp = tcg_temp_new_i32();
-            crn = ctz32(crm);
-            tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
-            tcg_gen_shri_i32(temp, temp, crn * 4);
-            tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
-        }
-    } else {
-        TCGv_i32 temp = tcg_temp_new_i32();
-        tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
-        for (crn = 0 ; crn < 8 ; crn++) {
-            if (crm & (1 << crn)) {
-                    tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
-                    tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
-            }
-        }
-    }
-}
-
 /* mtmsr */
 #if defined(TARGET_PPC64)
 static void gen_mtmsrd(DisasContext *ctx)
@@ -5030,11 +4970,9 @@ GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
 GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
-GEN_HANDLER(mfcr, 0x1F, 0x13, 0x00, 0x00000801, PPC_MISC),
 GEN_HANDLER(mfmsr, 0x1F, 0x13, 0x02, 0x001FF801, PPC_MISC),
 GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
 GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
-GEN_HANDLER(mtcrf, 0x1F, 0x10, 0x04, 0x00000801, PPC_MISC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mtmsrd, 0x1F, 0x12, 0x05, 0x001EF801, PPC_64B),
 GEN_HANDLER_E(setb, 0x1F, 0x00, 0x04, 0x0003F801, PPC_NONE, PPC2_ISA300),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index f9435f4a00..11d919a21a 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -461,6 +461,84 @@ static bool trans_ADDEX(DisasContext *ctx, arg_X *a)
     return true;
 }
 
+static bool trans_MTCRF(DisasContext *ctx, arg_MTCRF *a)
+{
+    TCGv_i32 temp;
+    uint32_t crm, crn;
+
+    crm = a->fxm;
+
+    temp = tcg_temp_new_i32();
+    tcg_gen_trunc_tl_i32(temp, cpu_gpr[a->rt]);
+
+    for (crn = 0 ; crn < 8 ; crn++) {
+        if (crm & (1 << crn)) {
+            tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
+            tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
+        }
+    }
+
+    return true;
+}
+
+static bool trans_MTOCRF(DisasContext *ctx, arg_MTOCRF *a)
+{
+    uint32_t crm, crn;
+
+    crm = a->fxm;
+
+    /* Checking crm > 0 and set_bits(crm) == 1 */
+    if (crm && ((crm & (crm - 1)) == 0)) {
+        TCGv_i32 temp = tcg_temp_new_i32();
+        crn = ctz32(crm);
+        tcg_gen_trunc_tl_i32(temp, cpu_gpr[a->rt]);
+        tcg_gen_shri_i32(temp, temp, crn * 4);
+        tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
+    }
+
+    return true;
+}
+
+static bool trans_MFOCR(DisasContext *ctx, arg_MFOCR *a)
+{
+    uint32_t crm, crn;
+
+    crm = a->fxm;
+
+    /* Checking crm > 0 and set_bits(crm) == 1 */
+    if (likely(crm && ((crm & (crm - 1)) == 0))) {
+        crn = ctz32(crm);
+        tcg_gen_extu_i32_tl(cpu_gpr[a->rt], cpu_crf[7 - crn]);
+        tcg_gen_shli_tl(cpu_gpr[a->rt],
+                        cpu_gpr[a->rt], crn * 4);
+    }
+
+    return true;
+}
+
+static bool trans_MFCR(DisasContext *ctx, arg_MFCR *a)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    tcg_gen_mov_i32(t0, cpu_crf[0]);
+    tcg_gen_shli_i32(t0, t0, 4);
+    tcg_gen_or_i32(t0, t0, cpu_crf[1]);
+    tcg_gen_shli_i32(t0, t0, 4);
+    tcg_gen_or_i32(t0, t0, cpu_crf[2]);
+    tcg_gen_shli_i32(t0, t0, 4);
+    tcg_gen_or_i32(t0, t0, cpu_crf[3]);
+    tcg_gen_shli_i32(t0, t0, 4);
+    tcg_gen_or_i32(t0, t0, cpu_crf[4]);
+    tcg_gen_shli_i32(t0, t0, 4);
+    tcg_gen_or_i32(t0, t0, cpu_crf[5]);
+    tcg_gen_shli_i32(t0, t0, 4);
+    tcg_gen_or_i32(t0, t0, cpu_crf[6]);
+    tcg_gen_shli_i32(t0, t0, 4);
+    tcg_gen_or_i32(t0, t0, cpu_crf[7]);
+    tcg_gen_extu_i32_tl(cpu_gpr[a->rt], t0);
+
+    return true;
+}
+
 static bool do_add_D(DisasContext *ctx, arg_D *a, bool add_ca, bool compute_ca,
                      bool compute_ov, bool compute_rc0)
 {
-- 
2.55.0


