Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FDEC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jrI-0005f6-At; Wed, 16 Sep 2026 03:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqw-0005bH-Ll; Wed, 16 Sep 2026 03:14:48 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jqs-0000zT-0L; Wed, 16 Sep 2026 03:14:46 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S13;
 Wed, 16 Sep 2026 15:08:03 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 11/19] target/riscv: Add packed SIMD multiply-accumulate
 instructions
Date: Wed, 16 Sep 2026 07:07:13 +0000
Message-Id: <20260916070721.3279229-12-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S13
X-Coremail-Antispam: 1UD129KBjvAXoWfAw13WF1rZFyrKF17uw4rZrb_yoW8urWrCo
 Z7Cr1rArW8C3y8urya9w1UXrs2qFW09a1DJay5Zr47XF93Wry2qrW5J348A3Z7CrWayry7
 XrZ3C34rtF9ak34Dn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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

Implement packed multiply-high accumulate, cross-element
multiply-accumulate, and mixed-width multiply-high accumulate
operations.  Cover signed, unsigned, mixed-sign, rounded, and
source-element selection variants.Add the associated decode
entries, translators and helpers.

Note that same-width multiply-high accumulate operations add the upper
half of each product to the corresponding destination element, while
their rounding variants round the product before extracting it.
Mixed-width variants discard the low bits corresponding to the narrower
source element before accumulation.  Cross-element variants select
source subelements and accumulate their full products into wider
destination elements.  Accumulation wraps to the destination element
width, and these operations do not affect vxsat.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       |  56 ++++++
 target/riscv/insn32.decode                  |  92 +++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  56 ++++++
 target/riscv/tcg/psimd_helper.c             | 195 ++++++++++++++++++++
 4 files changed, 399 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c6e69163262..e90e01373ed 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1621,3 +1621,59 @@ DEF_HELPER_3(mulsu_w11, i64, env, i64, i64)
 DEF_HELPER_3(mulu_w00, i64, env, i64, i64)
 DEF_HELPER_3(mulu_w01, i64, env, i64, i64)
 DEF_HELPER_3(mulu_w11, i64, env, i64, i64)
