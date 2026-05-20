Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D01ACD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlcy-0005C4-AU; Wed, 20 May 2026 14:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcN-0004Jp-29
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcE-00029d-Rb
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b941cd869cso33203785ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301557; x=1779906357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Pxlgby8qcltoDk8xASbSaE+nJXYWZe1viWUFc7OgMk=;
 b=HVmqzLgD7JDYP49PM/2a3dwL6S9XXUqhTgJwLsDDAJsmzMOIuLxMYuwiIqP3fAXkcQ
 14qX2T73sIP1351jS1wTe8e7/v4UpA2B1tRIdN2nft+uuWdb2eVxicAF2zBszGbFVo71
 A92RWI1dH9R0SxDcxp6wOeutAsZtm4SZo8J10pqkHZYuP81ZTOPEKEITg/qKgkLUa7i8
 njwtYM9YKb/0m6+DEOq2vQVfzYDdd+Rgv8A8ckmAaIcIwkns4CkY8xrND3LsE0vuvt0a
 XDW3Px3WCg15WfFoYnBgm03I4V8g5VgRf62xZicWfqxc+BYxsQ+dZj6hLMYeppLExhUK
 QBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301557; x=1779906357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Pxlgby8qcltoDk8xASbSaE+nJXYWZe1viWUFc7OgMk=;
 b=rAGukTZ9PLI1tF2HYA195Ep/KCITa+t2pPIvqxlBNS45cCmsArm+5k2olg8yzGwly2
 5aSgaUrHbl8QtHjdWcKy+L6YP7TUqX+4zDZYIXyo0U04vx1rGUJkNzDQoOmvr5BfUbgm
 RnwbMw3vSk3CIjmGJfxrKECJd6X2T58h1KgROsxbb4zffuIwnD4fyEZtkWw5rTJrBSLt
 QbOWa0cdFvdTiySY5roUY5ysyRoSZwd09y6S5eTokSS0YlDuZyYMzM0JkIC1uFCTJPJT
 ROm/LZj8WovvxKzz470uoyvpPXI7p/ChQU8Jjdxn7XHU60/+afgOV+Uz1OF/MpgSvdA2
 cXhA==
X-Gm-Message-State: AOJu0Yzp7oKP/FqwjiN8WrtLAP/SgU+y6frKSFlV/UEZNEBUf0aLYTSG
 Tz+4BHVmlX1kstjc7fu/zU0gSvd6cGZA0n8jzOxv4bE9+ybD++OxsVSgNnwenp5nsRrdZ8qYLou
 B/Te/Qgs=
X-Gm-Gg: Acq92OF2dxH/8uaObeDU47JdGq3/ICC/BjhraJqBIRUxSdbVCUh4TEm4Wx8UfqLf1qP
 eh4iVoPc4l63ju6yZUJjQh3EgPrXSDX4/KhUg+zOMXfkycSpxaGkMbx/sU/Yn9blIAG7wcB9bXP
 M11UpQwbfyAT7fkkVnCqXrqQ2VierAK73J8STYmd9fmmSc/CtEiT0Xw8e64rLUhUa+U9tEN+rY6
 YleQ6yFvAvqxODmR/9qgRVgdQJuw+X1A/wpMfKf7w56WMdvYMRBmMNx5AC/xRp2ZbdoKpzI8AYx
 5sv3v5X5C/zLNYSZR+iUTmfyaVV0EmmpdBFBTHQmEEP0hOCdglPmm0VgmJLhQ1IHzrI7dvh4zhF
 sJksmGfZ24a0O9OXUWq6DH6qc7RW/emo4TclBWH90Pk7/tvhbRm9ojQmdAdNuwDbsAIZQtRJHCU
 GTOmB5NoqOvom8w8dTJNW6iwkqTnZc
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id
 d9443c01a7336-2bd7e9e263emr258594815ad.40.1779301556819; 
 Wed, 20 May 2026 11:25:56 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 57/64] target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
Date: Wed, 20 May 2026 11:22:06 -0700
Message-ID: <20260520182213.872945-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  2 ++
 5 files changed, 35 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 90098c3cbe..67b9d7e982 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1620,6 +1620,11 @@ static inline bool isar_feature_aa64_f8dp2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8DP2);
 }
 
+static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5995d77577..3c74f02022 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -35,3 +35,5 @@ DEF_HELPER_FLAGS_5(gvec_fdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index d3bbea1735..160850be53 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -807,3 +807,28 @@ void HELPER(gvec_fdot_idx_hb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 16;
+    uint64_t *n = vn;
+    uint64_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float32 d0 = f8dotadd_s(n[0], m[0], 8, d[H4(0)], &ctx);
+        float32 d1 = f8dotadd_s(n[0], m[1], 8, d[H4(1)], &ctx);
+        float32 d2 = f8dotadd_s(n[1], m[0], 8, d[H4(2)], &ctx);
+        float32 d3 = f8dotadd_s(n[1], m[1], 8, d[H4(3)], &ctx);
+
+        d[H4(0)] = d0;
+        d[H4(1)] = d1;
+        d[H4(2)] = d2;
+        d[H4(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c5ea6b27a9..02d5e007f9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7418,6 +7418,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
+TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d1254355b6..6404c26540 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1216,6 +1216,8 @@ FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
 FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
+FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


