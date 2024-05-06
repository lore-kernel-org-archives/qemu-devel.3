Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B285BC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wnd-0002yg-Bt; Mon, 06 May 2024 07:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wml-00028t-3x
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmj-00023M-9k
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sMhmJO5kyFUJkf58pFSFv2atNJSSrYfDJkwhEX27jSY=; b=nW9k4wvkivfJUu5+V32rAczZ2P
 +/7EPKtAjkjUEqwTb8jGnYySbJixBhVcgfC0/CNZ2g5IOnqlvi+9JzKi0R+W1lepkZ+GfAJFX0iHR
 nJU8Pbohj1egCRD/dipFSCZAr2a7a3t45HL7zEPCr1Mj+gPFh6XLRPoVNGLBIDPbUJsGmbMdMrM4w
 4xzC1oolOERiknKqs/QiLwszDl0IOpJ4MQaLXMZaaNtwFYXNWi4Lnd8zFT2mbpY7BYsjS8zHLdQFd
 XkS5eSROOIpgcSoxP6yFCXdxDL4Ycx2UHWBDg89Rt73c8orLUMbOa5Jh3NQFdQB1UYvNqbKWKAtqC
 rWzaymlHYQpnfLjPKBWrT2SoV23PtU0eo2C2hPOYRtI4MSgQhVR2pdFPTAsbcP6XVNibQHuo/0/ug
 XyzySncr2LC/9A1HTrCLJLn9J5Nu9sjPpzl0N70EEathfs9iW4tuKWWQJkhLNwTe6i/mjruLrgEZR
 pUmMWviqZSfQODqwMdosgbtm7Pv883MRFQoUqNAI0NeUVpWNYj/aMGU67TM6agjlBCSM+p+r5gUXJ
 qnrkEM6G3LHVzwkNpGN1zlgMCO+VSVmU45sSiVnMpHJ5Z6sLZ4Yp520G7BY4LpwyqKk1UcBOcMi8+
 90Iqz5sUcibgUBk89jDB2lB1QZHqMzGvsF7XuitRw=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wla-0005pA-OL; Mon, 06 May 2024 12:44:26 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:46 +0100
Message-Id: <20240506114451.331311-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 07/12] target/sparc: Fix FEXPAND
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

This is a 2-operand instruction, not 3-operand.
Worse, we took the source from the wrong operand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240502165528.244004-3-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/insns.decode |  2 +-
 target/sparc/translate.c  | 20 +++++++++++++++++++-
 target/sparc/vis_helper.c |  6 +++---
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b8087d0d2b..57ab755ffd 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -102,7 +102,7 @@ DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fexpand, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2d26404cb2..e2d8a07dc4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -352,7 +352,7 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @r_r_r
-    FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
+    FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @r_r2
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 571b3e3f03..dfcfe855a1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4358,6 +4358,25 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_df(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i64, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = tcg_temp_new_i64();
+    src = gen_load_fpr_F(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FEXPAND, VIS1, do_df, a, gen_helper_fexpand)
+
 static bool do_env_df(DisasContext *dc, arg_r_r *a,
                       void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
 {
@@ -4589,7 +4608,6 @@ TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
 TRANS(FMULD8ULx16, VIS1, do_ddd, a, gen_helper_fmuld8ulx16)
 TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
-TRANS(FEXPAND, VIS1, do_ddd, a, gen_helper_fexpand)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
 TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 7763b16c24..db2e6dd6c1 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -260,13 +260,13 @@ uint64_t helper_fmuld8ulx16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fexpand(uint64_t src1, uint64_t src2)
+uint64_t helper_fexpand(uint32_t src2)
 {
     VIS32 s;
     VIS64 d;
 
-    s.l = (uint32_t)src1;
-    d.ll = src2;
+    s.l = src2;
+    d.ll = 0;
     d.VIS_W64(0) = s.VIS_B32(0) << 4;
     d.VIS_W64(1) = s.VIS_B32(1) << 4;
     d.VIS_W64(2) = s.VIS_B32(2) << 4;
-- 
2.39.2


