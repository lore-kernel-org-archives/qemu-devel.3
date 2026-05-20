Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426B2CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjTG-0008MG-AF; Wed, 20 May 2026 12:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjSm-0007zT-DU; Wed, 20 May 2026 12:08:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wPjSj-0002WI-Nx; Wed, 20 May 2026 12:08:04 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KF70Qm160368; Wed, 20 May 2026 16:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=kcPO1wA9LEbAbveDq
 qsB4Lr5Oazo6ZrtHW15PfmGbCs=; b=GXUmU6FNcmyAajr+vmFtv3iofmivQ1bdx
 BhaSsv+1TaknVsx/VMhuCBFPP8G3Gigq3vD9+Nq0oOkG10MIwJ/8E/G0hps+bNpm
 5WU+1GrCfBd38reWkVxkANxPOICc5Buk2cjWi1xkeIBTs+TRmQS1Ctx6loaKRAV2
 Mw0xnpm7bIJQAMtH0u2paOx1soYjjLN9rE35QGH5ih8iRiG/SOMa6UcmetvVioxO
 owKyJKLsRXE7rIgkrB5bXy7faX0eEN0/K7Mi8cB5C5+W5b+3qP/cfgAU7Z4/2F8E
 oTb+5WI+HpcjfCVW9KtlAJl9Vb9bbtJVrOHlq3M4gc8xdGEL4Lp3A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8hw50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:07:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFs5VN031770;
 Wed, 20 May 2026 16:07:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gfutb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 16:07:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64KG7swo49021220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 16:07:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73CC32004B;
 Wed, 20 May 2026 16:07:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62D6C20040;
 Wed, 20 May 2026 16:07:49 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.39.31.153]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 16:07:49 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com, nikhilks@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [RFC PATCH 01/28] target/ppc: Migrate extswsli to decodetree
Date: Wed, 20 May 2026 21:37:01 +0530
Message-ID: <20260520160728.2283628-2-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520160728.2283628-1-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NiBTYWx0ZWRfX4Y6TYBFMS5mo
 Od8QkLGyl4VBrZTDOaMnqGbZexq0N8HuFErc4Y/7jEqCRJYIEOxBgTuesFlcymamlMkNixYyUSj
 Ni+/MvT5HDZjLvHnqURDcBh9KDMmDq2spG3H/yw36lg2wuf2mEAIFdA2qHt0cRSBiJkpzSAB6Dh
 FQKs7Srx9ZMr4wpksFJvBTxUgoGXij7KGZlgG4Q/au0iBQYull3KTYdvm7T7nfOKKOsGKrjERJq
 gOi7cv5NtbUjmF6gIz4pUi3xPCPHB15nGkiY1fqaw5eEqYq/vBUowwHml4MGdEmZUWm/lYFBCDb
 aADmRJC9IrjPk8Wb9l9IphYs63sMwwnWYnNcVKyq0c8gs1tDblB1tGRhATae9F6WzXLib9+p7cX
 q+566dimVCOubeiHjRBB/UEH3QlNfkGYrOnOjkzkdShhReAPZymG1A10pMc+s5A3+AiwACRBMdy
 HfwtQECe0NRuQDNnHDA==
X-Proofpoint-GUID: _j454uwSG-hR1AHjXGxB7AbmI2oTT18A
X-Proofpoint-ORIG-GUID: a8txFWYPWUipmH9lSbHkKeC5fAnqdc81
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ddc5f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=5564cPbbYpJZlbqb9BIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
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

From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Move EXTSWSLI to decodetree using the XS-form layout with a custom
%xs_sh field to represent the fractured shift encoding.

This replaces legacy GEN_HANDLER-based implementations with a single
trans_EXTSWSLI() handler.

The implementation intentionally operates directly on the destination
GPR to preserve exact TCG output and avoid introducing temporary
variables, matching legacy behavior.

Testing:
  - Verified TCG equivalence with legacy implementation.

Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/insn32.decode |  8 ++++++++
 target/ppc/translate.c   | 43 ++++++++++++++--------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 0e9c68f2fb..342e65dadf 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -117,6 +117,11 @@
 &X_sa_rc        rs ra rc
 @X_sa_rc        ...... rs:5 ra:5 ..... .......... rc:1          &X_sa_rc
 
+# XS-form with fractured shift amount
+%xs_sh           1:1 11:5
+&XS              rs ra sh rc
+@XS              ...... rs:5 ra:5 ..... ......... . rc:1        &XS sh=%xs_sh
+
 %x_frtp         22:4 !function=times_2
 %x_frap         17:4 !function=times_2
 %x_frbp         12:4 !function=times_2
@@ -1301,6 +1306,9 @@ XVF64GERPN      111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
 XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
 XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
 
+##Extend Sign Word and Shift Left Immediate XS-form
+EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
+
 ## Vector Division Instructions
 
 VDIVSW          000100 ..... ..... ..... 00110001011    @VX
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3f6d326cef..e802414fca 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2470,30 +2470,6 @@ static void gen_sradi1(DisasContext *ctx)
     gen_sradi(ctx, 1);
 }
 
-/* extswsli & extswsli. */
-static inline void gen_extswsli(DisasContext *ctx, int n)
-{
-    int sh = SH(ctx->opcode) + (n << 5);
-    TCGv dst = cpu_gpr[rA(ctx->opcode)];
-    TCGv src = cpu_gpr[rS(ctx->opcode)];
-
-    tcg_gen_ext32s_tl(dst, src);
-    tcg_gen_shli_tl(dst, dst, sh);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, dst);
-    }
-}
-
-static void gen_extswsli0(DisasContext *ctx)
-{
-    gen_extswsli(ctx, 0);
-}
-
-static void gen_extswsli1(DisasContext *ctx)
-{
-    gen_extswsli(ctx, 1);
-}
-
 /* srd & srd. */
 static void gen_srd(DisasContext *ctx)
 {
@@ -5750,6 +5726,21 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
     return true;
 }
 
+static bool trans_EXTSWSLI(DisasContext *ctx, arg_XS *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+
+    /* Mimic legacy behavior: operate directly on dst */
+    tcg_gen_ext32s_tl(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+    tcg_gen_shli_tl(cpu_gpr[a->ra], cpu_gpr[a->ra], a->sh);
+
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
 #include "translate/fixedpoint-impl.c.inc"
 
 #include "translate/fp-impl.c.inc"
@@ -5850,10 +5841,6 @@ GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
 GEN_HANDLER2(sradi0, "sradi", 0x1F, 0x1A, 0x19, 0x00000000, PPC_64B),
 GEN_HANDLER2(sradi1, "sradi", 0x1F, 0x1B, 0x19, 0x00000000, PPC_64B),
 GEN_HANDLER(srd, 0x1F, 0x1B, 0x10, 0x00000000, PPC_64B),
-GEN_HANDLER2_E(extswsli0, "extswsli", 0x1F, 0x1A, 0x1B, 0x00000000,
-               PPC_NONE, PPC2_ISA300),
-GEN_HANDLER2_E(extswsli1, "extswsli", 0x1F, 0x1B, 0x1B, 0x00000000,
-               PPC_NONE, PPC2_ISA300),
 #endif
 /* handles lfdp, lxsd, lxssp */
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
-- 
2.53.0


