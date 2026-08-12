Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F174C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t1-0004JB-SO; Wed, 12 Aug 2026 08:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sw-0004Ak-B0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7su-0008UO-Cf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so551124f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536997; x=1787141797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WuaHOxeAnhceyL4m+VMh1cqQu77uUg/5cvN9Mt8k7Qo=;
 b=TezHC/Iz6H0EL5Be3CKQME7M4tuC+EWQgUzJnnoyOuJZmz0ZaSwIIJ0A5eXqHYhWzh
 NkHUeDi3GQVN5Bhg1TQoo0s/fFz2LrUV4t6/cIov87sclo2bPLQgi2sLovlOJJV37g4F
 tI69OXSCjXhi4K/HoPrNaLS/PC/75R4wlYuPBK7x+vTn/GiA9JJp8p2vNrO8XdjMaqn0
 M9LRnnzu3gK4DaqN8+ps+rmA6et1pp34NQ3UG506i8mntxf8sWaiVOlJDn8ZuW76H02M
 SXKGMRh2ErF92P8aim4ynRwDSsYCCbh/YB3OtWP0mHSok6wESaFD+wGxjtXQFowuet2j
 q/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536997; x=1787141797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WuaHOxeAnhceyL4m+VMh1cqQu77uUg/5cvN9Mt8k7Qo=;
 b=nyPQkrXbs1yTQtwOY5FTZiQyq60HBcnGr4YFZBq1zdOHjpLFjJX9YXzgSP3qnJ7n++
 SvPE1GEDwGi29GfTwKFCPke2vanXTjV4zs+5X5d4AkAJ2XpuXVuQN9+8EMhO8/dzNOyl
 JouBwgq/ZdoqwI98B+30H8KlTDH9GfXxpJjjpcaJk8t7o/8+bWiaG724N+kPCwieBMOy
 CrvDLCSmvWcUPYN0BlMYFUvsgjte0DAS0ZmNQiAE3P6EuAsNlaCiIJvDeEX1dx+MgrbS
 q/Y9sVBcV9mfH3EoHqW8j9R/ZrG713KpDAoPIFP59tEBfz2ovyLOTyo8laAEF6wNqdNP
 GXaQ==
X-Gm-Message-State: AOJu0YxstwEZmZnEgCdLDrQ9ZyztdpzCUx3iv8v4g6dhx+peu5WPULVp
 LDtTKFo0LDyn4Ppj4buHYk6N4BGrWJPvuiJ0m8XO3hRyRfKpOKGay8LYTw8wA+u4zcw5rI3Htnp
 dVC3W
X-Gm-Gg: AR+sD12YUCORwMyG1GMoOHRY2E2xI0QsPaHIsht0pEexWHBHocsxoi8CP2Gqpv+AEI+
 9PDQmVoNljgE2SdNuj/uBgNKaJSNCQr2//UuDoDcV0pvR4b6WJ6tN/cNh4+V5fZzjN5I/hEt6ln
 VKEca8lKlIl+FPesNmXvb8w6AeMXJ0QZB4tk3SOF/zNwCZeEPLd8mCkd0NH/zKy3SnuNwcTAl5b
 7WJhT+9RgTAXpBhw43MnG/HAdL2MTfCqFQpQ6l3bmcHH61B/Bn3dwGX9lmb5Xj4zDNRU/EMBNgL
 PkKE86/e1nxtsTE9BFryszSZifXo5o5m/FteIdZFD+nOXrW/7Mrc9/trjr+fSREGEsMLDDgCdBt
 WG7kU6So87LEm8ZqXqKMgiwDejwKmaVU5fkyQB6fZxjcduX1PQeztpJOBxlrlMsu1SplyUUDmM6
 5VoUbpjLd880+E4aAZAk+4SWBrSvEBw67mhtqVHj1cmCnLE+4p5/It5heNnm1QCbMZ0p1ClCCYz
 WOsdFdklxeFV/rOWNQ1j49yC9DF2koCotfdrHVxd3LcclTWV/yh9Em7zTtQgrQPvI1ADSNtVY7C
 rnte
X-Received: by 2002:a05:600c:19c6:b0:499:7a5e:4c3f with SMTP id
 5b1f17b1804b1-4997c0fcab7mr66816895e9.1.1786536997390; 
 Wed, 12 Aug 2026 05:16:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/26] target/arm: Implement FTMOPA (widening, 4-way,
 FP8 to FP32)
