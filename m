Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CDEC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 09:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSC33-0008V8-SB; Thu, 19 Jun 2025 05:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC30-0008TY-Af; Thu, 19 Jun 2025 05:59:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1uSC2y-0007rJ-7L; Thu, 19 Jun 2025 05:59:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IMnqXF017922;
 Thu, 19 Jun 2025 09:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GF5H2TU6H29ju9w12
 yMnlZlYi8wrCGxV6AHi8w3DmdE=; b=IsM4N8Tq1q9ZtSsTzVlIpV34H/iFvjIZM
 OEK81+p7kxCk+26ZjlsYXwP/fswemrdSTFAnSCZW+CEaWQNkFl+5SaOrj7XIIFZo
 zQoPi8Ntbl+XibHabLyJLR7JPZ6UT8zHBRlpXLVxMczU/NK8Ajiq/F93eEqu+KvJ
 icTLowNNG0r3EGDZunFcKC8gONgMGpZD4Ps0MH4i3SwxF88SEp/1eHTnixUC/Ss+
 TymUEooTD3mSTn110vdHGN/jBfeGezUx6jMlWuiSVQY/tuFJknaCJg4Tej8GFbGm
 X0yweSi2HbymkHgEC+WXL2V99CKgEYAapGGos8VizNnvWiDzwBkhw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktvrvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55J9vYZ1021668;
 Thu, 19 Jun 2025 09:59:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktvrvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:59:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55J73WIe010821;
 Thu, 19 Jun 2025 09:58:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtns03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 09:58:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55J9wwp054854006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 09:58:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 099A220043;
 Thu, 19 Jun 2025 09:58:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7042520040;
 Thu, 19 Jun 2025 09:58:56 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.in.ibm.com (unknown
 [9.79.200.241]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Jun 2025 09:58:56 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 danielhb413@gmail.com
Cc: richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 2/5] target/ppc: Move floating-point compare instructions to
 decodetree.
Date: Thu, 19 Jun 2025 15:28:37 +0530
Message-ID: <20250619095840.369351-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619095840.369351-1-rathc@linux.ibm.com>
References: <20250619095840.369351-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ipRvhUntNzK4cMx2JwVCCBYXkW9P3XaM
X-Proofpoint-ORIG-GUID: 5LRYybzZ7JUp3pQCmdzAM79OT5jvy0P_
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=6853df65 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=TaHRx3OIgkk5F58xYbkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA4MiBTYWx0ZWRfX5LnC99utZrtI
 1hCiDsW2TtjCqJxByOIRgVlazfXSkuGfmiDu7k6P67I1ls2hAowKWOeKi729R/s0rJU5vCru93r
 Qzmax0DPkLO1r6ZTXTVbnYGBStNg1oM/DpmPLLXCWsWj8GYMG0KSrLEFhxndU4MnrGclw01NiDW
 wLq4P3tVJ7BHC8PiTCKVOdIfZslXNU1m7/yNoGBD2vPkv7tsJ+Uf/qMevbbGDTodzRkSyEoWmXI
 LiL7ak8wiJnDAD8W+hv+jDKv9mhKc6p6XHrH8yeyz+paV/2qqZYEEpfSb4W7dYBKIvGb3s8ANdp
 69atQ7/9Y8R2mg2Bstevjyq/arRfC7bJHCJcNYJWHNf/wCq4IKR3blKOiEmqmW/qw7TtbLVzaxA
 UMhv3d++IXyPWrD/lrQrQorVcIaxw4W6Ycd5N2/Ae/NC2PnGGF+kQ7KZBB7/EKcMl0SPgUBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=996 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move below instructions to decodetree specification :

	fcmp{u, o}		: X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/fpu_helper.c            |  4 +--
 target/ppc/helper.h                |  4 +--
 target/ppc/insn32.decode           |  5 ++++
 target/ppc/translate/fp-impl.c.inc | 45 +++++++++---------------------
 target/ppc/translate/fp-ops.c.inc  |  2 --
 5 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 503cbd98ad..850aca6ed1 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -871,7 +871,7 @@ uint32_t helper_FTSQRT(uint64_t frb)
     return 0x8 | (fg_flag ? 4 : 0) | (fe_flag ? 2 : 0);
 }
 
