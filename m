Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBD1CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3Y-00031o-2p; Sun, 28 Sep 2025 15:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3V-000301-7Q
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3K-000487-Hl
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SHoSve024019;
 Sun, 28 Sep 2025 19:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6rxJghI/Ay80Y/ymC
 YTnBc6UkYhodyjmT/QkBmZUX0A=; b=J4e/gl+tIT1pB8Z/K2M1+I5RvM9FtL5tc
 IHKLykcBLJRCFAR6N2GKBue0Ogqom0MWpBd6EPwDZCVtXh9nYRoSsa9pKm9FB9Z2
 2bJ22LDnRtTT2iVE7oHExFPe/WhjetkuJhBz+xSw2IBfD0u/zH4xkvHArmqfE3J4
 Xyt1Nsp6aPrKVhi7hHRFOBC+ZSLWQWGIol6s20MZF1pHV99X/h4SVi5rWD9u/t7t
 NtYeB4y4MJ/0qSoefiAkqhdcrudKvtGsxHJLA//yUJ1Il0jgt9Zj2Jv5PTsRWFnO
 wJuBUkeSKx873oUoH/Ukcgf73VsB3Zu7OL8ZLyscMAIGI2vJ5XVlg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ktxq29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SGtIIJ020064;
 Sun, 28 Sep 2025 19:27:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8ru1dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:27:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJRAnE52429300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:27:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60BF12004D;
 Sun, 28 Sep 2025 19:27:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59CF120040;
 Sun, 28 Sep 2025 19:27:09 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:27:09 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/27] target/ppc: Move floating-point compare instructions to
 decodetree.
Date: Mon, 29 Sep 2025 00:56:24 +0530
Message-ID: <20250928192629.139822-23-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68d98c12 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=TaHRx3OIgkk5F58xYbkA:9 a=cvBusfyB2V15izCimMoJ:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: 0_vgopz5PowhAXJn8ue3dEUBETYKIrRd
X-Proofpoint-ORIG-GUID: 0_vgopz5PowhAXJn8ue3dEUBETYKIrRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX3okEpdNZe248
 6GVdCcJdyETdD4N8Sjx049XQH8c5F0HburGlw90cbPLBMUjNRKZg4Z9eiq4P3mfIYNLNQ9MlHGX
 g+A+bOkPxp3hjtDGLHI+ACWrF5DwHHdh89Ggr7cmy0RCbnXiJmvM5o62BulVnfqAhuqwihHxcJ+
 HXqW3+P7gAzl/HLFQCa+b16wy7dvStYDs+QVL3RJO3xXpYTwLjSBoJ34c6BJmK7qMYMi1BGbJCQ
 M3hpmrSV4enGa+y3aGz1/eZfTKGTBimBjLUL2Yvm3TeRLu3OO4dHPPABDweLr1iNtA6apWddQR5
 dkCPu4Q/10YaVzCZ8Kp2S+d1h4qPW6dKcWv6iuOQkWsE4nTQJ/pDwbCz4rQ4wtpzvWSuEk1b2A+
 hjctTEhRKoba+jfQtWwDa0sC8hckgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Move below instructions to decodetree specification :

	fcmp{u, o}		: X-form

The changes were verified by validating that the tcg ops generated by
those instructions remain the same, which were captured with the '-d
in_asm,op' flag.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250619095840.369351-3-rathc@linux.ibm.com
Message-ID: <20250619095840.369351-3-rathc@linux.ibm.com>
---
 target/ppc/helper.h                |  4 +--
 target/ppc/insn32.decode           |  5 ++++
 target/ppc/fpu_helper.c            |  4 +--
 target/ppc/translate/fp-impl.c.inc | 45 +++++++++---------------------
 target/ppc/translate/fp-ops.c.inc  |  2 --
 5 files changed, 22 insertions(+), 38 deletions(-)

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
index 0c7472d929..d446ec534d 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -592,6 +592,11 @@ FCFIDS          111011 ..... ----- ..... 1101001110 .   @X_tb_rc
 FCFIDU          111111 ..... ----- ..... 1111001110 .   @X_tb_rc
 FCFIDUS         111011 ..... ----- ..... 1111001110 .   @X_tb_rc
 
+### Floating-Point Compare Instructions
+
+FCMPU           111111 ... -- ..... ..... 0000000000 -  @X_bf
+FCMPO           111111 ... -- ..... ..... 0000100000 -  @X_bf
+
 ### Floating-Point Select Instruction
 
 FSEL            111111 ..... ..... ..... ..... 10111 .  @A
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
2.43.5


