Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205F7C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 05:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1JLL-00035w-DI; Mon, 29 Apr 2024 01:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s1JKi-0002ua-Co; Mon, 29 Apr 2024 01:13:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1s1JKf-0005iL-Qk; Mon, 29 Apr 2024 01:13:44 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43T57Vv2024900; Mon, 29 Apr 2024 05:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ioGX2N75dkt6yWt4qZf6Y1ckzhIs8Q/OVfOnl/CwKbo=;
 b=MYOTA6iaq0C4qH5NvvUQUdBB5BdoPqZdku9ln9TYNOW2dVswikpsS1JBi/zlGnNXYyMZ
 6Lx5bT1EYZxFzuoDqjPYEinlGXpRayUu0y5ax3ANKWziKAq4l8oux3rz+IPvYbXgg6K3
 WtA5F6/VttBTf3BqRS+X0eGHNkWNiVCq2oBAc8V1MnEzWAeAyVxnC6xpwV2yxVrKNKRe
 GmZ86GkgVzy4fSy6ijBcCf1tmKxVgPve/T1qkU5EISdpf/JUOpxj8ovalDCDNtVssvNb
 Vz3zYrgJsWleJjf4/FBHf9hKBIgSwQBUSpo9yoHZrpoPr3YLJ4+QJyE8jtHcyiu61qz0 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt54br082-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:37 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43T5DbvC001756;
 Mon, 29 Apr 2024 05:13:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt54br081-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:37 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43T4AAK6003038; Mon, 29 Apr 2024 05:13:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpp5e22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 05:13:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43T5DWKh40370550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 05:13:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0032820043;
 Mon, 29 Apr 2024 05:13:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0C4F20040;
 Mon, 29 Apr 2024 05:13:29 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.12.153])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Apr 2024 05:13:29 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 1/3] target/ppc: Move VMX storage access instructions to
 decodetree
