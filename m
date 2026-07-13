Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915B3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPfs-0006A1-Qa; Mon, 13 Jul 2026 19:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfq-00066v-3g
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:54 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfo-0005nD-64
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc6dd436c6so3862295ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783983770; x=1784588570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c/U/Q9KaL1t57a12jvk2yeR0GpuqsQXc/eJUhWpLOZA=;
 b=CxYK5+d96Oz9DjFBurzLXNKZYZRffqeDTl22Ut+WZ+w/dWisvUKAlAA5inAHDa8eDJ
 sTQzXKcQ5vr03B7Io6kjs3CpbfdG1baBZ7Ke2MlG8np4BsrDyv7mrBNbG47gssjTxrc7
 7EGuWhV4pBBpoMCXrHcSV/WBNyX6UzF01Hl4X34YWJXtwLGcsJeLFpOKxvjdBV8NkYZH
 X4SpfS983l6awhw6CigPYdSkU3QWl58Yaa7cLX82bPAdFJ852MPArBl0xYpgDt+SY64i
 /uMAsEg53mpm+SDtgqb20ja8r5f6ESelbZT/a4JnS9Cm383DmItUNmwdURVZsPhcC+lh
 O9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783983770; x=1784588570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c/U/Q9KaL1t57a12jvk2yeR0GpuqsQXc/eJUhWpLOZA=;
 b=bAbXIn1IVafCEGof45IIVzIl8HzLtD01ZJJa2CSELpjr7QS43ataU9kws7jBoWQyo0
 FwmWpOnZv4iQBsvIm4meTc/1b6E9pG3H1Srmr8/VM2zBwmsFbj5YkmBd4VwsBTaNueLX
 ZXhG9CQcAVjhhISg7SCzLgOV4rXwPpgNpxz+hQY24cs+AAGEWtfWu+J7VUIhwlO0x6F4
 0Ey29IqjXPbhSSDM2aB2Eux78FP2gm9N5dQFjVseYP0sbNuKjd65IBODjTBoYCv4jh9/
 ac+PpLuzxsNx3DQN5+m1GywgAWEv4qB9C/Vy8VGgx0Sxi/RfAM63a2B/WBoW4y39cA0K
 i5gA==
X-Gm-Message-State: AOJu0YyJJNKMUilqobilVm04cHWW3/ZCoMwxKJHvEANWajMvx59V6lDx
 GchpxtBtmxTGaqgeJcNOJKQnUHvLmqQ4NyeAO25uY6QrtSDEYTdg/m1nWpE6aoZVlgsjrN8VMxU
 eDh8o
X-Gm-Gg: AfdE7cn/6UaBMR0Lz0C2HBmpriwOvWYfxs2EVrmBrmcEJoBkTWM7QZmnOsSVufUl50Z
 Frpf4o9k5PgifiaEyhGZmMcFwgpYIPWXa2nYGfqJbO5gmz3X0qFFAbekaWgKAMFVvr+xKYZbYvd
 Qk9diL9iYKIuwOzRkIj0YnGwLhKvZWc+pxYtVbx+/ahL5m2Lt7sC/J5ZdtaDRdJ3dY754yH8/qC
 vlalF7zV9107qiO+FmbEtDlmOwseu5itwleCQcB4aoqA+GF+fYN7zd4r2eZBp9LZPK+v7MK9+kV
 7At9YK/jDiPTArxsgQTz6zUGb4OzfcraoeQuT4/hI+eRVMFrBAwwwACttRCZq8+tnF9HvyCLrpT
 jywEzHEiEb/YQV5oXk3no0N37APH8Qvr6+oj2J/BNApYVuMkfUZMz7FfgulpWt5H/hqSynAyInt
 w7hpiB9/OQ4PWplOGXnrNfEy6tBJVe
X-Received: by 2002:a17:902:d98b:b0:2ca:1bbe:c3d0 with SMTP id
 d9443c01a7336-2ce9f3d5e4amr101786985ad.43.1783983770461; 
 Mon, 13 Jul 2026 16:02:50 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8e9csm106902965ad.24.2026.07.13.16.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 16:02:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/10] target/arm: Implement FTMOPA (widening, 2-way,
 FP8 to FP16)
