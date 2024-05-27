Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BF0C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVeM-0003uS-Tb; Mon, 27 May 2024 04:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdN-0001Pd-9w; Mon, 27 May 2024 04:23:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdL-0000uY-Hv; Mon, 27 May 2024 04:23:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1CCFF6A572;
 Mon, 27 May 2024 11:22:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 46E8BD850F;
 Mon, 27 May 2024 11:21:40 +0300 (MSK)
Received: (nullmailer pid 66415 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 21/44] target/sparc: Fix FMUL8x16A{U,L}
Date: Mon, 27 May 2024 11:21:12 +0300
Message-Id: <20240527082138.66217-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240527112053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These instructions have f32 inputs, which changes the decode
of the register numbers.  While we're fixing things, use a
common helper for both insns, extracting the 16-bit scalar
in tcg beforehand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240502165528.244004-5-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit a859602c746baf4892cc8ca1ce003e92411d1716)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 27dc604cac..9cde2b69a5 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -96,8 +96,7 @@ DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
-DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c4adc148d2..a8ada6934a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -45,6 +45,7 @@
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_done(E)                     qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
+# define gen_helper_fmul8x16a(D, S1, S2)        qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
@@ -72,8 +73,6 @@
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmul8x16al           ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmul8x16au           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
@@ -719,6 +718,18 @@ static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
+static void gen_op_fmul8x16al(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    tcg_gen_ext16s_i32(src2, src2);
+    gen_helper_fmul8x16a(dst, src1, src2);
+}
+
+static void gen_op_fmul8x16au(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    tcg_gen_sari_i32(src2, src2, 16);
+    gen_helper_fmul8x16a(dst, src1, src2);
+}
+
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -4583,6 +4594,27 @@ TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
 TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
 TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
 
+static bool do_dff(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i32, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
+TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
+
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
 {
@@ -4620,8 +4652,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
     return advance_pc(dc);
 }
 
-TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
-TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 7728ffe9c6..ff2f43c23f 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -119,44 +119,23 @@ uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16al(uint64_t src1, uint64_t src2)
+uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
 {
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(1) * (int32_t)s.VIS_B64(r);       \
-    if ((tmp & 0xff) > 0x7f) {                                  \
-        tmp += 0x100;                                           \
-    }                                                           \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
-
-    return d.ll;
-}
-
-uint64_t helper_fmul8x16au(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
+    VIS32 s;
+    VIS64 d;
     uint32_t tmp;
 
-    s.ll = src1;
-    d.ll = src2;
+    s.l = src1;
+    d.ll = 0;
 
-#define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(0) * (int32_t)s.VIS_B64(r);       \
-    if ((tmp & 0xff) > 0x7f) {                                  \
-        tmp += 0x100;                                           \
-    }                                                           \
-    d.VIS_W64(r) = tmp >> 8;
+#define PMUL(r)                                \
+    do {                                       \
+        tmp = src2 * (int32_t)s.VIS_B32(r);    \
+        if ((tmp & 0xff) > 0x7f) {             \
+            tmp += 0x100;                      \
+        }                                      \
+        d.VIS_W64(r) = tmp >> 8;               \
+    } while (0)
 
     PMUL(0);
     PMUL(1);
-- 
2.39.2


