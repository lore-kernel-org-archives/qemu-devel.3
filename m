Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6E8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjV6-0005vg-2g; Wed, 20 May 2026 12:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjV3-0005l5-FO; Wed, 20 May 2026 12:10:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjV1-0003OR-6a; Wed, 20 May 2026 12:10:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE1IOG3442044; Wed, 20 May 2026 16:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NxaymOXPa039Hkmom
 YBKHFY+IMU8wyTJwb6M4tLrYkw=; b=PPFysGOyuL0LU9j73UUBjPIfiodN+h16b
 zb9LPYnNQksEnT9RIcuWlr9Kc03gHGywq/lNQ6LT8UgfCCmLbFOppdQBK3x8mGS+
 tSQ2CrVqhZdsr9VnEk65i7HJsn22GN0Yd2Vksx63cFZAzD2a1iY6uDRObCR+CuY7
 LHFy2F+rHSLng9un5UO7JZGxFj5RnzYGIS7VfrVqFMhDBu+U5w6AidKeRdME3Vib
 mv9glmY8fWhp0knGzfTbLypx36DP8JhoyJ4AOX9A5sETILAHFOcKpyUI+xkWQLrk
 vcbJsy/1gJeFVxvMOSHnW4stxxSmmA+zNWFqKfTtjt9vyYijFvBwQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw9xvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:10:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFsE0e015474;
 Wed, 20 May 2026 16:10:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk83rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:10:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KGAEvp47251880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:10:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 177C020040;
 Wed, 20 May 2026 16:10:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0253D20043;
 Wed, 20 May 2026 16:10:09 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:10:08 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 24/28] target/ppc: Move rlwimi,
 rlwinm instructions to decodetree
Date: Wed, 20 May 2026 21:37:24 +0530
Message-ID: <20260520160728.2283628-25-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfXy5rgHQqvf7/s
 TiMY0gmVFmn/aA+3suMA5YmFBjoDw/DwVJpF6YrDiXiEIPNFFym+upGRjdLy3D7LHUJDV4fXSA2
 q5SEuQLFc7P3pobYOXVEyU25zY5bG1dfv+F9tWexhus0zmsFUuZ0DTflnkSGF0aSyoepVQFS51S
 +d+3AqIohAUfXhtLRcY5drMbzaMQj1uN7tvyU+DZnzbnF634vGyBRwnnjHsZ2ybkDF7ltRr5nph
 LgdNDHQjZf6IAtLCvGomA3lRCuNOpJASuz14aWFSQvlZ8TlKz/xGwfDuwONM8TD9hMx6vlEVcRK
 QSQrAwMHdn8qj87r5x8NVkiRxF5ZHRiJ6A4veyQyYDM3wkznTNpIToHHpUK2KgVF3qklg8F9ta6
 gf3Tchwy0ZI0UkrnrP6z83pJtsvPaZvCjFTaeektOh4oOC53/XeNbICZNYi1/Uli0NhXbXqy8Ae
 Wh8xRPOaciv9i0KcsUg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ddcea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=0rCImzozmzrCB6NAvZYA:9
X-Proofpoint-ORIG-GUID: FBwUXw4fpIp4gz2IEqnbjMB25CrJrnT1
X-Proofpoint-GUID: 3thiZhe9meOUe8chN4zqVFQtqu7AfPrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
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

From: Tanushree Shah <tshah@linux.ibm.com>

-Moving the following instructions to decodetree specification:
            rlwimi                           : M-form
            rlwimi.                          : M-form
            rlwinm                           : M-form
            rlwinm.                          : M-form
 The changes were verified by validating that the tcg ops generated by
 those instructions remain the same, which were captured with the
 "-d in_asm,op" flag.

 Additionally, validated using small assembly tests confirming the
 destination register is correctly updated based on rotated and masked
 source values and confirmed that the value was same before and after
 the change

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   |   6 ++
 target/ppc/translate.c                     | 106 ---------------------
 target/ppc/translate/fixedpoint-impl.c.inc |  98 +++++++++++++++++++
 3 files changed, 104 insertions(+), 106 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 56c9f2568d..bbce48bcbc 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -312,6 +312,9 @@
 
 @Z23_te_tbp     ...... ....0 te:5 ....0 rmc:2 ........ rc:1     &Z23_te_tb frt=%z23_frtp frb=%z23_frbp
 