Date: Mon, 13 Jul 2026 16:02:40 -0700
Message-ID: <20260713230244.70174-7-richard.henderson@linaro.org>
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
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 43 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 12 +++++++++
 target/arm/tcg/sme.decode        |  2 ++
 5 files changed, 64 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index d3bf0746cb..1ab6c90b8c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1852,6 +1852,11 @@ static inline bool isar_feature_aa64_sme_tmop_f16f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f16f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_tmop_f8f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f8f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index dedbd8541c..13be62aa15 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -47,3 +47,5 @@ DEF_HELPER_FLAGS_5(sme_fvdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(sme_fmop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4a_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_6(sme_ftmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 4b046f5f26..305cafdc9b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -1005,3 +1005,46 @@ void HELPER(sme_fmop4a_hb)(void *vza, void *vzn, void *vzm,
     FP8MulContext ctx = fp8_mul_start(env, 0xf);
     sme_mop4(vza, vzn, vzm, &ctx, desc, sizeof(float16), inner_fmop4a_hb);
 }
+
+void HELPER(sme_ftmopa_hb)(void *vza, void *vzn, void *vzm, void *vzk,
+                           CPUArchState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t dim = oprsz >> MO_16;
+    intptr_t index = simd_data(desc);
+    intptr_t ctrl_base = (index * oprsz) >> 1;
+    uint8_t *zn0 = vzn, *zn1 = vzn + sizeof(ARMVectorReg);
+    uint16_t *za = vza, *zm = vzm;
+    uint64_t *zk = vzk;
+
+    for (intptr_t row = 0; row < dim; row++) {
+        uint16_t *za_row = za + tile_vslice_offset(row);
+
+        for (intptr_t col = 0; col < dim; col++) {
+            uint16_t e2 = zm[H2(col)];
+            uint16_t *e3 = za_row + H2(col);
+            uint16_t e1 = 0;
+
+            /*
+             * Four control bits select two elements.  The two elements
+             * may be non-contiguous, so assemble them locally into e1.
+             * Pseudo-code has a double loop running forward, with a
+             * test for (i < 2) to limit construction to 2 elements.
+             * Easier to run a single loop backward, shifting extra
+             * elements off the top of our uint16_t.
+             */
+            uint64_t this_ctrl = extractn(zk, ctrl_base + col * 4, 4);
+            for (int i = 3; i >= 0; i--) {
+                if (this_ctrl & (1 << i)) {
+                    bool e = i & 1;
+                    bool r = i & 2;
+                    uint8_t *p = (r ? zn1 : zn0) + H1(2 * row + e);
+                    e1 = (e1 << 8) | *p;
+                }
+            }
+
+            *e3 = f8dotadd_h(e1, e2, 2, *e3, &ctx);
+        }
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 43d1726972..395652f477 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2167,3 +2167,15 @@ TRANS_FEAT(BFTMOPA_sh, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ENV, gen_helper_sme_bftmopa_sh)
 TRANS_FEAT(FTMOPA_sh, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ENV, gen_helper_sme_ftmopa_sh)
+
+static bool do_tmop_fp8(DisasContext *s, arg_tmop *a, MemOp esz,
+                        gen_helper_gvec_4_ptr *fn)
+{
+    if (!fpmr_access_check(s)) {
+        return true;
+    }
+    return do_tmop_fp(s, a, esz, FPST_ENV, fn);
+}
+
+TRANS_FEAT(FTMOPA_hb, aa64_sme_tmop_f8f16, do_tmop_fp8,
+           a, MO_16, gen_helper_sme_ftmopa_hb)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5c453ea729..da6f4686d3 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1148,3 +1148,5 @@ FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 BFTMOPA_sh      1000 0001 010 ..... 000 ... .... .. 00 ..       @tmop_o2
 FTMOPA_sh       1000 0001 011 ..... 000 ... .... .. 00 ..       @tmop_o2
+
+FTMOPA_hb       1000 0000 011 ..... 000 ... .... .. 100 .       @tmop_o1
-- 
2.43.0


