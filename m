Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A70C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVfl-0005c9-8W; Mon, 27 May 2024 04:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdi-0001dD-Ie; Mon, 27 May 2024 04:23:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdg-0000vD-IO; Mon, 27 May 2024 04:23:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D64C6A573;
 Mon, 27 May 2024 11:22:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 58C0FD8510;
 Mon, 27 May 2024 11:21:40 +0300 (MSK)
Received: (nullmailer pid 66418 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 22/44] target/sparc: Fix FMULD8*X16
Date: Mon, 27 May 2024 11:21:13 +0300
Message-Id: <20240527082138.66217-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
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

Not only do these instructions have f32 inputs, they also do not
perform rounding.  Since these are relatively simple, implement
them properly inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240502165528.244004-6-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit be8998e046c2a7e434494b75cf468ffd9d536025)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 9cde2b69a5..fcb9c617b7 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -99,8 +99,6 @@ DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a8ada6934a..8a2894bb9f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -74,8 +74,6 @@
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
@@ -730,6 +728,48 @@ static void gen_op_fmul8x16au(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
     gen_helper_fmul8x16a(dst, src1, src2);
 }
 
+static void gen_op_fmuld8ulx16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+
+    tcg_gen_ext8u_i32(t0, src1);
+    tcg_gen_ext16s_i32(t1, src2);
+    tcg_gen_mul_i32(t0, t0, t1);
+
+    tcg_gen_extract_i32(t1, src1, 16, 8);
+    tcg_gen_sextract_i32(t2, src2, 16, 16);
+    tcg_gen_mul_i32(t1, t1, t2);
+
+    tcg_gen_concat_i32_i64(dst, t0, t1);
+}
+
+static void gen_op_fmuld8sux16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+
+    /*
+     * The insn description talks about extracting the upper 8 bits
+     * of the signed 16-bit input rs1, performing the multiply, then
+     * shifting left by 8 bits.  Instead, zap the lower 8 bits of
+     * the rs1 input, which avoids the need for two shifts.
+     */
+    tcg_gen_ext16s_i32(t0, src1);
+    tcg_gen_andi_i32(t0, t0, ~0xff);
+    tcg_gen_ext16s_i32(t1, src2);
+    tcg_gen_mul_i32(t0, t0, t1);
+
+    tcg_gen_sextract_i32(t1, src1, 16, 16);
+    tcg_gen_andi_i32(t1, t1, ~0xff);
+    tcg_gen_sextract_i32(t2, src2, 16, 16);
+    tcg_gen_mul_i32(t1, t1, t2);
+
+    tcg_gen_concat_i32_i64(dst, t0, t1);
+}
+
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -4614,6 +4654,8 @@ static bool do_dff(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
+TRANS(FMULD8SUx16, VIS1, do_dff, a, gen_op_fmuld8sux16)
+TRANS(FMULD8ULx16, VIS1, do_dff, a, gen_op_fmuld8ulx16)
 
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
@@ -4654,8 +4696,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
-TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
-TRANS(FMULD8ULx16, VIS1, do_ddd, a, gen_helper_fmuld8ulx16)
 TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index ff2f43c23f..61c61c7fea 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -194,52 +194,6 @@ uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmuld8sux16(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((int32_t)s.VIS_SW64(r) >> 8);       \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_L64(r) = tmp;
-
-    /* Reverse calculation order to handle overlap */
-    PMUL(1);
-    PMUL(0);
-#undef PMUL
-
-    return d.ll;
-}
-
-uint64_t helper_fmuld8ulx16(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 2));        \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_L64(r) = tmp;
-
-    /* Reverse calculation order to handle overlap */
-    PMUL(1);
-    PMUL(0);
-#undef PMUL
-
-    return d.ll;
-}
-
 uint64_t helper_fexpand(uint32_t src2)
 {
     VIS32 s;
-- 
2.39.2


