Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CA6C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgry-000836-6j; Thu, 13 Jun 2024 05:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sHgrv-00082a-6f
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:35:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sHgrt-0007D8-7l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:35:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7ocRm019203;
 Thu, 13 Jun 2024 09:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=wzwFaRFwU+U08
 MkPVHe5Na9LWGjra8JxSyRRxaGzd0M=; b=FGV0dG3nXlHq2htrK/h8tAO/ZrpDQ
 ielXymkFVclKeoR82FwccGgzBmFBq9kvH4CjjRZIX5KBZtc/kzgl2Rho4UWweuA2
 pGd+4QaW+LKw7h4JY3EdUUj4FgfcrpAbD6vNKK6GTJ3tqL+JOuc4u7t4fEXe2WW4
 gR1fJDCP64Wf3zVnkmzP0dpBosKf7uKp+YKrwXqI7fpKP94ICneHiBeYaSIuXx7v
 g2tonp885MSO8/Pe/CK7mtMt8/5OunIhx/YiJPIKmIhL3qSO1qZKaI1SGMS9Q5dZ
 KKAAwfWUIS0yrlrKPzk5HPv8VooB+400HnOWfvhX9NEhXfT8EG+LL6K8Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqrkdgus5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45D9XavO031858;
 Thu, 13 Jun 2024 09:33:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqrkdgus3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45D82hg7020045; Thu, 13 Jun 2024 09:33:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34ndxwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 09:33:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45D9XWKX49152310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2024 09:33:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F351820040;
 Thu, 13 Jun 2024 09:33:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4E8F2004E;
 Thu, 13 Jun 2024 09:33:30 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2024 09:33:30 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 1/4] target/ppc: Moving VSX scalar storage access insns to
 decodetree.
Date: Thu, 13 Jun 2024 15:03:15 +0530
Message-Id: <20240613093318.314913-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613093318.314913-1-rathc@linux.ibm.com>
References: <20240613093318.314913-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bvFVaeO6V-g1yOOv0TKRMB-1WYoD_VUg
X-Proofpoint-GUID: YjjS2OEVu9C6ebLRRaYUNIbmPLN9DQRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=955 bulkscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Moving the following instructions to decodetree specification :

	lxs{d, iwa, ibz, ihz, iwz, sp}x		: X-form
	stxs{d, ib, ih, iw, sp}x		: X-form

The changes were verified by validating that the tcg-ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/insn32.decode            | 13 +++++
 target/ppc/translate/vsx-impl.c.inc | 79 +++++++++++++----------------
 target/ppc/translate/vsx-ops.c.inc  | 11 ----
 3 files changed, 49 insertions(+), 54 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 30d6f9f750..88753c75e1 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -792,6 +792,19 @@ STXVRHX         011111 ..... ..... ..... 0010101101 .   @X_TSX
 STXVRWX         011111 ..... ..... ..... 0011001101 .   @X_TSX
 STXVRDX         011111 ..... ..... ..... 0011101101 .   @X_TSX
 
+LXSDX           011111 ..... ..... ..... 1001001100 .   @X_TSX
+LXSIWAX         011111 ..... ..... ..... 0001001100 .   @X_TSX
+LXSIBZX         011111 ..... ..... ..... 1100001101 .   @X_TSX
+LXSIHZX         011111 ..... ..... ..... 1100101101 .   @X_TSX
+LXSIWZX         011111 ..... ..... ..... 0000001100 .   @X_TSX
+LXSSPX          011111 ..... ..... ..... 1000001100 .   @X_TSX
+
+STXSDX          011111 ..... ..... ..... 1011001100 .   @X_TSX
+STXSIBX         011111 ..... ..... ..... 1110001101 .   @X_TSX
+STXSIHX         011111 ..... ..... ..... 1110101101 .   @X_TSX
+STXSIWX         011111 ..... ..... ..... 0010001100 .   @X_TSX
+STXSSPX         011111 ..... ..... ..... 1010001100 .   @X_TSX
+
 ## VSX Vector Binary Floating-Point Sign Manipulation Instructions
 
 XVABSDP         111100 ..... 00000 ..... 111011001 ..   @XX2
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index a769f199ce..de2a26a213 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -24,30 +24,27 @@ static inline TCGv_ptr gen_acc_ptr(int reg)
     return r;
 }
 