+&M              ra rs sh mb me rc:bool
+@M              ...... rs:5 ra:5 sh:5 mb:5 me:5 rc:1 &M
+
 ### Fixed-Point Load Instructions
 
 LBZ             100010 ..... ..... ................     @D
@@ -561,6 +564,9 @@ SRADI           011111 ..... ..... ..... 110011101 . .  @XS
 
 EXTSWSLI        011111 ..... ..... ..... 110111101 . .  @XS
 
+RLWIMI          010100 ..... ..... ..... ..... ......   @M
+RLWINM          010101 ..... ..... ..... ..... ......   @M
+
 ## BCD Assist
 
 ADDG6S          011111 ..... ..... ..... - 001001010 -  @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fc107399db..89ff4cf190 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2012,110 +2012,6 @@ static void gen_pause(DisasContext *ctx)
 
 /***                             Integer rotate                            ***/
 
-/* rlwimi & rlwimi. */
-static void gen_rlwimi(DisasContext *ctx)
-{
-    TCGv t_ra = cpu_gpr[rA(ctx->opcode)];
-    TCGv t_rs = cpu_gpr[rS(ctx->opcode)];
-    uint32_t sh = SH(ctx->opcode);
-    uint32_t mb = MB(ctx->opcode);
-    uint32_t me = ME(ctx->opcode);
-
-    if (sh == (31 - me) && mb <= me) {
-        tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
-    } else {
-        target_ulong mask;
-        bool mask_in_32b = true;
-        TCGv t1;
-
-#if defined(TARGET_PPC64)
-        mb += 32;
-        me += 32;
-#endif
-        mask = MASK(mb, me);
-
-#if defined(TARGET_PPC64)
-        if (mask > 0xffffffffu) {
-            mask_in_32b = false;
-        }
-#endif
-        t1 = tcg_temp_new();
-        if (mask_in_32b) {
-            TCGv_i32 t0 = tcg_temp_new_i32();
-            tcg_gen_trunc_tl_i32(t0, t_rs);
-            tcg_gen_rotli_i32(t0, t0, sh);
-            tcg_gen_extu_i32_tl(t1, t0);
-        } else {
-#if defined(TARGET_PPC64)
-            tcg_gen_deposit_i64(t1, t_rs, t_rs, 32, 32);
-            tcg_gen_rotli_i64(t1, t1, sh);
-#else
-            g_assert_not_reached();
-#endif
-        }
-
-        tcg_gen_andi_tl(t1, t1, mask);
-        tcg_gen_andi_tl(t_ra, t_ra, ~mask);
-        tcg_gen_or_tl(t_ra, t_ra, t1);
-    }
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, t_ra);
-    }
-}
-
-/* rlwinm & rlwinm. */
-static void gen_rlwinm(DisasContext *ctx)
-{
-    TCGv t_ra = cpu_gpr[rA(ctx->opcode)];
-    TCGv t_rs = cpu_gpr[rS(ctx->opcode)];
-    int sh = SH(ctx->opcode);
-    int mb = MB(ctx->opcode);
-    int me = ME(ctx->opcode);
-    int len = me - mb + 1;
-    int rsh = (32 - sh) & 31;
-
-    if (sh != 0 && len > 0 && me == (31 - sh)) {
-        tcg_gen_deposit_z_tl(t_ra, t_rs, sh, len);
-    } else if (me == 31 && rsh + len <= 32) {
-        tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
-    } else {
-        target_ulong mask;
-        bool mask_in_32b = true;
-#if defined(TARGET_PPC64)
-        mb += 32;
-        me += 32;
-#endif
-        mask = MASK(mb, me);
-#if defined(TARGET_PPC64)
-        if (mask > 0xffffffffu) {
-            mask_in_32b = false;
-        }
-#endif
-        if (mask_in_32b) {
-            if (sh == 0) {
-                tcg_gen_andi_tl(t_ra, t_rs, mask);
-            } else {
-                TCGv_i32 t0 = tcg_temp_new_i32();
-                tcg_gen_trunc_tl_i32(t0, t_rs);
-                tcg_gen_rotli_i32(t0, t0, sh);
-                tcg_gen_andi_i32(t0, t0, mask);
-                tcg_gen_extu_i32_tl(t_ra, t0);
-            }
-        } else {
-#if defined(TARGET_PPC64)
-            tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
-            tcg_gen_rotli_i64(t_ra, t_ra, sh);
-            tcg_gen_andi_i64(t_ra, t_ra, mask);
-#else
-            g_assert_not_reached();
-#endif
-        }
-    }
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, t_ra);
-    }
-}
-
 /* rlwnm & rlwnm. */
 static void gen_rlwnm(DisasContext *ctx)
 {
@@ -4833,8 +4729,6 @@ GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
 GEN_HANDLER_E(copy, 0x1F, 0x06, 0x18, 0x03C00001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 /* handles lfdp, lxsd, lxssp */
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 76b1011fad..a75ac54191 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1874,6 +1874,104 @@ static bool trans_SRAWI(DisasContext *ctx, arg_SRAWI *a)
     return true;
 }
 
+static bool trans_RLWIMI(DisasContext *ctx, arg_RLWIMI *a)
+{
+    TCGv t_ra = cpu_gpr[a->ra];
+    TCGv t_rs = cpu_gpr[a->rs];
+
+    if (a->sh == (31 - a->me) && a->mb <= a->me) {
+        tcg_gen_deposit_tl(t_ra, t_ra, t_rs, a->sh, a->me - a->mb + 1);
+    } else {
+        target_ulong mask;
+        bool mask_in_32b = true;
+        TCGv t1;
+
+#if defined(TARGET_PPC64)
+        a->mb += 32;
+        a->me += 32;
+#endif
+        mask = MASK((uint32_t)a->mb, (uint32_t)a->me);
+
+#if defined(TARGET_PPC64)
+        if (mask > 0xffffffffu) {
+            mask_in_32b = false;
+        }
+#endif
+        t1 = tcg_temp_new();
+        if (mask_in_32b) {
+            TCGv_i32 t0 = tcg_temp_new_i32();
+            tcg_gen_trunc_tl_i32(t0, t_rs);
+            tcg_gen_rotli_i32(t0, t0, a->sh);
+            tcg_gen_extu_i32_tl(t1, t0);
+        } else {
+#if defined(TARGET_PPC64)
+            tcg_gen_deposit_i64(t1, t_rs, t_rs, 32, 32);
+            tcg_gen_rotli_i64(t1, t1, a->sh);
+#else
+            g_assert_not_reached();
+#endif
+        }
+
+        tcg_gen_andi_tl(t1, t1, mask);
+        tcg_gen_andi_tl(t_ra, t_ra, ~mask);
+        tcg_gen_or_tl(t_ra, t_ra, t1);
+    }
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, t_ra);
+    }
+    return true;
+}
+
+static bool trans_RLWINM(DisasContext *ctx, arg_RLWINM *a)
+{
+    TCGv t_ra = cpu_gpr[a->ra];
+    TCGv t_rs = cpu_gpr[a->rs];
+    int len = a->me - a->mb + 1;
+    int rsh = (32 - a->sh) & 31;
+
+    if (a->sh != 0 && len > 0 && a->me == (31 - a->sh)) {
+        tcg_gen_deposit_z_tl(t_ra, t_rs, a->sh, len);
+    } else if (a->me == 31 && rsh + len <= 32) {
+        tcg_gen_extract_tl(t_ra, t_rs, rsh, len);
+    } else {
+        target_ulong mask;
+        bool mask_in_32b = true;
+#if defined(TARGET_PPC64)
+        a->mb += 32;
+        a->me += 32;
+#endif
+        mask = MASK(a->mb, a->me);
+#if defined(TARGET_PPC64)
+        if (mask > 0xffffffffu) {
+            mask_in_32b = false;
+        }
+#endif
+        if (mask_in_32b) {
+            if (a->sh == 0) {
+                tcg_gen_andi_tl(t_ra, t_rs, mask);
+            } else {
+                TCGv_i32 t0 = tcg_temp_new_i32();
+                tcg_gen_trunc_tl_i32(t0, t_rs);
+                tcg_gen_rotli_i32(t0, t0, a->sh);
+                tcg_gen_andi_i32(t0, t0, mask);
+                tcg_gen_extu_i32_tl(t_ra, t0);
+            }
+        } else {
+#if defined(TARGET_PPC64)
+            tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
+            tcg_gen_rotli_i64(t_ra, t_ra, a->sh);
+            tcg_gen_andi_i64(t_ra, t_ra, mask);
+#else
+            g_assert_not_reached();
+#endif
+        }
+    }
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, t_ra);
+    }
+    return true;
+}
+
 static void do_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
                                      TCGv EA, int rt,
                                      TCGCond cond, int addend)
-- 
2.53.0


