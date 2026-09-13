Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2829C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB7-0002u6-Lv; Sat, 12 Sep 2026 22:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB1-0002Nz-Ie
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:44 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAz-0001v5-NU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:43 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so584317a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267360; x=1789872160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bhfsNWo/UcR8ajtcMqpe1FVfse6uIeAVrBGjoo12jBw=;
 b=oSRYUbTvIotXKTpdKV9Oez/zWTAFI9alZw23BYAt9gIrX3x55BASSShDoaUPo8+opq
 Qhb4b+HaQPKybx7P4eKHH/hwyuCtnlmt5dR03mhFoVtCHnd4RmReqVcFqqqN1894/W8J
 5K+F/guHYObgI4jJsHXVBDChGBUSMJOEZQjVOaDvVlU/PwhDym51u0QSd4WTToPfePa0
 YzaFcHLtRC6YnYMqiEySPSWyiT8ovXuj6455bYuUoI7zgKp64dFNZcSfEgoSh1yjpiRm
 jcQZomlcOEwtHbWoSFSRB1cayjJAiefyX8mC8TgsWMmh6Jy33x1Z/9xLMNoDoYfZ6BK4
 Z3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267360; x=1789872160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bhfsNWo/UcR8ajtcMqpe1FVfse6uIeAVrBGjoo12jBw=;
 b=oTnSmbW6b0oRqcxKD4K4FuVbCXEgUwfEr1aPH9oYQS7mg8NRor6ZHcVT/K4+1O5a3t
 v8MHpziZX2kPiB5SDdfJj6eLlJ43hH8dm64PcyySNR6xm6ZZyRANzaJW08+BEDuk7fL4
 NXynbldhTWyxY4cNgjQhq6yUJkC8OoSIzbhESImQvlL0ARYahjgBj04OV0GtZF7C7hsF
 YehbtUafWexpllAEWzyjvCru5wuz91f13XQqkR4uYoubdEh0as32Pnf1AfcPtW+i0Xwb
 9lhnE22hX/uOZhr61KZkWssaQP59eo/yz+TvmSeJaS5O/0+MRanOLQhaKDSb242Yk9D6
 9gbw==
X-Gm-Message-State: AFuF++n+vzFwsjkuyAZIQ53VpPLhEC4HAeRNglm2w4BdLQKlzg6HH6KP
 b4ipX/Ii3fmGaDAxByrtZCE7e+LLhj/NB93xXqZU9B7shCxo4gVGV8nSHKquMxY0vTfaGjlLx57
 bAnh986s=
X-Gm-Gg: AYBFou0GrjqF7vcf+U3Sn1LQgU3I57nO4tUtCukPbDP6YeNimNeRz7vHuOtu3kZD3c7
 lK2m9IGYzcXgIKM1P9K0B9zo7XvkvUwNSakypCnY15x4qjS7dR9QCg3BC6X5XpGzUI2qWvK9Qy7
 lDjuzdnjjunz9sLyW+Y0mVgKIg/WYrLm04APErUInYfOsUYdCVpJaCDDDV/E6rBAgD87vPfhoeQ
 Tr4S3/8d8eYIIhW2dwynoQ7dZNI7JTkYmdNCN/WXAn317gh+5aWn87aFa/jbtvBHXOxxcsLSS1V
 5MgsPWmCpLaAS7WCT3qdcjga+5wfjIgxYIW35Cr/mhchz3TDezT57FoE05nq1UW74jI9sqykr5J
 qIvVRZXEnOOYwYmH0p4LVUAW1yF2q5wQSsNMLmH/jmXooUJkP4ypjd33bfONdlD2fdCBnoNiMGD
 5yr/+XcZN1dRX2d896u2rs0e1DmGcqbhuL5jdLzDJX8MT4w/kJH48mlLlhVbIjrh9XKxry+XHWb
 lLPD2U=
X-Received: by 2002:a05:6a21:3395:b0:3da:b089:dba4 with SMTP id
 adf61e73a8af0-3db0e109f4dmr10191225637.2.1789267360310; 
 Sat, 12 Sep 2026 19:42:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 54/86] tcg: Generic expansion of tcg_gen_clrsb_*
Date: Sat, 12 Sep 2026 16:38:05 -1000
Message-ID: <20260913023837.741866-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 46 ++++++++++++++----------------------
 3 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 77fc1cdc3a8..579699f5939 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -185,7 +184,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 9968ca9516f..1bdf9876067 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 053b4b8116d..723168aae5a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -496,6 +496,24 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
+        TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, t, src, width - 1);
+        gen_xor(type, t, t, src);
+        gen_clzi(type, t, t, width);
+        gen_addi(type, dst, t, -1);
+        tcg_temp_free_internal(t);
+    } else if (type == TCG_TYPE_I32) {
+        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    } else {
+        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    }
+}
+
 static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_clz, type, 0)) {
@@ -934,20 +952,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t, arg, 31);
-        tcg_gen_xor_i32(t, t, arg);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_subi_i32(ret, t, 1);
-        tcg_temp_free_i32(t);
-    } else {
-        gen_helper_clrsb_i32(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1779,20 +1783,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t, arg, 63);
-        tcg_gen_xor_i64(t, t, arg);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_subi_i64(ret, t, 1);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_clrsb_i64(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


