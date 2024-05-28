Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA4FC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUx-0001h0-1w; Tue, 28 May 2024 10:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUu-0001ex-Tn
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUq-00075Q-KH
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:16 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-357ec504fcdso579229f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905291; x=1717510091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h1buDJhz2wCtQFvBdtMaIdKQ5IOooPTw5OQ/DvPjbTs=;
 b=yJE17Fe0Ay6oqiJ9hZMM5qc0w84aKBtBEDiz6A2WpFE70d9EZI5PZLiVBg2Ul5cpi0
 mwTdrH5VJ9oSwIz4z1UA4vRpzQlxtallj/bQIyu+zwgivEzJEbNOWUGuMlHhtF8e8S/3
 QbM/LBbI0KpklrCYUEs9pKP3rCtaYNplC3SjhKClol9HsREmT5icyK3QwcJUwGrbZMKB
 J/zkR4xmRXy7UaTg0s/tJA3iU/F++GDqwmH1dPGfu3EFWP2cSviSXDbh81KZbhEh0rXA
 v29Wl24H/hGoCdy+FSHgbFoSVvs1lB/5f7PJVziTHXssHlo0xFpLVddNr68wUi5JY2gI
 Epfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905291; x=1717510091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1buDJhz2wCtQFvBdtMaIdKQ5IOooPTw5OQ/DvPjbTs=;
 b=f9Uxcyt/ZwdGJcKx1EyITIM5J3wM9T7Aqbuw4dWKAieT9oSaXHoYqlZcJUkpKbzXp5
 ajmBHrwSIRjFxl8TqE9BDQqYxct18ZelBxwGBNj1E1WiWy3vsiXENeDgtE83EJkT0miK
 QuMJnzdstudTh/yRpQWl1LYWzzW4VnXeqFKodE1DHYFrrMF59PZVixBUvipWjVywI7MD
 Bj4hrjtUIvacS3byOyNitaQb83NHH7FcrkWjp1EVbNuVY6o9vfBUn5Z30WCC2QOyq8LO
 pVGfWcLgZnX4B4DOPoAErQ9KM5U5WPY62uD/AlcZzuDyV+ussqUjwJA+HI2HSyhP3jUu
 BQSg==
X-Gm-Message-State: AOJu0YwWdkGVb/GPT5IYTAM5+37P9G01ZQaBlQnxmoUio0QrhXBlvTTW
 BjXNtwxbAZOB6KTLdg4r4Y5Jq6BX0qNnc3w6+/xn2P48LplMr8Ee0vqaRXc2IvWuab+hOdAWKP4
 j
X-Google-Smtp-Source: AGHT+IF99kCcW1juK2IXcO8i27DvvHc+XVe5aQuUcvz1luvJylZBtL8o3bOGDY6cpg9uokbkfu61SA==
X-Received: by 2002:a05:6000:401f:b0:354:fd51:45fe with SMTP id
 ffacd0b85a97d-3552fdf29a8mr9356995f8f.47.1716905291275; 
 Tue, 28 May 2024 07:08:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/42] target/arm: Introduce vfp_load_reg16
Date: Tue, 28 May 2024 15:07:38 +0100
Message-Id: <20240528140753.3620597-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Load and zero-extend float16 into a TCGv_i32 before
all scalar operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240524232121.284515-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-vfp.c | 39 +++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b9af03b7c35..8e755fcde8a 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -48,6 +48,12 @@ static inline void vfp_store_reg32(TCGv_i32 var, int reg)
     tcg_gen_st_i32(var, tcg_env, vfp_reg_offset(false, reg));
 }
 
+static inline void vfp_load_reg16(TCGv_i32 var, int reg)
+{
+    tcg_gen_ld16u_i32(var, tcg_env,
+                      vfp_reg_offset(false, reg) + HOST_BIG_ENDIAN * 2);
+}
+
 /*
  * The imm8 encodes the sign bit, enough bits to represent an exponent in
  * the range 01....1xx to 10....0xx, and the most significant 4 bits of
@@ -902,8 +908,7 @@ static bool trans_VMOV_half(DisasContext *s, arg_VMOV_single *a)
     if (a->l) {
         /* VFP to general purpose register */
         tmp = tcg_temp_new_i32();
