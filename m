Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A78C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYD-0006L9-Ar; Sat, 01 Feb 2025 11:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYB-0006J8-3K
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY9-0001Aw-Bb
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:54 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so1825828f8f.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428052; x=1739032852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vpMSdd/6TkdfCRr5FCGHe6DC8lmbsXPDu8N06iR71b8=;
 b=W+fnfKXAHxNd11GVJe8XfgbUnp0j6bMQ5X69kNssREYBq9X8IlDtRbdUiuxiW+ZZ2K
 S08dJXBaE9VxooHwswqQncH2RzbqzTQ0wZFv/cmWgU5Zmrgo1A/odGnSNS0+o4LDJ1C0
 u1fQWFueapgf3J8CtUigXuo0qAbo0FMrIHjAkch8AQNbv4P/yNvrjOydlwAZrZw7dcwG
 C6x/iYFzkCYZinWQGr8GUbro8rBr3m/NLDdv3QfErPdcMuj1Lqkd97+NEfFEvv0ba7r5
 0wYTxgB9M7OZRrVV0ukYGfIRsWZFtQeS/vv8bpLS9YUKxp1Mv59zhn2gYFrc9tI5ZnDP
 nJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428052; x=1739032852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpMSdd/6TkdfCRr5FCGHe6DC8lmbsXPDu8N06iR71b8=;
 b=gsmygBeUs1uQzuQs+G8xlKxR7CG3IuJPsGjXLDgZVCWmeOQyxm6QsAiA9iy5RiMtm7
 5dVfJkBJKpbB6ZYzl91/6RzhE2m3lIRsy80/zPN91LCQyZ+NH5GgPCE+Hk1zu3xmsjGX
 VnndUIW8hcGrbbheWEmGYNmTuqPrVq5WVA48nmikPfA9VSTNO2fOGErE2PMAzrrvb3rj
 TnhS4uFG3TTkZjz8ZwXVQRtWJrDq0rshKxtTQNZiG7xl1uazLz0Y55DDg4OmBZ5gTGLv
 HWaFGChU2Jx0agPH97KqI99yP0n7M6w8wYEdfjPGFKAAHdqXFcTGddbyY46n/4e40MTi
 95Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXisx7DVHt4Jbwqy4Nef3wheJpaU96faT9/dTco/e7+erUjWvBfnYBVOuLzn43dxb+v76J8ceu9dvKg@nongnu.org
X-Gm-Message-State: AOJu0YzON6eQZXKkiqdxTIoeujsBxCerXYGlnRUvsz6nUoW9slQ4DhdO
 4ut9ZMhcqC5TE7QNWfRAFn9LwooN7/zy+nkh7Qtj3ky8vhgeWon9/rabkD3Ie8g=
X-Gm-Gg: ASbGncsdi8FVl6GKb2/Sef9ESuGU+NVSxulE2JpJEMhSj7TDUC+I3gCNP/yBjAk2YKF
 CLG11ohMpCE4fIiyWpi76Z2yNmh8VZPd6CcHx7CtySECo9qX3RjLs3kCPQYXY2ulCGmPF9HRRIX
 XoqW1sljelIZwo49CXdoaWZwOZ4x5tyfoktls6o1t8M3KEDFev4IRKUtiLzOa3s0AWWXUdcroHZ
 KfbKZlIVqG21AFGJo3oZHZLID9ZvUGVMpDJKWV+yEdIXuaVFo7BGOItVekcbvHSVMHHnUlaKKeG
 C0kLVTknMxgUAhi6RC+t
X-Google-Smtp-Source: AGHT+IG5QU+j8mAMrBLukwFrXsV3oPgqe72EShZrkT9181aBgyjDL1RWAHOHlOf57VM+rq8D0bKBmA==
X-Received: by 2002:a5d:6d84:0:b0:386:3672:73e7 with SMTP id
 ffacd0b85a97d-38c60f149e9mr5800661f8f.9.1738428051902; 
 Sat, 01 Feb 2025 08:40:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 27/69] target/arm: Implement FPCR.AH semantics for FMINP
 and FMAXP
