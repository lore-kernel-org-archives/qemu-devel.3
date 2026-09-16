Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B145C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jrW-0005qO-7Y; Wed, 16 Sep 2026 03:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqw-0005bF-5i; Wed, 16 Sep 2026 03:14:48 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqs-0000zW-0G; Wed, 16 Sep 2026 03:14:45 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S16;
 Wed, 16 Sep 2026 15:08:04 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 14/19] target/riscv: Add packed SIMD two-way
 multiply-add/subtract instructions
Date: Wed, 16 Sep 2026 07:07:16 +0000
Message-Id: <20260916070721.3279229-15-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S16
X-Coremail-Antispam: 1UD129KBjvAXoW3CrWDuFyrWryDKFy3ZryUGFg_yoW8GF1rJo
 Z29r15ZrZ3Cw1Uuryakw1UXFn7XrykX3yDGrWUZr43WFWfXr1agr4UJ34UZ3WIyrWayFW7
 XrZakw15tF9a934Dn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUO97AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoBTYUUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.74,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Implement Q-format horizontal multiply-add and PM2 horizontal
multiply-add/subtract operations.  Cover signed, unsigned, mixed-sign,
corresponding and crossed element pairing, accumulating and
non-accumulating, and rounded and non-rounded variants. Add
the associated decode entries, translators and helpers.

These instructions combine two products from each packed element group
using addition or subtraction.  Q-format variants discard the low
fractional bits of each product, while rounded variants add the required
rounding value before extraction.  Accumulating variants add the
combined result to the corresponding element of rd.  Note that
PM2SADD.H and PM2SADD.HX clamp out-of-range sums to the signed
destination range and set vxsat; the other operations wrap to the
destination width and do not affect vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       |  36 ++++++
 target/riscv/insn32.decode                  |  36 ++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  36 ++++++
 target/riscv/tcg/psimd_helper.c             | 119 ++++++++++++++++++++
 4 files changed, 227 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 7a052991ad1..5e33026bcb0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1705,3 +1705,39 @@ DEF_HELPER_4(pmqacc_w_h11, i64, env, i64, i64, i64)
 DEF_HELPER_4(pmqracc_w_h00, i64, env, i64, i64, i64)
 DEF_HELPER_4(pmqracc_w_h01, i64, env, i64, i64, i64)
 DEF_HELPER_4(pmqracc_w_h11, i64, env, i64, i64, i64)
