Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F296C4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjzAl-0006dH-8v; Wed, 15 Jul 2026 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAk-0006d5-Ip; Wed, 15 Jul 2026 08:57:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wjzAi-0001Cg-V2; Wed, 15 Jul 2026 08:57:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FBfn8L2371197; Wed, 15 Jul 2026 12:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HeTmpvF9GLKHG27Fm
 9rVuMFdkb5p8e+LI1ML6sb1T1s=; b=IFF5prBSHhrg5cBs9zTmi/hgCcWdpE5bg
 KKPubj0iqNEWdpj3SDlDRye+MDOWZGcCTXegT70slQO/exdGAL9gZYxXcIYYQw8o
 ckbU6w51V0aTmFX2/e8x1woQw8UW60zTkbvEZ15X/6A49mhJbFu13JjkY2XxOWGg
 WNTIU5BCsYgBviQdnYJ5/D3PVk4nwi7RjeyTc+oPIUi5TpjOCPGtlz8NEOL1J4tj
 m7y+OTh6PTLGxnZHZUGB75qEgBdnwWxz4+YRQqYMNyU1pVTtJ3O8KeqGRpiUzRCG
 BW0r7Y+YzsxEK3aSHTyQRUHcICiHTpwPlBKBkJhLnvqr8OpFDU7fA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33c5d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:57:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FCnimn011087;
 Wed, 15 Jul 2026 12:57:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q8972-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 12:57:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66FCv1bb48628128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 12:57:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 164D92004B;
 Wed, 15 Jul 2026 12:57:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 609C82004D;
 Wed, 15 Jul 2026 12:56:57 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.30.15]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2026 12:56:57 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, tommusta@gmail.com
Cc: richard.henderson@linaro.org, milesg@linux.ibm.com, shivangu@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH 3/7] target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
Date: Wed, 15 Jul 2026 18:26:30 +0530
Message-ID: <20260715125634.2107320-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715125634.2107320-1-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfX6dYFSgzYosr3
 DievOp63u+9KLOoB7IcJE7/CqU/QRoNdY6Imku8tnDwXRcJcxQVfnr41ahDrQ/VH+i5I8SWH8xj
 N1ftHQ5iJwwfw4vUR8Z04e9SOdfOM9M=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5783a1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=nQ85-MmU5D-d4o_ZYwcA:9
X-Proofpoint-GUID: -I8yhzb50_ZJ0Je9YtWJv5pVcf-jWMyc
X-Proofpoint-ORIG-GUID: xWwyIAyf1NqEvOB0Idst2kw9xAdfVHT-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNiBTYWx0ZWRfX5+ajmbqFRvq+
 xaqtHACvGHZSUFhZr70k6LRg/T9nKJp0+lKQTBCksD3PCJm39EcPfWH5ZIGfPaI6JeP73RZ9HFA
 KeZR1ZpZS/ghbYLWXhAGQLi4KU+2ZJN1YG2izc7gVtdIxbTWGzSlGrAuWjMn6EqtsEcB2MtZ/Gm
 NXNeMKmHvOQm4fXfNc7y5GQv+/zLt36+tLiNHj90qIeYVJxBsxikYwJXJflj+hi2Hde6udSOUg2
 nLVzr6AdLdupZuhvLjkDqLmff1YfYiNpIJ4KOU0HMlYMK29DChaHA25BwrX3R9Uec2pTOb72YH4
 ecZZfCyYwo5VS/uWg+j0oF0JpOIsAuv0uETu05OnKCA07uvK3c9iRsw5vFDo+Pg5VuLdGHejk5l
 +cuKEI7w3zYCgjvKdVFmdZrBbjZIucICfgebg7b7WwQWpVZYmsfnOE9sYBLPpMvxK+fbXEA2s2C
 DLZm5g/sdFY9Vi8sWcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

PPC2_LSQ_ISA207 is only ever set in the CPUPPCState's insns_flags2
alongside PPC2_ISA207. Checks made by PPC2_LSQ_ISA207 could be
replaced with PPC2_ISA207, hence rendering is useless and apt for
removal. This patch does the same.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 linux-user/ppc/elfload.c                   | 2 +-
 target/ppc/cpu.h                           | 3 ---
 target/ppc/cpu_init.c                      | 3 +--
 target/ppc/cpu_init.h                      | 2 +-
 target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 5c6065e08a..76ab9f43de 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -116,7 +116,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
 
     GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
-    GET_FEATURE2((PPC2_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+    GET_FEATURE2((PPC2_ISA207 | PPC2_ALTIVEC_207 |
                   PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
                   QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
     GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index df1e943d8d..b3cd8d85df 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2577,8 +2577,6 @@ enum {
     PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
     /* ISA 2.06B floating point test instructions                            */
     PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
-    /* ISA 2.07 load/store quadword                                          */
-    PPC2_LSQ_ISA207    = 0x0000000000002000ULL,
     /* ISA 2.07 Altivec                                                      */
     PPC2_ALTIVEC_207   = 0x0000000000004000ULL,
     /* PowerISA 2.07 Book3s specification                                    */
@@ -2608,7 +2606,6 @@ enum {
                         PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
                         PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
-                        PPC2_LSQ_ISA207 | \
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index be8b3c447d..9b0d19ba20 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6349,8 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
     pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 |
-                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
+                        PPC2_FP_TST_ISA206 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
                         PPC2_BCDA_ISA206;
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 7dd587908e..6961007926 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -18,7 +18,7 @@
     (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
      PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
      PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
-     PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
+     PPC2_ALTIVEC_207 | PPC2_ISA205 |                                \
      PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
      PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
 
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 9c7c754db1..6e4c8c34b3 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -116,7 +116,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
 
     REQUIRE_INSNS_FLAGS(ctx, 64BX);
 
-    if (!prefixed && !(ctx->insns_flags2 & PPC2_LSQ_ISA207)) {
+    if (!prefixed && !(ctx->insns_flags2 & PPC2_ISA207)) {
         /* lq and stq were privileged prior to V. 2.07 */
         REQUIRE_SV(ctx);
 
@@ -280,7 +280,7 @@ TRANS64(STDCX, do_store_cond, MO_UQ);
 static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
 {
     REQUIRE_64BIT(ctx);
-    REQUIRE_INSNS_FLAGS2(ctx, LSQ_ISA207);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
 #if defined(TARGET_PPC64)
     TCGLabel *lfail = gen_new_label();
     TCGv ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
-- 
2.53.0


