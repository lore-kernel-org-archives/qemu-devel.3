Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB94FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg811-0000IX-NT; Thu, 06 Feb 2025 14:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80S-0007KP-K4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:48 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80P-0000c0-06
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:48 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2164b662090so27977125ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871863; x=1739476663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uU2eho+S5wLdkRYW5zeyOVQxfSf5m2iq7UX8+pfSEzY=;
 b=RWJtYj0u/bg+y3rpvtRXhQvcPRHDh+6vwMjBv0DHh0EOWeKsCfOyIu2CvKSywNXzia
 XEsA88Z32ETXLGJADCzVTO+FfLIsgFUzpNwBOVdb7lI8ndr/IIOWwmMNpnPJWNtAwj/5
 zsm8WBfGcdtvYn1xfinTzm56wuLaRQC++Je626AxiZBJJ0S+ZfREqoWTGJ8HVw8NUXUS
 vDZQRn0RJCoZF8WfHDY8vRFdzx7MeMNMmVgWMTPYoC2okmu8VtLM9Js5WlX0uitsJAci
 YeMS37ENT3Q9YqdvJ9moql6hU8fVHmqo9Kf8/zgy26qJ0kfiNsawrvqd3zKakA8Jg3Lk
 1sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871863; x=1739476663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uU2eho+S5wLdkRYW5zeyOVQxfSf5m2iq7UX8+pfSEzY=;
 b=aoHAIftljrn8I0UzkL6DTnRVAhNMRFjYSWrTvLTv/BagzAGNVnfyUHv9BozG3dMepc
 5TQ2F7SPiAcREq28eoWvNohTFFYdupw22ort00Pd+kY2zvcN89ovjfnEYpQqkamaSyJP
 Gnb/pyINUvq2GseCR8tELk839HzFFJbABs68sQRPEOw9qWe4wQlJgFuoWBnbnoJpu3Wp
 j9ySi6Ke40QhNMDZt5/bJJpUstxyYzIM93E2Scjp+vfcjllqMrZ9mUS4ljmHBJ0ktkbe
 vzbtec4qmeKZOXGwgj2haIqUBONzYvka+tPOpz1lHT57CstDejFsVTSDpKb43CuOY8KF
 UyvQ==
X-Gm-Message-State: AOJu0Yz6V8fheqfuSNGtzLbVR4Vig+awSm7D/RMAqDQd+DukXLX1Jqug
 aABWlN+r5bL78OtkjdcyyOFv7gHBIql6aVRg48w8z/jxyLDIMtbwiamIzgKng2M/qfOjqxkQiv4
 X
X-Gm-Gg: ASbGncvzHPHf5KFJTwEt1KcDj/x5ebVlbIlbeO0hPXf+hkCaDhONfX+KzZSWbGB+rp0
 pbegObTE2CArupE8nCkK5GAUfeVP2qgKFRkCmRf7B9CWtmUjHxm/x7YnTzoKCreSaFe3e8Mh+2F
 /JIVDb5uXcIBGkVI+DEtlDCcZX4CaVRQuJ/PdJsuMEZT+z3tIacFRlv9Y22C5/ltnDYhF5ls2yq
 oxAu8SgvDBqtFW7B7uJ6oz3oNWELWU7rgARxE8iIA6Uf5hPTK/aYVFH7f63woIEbqYN9UaYYShs
 5baCM5fNt7xD9WSnWs5ESVaq6UAf0WiCivf5jvh3xnAWECY=
X-Google-Smtp-Source: AGHT+IHCO4MXdDVF1zHGCuPg7FbQvK4ydCEi4POfxtRtyhzQg6Mk9Ra6FJgC8WtRffWlAGVLmL39uQ==
X-Received: by 2002:a05:6a00:1acc:b0:728:ecab:51e3 with SMTP id
 d2e1a72fcca58-7305d47f31cmr663385b3a.11.1738871863508; 
 Thu, 06 Feb 2025 11:57:43 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 36/61] target/arm: Remove helper_gvec_sudot_idx_4b
Date: Thu,  6 Feb 2025 11:56:50 -0800
Message-ID: <20250206195715.2150758-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Add gen_helper_gvec_sudot_idx_4b as an expander which
swaps arguments and uses helper_gvec_usdot_idx_4b.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h         | 2 --
 target/arm/tcg/translate.h  | 3 +++
 target/arm/tcg/gengvec.c    | 6 ++++++
 target/arm/tcg/vec_helper.c | 1 -
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 5772ea98bd..7ae4cddb3c 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -620,8 +620,6 @@ DEF_HELPER_FLAGS_5(gvec_sdot_idx_4h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_idx_4h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sudot_idx_4b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_usdot_idx_4b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index be39adfa86..a6e6181421 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -624,6 +624,9 @@ void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                       uint32_t opr_sz, uint32_t max_sz);
 
+void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                  TCGv_ptr a, TCGv_i32 desc);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 01867f8ace..c182e5ab6f 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -23,6 +23,12 @@
 #include "translate.h"
 
 
+void gen_helper_gvec_sudot_idx_4b(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                  TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_gvec_usdot_idx_4b(d, m, n, a, desc);
+}
+
 static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
                             uint32_t opr_sz, uint32_t max_sz,
                             gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 8beace8147..7904159d57 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -867,7 +867,6 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
 
 DO_DOT_IDX(gvec_sdot_idx_4b, int32_t, int8_t, int8_t, H4)
 DO_DOT_IDX(gvec_udot_idx_4b, uint32_t, uint8_t, uint8_t, H4)
-DO_DOT_IDX(gvec_sudot_idx_4b, int32_t, int8_t, uint8_t, H4)
 DO_DOT_IDX(gvec_usdot_idx_4b, int32_t, uint8_t, int8_t, H4)
 DO_DOT_IDX(gvec_sdot_idx_4h, int64_t, int16_t, int16_t, H8)
 DO_DOT_IDX(gvec_udot_idx_4h, uint64_t, uint16_t, uint16_t, H8)
-- 
2.43.0


