Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CACE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEq-0007wg-7H; Tue, 17 Dec 2024 12:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEn-0007vu-VQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:02 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEe-0006Bm-S0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:01 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso2787608f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455989; x=1735060789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vKeiMa5G9lGX+jdw8oUEa3hznhK/1jD0/IOXSy3bA/8=;
 b=X7XjMse79naiNsMOnLTQOjepVIPk45I+jCUEm5rszgr8NpnouTgHEhTQw8cbYB2Bv4
 FXNuO1A/3drTOVE018MWgyM7kgcvrL5l4TP74C5Gw9llw/Mjj0z1cRJEtQjcAyo7UASV
 PxaeHD75pnT1zaBs6fFWqYueA0JGZ9g0U5HbYdDsrVseZxlbXDhrY+m8jgjElm1CXKXg
 HpNxipdLIQim4h8aCpkAQRDQTwsvnG7yqu2g0DtJeXLU4C0G0p9Jb74P/pQMFHJIeUC+
 xERI2aOnK2hzU7rabM6UgP7R+q9ieDmf0PwH6FStX12RcEZQpc8o/X+HbLP5TDD0DhsI
 Zwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455989; x=1735060789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKeiMa5G9lGX+jdw8oUEa3hznhK/1jD0/IOXSy3bA/8=;
 b=Uf1EG+wDFZSm7AI58KX6znpJ18PSkVnwp261S9/UYkAv8jsZNQWB7cMDQwd7ct2jQ6
 8gs0jlYgjv2cYXIv2/bb2zl0kEwDeO1OYjnQRR2VDd5cintKqf8BcBdzfBgD+B/qS8UZ
 0rTSbOD54cIuxGnYqZ2ztmK5WsKLKduATwOTCDx5+ziAYjc363qWJRrq8TdmbA60RW9r
 ydGc7Fi6MjKDFc8HV8YRi5OHBdECufVN96TMvjf+gZ3JBvEYl7t7ZG+9FoRUgrvpIyFv
 H3SfJ2YtdY3JtqeTfR8PC+1rceu/BVr+0c0inXnThMHjeMIN+X0ZF7E4mONrtCZ1s/fL
 IUGA==
X-Gm-Message-State: AOJu0YwVMKrPYtst+xv/bBARvXnA3WHXXJclM0ODGX+rXjryJiouwOhl
 S7KH394qeAABl/878gW14iWxr2KFC2tryDmgkWONo2gSGgzJP/YCrvbjzfYpO0t/7ZN9c/jJ+yG
 o
X-Gm-Gg: ASbGncuP6yaZR9Ddi8GEuYV4xdHSlVMhcKAs515UbeK5iiblSyUXFLfgieVWZUZajI4
 YDf3tAdTM/pMYrcHx+Z3R+WdvR3cZx0UKP+tTEJYKwAbUQwBwBFCkxlscrqWwXwLzSKRlDQ+/kE
 jyPWlCiYatBESimcV/IgCrxk3hbPBpb+qhkScgyZXWpHjoXa8K6xBkMrs3Zaov/tFB/Ekfg+nF/
 GNYKsg8j6lWC/7nMZnIzMHMZy9s0NDrFBk4Fw89NpurQt1nxe/1Ot7lp/LJbX4=
X-Google-Smtp-Source: AGHT+IEfyQXx4M6jTDQ5VivnfeOshyYJNs/Vj3wJSuYC7DfL7dCXkdZKVte6jg/UDV1EdyAFD3vKdw==
X-Received: by 2002:a05:6000:4b12:b0:385:f6b9:e750 with SMTP id
 ffacd0b85a97d-38880abfbabmr16665224f8f.9.1734455989229; 
 Tue, 17 Dec 2024 09:19:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/19] target/arm: Convert neon_helper.c to use env alias
Date: Tue, 17 Dec 2024 17:19:27 +0000
Message-Id: <20241217171937.3899947-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031224.78525-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h          | 56 ++++++++++++++++++------------------
 target/arm/tcg/neon_helper.c |  6 ++--
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index bb241df8260..707a8daabb0 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -310,34 +310,34 @@ DEF_HELPER_3(neon_qrshl_u32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrshl_s32, i32, env, i32, i32)
 DEF_HELPER_3(neon_qrshl_u64, i64, env, i64, i64)
 DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
-DEF_HELPER_FLAGS_5(neon_sqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_uqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_uqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(neon_sqshlui_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_sqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(neon_uqrshl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_uqshli_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(neon_sqshlui_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(gvec_srshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_srshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 99fbebbe14a..e2cc7cf4ee6 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -130,11 +130,10 @@ void HELPER(name)(void *vd, void *vn, void *vm, uint32_t desc) \
 }
 
 #define NEON_GVEC_VOP2_ENV(name, vtype) \
-void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
+void HELPER(name)(void *vd, void *vn, void *vm, CPUARMState *env, uint32_t desc) \
 {                                                               \
     intptr_t i, opr_sz = simd_oprsz(desc);                      \
     vtype *d = vd, *n = vn, *m = vm;                            \
-    CPUARMState *env = venv;                                    \
     for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
         NEON_FN(d[i], n[i], m[i]);                              \
     }                                                           \
@@ -142,12 +141,11 @@ void HELPER(name)(void *vd, void *vn, void *vm, void *venv, uint32_t desc) \
 }
 
 #define NEON_GVEC_VOP2i_ENV(name, vtype) \
-void HELPER(name)(void *vd, void *vn, void *venv, uint32_t desc) \
+void HELPER(name)(void *vd, void *vn, CPUARMState *env, uint32_t desc) \
 {                                                               \
     intptr_t i, opr_sz = simd_oprsz(desc);                      \
     int imm = simd_data(desc);                                  \
     vtype *d = vd, *n = vn;                                     \
-    CPUARMState *env = venv;                                    \
     for (i = 0; i < opr_sz / sizeof(vtype); i++) {              \
         NEON_FN(d[i], n[i], imm);                               \
     }                                                           \
-- 
2.34.1


