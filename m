Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA663C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5v4-0000s2-21; Wed, 26 Aug 2026 01:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5v2-0000lS-8U; Wed, 26 Aug 2026 01:11:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5v0-0005O5-0d; Wed, 26 Aug 2026 01:11:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3ViJv2716420; Wed, 26 Aug 2026 05:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=g+ybDnlnjkQXL4JjR
 18zwo3Her5tre/RapNbsVGpjB0=; b=NJhBkCCyEjJzFPXS5BwEjlebhrqbfJRWj
 ja0nPy4BELBmKGeBgJmI4fm5Mew6UrHglfhM5J6oaXy6yHEkTHQfwUn8J3hnFwlh
 Yj1oBgXbLmRgjzSTj1Xr5K83Tx9GwS3Rdfo8faygx3rVqrMJS0mliZhniHX7AC53
 tTPw/VXxrT0Bkxf5qq+hSxKWcY817poNInyLIXJ72jDCbBeBQTJuvWCVieU6Y949
 fZpC9F8zCD6+e6Bns79WiH8CDAzCdf1nMGwZ37KosVgM+4FckUtQGysayXv4dxuU
 fDoCbPdqFIp2d4greXuPCqGmXOjqEs6GHVhaZKkYdptMEK/Na+krA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hvrn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5BI4D009731;
 Wed, 26 Aug 2026 05:11:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy7xre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5BFaT41681272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5311520040;
 Wed, 26 Aug 2026 05:11:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D03720043;
 Wed, 26 Aug 2026 05:11:10 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:11:09 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 15/37] target/ppc: move various conditional branch insns to
 decodetree
Date: Wed, 26 Aug 2026 10:38:41 +0530
Message-ID: <20260826050923.74756-16-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX2fd+pab0EIQl
 jF6D1hk5egtd+oJ4t7pUFadLdiG2nQwtWt1rmZY004wzJt0J3YYGpRvFQf9YZSpQa7Lym7Gl6uF
 HrDoKl+rpvDzabpjuUNkQOfFSKii6rQ=
X-Proofpoint-GUID: VqoeToUUKFqQO6G3qF8tQoJApqxDtaHV
X-Proofpoint-ORIG-GUID: l-SIM0AdwhMWfCYQ4_b21Li6HGr6rE38
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX8lBxj3XOXDeH
 yUCOVGxSVlMukqVDoChfqX6Dz+e14yI8cjFV8Tf1Axc/ziIVuRS/z9zeUjapqFP3hiL4KKnNww8
 FHfydjep25f0fqRU4XDsSnslussNUkXMCWHG72d5jieTj6mHu7p9HQZbzd06usRQZhFubN2+LKH
 qJcJdfllR7SKLepahSxqw7iF42JpAMLIPqgDMLmd03x8xltbcN4RADw6iGUGK4OoN9xJI5rjzCB
 5KwBh3w9xCruH1fyzdGnQadvvEsMbwD0z7ljRa5r2bgQoMliJYBjmJCuGb1oZ0oBvamEhCVmEob
 bPwMquSSq0nHdh5lQPGU0GixnIHxuf/j+TfnUXaldoaxaTf3rq7i1JK757G11qtsr6L1Rxz1ij8
 AcjfBTkdoyovL1ryQwJ9+qCRJZor+isfdXTKF+t5F0tD67oFgIG4v+GU1CPKc9y/nJ93CyP7vuR
 ZoLirNsBsLh3IAIB+EQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8e7578 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CKxRzG1O2kzciCs865QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
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