+
+/* Packed SIMD - Two-Way Multiply and Accumulate Operations */
+DEF_HELPER_3(pmq2add_h, tl, env, tl, tl)
+DEF_HELPER_3(pmqr2add_h, tl, env, tl, tl)
+DEF_HELPER_4(pmq2adda_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmqr2adda_h, tl, env, tl, tl, tl)
+DEF_HELPER_3(pmq2add_w, i64, env, i64, i64)
+DEF_HELPER_3(pmqr2add_w, i64, env, i64, i64)
+DEF_HELPER_4(pmq2adda_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmqr2adda_w, i64, env, i64, i64, i64)
+DEF_HELPER_3(pm2add_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2addsu_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2addu_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2add_hx, tl, env, tl, tl)
+DEF_HELPER_3(pm2sub_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2sub_hx, tl, env, tl, tl)
+DEF_HELPER_3(pm2sadd_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2sadd_hx, tl, env, tl, tl)
+DEF_HELPER_4(pm2adda_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2addasu_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2addau_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2adda_hx, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2suba_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pm2suba_hx, tl, env, tl, tl, tl)
+DEF_HELPER_3(pm2add_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2addsu_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2addu_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2add_wx, i64, env, i64, i64)
+DEF_HELPER_3(pm2sub_w, i64, env, i64, i64)
+DEF_HELPER_3(pm2sub_wx, i64, env, i64, i64)
+DEF_HELPER_4(pm2adda_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2addasu_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2addau_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2adda_wx, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2suba_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pm2suba_wx, i64, env, i64, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 3d9e79de58f..263e02ef903 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1567,3 +1567,39 @@ mqacc_w11       11111 01 ..... ..... 111 ..... 0111011 @r
 mqracc_w00      11101 11 ..... ..... 111 ..... 0111011 @r
 mqracc_w01      11111 11 ..... ..... 101 ..... 0111011 @r
 mqracc_w11      11111 11 ..... ..... 111 ..... 0111011 @r
+
+# Packed SIMD - Two-Way Multiply and Accumulate Operations
+pmq2add_h       10110 00 ..... ..... 101 ..... 0111011 @r
+pmqr2add_h      10110 10 ..... ..... 101 ..... 0111011 @r
+pmq2adda_h      10111 00 ..... ..... 101 ..... 0111011 @r
+pmqr2adda_h     10111 10 ..... ..... 101 ..... 0111011 @r
+pmq2add_w       10110 01 ..... ..... 101 ..... 0111011 @r
+pmqr2add_w      10110 11 ..... ..... 101 ..... 0111011 @r
+pmq2adda_w      10111 01 ..... ..... 101 ..... 0111011 @r
+pmqr2adda_w     10111 11 ..... ..... 101 ..... 0111011 @r
+pm2add_h        10000 00 ..... ..... 101 ..... 0111011 @r
+pm2addsu_h      11100 00 ..... ..... 101 ..... 0111011 @r
+pm2addu_h       10100 00 ..... ..... 101 ..... 0111011 @r
+pm2add_hx       10010 00 ..... ..... 101 ..... 0111011 @r
+pm2sub_h        11000 00 ..... ..... 101 ..... 0111011 @r
+pm2sub_hx       11010 00 ..... ..... 101 ..... 0111011 @r
+pm2sadd_h       11000 10 ..... ..... 101 ..... 0111011 @r
+pm2sadd_hx      11010 10 ..... ..... 101 ..... 0111011 @r
+pm2adda_h       10001 00 ..... ..... 101 ..... 0111011 @r
+pm2addasu_h     11101 00 ..... ..... 101 ..... 0111011 @r
+pm2addau_h      10101 00 ..... ..... 101 ..... 0111011 @r
+pm2adda_hx      10011 00 ..... ..... 101 ..... 0111011 @r
+pm2suba_h       11001 00 ..... ..... 101 ..... 0111011 @r
+pm2suba_hx      11011 00 ..... ..... 101 ..... 0111011 @r
+pm2add_w        10000 01 ..... ..... 101 ..... 0111011 @r
+pm2addsu_w      11100 01 ..... ..... 101 ..... 0111011 @r
+pm2addu_w       10100 01 ..... ..... 101 ..... 0111011 @r
+pm2add_wx       10010 01 ..... ..... 101 ..... 0111011 @r
+pm2sub_w        11000 01 ..... ..... 101 ..... 0111011 @r
+pm2sub_wx       11010 01 ..... ..... 101 ..... 0111011 @r
+pm2adda_w       10001 01 ..... ..... 101 ..... 0111011 @r
+pm2addasu_w     11101 01 ..... ..... 101 ..... 0111011 @r
+pm2addau_w      10101 01 ..... ..... 101 ..... 0111011 @r
+pm2adda_wx      10011 01 ..... ..... 101 ..... 0111011 @r
+pm2suba_w       11001 01 ..... ..... 101 ..... 0111011 @r
+pm2suba_wx      11011 01 ..... ..... 101 ..... 0111011 @r
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index ef3c5b00a3a..65647fd61eb 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -874,3 +874,39 @@ GEN_SIMD_TRANS_ACC_64(pmqacc_w_h11)
 GEN_SIMD_TRANS_ACC_64(pmqracc_w_h00)
 GEN_SIMD_TRANS_ACC_64(pmqracc_w_h01)
 GEN_SIMD_TRANS_ACC_64(pmqracc_w_h11)
+
+/* Packed SIMD - Two-Way Multiply and Accumulate Operations */
+GEN_SIMD_TRANS(pmq2add_h)
+GEN_SIMD_TRANS(pmqr2add_h)
+GEN_SIMD_TRANS_ACC(pmq2adda_h)
+GEN_SIMD_TRANS_ACC(pmqr2adda_h)
+GEN_SIMD_TRANS_64(pmq2add_w)
+GEN_SIMD_TRANS_64(pmqr2add_w)
+GEN_SIMD_TRANS_ACC_64(pmq2adda_w)
+GEN_SIMD_TRANS_ACC_64(pmqr2adda_w)
+GEN_SIMD_TRANS(pm2add_h)
+GEN_SIMD_TRANS(pm2addsu_h)
+GEN_SIMD_TRANS(pm2addu_h)
+GEN_SIMD_TRANS(pm2add_hx)
+GEN_SIMD_TRANS(pm2sub_h)
+GEN_SIMD_TRANS(pm2sub_hx)
+GEN_SIMD_TRANS_VXSAT(pm2sadd_h)
+GEN_SIMD_TRANS_VXSAT(pm2sadd_hx)
+GEN_SIMD_TRANS_ACC(pm2adda_h)
+GEN_SIMD_TRANS_ACC(pm2addasu_h)
+GEN_SIMD_TRANS_ACC(pm2addau_h)
+GEN_SIMD_TRANS_ACC(pm2adda_hx)
+GEN_SIMD_TRANS_ACC(pm2suba_h)
+GEN_SIMD_TRANS_ACC(pm2suba_hx)
+GEN_SIMD_TRANS_64(pm2add_w)
+GEN_SIMD_TRANS_64(pm2addsu_w)
+GEN_SIMD_TRANS_64(pm2addu_w)
+GEN_SIMD_TRANS_64(pm2add_wx)
+GEN_SIMD_TRANS_64(pm2sub_w)
+GEN_SIMD_TRANS_64(pm2sub_wx)
+GEN_SIMD_TRANS_ACC_64(pm2adda_w)
+GEN_SIMD_TRANS_ACC_64(pm2addasu_w)
+GEN_SIMD_TRANS_ACC_64(pm2addau_w)
+GEN_SIMD_TRANS_ACC_64(pm2adda_wx)
+GEN_SIMD_TRANS_ACC_64(pm2suba_w)
+GEN_SIMD_TRANS_ACC_64(pm2suba_wx)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index feb93561e60..639557351da 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -3101,3 +3101,122 @@ GEN_PSIMD_QMUL_ACC_INDEXED(pmqracc_w_h11, uint64_t, int16_t, int16_t,
                            int32_t, int64_t, int32_t, uint32_t, EXTRACT16,
                            EXTRACT32, INSERT32, ELEMS_W, 2, 1, 1, 15,
                            1LL << 14, PSIMD_MUL_S64)
+
+/* Two-Way Multiply and Accumulate Operations */
+
+GEN_PSIMD_Q2ADD(pmq2add_h, target_ulong, int16_t, int32_t, int64_t,
+                uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2, 15, 0,
+                PSIMD_MUL_S32)
+GEN_PSIMD_Q2ADD(pmqr2add_h, target_ulong, int16_t, int32_t, int64_t,
+                uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2, 15, 1LL << 14,
+                PSIMD_MUL_S32)
+GEN_PSIMD_Q2ADDA(pmq2adda_h, target_ulong, int16_t, int32_t, int32_t,
+                 int64_t, uint32_t, EXTRACT16, EXTRACT32, INSERT32,
+                 ELEMS_W, 2, 15, 0, PSIMD_MUL_S32)
+GEN_PSIMD_Q2ADDA(pmqr2adda_h, target_ulong, int16_t, int32_t, int32_t,
+                 int64_t, uint32_t, EXTRACT16, EXTRACT32, INSERT32,
+                 ELEMS_W, 2, 15, 1LL << 14, PSIMD_MUL_S32)
+
+GEN_PSIMD_Q2ADD(pmq2add_w, uint64_t, int32_t, int64_t, int64_t,
+                uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0, 31, 0,
+                PSIMD_MUL_S64)
+GEN_PSIMD_Q2ADD(pmqr2add_w, uint64_t, int32_t, int64_t, int64_t,
+                uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0, 31, 1LL << 30,
+                PSIMD_MUL_S64)
+GEN_PSIMD_Q2ADDA(pmq2adda_w, uint64_t, int32_t, int64_t, int64_t,
+                 int64_t, uint64_t, EXTRACT32, EXTRACT64, INSERT64,
+                 ELEMS_D, 0, 31, 0, PSIMD_MUL_S64)
+GEN_PSIMD_Q2ADDA(pmqr2adda_w, uint64_t, int32_t, int64_t, int64_t,
+                 int64_t, uint64_t, EXTRACT32, EXTRACT64, INSERT64,
+                 ELEMS_D, 0, 31, 1LL << 30, PSIMD_MUL_S64)
+
+GEN_PSIMD_2WAY_MUL(pm2add_h, target_ulong, int16_t, int16_t,
+                   int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2,
+                   0, 1, 0, 1, PSIMD_MUL_S32, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2addsu_h, target_ulong, int16_t, uint16_t,
+                   int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2,
+                   0, 1, 0, 1, PSIMD_MUL_SU32, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2addu_h, target_ulong, uint16_t, uint16_t,
+                   uint32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2,
+                   0, 1, 0, 1, PSIMD_MUL_U32, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2add_hx, target_ulong, int16_t, int16_t,
+                   int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2,
+                   0, 1, 1, 0, PSIMD_MUL_S32, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2sub_h, target_ulong, int16_t, int16_t,
+                   int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2,
+                   0, 1, 0, 1, PSIMD_MUL_S32, PSIMD_COMB_SUB)
+GEN_PSIMD_2WAY_MUL(pm2sub_hx, target_ulong, int16_t, int16_t,
+                   int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W, 2,
+                   0, 1, 1, 0, PSIMD_MUL_S32, PSIMD_COMB_SUB)
+
+GEN_PSIMD_2WAY_SAT_MUL(pm2sadd_h, 0, 1, 0, 1)
+GEN_PSIMD_2WAY_SAT_MUL(pm2sadd_hx, 0, 1, 1, 0)
+
+GEN_PSIMD_2WAY_MUL_ACC(pm2adda_h, target_ulong, int16_t, int16_t,
+                       int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                       INSERT32, ELEMS_W, 2, 0, 1, 0, 1, PSIMD_MUL_S32,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2addasu_h, target_ulong, int16_t, uint16_t,
+                       int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                       INSERT32, ELEMS_W, 2, 0, 1, 0, 1, PSIMD_MUL_SU32,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2addau_h, target_ulong, uint16_t, uint16_t,
+                       uint32_t, uint32_t, uint32_t, EXTRACT16, EXTRACT32,
+                       INSERT32, ELEMS_W, 2, 0, 1, 0, 1, PSIMD_MUL_U32,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2adda_hx, target_ulong, int16_t, int16_t,
+                       int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                       INSERT32, ELEMS_W, 2, 0, 1, 1, 0, PSIMD_MUL_S32,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2suba_h, target_ulong, int16_t, int16_t,
+                       int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                       INSERT32, ELEMS_W, 2, 0, 1, 0, 1, PSIMD_MUL_S32,
+                       PSIMD_COMB_SUB)
+GEN_PSIMD_2WAY_MUL_ACC(pm2suba_hx, target_ulong, int16_t, int16_t,
+                       int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                       INSERT32, ELEMS_W, 2, 0, 1, 1, 0, PSIMD_MUL_S32,
+                       PSIMD_COMB_SUB)
+
+GEN_PSIMD_2WAY_MUL(pm2add_w, uint64_t, int32_t, int32_t,
+                   int64_t, uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0,
+                   0, 1, 0, 1, PSIMD_MUL_S64, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2addsu_w, uint64_t, int32_t, uint32_t,
+                   int64_t, uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0,
+                   0, 1, 0, 1, PSIMD_MUL_SU64, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2addu_w, uint64_t, uint32_t, uint32_t,
+                   uint64_t, uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0,
+                   0, 1, 0, 1, PSIMD_MUL_U64, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2add_wx, uint64_t, int32_t, int32_t,
+                   int64_t, uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0,
+                   0, 1, 1, 0, PSIMD_MUL_S64, PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL(pm2sub_w, uint64_t, int32_t, int32_t,
+                   int64_t, uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0,
+                   0, 1, 0, 1, PSIMD_MUL_S64, PSIMD_COMB_SUB)
+GEN_PSIMD_2WAY_MUL(pm2sub_wx, uint64_t, int32_t, int32_t,
+                   int64_t, uint64_t, EXTRACT32, INSERT64, ELEMS_D, 0,
+                   0, 1, 1, 0, PSIMD_MUL_S64, PSIMD_COMB_SUB)
+
+GEN_PSIMD_2WAY_MUL_ACC(pm2adda_w, uint64_t, int32_t, int32_t,
+                       int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, 0, 1, 0, 1, PSIMD_MUL_S64,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2addasu_w, uint64_t, int32_t, uint32_t,
+                       int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, 0, 1, 0, 1, PSIMD_MUL_SU64,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2addau_w, uint64_t, uint32_t, uint32_t,
+                       uint64_t, uint64_t, uint64_t, EXTRACT32, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, 0, 1, 0, 1, PSIMD_MUL_U64,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2adda_wx, uint64_t, int32_t, int32_t,
+                       int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, 0, 1, 1, 0, PSIMD_MUL_S64,
+                       PSIMD_COMB_ADD)
+GEN_PSIMD_2WAY_MUL_ACC(pm2suba_w, uint64_t, int32_t, int32_t,
+                       int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, 0, 1, 0, 1, PSIMD_MUL_S64,
+                       PSIMD_COMB_SUB)
+GEN_PSIMD_2WAY_MUL_ACC(pm2suba_wx, uint64_t, int32_t, int32_t,
+                       int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                       INSERT64, ELEMS_D, 0, 0, 1, 1, 0, PSIMD_MUL_S64,
+                       PSIMD_COMB_SUB)
-- 
2.34.1


