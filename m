Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBC4C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3Oi-0004rK-W6; Thu, 20 Aug 2026 10:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3OV-0004Ty-7e; Thu, 20 Aug 2026 10:05:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wx3OS-0006WV-6v; Thu, 20 Aug 2026 10:05:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K9516N424679; Thu, 20 Aug 2026 14:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ui2zDkvCXf3fTTs6f
 6SI8/LDuQgYmB88oyFdlYO4vTQ=; b=sibD79uE3UCYeFRgLNMzeV+0rns2Elw2I
 YzgL1QaJ64OHbTUmwPMC1lx9NjGKuTPA7Vrs3sPfIFm3eWiQr9NWo9MWNiv/PXVx
 ZlVO9MiFcuxVyyV3v51wUfr34yM50dDVvqdLpVbfWAmft5qa6WF86e+KSKi7usbc
 qrkjeCx0n4THRZdNJkW36hwy96i8fvoLaWzJmQyarcK2uidkHikZd5IrRhRVPmVB
 lqp/sQC+lsMgEtcFW4+ndW+R6ndI8gy2mVU2gbeR/lghYouGcILqF+SNVx41bcqP
 k3it/uuRlGk++HrWhfAMIFN/VdjLP9PWyGLQ07iaZkzH4AkpfT4zQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1jrg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KDuJCX021603;
 Thu, 20 Aug 2026 14:05:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhewks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 14:05:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KE57qm37814712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 14:05:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61E0320043;
 Thu, 20 Aug 2026 14:05:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCBB720040;
 Thu, 20 Aug 2026 14:04:56 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.17.115]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 14:04:56 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 15/29] target/ppc: move various conditional branch insns to
 decodetree
Date: Thu, 20 Aug 2026 19:30:44 +0530
Message-ID: <20260820140114.327023-16-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820140114.327023-1-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a87099d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=CKxRzG1O2kzciCs865QA:9
X-Proofpoint-GUID: 4cwtlBJDRWUeEaYAOFrgDnHjKEumDg5y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX004i3roC3t0n
 Wr1LZmp63jruPH4RZva5dSGo9H4yQc5RcYQLvcaSxLlkQ2/7eWcSYAKJbQtUyNiKN7K/EjAIlZ4
 AwCJWRrpdM7hFEezICyth80G6X0cOqo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwNSBTYWx0ZWRfX/pguQSSlZHFu
 sH6p3lKHUPI3yW8zRQ7X57Hzsv2yURxoJ5Qo2sR+35oC6S/RElLOTnk9og/Y9cW5G5/MB74wzCn
 wxoMhqLqAjDDom73Tn5qmVFVkWCb4bOwAqR9WNF6c07YVMtHjyCCHvHlXpyZYUsIEL3PYfHpsGu
 FmBHW8CLgIeI8l1U67F8u/I17m0VT9oivu1b43xB8jPYySNeuXh29huxhoT5yYx2mAFMIkUySkN
 xirwwDQslUg/ERgQuCW1x7aOCNHBzQ5sxiQIBLtkxcmCOpqi18vyXV+HMnzFWnRT4H1VUHd6WUp
 p5DzSJ6fFoxbDY/w+CFdLiYEHFoQeAe/X2+BIx5qfLlnIxxn/FKLsGyc5Ey2w6a8nczBseafNqN
 CRAdC8KtAQkXcpJCPzrvx7jIUW0WQwqmlbkXao2Mx5+p+PLE0tER0M9s+4F5vF8UqJyxD855XxG
 o6Vzzufw2bAWUfoBBPQ==
X-Proofpoint-ORIG-GUID: 7mxk0kHaN1c1UzlD_2XrKsV6FI1tWa9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200105
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

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Convert the following instructions to decodetree specification:

bc
bca
bcl
bcla

bclr
bclrl

bcctr
bcctrl

bctar
bctarl

The branch was tested by comparing the qemu -D log -d op,in_asm output for
each instruction and also for the various combinations of branch option
(BO) bits for the conditional branch instructions. Additionally, gdb
was used to confirm the LR and other register's behavior is consistent
to legacy behavior.

Further, the changes also pass a boot test into Fedora distro.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode               |  13 ++
 target/ppc/translate.c                 | 148 -----------------------
 target/ppc/translate/branch-impl.c.inc | 157 +++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 148 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 6a3254aaf6..67fb181542 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1495,6 +1495,19 @@ CLRBHRB         011111 ----- ----- ----- 0110101110 -
 
 B               010010 ........................ . .  @I_b
 
