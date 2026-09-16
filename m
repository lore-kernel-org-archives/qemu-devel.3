Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C98C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jkk-0005nF-Sq; Wed, 16 Sep 2026 03:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkb-0005dj-MA; Wed, 16 Sep 2026 03:08:14 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkV-0008JK-1m; Wed, 16 Sep 2026 03:08:13 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S12;
 Wed, 16 Sep 2026 15:08:03 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 10/19] target/riscv: Add packed SIMD pure multiplication
 instructions
Date: Wed, 16 Sep 2026 07:07:12 +0000
Message-Id: <20260916070721.3279229-11-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S12
X-Coremail-Antispam: 1UD129KBjvAXoW3tw15XFWDCF1UAr4fuw45Jrb_yoW8Zr4xJo
 Z7Cr4rZrWfGw45u343Kw1UX3Z2yrWIv3WDKFW5Zr4UWa4fWry2gryUJ348A3WxArWFyry7
 XrZ3C3s8tasaka4Dn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUO97AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
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
index 55d95c6eb6d..c6e69163262 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1560,3 +1560,64 @@ DEF_HELPER_3(pnclipup_w, i64, env, i64, i64)
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
index 38210bb4934..94736a24038 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1340,3 +1340,94 @@ pnclipup_w  1000011 ..... ..... 010 ..... 0111011 @r
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
index 2c9a34b9a7e..39bec55bd25 100644
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
index f883596fe49..f84b43bfaa7 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2629,3 +2629,184 @@ GEN_PSIMD_CLS(cls, target_ulong, uint32_t, clrsb32)
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
2.34.1


