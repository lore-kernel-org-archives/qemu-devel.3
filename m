Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8830C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBViu-0005ON-V5; Mon, 27 May 2024 04:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdl-0001gA-Jb; Mon, 27 May 2024 04:23:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBVdj-0000wj-4n; Mon, 27 May 2024 04:23:32 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A6BB6A574;
 Mon, 27 May 2024 11:22:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 690F4D8511;
 Mon, 27 May 2024 11:21:40 +0300 (MSK)
Received: (nullmailer pid 66421 invoked by uid 1000);
 Mon, 27 May 2024 08:21:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 23/44] target/sparc: Fix FPMERGE
Date: Mon, 27 May 2024 11:21:14 +0300
Message-Id: <20240527082138.66217-23-mjt@tls.msk.ru>
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

This instruction has f32 inputs, which changes the decode
of the register numbers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240502165528.244004-7-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
(cherry picked from commit d3ef26afde77fbdedd5b30282134ff99d0fe5cc5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index fcb9c617b7..97fbf6f66c 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -94,7 +94,7 @@ DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_WG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
 DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
-DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8a2894bb9f..99c6f3cc72 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4656,6 +4656,7 @@ TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
 TRANS(FMULD8SUx16, VIS1, do_dff, a, gen_op_fmuld8sux16)
 TRANS(FMULD8ULx16, VIS1, do_dff, a, gen_op_fmuld8ulx16)
+TRANS(FPMERGE, VIS1, do_dff, a, gen_helper_fpmerge)
 
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
@@ -4696,7 +4697,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
-TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
 TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 61c61c7fea..14c665cad6 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -74,22 +74,23 @@ typedef union {
     float32 f;
 } VIS32;
 
-uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
+uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s1, s2;
+    VIS64 d;
 
-    s.ll = src1;
-    d.ll = src2;
+    s1.l = src1;
+    s2.l = src2;
+    d.ll = 0;
 
-    /* Reverse calculation order to handle overlap */
-    d.VIS_B64(7) = s.VIS_B64(3);
-    d.VIS_B64(6) = d.VIS_B64(3);
-    d.VIS_B64(5) = s.VIS_B64(2);
-    d.VIS_B64(4) = d.VIS_B64(2);
-    d.VIS_B64(3) = s.VIS_B64(1);
-    d.VIS_B64(2) = d.VIS_B64(1);
-    d.VIS_B64(1) = s.VIS_B64(0);
-    /* d.VIS_B64(0) = d.VIS_B64(0); */
+    d.VIS_B64(7) = s1.VIS_B32(3);
+    d.VIS_B64(6) = s2.VIS_B32(3);
+    d.VIS_B64(5) = s1.VIS_B32(2);
+    d.VIS_B64(4) = s2.VIS_B32(2);
+    d.VIS_B64(3) = s1.VIS_B32(1);
+    d.VIS_B64(2) = s2.VIS_B32(1);
+    d.VIS_B64(1) = s1.VIS_B32(0);
+    d.VIS_B64(0) = s2.VIS_B32(0);
 
     return d.ll;
 }
-- 
2.39.2


