Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D108CCDB47C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGH-0004u6-1n; Wed, 24 Jun 2026 21:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGD-0004r3-Vb
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGC-0008U8-5a
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:09 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c88eb5e7713so626603a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352326; x=1782957126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTjgAJNDQgrpdJWK35ZiRgETxbEW9h3Lx/7T/PIcGQU=;
 b=nSmV1gJFDXB5s0CgK+/2pG5DsmIe3mznHM7M73A66I6q05r3hlPD23HRL4OyG6DIdC
 Y4ObbdPoN6QrptrVSQHZOJXdj1Wp0zr3L1p1n70vGrijxP1f3WuoVH0V60xoyRPxzQBo
 6R/4CTqYsGrg8oHf/x3Xwa/KC6bdcOlLdfZprTrohO4FCu6e2bllNJmWK60CmzrcisuQ
 JWCCNTMga3ekfzKWXDx/abVZvrDl2igW3J5wm9pbtmOJGzV7QN9rmQxXg0PgRcA2TLLd
 vUPnFf7tCdBuXtT9I/Zy2FKH7+04tNRjc1yntmGnxXD0kgAucisg0YmWTXFcnWZpHtoK
 TrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352326; x=1782957126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xTjgAJNDQgrpdJWK35ZiRgETxbEW9h3Lx/7T/PIcGQU=;
 b=SpdlNbvjBzIEswad4saNteAlP5ZkWa0B/dLSJBWamez9qYWbCZ6uqe9fRuVywue9kB
 Nt87Ih/ZSKVylFzq0cCOhpM07A1iOrMKBraRt1bbSBq1WaVcdKfNPTWZ0xnrUovK8E6f
 uLtO0ErS66iHM+eHMVTXzQjoZs8KZXYU2Dh6zvyD4RdfwgC0C3BoKUFjw17POykKxfFU
 w4JfwAmx2H2/K0E9xG4MUWKNG+eICPrXs/SgKak/sxa4WWs6yh2GsVDcPediva2zwO0q
 HFwuntB7d1sfgQbFg9u/6v4T8vH2VakJqQf4S75D488IuWacyZrnXPGx42ywKnQZv0qQ
 SvnQ==
X-Gm-Message-State: AOJu0Yxrb8BJZGxi3n53dZMOy6HBnDSIRJFAXWSRIhDmeoGugOTcDlIt
 9o20gX0U6AxgdGFkuAe6LZjVAk7w47LVzbGlES7vsbNKyJ2ctjg+8pLZvpNEv5TW04Ud189Bfhq
 CGXcM
X-Gm-Gg: AfdE7cn9D9G9u+7hjcRB7UZ+eHHfDv6kdWxUYGJyikljbjXkGWEjRrxw0cFWiagTmPu
 xu1q1ulVkdw3gmJxpm4p2ObUxdmVLYbiL4p4KQXMnshwPkCvC103jxi2zpr3W3MIYBcMxI44h5e
 hW3A0fn9eKlRrS2+7O3dVhl08hrn6qFEy1fb/e4HwXuZKMTeCsGxdHUnCwKlYw5lrWPULfPvxRs
 mmBjXaI4l+KNjQQIfdTP5ue2Xzpj7aYKZflZHT9xNXOLGUYcjEr0JQNJ9T1Zs2LITmFaZbMZCvb
 LC6e6jfml8J7wJi1fCUM/keKbPTV6NQy/29HpB18NyEkQ0wr+BVsKjWLcJ5QHClxIbPJCYTAO+Z
 AXm7axHDYN30y18SLyagjZvMAyxAMJYte7VyDbfQywiIgTYweWsENv0wx/uajiVRFVWy1w8zQDh
 BC2RFO0f5SW3tYG/iz/x2FlSswRB3Ey8Ol9Of6HpchhJm4V6U8iw==
X-Received: by 2002:a17:903:2f87:b0:2c0:dd75:e830 with SMTP id
 d9443c01a7336-2c7fc66300fmr6776565ad.5.1782352326307; 
 Wed, 24 Jun 2026 18:52:06 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:52:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/10] target/arm: Implement FMOPA (widening, 2-way,
 FP8 to FP16)
