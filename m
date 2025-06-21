Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E246C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83R-0005ww-7f; Sat, 21 Jun 2025 19:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82I-00024c-RX
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:15 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-0004zB-1T
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:14 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2273459b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550049; x=1751154849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YA/ssCHXSmGBp4eSC0q7UmNykTa9bkmVSXKbmxAWP7o=;
 b=nnbzeuuR5o2dUogvplu4j7FC7kyem6h9XaQSR4LYByAOCRlaWgz1k4xtCf5ooRZR7W
 qBArTZgtLC83mdUy3UYOnWHGwZgctc8u5yi6vpfkR4L1qrtXrpAATM0QrE9xzng0LsXO
 AOozQNRT+4A1ea1HGM6lCKeYSFeO6SBqHpCLPQK8nPqgYFXKH6MIeowiQLok+CutYP9b
 35QbPXb00yDHXaJLh0kmiYbmDNzd+Cyk0fBYYjrh+vudEI4hs7MxQ0Pyv9GQ7lGDGoAm
 SWcY7Ikvh73VMFtCPYVrERWn0eIhr8COc+Vn/Sxq/ZlIh5G07U/6gy/PIIfVhWv1qgv4
 b5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550049; x=1751154849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YA/ssCHXSmGBp4eSC0q7UmNykTa9bkmVSXKbmxAWP7o=;
 b=Z6M+GpdrGeW+leqJjNnF7LBFDTOwtyVdXPJTUZT6KsAQaIZI8GraKKBagqycOi0fg1
 BQjhqXs+FxvY6hrcvEOLpwtB4jOkz2h/JV8kM3cZLlY/Oo53G3+snUDJdQXM0s8mMcay
 z+Wzrp4nvjWOfQJGQBepvnMSThgd1gwySfTft9yNsjJGUw0nVAur5YUVH/4DntUFog62
 l1JSFInDnZOP2y1rsCSY/flP7iHX9PdRrubBOOgQhaj1b414yH/WjuONAjVfw7PErgwt
 07ymlkHe7mtXnnpUpydlsOlo27ncjTn2qPzk06fQ8jgOaDdQ3y5tShG81tYHQEuhrTPK
 eNGA==
X-Gm-Message-State: AOJu0YyohKEJm0TrmXuy4VZGhQnKcKIav+NpBWrUECIwzTyhsb/rD+z5
 x+7I8qDGDLsmXCY6e6S7uuLZqPFTpTNzDD222KoN0yQx3vWG9QxtddkoonHkjM8gq4Y74TM0+gu
 ls4dmLe4=
X-Gm-Gg: ASbGnctHv5EwgTMrDWoVnVuIPrBBMVauDOb/JfL5wz23HFL0IcRk0WJbKqnXISOnGMP
 0iZaz/PQ1CfkzY2RrFWNnZMOvNbydi1rTyld/yDYElGnKclewXfpVRwZ8pgwzyS4DZI5p3hZlYg
 oYTeJDZj/c3LoggZ0vtCH1znmu8It4D5Lw0thWc2R1/wmlAYlDMxT3AafHjvOI7RLS+tyCAeeRW
 53//hzR81U1m2hM4zmUhQBRdiifG+fiDUk/kEg+jRQ+LVbG3k5ziQzl4ydU8/NORBrIXHMg5C1Y
 PDNI5J5KLiW6gaGN8VlP3K8Ik8vtoSa2OPBRwdi3IKxzsm5ftiPUlIQ1iua7xcikdTCv2tQ8t5T
 vg7i3N66r7D/a9NyP6VsNnpFqmES7lDk=
X-Google-Smtp-Source: AGHT+IH7PUoIAvi4iMYYsuBS6XWhUh4NuzcW3paDrliMwQ3lMF11bkjKGSWFt8eYkOA2ShstCyCpyA==
X-Received: by 2002:a05:6a00:8783:b0:746:1c67:f6cb with SMTP id
 d2e1a72fcca58-7490f4bebdbmr8627075b3a.5.1750550049429; 
 Sat, 21 Jun 2025 16:54:09 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 047/101] target/arm: Rename gvec_fml[as]_[hs] with _nf_
 infix
Date: Sat, 21 Jun 2025 16:49:43 -0700
Message-ID: <20250621235037.74091-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Emphasize the non-fused nature of these multiply-add.
Matches other helpers such as gvec_rsqrts_nf_[hs].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h         | 8 ++++----
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/vec_helper.c     | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index fa44b34dd5..3fcda30f9c 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -780,11 +780,11 @@ DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
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


