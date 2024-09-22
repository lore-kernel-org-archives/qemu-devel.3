Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCFCF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHj-0001pZ-OM; Sun, 22 Sep 2024 08:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHL-0000vv-ON
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:33 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHH-0002O1-Sx
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:26 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c42384c517so4354267a12.3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006482; x=1727611282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wC8NJvzs4xm1iFMunKJrmEEYWEWZeuBA49NgWvG2FqE=;
 b=rKPiyRQ1kiwfqHh5tDcwj1gWjpAvm0zjGP8f6kzYEJ/WEoBsz8SXEsyrXMmb7WLdfJ
 R20Mm6LgBQuBiRosJALADU3HiS9SABJdIswX+EwvKFFju94WdulJ9J2ZjC5mwzjAIGBR
 sTox+BE9RmlR2dpNpgr7rM+ZAtcPywfrGMxTB9/BlDHuJLF2AsGqGiDZNb4noIPdhO1N
 LSSnJkexAlQYuLQMk+R0XEZs11a1242U0NLPV2UmQJAbmQP2/PGyXQQ64oOCcF0yi7Wj
 2WVb+d7rFXLz5Kqa8K+JgB4x5Pacjd93Ws8nkapW2gUSdhzusCHBnCAaJUxiHfuD7gYR
 lpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006482; x=1727611282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wC8NJvzs4xm1iFMunKJrmEEYWEWZeuBA49NgWvG2FqE=;
 b=ZwW1TPOfZdmAOnTRvFlBDO51qM6d+abrQX3ITG1ir83+qOaE6XcQ+qfLkmnSXbX9k8
 vRcdor8R7ndo19IgNNp8+kJrW6cTk23vGraAWDjIV3Kb8udjcCH2z0FFcxqXlgq6Zg/t
 z/H8wH5l137TH1soqpz5zPKx9v/p83Aggs+E4mS7KIWRfEXr1nHYs2U7e60Wpe6QXvzq
 XE8T7Hep0BTQB5Bmz7xmsFjweOJYnsw6/0SeQGc/RSFAdUrDVcbFRGlVXlQkeSLCCEbz
 UIfjMQy/k29g5cHw+leTyx+AtLpj7UEDFNWkpmG7P1R2HPN5/ZUtTPFClUQJnAux7XWJ
 f6XA==
X-Gm-Message-State: AOJu0Yw+LfefqnrmIdJ7t0/NQXuIshEIC1NiKBMf5ZIetnvUXuPPQPE2
 fCd9blXk8DSVmg9CNMWYAAPkjknWH4OobY5bd5Wy3wuZqrh1QRRZsUe3j5tDVJkGCP9DrjJo+M1
 2KJM=
X-Google-Smtp-Source: AGHT+IEEECOMDBBeoR8stvilyVAV3hx4s6NM/ob+J6D8P752AmVU0BTLM50gJMIQ0F0/N9wqN33nDQ==
X-Received: by 2002:a17:907:f763:b0:a8d:7210:e295 with SMTP id
 a640c23a62f3a-a90d549c41cmr722351566b.10.1727006482198; 
 Sun, 22 Sep 2024 05:01:22 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 14/31] tcg/i386: Implement cmp_vec with avx512 insns
Date: Sun, 22 Sep 2024 14:00:55 +0200
Message-ID: <20240922120112.5067-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The sse/avx instruction set only has EQ and GT as direct comparisons.
Other signed comparisons can be generated from swapping and inversion.
However unsigned comparisons are not available and must be transformed
to signed comparisons by biasing the inputs.

The avx512 instruction set has a complete set of comparisons, with
results placed into a predicate register.  We can produce the normal
cmp_vec result by using VPMOVM2*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 64 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 210389955d..b1d642fc67 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -413,6 +413,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_UD2         (0x0b | P_EXT)
 #define OPC_VPBLENDD    (0x02 | P_EXT3A | P_DATA16)
 #define OPC_VPBLENDVB   (0x4c | P_EXT3A | P_DATA16)
+#define OPC_VPCMPB      (0x3f | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPUB     (0x3e | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPW      (0x3f | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPCMPUW     (0x3e | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPCMPD      (0x1f | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPUD     (0x1e | P_EXT3A | P_DATA16 | P_EVEX)
+#define OPC_VPCMPQ      (0x1f | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
+#define OPC_VPCMPUQ     (0x1e | P_EXT3A | P_DATA16 | P_VEXW | P_EVEX)
 #define OPC_VPINSRB     (0x20 | P_EXT3A | P_DATA16)
 #define OPC_VPINSRW     (0xc4 | P_EXT | P_DATA16)
 #define OPC_VBROADCASTSS (0x18 | P_EXT38 | P_DATA16)
