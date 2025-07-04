Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC1C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhMr-0005Q0-Fs; Fri, 04 Jul 2025 10:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIX-0005gO-F9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:53 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIV-0006A5-9K
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:53 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2f78ef10832so691166fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638910; x=1752243710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRLXMT2SgHddXL2FtxT5fbwaMhj+IOtlZidR4XsmCHs=;
 b=g+8bsaz5MPe9Vwikt6FU7eQDhjCK5Lo9Memit85CgENlOfmUWYIvhNHxKjIUZ09VOE
 EL9mZCc5tM2+Drl4URlEcAfbOVmEGtW1QAbThhIwSOAcA54u6MtVNM/VfehYJ3mPiOBt
 CrVCc+9WQMpDwp7osK605+3Ilz12p6ryg5AInrCcPx+vpZdjQihmlcCjos/kJqe7kK/a
 m0nFTzJU+bRuCoO3maM1Q6tHDfUtOp7bTZbMNxT0GwdNtnGf6i+595gg8n/5PwdW++Mz
 6XgqQ4Jcnfu5z2cfFgO5fJZHgq3jR8oMm7aN1to8fraFvpe/8YOmLczuzMcdhAj1D/Df
 fadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638910; x=1752243710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRLXMT2SgHddXL2FtxT5fbwaMhj+IOtlZidR4XsmCHs=;
 b=Whx9ATIuGmpc+MMaG+YACwBUYk2JO8bV+y2kAhW7pmboHiLWmp9R4UzLSfFgCmu+8k
 TcoQTe5o1znl7icoVaZOnyiuJS/RwSpPsg7em3WWwBlALphvezzDSL6wZKXE3HdOMtMW
 9N89qxpWyvRis40nDwO9Sb3ELjJyuvkAksB0L8gK6AvfelilRfDCHbi/QgZaFc6W90W7
 OWkDp9o56gRLk2pe/8UYwikrJBLOggYYtwJ/ygJ5Wh3IsmJ3GCkDw+uox/SQSK6twLR2
 qtAQyW8AN7MVP0kCW6TWEBe3QkfWD5L57pmcdsSumw42vbBI9ps7EgSdyCkN5VIRiBc/
 BDEA==
X-Gm-Message-State: AOJu0YxafjFn+rFqK/DxE1vnYnMOILhUvHtXsXmTTvU4accMxTlm87li
 /FB86nzmbDz8ODb0OkWWyaYRELW3w8j+N1ain6PUV4e9J5s3g5g349Lmr65TTjthnYRbWcaWX9U
 /bgog2as=
X-Gm-Gg: ASbGncuUPZl338ly904uVESwMbCE3m5+4wC6sEEj69LLXc07iuyKrsEf2AtTpJ2iLkc
 tvuHjHLu4loHBRTRE0PuiqAnbw/SMSawH846KSQkkHUwSbK/7oIs4dTw231Uu/50T29ki/xc4G4
 jD3JF4Wq9sSDzeE61U3EyVK5mOAgwl1lvSXZEB46NPcbPML+/n0rHupuLEFQ1Rc1b5yxBWWe87I
 yn9IHs89htuGP3LOfGm8VerwMp68zrpm2+pZUPrmw+n9NXILLG/PblXyACI4t+Qx0OwCVTBaFIB
 a2cUrzeK5aHcx16qJO610RSbYMHCmTe1OKlc10k1AntuOZcn9pv99HkX6BhZP0vwVR/1bNf+6uF
 KvAQrUcswjLr8Kcgspz3ymFgLeGCzr8Uw+iG2KdRcsQdWI3zn
X-Google-Smtp-Source: AGHT+IEuoY8kgt1SENyVf6DfexHMLLE7l7YpGOE8tZ4rHh9aaZA5W43at/wAKoIz0QVtXmeSfJilNQ==
X-Received: by 2002:a05:6870:6126:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2f796e07bd4mr1738162fac.36.1751638910101; 
 Fri, 04 Jul 2025 07:21:50 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 035/108] target/arm: Add helper_gvec{_ah}_bfmlsl{_nx}
