Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF20CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoM-0006up-6l; Thu, 04 Jun 2026 19:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoH-0006qQ-Eo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoF-0007z9-7s
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso9649565ad.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616950; x=1781221750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0S4mgAnLz7VaCxx4V6clCkrHPo+LDsuEwWJQq3WHbB0=;
 b=a7TefrPGvBSUKQAK7oeB2LQCOoKBcOlTXmMzoiCSHx3XwXWxsUwCfR8lCh0C3UlVFK
 6JvAOu7eJjoFhLrF3egI5ZeBJ8WLJdJyyvvZ4XFxAz2qLOLd+hz0TGPY1ysq8VINuyjN
 vUMEBhzS+hBFDMTIL5QaUBuGgrpMCeBNehNiseo+KBtP5kyC4Bm7TEbBnt1N6UK/KD+9
 +T/KO5jpsrMqaZrDN/ORotuBiWlZ08La1S+aEyAfhyz9qfVMCPJNCVk2zvbqh/gBZoCd
 7uE/AhE83+NBfq9p5aTXKS4kDw4culX6dPy51UecS0kuRGsAyQMJdP1AzXxYrnnkuRe7
 JaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616950; x=1781221750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0S4mgAnLz7VaCxx4V6clCkrHPo+LDsuEwWJQq3WHbB0=;
 b=cm+dPvrS9OTUHxwpBopnXFCnRtMoMAdoFv0munUNiFutckfJSbhja7X1/Zo9Y2FBW1
 +N4DUrgWbmXKN7CIXBWuEG/rz6D+n936vOR5CB3Rhw/MRCKoz9Nbtk1c/1cwqnrbLCiu
 4jgQF5kBGA/o5baQOukOD5pQ9pSYZOdYAu0qxmVEUV4bFan7Pw/c07FtDmkogODll3SR
 hNigC05iCsLm2Z2W2/FdpOeXzsTrhXKGSdk6hCfzAAsUQbXUtpo5fcM1LZoNgVQ0LwUq
 nDag2a0CBcUqzTBVS+IpOmVUTt46GUnDtXbvBNNLZKQTG0h8I6t8RBbtesYwsCPXwGIt
 hW9A==
X-Gm-Message-State: AOJu0Yy9l1sFM95KJIyj9Al6wEwYBqYVh+81ciY1BuGEvr7yhzOyySMX
 x5PP1KM0NJPbmzSLqZanMecxZ/Gdn9VJFshSnTHA1SPIE0Wy06AE9NIVtZQpgOs372QM5lL19Rv
 AKvlAOPs=
X-Gm-Gg: Acq92OH/Yp/ToLZNmd0U1b4WBmYgXwi3pdqHldnMDmiQdmK51KwZX0pV4zzB9rw+e9s
 PU3sMvY/JrQ03Pv453+PzlF6CZwgl32GT2EfJT0HXXNn4hycYrxhilogdsq2+tSFjkKre/U2XoB
 idQZnPaF1wxsBpt2cLCUXK34fwpBmSQKJJddcX64VzRAnyP1H1+We6kPTzLVQRqSX5hpLZgTA16
 k7NdjChdfo1QuX+/RdYEZoIR2o6rH7bLYC78iX1ZErOageGw/xHfGBAqY5yXh5okC0ilYJHvKrR
 xwt3NUXNVKXYD1zm5Lr+u6IO9wFP2k2iS6EPJ4i2O2sF2rS2RrtUTTpq+ArlFot/XjTY5HraY2c
 e3SOBtcliwGzAMaIH2JOh4n8KxCaQRm8MCxN08qgC/6AntJgd9Pbi/Spbj6kEoX5TaNZdasRHc2
 EhCNyYIILSBlvhPixVJT0MDYWt4t462sHpjb8BSck=
X-Received: by 2002:a17:902:ccc3:b0:2b4:59bf:5728 with SMTP id
 d9443c01a7336-2c1e80ec2abmr7532215ad.25.1780616949749; 
 Thu, 04 Jun 2026 16:49:09 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 22/25] target/arm: Implement FIRSTP, LASTP
