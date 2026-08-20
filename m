Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C70C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkx-0005Wc-3s; Wed, 19 Aug 2026 23:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkw-0005Ot-2X
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtku-0004II-EZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so2214454a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197671; x=1787802471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=msTYxKrfEGozy/cQf2TaV3I4p9p1A05eh8KT3o9m9rM=;
 b=L08OjMTvBAhxBqfBK56J7RK7s+PGS3MoXs69ROv1GXievAp0A5MFnmVnE2Z0NlMsrc
 5fhjNbHhx6bPkF4xXh97ikuqjen+v4CBKHrLHIUbSMmw39oOomGMUTbFF2Fbs/QS+k6j
 OmcJhPJ0vN1MJKjwsTkQIcVqc82iIUBTL+5OuQoFHPQ765JIc7l/UjTLoY2tyXLVFEom
 T4PESWdukXN19vIGZQ58WSeQRBLy4F3uXC5mGLoTNFMCKB0VBz93CQf3gq0W0rcp8+6v
 HVX8jtzx1ISfqDY47gdFxlqO+0+tpJhMfbJ9ZIiM3Q/TCEXFjOVCrouqq4RqfCz1FNeg
 Dj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197671; x=1787802471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=msTYxKrfEGozy/cQf2TaV3I4p9p1A05eh8KT3o9m9rM=;
 b=eMexpgN4wUEBQKoXHjsDqMgXyheLkMNbgChcV5ceNtB4r0n4OP40Oi6N1ufZSfLce8
 2t1enVkckzscdU5nTPL5tJkQXtt9g7bCZ3Z5+QDP44ly0sKRaYOuyr774SpUaPD+NC+4
 NNCRkREQTP0+qizmo2nQWmVF4ziqLBR0D+nW9cLTQsVU7eUdzJqR7lz5aez4agEwlwXV
 i1u0/7uK2GEvodgL/N0MhQDJ8nkVN1Jyln1NJi2RggPgoptACG2RxBmk9XXZVWZhESLc
 qKY9AC5Hv5VOtyJeXXXtkChSPYJMo2K2Cg4va4zhmSucbIwsXRYUlvKpsFT+XkhDdYK/
 sNSA==
X-Gm-Message-State: AFuF++nlwEme9qv57jvHHeVLMVZn2bWnXZZyMHbAdyyZEyk44zLv9KtC
 57HDpYpdqUUZv3lFTIHBjDPvm3wPGSmAsauq9nwKfsQahFcC07NTYZMb1+wzhQ==
X-Gm-Gg: AR+sD13hvVx5w3H6j5PIXBVXMxaJMOWptSsjxG8YVFjrPbnjAYBhRh+hxeOogQcg132
 adI5yumHWV3ffctdM0MeICpNcmKa8b7o0820sjLlZIfMp4rObYkvDLZfKMQYDJgx/q5a68ZRXtu
 wbjHbCZc1h3zqAnvlOtdmu8cl+/CQU/DV/TYs9FkFIvveXFbMXc1UsRu/IYcBPmjgtsxc45gc+q
 NZffQsNq+3PB2PCPjQKKjPY8uj4YpRy5HKlJtrnSn4o09KFPMjSzENhwW7YS9Nua7t42Aa+foVv
 CQ1A4jok8mU2Wg+0/P8zVZzxlONsrGSdafN5gZ4RfhHimXatHcON6lQQLJX+PTK+a7dbTLJj6+j
 iRK8QZI5K4SsP4UUiCNXrdmbo57YGRfoMaEdsketlhKV7WOSSc6RrFX+1ri6mPXpkON6PIslXgO
 PZnkgob9FEfqGjs3yFuVGMNgmL/MvV3HcLPJaQTHMlbvWwtoB8xZa8YQUlVGttYrJBrVi7kaCwV
 p0TsA==
X-Received: by 2002:a17:90b:1a8f:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-3958125a864mr17530263a91.15.1787197671121; 
 Wed, 19 Aug 2026 20:47:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 65/93] disas/riscv: Tidy rv_comp_data terminators
Date: Thu, 20 Aug 2026 13:44:02 +1000
Message-ID: <20260820034430.1186695-66-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Use { } instead of two zeros.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-30-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e0b3d22031..f3c9213fd1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1072,123 +1072,123 @@ static const rvc_constraint rvcc_true[] = { rvc_end };
 static const rv_comp_data rvcp_jal[] = {
     { rv_op_j, rvcc_j },
     { rv_op_jal_ra, rvcc_jal_ra },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_jalr[] = {
     { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
     { rv_op_jalr_ra, rvcc_jalr_ra },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_beq[] = {
     { rv_op_beqz, rvcc_beqz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_bne[] = {
     { rv_op_bnez, rvcc_bnez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_blt[] = {
     { rv_op_bltz, rvcc_bltz },
     { rv_op_bgtz, rvcc_bgtz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_bge[] = {
     { rv_op_blez, rvcc_blez },
     { rv_op_bgez, rvcc_bgez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_addi[] = {
     { rv_op_nop, rvcc_nop },
     { rv_op_mv, rvcc_mv },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sltiu[] = {
     { rv_op_seqz, rvcc_seqz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_xori[] = {
     { rv_op_not, rvcc_not },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sub[] = {
     { rv_op_neg, rvcc_neg },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_slt[] = {
     { rv_op_sltz, rvcc_sltz },
     { rv_op_sgtz, rvcc_sgtz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sltu[] = {
     { rv_op_snez, rvcc_snez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_addiw[] = {
     { rv_op_sext_w, rvcc_sext_w },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_subw[] = {
     { rv_op_negw, rvcc_negw },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_s[] = {
     { rv_op_fmv_s, rvcc_fmv_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_s[] = {
     { rv_op_fneg_s, rvcc_fneg_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_s[] = {
     { rv_op_fabs_s, rvcc_fabs_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_d[] = {
     { rv_op_fmv_d, rvcc_fmv_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_d[] = {
     { rv_op_fneg_d, rvcc_fneg_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_d[] = {
     { rv_op_fabs_d, rvcc_fabs_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_q[] = {
     { rv_op_fmv_q, rvcc_fmv_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_q[] = {
     { rv_op_fneg_q, rvcc_fneg_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_q[] = {
     { rv_op_fabs_q, rvcc_fabs_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 /* Convert compressed insns into normal insns via pseudo expansion. */
-- 
2.54.0