+
+/* Packed SIMD - Multiply-Accumulate Operations */
+DEF_HELPER_4(pmhacc_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhaccsu_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhaccu_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhracc_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhraccsu_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhraccu_h, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhacc_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhracc_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhaccsu_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhraccsu_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhaccu_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhraccu_w, i64, env, i64, i64, i64)
+DEF_HELPER_4(mhacc, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhracc, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhaccsu, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhraccsu, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhaccu, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhraccu, i32, env, i32, i32, i32)
+DEF_HELPER_4(pmhacc_h_b0, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhacc_h_b1, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhaccsu_h_b0, tl, env, tl, tl, tl)
+DEF_HELPER_4(pmhaccsu_h_b1, tl, env, tl, tl, tl)
+DEF_HELPER_4(mhacc_h0, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhacc_h1, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhaccsu_h0, i32, env, i32, i32, i32)
+DEF_HELPER_4(mhaccsu_h1, i32, env, i32, i32, i32)
+DEF_HELPER_4(pmhacc_w_h0, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhacc_w_h1, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhaccsu_w_h0, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmhaccsu_w_h1, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmacc_w_h00, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmacc_w_h01, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmacc_w_h11, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmaccsu_w_h00, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmaccsu_w_h11, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmaccu_w_h00, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmaccu_w_h01, i64, env, i64, i64, i64)
+DEF_HELPER_4(pmaccu_w_h11, i64, env, i64, i64, i64)
+DEF_HELPER_4(macc_h00, i32, env, i32, i32, i32)
+DEF_HELPER_4(macc_h01, i32, env, i32, i32, i32)
+DEF_HELPER_4(macc_h11, i32, env, i32, i32, i32)
+DEF_HELPER_4(maccsu_h00, i32, env, i32, i32, i32)
+DEF_HELPER_4(maccsu_h11, i32, env, i32, i32, i32)
+DEF_HELPER_4(maccu_h00, i32, env, i32, i32, i32)
+DEF_HELPER_4(maccu_h01, i32, env, i32, i32, i32)
+DEF_HELPER_4(maccu_h11, i32, env, i32, i32, i32)
+DEF_HELPER_4(macc_w00, i64, env, i64, i64, i64)
+DEF_HELPER_4(macc_w01, i64, env, i64, i64, i64)
+DEF_HELPER_4(macc_w11, i64, env, i64, i64, i64)
+DEF_HELPER_4(maccsu_w00, i64, env, i64, i64, i64)
+DEF_HELPER_4(maccsu_w11, i64, env, i64, i64, i64)
+DEF_HELPER_4(maccu_w00, i64, env, i64, i64, i64)
+DEF_HELPER_4(maccu_w01, i64, env, i64, i64, i64)
+DEF_HELPER_4(maccu_w11, i64, env, i64, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 94736a24038..2bf26ec1563 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1431,3 +1431,95 @@ mulsu_w11       11110 11 ..... ..... 011 ..... 0111011 @r
 mulu_w00        10100 11 ..... ..... 011 ..... 0111011 @r
 mulu_w01        10110 11 ..... ..... 001 ..... 0111011 @r
 mulu_w11        10110 11 ..... ..... 011 ..... 0111011 @r
+
+# Packed SIMD - Multiply-Accumulate Operations
+pmhacc_h    10001 00 ..... ..... 111 ..... 0111011 @r
+pmhaccsu_h  11001 00 ..... ..... 111 ..... 0111011 @r
+pmhaccu_h   10011 00 ..... ..... 111 ..... 0111011 @r
+pmhracc_h   10001 10 ..... ..... 111 ..... 0111011 @r
+pmhraccsu_h 11001 10 ..... ..... 111 ..... 0111011 @r
+pmhraccu_h  10011 10 ..... ..... 111 ..... 0111011 @r
+{
+  mhacc     10001 01 ..... ..... 111 ..... 0111011 @r
+  pmhacc_w  10001 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhracc    10001 11 ..... ..... 111 ..... 0111011 @r
+  pmhracc_w 10001 11 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhaccsu   11001 01 ..... ..... 111 ..... 0111011 @r
+  pmhaccsu_w    11001 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhraccsu  11001 11 ..... ..... 111 ..... 0111011 @r
+  pmhraccsu_w   11001 11 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhaccu    10011 01 ..... ..... 111 ..... 0111011 @r
+  pmhaccu_w 10011 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhraccu   10011 11 ..... ..... 111 ..... 0111011 @r
+  pmhraccu_w    10011 11 ..... ..... 111 ..... 0111011 @r
+}
+pmhacc_h_b0     10101 00 ..... ..... 111 ..... 0111011 @r
+pmhacc_h_b1     10111 00 ..... ..... 111 ..... 0111011 @r
+pmhaccsu_h_b0   10101 10 ..... ..... 111 ..... 0111011 @r
+pmhaccsu_h_b1   10111 10 ..... ..... 111 ..... 0111011 @r
+{
+  mhacc_h0      10101 01 ..... ..... 111 ..... 0111011 @r
+  pmhacc_w_h0   10101 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhacc_h1      10111 01 ..... ..... 111 ..... 0111011 @r
+  pmhacc_w_h1   10111 01 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhaccsu_h0    10101 11 ..... ..... 111 ..... 0111011 @r
+  pmhaccsu_w_h0 10101 11 ..... ..... 111 ..... 0111011 @r
+}
+{
+  mhaccsu_h1    10111 11 ..... ..... 111 ..... 0111011 @r
+  pmhaccsu_w_h1 10111 11 ..... ..... 111 ..... 0111011 @r
+}
+{
+  macc_h00      10001 01 ..... ..... 011 ..... 0111011 @r
+  pmacc_w_h00   10001 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  macc_h01      10011 01 ..... ..... 001 ..... 0111011 @r
+  pmacc_w_h01   10011 01 ..... ..... 001 ..... 0111011 @r
+}
+{
+  macc_h11      10011 01 ..... ..... 011 ..... 0111011 @r
+  pmacc_w_h11   10011 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  maccsu_h00    11101 01 ..... ..... 011 ..... 0111011 @r
+  pmaccsu_w_h00 11101 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  maccsu_h11    11111 01 ..... ..... 011 ..... 0111011 @r
+  pmaccsu_w_h11 11111 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  maccu_h00     10101 01 ..... ..... 011 ..... 0111011 @r
+  pmaccu_w_h00  10101 01 ..... ..... 011 ..... 0111011 @r
+}
+{
+  maccu_h01     10111 01 ..... ..... 001 ..... 0111011 @r
+  pmaccu_w_h01  10111 01 ..... ..... 001 ..... 0111011 @r
+}
+{
+  maccu_h11     10111 01 ..... ..... 011 ..... 0111011 @r
+  pmaccu_w_h11  10111 01 ..... ..... 011 ..... 0111011 @r
+}
+macc_w00        10001 11 ..... ..... 011 ..... 0111011 @r
+macc_w01        10011 11 ..... ..... 001 ..... 0111011 @r
+macc_w11        10011 11 ..... ..... 011 ..... 0111011 @r
+maccsu_w00      11101 11 ..... ..... 011 ..... 0111011 @r
+maccsu_w11      11111 11 ..... ..... 011 ..... 0111011 @r
+maccu_w00       10101 11 ..... ..... 011 ..... 0111011 @r
+maccu_w01       10111 11 ..... ..... 001 ..... 0111011 @r
+maccu_w11       10111 11 ..... ..... 011 ..... 0111011 @r
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 39bec55bd25..5aaa3c6ffa5 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -790,3 +790,59 @@ GEN_SIMD_TRANS_64(mulsu_w11)
 GEN_SIMD_TRANS_64(mulu_w00)
 GEN_SIMD_TRANS_64(mulu_w01)
 GEN_SIMD_TRANS_64(mulu_w11)
+
+/* Packed SIMD - Multiply-Accumulate Operations */
+GEN_SIMD_TRANS_ACC(pmhacc_h)
+GEN_SIMD_TRANS_ACC(pmhaccsu_h)
+GEN_SIMD_TRANS_ACC(pmhaccu_h)
+GEN_SIMD_TRANS_ACC(pmhracc_h)
+GEN_SIMD_TRANS_ACC(pmhraccsu_h)
+GEN_SIMD_TRANS_ACC(pmhraccu_h)
+GEN_SIMD_TRANS_ACC_64(pmhacc_w)
+GEN_SIMD_TRANS_ACC_64(pmhracc_w)
+GEN_SIMD_TRANS_ACC_64(pmhaccsu_w)
+GEN_SIMD_TRANS_ACC_64(pmhraccsu_w)
+GEN_SIMD_TRANS_ACC_64(pmhaccu_w)
+GEN_SIMD_TRANS_ACC_64(pmhraccu_w)
+GEN_SIMD_TRANS_ACC_32(mhacc)
+GEN_SIMD_TRANS_ACC_32(mhracc)
+GEN_SIMD_TRANS_ACC_32(mhaccsu)
+GEN_SIMD_TRANS_ACC_32(mhraccsu)
+GEN_SIMD_TRANS_ACC_32(mhaccu)
+GEN_SIMD_TRANS_ACC_32(mhraccu)
+GEN_SIMD_TRANS_ACC(pmhacc_h_b0)
+GEN_SIMD_TRANS_ACC(pmhacc_h_b1)
+GEN_SIMD_TRANS_ACC(pmhaccsu_h_b0)
+GEN_SIMD_TRANS_ACC(pmhaccsu_h_b1)
+GEN_SIMD_TRANS_ACC_32(mhacc_h0)
+GEN_SIMD_TRANS_ACC_32(mhacc_h1)
+GEN_SIMD_TRANS_ACC_32(mhaccsu_h0)
+GEN_SIMD_TRANS_ACC_32(mhaccsu_h1)
+GEN_SIMD_TRANS_ACC_64(pmhacc_w_h0)
+GEN_SIMD_TRANS_ACC_64(pmhacc_w_h1)
+GEN_SIMD_TRANS_ACC_64(pmhaccsu_w_h0)
+GEN_SIMD_TRANS_ACC_64(pmhaccsu_w_h1)
+GEN_SIMD_TRANS_ACC_64(pmacc_w_h00)
+GEN_SIMD_TRANS_ACC_64(pmacc_w_h01)
+GEN_SIMD_TRANS_ACC_64(pmacc_w_h11)
+GEN_SIMD_TRANS_ACC_64(pmaccsu_w_h00)
+GEN_SIMD_TRANS_ACC_64(pmaccsu_w_h11)
+GEN_SIMD_TRANS_ACC_64(pmaccu_w_h00)
+GEN_SIMD_TRANS_ACC_64(pmaccu_w_h01)
+GEN_SIMD_TRANS_ACC_64(pmaccu_w_h11)
+GEN_SIMD_TRANS_ACC_32(macc_h00)
+GEN_SIMD_TRANS_ACC_32(macc_h01)
+GEN_SIMD_TRANS_ACC_32(macc_h11)
+GEN_SIMD_TRANS_ACC_32(maccsu_h00)
+GEN_SIMD_TRANS_ACC_32(maccsu_h11)
+GEN_SIMD_TRANS_ACC_32(maccu_h00)
+GEN_SIMD_TRANS_ACC_32(maccu_h01)
+GEN_SIMD_TRANS_ACC_32(maccu_h11)
+GEN_SIMD_TRANS_ACC_64(macc_w00)
+GEN_SIMD_TRANS_ACC_64(macc_w01)
+GEN_SIMD_TRANS_ACC_64(macc_w11)
+GEN_SIMD_TRANS_ACC_64(maccsu_w00)
+GEN_SIMD_TRANS_ACC_64(maccsu_w11)
+GEN_SIMD_TRANS_ACC_64(maccu_w00)
+GEN_SIMD_TRANS_ACC_64(maccu_w01)
+GEN_SIMD_TRANS_ACC_64(maccu_w11)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index f84b43bfaa7..b9bb7d497fc 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2810,3 +2810,198 @@ GEN_PSIMD_MUL_ELEM_SCALAR(mulu_w01, uint64_t, uint32_t, uint32_t,
                           uint64_t, EXTRACT32, 0, 1, PSIMD_MUL_U64)
 GEN_PSIMD_MUL_ELEM_SCALAR(mulu_w11, uint64_t, uint32_t, uint32_t,
                           uint64_t, EXTRACT32, 1, 1, PSIMD_MUL_U64)
+
+/* Multiply-Accumulate Operations */
+
+GEN_PSIMD_MUL_HIGH_ACC(pmhacc_h, target_ulong, int16_t, int16_t, int16_t,
+                       int32_t, int16_t, uint16_t, EXTRACT16, INSERT16,
+                       ELEMS_H, 16, 0, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH_ACC(pmhaccsu_h, target_ulong, int16_t, uint16_t, int16_t,
+                       int32_t, int16_t, uint16_t, EXTRACT16, INSERT16,
+                       ELEMS_H, 16, 0, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_HIGH_ACC(pmhaccu_h, target_ulong, uint16_t, uint16_t, uint16_t,
+                       uint32_t, uint16_t, uint16_t, EXTRACT16, INSERT16,
+                       ELEMS_H, 16, 0, PSIMD_MUL_U32)
+GEN_PSIMD_MUL_HIGH_ACC(pmhracc_h, target_ulong, int16_t, int16_t, int16_t,
+                       int32_t, int16_t, uint16_t, EXTRACT16, INSERT16,
+                       ELEMS_H, 16, 1 << 15, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH_ACC(pmhraccsu_h, target_ulong, int16_t, uint16_t, int16_t,
+                       int32_t, int16_t, uint16_t, EXTRACT16, INSERT16,
+                       ELEMS_H, 16, 1 << 15, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_HIGH_ACC(pmhraccu_h, target_ulong, uint16_t, uint16_t,
+                       uint16_t, uint32_t, uint16_t, uint16_t,
+                       EXTRACT16, INSERT16, ELEMS_H, 16, 1 << 15,
+                       PSIMD_MUL_U32)
+
+GEN_PSIMD_MUL_HIGH_ACC(pmhacc_w, uint64_t, int32_t, int32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 0, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC(pmhracc_w, uint64_t, int32_t, int32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 1LL << 31, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC(pmhaccsu_w, uint64_t, int32_t, uint32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 0, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_ACC(pmhraccsu_w, uint64_t, int32_t, uint32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 1LL << 31, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_ACC(pmhaccu_w, uint64_t, uint32_t, uint32_t, uint32_t,
+                       uint64_t, uint32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 0, PSIMD_MUL_U64)
+GEN_PSIMD_MUL_HIGH_ACC(pmhraccu_w, uint64_t, uint32_t, uint32_t, uint32_t,
+                       uint64_t, uint32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 1LL << 31, PSIMD_MUL_U64)
+
+GEN_PSIMD_MUL_HIGH_ACC(mhacc, uint32_t, int32_t, int32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 0, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC(mhracc, uint32_t, int32_t, int32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 1LL << 31, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC(mhaccsu, uint32_t, int32_t, uint32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 0, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_ACC(mhraccsu, uint32_t, int32_t, uint32_t, int32_t,
+                       int64_t, int32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 1LL << 31, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_ACC(mhaccu, uint32_t, uint32_t, uint32_t, uint32_t,
+                       uint64_t, uint32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 0, PSIMD_MUL_U64)
+GEN_PSIMD_MUL_HIGH_ACC(mhraccu, uint32_t, uint32_t, uint32_t, uint32_t,
+                       uint64_t, uint32_t, uint32_t, EXTRACT32, INSERT32,
+                       ELEMS_W, 32, 1LL << 31, PSIMD_MUL_U64)
+
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhacc_h_b0, target_ulong, int16_t, int8_t,
+                           int16_t, int32_t, int16_t, uint16_t, EXTRACT16,
+                           EXTRACT8, INSERT16, ELEMS_H, 2, 0, 8,
+                           PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhacc_h_b1, target_ulong, int16_t, int8_t,
+                           int16_t, int32_t, int16_t, uint16_t, EXTRACT16,
+                           EXTRACT8, INSERT16, ELEMS_H, 2, 1, 8,
+                           PSIMD_MUL_S32)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhaccsu_h_b0, target_ulong, int16_t, uint8_t,
+                           int16_t, int32_t, int16_t, uint16_t, EXTRACT16,
+                           EXTRACT8, INSERT16, ELEMS_H, 2, 0, 8,
+                           PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhaccsu_h_b1, target_ulong, int16_t, uint8_t,
+                           int16_t, int32_t, int16_t, uint16_t, EXTRACT16,
+                           EXTRACT8, INSERT16, ELEMS_H, 2, 1, 8,
+                           PSIMD_MUL_SU32)
+
+GEN_PSIMD_MUL_HIGH_ACC_SEL(mhacc_h0, uint32_t, int32_t, int16_t, int32_t,
+                           int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 0, 0, 16,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(mhacc_h1, uint32_t, int32_t, int16_t, int32_t,
+                           int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 0, 1, 16,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(mhaccsu_h0, uint32_t, int32_t, uint16_t, int32_t,
+                           int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 0, 0, 16,
+                           PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(mhaccsu_h1, uint32_t, int32_t, uint16_t, int32_t,
+                           int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 0, 1, 16,
+                           PSIMD_MUL_SU64)
+
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhacc_w_h0, uint64_t, int32_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 2, 0, 16,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhacc_w_h1, uint64_t, int32_t, int16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 2, 1, 16,
+                           PSIMD_MUL_S64)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhaccsu_w_h0, uint64_t, int32_t, uint16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 2, 0, 16,
+                           PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_HIGH_ACC_SEL(pmhaccsu_w_h1, uint64_t, int32_t, uint16_t,
+                           int32_t, int64_t, int32_t, uint32_t, EXTRACT32,
+                           EXTRACT16, INSERT32, ELEMS_W, 2, 1, 16,
+                           PSIMD_MUL_SU64)
+
+GEN_PSIMD_MUL_ACC_INDEXED(pmacc_w_h00, uint64_t, int16_t, int16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 2, 0, 0, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ACC_INDEXED(pmacc_w_h01, uint64_t, int16_t, int16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 2, 0, 1, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ACC_INDEXED(pmacc_w_h11, uint64_t, int16_t, int16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 2, 1, 1, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ACC_INDEXED(pmaccsu_w_h00, uint64_t, int16_t, uint16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 2, 0, 0, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_ACC_INDEXED(pmaccsu_w_h11, uint64_t, int16_t, uint16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 2, 1, 1, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_ACC_INDEXED(pmaccu_w_h00, uint64_t, uint16_t, uint16_t,
+                          uint32_t, uint32_t, uint32_t, EXTRACT16,
+                          EXTRACT32, INSERT32, ELEMS_W, 2, 0, 0,
+                          PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ACC_INDEXED(pmaccu_w_h01, uint64_t, uint16_t, uint16_t,
+                          uint32_t, uint32_t, uint32_t, EXTRACT16,
+                          EXTRACT32, INSERT32, ELEMS_W, 2, 0, 1,
+                          PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ACC_INDEXED(pmaccu_w_h11, uint64_t, uint16_t, uint16_t,
+                          uint32_t, uint32_t, uint32_t, EXTRACT16,
+                          EXTRACT32, INSERT32, ELEMS_W, 2, 1, 1,
+                          PSIMD_MUL_U32)
+
+GEN_PSIMD_MUL_ACC_INDEXED(macc_h00, uint32_t, int16_t, int16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 0, 0, 0, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ACC_INDEXED(macc_h01, uint32_t, int16_t, int16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 0, 0, 1, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ACC_INDEXED(macc_h11, uint32_t, int16_t, int16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 0, 1, 1, PSIMD_MUL_S32)
+GEN_PSIMD_MUL_ACC_INDEXED(maccsu_h00, uint32_t, int16_t, uint16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 0, 0, 0, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_ACC_INDEXED(maccsu_h11, uint32_t, int16_t, uint16_t,
+                          int32_t, int32_t, uint32_t, EXTRACT16, EXTRACT32,
+                          INSERT32, ELEMS_W, 0, 1, 1, PSIMD_MUL_SU32)
+GEN_PSIMD_MUL_ACC_INDEXED(maccu_h00, uint32_t, uint16_t, uint16_t,
+                          uint32_t, uint32_t, uint32_t, EXTRACT16,
+                          EXTRACT32, INSERT32, ELEMS_W, 0, 0, 0,
+                          PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ACC_INDEXED(maccu_h01, uint32_t, uint16_t, uint16_t,
+                          uint32_t, uint32_t, uint32_t, EXTRACT16,
+                          EXTRACT32, INSERT32, ELEMS_W, 0, 0, 1,
+                          PSIMD_MUL_U32)
+GEN_PSIMD_MUL_ACC_INDEXED(maccu_h11, uint32_t, uint16_t, uint16_t,
+                          uint32_t, uint32_t, uint32_t, EXTRACT16,
+                          EXTRACT32, INSERT32, ELEMS_W, 0, 1, 1,
+                          PSIMD_MUL_U32)
+
+GEN_PSIMD_MUL_ACC_INDEXED(macc_w00, uint64_t, int32_t, int32_t,
+                          int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                          INSERT64, ELEMS_D, 0, 0, 0, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_ACC_INDEXED(macc_w01, uint64_t, int32_t, int32_t,
+                          int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                          INSERT64, ELEMS_D, 0, 0, 1, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_ACC_INDEXED(macc_w11, uint64_t, int32_t, int32_t,
+                          int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                          INSERT64, ELEMS_D, 0, 1, 1, PSIMD_MUL_S64)
+GEN_PSIMD_MUL_ACC_INDEXED(maccsu_w00, uint64_t, int32_t, uint32_t,
+                          int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                          INSERT64, ELEMS_D, 0, 0, 0, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_ACC_INDEXED(maccsu_w11, uint64_t, int32_t, uint32_t,
+                          int64_t, int64_t, uint64_t, EXTRACT32, EXTRACT64,
+                          INSERT64, ELEMS_D, 0, 1, 1, PSIMD_MUL_SU64)
+GEN_PSIMD_MUL_ACC_INDEXED(maccu_w00, uint64_t, uint32_t, uint32_t,
+                          uint64_t, uint64_t, uint64_t, EXTRACT32,
+                          EXTRACT64, INSERT64, ELEMS_D, 0, 0, 0,
+                          PSIMD_MUL_U64)
+GEN_PSIMD_MUL_ACC_INDEXED(maccu_w01, uint64_t, uint32_t, uint32_t,
+                          uint64_t, uint64_t, uint64_t, EXTRACT32,
+                          EXTRACT64, INSERT64, ELEMS_D, 0, 0, 1,
+                          PSIMD_MUL_U64)
+GEN_PSIMD_MUL_ACC_INDEXED(maccu_w11, uint64_t, uint32_t, uint32_t,
+                          uint64_t, uint64_t, uint64_t, EXTRACT32,
+                          EXTRACT64, INSERT64, ELEMS_D, 0, 1, 1,
+                          PSIMD_MUL_U64)
-- 
2.34.1


