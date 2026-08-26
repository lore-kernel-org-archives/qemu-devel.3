Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C7AC61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5uz-0000ZH-Bc; Wed, 26 Aug 2026 01:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5uy-0000W0-1x; Wed, 26 Aug 2026 01:11:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wz5uv-0005MG-Tx; Wed, 26 Aug 2026 01:11:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VWho2806128; Wed, 26 Aug 2026 05:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=w9RIMHFJMOzroU5/d
 ZTfwA4Jn+dbonVSgiwMd1MkDpg=; b=ECMnTOEv8S81IevXZ+9FPIo6rTNn1/VwE
 yjuuVotziW19z4hLjKpCnVByKHn4OIl4Hq0rjv/qGa9hFtbUuz9htMot4qkPZNYZ
 M6rneK/KWanmxLy70WDlUbD/Rco7vQQ0B0BI0dRaeR0DtCNXvaDnUFrRG/JGdVcn
 o/hTXW9qRCjP0vM6Tfu6wOvI4ScxKwUl32oG61PsixEP8zIxFd/0Uyi8UDDGpIfy
 flN2VcjdJ7fU/QfY6uP98tnBVkD6CGf0ma0gap8n/Lfw404PllM2dcjyEv4NGIni
 1JJTjwk00xvHEddNpXmu6ZeekvHtYiL4/FgETXvO0nW1YLN45RbRw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73944p05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4uKr7011656;
 Wed, 26 Aug 2026 05:11:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw8ate-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 05:11:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q5B9Dh42271028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 05:11:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EFD220043;
 Wed, 26 Aug 2026 05:11:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6578220040;
 Wed, 26 Aug 2026 05:11:04 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.124.215.63]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 05:11:02 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 14/37] target/ppc: Convert b{a, l, la} to decode tree
Date: Wed, 26 Aug 2026 10:38:40 +0530
Message-ID: <20260826050923.74756-15-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826050923.74756-1-rathc@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hcOVfZAINOMiwdtEgMQpqGUxPG1RxnwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfX9NW+WDQbD3dB
 EEXFnaO9xiRHWt1TgFTvGrMr+wMWuX/ci/lNH+QCN054E5LxWPCsJYLra9vmJ0zXXxA3dTTblVQ
 l5MHv7k5xymuGMFuw/paQEccLKD3psZMhLAvLjic3vKbT7Rf3PCVNOS2X3YsCONrK3XQD7KRXZK
 5TZ6lN6VybEPmtbDUOm54Y15ga70L+mB56cyHPHdyzmRYMMgbOTyWRak5+P/1/P61/aTLEvSPIc
 UoR3si9/Xt7q6d03ksuCxRuYcBc/JDoV+/fTpvr3vb4SanXps6E28LGWk1yNb3PND22rSOROR/I
 dWBPNpxUx0Q7RiTL81u2zuT4DRI39ZTrUx3RFoxqx464OI6C21ME+azqILrp5PMHUYo6ibnjrNs
 rJ/vGIuWJ2muaX2RB2GbOnsb3+woWZ54Ld9Z7ls8jH00g+hgSZn/JKZbbJWU8z5gxIfhffHrteh
 mfTCwDgmRDkwi8co27A==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8e7573 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=8uLd_aw9J8tj_XdJNvAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0MCBTYWx0ZWRfXy+quoE75POom
 BPZeDVg809syFkV1Oz4WFzZQriar7c9DuYryb/eZiXeqZrPSrFa0pYwM+glFM9MOuAqyz9w0h4F
 oVbcEEjMKsiSLAwt6S4YGcLOO7/OzQU=
X-Proofpoint-ORIG-GUID: Z4XK2QBJDG_epwO4ATbp6xRvdEeSXbtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260040
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

Convert b, ba, bl and bla to decode tree specification. The functionality
was tested by comparing the qemu -D log -d op,in_asm output as well as
single stepping gdb to confirm LR was correctly populated only when LK
is set.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode               |  7 +++++++
 target/ppc/internal.h                  |  7 -------
 target/ppc/translate.c                 | 24 ------------------------
 target/ppc/translate/branch-impl.c.inc | 24 ++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 91ece88a70..6a3254aaf6 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -1488,6 +1488,13 @@ MCRF            010011 ... -- ... -- ----- 00000 00000 -       @XL_bfa
 MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
 CLRBHRB         011111 ----- ----- ----- 0110101110 -
 
+# Branch Instructions
+%li             2:24 !function=times_4
+&I_b            li aa:bool lk:bool
+@I_b            ...... ........................ aa:1 lk:1 &I_b li=%li
+
+B               010010 ........................ . .  @I_b
+
 ## Misc POWER instructions
 
 ATTN            000000 00000 00000 00000 0100000000 0
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a3bb12afd9..a20a0f9f7e 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -197,13 +197,6 @@ EXTRACT_HELPER(L, 16, 2);
 EXTRACT_HELPER(WC, 21, 2);
 EXTRACT_HELPER(PL, 16, 2);
 
-/***                            Jump target decoding                       ***/
-/* Immediate address */
-static inline target_ulong LI(uint32_t opcode)
-{
-    return (opcode >> 0) & 0x03FFFFFC;
-}
-
 static inline uint32_t BD(uint32_t opcode)
 {
     return (opcode >> 0) & 0xFFFC;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a31cda4490..b528cab17d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3089,29 +3089,6 @@ static inline void gen_setlr(DisasContext *ctx, target_ulong nip)
     tcg_gen_movi_tl(cpu_lr, nip);
 }
 
-/* b ba bl bla */
-static void gen_b(DisasContext *ctx)
-{
-    target_ulong li, target;
-
-    /* sign extend LI */
-    li = LI(ctx->opcode);
-    li = (li ^ 0x02000000) - 0x02000000;
-    if (likely(AA(ctx->opcode) == 0)) {
-        target = ctx->cia + li;
-    } else {
-        target = li;
-    }
-    if (LK(ctx->opcode)) {
-        gen_setlr(ctx, ctx->base.pc_next);
-        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
-    } else {
-        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
-    }
-    gen_goto_tb(ctx, 0, target);
-    ctx->base.is_jmp = DISAS_NORETURN;
-}
-
 #define BCOND_IM  0
 #define BCOND_LR  1
 #define BCOND_CTR 2
@@ -5366,7 +5343,6 @@ GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
 /* ISA v3.0 changed the extended opcode from 62 to 30 */
 GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
 GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(b, 0x12, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bc, 0x10, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bcctr, 0x13, 0x10, 0x10, 0x00000000, PPC_FLOW),
 GEN_HANDLER(bclr, 0x13, 0x10, 0x00, 0x00000000, PPC_FLOW),
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index 9ade0c659a..745f71afd1 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -31,3 +31,27 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
     return true;
 }
 #endif
+
+static bool trans_B(DisasContext *ctx, arg_I_b *a)
+{
+    target_ulong target, li;
+
+    /* sign extend LI */
+    li = (a->li ^ 0x02000000) - 0x02000000;
+
+    if (likely(a->aa == 0)) {
+        target = ctx->cia + li;
+    } else {
+        target = li;
+    }
+    if (a->lk) {
+        gen_setlr(ctx, ctx->base.pc_next);
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_CALL);
+    } else {
+        gen_update_branch_history(ctx, ctx->cia, NULL, BHRB_TYPE_OTHER);
+    }
+    gen_goto_tb(ctx, 0, target);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    return true;
+}
-- 
2.55.0