Date: Wed, 12 Aug 2026 13:16:03 +0100
Message-ID: <20260812121622.649730-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/fp8_helper.c      |  7 +++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/sme.decode        |  1 +
 target/arm/tcg/sme_helper.c      | 44 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  2 ++
 target/arm/tcg/vec_internal.h    |  7 +++++
 7 files changed, 67 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 1ab6c90b8c..280ead6f9c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1857,6 +1857,11 @@ static inline bool isar_feature_aa64_sme_tmop_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f8f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_tmop_f8f32(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f8f32(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 305cafdc9b..0be811e71b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -1048,3 +1048,10 @@ void HELPER(sme_ftmopa_hb)(void *vza, void *vzn, void *vzm, void *vzk,
         }
     }
 }
+
+void HELPER(sme_ftmopa_sb)(void *vza, void *vzn, void *vzm, void *vzk,
+                           CPUArchState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    sme_tmop_4way_sb(vza, vzn, vzm, vzk, &ctx, desc, inner_fmop4a_sb);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 13be62aa15..e2cf2ba8c7 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -49,3 +49,4 @@ DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32
 DEF_HELPER_FLAGS_5(sme_fmop4a_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(sme_ftmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme_ftmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index da6f4686d3..eab1f7e8fb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1150,3 +1150,4 @@ BFTMOPA_sh      1000 0001 010 ..... 000 ... .... .. 00 ..       @tmop_o2
 FTMOPA_sh       1000 0001 011 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 FTMOPA_hb       1000 0000 011 ..... 000 ... .... .. 100 .       @tmop_o1
+FTMOPA_sb       1000 0000 011 ..... 000 ... .... .. 00 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c2b7c23d6c..3d7aefac5b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2723,6 +2723,50 @@ static void sme_tmop_2way_sh(uint32_t *za, uint16_t *zn0, uint32_t *zm,
     }
 }
 
+void sme_tmop_4way_sb(uint32_t *za, uint8_t *zn0, uint32_t *zm,
+                      uint64_t *zk, void *fn_opaque, uint32_t desc,
+                      void (*fn)(void *, void *, void *, void *))
+{
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t dim = oprsz >> MO_32;
+    intptr_t index = simd_data(desc);
+    intptr_t ctrl_base = (index * oprsz) >> 1;
+    uint8_t *zn1 = zn0 + sizeof(ARMVectorReg);
+
+    for (intptr_t row = 0; row < dim; row++) {
+        uint32_t *za_row = za + tile_vslice_offset(row);
+
+        for (intptr_t col = 0; col < dim; col++) {
+            uint32_t *e2 = zm + H4(col);
+            uint32_t *e3 = za_row + H4(col);
+            uint16_t e1l = 0, e1h = 0;
+            uint32_t e1;
+
+            /*
+             * Eight control bits select two elements from each row.
+             * The elements may be non-contiguous, so assemble them
+             * locally into e1.
+             * Pseudo-code has a triple loop running forward, with a
+             * test for (i < 2) to limit construction to 2 elements.
+             * Easier to run a single loop backward, shifting extra
+             * elements off the top.
+             */
+            uint64_t this_ctrl = extractn(zk, ctrl_base + col * 8, 8);
+            for (int e = 3; e >= 0; e--) {
+                if (this_ctrl & (0x01 << e)) {
+                    e1l = (e1l << 8) | zn0[H1(4 * row + e)];
+                }
+                if (this_ctrl & (0x10 << e)) {
+                    e1h = (e1h << 8) | zn1[H1(4 * row + e)];
+                }
+            }
+            e1 = (e1h << 16) | e1l;
+
+            fn(e3, &e1, e2, fn_opaque);
+        }
+    }
+}
+
 static void inner_fmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
 {
     float16 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 206f078bfb..ceed864da8 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2179,3 +2179,5 @@ static bool do_tmop_fp8(DisasContext *s, arg_tmop *a, MemOp esz,
 
 TRANS_FEAT(FTMOPA_hb, aa64_sme_tmop_f8f16, do_tmop_fp8,
            a, MO_16, gen_helper_sme_ftmopa_hb)
+TRANS_FEAT(FTMOPA_sb, aa64_sme_tmop_f8f32, do_tmop_fp8,
+           a, MO_32, gen_helper_sme_ftmopa_sb)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 038a2a3439..8f6d8a984b 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -555,4 +555,11 @@ void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,
               uint32_t desc, size_t esize,
               void (*fn)(void *, void *, void *, void *));
 
+/*
+ * Perform SME sparse outer product, 4-way, 8 to 32-bit.
+ */
+void sme_tmop_4way_sb(uint32_t *za, uint8_t *zn0, uint32_t *zm,
+                      uint64_t *zk, void *fn_opaque, uint32_t desc,
+                      void (*fn)(void *, void *, void *, void *));
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
-- 
2.43.0


