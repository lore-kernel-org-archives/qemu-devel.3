Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54736C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg848-0008Ow-Ny; Thu, 06 Feb 2025 15:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83R-0007eM-85
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:53 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83O-00016w-Lt
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:52 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f9d9ee2ec2so2031736a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872048; x=1739476848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iYDs9XcESAd110lFAeQOGp7QWDlkLwtk3ASQqlfRvs=;
 b=V8qMSbhZqkII01z9V8+0vFcytlXLOOe+3asEEKpPe2nag10XnejfGje9Ug5uwuz/lk
 dJZsTAiFRgbegdY7zyrejtGNhw4w7L0Wf5F0ABGxcyPnA5mFLEFQHW4ZA+Jylg9v1MkP
 Ea89n+i+rF6rktZCOUnvly2RTUSKKcQXMBF2gF9ss4rfaNGYa7hHu0QAYNnRy+/sdBtj
 mdzAsMrrOjjN3WWWVVdx3TzEQBUv3pseSu15381u8w62t0Z4aLsQBQMPy+xR7sZ0veZn
 rikLWSF0K430DKqAgYJl2X6lDrMxp8blvnJdbMk8F+wt0vJurK6+C6QenfGehI7ERCH3
 +2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872048; x=1739476848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iYDs9XcESAd110lFAeQOGp7QWDlkLwtk3ASQqlfRvs=;
 b=w4T7EnxWqfcePIYKcuDJPV4IgJ1ls2Hy57XVgFQmA5k/ryQz8kqwG4vc4Al3NdDEbw
 bPe+eMv21z3q0bC0vz1cjvOg1CDuPZJ6TKNYYyjQ3YuQcUM+syzLFa8cWdyFbmeOmf71
 OPnLlbec6U3RhJ49TN1vNtOBXK5WZSsZqoq8lbn83pkV8uQV41W85M+o/qedJUvYLe4s
 nJO5bfUbc77DNIeVIe+bWhzWk/ri3YDB/whLnFw7/Mq7xqmunFNccCLRji4e2py/5Zg4
 I+L8F9Yq/22Kk/EYUkRf6A0DXXwNsWIfCfviqvFzk4OqFQcbWraBSNJm2Utw8vyo01aU
 Bg1A==
X-Gm-Message-State: AOJu0Yy/xH81fb9pQY4y3gGF26AE3qlYt86wDwPTrcn25Ej4YsWiR+kc
 yRWGRixSLsOA5ZY7Sr6IIZSxfxHSxBZT/ZkxDL7bXdnGrgJWsF2kqx7NBS53rQYZb7GGRv+NXRj
 m
X-Gm-Gg: ASbGncvVmm1/t5CTe6wLauzHqE0T2qprS2+IHUys/f5UQmBZWJvlGchia9aavPGLao7
 c1MIOzqaTKZOUZ3HPoMKQY17HoZ5PjkaO79I5Kv60OA0U7ZC7jwhrtvN3VBm/HJMLKm22PC9CgB
 6qIXvalj3KiRW+9Hs93YmzkBvdYlJc5nYyeffkk7m7igYuH2N2y5Tf7UUiCksriQ374unowaAT5
 BfCdVnUyVifgolDFFGlT5hPULMZfmP5uV6yLpV2NFXhEzKxitvNAkNWHtKuk/wU1/0M4Us2yjOd
 boJemoeJnXC12HLvCtk5jX9fl9dqcgX5bV0LCXg+tvYz6CM=
X-Google-Smtp-Source: AGHT+IFg9qdJgJN6e/xkj6GiSDaJ+XiblL5wEQTvvmT/Tsb0w3YtLYUbv3gRzbVw3zjsZsPgu2elCw==
X-Received: by 2002:a17:90b:3c90:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-2fa243ebde4mr405208a91.34.1738872047685; 
 Thu, 06 Feb 2025 12:00:47 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 41/61] target/arm: Rename gvec_fml[as]_[hs] with _nf_ infix
Date: Thu,  6 Feb 2025 11:56:55 -0800
Message-ID: <20250206195715.2150758-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Emphasize the non-fused nature of these multiply-add.
Matches other helpers such as gvec_rsqrts_nf_[hs].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 8 ++++----
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/vec_helper.c     | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5509486aa7..b00b79c12c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -776,11 +776,11 @@ DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index ea04336797..844d2e29e4 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1010,8 +1010,8 @@ DO_3S_FP_GVEC(VACGE, gen_helper_gvec_facge_s, gen_helper_gvec_facge_h)
 DO_3S_FP_GVEC(VACGT, gen_helper_gvec_facgt_s, gen_helper_gvec_facgt_h)
 DO_3S_FP_GVEC(VMAX, gen_helper_gvec_fmax_s, gen_helper_gvec_fmax_h)
 DO_3S_FP_GVEC(VMIN, gen_helper_gvec_fmin_s, gen_helper_gvec_fmin_h)
-DO_3S_FP_GVEC(VMLA, gen_helper_gvec_fmla_s, gen_helper_gvec_fmla_h)
-DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_s, gen_helper_gvec_fmls_h)
+DO_3S_FP_GVEC(VMLA, gen_helper_gvec_fmla_nf_s, gen_helper_gvec_fmla_nf_h)
+DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_nf_s, gen_helper_gvec_fmls_nf_h)
 DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
 DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
 DO_3S_FP_GVEC(VRECPS, gen_helper_gvec_recps_nf_s, gen_helper_gvec_recps_nf_h)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ce7f55bfc8..2d2a000a4a 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1667,11 +1667,11 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
-DO_MULADD(gvec_fmla_h, float16_muladd_nf, float16)
-DO_MULADD(gvec_fmla_s, float32_muladd_nf, float32)
+DO_MULADD(gvec_fmla_nf_h, float16_muladd_nf, float16)
+DO_MULADD(gvec_fmla_nf_s, float32_muladd_nf, float32)
 
-DO_MULADD(gvec_fmls_h, float16_mulsub_nf, float16)
-DO_MULADD(gvec_fmls_s, float32_mulsub_nf, float32)
+DO_MULADD(gvec_fmls_nf_h, float16_mulsub_nf, float16)
+DO_MULADD(gvec_fmls_nf_s, float32_mulsub_nf, float32)
 
 DO_MULADD(gvec_vfma_h, float16_muladd_f, float16)
 DO_MULADD(gvec_vfma_s, float32_muladd_f, float32)
-- 
2.43.0


