Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027B9CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ldt-0007JW-3a; Mon, 22 Sep 2025 14:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lcO-0005IX-7S
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc4-0004TF-Ry
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:31 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77e6495c999so3283164b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567010; x=1759171810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48M255vDXUg+h3ahPw5Hxn6mwDdmXJFvoCKvpfhtzJg=;
 b=NIPOFXT+JNirVsxNyO1TiQWDeJtzd9MzDAO5JGIBjBMa7ZjcOM7UOQZMw/Ua5sbmxl
 G9W0lGTBXT0AbY4FqOTgeVB8FRFvcaBMempMnuXlvmkEonB1HSi6sjciW95EoTRzWR4M
 TMoGfThjnjKuY51MDMt36MQRQzYJAv7LuLpOj6n7708IQtavi+mjRno+RYnzdROsz5Dv
 bJycKxOFHVjOJF7SYjObnYCiVoC8JdUD+Pjj92u129zw3L8k6Eg2doVNbo6fa2lFYMov
 NEAIJzfVj35WJRPYu+UlLNqqkubP+NRxye7x8DOOR3qFKImkTp+b+BOG/8nZ2wC8DzR/
 5qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567010; x=1759171810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48M255vDXUg+h3ahPw5Hxn6mwDdmXJFvoCKvpfhtzJg=;
 b=stn0Q0+JVJ2sv9xV8c9GeEv2cXmQMJfw4okitrxoTVzoN32LvWQ78J7a1jjH2CL10S
 zXYbWwMWqhEuHU1t0OlhGJFUsDzrtBI3QvgWJnSrg2HKfdU5yXFq9J6Q8LdyTF7NvqkG
 X8zgwA3lay5v0DrKDhxuJ6bO6qEsS/LmQliqBAYr5+k05245mQuPMcmmWKsh3pyJG6u3
 rPneXs6rDU0mIjUn7pPETQwyr5/bYRZ3b7OtnCUTPNoMxUTuVKUf8bzNlLOvrdkGnekF
 v6x9rX/f+1zdwhImegF18R02kBf7dMH6LCnlbwp1VL/xDD4ObMxw2ib8oYeJxiL2MFpH
 y5Ig==
X-Gm-Message-State: AOJu0Yx4ggRS4jPosWxpWsiFx4HAhg+SuIZ94B2WAT2g2eUBfPNvjxwi
 aZri0/AjiWmr+5odxlRZ58+8QWv0RoZyjmwEE98CdY4Rn9dmPqf8xBWV924eyM+1rI9N+NKSrCR
 nz+CD
X-Gm-Gg: ASbGncsusBuQdH1H4lCmDJboLB+A9/AsMLnOvyXOwCla30uVwV4nPRIVTNcUk0wt3TI
 zT5a0T9syuLrMIBrc7gpik9ju9rJ2MLPMZBi0s4quMK7OODhqFv5KVBVjFocb/eQz5S5sPQ7hWJ
 UAF15mzyEy3hrWkawLW5Vsnu6yGtyMEuPHy3H33pjz9I20ZvxkhGh/S24RvLQq3PpcFxXo8F+A0
 E5QvJ4wBp6bKg7oD/yYCAB1Od38+rOvTtnNLJejHKpXVrQLRKFhq09NzgiCHIZCBW0wFM2D+8i0
 ZGzcgxBPOhYGj83eglSeDJ8q+gxIxGkyEVzhCPPaMuqH7c3P2WyhzwP5Wsme51B4fHhmfciINZU
 sH4YY9E9Fsq96XZi9q3oUHhkk0rKv
X-Google-Smtp-Source: AGHT+IG6pj8AQ8C/K2XSJnWEqFbt0j7WlNorN+oVg5XDfQr8pXP6GohDsx+iOr0YsVOrIE5YyNoOSw==
X-Received: by 2002:a05:6a21:3290:b0:24a:d857:fcab with SMTP id
 adf61e73a8af0-2cfdaf0bcdemr137108637.23.1758567009880; 
 Mon, 22 Sep 2025 11:50:09 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 37/76] target/arm: Make helper_exception_return system-only
Date: Mon, 22 Sep 2025 11:48:45 -0700
Message-ID: <20250922184924.2754205-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    | 5 ++++-
 target/arm/tcg/helper-a64.c    | 2 ++
 target/arm/tcg/translate-a64.c | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 85023465b7..b6008b5a3a 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -80,7 +80,6 @@ DEF_HELPER_3(vfp_ah_maxh, f16, f16, f16, fpst)
 DEF_HELPER_3(vfp_ah_maxs, f32, f32, f32, fpst)
 DEF_HELPER_3(vfp_ah_maxd, f64, f64, f64, fpst)
 
-DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
@@ -145,3 +144,7 @@ DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_2(exception_return, void, env, i64)
+#endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 71c6c44ee8..6d77fd0113 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -576,6 +576,7 @@ uint32_t HELPER(advsimd_rinth)(uint32_t x, float_status *fp_status)
     return ret;
 }
 
+#ifndef CONFIG_USER_ONLY
 static int el_from_spsr(uint32_t spsr)
 {
     /* Return the exception level that this SPSR is requesting a return to,
@@ -787,6 +788,7 @@ illegal_return:
     qemu_log_mask(LOG_GUEST_ERROR, "Illegal exception return at EL%d: "
                   "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9dfcf4f993..ce5d597c93 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1870,6 +1870,9 @@ static bool trans_BLRA(DisasContext *s, arg_bra *a)
 
 static bool trans_ERET(DisasContext *s, arg_ERET *a)
 {
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
     TCGv_i64 dst;
 
     if (s->current_el == 0) {
@@ -1889,10 +1892,14 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
     return true;
+#endif
 }
 
 static bool trans_ERETA(DisasContext *s, arg_reta *a)
 {
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
     TCGv_i64 dst;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
@@ -1918,6 +1925,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
     return true;
+#endif
 }
 
 static bool trans_NOP(DisasContext *s, arg_NOP *a)
-- 
2.43.0


