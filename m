Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98186C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wok-0004fG-F7; Mon, 06 May 2024 07:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wnD-0002bI-IU
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:46:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmr-00025W-SR
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NVY+DInK6e9c7Rfod3udmjYDPm6WHRlbkoobfpkday0=; b=AJJfiv620T+8S/6UmLQL8dX5L3
 LWIi3XFQaE4CVpHBRpTH4KWo8uE0cTa9Qt8S8za5yfdxdEYC9eWFpAzxHd2Hi79p6t72oug3fjr9w
 b4vLuNe5VX+vwd9fghk48jYaBWIcCPGkOnF+/pLD2u5ld55k6Q/Ow5U8GkEKpMLLcpPviST+4vGrR
 pu0I2grH/QJlpEUgiwqyqTliIKMjunORuDWGOZjaQIxhLjU1/3zfyxpaeZ/wGWs0PmvOrg8hp51x6
 I+IHBVz8sutSHdGGjxBWqn0aZ9HA77DgiZsdQHnuoLZFA5ah7uZzM9YhiuU8v2KG/tiPgbEDJrNw7
 Lpint4/dCE6miLddt/1IRzgW6Lo4ev/vGAK6Tc01/JjJ340n6cVCQj692mT0DnxSI2hDVXXvl0CSh
 V6j9xacGJBH09a5vOBEKuryIfB1KPMyn0pWQlDh5ziah5rPgCPF3SxV8Y8AxXMgHYL5HD/v+SlO7f
 U/3lyqSjZhbMREwikicg9Y418H5+TbKMzlQpYM8EwKIIxDuHlChEas3wmUEvR/M3W1MR8ygwHL4wr
 puS7K6P2iMt4DKEb9XTq8RsLirnkZ2wThaz1bMh2MTnAJ4M4Xs8C4Ism78SnWHwdvFYQ7KjJNVA/6
 eb4enEojEkL6f7GgZ7yQ0eabYP1olFuF6jFWohEn8=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wln-0005pA-4f; Mon, 06 May 2024 12:44:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:49 +0100
Message-Id: <20240506114451.331311-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 10/12] target/sparc: Fix FMULD8*X16
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

Not only do these instructions have f32 inputs, they also do not
perform rounding.  Since these are relatively simple, implement
them properly inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240502165528.244004-6-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/helper.h     |  2 --
 target/sparc/translate.c  | 48 +++++++++++++++++++++++++++++++++++----
 target/sparc/vis_helper.c | 46 -------------------------------------
 3 files changed, 44 insertions(+), 52 deletions(-)

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


