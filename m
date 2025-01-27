Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD78FC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUv-0006TY-2P; Mon, 27 Jan 2025 18:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUj-0006N2-Vs
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:19 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUg-0005Yj-1b
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:17 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so9434183a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020372; x=1738625172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rv/vufPtN4qZGgCEixmno+0BEOkC6dlLbTtJbkkFI6Y=;
 b=uqkh5ZaXC1uGs9NXy+bYk8dl/tzOOokYSfdG7vd+Bd2nFdcoTIHp7KxEAxcz8spydw
 rnAt7UJrTABAb+FJIngrMsZeV27buKruzwaCd4I6QerpsKflgFc1GdWaFHgo95r6nhKf
 Bb0fnxYa8lyx24Ddew9dSnz6O4sKNR9s3vn7xvGT6EpiBlrIDYbtt1n97SZ/UTrO1J6o
 e4Y3smYLPpfKJi4zy8lbWc+1G5cJXTXL3Ts5idhDo0ijUmBFXMWkTkVRcHzRIF82NLFU
 srll4eHhbdxLmFrtnS3k00CBOG9dFfGTiJz/UHMSX+3kaeIT66JxjKQgEoaaAYjobD5l
 690Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020372; x=1738625172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rv/vufPtN4qZGgCEixmno+0BEOkC6dlLbTtJbkkFI6Y=;
 b=eCVp0BX1OMMaGx+iDcionLl13QyYD7qKc5u5hUkHjS0FJEwRRFiR+LxG3XiluBH+cn
 RM5Op2Hod4qE1JuvfcNm9TsYRtbw7CDQnEsau6i2CcCayMj5Jq65S4H793qC6J5fah1f
 ed6PUBUc5w4GpbX+vlk8FK/79FJXjb3AbTPhf4Ea1AGHeEEL6fZWXDnxF9uDVG6G+cLs
 0+sQTFs4RaDnzNVvUVaTHhSLlVTApFOe+CkDVqVCEdicg70qvJHXRIrPkt71f0pIPO/N
 fgsb6bZxltqngKY8azJOzBztlp6a6w7guw0kfe1QtNBCKeI9Mvidm/hoSRGSuwummpAt
 jwhA==
X-Gm-Message-State: AOJu0YzQTGfUKEAxMzHb1WB07uyRvrCTnjvl1DSDRlEGFY2YrpvgfEcx
 XvLYt5RMW/XBJitiQNPcGknm3xEH56lcnHOFwiT9VYrcwSfn1bsGPqIsBDj+QamtDx+s8M1ze1I
 /
X-Gm-Gg: ASbGncty6WfHfH6z3DlWRcaEchBgp+wUr9rb3G4fynplToHKrslzk4/O9Yq6yDJo1l7
 aa1StJQ0ypH7she/FqeCkuU5pMCV1AKj+yIKDHVg2EvUcysf68VYUcFckvcdn8DEhy513/KYSxK
 T5AXH9HMR1sQd7X+kZQ89GeA013j7AJ6qX79EAMCdEA1DOkIfOtwjXXzaaPvC9TzM4yhd1t54m7
 uh1dGbzl2w2a9jYY+wqz0pj8R6Z131Bw5V2uuWER69NnUJhwXAnZHo5LGxtuvxTFUnsrRjIeqIX
 BX3AWDTkdVfl4NgwUGttH/pHn4Xz5Zs63SFNWyQ=
X-Google-Smtp-Source: AGHT+IGVGmGOX+jYkUxwIrh9VQwvXmLlA1gq893+Mqz+4HvBalKSMZqUAVDVT2veufpZuepAlOp+6Q==
X-Received: by 2002:a17:90b:2f46:b0:2f4:4431:51d4 with SMTP id
 98e67ed59e1d1-2f82bff6fcdmr1777822a91.6.1738020372524; 
 Mon, 27 Jan 2025 15:26:12 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 09/22] target/arm: Remove ah_fp_status_f16
Date: Mon, 27 Jan 2025 15:25:51 -0800
Message-ID: <20250127232604.20386-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace with fp_status[FPST_AH_F16].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h        |  3 +--
 target/arm/cpu.c        |  2 +-
 target/arm/vfp_helper.c | 10 +++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 18afff8509..0f7d5d5430 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -237,7 +237,7 @@ typedef struct NVICState NVICState;
  * behaviour when FPCR.AH == 1: they don't update cumulative
  * exception flags, they act like FPCR.{FZ,FIZ} = {1,1} and
  * they ignore FPCR.RMode. But they don't ignore FPCR.FZ16,
- * which means we need an ah_fp_status_f16 as well.
+ * which means we need an FPST_AH_F16 as well.
  *
  * To avoid having to transfer exception bits around, we simply
  * say that the FPSCR cumulative exception flags are the logical
@@ -695,7 +695,6 @@ typedef struct CPUArchState {
                 float_status fp_status_f16_a32;
                 float_status fp_status_f16_a64;
                 float_status ah_fp_status;
-                float_status ah_fp_status_f16;
             };
         };
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 26e3465a4b..ffb2151de5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -559,7 +559,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status);
     set_flush_to_zero(1, &env->vfp.ah_fp_status);
     set_flush_inputs_to_zero(1, &env->vfp.ah_fp_status);
-    arm_set_ah_fp_behaviours(&env->vfp.ah_fp_status_f16);
+    arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 93db713a40..d8dc58098b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -129,7 +129,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
           & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
-     * We do not merge in flags from ah_fp_status or ah_fp_status_f16, because
+     * We do not merge in flags from ah_fp_status or FPST_AH_F16, because
      * they are used for insns that must not set the cumulative exception bits.
      */
 
@@ -160,7 +160,7 @@ static void vfp_clear_float_status_exc_flags(CPUARMState *env)
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD]);
     set_float_exception_flags(0, &env->vfp.fp_status[FPST_STD_F16]);
     set_float_exception_flags(0, &env->vfp.ah_fp_status);
-    set_float_exception_flags(0, &env->vfp.ah_fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.fp_status[FPST_AH_F16]);
 }
 
 static void vfp_sync_and_clear_float_status_exc_flags(CPUARMState *env)
@@ -206,11 +206,11 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a32);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16_a64);
         set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_STD_F16]);
-        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.ah_fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_FZ) {
         bool ftz_enabled = val & FPCR_FZ;
@@ -235,7 +235,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a32);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16_a64);
         set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status);
-        set_default_nan_mode(dnan_enabled, &env->vfp.ah_fp_status_f16);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status[FPST_AH_F16]);
     }
     if (changed & FPCR_AH) {
         bool ah_enabled = val & FPCR_AH;
-- 
2.43.0