-void helper_fcmpu(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
+void helper_FCMPU(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
                   uint32_t crfD)
 {
     CPU_DoubleU farg1, farg2;
@@ -902,7 +902,7 @@ void helper_fcmpu(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
     }
 }
 
-void helper_fcmpo(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
+void helper_FCMPO(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
                   uint32_t crfD)
 {
     CPU_DoubleU farg1, farg2;
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 96000f4f0d..e99c8c824b 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -94,8 +94,8 @@ DEF_HELPER_2(fpscr_setbit, void, env, i32)
 DEF_HELPER_FLAGS_1(todouble, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_1(tosingle, TCG_CALL_NO_RWG_SE, i32, i64)
 
-DEF_HELPER_4(fcmpo, void, env, i64, i64, i32)
-DEF_HELPER_4(fcmpu, void, env, i64, i64, i32)
+DEF_HELPER_4(FCMPO, void, env, i64, i64, i32)
+DEF_HELPER_4(FCMPU, void, env, i64, i64, i32)
 
 DEF_HELPER_2(FCTIW, i64, env, i64)
 DEF_HELPER_2(FCTIWU, i64, env, i64)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 15dec702b9..0ffd814471 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -565,6 +565,11 @@ FCFIDS          111011 ..... ----- ..... 1101001110 .   @X_tb_rc
 FCFIDU          111111 ..... ----- ..... 1111001110 .   @X_tb_rc
 FCFIDUS         111011 ..... ----- ..... 1111001110 .   @X_tb_rc
 
+### Floating-Point Compare Instructions
+
+FCMPU           111111 ... -- ..... ..... 0000000000 -  @X_bf
+FCMPO           111111 ... -- ..... ..... 0000100000 -  @X_bf
+
 ### Floating-Point Select Instruction
 
 FSEL            111111 ..... ..... ..... ..... 10111 .  @A
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index f296cfcdb0..4e18d350c0 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -257,46 +257,27 @@ static bool trans_FTSQRT(DisasContext *ctx, arg_X_bf_b *a)
 }
 
 /***                         Floating-Point compare                        ***/
-
-/* fcmpo */
-static void gen_fcmpo(DisasContext *ctx)
+static bool do_helper_cmp(DisasContext *ctx, arg_X_bf *a,
+                          void (*helper)(TCGv_env, TCGv_i64, TCGv_i64,
+                                         TCGv_i32))
 {
     TCGv_i32 crf;
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
+    TCGv_i64 t0, t1;
+    REQUIRE_INSNS_FLAGS(ctx, FLOAT);
+    REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_reset_fpstatus();
-    crf = tcg_constant_i32(crfD(ctx->opcode));
-    get_fpr(t0, rA(ctx->opcode));
-    get_fpr(t1, rB(ctx->opcode));
-    gen_helper_fcmpo(tcg_env, t0, t1, crf);
+    crf = tcg_constant_i32(a->bf);
+    get_fpr(t0, a->ra);
+    get_fpr(t1, a->rb);
+    helper(tcg_env, t0, t1, crf);
     gen_helper_float_check_status(tcg_env);
+    return true;
 }
 
-/* fcmpu */
-static void gen_fcmpu(DisasContext *ctx)
-{
-    TCGv_i32 crf;
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->fpu_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_FPU);
-        return;
-    }
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    gen_reset_fpstatus();
-    crf = tcg_constant_i32(crfD(ctx->opcode));
-    get_fpr(t0, rA(ctx->opcode));
-    get_fpr(t1, rB(ctx->opcode));
-    gen_helper_fcmpu(tcg_env, t0, t1, crf);
-    gen_helper_float_check_status(tcg_env);
-}
+TRANS(FCMPU, do_helper_cmp, gen_helper_FCMPU);
+TRANS(FCMPO, do_helper_cmp, gen_helper_FCMPO);
 
 /***                         Floating-point move                           ***/
 /* fabs */
diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
index acb8ac32da..502453da35 100644
--- a/target/ppc/translate/fp-ops.c.inc
+++ b/target/ppc/translate/fp-ops.c.inc
@@ -10,8 +10,6 @@ GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
 GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
 GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
 
-GEN_HANDLER(fcmpo, 0x3F, 0x00, 0x01, 0x00600001, PPC_FLOAT),
-GEN_HANDLER(fcmpu, 0x3F, 0x00, 0x00, 0x00600001, PPC_FLOAT),
 GEN_HANDLER(fabs, 0x3F, 0x08, 0x08, 0x001F0000, PPC_FLOAT),
 GEN_HANDLER(fmr, 0x3F, 0x08, 0x02, 0x001F0000, PPC_FLOAT),
 GEN_HANDLER(fnabs, 0x3F, 0x08, 0x04, 0x001F0000, PPC_FLOAT),
-- 
2.49.0


