Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16F5C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoZp-0004QT-7s; Wed, 21 Feb 2024 10:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcoOV-0002YR-9s; Wed, 21 Feb 2024 10:20:23 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchuQ-0002gG-Vc; Wed, 21 Feb 2024 03:24:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1CA24F3E9;
 Wed, 21 Feb 2024 11:21:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9B42E860C8;
 Wed, 21 Feb 2024 11:21:01 +0300 (MSK)
Received: (nullmailer pid 2142118 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 43/60] target/arm: Split out make_svemte_desc
Date: Wed, 21 Feb 2024 11:20:31 +0300
Message-Id: <20240221082058.2141850-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Share code that creates mtedesc and embeds within simd_desc.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 96fcc9982b4aad7aced7fbff046048bbccc6cb0c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 96ba39b37e..7b811b8ac5 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -28,6 +28,8 @@ bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
 bool sve_access_check(DisasContext *s);
 bool sme_enabled_check(DisasContext *s);
 bool sme_enabled_check_with_svcr(DisasContext *s, unsigned);
+uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+                          uint32_t msz, bool is_write, uint32_t data);
 
 /* This function corresponds to CheckStreamingSVEEnabled. */
 static inline bool sme_sm_enabled_check(DisasContext *s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8f0dfc884e..46c7fce8b4 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -206,7 +206,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 
     TCGv_ptr t_za, t_pg;
     TCGv_i64 addr;
-    int svl, desc = 0;
+    uint32_t desc;
     bool be = s->be_data == MO_BE;
     bool mte = s->mte_active[0];
 
@@ -224,18 +224,11 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
     tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->esz);
     tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
 
-    if (mte) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, a->st);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << a->esz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
-    } else {
+    if (!mte) {
         addr = clean_data_tbi(s, addr);
     }
-    svl = streaming_vec_reg_size(s);
-    desc = simd_desc(svl, svl, desc);
+
+    desc = make_svemte_desc(s, streaming_vec_reg_size(s), 1, a->esz, a->st, 0);
 
     fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg, addr,
                                       tcg_constant_i32(desc));
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a88e523cba..508f7b6bbd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4437,18 +4437,18 @@ static const uint8_t dtype_esz[16] = {
     3, 2, 1, 3
 };
 
-static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
-                       int dtype, uint32_t mte_n, bool is_write,
-                       gen_helper_gvec_mem *fn)
+uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+                          uint32_t msz, bool is_write, uint32_t data)
 {
-    unsigned vsz = vec_full_reg_size(s);
-    TCGv_ptr t_pg;
     uint32_t sizem1;
-    int desc = 0;
+    uint32_t desc = 0;
 
-    assert(mte_n >= 1 && mte_n <= 4);
-    sizem1 = (mte_n << dtype_msz(dtype)) - 1;
+    /* Assert all of the data fits, with or without MTE enabled. */
+    assert(nregs >= 1 && nregs <= 4);
+    sizem1 = (nregs << msz) - 1;
     assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
+    assert(data < 1u << SVE_MTEDESC_SHIFT);
+
     if (s->mte_active[0]) {
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
@@ -4456,7 +4456,18 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
         desc <<= SVE_MTEDESC_SHIFT;
-    } else {
+    }
+    return simd_desc(vsz, vsz, desc | data);
+}
+
+static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
+                       int dtype, uint32_t nregs, bool is_write,
+                       gen_helper_gvec_mem *fn)
+{
+    TCGv_ptr t_pg;
+    uint32_t desc;
+
+    if (!s->mte_active[0]) {
         addr = clean_data_tbi(s, addr);
     }
 
@@ -4465,7 +4476,8 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
      */
-    desc = simd_desc(vsz, vsz, zt | desc);
+    desc = make_svemte_desc(s, vec_full_reg_size(s), nregs,
+                            dtype_msz(dtype), is_write, zt);
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
@@ -5224,25 +5236,16 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
                        int scale, TCGv_i64 scalar, int msz, bool is_write,
                        gen_helper_gvec_mem_scatter *fn)
 {
-    unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_zm = tcg_temp_new_ptr();
     TCGv_ptr t_pg = tcg_temp_new_ptr();
     TCGv_ptr t_zt = tcg_temp_new_ptr();
-    int desc = 0;
-
-    if (s->mte_active[0]) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << msz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
-    }
-    desc = simd_desc(vsz, vsz, desc | scale);
+    uint32_t desc;
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
     tcg_gen_addi_ptr(t_zm, tcg_env, vec_full_reg_offset(s, zm));
     tcg_gen_addi_ptr(t_zt, tcg_env, vec_full_reg_offset(s, zt));
+
+    desc = make_svemte_desc(s, vec_full_reg_size(s), 1, msz, is_write, scale);
     fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i32(desc));
 }
 
-- 
2.39.2


