Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF36C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpm0-00007R-GS; Fri, 28 Aug 2026 02:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzply-0008Va-VM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplw-00011i-03
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S225O5596413; Fri, 28 Aug 2026 06:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=G/iRB1WUKx2G0NNeJ
 01VQQv48bZVSRk51nk4Twce2ZU=; b=KBL0kFx4h6Zxdgw6QrJ+Gj6RjoTMCLTHG
 MC7FYhOaB6wN0i3RcKnQdSA+Okt0m77I2hr0F8PsBvEwm0O7xeGXAPCs93mnKnLN
 jkcQ0/Q+cwABvNa+bylBhd2pTQhQvzT9OXiEus2LvTmuWcIfzRuMbZeC/47/lNeE
 d+GCKaohRA4WaN3tgzYngOIWwWXClZiGTKPav4OxJ4v2Mmfvp/xSIBzxGqNML5dE
 ay3Z6QJP1p+HiGdca2Y7IVgpBagO2BsYhNhdQ9IKxNX25gjpN5e9fobZq8Q+bILB
 CxSe2RmY6/RpAkycOMlOfRx2B8ybnjHNVnbU2YuRJjhVKJsKV6H7g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394je9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:09:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uITh019166;
 Fri, 28 Aug 2026 06:09:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kcmbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 06:09:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68uC147120742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BFA520043;
 Fri, 28 Aug 2026 06:08:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08E9F20040;
 Fri, 28 Aug 2026 06:08:54 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:53 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 34/41] target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
Date: Fri, 28 Aug 2026 11:37:09 +0530
Message-ID: <20260828060716.91672-35-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PVXvapwoNNgUsnv27DjaS_1mV7NDMzzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX6iQkVs0rAybY
 s7j2PqEwVFTFNqXicZ+YH3jEQXVbB3fUrOWS7JnTJEZ3SaDkmaE+noeq5plAvwmZZEkZQ/5G9Mb
 /+TwUZHh3AorDPNpRGGXR9ZO0PETcYmpeb53KBeY00VBKsElGrhu9lf0rmpmiPQoQBkK1ZBHn7Z
 mGjnBUKr/gthpV4phpdxjz2G6T6y82VumCihhqar3Jjn9Rc2ShYZV7ERYZeiVHgSbZNHzkB4Bp6
 KRFivN/NG1vxBXTA4D7YHCYGeuXGfSN8tDhvFSVUJyeojADrkHhrtyKiCaMRsOhD0+5MlNq9RUM
 0JqezQLtLZC4LVDvLxogV4W3rdT32tKqhBMrhe3zcj+TOj9/0RFvwBKCQCFRDIhU6cM5zOfAetQ
 6m9fpRVRRNOqpgqQIxCJ4s9DfHmN2OzEFGRqnMnAPDpV3+Vfc+12nJH/g2NJ3VOgWKpuY/xtzlz
 7BV8buR1rbUiYevH4kQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9125fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=cNgVSLs5fDz-aCfjPlgA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX8w75ITNLqv0c
 UCc9qTZkDu8GizwSpZlsxvjvaPKYG+tvtqO85yo8lR+ogXPWrDGG5oRUjHQQNihStmY+cqvZ6zS
 1Iv1q66twqtqEhKycNj3W/zJbMeYLas=
X-Proofpoint-ORIG-GUID: PVXvapwoNNgUsnv27DjaS_1mV7NDMzzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Chinmay Rath <rathc@linux.ibm.com>

There are several flags for Power ISA 2.07 currently in use, namely :
PPC2_VSX207, PPC2_BCTAR_ISA207, PPC2_LSQ_ISA207, etc, but most of them
are used together without any individual use.

