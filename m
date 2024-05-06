Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3548BC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3woe-0004Rr-Jc; Mon, 06 May 2024 07:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wnD-0002bH-JW
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:46:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmr-00025S-FA
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WavmyVT0W+fmmIs670leuexf31sAnaVVyxTdQUL0QZU=; b=xxNFWUKaGq5YMCRqybi5uHCo+B
 SpOhZTRK7FCaN0CXjKCn8rfdVGkJR4ukMSC0hZka5DTzwVVNGCRWLvFflXjclfeBTsiGfvD2+Gqei
 E372VDStxz2gCF5daUhZ3Rx+QjdK/n4pm5nynbaZI1vTfbQSs2BQ2dwwkTwfW0mFZ9XtoaN3GKp1F
 JW4/Pcy2+4EJDYMeaAZxtB9d0Szpaa+OZ7Lf4LKw4rxKzAfS0DOf22tK1GQFmyZb1DGkSVBe48BMN
 wXIJDoiX4Y+OJ9l9x2kLbsD9/BlNOx7dZf+UJ/998PdZSKTPSErlKXVkacTGzYy9EAwDgbvjUyanH
 FNtzh1pMbV31OsmoKPS8iLn/pE2dpSY7k41Re1Q5z8yDiqp4r4M+ZIhvxrlNCoY/EtwTIOij0VUJc
 Ro3ID/+QqHFknquOeSOpK2ZSCrlDwF0KMcaGweVd/hQV75diwlnw4qHzsUalY0TCdR9RMbM1KCVf4
 PxMyAdkbNHbsJhrQlWr4+3UPsuWwfYjbriEIb/E5KD66bPuAUBAeRvg/TfX1PNAB1ax7vEary1ZYU
 X9HgekWKQlvf6ctzoMTBQBbi5HFZmz/rhUAQMM52H6HVbJ5TF2iHb8Uzxrq175/XgaqvSkfkljkVm
 v78Ba0e5WYZg24ObYTTCswgpuLBb+tGlfUBcsNdyE=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wli-0005pA-UL; Mon, 06 May 2024 12:44:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:48 +0100
Message-Id: <20240506114451.331311-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 09/12] target/sparc: Fix FMUL8x16A{U,L}
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 target/sparc/helper.h     |  3 +--
 target/sparc/translate.c  | 38 +++++++++++++++++++++++++++----
 target/sparc/vis_helper.c | 47 +++++++++++----------------------------
 3 files changed, 48 insertions(+), 40 deletions(-)

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