Date: Sat,  1 Feb 2025 16:39:30 +0000
Message-Id: <20250201164012.1660228-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Implement the FPCR.AH semantics for the pairwise floating
point minimum/maximum insns FMINP and FMAXP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
 target/arm/tcg/vec_helper.c    | 10 ++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index f1b4606f763..8349752e99b 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -986,6 +986,20 @@ DEF_HELPER_FLAGS_5(gvec_ah_fmin_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_ah_fmin_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_faddv_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 80a6562ed51..7af727b606d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5776,14 +5776,24 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxp[3] = {
     gen_helper_gvec_fmaxp_s,
     gen_helper_gvec_fmaxp_d,
 };
-TRANS(FMAXP_v, do_fp3_vector, a, 0, f_vector_fmaxp)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fmaxp[3] = {
+    gen_helper_gvec_ah_fmaxp_h,
+    gen_helper_gvec_ah_fmaxp_s,
+    gen_helper_gvec_ah_fmaxp_d,
+};
+TRANS(FMAXP_v, do_fp3_vector_2fn, a, 0, f_vector_fmaxp, f_vector_ah_fmaxp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminp[3] = {
     gen_helper_gvec_fminp_h,
     gen_helper_gvec_fminp_s,
     gen_helper_gvec_fminp_d,
 };
-TRANS(FMINP_v, do_fp3_vector, a, 0, f_vector_fminp)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fminp[3] = {
+    gen_helper_gvec_ah_fminp_h,
+    gen_helper_gvec_ah_fminp_s,
+    gen_helper_gvec_ah_fminp_d,
+};
+TRANS(FMINP_v, do_fp3_vector_2fn, a, 0, f_vector_fminp, f_vector_ah_fminp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnmp[3] = {
     gen_helper_gvec_fmaxnump_h,
@@ -6775,9 +6785,16 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
     return true;
 }
 
+static bool do_fp3_scalar_pair_2fn(DisasContext *s, arg_rr_e *a,
+                                   const FPScalar *fnormal,
+                                   const FPScalar *fah)
+{
+    return do_fp3_scalar_pair(s, a, s->fpcr_ah ? fah : fnormal);
+}
+
 TRANS(FADDP_s, do_fp3_scalar_pair, a, &f_scalar_fadd)
-TRANS(FMAXP_s, do_fp3_scalar_pair, a, &f_scalar_fmax)
-TRANS(FMINP_s, do_fp3_scalar_pair, a, &f_scalar_fmin)
+TRANS(FMAXP_s, do_fp3_scalar_pair_2fn, a, &f_scalar_fmax, &f_scalar_fmax_ah)
+TRANS(FMINP_s, do_fp3_scalar_pair_2fn, a, &f_scalar_fmin, &f_scalar_fmin_ah)
 TRANS(FMAXNMP_s, do_fp3_scalar_pair, a, &f_scalar_fmaxnm)
 TRANS(FMINNMP_s, do_fp3_scalar_pair, a, &f_scalar_fminnm)
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 9f77aa6b919..61e6e54570c 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2444,6 +2444,16 @@ DO_3OP_PAIR(gvec_fminnump_h, float16_minnum, float16, H2)
 DO_3OP_PAIR(gvec_fminnump_s, float32_minnum, float32, H4)
 DO_3OP_PAIR(gvec_fminnump_d, float64_minnum, float64, )
 
+#ifdef TARGET_AARCH64
+DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
+DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, )
+
+DO_3OP_PAIR(gvec_ah_fminp_h, helper_vfp_ah_minh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fminp_s, helper_vfp_ah_mins, float32, H4)
+DO_3OP_PAIR(gvec_ah_fminp_d, helper_vfp_ah_mind, float64, )
+#endif
+
 #undef DO_3OP_PAIR
 
 #define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
-- 
2.34.1


