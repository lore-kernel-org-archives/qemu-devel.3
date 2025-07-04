Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9793AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEZ-0000jb-6W; Fri, 04 Jul 2025 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjET-0000eq-Fz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjER-0006ID-MM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d54214adso7690395e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646346; x=1752251146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6mjsiA7KZKDAszwy3x3Eg/bebyO79pChhA3d2B5HK0s=;
 b=iq5BzxzPFOh3tP3dgGxvav2+C/aHLEXqkdrwMG3m/ogy6yxquFPORRaSzN+2YFfw7B
 i9DpTGw0aqf0Kxozh6wv7ajHqEuqQjI2EeB5aTDaDTS4L/WGY0jGwdRUv6TOXxXaW3jV
 v38mWRQa+ufGfca8s0s6yzUfeVT60mR9k6b5rQttCzOPFRYBacFPChyJMs2xxNNdXx6P
 oqjLRNQLifVBjsC2MZlwDBJtrqD+8o49yitDRUWL/SedcIyTMGMkDn/Z1BeTBlvZKV/6
 qUVbbtNusnQAlo1lJHhINUtsCz/VwvvX11opAR375Xp/RCzPHH5DrdoxAYedLlxIK0f3
 M8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646346; x=1752251146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6mjsiA7KZKDAszwy3x3Eg/bebyO79pChhA3d2B5HK0s=;
 b=dii9YKCvOMNOSdAdB+nvvtYopDCUjV9tQzTS0ocwzUteBM1YuBa95yCDaDY/3nP3nB
 zkdQ8Y991gWDn3TgWUqQtOpeC1ygC4VMtK+ONQQhT4HECrRYEkUPICPG+DuPv/ePkNAO
 qqdDls8C9dmmjuEVYVF0XIhzhdFQ24eIw8jwjCWPbDBFFHxKfxi8+TaPFP/7fehoKvGT
 FVLPefVt4hJeBbfmcp+TWYfwGv1E6Vtzn3/ogbUwOqPIYIrKR0APcPjdP0RBfW/K3EY7
 C3PTHq6NlHiZ1d1L2E8hNfi3pe4nW9Znr04zONlsPYcntA8B+wwlM0eeVffeGnd5u3JN
 lupg==
X-Gm-Message-State: AOJu0YzDpMTNaiMrUV+IT/rdek1FcdkqUoYIQO3XwLbDFzx6F58ySt/u
 oCnOnVXGwqSwn0VQ5w665a9oYgx/PoNGl2NRNJ2KABb8sUkIxNrLzIy9WR+0gvAv/26fDXzu6yr
 7KqvW
X-Gm-Gg: ASbGncv+vO07xWHRv8PUReb11dXj6SVDy6catQciJ/sNqkRyIBsReq+KCKf6ZmX1wc9
 atgWTbfGUHUFXMxmzCX/Z33mQ4sWnOYsIaZAv+a3Dp4aqVnrMR4slZYaxP0j+V5S++z/gkaSHT/
 jmKQh2E0grRwWMFwqDf6nRUevqJL7KWqJYJPrbcrcOvfXq+z9CiFB1ZuG0IPm25ZrQSPQcjMXPy
 IxiY0VUDkTP3dk6pOBltMnOWc2mvyUUhkqc+Fcd9ut2kRWUZb9AC7lFtlS+jrawECs6VkrjFaff
 WMAR/SKteWTGa0PTUPS6J09MW72IIw0mODkATqwP6n4JFBIewOG8WDswhZXYi0wBfOBq
X-Google-Smtp-Source: AGHT+IGxSxn6cG4YqGCJOJoZdssWsgWPJbWn31EleR8aX63N72xGxT5JGj3kNLgYFsLFISLwKhqz4A==
X-Received: by 2002:a05:600c:c4a5:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-454b3122753mr35051825e9.15.1751646346176; 
 Fri, 04 Jul 2025 09:25:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 047/119] target/arm: Add helper_gvec{_ah}_bfmlsl{_nx}
Date: Fri,  4 Jul 2025 17:23:47 +0100
Message-ID: <20250704162501.249138-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-36-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h     |  8 +++++
 target/arm/tcg/vec_helper.c | 58 ++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 8c4705fc539..a05b63380cb 100644
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
index e8467823f21..5dcd6f9282d 100644
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


