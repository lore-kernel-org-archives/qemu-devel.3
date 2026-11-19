Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE89606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwus-0005zs-Rt; Thu, 19 Nov 2026 02:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwuG-0005nC-RC; Thu, 19 Nov 2026 02:50:12 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwu9-0007Ey-TQ; Thu, 19 Nov 2026 02:50:06 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S12;
 Thu, 19 Nov 2026 15:44:04 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 10/20] target/riscv: Add packed SIMD pure multiplication
 instructions
Date: Thu, 19 Nov 2026 07:43:30 +0000
Message-ID: <20261119074345.866125-11-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S12
X-Coremail-Antispam: 1UD129KBjvAXoW3tw15XFWDCF1UAr4fuw45Jrb_yoW8Zr47Xo
 Z7Cr4rZrWfGw45u343Kw1UX3Z2yrWIv3WDKFW5Zr4UWa4fWry2gryUJ348A3WxArWFyry7
 XrZ3C3s8tasaka4Dn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement packed same-width multiply-high, cross-element multiply, and
mixed-width multiply-high operations.  Cover signed, unsigned,
mixed-sign, rounded, and source-element selection variants.
Add the associated decode entries, translators and helpers.

Note that multiply-high operations retain the upper half of each
product, while their rounding variants round the product before
extracting the result.  Cross-element multiply operations select source
subelements and preserve their full products in wider destination
elements.  These operations do not affect vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       |  61 +++++++
 target/riscv/insn32.decode                  |  91 ++++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  61 +++++++
 target/riscv/tcg/psimd_helper.c             | 181 ++++++++++++++++++++
 4 files changed, 394 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4f13c7753d..daf00b260d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1599,3 +1599,64 @@ DEF_HELPER_3(pnclipup_w, i64, env, i64, i64)
 /* Packed SIMD - Count Leading Operations */
 DEF_HELPER_2(cls, tl, env, tl)
 DEF_HELPER_2(clsw, i64, env, i64)