Date: Mon, 29 Apr 2024 10:43:15 +0530
Message-Id: <20240429051317.289426-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240429051317.289426-1-rathc@linux.ibm.com>
References: <20240429051317.289426-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Eqi0Ks6ohcBZlx2Ly-jIuq7ahAh2ggjF
X-Proofpoint-ORIG-GUID: y5oubBLAaGfrTm8HJ0IhfeSqaw3u00S_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_02,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

	{l,st}ve{b,h,w}x,
	{l,st}v{x,xl},
	lvs{l,r}		: X-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/helper.h                 |  12 +-
 target/ppc/insn32.decode            |  17 +++
 target/ppc/mem_helper.c             |  12 +-
 target/ppc/translate.c              |   2 -
 target/ppc/translate/vmx-impl.c.inc | 221 ++++++++++++----------------
 target/ppc/translate/vmx-ops.c.inc  |  19 ---
 6 files changed, 120 insertions(+), 163 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..f397ef459a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -267,12 +267,12 @@ DEF_HELPER_5(VMSUMSHS, void, env, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_5(VMLADDUHM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
 DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
-DEF_HELPER_3(lvebx, void, env, avr, tl)
-DEF_HELPER_3(lvehx, void, env, avr, tl)
-DEF_HELPER_3(lvewx, void, env, avr, tl)
-DEF_HELPER_3(stvebx, void, env, avr, tl)
-DEF_HELPER_3(stvehx, void, env, avr, tl)
-DEF_HELPER_3(stvewx, void, env, avr, tl)
+DEF_HELPER_3(LVEBX, void, env, avr, tl)
+DEF_HELPER_3(LVEHX, void, env, avr, tl)
+DEF_HELPER_3(LVEWX, void, env, avr, tl)
+DEF_HELPER_3(STVEBX, void, env, avr, tl)
+DEF_HELPER_3(STVEHX, void, env, avr, tl)
+DEF_HELPER_3(STVEWX, void, env, avr, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(lxvl, void, env, tl, vsr, tl)
 DEF_HELPER_4(lxvll, void, env, tl, vsr, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index eada59f59f..27655f0d9e 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -526,6 +526,23 @@ DSCRIQ          111111 ..... ..... ...... 001100010 .   @Z22_tap_sh_rc
 
 VPMSUMD         000100 ..... ..... ..... 10011001000    @VX
 
+## Vector Load/Store Instructions
+
+LVEBX           011111 ..... ..... ..... 0000000111 -   @X
+LVEHX           011111 ..... ..... ..... 0000100111 -   @X
+LVEWX           011111 ..... ..... ..... 0001000111 -   @X
+LVX             011111 ..... ..... ..... 0001100111 -   @X
+LVXL            011111 ..... ..... ..... 0101100111 -   @X
+
+STVEBX          011111 ..... ..... ..... 0010000111 -   @X
+STVEHX          011111 ..... ..... ..... 0010100111 -   @X
+STVEWX          011111 ..... ..... ..... 0011000111 -   @X
+STVX            011111 ..... ..... ..... 0011100111 -   @X
+STVXL           011111 ..... ..... ..... 0111100111 -   @X
+
+LVSL            011111 ..... ..... ..... 0000000110 -   @X
+LVSR            011111 ..... ..... ..... 0000100110 -   @X
+
 ## Vector Integer Instructions
 
 VCMPEQUB        000100 ..... ..... ..... . 0000000110   @VC
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index ea7e8443a8..f88155ad45 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -404,9 +404,9 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         }                                                       \
     }
 #define I(x) (x)
-LVE(lvebx, cpu_ldub_data_ra, I, u8)
-LVE(lvehx, cpu_lduw_data_ra, bswap16, u16)
-LVE(lvewx, cpu_ldl_data_ra, bswap32, u32)
+LVE(LVEBX, cpu_ldub_data_ra, I, u8)
+LVE(LVEHX, cpu_lduw_data_ra, bswap16, u16)
+LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
@@ -432,9 +432,9 @@ LVE(lvewx, cpu_ldl_data_ra, bswap32, u32)
         }                                                               \
     }
 #define I(x) (x)
-STVE(stvebx, cpu_stb_data_ra, I, u8)
-STVE(stvehx, cpu_stw_data_ra, bswap16, u16)
-STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
+STVE(STVEBX, cpu_stb_data_ra, I, u8)
+STVE(STVEHX, cpu_stw_data_ra, bswap16, u16)
+STVE(STVEWX, cpu_stl_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..cde3b88b98 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6640,8 +6640,6 @@ GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
                PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
              PPC_440_SPEC),
-GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
-GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index b56e615c24..4d5e743cfe 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -14,125 +14,88 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
     return r;
 }
 
