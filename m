Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194A3EE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYg-0002iP-7h; Wed, 11 Sep 2024 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYZ-0002PC-A1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYX-0003g9-8R
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:02 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7191ee537cbso644807b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073460; x=1726678260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wC8NJvzs4xm1iFMunKJrmEEYWEWZeuBA49NgWvG2FqE=;
 b=jrgnsqxtrWpaG7vwfiwVlYoxE2wyA530GTWXX7+9lfpN9qPn1//Kg8VF16I8B+yXLq
 kyZ8h9qRtVz83HX7klv113ZRo4lQjVyZRBPWv1sSF81HY2hzl60VE51QI6gqmq3P0aEs
 immiPIHFWwt96uCQBCPUCQ0RRGZyVOzSk0EpEvojVozJ9qKL41p/Zozn+Q0RjuYmCgoJ
 FWTPH2aDyFurXRYPyHy8Du73nwHbBHF6wuHIyLSBqSb3kvC/TKYZD/sgN72qVUXJiQyc
 0iyoM3D6bsDDHXFONyFyTIBmAbVhxuLKFkjPSeSYbNI9irnR8587bRk3boKnHDAewUOL
 lKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073460; x=1726678260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wC8NJvzs4xm1iFMunKJrmEEYWEWZeuBA49NgWvG2FqE=;
 b=aPB/yB5VM/O2THbaHwEpXTxKtPtZA+BnanGL2GrdRm4GnPM2wa2h0c4PyROnlT/dHy
 JuC9+eKSDeVYMp4NURk5rMugAUbl2Wx+loN1S6w/A/snPavlfkAVFFIT/yeE03uAhkKI
 kjFL1pJht9A5ZJyssu2+tM3bMChAHPFl3OfBMQNhDqUotps69l/mkYPr0VfYAVG1vtNK
 iO1RK+G1HqJWqoBM1rywoU56LN/qqjfZ67VjTzaJkJMZMsamS/2H3YdM6cloqqaIZryJ
 DazDhbDLQZqX3L3321Wec75M6KnpJyV+MpH7ep5ia0bQLfVrIy6zu9amWSNKnJaDSzD+
 2GSg==
X-Gm-Message-State: AOJu0YyWZXiGrIna6bfNMsDizQQ+k05B4TqSNDBB4CnHz1qckf2d49Wh
 VEX06WLFcFnfOjp7nCzsXbE6DJfOdCzhPfZiQUit4ieGJTkMxohITxfNa9EGJRHs5wTmz1ju8nQ
 I
X-Google-Smtp-Source: AGHT+IG+EsJeg+se6UGL3e8yKicFQLksj3SlmzyiVHY8wiup4cjxaZs3AyPdFYPglxLi3ZEijiCVDg==
X-Received: by 2002:a05:6a00:138f:b0:70e:91ca:32ab with SMTP id
 d2e1a72fcca58-71926065435mr24403b3a.6.1726073459565; 
 Wed, 11 Sep 2024 09:50:59 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 11/18] tcg/i386: Implement cmp_vec with avx512 insns
Date: Wed, 11 Sep 2024 09:50:40 -0700
Message-ID: <20240911165047.1035764-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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


