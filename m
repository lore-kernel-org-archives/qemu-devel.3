Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C3606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwpS-0007HV-Fk; Thu, 19 Nov 2026 02:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwos-0006y5-ON; Thu, 19 Nov 2026 02:44:42 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoo-0001jo-Ay; Thu, 19 Nov 2026 02:44:34 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S16;
 Thu, 19 Nov 2026 15:44:06 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 14/20] target/riscv: Add packed SIMD two-way
 multiply-add/subtract instructions
Date: Thu, 19 Nov 2026 07:43:34 +0000
Message-ID: <20261119074345.866125-15-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S16
X-Coremail-Antispam: 1UD129KBjvAXoW3CrWDuFyrWryrKr1kXF1xAFb_yoW8GF15Xo
 Z29r15ZrZ3Gw1Uuryakw18XFn7XrykX3yDGrWUZr43WFWfXr1agr4UJ34UZ3WIyrWayFW7
 XrZakw15tF9a934Dn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUO-7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl
 6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWU
 JVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxV
 A2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
 6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
 C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_
 Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r
 1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
 JbIYCTnIWIevJa73UjIFyTuYvjfUOR6zUUUUU
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.993,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 6a41d0a9bf..4a38b1a9c0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1744,3 +1744,39 @@ DEF_HELPER_4(pmqacc_w_h11, i64, env, i64, i64, i64)
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
index 62a1b7b21b..42750bde00 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1578,3 +1578,39 @@ mqacc_w11       11111 01 ..... ..... 111 ..... 0111011 @r
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
index ef3c5b00a3..65647fd61e 100644
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
index 6df8b65ca5..61ba98e723 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -3096,3 +3096,122 @@ GEN_PSIMD_QMUL_ACC_INDEXED(pmqracc_w_h11, uint64_t, int16_t, int16_t,
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
2.53.0


