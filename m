Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06122C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZY-0005O3-Hm; Fri, 04 Jul 2025 10:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPU-0003P3-Sb
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:08 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPR-0001p6-GL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:03 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73a44512c8aso341602a34.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639340; x=1752244140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyEWmMp7L+dAr0fEadjY9idDVfgXR6Setv1KsNsB/Sc=;
 b=ItYMyCzXYPXHKawzNwWs8pftGWaAAhaVFWm3tLtRoUP5fLUZjIXSOj/HTXaELdDUHq
 RB7EpX8DOq5ppy5ERvS0hJBX++YGDGy9KfmTWdgy+Yn2m958g49Ab4GYPnsWbPOY/11A
 igyMODBRrTszHFJ+kke/DtGq6FeERGvZU3nqUC/w3cWqFCPjASpj4dddtHzd54ueaxrU
 Ipshfy4Qlji6rpphKueSPsBmc0ga1lJkHlW2cTLrDVY6YI2Knhr67OIOvwrDiKBRfZN5
 73KfOBGyPWAY5vkz5Y5H56V1I2mpxg8b9pbgnqsMS4IMPB+R0zDI0IzITH6v8pTXOeGb
 gXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639340; x=1752244140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uyEWmMp7L+dAr0fEadjY9idDVfgXR6Setv1KsNsB/Sc=;
 b=AKmyCnARPBkC15Y6u5QBT2qHusu5cy8/ZWWvZ9EhNGH3XnaxQZQ9wXt+4PCRIGIIM9
 iuwunYtRVrKhr6ZOk+Imm5CCs3EfrnIq6QDbLDkbTmcK0szbo9NmYHSHLGuCxGlSlLbo
 txT41HqkOThqBJWy4tUkPKTqT39hbWQARz+ddJS6+B1Mf3OZe2rbd3eCZKEGX/C7zo2L
 UBS9WUzVOF6RELehj0Ww6hcoFN+iPxb2zREIGJUbjicPp8cL0fp/gCSrj7+tsXdi77Sj
 wl/j7oGHTHtny2R8705TmGa/x83+wtFoRaQJXq9+OcT5v3x7lIqfDeP1GM+nfOpny/9H
 STsw==
X-Gm-Message-State: AOJu0Yxm2VEm0KrW1QEWow9eL01VaUSwrA/TeBZuy+gd2Hoa+6VWGjUl
 +eJjZ5TVtHbhksOICrXGv2YWM7ZB1SCA7L/cMnWQp24+53OBqK/epity2EG5C3fP9ovk89qHpH9
 +kYPW+RQ=
X-Gm-Gg: ASbGnctWluZTFkFFZsVRN7ut8RJBe1nAwIC4+8PlKzXHAIrwO42nZmvv2VUepcH9ASx
 6tRRczoGLpnYulHv768whA83v6jA/VaNlgxwYHl+2RigQ551zPf6nhUVTSs+lTvlpdp11LF79jN
 jhG8KFvLixJ/yKW7a9sJ6OihQOVRf4kZ5TIimrO0k4igtcUx5pMc1S1xSlpNUJv4JDxL8x1sp4Z
 13MIsL76dSTrtdf//EPa8Eeum8iupFgYSXFO6bwPHbrItT2ebU83gvXgelQqeVM33J7UzTVTH7j
 D4+ftoznpCz5+dN1ocwJFUs9f/kL6d98ppWCAp/a3wHYPoUEUo6Oo64BjNqGCbbn02qqJZhAx1n
 Myc5pBElWwJyjWG8sFuLfzI1UfNLtmGHAZJImCeb0lE7r1+eSV76zlE5kHpc=
X-Google-Smtp-Source: AGHT+IFsvRnvR9vO5mb2y5jgGgCAmH4HKU79xRxfgHV0DNM06UUVvJg1KcMaoHdz/pZasVdj3LzrKQ==
X-Received: by 2002:a05:6830:8008:b0:735:22:7cad with SMTP id
 46e09a7af769-73ca48e9df4mr1323294a34.11.1751639340271; 
 Fri, 04 Jul 2025 07:29:00 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 101/108] target/arm: Rename FMOPA_h to FMOPA_w_h
Date: Fri,  4 Jul 2025 08:21:04 -0600
Message-ID: <20250704142112.1018902-102-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The pattern we currently have as FMOPA_h is the "widening" insn
that takes fp16 inputs and produces single-precision outputs.
This is unlike FMOPA_s and FMOPA_d, which are non-widening
produce outputs the same size as their inputs.

SME2 introduces a non-widening fp16 FMOPA operation; rename
FMOPA_h to FMOPA_w_h (for 'widening'), so we can use FMOPA_h
for the non-widening version, giving it a name in line with
the other non-widening ops FMOPA_s and FMOPA_d.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 2 +-
 target/arm/tcg/sme_helper.c    | 4 ++--
 target/arm/tcg/translate-sme.c | 4 ++--
 target/arm/tcg/sme.decode      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index c9961d6b7f..67d620e456 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -135,7 +135,7 @@ DEF_HELPER_FLAGS_5(sme_addva_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addha_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_addva_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_7(sme_fmopa_h, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_7(sme_fmopa_w_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 424fc006be..1575a2f20c 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1146,8 +1146,8 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
     return float32_add(sum, t32, s_std);
 }
 
-void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
-                         void *vpm, CPUARMState *env, uint32_t desc)
+void HELPER(sme_fmopa_w_h)(void *vza, void *vzn, void *vzm, void *vpn,
+                           void *vpm, CPUARMState *env, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d38b8a5ca2..1167aa4964 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -565,8 +565,8 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
     return true;
 }
 
-TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
-           MO_32, gen_helper_sme_fmopa_h)
+TRANS_FEAT(FMOPA_w_h, aa64_sme, do_outprod_env, a,
+           MO_32, gen_helper_sme_fmopa_w_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
            MO_32, FPST_ZA, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5a5b8ff8a5..77744eef4f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -190,7 +190,7 @@ FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
 BFMOPA          10000001 100 ..... ... ... ..... . 00 ..        @op_32
-FMOPA_h         10000001 101 ..... ... ... ..... . 00 ..        @op_32
+FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
 SUMOPA_s        1010000 0 10 1 ..... ... ... ..... . 00 ..      @op_32
-- 
2.43.0