-#define VSX_LOAD_SCALAR(name, operation)                      \
-static void gen_##name(DisasContext *ctx)                     \
-{                                                             \
-    TCGv EA;                                                  \
-    TCGv_i64 t0;                                              \
-    if (unlikely(!ctx->vsx_enabled)) {                        \
-        gen_exception(ctx, POWERPC_EXCP_VSXU);                \
-        return;                                               \
-    }                                                         \
-    t0 = tcg_temp_new_i64();                                  \
-    gen_set_access_type(ctx, ACCESS_INT);                     \
-    EA = tcg_temp_new();                                      \
-    gen_addr_reg_index(ctx, EA);                              \
-    gen_qemu_##operation(ctx, t0, EA);                        \
-    set_cpu_vsr(xT(ctx->opcode), t0, true);                   \
-    /* NOTE: cpu_vsrl is undefined */                         \
+static bool do_lxs(DisasContext *ctx, arg_X *a,
+                   void (*op)(DisasContext *, TCGv_i64, TCGv))
+{
+    TCGv EA;
+    TCGv_i64 t0;
+    REQUIRE_VSX(ctx);
+    t0 = tcg_temp_new_i64();
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    op(ctx, t0, EA);
+    set_cpu_vsr(a->rt, t0, true);
+    /* NOTE: cpu_vsrl is undefined */
+    return true;
 }
 
-VSX_LOAD_SCALAR(lxsdx, ld64_i64)
-VSX_LOAD_SCALAR(lxsiwax, ld32s_i64)
-VSX_LOAD_SCALAR(lxsibzx, ld8u_i64)
-VSX_LOAD_SCALAR(lxsihzx, ld16u_i64)
-VSX_LOAD_SCALAR(lxsiwzx, ld32u_i64)
-VSX_LOAD_SCALAR(lxsspx, ld32fs)
+TRANS_FLAGS2(VSX, LXSDX, do_lxs, gen_qemu_ld64_i64);
+TRANS_FLAGS2(VSX207, LXSIWAX, do_lxs, gen_qemu_ld32s_i64);
+TRANS_FLAGS2(ISA300, LXSIBZX, do_lxs, gen_qemu_ld8u_i64);
+TRANS_FLAGS2(ISA300, LXSIHZX, do_lxs, gen_qemu_ld16u_i64);
+TRANS_FLAGS2(VSX207, LXSIWZX, do_lxs, gen_qemu_ld32u_i64);
+TRANS_FLAGS2(VSX207, LXSSPX, do_lxs, gen_qemu_ld32fs);
 
 static void gen_lxvd2x(DisasContext *ctx)
 {
@@ -266,29 +263,25 @@ VSX_VECTOR_LOAD_STORE_LENGTH(stxvl)
 VSX_VECTOR_LOAD_STORE_LENGTH(stxvll)
 #endif
 
-#define VSX_STORE_SCALAR(name, operation)                     \
-static void gen_##name(DisasContext *ctx)                     \
-{                                                             \
-    TCGv EA;                                                  \
-    TCGv_i64 t0;                                              \
-    if (unlikely(!ctx->vsx_enabled)) {                        \
-        gen_exception(ctx, POWERPC_EXCP_VSXU);                \
-        return;                                               \
-    }                                                         \
-    t0 = tcg_temp_new_i64();                                  \
-    gen_set_access_type(ctx, ACCESS_INT);                     \
-    EA = tcg_temp_new();                                      \
-    gen_addr_reg_index(ctx, EA);                              \
-    get_cpu_vsr(t0, xS(ctx->opcode), true);                   \
-    gen_qemu_##operation(ctx, t0, EA);                        \
+static bool do_stxs(DisasContext *ctx, arg_X *a,
+                    void (*op)(DisasContext *, TCGv_i64, TCGv))
+{
+    TCGv EA;
+    TCGv_i64 t0;
+    REQUIRE_VSX(ctx);
+    t0 = tcg_temp_new_i64();
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    get_cpu_vsr(t0, a->rt, true);
+    op(ctx, t0, EA);
+    return true;
 }
 
-VSX_STORE_SCALAR(stxsdx, st64_i64)
-
-VSX_STORE_SCALAR(stxsibx, st8_i64)
-VSX_STORE_SCALAR(stxsihx, st16_i64)
-VSX_STORE_SCALAR(stxsiwx, st32_i64)
-VSX_STORE_SCALAR(stxsspx, st32fs)
+TRANS_FLAGS2(VSX, STXSDX, do_stxs, gen_qemu_st64_i64);
+TRANS_FLAGS2(ISA300, STXSIBX, do_stxs, gen_qemu_st8_i64);
+TRANS_FLAGS2(ISA300, STXSIHX, do_stxs, gen_qemu_st16_i64);
+TRANS_FLAGS2(VSX207, STXSIWX, do_stxs, gen_qemu_st32_i64);
+TRANS_FLAGS2(VSX207, STXSSPX, do_stxs, gen_qemu_st32fs);
 
 static void gen_stxvd2x(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index 3c0a70cb7c..d44cb55836 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -1,9 +1,3 @@
-GEN_HANDLER_E(lxsdx, 0x1F, 0x0C, 0x12, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(lxsiwax, 0x1F, 0x0C, 0x02, 0, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(lxsiwzx, 0x1F, 0x0C, 0x00, 0, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(lxsibzx, 0x1F, 0x0D, 0x18, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxsihzx, 0x1F, 0x0D, 0x19, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(lxsspx, 0x1F, 0x0C, 0x10, 0, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(lxvd2x, 0x1F, 0x0C, 0x1A, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(lxvwsx, 0x1F, 0x0C, 0x0B, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvdsx, 0x1F, 0x0C, 0x0A, 0, PPC_NONE, PPC2_VSX),
@@ -15,11 +9,6 @@ GEN_HANDLER_E(lxvl, 0x1F, 0x0D, 0x08, 0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(lxvll, 0x1F, 0x0D, 0x09, 0, PPC_NONE, PPC2_ISA300),
 #endif
 
-GEN_HANDLER_E(stxsdx, 0x1F, 0xC, 0x16, 0, PPC_NONE, PPC2_VSX),
-GEN_HANDLER_E(stxsibx, 0x1F, 0xD, 0x1C, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stxsihx, 0x1F, 0xD, 0x1D, 0, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER_E(stxsiwx, 0x1F, 0xC, 0x04, 0, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(stxsspx, 0x1F, 0xC, 0x14, 0, PPC_NONE, PPC2_VSX207),
 GEN_HANDLER_E(stxvd2x, 0x1F, 0xC, 0x1E, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvw4x, 0x1F, 0xC, 0x1C, 0, PPC_NONE, PPC2_VSX),
 GEN_HANDLER_E(stxvh8x, 0x1F, 0x0C, 0x1D, 0, PPC_NONE,  PPC2_ISA300),
-- 
2.39.3