-#define GEN_VR_LDX(name, opc2, opc3)                                          \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    TCGv EA;                                                                  \
-    TCGv_i64 avr;                                                             \
-    if (unlikely(!ctx->altivec_enabled)) {                                    \
-        gen_exception(ctx, POWERPC_EXCP_VPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    gen_set_access_type(ctx, ACCESS_INT);                                     \
-    avr = tcg_temp_new_i64();                                                 \
-    EA = tcg_temp_new();                                                      \
-    gen_addr_reg_index(ctx, EA);                                              \
-    tcg_gen_andi_tl(EA, EA, ~0xf);                                            \
-    /*                                                                        \
-     * We only need to swap high and low halves. gen_qemu_ld64_i64            \
-     * does necessary 64-bit byteswap already.                                \
-     */                                                                       \
-    if (ctx->le_mode) {                                                       \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, false);                               \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, true);                                \
-    } else {                                                                  \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, true);                                \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, false);                               \
-    }                                                                         \
-}
-
-#define GEN_VR_STX(name, opc2, opc3)                                          \
-static void gen_st##name(DisasContext *ctx)                                   \
-{                                                                             \
-    TCGv EA;                                                                  \
-    TCGv_i64 avr;                                                             \
-    if (unlikely(!ctx->altivec_enabled)) {                                    \
-        gen_exception(ctx, POWERPC_EXCP_VPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    gen_set_access_type(ctx, ACCESS_INT);                                     \
-    avr = tcg_temp_new_i64();                                                 \
-    EA = tcg_temp_new();                                                      \
-    gen_addr_reg_index(ctx, EA);                                              \
-    tcg_gen_andi_tl(EA, EA, ~0xf);                                            \
-    /*                                                                        \
-     * We only need to swap high and low halves. gen_qemu_st64_i64            \
-     * does necessary 64-bit byteswap already.                                \
-     */                                                                       \
-    if (ctx->le_mode) {                                                       \
-        get_avr64(avr, rD(ctx->opcode), false);                               \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        get_avr64(avr, rD(ctx->opcode), true);                                \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-    } else {                                                                  \
-        get_avr64(avr, rD(ctx->opcode), true);                                \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        get_avr64(avr, rD(ctx->opcode), false);                               \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-    }                                                                         \
-}
-
-#define GEN_VR_LVE(name, opc2, opc3, size)                              \
-static void gen_lve##name(DisasContext *ctx)                            \
-    {                                                                   \
-        TCGv EA;                                                        \
-        TCGv_ptr rs;                                                    \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        gen_set_access_type(ctx, ACCESS_INT);                           \
-        EA = tcg_temp_new();                                            \
-        gen_addr_reg_index(ctx, EA);                                    \
-        if (size > 1) {                                                 \
-            tcg_gen_andi_tl(EA, EA, ~(size - 1));                       \
-        }                                                               \
-        rs = gen_avr_ptr(rS(ctx->opcode));                              \
-        gen_helper_lve##name(tcg_env, rs, EA);                          \
-    }
-
-#define GEN_VR_STVE(name, opc2, opc3, size)                             \
-static void gen_stve##name(DisasContext *ctx)                           \
-    {                                                                   \
-        TCGv EA;                                                        \
-        TCGv_ptr rs;                                                    \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        gen_set_access_type(ctx, ACCESS_INT);                           \
-        EA = tcg_temp_new();                                            \
-        gen_addr_reg_index(ctx, EA);                                    \
-        if (size > 1) {                                                 \
-            tcg_gen_andi_tl(EA, EA, ~(size - 1));                       \
-        }                                                               \
-        rs = gen_avr_ptr(rS(ctx->opcode));                              \
-        gen_helper_stve##name(tcg_env, rs, EA);                         \
-    }
+static bool trans_LVX(DisasContext *ctx, arg_X *a)
+{
+    TCGv EA;
+    TCGv_i64 avr;
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+    gen_set_access_type(ctx, ACCESS_INT);
+    avr = tcg_temp_new_i64();
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    tcg_gen_andi_tl(EA, EA, ~0xf);
+    /*
+     * We only need to swap high and low halves. gen_qemu_ld64_i64
+     * does necessary 64-bit byteswap already.
+     */
+    gen_qemu_ld64_i64(ctx, avr, EA);
+    set_avr64(a->rt, avr, !ctx->le_mode);
+    tcg_gen_addi_tl(EA, EA, 8);
+    gen_qemu_ld64_i64(ctx, avr, EA);
+    set_avr64(a->rt, avr, ctx->le_mode);
+    return true;
+}
 
-GEN_VR_LDX(lvx, 0x07, 0x03);
 /* As we don't emulate the cache, lvxl is strictly equivalent to lvx */
-GEN_VR_LDX(lvxl, 0x07, 0x0B);
+QEMU_FLATTEN
+static bool trans_LVXL(DisasContext *ctx, arg_LVXL *a)
+{
+    return trans_LVX(ctx, a);
+}
 
-GEN_VR_LVE(bx, 0x07, 0x00, 1);
-GEN_VR_LVE(hx, 0x07, 0x01, 2);
-GEN_VR_LVE(wx, 0x07, 0x02, 4);
+static bool trans_STVX(DisasContext *ctx, arg_STVX *a)
+{
+    TCGv EA;
+    TCGv_i64 avr;
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+    gen_set_access_type(ctx, ACCESS_INT);
+    avr = tcg_temp_new_i64();
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    tcg_gen_andi_tl(EA, EA, ~0xf);
+    /*
+     * We only need to swap high and low halves. gen_qemu_st64_i64
+     * does necessary 64-bit byteswap already.
+     */
+    get_avr64(avr, a->rt, !ctx->le_mode);
+    gen_qemu_st64_i64(ctx, avr, EA);
+    tcg_gen_addi_tl(EA, EA, 8);
+    get_avr64(avr, a->rt, ctx->le_mode);
+    gen_qemu_st64_i64(ctx, avr, EA);
+    return true;
+}
 
-GEN_VR_STX(svx, 0x07, 0x07);
 /* As we don't emulate the cache, stvxl is strictly equivalent to stvx */
-GEN_VR_STX(svxl, 0x07, 0x0F);
+QEMU_FLATTEN
+static bool trans_STVXL(DisasContext *ctx, arg_STVXL *a)
+{
+    return trans_STVX(ctx, a);
+}
+
+static bool do_ldst_ve_X(DisasContext *ctx, arg_X *a, int size,
+                   void (*helper)(TCGv_env, TCGv_ptr, TCGv))
+{
+    TCGv EA;
+    TCGv_ptr vrt;
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    if (size > 1) {
+        tcg_gen_andi_tl(EA, EA, ~(size - 1));
+    }
+    vrt = gen_avr_ptr(a->rt);
+    helper(tcg_env, vrt, EA);
+    return true;
+}
+
+TRANS(LVEBX, do_ldst_ve_X, 1, gen_helper_LVEBX);
+TRANS(LVEHX, do_ldst_ve_X, 2, gen_helper_LVEHX);
+TRANS(LVEWX, do_ldst_ve_X, 4, gen_helper_LVEWX);
 
-GEN_VR_STVE(bx, 0x07, 0x04, 1);
-GEN_VR_STVE(hx, 0x07, 0x05, 2);
-GEN_VR_STVE(wx, 0x07, 0x06, 4);
+TRANS(STVEBX, do_ldst_ve_X, 1, gen_helper_STVEBX);
+TRANS(STVEHX, do_ldst_ve_X, 2, gen_helper_STVEHX);
+TRANS(STVEWX, do_ldst_ve_X, 4, gen_helper_STVEWX);
 
 static void gen_mfvscr(DisasContext *ctx)
 {
@@ -460,15 +423,17 @@ static void trans_vmrgow(DisasContext *ctx)
  * Let X be the 32-byte value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1F.
  * Bytes sh:sh+15 of X are placed into vD.
  */
-static void trans_lvsl(DisasContext *ctx)
+static bool trans_LVSL(DisasContext *ctx, arg_LVSL *a)
 {
-    int VT = rD(ctx->opcode);
     TCGv_i64 result = tcg_temp_new_i64();
     TCGv_i64 sh = tcg_temp_new_i64();
     TCGv EA = tcg_temp_new();
 
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+
     /* Get sh(from description) by anding EA with 0xf. */
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_extu_tl_i64(sh, EA);
     tcg_gen_andi_i64(sh, sh, 0xfULL);
 
@@ -478,13 +443,14 @@ static void trans_lvsl(DisasContext *ctx)
      */
     tcg_gen_muli_i64(sh, sh, 0x0101010101010101ULL);
     tcg_gen_addi_i64(result, sh, 0x0001020304050607ull);
-    set_avr64(VT, result, true);
+    set_avr64(a->rt, result, true);
     /*
      * Create bytes sh+8:sh+15 of X(from description) and place them in
      * lower doubleword of vD.
      */
     tcg_gen_addi_i64(result, sh, 0x08090a0b0c0d0e0fULL);
-    set_avr64(VT, result, false);
+    set_avr64(a->rt, result, false);
+    return true;
 }
 
 /*
@@ -494,16 +460,17 @@ static void trans_lvsl(DisasContext *ctx)
  * Let X be the 32-byte value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1F.
  * Bytes (16-sh):(31-sh) of X are placed into vD.
  */
-static void trans_lvsr(DisasContext *ctx)
+static bool trans_LVSR(DisasContext *ctx, arg_LVSR *a)
 {
-    int VT = rD(ctx->opcode);
     TCGv_i64 result = tcg_temp_new_i64();
     TCGv_i64 sh = tcg_temp_new_i64();
     TCGv EA = tcg_temp_new();
 
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
 
     /* Get sh(from description) by anding EA with 0xf. */
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_extu_tl_i64(sh, EA);
     tcg_gen_andi_i64(sh, sh, 0xfULL);
 
@@ -513,13 +480,14 @@ static void trans_lvsr(DisasContext *ctx)
      */
     tcg_gen_muli_i64(sh, sh, 0x0101010101010101ULL);
     tcg_gen_subfi_i64(result, 0x1011121314151617ULL, sh);
-    set_avr64(VT, result, true);
+    set_avr64(a->rt, result, true);
     /*
      * Create bytes (24-sh):(32-sh) of X(from description) and place them in
      * lower doubleword of vD.
      */
     tcg_gen_subfi_i64(result, 0x18191a1b1c1d1e1fULL, sh);
-    set_avr64(VT, result, false);
+    set_avr64(a->rt, result, false);
+    return true;
 }
 
 /*
@@ -1158,8 +1126,6 @@ GEN_VXFORM_TRANS_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
 GEN_VXFORM_HETRO(vextubrx, 6, 28)
 GEN_VXFORM_HETRO(vextuhrx, 6, 29)
 GEN_VXFORM_HETRO(vextuwrx, 6, 30)
-GEN_VXFORM_TRANS(lvsl, 6, 31)
-GEN_VXFORM_TRANS(lvsr, 6, 32)
 GEN_VXFORM_TRANS_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207,
                 vextuwrx, PPC_NONE, PPC2_ISA300)
 
@@ -3365,11 +3331,6 @@ TRANS_FLAGS2(ISA310, VMODUQ, do_vx_helper, gen_helper_VMODUQ)
 #undef DIVS64
 #undef DIVU64
 
-#undef GEN_VR_LDX
-#undef GEN_VR_STX
-#undef GEN_VR_LVE
-#undef GEN_VR_STVE
-
 #undef GEN_VX_LOGICAL
 #undef GEN_VX_LOGICAL_207
 #undef GEN_VXFORM
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 33fec8aca4..672fba3796 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -1,22 +1,3 @@
-#define GEN_VR_LDX(name, opc2, opc3)                                          \
-GEN_HANDLER(name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-#define GEN_VR_STX(name, opc2, opc3)                                          \
-GEN_HANDLER(st##name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-#define GEN_VR_LVE(name, opc2, opc3)                                    \
-    GEN_HANDLER(lve##name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-#define GEN_VR_STVE(name, opc2, opc3)                                   \
-    GEN_HANDLER(stve##name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-GEN_VR_LDX(lvx, 0x07, 0x03),
-GEN_VR_LDX(lvxl, 0x07, 0x0B),
-GEN_VR_LVE(bx, 0x07, 0x00),
-GEN_VR_LVE(hx, 0x07, 0x01),
-GEN_VR_LVE(wx, 0x07, 0x02),
-GEN_VR_STX(svx, 0x07, 0x07),
-GEN_VR_STX(svxl, 0x07, 0x0F),
-GEN_VR_STVE(bx, 0x07, 0x04),
-GEN_VR_STVE(hx, 0x07, 0x05),
-GEN_VR_STVE(wx, 0x07, 0x06),
-
 #define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
 GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_ALTIVEC)
 
-- 
2.39.3


