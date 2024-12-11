Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50178E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPeE-0001Fq-CA; Wed, 11 Dec 2024 11:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdG-0005JQ-80
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:16 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdE-0001OO-1X
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:13 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46779ae3139so18042661cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934731; x=1734539531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ev7jjsh9Nmr0LRpcRvQLdJjaZQoRj4CtThapvJLKxEk=;
 b=h/A8ouxr/2d+OyaRE69M4DRdl8STTDJ/76HRkkwaiErQiiH8imMBesyMF++DruDstO
 8pXdhoZJOS0dmtrFcvVAuMkeGTjQuISxlgmYu9bTiL2loIAVuQaVX/ThJgg3mY8ByPW1
 zD0DpSepRLOneT5IqtKQ4sVzg2DlSOC1DEoQG/j9UHzrJ1iJL7taDxpKjtd0sdveE9Lb
 fCqXQ9R/XsH/NoE6lnKTfibflq/uluCBkDChqWrQ/NS+KfHwayFVTwz3Qzr/n2U/w6AX
 N9AXFlt6iGr670kuZTU9nscBZfn9OQYXa68GHPNwlvb8GZ6keDumsgqHYAHYCaNh5d/8
 4Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934731; x=1734539531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ev7jjsh9Nmr0LRpcRvQLdJjaZQoRj4CtThapvJLKxEk=;
 b=NH8NLVC52EWueXyOcBg2CRZw+vT8wEejSJzA1SWDT92KI8fzzwnE8jjtFolhW1N6dN
 aRU9Ee0+eYo6fAgCAyTvYYjS+qjqzeGeVNZIYMVKaBF0FqOAjCqAqIIHHJ0Y9Vvuunym
 xSF/rbX16ugOkfInPFILuz9pvuXbXCD9hwNh00hvf2oWH5hSI62vy0/5/Pu0zKa4liX4
 G/Q5bpkZhsbel4HGKE+PacyzPHL0809xKCLTLuF6eugt9sT/+hPgTeA3QdT272SlB9aU
 8XpCUG50eN4M/mVZsmzNegvpba1Mt5Y4/pRkjg1G8G2V4M6puDP8O0ZTz3xQ1xBhKlha
 KUhg==
X-Gm-Message-State: AOJu0YwadImyPJxqp8qesnDjpvxdqsyo+uKZ9KZTYKYJLlKBsTbNFYh2
 ahIadlHN+jWPmtbYoAihM24mR8ucsuIKGGaLFSi/TCBe8V/eaGe1GUmVVsRC0kLGfD9HHfuvvOE
 QMbrx+YVT
X-Gm-Gg: ASbGnctgTPmpz5ZMKFv7aiUElB35EcW+cQcBfvHL8Ye8wvWvff3QvyxsSd1aprHA6RC
 vH3j6GL0MmyMp0MQbBNrejoCLGSkLbpgwAo5dtJs1yth+dPcUTtge0vShyNHDS8NPZEgsrvLsGI
 A77GQGFY3yasAYjcjuSOVBZHJVpwY0j7mOaZq0sYdghqltA8u0MzSOqOC8DXFOCWpEoHJZIA5Y0
 41YNgDRO1wCQBLj3VfMXO9G+Hiw33mdniQQMA9EH+L25nnkDIA3svpWn7Si8w==
X-Google-Smtp-Source: AGHT+IFJupYzmvJ728oZXqmZdRwOfI/NdDSiR6rZ5P09BhgttyPp4pEZeAEzQqB0VUsTj8gB4LsvvA==
X-Received: by 2002:a05:622a:2d2:b0:460:a928:696f with SMTP id
 d75a77b69052e-4678936d296mr47606581cf.29.1733934730964; 
 Wed, 11 Dec 2024 08:32:10 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 26/69] target/arm: Remove helper_sqrt_f16
Date: Wed, 11 Dec 2024 10:29:53 -0600
Message-ID: <20241211163036.2297116-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
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

This function is identical with helper_vfp_sqrth.
Replace all uses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  1 -
 target/arm/tcg/helper-a64.c    | 11 -----------
 target/arm/tcg/translate-a64.c |  4 ++--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 481007bf39..203b7b7ac8 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -80,7 +80,6 @@ DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
 DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
 DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
-DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 8f42a28d07..3f4d7b9aba 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -915,17 +915,6 @@ illegal_return:
                   "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
 }
 
-/*
- * Square Root and Reciprocal square root
- */
-
-uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
-{
-    float_status *s = fpstp;
-
-    return float16_sqrt(a, s);
-}
-
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
     uintptr_t ra = GETPC();
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cfc73b8506..2a5cb70475 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8354,7 +8354,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     switch (opcode) {
     case 0x3: /* FSQRT */
         fpst = fpstatus_ptr(FPST_FPCR_F16);
-        gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
+        gen_helper_vfp_sqrth(tcg_res, tcg_op, fpst);
         break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
@@ -10978,7 +10978,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             case 0x7f: /* FSQRT */
-                gen_helper_sqrt_f16(tcg_res, tcg_op, tcg_fpstatus);
+                gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             default:
                 g_assert_not_reached();
-- 
2.43.0


