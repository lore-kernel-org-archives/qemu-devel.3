Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DB1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfx-00071U-5d; Mon, 29 Jun 2026 08:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfM-0006q2-W4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfL-0007K9-1f
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493a7bd27c2so11482345e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734441; x=1783339241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BHpav8nOTAm1opkyuJI8c8OVhqlQNczzPglWhPIf9gg=;
 b=TRRoJ0MT4hWATQ7Ba6uo3me8A4Cac94u8iro9rM3tggYk3xw9FlTseChvsZVLnolXW
 Hb/XYAXP312I986i6BuuJfPlHmLvqGs8l8c3DClksEWthnoboHI+ui3gRgKJ1yOyxZTn
 sAqMGJnCcd7j76o0nGCRyHvRU6gr2VyCPT8Hs88lCFBcOBZsSkDRdmCjJvxy9f5JvmJr
 4RkCwDBrIKNv563U9HYEuX04bR4bLymhInxeYXEznptq4Y5wUfqcOCSk+nDnSdTWx0yX
 Oo8sLV3TKDy7kZm1u1I1zm5eZ4pcgYIPtIQ8YPk6Qec01ych+UEuRrcQVSO68rALTqJN
 qrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734441; x=1783339241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BHpav8nOTAm1opkyuJI8c8OVhqlQNczzPglWhPIf9gg=;
 b=jojA19aQbAfzdLlzTl1yOZncr5qTeXPnr7VySaHuE4pybyrj6UlHnIMG1noWyunYOG
 vZXCuFRni6IaYVmEVoQXCGJ2vBSrX3B+bEYr/umwJdFpjSarVCTCksuctLydkcDc22RT
 bbqWWX8TzWB2ksdfxrThyu4cUdR3L1fXDMmRl8qX6B1UtjeSRakhQnO7rdjrVOmq+nfz
 pOutkoVDs7SBvQcgxsgVFv8mL7NyQ06x1xDqlxzr+oldVlfpOC1+WI/i27tL5vL4CmZv
 5509YIWWAp3fRIS51pB2KH1gwo73nC0vtSOXtvmeRwzscsPnustsyPKl0VV/Rpp8IoED
 gOoQ==
X-Gm-Message-State: AOJu0Yxehe72CEk4ZV8a+GaJ4pZ/pbOMG1ePpDgu8PKp9DtuiL/vuRES
 Zd9+qta9aU/+DbLFHxT+HI735hn9Rfx1ILhR1az/hzLOwcF/Lqam+tSyj1K+5oMxFC01rs9P7fj
 bWEL1
X-Gm-Gg: AfdE7cnORqzVezEMc1/sILulO5DYoDe0MTKjexYTo+5yQU7sAGDAb04lY4iowPx34jC
 ckLohEQ/PIZ201xg1JhT4R7Bd1piXVLyz2TS21i2kOaKzX2feck2vO/VkHHLRjTwhvNJ8y4UQbW
 SEd+MntaCXz+ggkwx4IZxiXvTS4eWDOvf70xUxYvpDWlsrJBJ4u0QeAnUHLbt6Uqjmqxva+rfrL
 GZToMASobSl96iinOmGbaC/OyCdQLih8Cz+nY2H8aEuvplgTnWv/Qhkoe2zdu1N8gvLtToYGNc3
 lksfoMnI5VlN1vbyitnthpw15sKpprmdnkUvMzzDmVWaIwDgJKrvqZfi+KPW0xvqn4ZFbQBKBN+
 Ix0eX9LaRl50npoLw+jL2wsXzXfqaSFkwycRIDebAJFA3ailuSzfQFyBgu91xuf20+46E1i2jUu
 uDlG0FhvQi9sPwkmlHAIadCjyB9om1AGs0uAtu67D9iQzJBNr06wV7xdmfEZSi6UmPc7T6Dmmkr
 RJgFH5o3/umnnPlhVKTBw==
X-Received: by 2002:a05:600c:4e53:b0:491:91cc:d12d with SMTP id
 5b1f17b1804b1-493b71dadc0mr7069375e9.25.1782734441330; 
 Mon, 29 Jun 2026 05:00:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/54] target/arm: Implement FIRSTP, LASTP
Date: Mon, 29 Jun 2026 12:59:44 +0100
Message-ID: <20260629120032.1645265-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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
Message-id: 20260618040718.572950-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  3 ++
 target/arm/tcg/sve.decode        |  3 ++
 target/arm/tcg/sve_helper.c      | 30 +++++++++++++++++
 target/arm/tcg/translate-sve.c   | 56 ++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index b64a0faa19..19bd936f6e 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -961,6 +961,9 @@ DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_2(sve2p1_cntp_c, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 
+DEF_HELPER_FLAGS_3(sve_firstp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_lastp, TCG_CALL_NO_RWG_SE, i64, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 
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
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bd8fa2da7e..b2875a559b 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4328,6 +4328,36 @@ uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
     return count >> p.lg2_stride;
 }
 
+uint64_t HELPER(sve_firstp)(void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
+    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
+
+    for (intptr_t i = 0; i < words; ++i) {
+        uint64_t t = n[i] & g[i] & mask;
+        if (t) {
+            return (i * 64 + ctz64(t)) >> esz;
+        }
+    }
+    return -1;
+}
+
+uint64_t HELPER(sve_lastp)(void *vn, void *vg, uint32_t pred_desc)
+{
+    intptr_t words = DIV_ROUND_UP(FIELD_EX32(pred_desc, PREDDESC, OPRSZ), 8);
+    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint64_t *n = vn, *g = vg, mask = pred_esz_masks[esz];
+
+    for (intptr_t i = words - 1; i >= 0; --i) {
+        uint64_t t = n[i] & g[i] & mask;
+        if (t) {
+            return (i * 64 + (63 - clz64(t))) >> esz;
+        }
+    }
+    return -1;
+}
+
 /* C.f. Arm pseudocode EncodePredCount */
 static uint64_t encode_pred_count(uint32_t elements, uint32_t count,
                                   uint32_t esz, bool invert)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 01199dbd78..63f64796e5 100644
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
+                gen_helper_sve_firstp(v, t_pn, t_pg, t_desc);
+            } else {
+                gen_helper_sve_lastp(v, t_pn, t_pg, t_desc);
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
-- 
2.43.0


