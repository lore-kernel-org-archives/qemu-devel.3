Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2E3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjTo-0000aB-Om; Wed, 20 May 2026 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTM-00006M-3Q; Wed, 20 May 2026 12:08:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjTJ-0002hO-Jj; Wed, 20 May 2026 12:08:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7NK59980011; Wed, 20 May 2026 16:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=f2CUa7Cc0I0t8bRtY
 668ZJKc7TdvZm6CM8IWVYziE60=; b=qbZ9qWzevuPGdYiuhM7+uzXyf1k3Pu3Ht
 FBJntu4611rI8JKC7IRjsVn+zfE5zEOklChpkUJfGjmN2WOeUudS9uQc/QN4lfF5
 QE2l8k9BcVotcuk+d/+syLTilk9kh6u/kbbOhpA60Pufg8wk30eGU7Cz0j+BEE6o
 aAdvDYi8uon//kMws6xmtUBoykzeizUkBfyh85DGwN5Z3t+GzJhf65E3YKTTRc+x
 +USLv2g3iMkp7yonS0XX1qapX7rMnvOZISPpj7PVta3YtJjGsU0gXJZo/Fo4vW3W
 nVuY1IYgOP9EOwPWTmQ9TsgOBNnKagOUrQIMI88OHuavyw8Zo57fA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mtw9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFdHp1026172;
 Wed, 20 May 2026 16:08:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7tnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:08:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG8TOD40173826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:08:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A329B20043;
 Wed, 20 May 2026 16:08:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8762020040;
 Wed, 20 May 2026 16:08:24 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:08:24 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 07/28] target/ppc: convert slw,
 srw instruction via decode spec
Date: Wed, 20 May 2026 21:37:07 +0530
Message-ID: <20260520160728.2283628-8-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zVCfeTmvcgqaPQXhbMxwX2qtlPttB5wc
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0ddc82 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=Fp1rp7siH0uluUpQqjEA:9
X-Proofpoint-ORIG-GUID: W4XITyrq5__-MQ2AL_5p9mTrqeM6NeaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX0gqpAfj9Vwuj
 IOa9+7ZHiislDmwWsaJECMxBsApZ7PN1e/9Eb9e6IRZnkIM93OIqJp+HI3w1ScfBX0fvfyVr32e
 s2X5OlAAb90Cr449iN67ClwqkgBb6qC3YfjgEGTqKk6rZYeNn5QiMXNltuRHsdGw7YvCzBi3rKn
 uKrBZQtZQ3APHP9A4VDQ+m6x0LSkcdtUt7V/v59gxspriPZO5n8PPR6S2h34zdqENJYdu1o7rkq
 97ZYTXd0hjzgSn9nyb/sX6ARJeLrEuaiKGyju0IEx+/LkiRhi4EHJdfrDGzf+r8sNVy/Q4pFyu+
 R27OYZ4kGY8VQhA2fZLl/cLbodwgbsYgEvP+DYynBPu7mP5JXe01W/9Xgbm6NcjPU2qUJi7OSWq
 WTtYn0Pklh4tbLxnmb5fCQ47AzX1fyyOuktWir0+ZkhLQei797KEIhH8O6VG8S0EJGvdlHLd/9C
 7maut4HKOHzxNbZF6Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200156
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

From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>

Instructions converted:

- slw
- srw

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode                   |  6 +++
 target/ppc/translate.c                     | 49 ----------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 48 +++++++++++++++++++++
 3 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 1f363771ed..6c3f737657 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -505,6 +505,12 @@ HASHCHK         011111 ..... ..... ..... 1011110010 .   @X_DW
 HASHSTP         011111 ..... ..... ..... 1010010010 .   @X_DW
 HASHCHKP        011111 ..... ..... ..... 1010110010 .   @X_DW
 
+# Fixed-Point Shift Instructions
+
+SLW		011111 ..... ..... ..... 0000011000 .	@X_rc
+SRW		011111 ..... ..... ..... 1000011000 .	@X_rc
+
+
 ## BCD Assist
 
 ADDG6S          011111 ..... ..... ..... - 001001010 -  @X
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index aeecc06477..d4f85b9be5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2315,29 +2315,6 @@ GEN_PPC64_R4(rldimi, 0x1E, 0x06);
 
 /***                             Integer shift                             ***/
 