+%bd             2:14 !function=times_4
+&bcond          bo:uint32_t bi bd aa:bool lk:bool
+@B_bcond        ...... bo:5 bi:5 .............. aa:1 lk:1 &bcond bd=%bd
+
+BC              010000 ..... ..... .............. . .  @B_bcond
+
+&bclr          bo bi bh lk:bool
+@XL_bclr       ...... bo:5 bi:5 --- bh:2 .......... lk:1 &bclr
+
+BCLR            010011 ..... ..... ---.. 0000010000 . @XL_bclr
+BCCTR           010011 ..... ..... ---.. 1000010000 . @XL_bclr
+BCTAR           010011 ..... ..... ---.. 1000110000 . @XL_bclr
+
 ## Misc POWER instructions
 
 ATTN            000000 00000 00000 00000 0100000000 0
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b528cab17d..7100787a25 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3089,150 +3089,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_lr, nip);
 }
 
-#define BCOND_IM  0
-#define BCOND_LR  1
-#define BCOND_CTR 2
-#define BCOND_TAR 3
-
-static void gen_bcond(DisasContext *ctx, int type)
-{
-    uint32_t bo = BO(ctx->opcode);
-    TCGLabel *l1;
-    TCGv target;
-    target_long bhrb_type = BHRB_TYPE_OTHER;
-
-    if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
-        target = tcg_temp_new();
-        if (type == BCOND_CTR) {
-            tcg_gen_mov_tl(target, cpu_ctr);
-        } else if (type == BCOND_TAR) {
-            gen_load_spr(target, SPR_TAR);
-        } else {
-            tcg_gen_mov_tl(target, cpu_lr);
-        }
-        if (!LK(ctx->opcode)) {
-            bhrb_type |= BHRB_TYPE_INDIRECT;
-        }
-        bhrb_type |= BHRB_TYPE_XL_FORM;
-    } else {
-        target = NULL;
-    }
-    if (LK(ctx->opcode)) {
-        gen_setlr(ctx, ctx->base.pc_next);
-        bhrb_type |= BHRB_TYPE_CALL;
-    }
-    l1 = gen_new_label();
-    if ((bo & 0x4) == 0) {
-        /* Decrement and test CTR */
-        TCGv temp = tcg_temp_new();
-
-        if (type == BCOND_CTR) {
-            /*
-             * All ISAs up to v3 describe this form of bcctr as invalid but
-             * some processors, ie. 64-bit server processors compliant with
-             * arch 2.x, do implement a "test and decrement" logic instead,
-             * as described in their respective UMs. This logic involves CTR
-             * to act as both the branch target and a counter, which makes
-             * it basically useless and thus never used in real code.
-             *
-             * This form was hence chosen to trigger extra micro-architectural
-             * side-effect on real HW needed for the Spectre v2 workaround.
-             * It is up to guests that implement such workaround, ie. linux, to
-             * use this form in a way it just triggers the side-effect without
-             * doing anything else harmful.
-             */
-            if (unlikely(!is_book3s_arch2x(ctx))) {
-                gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-                return;
-            }
-
-            if (NARROW_MODE(ctx)) {
-                tcg_gen_ext32u_tl(temp, cpu_ctr);
-            } else {
-                tcg_gen_mov_tl(temp, cpu_ctr);
-            }
-            if (bo & 0x2) {
-                tcg_gen_brcondi_tl(TCG_COND_NE, temp, 0, l1);
-            } else {
-                tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
-            }
-            tcg_gen_subi_tl(cpu_ctr, cpu_ctr, 1);
-        } else {
-            tcg_gen_subi_tl(cpu_ctr, cpu_ctr, 1);
-            if (NARROW_MODE(ctx)) {
-                tcg_gen_ext32u_tl(temp, cpu_ctr);
-            } else {
-                tcg_gen_mov_tl(temp, cpu_ctr);
-            }
-            if (bo & 0x2) {
-                tcg_gen_brcondi_tl(TCG_COND_NE, temp, 0, l1);
-            } else {
-                tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
-            }
-        }
-        bhrb_type |= BHRB_TYPE_COND;
-    }
-    if ((bo & 0x10) == 0) {
-        /* Test CR */
-        uint32_t bi = BI(ctx->opcode);
-        uint32_t mask = 0x08 >> (bi & 0x03);
-        TCGv_i32 temp = tcg_temp_new_i32();
-
-        if (bo & 0x8) {
-            tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
-            tcg_gen_brcondi_i32(TCG_COND_EQ, temp, 0, l1);
-        } else {
-            tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
-            tcg_gen_brcondi_i32(TCG_COND_NE, temp, 0, l1);
-        }
-        bhrb_type |= BHRB_TYPE_COND;
-    }
-
-    gen_update_branch_history(ctx, ctx->cia, target, bhrb_type);
-
-    if (type == BCOND_IM) {
-        target_ulong li = (target_long)((int16_t)(BD(ctx->opcode)));
-        if (likely(AA(ctx->opcode) == 0)) {
-            gen_goto_tb(ctx, 0, ctx->cia + li);
-        } else {
-            gen_goto_tb(ctx, 0, li);
-        }
-    } else {
-        if (NARROW_MODE(ctx)) {
-            tcg_gen_andi_tl(cpu_nip, target, (uint32_t)~3);
-        } else {
-            tcg_gen_andi_tl(cpu_nip, target, ~3);
-        }
-        gen_lookup_and_goto_ptr(ctx);
-    }
-    if ((bo & 0x14) != 0x14) {
-        /* fallthrough case */
-        gen_set_label(l1);
-        gen_goto_tb(ctx, 1, ctx->base.pc_next);
-    }
-    ctx->base.is_jmp = DISAS_NORETURN;
-}
-
-static void gen_bc(DisasContext *ctx)
-{
-    gen_bcond(ctx, BCOND_IM);
-}
-
-static void gen_bcctr(DisasContext *ctx)
-{
-    gen_bcond(ctx, BCOND_CTR);
-}
-
-static void gen_bclr(DisasContext *ctx)
-{
-    gen_bcond(ctx, BCOND_LR);
-}
-
-static void gen_bctar(DisasContext *ctx)
-{
-    gen_bcond(ctx, BCOND_TAR);
-}
-
 /***                      Condition register logical                       ***/
 #define GEN_CRLOGIC(name, tcg_op, opc)                                        \
 static void glue(gen_, name)(DisasContext *ctx)                               \
