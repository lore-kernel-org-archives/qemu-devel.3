Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE9DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnL-0000cc-1c; Sun, 05 May 2024 21:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmr-0008My-PT
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:02 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmK-0002Vf-BR
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:01 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-60585faa69fso815310a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957466; x=1715562266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEt+N8QVC6VNPpsOJPEnH14M/rsdrctDg74RO6PnuQM=;
 b=ny/FblQxd+7lHDjUOmdN9yVgegou02yeSEIEXFzQf1r2Ka52Flylw+qmFOkWpuTi+B
 jM9nrMotsfNBKv20/ncDQnTzDZ1UV0eFdKRdqPCU07SH8i8f8saMBOqJZ2P4sfUBYA84
 L0H3RH2jNTboWwe7edGtl2zKrdqm7J6yDt+mBoNGppH1rfx2aZJMXD719hicu/uONBI/
 VJPHswCAd4R522B4cSnjjZg44uGL4PAXWk+hDaB25p8zpVVuX/usyZjhH/bab1ln01XS
 y/JOLAQ5oThFeTVw5Baufhvv1oY6JjppUU+4uGusH+YnVPKswzvMfEmi47O/0Z01msDr
 kCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957466; x=1715562266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEt+N8QVC6VNPpsOJPEnH14M/rsdrctDg74RO6PnuQM=;
 b=LpTrRgSPdv8sJMPWwqayGXzrnKxx7+5UYUKQ/ku2BOmU4U88jdvHkTiGayq2Jit7DA
 zSiBUbH1/w7RSi0v+I/R+JnzSl5o5700xQO703GDv1eO5Y7e+hKV03Bc+fKkhGQW7cDy
 xwlZnuMe9xRVDzLC5ZAVppRFb9aeHszumoBPNncPBiMyJ/beHWpky+Y2NFg37uUn4XE5
 erYKdOesHB1RQVx5aam4u06JMXUICWsmcDj7V07AGW9v6rWdmyBea46geZ0bM8SEzRzU
 Ubtt9Nj29NnMazOU0+rPjnM2Et4HJ1Q/9tskhF6vYQow2/IMfN0JOKdBfDU/vP8QE6eB
 1LVA==
X-Gm-Message-State: AOJu0YwsJQ8ERQWP4G1/biKNtkM5UHEcgIS4ZbJsG/rF7IqljG38Mcao
 UJH9F4794vwpitqwr8AZQTR0ashzojyDvPDnYOXwOVxH3q8bKjdHELENJCS/2/i/0C5lgkrgHgQ
 l
X-Google-Smtp-Source: AGHT+IG0pemy21/r/3zGfekHL0fXnJ9QsXdlFaEB019gDEjZY3gvsg5MtZ95SqkqSLCukME/63gloA==
X-Received: by 2002:a17:90b:1481:b0:2b4:329e:eabd with SMTP id
 js1-20020a17090b148100b002b4329eeabdmr11839683pjb.2.1714957466175; 
 Sun, 05 May 2024 18:04:26 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 25/57] target/arm: Use gvec for neon padd
Date: Sun,  5 May 2024 18:03:31 -0700
Message-Id: <20240506010403.6204-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 target/arm/helper.h             | 2 --
 target/arm/tcg/neon_helper.c    | 5 -----
 target/arm/tcg/translate-neon.c | 3 +--
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d3579a101f..51ed49aa50 100644
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
index bc6c4a54e9..a0b51c8809 100644
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
index 2326a05a0a..6c5a7a98e1 100644
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


