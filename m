Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E835C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATi-00084Y-ES; Thu, 23 May 2024 11:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATc-0007yQ-9W
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATW-0002Vi-Me
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-354f3f6c3b1so1361012f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478523; x=1717083323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CGBp4NU67CugPtunqKfnvn/OzvHvAn+YyDYS3BiGhZM=;
 b=EQr4zTzc4uhMmQQHB7GAciNjRxRZltExEM2MkIrkSFrfxEj68nV9GKRXFbB5R8x2ue
 cTa8dgGtzGlHmW5i40eAdCVLQjZHrEAP1ROR6OaEjuPP4OdTDUxy6V6+b+PsO9yjuvbI
 XO4O97cA9nc3xqCS4JtvldiXfxmkDzOf4toJZG5qkK5naiqeQAXHPjR11sM+OLBttnDR
 zyO30oafKc0qxxrnp5VYFUtsN/1HGGoibNJ3NvX2Encq4jT9p3T5zc3VMo5fNcDXZCvH
 4VGRwHgw8oEHM+7NGcVks3BE33Ymg9GSYdOSlol/q6GB3Yq3zGUhgKPQZxIplBQ+aWl4
 unwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478523; x=1717083323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGBp4NU67CugPtunqKfnvn/OzvHvAn+YyDYS3BiGhZM=;
 b=v4+HkcABSY/94OBQuv76wYT4eh3PW8V+AkquEBcE0+69mmEXUZGtFwu/E2gwv8YfZw
 hkol/RUjLOFg+AMb18KHoAudHGhV+NER6VWi3oMqcIz9VrxtiCwXra0KN5OqUgEwTqp5
 AWxSQswiRzlrzzxC0FEMkFUiw9wEFiy+ondspRgP+LjrUxJvA0prnoGpVjFCAordn33s
 MY1qD2cSxN8gCJ4jATOGyI2d0jo15ESR+k3eVO2l740sbAW20DuC+15GDoHBD6TSjjWu
 nQQNxHbg5wK/bPa+F8T+zLHTpyi/joMFjbIyY9Z/MVh+QgNJ2zGBOcOI5XvkS7OWq04g
 gMeA==
X-Gm-Message-State: AOJu0Yxa69Ew9nBFcIAvT9bM61DcMPSR1IlpcnVwFLl6HkpKUYo7b0KS
 Y+3aonZiGb1o7xZC0BzF20A5ZAjcFgp+WpyUw+qrf58svj2PEXL9UrvLExCij1nDKDSaG+3M82X
 x
X-Google-Smtp-Source: AGHT+IFTemVyjDaQQhOPXroGhnESoNjNWyuYDHr9BPeR9EZlFbytYFZZlNB5oOlCs9sb8add7/slVQ==
X-Received: by 2002:adf:f384:0:b0:355:448:7974 with SMTP id
 ffacd0b85a97d-35504487a0bmr208897f8f.35.1716478523709; 
 Thu, 23 May 2024 08:35:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/37] target/arm: Use gvec for neon padd
Date: Thu, 23 May 2024 16:35:01 +0100
Message-Id: <20240523153505.2900433-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-26-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             | 2 --
 target/arm/tcg/neon_helper.c    | 5 -----
 target/arm/tcg/translate-neon.c | 3 +--
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d3579a101f4..51ed49aa50c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -354,8 +354,6 @@ DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
 
 DEF_HELPER_2(neon_add_u8, i32, i32, i32)
 DEF_HELPER_2(neon_add_u16, i32, i32, i32)
-DEF_HELPER_2(neon_padd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_padd_u16, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index bc6c4a54e9d..a0b51c88096 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -745,11 +745,6 @@ uint32_t HELPER(neon_add_u16)(uint32_t a, uint32_t b)
     return (a + b) ^ mask;
 }
 
-#define NEON_FN(dest, src1, src2) dest = src1 + src2
-NEON_POP(padd_u8, neon_u8, 4)
-NEON_POP(padd_u16, neon_u16, 2)
-#undef NEON_FN
-
 #define NEON_FN(dest, src1, src2) dest = src1 - src2
 NEON_VOP(sub_u8, neon_u8, 4)
 NEON_VOP(sub_u16, neon_u16, 2)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 2326a05a0aa..6c5a7a98e1b 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -830,6 +830,7 @@ DO_3SAME_NO_SZ_3(VABD_S, gen_gvec_sabd)
 DO_3SAME_NO_SZ_3(VABA_S, gen_gvec_saba)
 DO_3SAME_NO_SZ_3(VABD_U, gen_gvec_uabd)
 DO_3SAME_NO_SZ_3(VABA_U, gen_gvec_uaba)
+DO_3SAME_NO_SZ_3(VPADD, gen_gvec_addp)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -1070,13 +1071,11 @@ static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
 #define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
 #define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
 #define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
-#define gen_helper_neon_padd_u32  tcg_gen_add_i32
 
 DO_3SAME_PAIR(VPMAX_S, pmax_s)
 DO_3SAME_PAIR(VPMIN_S, pmin_s)
 DO_3SAME_PAIR(VPMAX_U, pmax_u)
 DO_3SAME_PAIR(VPMIN_U, pmin_u)
-DO_3SAME_PAIR(VPADD, padd_u)
 
 #define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
     WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
-- 
2.34.1