Date: Thu,  4 Jun 2026 16:48:49 -0700
Message-ID: <20260604234852.573178-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
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
 target/arm/tcg/helper-sve-defs.h |  3 ++
 target/arm/tcg/sve_helper.c      | 30 +++++++++++++++++
 target/arm/tcg/translate-sve.c   | 56 ++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  3 ++
 4 files changed, 92 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index 11342e1e59..440a868cea 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -961,6 +961,9 @@ DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_2(sve2p1_cntp_c, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 
+DEF_HELPER_FLAGS_3(sve2p2_firstp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2p2_lastp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 3f99a362c3..57c7823feb 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4302,6 +4302,36 @@ uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
     return count >> p.lg2_stride;
 }
 
+uint64_t HELPER(sve2p2_firstp)(void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
+    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
+
+    for (intptr_t i = 0; i < words; ++i) {
+        uint64_t t = n[i] & g[i] & mask;
+        if (t) {
+            return (ctz64(t) + i * 64) >> esz;
+        }
+    }
+    return -1;
+}
+
+uint64_t HELPER(sve2p2_lastp)(void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
+    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
+
+    for (intptr_t i = words - 1; i >= 0; --i) {
+        uint64_t t = n[i] & g[i] & mask;
+        if (t) {
+            return ((clz64(t) ^ 63) + i * 64) >> esz;
+        }
+    }
+    return -1;
+}
+
 /* C.f. Arm pseudocode EncodePredCount */
 static uint64_t encode_pred_count(uint32_t elements, uint32_t count,
                                   uint32_t esz, bool invert)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 325fc28fb3..912290f460 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3481,6 +3481,62 @@ static bool trans_SINCDECP_z(DisasContext *s, arg_incdec2_pred *a)
     return true;
 }
 
+static bool do_firstp_lastp(DisasContext *s, arg_rpr_esz *a, bool firstp)
+{
+    if (sve_access_check(s)) {
+        unsigned psz = pred_full_reg_size(s);
+        TCGv_i64 v = cpu_reg(s, a->rd);
+
+        if (psz <= 8) {
+            uint64_t psz_mask;
+
+            tcg_gen_ld_i64(v, tcg_env, pred_full_reg_offset(s, a->rn));
+            if (a->rn != a->pg) {
+                TCGv_i64 g = tcg_temp_new_i64();
+                tcg_gen_ld_i64(g, tcg_env, pred_full_reg_offset(s, a->pg));
+                tcg_gen_and_i64(v, v, g);
+            }
+
+            /*
+             * Reduce the pred_esz_masks value simply to reduce the
+             * size of the code generated here.
+             */
+            psz_mask = MAKE_64BIT_MASK(0, psz * 8);
+            tcg_gen_andi_i64(v, v, pred_esz_masks[a->esz] & psz_mask);
+
+            if (firstp) {
+                tcg_gen_ctzi_i64(v, v, -1);
+            } else {
+                tcg_gen_clzi_i64(v, v, 64);
+                tcg_gen_subfi_i64(v, 63, v);
+            }
+            tcg_gen_sari_i64(v, v, a->esz);
+        } else {
+            TCGv_ptr t_pn = tcg_temp_new_ptr();
+            TCGv_ptr t_pg = tcg_temp_new_ptr();
+            unsigned desc = 0;
+            TCGv_i32 t_desc;
+
+            desc = FIELD_DP32(desc, PREDDESC, OPRSZ, psz);
+            desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+
+            tcg_gen_addi_ptr(t_pn, tcg_env, pred_full_reg_offset(s, a->rn));
+            tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
+            t_desc = tcg_constant_i32(desc);
+
+            if (firstp) {
+                gen_helper_sve2p2_firstp(v, t_pn, t_pg, t_desc);
+            } else {
+                gen_helper_sve2p2_lastp(v, t_pn, t_pg, t_desc);
+            }
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(FIRSTP, aa64_sme2p2_or_sve2p2, do_firstp_lastp, a, true)
+TRANS_FEAT(LASTP, aa64_sme2p2_or_sve2p2, do_firstp_lastp, a, false)
+
 /*
  *** SVE Integer Compare Scalars Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a3eefd60e5..bdc2b7f0c0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -852,6 +852,9 @@ BRKN            00100101 0. 01100001 .... 0 .... 0 ....         @pd_pg_pn_s
 CNTP            00100101 ..    100 000 10 ....     0 .... ..... @rd_pg4_pn
 CNTP_c          00100101 esz:2 100 000 10 000 vl:1 1 rn:4 rd:5
 
+FIRSTP          00100101 ..    100 001 10 ....     0 .... ..... @rd_pg4_pn
+LASTP           00100101 ..    100 010 10 ....     0 .... ..... @rd_pg4_pn
+
 # SVE inc/dec register by predicate count
 INCDECP_r       00100101 .. 10110 d:1 10001 00 .... .....     @incdec_pred u=1
 
-- 
2.43.0