@@ -5343,10 +5199,6 @@ GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
-GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
-GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
-GEN_HANDLER_E(bctar, 0x13, 0x10, 0x11, 0x0000E000, PPC_NONE, PPC2_BCTAR_ISA207),
 GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index 745f71afd1..c2889c1d12 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -55,3 +55,160 @@ static bool trans_B(DisasContext *ctx, arg_I_b *a)
 
     return true;
 }
+
+#define BCOND_IM  0
+#define BCOND_LR  1
+#define BCOND_CTR 2
+#define BCOND_TAR 3
+
+static bool bcond_helper(DisasContext *ctx, int type, uint32_t bo, int bi,
+                         int bd, int bh, bool aa, bool lk)
+{
+    TCGLabel *l1;
+    TCGv target;
+    target_long bhrb_type = BHRB_TYPE_OTHER;
+
+    if (type == BCOND_IM && bh != -1) {
+        /* BCOND_IM should never use bh */
+        return false;
+    } else if (type != BCOND_IM && (bd != -1 || aa != 0)) {
+        /* Other BCOND types should never use bd or aa */
+        return false;
+    }
+
+    if (type == BCOND_LR || type == BCOND_CTR || type == BCOND_TAR) {
+        target = tcg_temp_new();
+        if (type == BCOND_CTR) {
+            tcg_gen_mov_tl(target, cpu_ctr);
+        } else if (type == BCOND_TAR) {
+            gen_load_spr(target, SPR_TAR);
+        } else {
+            tcg_gen_mov_tl(target, cpu_lr);
+        }
+        if (!lk) {
+            bhrb_type |= BHRB_TYPE_INDIRECT;
+        }
+        bhrb_type |= BHRB_TYPE_XL_FORM;
+    } else {
+        target = NULL;
+    }
+    if (lk) {
+        gen_setlr(ctx, ctx->base.pc_next);
+        bhrb_type |= BHRB_TYPE_CALL;
+    }
+    l1 = gen_new_label();
+    if ((bo & 0x4) == 0) {
+        /* Decrement and test CTR */
+        TCGv temp = tcg_temp_new();
+
+        if (type == BCOND_CTR) {
+            /*
+             * All ISAs up to v3 describe this form of bcctr as invalid but
+             * some processors, ie. 64-bit server processors compliant with
+             * arch 2.x, do implement a "test and decrement" logic instead,
+             * as described in their respective UMs. This logic involves CTR
+             * to act as both the branch target and a counter, which makes
+             * it basically useless and thus never used in real code.
+             *
+             * This form was hence chosen to trigger extra micro-architectural
+             * side-effect on real HW needed for the Spectre v2 workaround.
+             * It is up to guests that implement such workaround, ie. linux, to
+             * use this form in a way it just triggers the side-effect without
+             * doing anything else harmful.
+             */
+            if (unlikely(!is_book3s_arch2x(ctx))) {
+                gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
+                return true;
+            }
+
+            if (NARROW_MODE(ctx)) {
+                tcg_gen_ext32u_tl(temp, cpu_ctr);
+            } else {
+                tcg_gen_mov_tl(temp, cpu_ctr);
+            }
+            if (bo & 0x2) {
+                tcg_gen_brcondi_tl(TCG_COND_NE, temp, 0, l1);
+            } else {
+                tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
+            }
+            tcg_gen_subi_tl(cpu_ctr, cpu_ctr, 1);
+        } else {
+            tcg_gen_subi_tl(cpu_ctr, cpu_ctr, 1);
+            if (NARROW_MODE(ctx)) {
+                tcg_gen_ext32u_tl(temp, cpu_ctr);
+            } else {
+                tcg_gen_mov_tl(temp, cpu_ctr);
+            }
+            if (bo & 0x2) {
+                tcg_gen_brcondi_tl(TCG_COND_NE, temp, 0, l1);
+            } else {
+                tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, l1);
+            }
+        }
+        bhrb_type |= BHRB_TYPE_COND;
+    }
+    if ((bo & 0x10) == 0) {
+        /* Test CR */
+        uint32_t mask = 0x08 >> (bi & 0x03);
+        TCGv_i32 temp = tcg_temp_new_i32();
+
+        if (bo & 0x8) {
+            tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
+            tcg_gen_brcondi_i32(TCG_COND_EQ, temp, 0, l1);
+        } else {
+            tcg_gen_andi_i32(temp, cpu_crf[bi >> 2], mask);
+            tcg_gen_brcondi_i32(TCG_COND_NE, temp, 0, l1);
+        }
+        bhrb_type |= BHRB_TYPE_COND;
+    }
+
+    gen_update_branch_history(ctx, ctx->cia, target, bhrb_type);
+
+    if (type == BCOND_IM) {
+        target_ulong li = (target_long)((int16_t)(bd));
+        if (likely(aa == 0)) {
+            gen_goto_tb(ctx, 0, ctx->cia + li);
+        } else {
+            gen_goto_tb(ctx, 0, li);
+        }
+    } else {
+        if (NARROW_MODE(ctx)) {
+            tcg_gen_andi_tl(cpu_nip, target, (uint32_t)~3);
+        } else {
+            tcg_gen_andi_tl(cpu_nip, target, ~3);
+        }
+        gen_lookup_and_goto_ptr(ctx);
+    }
+    if ((bo & 0x14) != 0x14) {
+        /* fallthrough case */
+        gen_set_label(l1);
+        gen_goto_tb(ctx, 1, ctx->base.pc_next);
+    }
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    return true;
+}
+
+static bool trans_BC(DisasContext *ctx, arg_bcond *a)
+{
+    /*
+     * bh is not used for bc variants hence we pass -1
+     */
+    return bcond_helper(ctx, BCOND_IM, a->bo, a->bi, a->bd, -1, a->aa, a->lk);
+}
+
+/*
+ * This helper is shared by bclr, bcctr and bctar.
+ */
+static bool bclr_helper(DisasContext *ctx, arg_bclr *a, int type)
+{
+    /*
+     * bd and aa is not used for bc variants hence we pass -1 and 0 respectively
+     */
+    return bcond_helper(ctx, type, a->bo, a->bi, -1, a->bh, 0, a->lk);
+}
+
+TRANS(BCLR, bclr_helper, BCOND_LR)
+TRANS(BCCTR, bclr_helper, BCOND_CTR)
+TRANS_FLAGS2(BCTAR_ISA207, BCTAR, bclr_helper, BCOND_TAR)
+
-- 
2.55.0