-/* slw & slw. */
-static void gen_slw(DisasContext *ctx)
-{
-    TCGv t0, t1;
-
-    t0 = tcg_temp_new();
-    /* AND rS with a mask that is 0 when rB >= 0x20 */
-#if defined(TARGET_PPC64)
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-#else
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
-    tcg_gen_sari_tl(t0, t0, 0x1f);
-#endif
-    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
-    t1 = tcg_temp_new();
-    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x1f);
-    tcg_gen_shl_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
-    tcg_gen_ext32u_tl(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
 
 /* sraw & sraw. */
 static void gen_sraw(DisasContext *ctx)
@@ -2379,30 +2356,6 @@ static void gen_srawi(DisasContext *ctx)
     }
 }
 
-/* srw & srw. */
-static void gen_srw(DisasContext *ctx)
-{
-    TCGv t0, t1;
-
-    t0 = tcg_temp_new();
-    /* AND rS with a mask that is 0 when rB >= 0x20 */
-#if defined(TARGET_PPC64)
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
-    tcg_gen_sari_tl(t0, t0, 0x3f);
-#else
-    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
-    tcg_gen_sari_tl(t0, t0, 0x1f);
-#endif
-    tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
-    tcg_gen_ext32u_tl(t0, t0);
-    t1 = tcg_temp_new();
-    tcg_gen_andi_tl(t1, cpu_gpr[rB(ctx->opcode)], 0x1f);
-    tcg_gen_shr_tl(cpu_gpr[rA(ctx->opcode)], t0, t1);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, cpu_gpr[rA(ctx->opcode)]);
-    }
-}
-
 #if defined(TARGET_PPC64)
 /* sld & sld. */
 static void gen_sld(DisasContext *ctx)
@@ -5801,10 +5754,8 @@ GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(rlwimi, 0x14, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwinm, 0x15, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(slw, 0x1F, 0x18, 0x00, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(sraw, 0x1F, 0x18, 0x18, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(srawi, 0x1F, 0x18, 0x19, 0x00000000, PPC_INTEGER),
-GEN_HANDLER(srw, 0x1F, 0x18, 0x10, 0x00000000, PPC_INTEGER),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(sld, 0x1F, 0x1B, 0x00, 0x00000000, PPC_64B),
 GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 91f9c6c391..9d04b96316 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1406,3 +1406,51 @@ TRANS(HASHST, do_hash, false, gen_helper_HASHST)
 TRANS(HASHCHK, do_hash, false, gen_helper_HASHCHK)
 TRANS(HASHSTP, do_hash, true, gen_helper_HASHSTP)
 TRANS(HASHCHKP, do_hash, true, gen_helper_HASHCHKP)
+
+static bool trans_SLW(DisasContext *ctx, arg_SLW *a)
+{
+    TCGv t0, t1;
+
+    t0 = tcg_temp_new();
+    /* AND rt with a mask that is 0 when rB >= 0x20 */
+#if defined(TARGET_PPC64)
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x3a);
+    tcg_gen_sari_tl(t0, t0, 0x3f);
+#else
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x1a);
+    tcg_gen_sari_tl(t0, t0, 0x1f);
+#endif
+    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
+    t1 = tcg_temp_new();
+    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x1f);
+    tcg_gen_shl_tl(cpu_gpr[a->ra], t0, t1);
+    tcg_gen_ext32u_tl(cpu_gpr[a->ra], cpu_gpr[a->ra]);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
+static bool trans_SRW(DisasContext *ctx, arg_SRW *a)
+{
+    TCGv t0, t1;
+
+    t0 = tcg_temp_new();
+    /* AND rt with a mask that is 0 when rB >= 0x20 */
+#if defined(TARGET_PPC64)
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x3a);
+    tcg_gen_sari_tl(t0, t0, 0x3f);
+#else
+    tcg_gen_shli_tl(t0, cpu_gpr[a->rb], 0x1a);
+    tcg_gen_sari_tl(t0, t0, 0x1f);
+#endif
+    tcg_gen_andc_tl(t0, cpu_gpr[a->rt], t0);
+    tcg_gen_ext32u_tl(t0, t0);
+    t1 = tcg_temp_new();
+    tcg_gen_andi_tl(t1, cpu_gpr[a->rb], 0x1f);
+    tcg_gen_shr_tl(cpu_gpr[a->ra], t0, t1);
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
-- 
2.53.0