Date: Fri,  4 Jul 2025 08:19:58 -0600
Message-ID: <20250704142112.1018902-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h     |  8 +++++
 target/arm/tcg/vec_helper.c | 58 ++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 8c4705fc53..a05b63380c 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1095,8 +1095,16 @@ DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmlsl, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmlsl, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_bfmlal_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmlsl_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmlsl_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_sclamp_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e8467823f2..5dcd6f9282 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3186,44 +3186,76 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
-                         float_status *stat, uint32_t desc)
+static void do_bfmlal(float32 *d, bfloat16 *n, bfloat16 *m, float32 *a,
+                      float_status *stat, uint32_t desc, int negx, int negf)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
-    intptr_t sel = simd_data(desc);
-    float32 *d = vd, *a = va;
-    bfloat16 *n = vn, *m = vm;
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1);
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        float32 nn = n[H2(i * 2 + sel)] << 16;
+        float32 nn = (negx ^ n[H2(i * 2 + sel)]) << 16;
         float32 mm = m[H2(i * 2 + sel)] << 16;
-        d[H4(i)] = float32_muladd(nn, mm, a[H4(i)], 0, stat);
+        d[H4(i)] = float32_muladd(nn, mm, a[H4(i)], negf, stat);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_bfmlal_idx)(void *vd, void *vn, void *vm,
-                             void *va, float_status *stat, uint32_t desc)
+void HELPER(gvec_bfmlal)(void *vd, void *vn, void *vm, void *va,
+                         float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0, 0);
+}
+
+void HELPER(gvec_bfmlsl)(void *vd, void *vn, void *vm, void *va,
+                         float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0x8000, 0);
+}
+
+void HELPER(gvec_ah_bfmlsl)(void *vd, void *vn, void *vm, void *va,
+                            float_status *stat, uint32_t desc)
+{
+    do_bfmlal(vd, vn, vm, va, stat, desc, 0, float_muladd_negate_product);
+}
+
+static void do_bfmlal_idx(float32 *d, bfloat16 *n, bfloat16 *m, float32 *a,
+                          float_status *stat, uint32_t desc, int negx, int negf)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
     intptr_t elements = opr_sz / 4;
     intptr_t eltspersegment = MIN(16 / 4, elements);
-    float32 *d = vd, *a = va;
-    bfloat16 *n = vn, *m = vm;
 
     for (i = 0; i < elements; i += eltspersegment) {
         float32 m_idx = m[H2(2 * i + index)] << 16;
 
         for (j = i; j < i + eltspersegment; j++) {
-            float32 n_j = n[H2(2 * j + sel)] << 16;
-            d[H4(j)] = float32_muladd(n_j, m_idx, a[H4(j)], 0, stat);
+            float32 n_j = (negx ^ n[H2(2 * j + sel)]) << 16;
+            d[H4(j)] = float32_muladd(n_j, m_idx, a[H4(j)], negf, stat);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_bfmlal_idx)(void *vd, void *vn, void *vm, void *va,
+                             float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0, 0);
+}
+
+void HELPER(gvec_bfmlsl_idx)(void *vd, void *vn, void *vm, void *va,
+                             float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0x8000, 0);
+}
+
+void HELPER(gvec_ah_bfmlsl_idx)(void *vd, void *vn, void *vm, void *va,
+                                float_status *stat, uint32_t desc)
+{
+    do_bfmlal_idx(vd, vn, vm, va, stat, desc, 0, float_muladd_negate_product);
+}
+
 #define DO_CLAMP(NAME, TYPE) \
 void HELPER(NAME)(void *d, void *n, void *m, void *a, uint32_t desc)    \
 {                                                                       \
-- 
2.43.0


