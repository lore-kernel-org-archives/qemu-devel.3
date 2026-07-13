Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D36C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPft-0006AA-EW; Mon, 13 Jul 2026 19:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfq-00067k-LE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:54 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfo-0005nU-NT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:54 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c7c61b5292so4447915ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783983771; x=1784588571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s2ESLQXRt7qIVkr/K/adcRYQvwQDSMqgiuM+T8rBJFg=;
 b=rj1Ynq9vuy/lcVNYabeDJEEQDErY031mgW53c93Sgndx8u0Ch4VZts2GpMKnconykv
 tJwBhnuNYyzQihFjDaUQkNsCdjrhx5ZTUEXN1FRpcI2/rbU4nK8AyJnupb5fQZmI4RJ4
 nIDHz3qSklr90pS1Kxj9OKFMYJcGCz8J5tgkAvM90oZoHU2HlcyWQt25v0/cPKiCnkW/
 wCzrQUJv/ApYTq66Y5WmmZQK19iZDpLNcssZWAKEkV53Tv9KGKGtMVEDHyHUFqy0fa8C
 8KpXtStyZIbWisGPcNNcfbZa23GSoRfwhuxXiGCnBwQU2OH8DJjs05i54Uwk22V4J5zN
 KBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783983771; x=1784588571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s2ESLQXRt7qIVkr/K/adcRYQvwQDSMqgiuM+T8rBJFg=;
 b=QnMks+6REE9KnrEF5owMZbFNP9X/26M5rQv/pnjaj87U885K4WCQcgc+PoeQDxtsce
 Fw6qxfVUT5TvbuoDIvPETfzzeAMP6ENntEg7y4e8OcwBHBpYqPINVTy7f7GEvHrlLIKE
 cjPDTzIuFTNvOO46ReESztyl/1Ti8TLtRomCmk3YFUoHFOE8Vk1yYi5bBhIYSxMJJgqW
 KDIGdt1azRRUQCnJWGo/dVnip5IHwkPGY7M/wILA5hptAWTOPiNNMGTYRobBXS84hNYj
 LPVgBODMXFK0La7OsFSgqjflx+eeOgO4iDNXWGy7ZJkojTPThsGZLPQlQf25lKYrN5Br
 m75A==
X-Gm-Message-State: AOJu0YyYK7toe2wsoBhxK3J/bFiTSxc/ER2UpegsrnCVlTZSDn22t80x
 NGpRG3aWIw0PMA8C4Q4qNAyiJcCxUmxHwoktI9L+aERNXoPz9+dXvsGPivzmw9ReScGncQz+id9
 qfIMB
X-Gm-Gg: AfdE7cloiu9iRjhpgSDvuwMhBTs5RnhxxPn1EHtu4exjmvMVwo1NKxy61cvna9tfc2F
 KCFcAwthypNd7RTICcCvVOXwpotx3MP5cVjxFVACZTrRWINdG0wK0mmRnBvFPkBMCfN8AUYK6np
 zrxQk86CGwMPZ33QWcj6bS8ReDafXMFCHeDUDMIgAuRzFJZpdqyNJPXcgmP37lOdvv/aJ7+iIUr
 PUkZQ486q67wtQe9FQWn41Wqsf8bJePK0tRcsIpaUECFhcQGAOgfW9VmgYd4/o8eaPisHBiY3qt
 7wyeFSgkdW+uasTC52WVhaoVZOzEjrDhHNtU7r51vgJckom+N7Al5Ia0kwsIoMhK3lQN5QfQW9T
 ovyeSOFeRzuT7pzHZrqq+8N8xGBuzZoC9NlJkrPy4VMhS20v8wKOCawxUwNTmC5rW2gYW1FJfE0
 Kyg3sMJZDkNt0djKsU6Q==
X-Received: by 2002:a17:902:ef0a:b0:2ca:9ab:e725 with SMTP id
 d9443c01a7336-2ce9e59d62cmr109786845ad.1.1783983771193; 
 Mon, 13 Jul 2026 16:02:51 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8e9csm106902965ad.24.2026.07.13.16.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 16:02:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/10] target/arm: Implement FTMOPA (widening, 4-way,
 FP8 to FP32)
Date: Mon, 13 Jul 2026 16:02:41 -0700
Message-ID: <20260713230244.70174-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713230244.70174-1-richard.henderson@linaro.org>
References: <20260713230244.70174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/vec_internal.h    |  7 +++++
 target/arm/tcg/fp8_helper.c      |  7 +++++
 target/arm/tcg/sme_helper.c      | 44 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  2 ++
 target/arm/tcg/sme.decode        |  1 +
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
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 13be62aa15..e2cf2ba8c7 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -49,3 +49,4 @@ DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32
 DEF_HELPER_FLAGS_5(sme_fmop4a_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(sme_ftmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme_ftmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
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
index 395652f477..0fda2d9ac5 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2179,3 +2179,5 @@ static bool do_tmop_fp8(DisasContext *s, arg_tmop *a, MemOp esz,
 
 TRANS_FEAT(FTMOPA_hb, aa64_sme_tmop_f8f16, do_tmop_fp8,
            a, MO_16, gen_helper_sme_ftmopa_hb)
+TRANS_FEAT(FTMOPA_sb, aa64_sme_tmop_f8f32, do_tmop_fp8,
+           a, MO_32, gen_helper_sme_ftmopa_sb)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index da6f4686d3..eab1f7e8fb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1150,3 +1150,4 @@ BFTMOPA_sh      1000 0001 010 ..... 000 ... .... .. 00 ..       @tmop_o2
 FTMOPA_sh       1000 0001 011 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 FTMOPA_hb       1000 0000 011 ..... 000 ... .... .. 100 .       @tmop_o1
+FTMOPA_sb       1000 0000 011 ..... 000 ... .... .. 00 ..       @tmop_o2
-- 
2.43.0