Create a generic ISA 2.07 flag and switch usage of PPC2_VSX207 to it
instead. Next commits would consolidate the remaining flags.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-31-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/cpu.h                    |  6 ++--
 target/ppc/cpu_init.h               |  2 +-
 target/ppc/cpu_init.c               |  2 +-
 target/ppc/translate/fp-impl.c.inc  |  4 +--
 target/ppc/translate/vsx-impl.c.inc | 56 ++++++++++++++---------------
 target/ppc/translate/vsx-ops.c.inc  | 24 ++++++-------
 6 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cbd5964b1a..91ef34cb21 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2565,8 +2565,8 @@ enum {
     PPC2_DBRX          = 0x0000000000000010ULL,
     /* Book I 2.05 PowerPC specification                                     */
     PPC2_ISA205        = 0x0000000000000020ULL,
-    /* VSX additions in ISA 2.07                                             */
-    PPC2_VSX207        = 0x0000000000000040ULL,
+    /* POWER ISA 2.07                                                        */
+    PPC2_ISA207        = 0x0000000000000040ULL,
     /* ISA 2.06B bpermd                                                      */
     PPC2_PERM_ISA206   = 0x0000000000000080ULL,
     /* ISA 2.06B divide extended variants                                    */
@@ -2607,7 +2607,7 @@ enum {
     PPC2_PPE42XM       = 0x0000000002000000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
-                        PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \
+                        PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
                         PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
                         PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index f8fd6ff5cd..1c41c0d349 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -15,7 +15,7 @@
 #define PPC_INSNS_FLAGS_POWER11 PPC_INSNS_FLAGS_POWER10
 
 #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
-    (PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
+    (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
      PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
      PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
      PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index e2533481d8..b913edd243 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6346,7 +6346,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
                        PPC_SEGMENT_64B | PPC_SLBI |
                        PPC_POPCNTB | PPC_POPCNTWD |
                        PPC_CILDST;
-    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
+    pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 464fb1d90f..e0d9fa2e24 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -342,7 +342,7 @@ static bool trans_FCPSGN(DisasContext *ctx, arg_FCPSGN *a)
 static bool trans_FMRGEW(DisasContext *ctx, arg_FMRGEW *a)
 {
     TCGv_i64 t0, t1, t2;
-    REQUIRE_INSNS_FLAGS2(ctx, VSX207);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
     REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
@@ -358,7 +358,7 @@ static bool trans_FMRGEW(DisasContext *ctx, arg_FMRGEW *a)
 static bool trans_FMRGOW(DisasContext *ctx, arg_FMRGOW *a)
 {
     TCGv_i64 t0, t1, t2;
-    REQUIRE_INSNS_FLAGS2(ctx, VSX207);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
     REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 00ad57c628..78311dcba9 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -50,11 +50,11 @@ static bool do_lxs(DisasContext *ctx, arg_X *a,
 }
 
 TRANS_FLAGS2(VSX, LXSDX, do_lxs, gen_qemu_ld64_i64);
-TRANS_FLAGS2(VSX207, LXSIWAX, do_lxs, gen_qemu_ld32s_i64);
+TRANS_FLAGS2(ISA207, LXSIWAX, do_lxs, gen_qemu_ld32s_i64);
 TRANS_FLAGS2(ISA300, LXSIBZX, do_lxs, gen_qemu_ld8u_i64);
 TRANS_FLAGS2(ISA300, LXSIHZX, do_lxs, gen_qemu_ld16u_i64);
-TRANS_FLAGS2(VSX207, LXSIWZX, do_lxs, gen_qemu_ld32u_i64);
-TRANS_FLAGS2(VSX207, LXSSPX, do_lxs, gen_qemu_ld32fs);
+TRANS_FLAGS2(ISA207, LXSIWZX, do_lxs, gen_qemu_ld32u_i64);
+TRANS_FLAGS2(ISA207, LXSSPX, do_lxs, gen_qemu_ld32fs);
 
 static bool trans_LXVD2X(DisasContext *ctx, arg_LXVD2X *a)
 {
@@ -304,8 +304,8 @@ static bool do_stxs(DisasContext *ctx, arg_X *a,
 TRANS_FLAGS2(VSX, STXSDX, do_stxs, gen_qemu_st64_i64);
 TRANS_FLAGS2(ISA300, STXSIBX, do_stxs, gen_qemu_st8_i64);
 TRANS_FLAGS2(ISA300, STXSIHX, do_stxs, gen_qemu_st16_i64);
-TRANS_FLAGS2(VSX207, STXSIWX, do_stxs, gen_qemu_st32_i64);
-TRANS_FLAGS2(VSX207, STXSSPX, do_stxs, gen_qemu_st32fs);
+TRANS_FLAGS2(ISA207, STXSIWX, do_stxs, gen_qemu_st32_i64);
+TRANS_FLAGS2(ISA207, STXSSPX, do_stxs, gen_qemu_st32fs);
 
 static bool trans_STXVD2X(DisasContext *ctx, arg_STXVD2X *a)
 {
@@ -988,7 +988,7 @@ GEN_VSX_HELPER_R2_AB(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300)
 GEN_VSX_HELPER_X2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_R2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
-GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
+GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_ISA207)
 GEN_VSX_HELPER_R2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xscvqpudz, 0x04, 0x1A, 0x11, PPC2_ISA300)
@@ -1185,7 +1185,7 @@ bool trans_XSCVSPDPN(DisasContext *ctx, arg_XX2 *a)
 {
     TCGv_i64 tmp;
 
-    REQUIRE_INSNS_FLAGS2(ctx, VSX207);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
     REQUIRE_VSX(ctx);
 
     tmp = tcg_temp_new_i64();
@@ -1210,16 +1210,16 @@ GEN_VSX_HELPER_X2(xsrdpic, 0x16, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpim, 0x12, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpip, 0x12, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
+GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_ISA207)
 GEN_VSX_HELPER_R2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 GEN_VSX_HELPER_R3(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
-GEN_VSX_HELPER_X2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X2(xsresp, 0x14, 0x01, 0, PPC2_ISA207)
+GEN_VSX_HELPER_X2(xssqrtsp, 0x16, 0x00, 0, PPC2_ISA207)
+GEN_VSX_HELPER_X2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_ISA207)
+GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_ISA207)
+GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_ISA207)
 
 GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
@@ -1409,14 +1409,14 @@ TRANS_FLAGS2(VSX, XSNMADDADP, do_xsmadd_XX3, true, gen_helper_XSNMADDDP)
 TRANS_FLAGS2(VSX, XSNMADDMDP, do_xsmadd_XX3, false, gen_helper_XSNMADDDP)
 TRANS_FLAGS2(VSX, XSNMSUBADP, do_xsmadd_XX3, true, gen_helper_XSNMSUBDP)
 TRANS_FLAGS2(VSX, XSNMSUBMDP, do_xsmadd_XX3, false, gen_helper_XSNMSUBDP)
-TRANS_FLAGS2(VSX207, XSMADDASP, do_xsmadd_XX3, true, gen_helper_XSMADDSP)
-TRANS_FLAGS2(VSX207, XSMADDMSP, do_xsmadd_XX3, false, gen_helper_XSMADDSP)
-TRANS_FLAGS2(VSX207, XSMSUBASP, do_xsmadd_XX3, true, gen_helper_XSMSUBSP)
-TRANS_FLAGS2(VSX207, XSMSUBMSP, do_xsmadd_XX3, false, gen_helper_XSMSUBSP)
-TRANS_FLAGS2(VSX207, XSNMADDASP, do_xsmadd_XX3, true, gen_helper_XSNMADDSP)
-TRANS_FLAGS2(VSX207, XSNMADDMSP, do_xsmadd_XX3, false, gen_helper_XSNMADDSP)
-TRANS_FLAGS2(VSX207, XSNMSUBASP, do_xsmadd_XX3, true, gen_helper_XSNMSUBSP)
-TRANS_FLAGS2(VSX207, XSNMSUBMSP, do_xsmadd_XX3, false, gen_helper_XSNMSUBSP)
+TRANS_FLAGS2(ISA207, XSMADDASP, do_xsmadd_XX3, true, gen_helper_XSMADDSP)
+TRANS_FLAGS2(ISA207, XSMADDMSP, do_xsmadd_XX3, false, gen_helper_XSMADDSP)
+TRANS_FLAGS2(ISA207, XSMSUBASP, do_xsmadd_XX3, true, gen_helper_XSMSUBSP)
+TRANS_FLAGS2(ISA207, XSMSUBMSP, do_xsmadd_XX3, false, gen_helper_XSMSUBSP)
+TRANS_FLAGS2(ISA207, XSNMADDASP, do_xsmadd_XX3, true, gen_helper_XSNMADDSP)
+TRANS_FLAGS2(ISA207, XSNMADDMSP, do_xsmadd_XX3, false, gen_helper_XSNMADDSP)
+TRANS_FLAGS2(ISA207, XSNMSUBASP, do_xsmadd_XX3, true, gen_helper_XSNMSUBSP)
+TRANS_FLAGS2(ISA207, XSNMSUBMSP, do_xsmadd_XX3, false, gen_helper_XSNMSUBSP)
 
 static bool do_xsmadd_X(DisasContext *ctx, arg_X_rc *a,
         void (*gen_helper)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr),
@@ -1590,9 +1590,9 @@ TRANS_FLAGS2(VSX, XXLANDC, do_logical_op, MO_64, tcg_gen_gvec_andc);
 TRANS_FLAGS2(VSX, XXLOR, do_logical_op, MO_64, tcg_gen_gvec_or);
 TRANS_FLAGS2(VSX, XXLXOR, do_logical_op, MO_64, tcg_gen_gvec_xor);
 TRANS_FLAGS2(VSX, XXLNOR, do_logical_op, MO_64, tcg_gen_gvec_nor);
-TRANS_FLAGS2(VSX207, XXLEQV, do_logical_op, MO_64, tcg_gen_gvec_eqv);
-TRANS_FLAGS2(VSX207, XXLNAND, do_logical_op, MO_64, tcg_gen_gvec_nand);
-TRANS_FLAGS2(VSX207, XXLORC, do_logical_op, MO_64, tcg_gen_gvec_orc);
+TRANS_FLAGS2(ISA207, XXLEQV, do_logical_op, MO_64, tcg_gen_gvec_eqv);
+TRANS_FLAGS2(ISA207, XXLNAND, do_logical_op, MO_64, tcg_gen_gvec_nand);
+TRANS_FLAGS2(ISA207, XXLORC, do_logical_op, MO_64, tcg_gen_gvec_orc);
 
 #define VSX_XXMRG(name, high)                               \
 static void glue(gen_, name)(DisasContext *ctx)             \
@@ -2682,10 +2682,10 @@ TRANS_FLAGS2(ISA300, XSMINCDP, do_helper_XX3, gen_helper_XSMINCDP)
 TRANS_FLAGS2(ISA300, XSMAXJDP, do_helper_XX3, gen_helper_XSMAXJDP)
 TRANS_FLAGS2(ISA300, XSMINJDP, do_helper_XX3, gen_helper_XSMINJDP)
 
-TRANS_FLAGS2(VSX207, XSADDSP, do_helper_XX3, gen_helper_XSADDSP)
-TRANS_FLAGS2(VSX207, XSSUBSP, do_helper_XX3, gen_helper_XSSUBSP)
-TRANS_FLAGS2(VSX207, XSMULSP, do_helper_XX3, gen_helper_XSMULSP)
-TRANS_FLAGS2(VSX207, XSDIVSP, do_helper_XX3, gen_helper_XSDIVSP)
+TRANS_FLAGS2(ISA207, XSADDSP, do_helper_XX3, gen_helper_XSADDSP)
+TRANS_FLAGS2(ISA207, XSSUBSP, do_helper_XX3, gen_helper_XSSUBSP)
+TRANS_FLAGS2(ISA207, XSMULSP, do_helper_XX3, gen_helper_XSMULSP)
+TRANS_FLAGS2(ISA207, XSDIVSP, do_helper_XX3, gen_helper_XSDIVSP)
 
 TRANS_FLAGS2(VSX, XSADDDP, do_helper_XX3, gen_helper_XSADDDP)
 TRANS_FLAGS2(VSX, XSSUBDP, do_helper_XX3, gen_helper_XSSUBDP)
diff --git a/target/ppc/translate/vsx-ops.c.inc b/target/ppc/translate/vsx-ops.c.inc
index e553b5b8fa..ae3df2c13d 100644
--- a/target/ppc/translate/vsx-ops.c.inc
+++ b/target/ppc/translate/vsx-ops.c.inc
@@ -1,9 +1,9 @@
-GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(mtvsrwz, 0x1F, 0x13, 0x07, 0x0000F800, PPC_NONE, PPC2_VSX207),
+GEN_HANDLER_E(mfvsrwz, 0x1F, 0x13, 0x03, 0x0000F800, PPC_NONE, PPC2_ISA207),
+GEN_HANDLER_E(mtvsrwa, 0x1F, 0x13, 0x06, 0x0000F800, PPC_NONE, PPC2_ISA207),
+GEN_HANDLER_E(mtvsrwz, 0x1F, 0x13, 0x07, 0x0000F800, PPC_NONE, PPC2_ISA207),
 #if defined(TARGET_PPC64)
-GEN_HANDLER_E(mfvsrd, 0x1F, 0x13, 0x01, 0x0000F800, PPC_NONE, PPC2_VSX207),
-GEN_HANDLER_E(mtvsrd, 0x1F, 0x13, 0x05, 0x0000F800, PPC_NONE, PPC2_VSX207),
+GEN_HANDLER_E(mfvsrd, 0x1F, 0x13, 0x01, 0x0000F800, PPC_NONE, PPC2_ISA207),
+GEN_HANDLER_E(mtvsrd, 0x1F, 0x13, 0x05, 0x0000F800, PPC_NONE, PPC2_ISA207),
 GEN_HANDLER_E(mfvsrld, 0X1F, 0x13, 0x09, 0x0000F800, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(mtvsrdd, 0X1F, 0x13, 0x0D, 0x0, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(mtvsrws, 0x1F, 0x13, 0x0C, 0x0000F800, PPC_NONE, PPC2_ISA300),
@@ -127,7 +127,7 @@ GEN_VSX_XFORM_300(xscmpoqp, 0x04, 0x04, 0x00600001),
 GEN_VSX_XFORM_300(xscmpuqp, 0x04, 0x14, 0x00600001),
 GEN_XX2FORM_EO(xscvdphp, 0x16, 0x15, 0x11, PPC2_ISA300),
 GEN_XX2FORM(xscvdpsp, 0x12, 0x10, PPC2_VSX),
-GEN_XX2FORM(xscvdpspn, 0x16, 0x10, PPC2_VSX207),
+GEN_XX2FORM(xscvdpspn, 0x16, 0x10, PPC2_ISA207),
 GEN_XX2FORM_EO(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300),
 GEN_VSX_XFORM_300_EO(xscvsdqp, 0x04, 0x1A, 0x0A, 0x00000001),
 GEN_XX2FORM(xscvspdp, 0x12, 0x14, PPC2_VSX),
@@ -145,12 +145,12 @@ GEN_XX2FORM(xsrdpip, 0x12, 0x06, PPC2_VSX),
 GEN_XX2FORM(xsrdpiz, 0x12, 0x05, PPC2_VSX),
 
 GEN_VSX_XFORM_300(xsdivqp, 0x04, 0x11, 0x0),
-GEN_XX2FORM(xsresp,  0x14, 0x01, PPC2_VSX207),
-GEN_XX2FORM(xsrsp, 0x12, 0x11, PPC2_VSX207),
-GEN_XX2FORM(xssqrtsp,  0x16, 0x00, PPC2_VSX207),
-GEN_XX2FORM(xsrsqrtesp,  0x14, 0x00, PPC2_VSX207),
-GEN_XX2FORM(xscvsxdsp, 0x10, 0x13, PPC2_VSX207),
-GEN_XX2FORM(xscvuxdsp, 0x10, 0x12, PPC2_VSX207),
+GEN_XX2FORM(xsresp,  0x14, 0x01, PPC2_ISA207),
+GEN_XX2FORM(xsrsp, 0x12, 0x11, PPC2_ISA207),
+GEN_XX2FORM(xssqrtsp,  0x16, 0x00, PPC2_ISA207),
+GEN_XX2FORM(xsrsqrtesp,  0x14, 0x00, PPC2_ISA207),
+GEN_XX2FORM(xscvsxdsp, 0x10, 0x13, PPC2_ISA207),
+GEN_XX2FORM(xscvuxdsp, 0x10, 0x12, PPC2_ISA207),
 
 GEN_XX2FORM(xvredp,  0x14, 0x0D, PPC2_VSX),
 GEN_XX2FORM(xvsqrtdp,  0x16, 0x0C, PPC2_VSX),
-- 
2.52.0