-        vfp_load_reg32(tmp, a->vn);
-        tcg_gen_andi_i32(tmp, tmp, 0xffff);
+        vfp_load_reg16(tmp, a->vn);
         store_reg(s, a->rt, tmp);
     } else {
         /* general purpose register to VFP */
@@ -1453,11 +1458,11 @@ static bool do_vfp_3op_hp(DisasContext *s, VFPGen3OpSPFn *fn,
     fd = tcg_temp_new_i32();
     fpst = fpstatus_ptr(FPST_FPCR_F16);
 
-    vfp_load_reg32(f0, vn);
-    vfp_load_reg32(f1, vm);
+    vfp_load_reg16(f0, vn);
+    vfp_load_reg16(f1, vm);
 
     if (reads_vd) {
-        vfp_load_reg32(fd, vd);
+        vfp_load_reg16(fd, vd);
     }
     fn(fd, f0, f1, fpst);
     vfp_store_reg32(fd, vd);
@@ -1633,7 +1638,7 @@ static bool do_vfp_2op_hp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     }
 
     f0 = tcg_temp_new_i32();
-    vfp_load_reg32(f0, vm);
+    vfp_load_reg16(f0, vm);
     fn(f0, f0);
     vfp_store_reg32(f0, vd);
 
@@ -2106,13 +2111,13 @@ static bool do_vfm_hp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i32();
 
-    vfp_load_reg32(vn, a->vn);
-    vfp_load_reg32(vm, a->vm);
+    vfp_load_reg16(vn, a->vn);
+    vfp_load_reg16(vm, a->vm);
     if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negh(vn, vn);
     }
-    vfp_load_reg32(vd, a->vd);
+    vfp_load_reg16(vd, a->vd);
     if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negh(vd, vd);
@@ -2456,11 +2461,11 @@ static bool trans_VCMP_hp(DisasContext *s, arg_VCMP_sp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i32();
 
-    vfp_load_reg32(vd, a->vd);
+    vfp_load_reg16(vd, a->vd);
     if (a->z) {
         tcg_gen_movi_i32(vm, 0);
     } else {
-        vfp_load_reg32(vm, a->vm);
+        vfp_load_reg16(vm, a->vm);
     }
 
     if (a->e) {
@@ -2700,7 +2705,7 @@ static bool trans_VRINTR_hp(DisasContext *s, arg_VRINTR_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    vfp_load_reg32(tmp, a->vm);
+    vfp_load_reg16(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_rinth(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
@@ -2773,7 +2778,7 @@ static bool trans_VRINTZ_hp(DisasContext *s, arg_VRINTZ_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    vfp_load_reg32(tmp, a->vm);
+    vfp_load_reg16(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rinth(tmp, tmp, fpst);
@@ -2853,7 +2858,7 @@ static bool trans_VRINTX_hp(DisasContext *s, arg_VRINTX_sp *a)
     }
 
     tmp = tcg_temp_new_i32();
-    vfp_load_reg32(tmp, a->vm);
+    vfp_load_reg16(tmp, a->vm);
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     gen_helper_rinth_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
@@ -3270,7 +3275,7 @@ static bool trans_VCVT_hp_int(DisasContext *s, arg_VCVT_sp_int *a)
 
     fpst = fpstatus_ptr(FPST_FPCR_F16);
     vm = tcg_temp_new_i32();
-    vfp_load_reg32(vm, a->vm);
+    vfp_load_reg16(vm, a->vm);
 
     if (a->s) {
         if (a->rz) {
@@ -3383,8 +3388,8 @@ static bool trans_VINS(DisasContext *s, arg_VINS *a)
     /* Insert low half of Vm into high half of Vd */
     rm = tcg_temp_new_i32();
     rd = tcg_temp_new_i32();
-    vfp_load_reg32(rm, a->vm);
-    vfp_load_reg32(rd, a->vd);
+    vfp_load_reg16(rm, a->vm);
+    vfp_load_reg16(rd, a->vd);
     tcg_gen_deposit_i32(rd, rd, rm, 16, 16);
     vfp_store_reg32(rd, a->vd);
     return true;
-- 
2.34.1