Date: Wed, 24 Jun 2026 18:51:55 -0700
Message-ID: <20260625015159.719300-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
References: <20260625015159.719300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 35 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 24 +++++++++++++---------
 target/arm/tcg/sme.decode        |  1 +
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index ef1375fea7..05bf8dbdc2 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -40,5 +40,6 @@ DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32
 DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_7(sme_fmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_7(sme_fmopa_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(sme_fvdot_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 3c2d959099..5606f0fd8e 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -893,6 +893,41 @@ void HELPER(sme_fmopa_sb)(void *vza, void *vzn, void *vzm, void *vpn,
     }
 }
 
+void HELPER(sme_fmopa_hb)(void *vza, void *vzn, void *vzm, void *vpn,
+                          void *vpm, CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    intptr_t oprsz = simd_maxsz(desc);
+    uint16_t *pn = vpn, *pm = vpm;
+
+    for (intptr_t row = 0; row < oprsz; ) {
+        uint16_t prow = pn[H2(row >> 4)];
+        do {
+            void *vza_row = vza + tile_vslice_offset(row);
+            uint16_t n = *(uint16_t *)(vzn + H1_2(row));
+
+            n &= expand_pred_b(prow & 3);
+
+            for (intptr_t col = 0; col < oprsz; ) {
+                uint16_t pcol = pm[H2(col >> 4)];
+                do {
+                    if (prow & pcol & 0x3) {
+                        uint16_t *a = vza_row + H1_2(col);
+                        uint16_t m = *(uint16_t *)(vzm + H1_2(col));
+
+                        m &= expand_pred_b(pcol & 3);
+                        *a = f8dotadd_h(n, m, 2, *a, &ctx);
+                    }
+                    col += 2;
+                    pcol >>= 2;
+                } while (col & 15);
+            }
+            row += 2;
+            prow >>= 2;
+        } while (row & 15);
+    }
+}
+
 void HELPER(sme_fvdot_idx_sb)(void *vd, void *vn, void *vm,
                               CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 197274d00e..7eeac28480 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -616,25 +616,29 @@ TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32,
            : !s->fpcr_ah ? gen_helper_sme_bfmops_w
            : gen_helper_sme_ah_bfmops_w)
 
-static bool trans_FMOPA_sb(DisasContext *s, arg_op *a)
+static bool do_outprod_fp8(DisasContext *s, arg_op *a, MemOp esz,
+                           gen_helper_gvec_5_ptr *fn)
 {
-    if (!dc_isar_feature(aa64_sme_f8f32, s)) {
-        return false;
-    }
     if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
         int svl = streaming_vec_reg_size(s);
         uint32_t desc = simd_desc(svl, svl, 0);
 
-        gen_helper_sme_fmopa_sb(get_tile(s, MO_32, a->zad),
-                                vec_full_reg_ptr(s, a->zn),
-                                vec_full_reg_ptr(s, a->zm),
-                                pred_full_reg_ptr(s, a->pn),
-                                pred_full_reg_ptr(s, a->pm),
-                                tcg_env, tcg_constant_i32(desc));
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr pn = pred_full_reg_ptr(s, a->pn);
+        TCGv_ptr pm = pred_full_reg_ptr(s, a->pm);
+
+        fn(za, zn, zm, pn, pm, tcg_env, tcg_constant_i32(desc));
     }
     return true;
 }
 
+TRANS_FEAT(FMOPA_sb, aa64_sme_f8f32, do_outprod_fp8,
+           a, MO_32, gen_helper_sme_fmopa_sb)
+TRANS_FEAT(FMOPA_hb, aa64_sme_f8f16, do_outprod_fp8,
+           a, MO_16, gen_helper_sme_fmopa_hb)
+
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
 TRANS_FEAT(SUMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_sumopa_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 1dd3b7c8b2..755d5f00d0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -199,6 +199,7 @@ BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
 FMOPA_sb        10000000 101 zm:5 pm:3 pn:3 zn:5 0 00 zad:2     &op sub=0
+FMOPA_hb        10000000 101 zm:5 pm:3 pn:3 zn:5 0100 zad:1     &op sub=0
 
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
 SUMOPA_s        1010000 0 10 1 ..... ... ... ..... . 00 ..      @op_32
-- 
2.43.0


