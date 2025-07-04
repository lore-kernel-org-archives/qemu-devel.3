Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37DCC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhPY-0002tt-Q6; Fri, 04 Jul 2025 10:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLh-0003w3-FL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:18 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLe-0007ra-Lq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:09 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73adf1a0c48so633166a34.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639105; x=1752243905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82A064SU2LUhD8rTioctnax35EtJD6goQBRa7TkwAiM=;
 b=D4RxNFYK25IFSfqAfGURr59D7SoO6kiKMB6Cq3mGPwBqmiScVSDaWR5cm45UEMnPo9
 3BTLPVnaVYJMenMmSUT+mDycaSQ436OnpXervXsAjDFnp18PYHu2OC6h5znI/Ioi4Djh
 kqnLSVeuXNjb8v2pQdgi+/J6fwgNE8Tl+FLeotEfBi1N+aNfvnH8wJcOrImc3yZY+CRU
 +nG3hFC7MM2d5kPBar/EtbN0FwqyXSQN0jRw5Q169S8p6o7pXydmrexIBi+A+P0bqs5Q
 9zF3s+yfQcfFBnL59WsdZ+dgfibDdo09tQ+rBERDYlqtezHVJ6pFeshjQh7p7VC+GdXK
 /tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639105; x=1752243905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82A064SU2LUhD8rTioctnax35EtJD6goQBRa7TkwAiM=;
 b=QvS1d1RozyQP+L8iy+Oh9eDzeurO+MuZoDD4J1Gfviujb0bsB8jL04T+14CjprnK4M
 8a/d/qXOD0QdOuXl85AI0RE0K/JI5FoCXOM+TvmmxSoamcyaOzXU6Rw6IxKPTvKNUqfT
 I0Jq72hA9TWA6JjBW4Go7UvxbmknIrMNhnVndF8Iu5XVY6vkDKggqUxnqMpgHql2bsRE
 jzgEYTIMlI10/c28Hi/DW6wi66oHyXOHMESUO3v4Sv221AoNRGnSobIxYm/QycSjNef6
 v5/nK9KhgmzxS+eRQXHFblzl9J36qYKsomolYn+yGvb1yWQGb4KEeKj/qaUbifkkEdp4
 ljew==
X-Gm-Message-State: AOJu0Yxida2uMI8pnWFEs+dgVKTjbyK8IPHgvBbkUs1sFhy8WQvWSiXX
 Q+drpfd5qe/0Jft0Dm0xZXcQBMqGZX/EfAtKEMYyLOMlutrzkWVp8b8UBvZpj6zmmZtq01oHd2k
 oeWAkvT0=
X-Gm-Gg: ASbGncuTw09CqWWEShZT8K24xrBWjHjOPMDbDFqO8BkwGmuK7pO74gHjo/oS2W+zsWV
 OtEyQy7i3HRT9U8fuRZ+Bh66nKlumFR/OMHo4PIXP1pL2irjwXyTi1xcfdE5n8dnL9I05zhdBJN
 IIn8HUeb2qSj7Sm/HxIg0vAzZSC9TQ7U+Pg+Bj/tQVZKpFsUsUvMDNjwMeHEVQn+tX7+SGMSJC7
 3Nlawt41JRq4s9bpEp/mW5U0S5TzHgDb8zf4xUMFSVdYaI5S+GCg6C34Y3YdJvSPo0f4cV/9pr7
 nDvy28SYxp5unTWqj0GqlTTKWgl7qBFympZq46XHTqpTpEgKgibVgQ2cc04esn9C8LH0G9VSeKz
 VYhNGrSGHArNjLOa3SEHoIENkHOabfCSCAviYPv3FsdpkSzEe
X-Google-Smtp-Source: AGHT+IHn7u5NiynNRHi7mbOeCdz4ajJZk51j5SJXLlTHjEMamc+a/EWL9E0Ux2ATNjY1QUkJ/SFoAw==
X-Received: by 2002:a05:6830:6110:b0:73a:8ac5:a6d9 with SMTP id
 46e09a7af769-73cad676353mr920125a34.11.1751639105158; 
 Fri, 04 Jul 2025 07:25:05 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 047/108] target/arm: Rename gvec_fml[as]_[hs] with _nf_
 infix
Date: Fri,  4 Jul 2025 08:20:10 -0600
Message-ID: <20250704142112.1018902-48-richard.henderson@linaro.org>
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

Emphasize the non-fused nature of these multiply-add.
Matches other helpers such as gvec_rsqrts_nf_[hs].

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h         | 8 ++++----
 target/arm/tcg/translate-neon.c | 4 ++--
 target/arm/tcg/vec_helper.c     | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index c4a208e3ba..b741470b51 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -790,11 +790,11 @@ DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
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
index baea6d8b89..4b7de5016e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1668,11 +1668,11 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
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