+
+/* Packed SIMD - Pure Multiplication Operations */
+DEF_HELPER_3(pmulh_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulhsu_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulhu_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulhr_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulhrsu_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulhru_h, tl, env, tl, tl)
+DEF_HELPER_3(pmulh_w, i64, env, i64, i64)
+DEF_HELPER_3(pmulhr_w, i64, env, i64, i64)
+DEF_HELPER_3(pmulhsu_w, i64, env, i64, i64)
+DEF_HELPER_3(pmulhrsu_w, i64, env, i64, i64)
+DEF_HELPER_3(pmulhu_w, i64, env, i64, i64)
+DEF_HELPER_3(pmulhru_w, i64, env, i64, i64)
+DEF_HELPER_3(mulhr, i32, env, i32, i32)
+DEF_HELPER_3(mulhrsu, i32, env, i32, i32)
+DEF_HELPER_3(mulhru, i32, env, i32, i32)
+DEF_HELPER_3(pmulh_h_b0, tl, env, tl, tl)
+DEF_HELPER_3(pmulh_h_b1, tl, env, tl, tl)
+DEF_HELPER_3(pmulhsu_h_b0, tl, env, tl, tl)
+DEF_HELPER_3(pmulhsu_h_b1, tl, env, tl, tl)
+DEF_HELPER_3(mulh_h0, i32, env, i32, i32)
+DEF_HELPER_3(mulh_h1, i32, env, i32, i32)
+DEF_HELPER_3(mulhsu_h0, i32, env, i32, i32)
+DEF_HELPER_3(mulhsu_h1, i32, env, i32, i32)
+DEF_HELPER_3(pmulh_w_h0, i64, env, i64, i64)
+DEF_HELPER_3(pmulh_w_h1, i64, env, i64, i64)
+DEF_HELPER_3(pmulhsu_w_h0, i64, env, i64, i64)
+DEF_HELPER_3(pmulhsu_w_h1, i64, env, i64, i64)
+DEF_HELPER_3(pmul_h_b00, tl, env, tl, tl)
+DEF_HELPER_3(pmul_h_b01, tl, env, tl, tl)
+DEF_HELPER_3(pmul_h_b11, tl, env, tl, tl)
+DEF_HELPER_3(pmulsu_h_b00, tl, env, tl, tl)
+DEF_HELPER_3(pmulsu_h_b11, tl, env, tl, tl)
+DEF_HELPER_3(pmulu_h_b00, tl, env, tl, tl)
+DEF_HELPER_3(pmulu_h_b01, tl, env, tl, tl)
+DEF_HELPER_3(pmulu_h_b11, tl, env, tl, tl)
+DEF_HELPER_3(pmul_w_h00, i64, env, i64, i64)
+DEF_HELPER_3(pmul_w_h01, i64, env, i64, i64)
+DEF_HELPER_3(pmul_w_h11, i64, env, i64, i64)
+DEF_HELPER_3(pmulsu_w_h00, i64, env, i64, i64)
+DEF_HELPER_3(pmulsu_w_h11, i64, env, i64, i64)
+DEF_HELPER_3(pmulu_w_h00, i64, env, i64, i64)
+DEF_HELPER_3(pmulu_w_h01, i64, env, i64, i64)
+DEF_HELPER_3(pmulu_w_h11, i64, env, i64, i64)
+DEF_HELPER_3(mul_h00, i32, env, i32, i32)
+DEF_HELPER_3(mul_h01, i32, env, i32, i32)
+DEF_HELPER_3(mul_h11, i32, env, i32, i32)
+DEF_HELPER_3(mulsu_h00, i32, env, i32, i32)
+DEF_HELPER_3(mulsu_h11, i32, env, i32, i32)
+DEF_HELPER_3(mulu_h00, i32, env, i32, i32)
+DEF_HELPER_3(mulu_h01, i32, env, i32, i32)
+DEF_HELPER_3(mulu_h11, i32, env, i32, i32)
+DEF_HELPER_3(mul_w00, i64, env, i64, i64)
+DEF_HELPER_3(mul_w01, i64, env, i64, i64)
+DEF_HELPER_3(mul_w11, i64, env, i64, i64)
+DEF_HELPER_3(mulsu_w00, i64, env, i64, i64)
+DEF_HELPER_3(mulsu_w11, i64, env, i64, i64)
+DEF_HELPER_3(mulu_w00, i64, env, i64, i64)
+DEF_HELPER_3(mulu_w01, i64, env, i64, i64)
+DEF_HELPER_3(mulu_w11, i64, env, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e4eb8d678c..3b4b32f142 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1351,3 +1351,94 @@ pnclipup_w  1000011 ..... ..... 010 ..... 0111011 @r
 # Packed SIMD - Count Leading Operations
 cls    01100 0000011 ..... 001 ..... 0010011 @r2
 clsw   01100 0000011 ..... 001 ..... 0011011 @r2
+
+# Packed SIMD - Pure Multiplication Operations
+pmulh_h     10000 00 ..... ..... 111 ..... 0111011 @r
+pmulhsu_h   11000 00 ..... ..... 111 ..... 0111011 @r
+pmulhu_h    10010 00 ..... ..... 111 ..... 0111011 @r
+pmulhr_h    10000 10 ..... ..... 111 ..... 0111011 @r
+pmulhrsu_h  11000 10 ..... ..... 111 ..... 0111011 @r
+pmulhru_h   10010 10 ..... ..... 111 ..... 0111011 @r
+pmulh_w     10000 01 ..... ..... 111 ..... 0111011 @r
+{
+  mulhr     10000 11 ..... ..... 111 ..... 0111011 @r
+  pmulhr_w  10000 11 ..... ..... 111 ..... 0111011 @r
+}
+pmulhsu_w   11000 01 ..... ..... 111 ..... 0111011 @r
+{
+  mulhrsu   11000 11 ..... ..... 111 ..... 0111011 @r
+  pmulhrsu_w    11000 11 ..... ..... 111 ..... 0111011 @r
+}
+pmulhu_w    10010 01 ..... ..... 111 ..... 0111011 @r
+{
+  mulhru    10010 11 ..... ..... 111 ..... 0111011 @r
+  pmulhru_w 10010 11 ..... ..... 111 ..... 0111011 @r
+}
+pmulh_h_b0      10100 00 ..... ..... 111 ..... 0111011 @r
+pmulh_h_b1      10110 00 ..... ..... 111 ..... 0111011 @r
+pmulhsu_h_b0    10100 10 ..... ..... 111 ..... 0111011 @r
+pmulhsu_h_b1    10110 10 ..... ..... 111 ..... 0111011 @r
+{
+  mulh_h0       10100 01 ..... ..... 111 ..... 0111011 @r
+  pmulh_w_h0    10100 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mulh_h1       10110 01 ..... ..... 111 ..... 0111011 @r
+  pmulh_w_h1    10110 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mulhsu_h0     10100 11 ..... ..... 111 ..... 0111011 @r
+  pmulhsu_w_h0  10100 11 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mulhsu_h1     10110 11 ..... ..... 111 ..... 0111011 @r
+  pmulhsu_w_h1  10110 11 ..... ..... 111 ..... 0111011 @r
+}
+pmul_h_b00      10000 00 ..... ..... 011 ..... 0111011 @r
+pmul_h_b01      10010 00 ..... ..... 001 ..... 0111011 @r
+pmul_h_b11      10010 00 ..... ..... 011 ..... 0111011 @r
+pmulsu_h_b00    11100 00 ..... ..... 011 ..... 0111011 @r
+pmulsu_h_b11    11110 00 ..... ..... 011 ..... 0111011 @r
+pmulu_h_b00     10100 00 ..... ..... 011 ..... 0111011 @r
+pmulu_h_b01     10110 00 ..... ..... 001 ..... 0111011 @r
+pmulu_h_b11     10110 00 ..... ..... 011 ..... 0111011 @r
+{
+  mul_h00       10000 01 ..... ..... 011 ..... 0111011 @r
+  pmul_w_h00    10000 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  mul_h01       10010 01 ..... ..... 001 ..... 0111011 @r
+  pmul_w_h01    10010 01 ..... ..... 001 ..... 0111011 @r
+}
+{
+  mul_h11       10010 01 ..... ..... 011 ..... 0111011 @r
+  pmul_w_h11    10010 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  mulsu_h00     11100 01 ..... ..... 011 ..... 0111011 @r
+  pmulsu_w_h00  11100 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  mulsu_h11     11110 01 ..... ..... 011 ..... 0111011 @r
+  pmulsu_w_h11  11110 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  mulu_h00      10100 01 ..... ..... 011 ..... 0111011 @r
+  pmulu_w_h00   10100 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  mulu_h01      10110 01 ..... ..... 001 ..... 0111011 @r
+  pmulu_w_h01   10110 01 ..... ..... 001 ..... 0111011 @r
+}
+{
+  mulu_h11      10110 01 ..... ..... 011 ..... 0111011 @r
+  pmulu_w_h11   10110 01 ..... ..... 011 ..... 0111011 @r
+}
+mul_w00         10000 11 ..... ..... 011 ..... 0111011 @r
+mul_w01         10010 11 ..... ..... 001 ..... 0111011 @r
+mul_w11         10010 11 ..... ..... 011 ..... 0111011 @r
+mulsu_w00       11100 11 ..... ..... 011 ..... 0111011 @r
+mulsu_w11       11110 11 ..... ..... 011 ..... 0111011 @r
+mulu_w00        10100 11 ..... ..... 011 ..... 0111011 @r
+mulu_w01        10110 11 ..... ..... 001 ..... 0111011 @r
+mulu_w11        10110 11 ..... ..... 011 ..... 0111011 @r
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 2c9a34b9a7..39bec55bd2 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -729,3 +729,64 @@ GEN_SIMD_TRANS_64_VXSAT(pnclipup_w)
 /* Packed SIMD - Count Leading Operations */
 GEN_SIMD_TRANS_R1(cls)
 GEN_SIMD_TRANS_R1_64(clsw)
+
+/* Packed SIMD - Pure Multiplication Operations */
+GEN_SIMD_TRANS(pmulh_h)
+GEN_SIMD_TRANS(pmulhsu_h)
+GEN_SIMD_TRANS(pmulhu_h)
+GEN_SIMD_TRANS(pmulhr_h)
+GEN_SIMD_TRANS(pmulhrsu_h)
+GEN_SIMD_TRANS(pmulhru_h)
+GEN_SIMD_TRANS_64(pmulh_w)
+GEN_SIMD_TRANS_64(pmulhr_w)
+GEN_SIMD_TRANS_64(pmulhsu_w)
+GEN_SIMD_TRANS_64(pmulhrsu_w)
+GEN_SIMD_TRANS_64(pmulhu_w)
+GEN_SIMD_TRANS_64(pmulhru_w)
+GEN_SIMD_TRANS_32(mulhr)
+GEN_SIMD_TRANS_32(mulhrsu)
+GEN_SIMD_TRANS_32(mulhru)
+GEN_SIMD_TRANS(pmulh_h_b0)
+GEN_SIMD_TRANS(pmulh_h_b1)
+GEN_SIMD_TRANS(pmulhsu_h_b0)
+GEN_SIMD_TRANS(pmulhsu_h_b1)
+GEN_SIMD_TRANS_32(mulh_h0)
+GEN_SIMD_TRANS_32(mulh_h1)
+GEN_SIMD_TRANS_32(mulhsu_h0)
+GEN_SIMD_TRANS_32(mulhsu_h1)
+GEN_SIMD_TRANS_64(pmulh_w_h0)
+GEN_SIMD_TRANS_64(pmulh_w_h1)
+GEN_SIMD_TRANS_64(pmulhsu_w_h0)
+GEN_SIMD_TRANS_64(pmulhsu_w_h1)
+GEN_SIMD_TRANS(pmul_h_b00)
+GEN_SIMD_TRANS(pmul_h_b01)
+GEN_SIMD_TRANS(pmul_h_b11)
+GEN_SIMD_TRANS(pmulsu_h_b00)
+GEN_SIMD_TRANS(pmulsu_h_b11)
+GEN_SIMD_TRANS(pmulu_h_b00)
+GEN_SIMD_TRANS(pmulu_h_b01)
+GEN_SIMD_TRANS(pmulu_h_b11)
+GEN_SIMD_TRANS_64(pmul_w_h00)
+GEN_SIMD_TRANS_64(pmul_w_h01)
+GEN_SIMD_TRANS_64(pmul_w_h11)
+GEN_SIMD_TRANS_64(pmulsu_w_h00)
+GEN_SIMD_TRANS_64(pmulsu_w_h11)
+GEN_SIMD_TRANS_64(pmulu_w_h00)
+GEN_SIMD_TRANS_64(pmulu_w_h01)
+GEN_SIMD_TRANS_64(pmulu_w_h11)
+GEN_SIMD_TRANS_32(mul_h00)
+GEN_SIMD_TRANS_32(mul_h01)
+GEN_SIMD_TRANS_32(mul_h11)
+GEN_SIMD_TRANS_32(mulsu_h00)
+GEN_SIMD_TRANS_32(mulsu_h11)
+GEN_SIMD_TRANS_32(mulu_h00)
+GEN_SIMD_TRANS_32(mulu_h01)
+GEN_SIMD_TRANS_32(mulu_h11)
+GEN_SIMD_TRANS_64(mul_w00)
+GEN_SIMD_TRANS_64(mul_w01)
+GEN_SIMD_TRANS_64(mul_w11)
+GEN_SIMD_TRANS_64(mulsu_w00)
+GEN_SIMD_TRANS_64(mulsu_w11)
+GEN_SIMD_TRANS_64(mulu_w00)
+GEN_SIMD_TRANS_64(mulu_w01)
+GEN_SIMD_TRANS_64(mulu_w11)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 9bcf94c727..7d87c0bcca 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2624,3 +2624,184 @@ GEN_PSIMD_CLS(cls, target_ulong, uint32_t, clrsb32)
 #endif
 
 GEN_PSIMD_CLS(clsw, uint64_t, uint32_t, clrsb32)
+
+/* Pure multiplication operations */
+
+GEN_PSIMD_MUL_HIGH(pmulh_h, target_ulong, int16_t, int16_t, int32_t,
+                   uint16_t, EXTRACT16, INSERT16, ELEMS_H, 16, 0,
+                   PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH(pmulhsu_h, target_ulong, int16_t, uint16_t, int32_t,
+                   uint16_t, EXTRACT16, INSERT16, ELEMS_H, 16, 0,
+                   PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_HIGH(pmulhu_h, target_ulong, uint16_t, uint16_t, uint32_t,
+                   uint16_t, EXTRACT16, INSERT16, ELEMS_H, 16, 0,
+                   PSIMD_MUL_U32)
+GEN_PSIMD_MUL_HIGH(pmulhr_h, target_ulong, int16_t, int16_t, int32_t,
+                   uint16_t, EXTRACT16, INSERT16, ELEMS_H, 16, 1 << 15,
+                   PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH(pmulhrsu_h, target_ulong, int16_t, uint16_t, int32_t,
+                   uint16_t, EXTRACT16, INSERT16, ELEMS_H, 16, 1 << 15,
+                   PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_HIGH(pmulhru_h, target_ulong, uint16_t, uint16_t, uint32_t,
+                   uint16_t, EXTRACT16, INSERT16, ELEMS_H, 16, 1 << 15,
+                   PSIMD_MUL_U32)
+
+GEN_PSIMD_MUL_HIGH(pmulh_w, uint64_t, int32_t, int32_t, int64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 0,
+                   PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH(pmulhr_w, uint64_t, int32_t, int32_t, int64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 1LL << 31,
+                   PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH(pmulhsu_w, uint64_t, int32_t, uint32_t, int64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 0,
+                   PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH(pmulhrsu_w, uint64_t, int32_t, uint32_t, int64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 1LL << 31,
+                   PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH(pmulhu_w, uint64_t, uint32_t, uint32_t, uint64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 0,
+                   PSIMD_MUL_U64)
+GEN_PSIMD_MUL_HIGH(pmulhru_w, uint64_t, uint32_t, uint32_t, uint64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 1LL << 31,
+                   PSIMD_MUL_U64)
+
+GEN_PSIMD_MUL_HIGH(mulhr, uint32_t, int32_t, int32_t, int64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 1LL << 31,
+                   PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH(mulhrsu, uint32_t, int32_t, uint32_t, int64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 1LL << 31,
+                   PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH(mulhru, uint32_t, uint32_t, uint32_t, uint64_t,
+                   uint32_t, EXTRACT32, INSERT32, ELEMS_W, 32, 1LL << 31,
+                   PSIMD_MUL_U64)
+
+GEN_PSIMD_MUL_HIGH_SEL(pmulh_h_b0, target_ulong, int16_t, int8_t,
+                       int32_t, uint16_t, EXTRACT16, EXTRACT8, INSERT16,
+                       ELEMS_H, 2, 0, 8, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH_SEL(pmulh_h_b1, target_ulong, int16_t, int8_t,
+                       int32_t, uint16_t, EXTRACT16, EXTRACT8, INSERT16,
+                       ELEMS_H, 2, 1, 8, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH_SEL(pmulhsu_h_b0, target_ulong, int16_t, uint8_t,
+                       int32_t, uint16_t, EXTRACT16, EXTRACT8, INSERT16,
+                       ELEMS_H, 2, 0, 8, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_HIGH_SEL(pmulhsu_h_b1, target_ulong, int16_t, uint8_t,
+                       int32_t, uint16_t, EXTRACT16, EXTRACT8, INSERT16,
+                       ELEMS_H, 2, 1, 8, PSIMD_MUL_SU32)
+
+GEN_PSIMD_MUL_HIGH_SEL(mulh_h0, uint32_t, int32_t, int16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 0, 0, 16, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_SEL(mulh_h1, uint32_t, int32_t, int16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 0, 1, 16, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_SEL(mulhsu_h0, uint32_t, int32_t, uint16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 0, 0, 16, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_SEL(mulhsu_h1, uint32_t, int32_t, uint16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 0, 1, 16, PSIMD_MUL_SU64)
+
+GEN_PSIMD_MUL_HIGH_SEL(pmulh_w_h0, uint64_t, int32_t, int16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 2, 0, 16, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_SEL(pmulh_w_h1, uint64_t, int32_t, int16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 2, 1, 16, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_SEL(pmulhsu_w_h0, uint64_t, int32_t, uint16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 2, 0, 16, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_SEL(pmulhsu_w_h1, uint64_t, int32_t, uint16_t,
+                       int64_t, uint32_t, EXTRACT32, EXTRACT16, INSERT32,
+                       ELEMS_W, 2, 1, 16, PSIMD_MUL_SU64)
+
+GEN_PSIMD_MUL_ELEM_INDEXED(pmul_h_b00, target_ulong, int8_t, int8_t,
+                           int16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 0, 0, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmul_h_b01, target_ulong, int8_t, int8_t,
+                           int16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 0, 1, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmul_h_b11, target_ulong, int8_t, int8_t,
+                           int16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 1, 1, PSIMD_MUL_S32)
+
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulsu_h_b00, target_ulong, int8_t, uint8_t,
+                           int16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 0, 0, PSIMD_MUL_SU16)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulsu_h_b11, target_ulong, int8_t, uint8_t,
+                           int16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 1, 1, PSIMD_MUL_SU16)
+
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulu_h_b00, target_ulong, uint8_t, uint8_t,
+                           uint16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 0, 0, PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulu_h_b01, target_ulong, uint8_t, uint8_t,
+                           uint16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 0, 1, PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulu_h_b11, target_ulong, uint8_t, uint8_t,
+                           uint16_t, uint16_t, EXTRACT8, INSERT16, ELEMS_H,
+                           2, 1, 1, PSIMD_MUL_U32)
+
+GEN_PSIMD_MUL_ELEM_INDEXED(pmul_w_h00, uint64_t, int16_t, int16_t,
+                           int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 0, 0, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmul_w_h01, uint64_t, int16_t, int16_t,
+                           int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 0, 1, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmul_w_h11, uint64_t, int16_t, int16_t,
+                           int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 1, 1, PSIMD_MUL_S32)
+
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulsu_w_h00, uint64_t, int16_t, uint16_t,
+                           int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 0, 0, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulsu_w_h11, uint64_t, int16_t, uint16_t,
+                           int32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 1, 1, PSIMD_MUL_SU32)
+
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulu_w_h00, uint64_t, uint16_t, uint16_t,
+                           uint32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 0, 0, PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulu_w_h01, uint64_t, uint16_t, uint16_t,
+                           uint32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 0, 1, PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ELEM_INDEXED(pmulu_w_h11, uint64_t, uint16_t, uint16_t,
+                           uint32_t, uint32_t, EXTRACT16, INSERT32, ELEMS_W,
+                           2, 1, 1, PSIMD_MUL_U32)
+
+GEN_PSIMD_MUL_ELEM_SCALAR(mul_h00, uint32_t, int16_t, int16_t,
+                          int32_t, EXTRACT16, 0, 0, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ELEM_SCALAR(mul_h01, uint32_t, int16_t, int16_t,
+                          int32_t, EXTRACT16, 0, 1, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ELEM_SCALAR(mul_h11, uint32_t, int16_t, int16_t,
+                          int32_t, EXTRACT16, 1, 1, PSIMD_MUL_S32)
+
+GEN_PSIMD_MUL_ELEM_SCALAR(mulsu_h00, uint32_t, int16_t, uint16_t,
+                          int32_t, EXTRACT16, 0, 0, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_ELEM_SCALAR(mulsu_h11, uint32_t, int16_t, uint16_t,
+                          int32_t, EXTRACT16, 1, 1, PSIMD_MUL_SU32)
+
+GEN_PSIMD_MUL_ELEM_SCALAR(mulu_h00, uint32_t, uint16_t, uint16_t,
+                          uint32_t, EXTRACT16, 0, 0, PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ELEM_SCALAR(mulu_h01, uint32_t, uint16_t, uint16_t,
+                          uint32_t, EXTRACT16, 0, 1, PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ELEM_SCALAR(mulu_h11, uint32_t, uint16_t, uint16_t,
+                          uint32_t, EXTRACT16, 1, 1, PSIMD_MUL_U32)
+
+GEN_PSIMD_MUL_ELEM_SCALAR(mul_w00, uint64_t, int32_t, int32_t,
+                          int64_t, EXTRACT32, 0, 0, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_ELEM_SCALAR(mul_w01, uint64_t, int32_t, int32_t,
+                          int64_t, EXTRACT32, 0, 1, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_ELEM_SCALAR(mul_w11, uint64_t, int32_t, int32_t,
+                          int64_t, EXTRACT32, 1, 1, PSIMD_MUL_S64)
+
+GEN_PSIMD_MUL_ELEM_SCALAR(mulsu_w00, uint64_t, int32_t, uint32_t,
+                          int64_t, EXTRACT32, 0, 0, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_ELEM_SCALAR(mulsu_w11, uint64_t, int32_t, uint32_t,
+                          int64_t, EXTRACT32, 1, 1, PSIMD_MUL_SU64)
+
+GEN_PSIMD_MUL_ELEM_SCALAR(mulu_w00, uint64_t, uint32_t, uint32_t,
+                          uint64_t, EXTRACT32, 0, 0, PSIMD_MUL_U64)
+GEN_PSIMD_MUL_ELEM_SCALAR(mulu_w01, uint64_t, uint32_t, uint32_t,
+                          uint64_t, EXTRACT32, 0, 1, PSIMD_MUL_U64)
+GEN_PSIMD_MUL_ELEM_SCALAR(mulu_w11, uint64_t, uint32_t, uint32_t,
+                          uint64_t, EXTRACT32, 1, 1, PSIMD_MUL_U64)
-- 
2.53.0