@@ -421,6 +429,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_VPBROADCASTW (0x79 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTD (0x58 | P_EXT38 | P_DATA16)
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
+#define OPC_VPMOVM2B    (0x28 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPMOVM2W    (0x28 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
+#define OPC_VPMOVM2D    (0x38 | P_EXT38 | P_SIMDF3 | P_EVEX)
+#define OPC_VPMOVM2Q    (0x38 | P_EXT38 | P_SIMDF3 | P_VEXW | P_EVEX)
 #define OPC_VPERMQ      (0x00 | P_EXT3A | P_DATA16 | P_VEXW)
 #define OPC_VPERM2I128  (0x46 | P_EXT3A | P_DATA16 | P_VEXL)
 #define OPC_VPROLVD     (0x15 | P_EXT38 | P_DATA16 | P_EVEX)
@@ -3110,9 +3122,59 @@ static bool tcg_out_cmp_vec_noinv(TCGContext *s, TCGType type, unsigned vece,
     return fixup & NEED_INV;
 }
 
+static void tcg_out_cmp_vec_k1(TCGContext *s, TCGType type, unsigned vece,
+                               TCGReg v1, TCGReg v2, TCGCond cond)
+{
+    static const int cmpm_insn[2][4] = {
+        { OPC_VPCMPB, OPC_VPCMPW, OPC_VPCMPD, OPC_VPCMPQ },
+        { OPC_VPCMPUB, OPC_VPCMPUW, OPC_VPCMPUD, OPC_VPCMPUQ }
+    };
+    static const int cond_ext[16] = {
+        [TCG_COND_EQ] = 0,
+        [TCG_COND_NE] = 4,
+        [TCG_COND_LT] = 1,
+        [TCG_COND_LTU] = 1,
+        [TCG_COND_LE] = 2,
+        [TCG_COND_LEU] = 2,
+        [TCG_COND_NEVER] = 3,
+        [TCG_COND_GE] = 5,
+        [TCG_COND_GEU] = 5,
+        [TCG_COND_GT] = 6,
+        [TCG_COND_GTU] = 6,
+        [TCG_COND_ALWAYS] = 7,
+    };
+
+    tcg_out_vex_modrm_type(s, cmpm_insn[is_unsigned_cond(cond)][vece],
+                           /* k1 */ 1, v1, v2, type);
+    tcg_out8(s, cond_ext[cond]);
+}
+
+static void tcg_out_k1_to_vec(TCGContext *s, TCGType type,
+                              unsigned vece, TCGReg dest)
+{
+    static const int movm_insn[] = {
+        OPC_VPMOVM2B, OPC_VPMOVM2W, OPC_VPMOVM2D, OPC_VPMOVM2Q
+    };
+    tcg_out_vex_modrm_type(s, movm_insn[vece], dest, 0, /* k1 */ 1, type);
+}
+
 static void tcg_out_cmp_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg v0, TCGReg v1, TCGReg v2, TCGCond cond)
 {
+    /*
+     * With avx512, we have a complete set of comparisons into mask.
+     * Unless there's a single insn expansion for the comparision,
+     * expand via a mask in k1.
+     */
+    if ((vece <= MO_16 ? have_avx512bw : have_avx512dq)
+        && cond != TCG_COND_EQ
+        && cond != TCG_COND_LT
+        && cond != TCG_COND_GT) {
+        tcg_out_cmp_vec_k1(s, type, vece, v1, v2, cond);
+        tcg_out_k1_to_vec(s, type, vece, v0);
+        return;
+    }
+
     if (tcg_out_cmp_vec_noinv(s, type, vece, v0, v1, v2, cond)) {
         tcg_out_dupi_vec(s, type, vece, TCG_TMP_VEC, -1);
         tcg_out_vex_modrm_type(s, OPC_PXOR, v0, v0, TCG_TMP_VEC, type);
@@ -4078,7 +4140,7 @@ static TCGCond expand_vec_cond(TCGType type, unsigned vece,
      * We must bias the inputs so that they become signed.
      * All other swapping and inversion are handled during code generation.
      */
-    if (vece == MO_64 && is_unsigned_cond(cond)) {
+    if (vece == MO_64 && !have_avx512dq && is_unsigned_cond(cond)) {
         TCGv_vec v1 = temp_tcgv_vec(arg_temp(*a1));
         TCGv_vec v2 = temp_tcgv_vec(arg_temp(*a2));
         TCGv_vec t1 = tcg_temp_new_vec(type);
-- 
2.43.0


