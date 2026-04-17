Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1213DF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjX-0001GI-GR; Fri, 17 Apr 2026 06:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjN-00015R-RB; Fri, 17 Apr 2026 06:47:27 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjI-0007zM-NP; Fri, 17 Apr 2026 06:47:25 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S10;
 Fri, 17 Apr 2026 18:47:16 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/14] target/riscv: rvp: add pure multiplication operations
Date: Fri, 17 Apr 2026 18:46:45 +0800
Message-Id: <20260417104652.17857-9-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S10
X-Coremail-Antispam: 1UD129KBjvAXoWfXr1kAr1UGr45JF4xtF1rtFb_yoWrXF4xKo
 W3Gw1Yy3s3Gw1xuw4rCa1UXw17ZrWIvw1DJw4Fvr45Xas7Gr17KF15J34kAayxGrWSyrW8
 WFZavF1fJF9Ik3srn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOj7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
 WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
 3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw
 0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqLvNU
 UUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.998,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                   |   62 ++
 target/riscv/insn32.decode              |   92 ++
 target/riscv/insn_trans/trans_rvp.c.inc |   62 ++
 target/riscv/psimd_helper.c             | 1066 +++++++++++++++++++++++
 4 files changed, 1282 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 78ae034331..4b3f01f8d0 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1543,3 +1543,65 @@ DEF_HELPER_4(merge, tl, env, tl, tl, tl)
 DEF_HELPER_2(cls, tl, env, tl)
 DEF_HELPER_2(clsw, i64, env, i64)
 
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
+DEF_HELPER_3(pm2sadd_h, tl, env, tl, tl)
+DEF_HELPER_3(pm2sadd_hx, tl, env, tl, tl)
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
index 09bb69b302..bd3b14af5b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1321,3 +1321,95 @@ merge       1010110 ..... ..... 001 ..... 0111011 @r
 cls    01100 0000011 ..... 001 ..... 0010011 @r2
 clsw   01100 0000011 ..... 001 ..... 0011011 @r2
 
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
+pm2sadd_h       11000 10 ..... ..... 101 ..... 0111011 @r
+pm2sadd_hx      11010 10 ..... ..... 101 ..... 0111011 @r
+mul_w00         10000 11 ..... ..... 011 ..... 0111011 @r
+mul_w01         10010 11 ..... ..... 001 ..... 0111011 @r
+mul_w11         10010 11 ..... ..... 011 ..... 0111011 @r
+mulsu_w00       11100 11 ..... ..... 011 ..... 0111011 @r
+mulsu_w11       11110 11 ..... ..... 011 ..... 0111011 @r
+mulu_w00        10100 11 ..... ..... 011 ..... 0111011 @r
+mulu_w01        10110 11 ..... ..... 001 ..... 0111011 @r
+mulu_w11        10110 11 ..... ..... 011 ..... 0111011 @r
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index fc6254b395..b01656ffb0 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -712,3 +712,65 @@ GEN_SIMD_TRANS_ACC(merge)
 GEN_SIMD_TRANS_R1(cls)
 GEN_SIMD_TRANS_R1_64(clsw)
 
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
+GEN_SIMD_TRANS(pm2sadd_h)
+GEN_SIMD_TRANS(pm2sadd_hx)
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
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index 4080aab234..b60fd3094c 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -3616,3 +3616,1069 @@ uint64_t HELPER(clsw)(CPURISCVState *env, uint64_t rs1)
 
     return c;
 }
+
+/* Pure multiplication operations */
+
+/**
+ * PMULH.H - Packed signed 16-bit multiply high
+ * For each halfword: rd[i] = (rs1[i] * rs2[i]) >> 16
+ */
+target_ulong HELPER(pmulh_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int32_t prod = (int32_t)e1 * (int32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 16);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHSU.H - Packed signed x unsigned 16-bit multiply high
+ */
+target_ulong HELPER(pmulhsu_h)(CPURISCVState *env,
+                               target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 16);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHU.H - Packed unsigned 16-bit multiply high
+ */
+target_ulong HELPER(pmulhu_h)(CPURISCVState *env,
+                              target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint32_t prod = (uint32_t)e1 * (uint32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 16);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHR.H - Packed signed 16-bit multiply high with rounding
+ */
+target_ulong HELPER(pmulhr_h)(CPURISCVState *env,
+                              target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int32_t prod = (int32_t)e1 * (int32_t)e2 + (1 << 15);
+        uint16_t high = (uint16_t)(prod >> 16);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHRSU.H - Packed signed x unsigned 16-bit multiply high with rounding
+ */
+target_ulong HELPER(pmulhrsu_h)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2 + (1 << 15);
+        uint16_t high = (uint16_t)(prod >> 16);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHRU.H - Packed unsigned 16-bit multiply high with rounding
+ */
+target_ulong HELPER(pmulhru_h)(CPURISCVState *env,
+                               target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint32_t prod = (uint32_t)e1 * (uint32_t)e2 + (1 << 15);
+        uint16_t high = (uint16_t)(prod >> 16);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULH.W - Packed signed 32-bit multiply high (RV64 only)
+ */
+uint64_t HELPER(pmulh_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int64_t prod = (int64_t)e1 * (int64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 32);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHR.W - Packed signed 32-bit multiply high with rounding (RV64 only)
+ */
+uint64_t HELPER(pmulhr_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int64_t prod = (int64_t)e1 * (int64_t)e2 + (1LL << 31);
+        uint32_t high = (uint32_t)(prod >> 32);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHSU.W - Packed signed x unsigned 32-bit multiply high (RV64 only)
+ */
+uint64_t HELPER(pmulhsu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 32);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHRSU.W - Packed signed x unsigned 32-bit
+ * multiply high with rounding (RV64 only)
+ */
+uint64_t HELPER(pmulhrsu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2 + (1LL << 31);
+        uint32_t high = (uint32_t)(prod >> 32);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHU.W - Packed unsigned 32-bit multiply high (RV64 only)
+ */
+uint64_t HELPER(pmulhu_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint64_t prod = (uint64_t)e1 * (uint64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 32);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHRU.W - Packed unsigned 32-bit multiply high with rounding (RV64 only)
+ */
+uint64_t HELPER(pmulhru_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint64_t prod = (uint64_t)e1 * (uint64_t)e2 + (1LL << 31);
+        uint32_t high = (uint32_t)(prod >> 32);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * MULHR - 32-bit signed multiply high with rounding
+ */
+uint32_t HELPER(mulhr)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int32_t b = (int32_t)rs2;
+    int64_t prod = (int64_t)a * (int64_t)b + (1LL << 31);
+    return (uint32_t)(prod >> 32);
+}
+
+/**
+ * MULHRSU - 32-bit signed x unsigned multiply high with rounding
+ */
+uint32_t HELPER(mulhrsu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    uint32_t b = rs2;
+    int64_t prod = (int64_t)a * (uint64_t)b + (1LL << 31);
+    return (uint32_t)(prod >> 32);
+}
+
+/**
+ * MULHRU - 32-bit unsigned multiply high with rounding
+ */
+uint32_t HELPER(mulhru)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint32_t a = rs1;
+    uint32_t b = rs2;
+    uint64_t prod = (uint64_t)a * (uint64_t)b + (1LL << 31);
+    return (uint32_t)(prod >> 32);
+}
+
+/**
+ * PMULH.H.B0 - Multiply halfword by low byte, result high halfword
+ */
+target_ulong HELPER(pmulh_h_b0)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i * 2);
+        int32_t prod = (int32_t)e1 * (int32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 8);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULH.H.B1 - Multiply halfword by high byte, result high halfword
+ */
+target_ulong HELPER(pmulh_h_b1)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i * 2 + 1);
+        int32_t prod = (int32_t)e1 * (int32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 8);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHSU.H.B0 - Multiply signed halfword by unsigned
+ * low byte, result high halfword
+ */
+target_ulong HELPER(pmulhsu_h_b0)(CPURISCVState *env,
+                                  target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i * 2);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 8);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHSU.H.B1 - Multiply signed halfword by unsigned
+ * high byte, result high halfword
+ */
+target_ulong HELPER(pmulhsu_h_b1)(CPURISCVState *env,
+                                  target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i * 2 + 1);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 8);
+        rd = INSERT16(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * MULH.H0 - 32-bit multiply by low halfword, result high 16 bits
+ */
+uint32_t HELPER(mulh_h0)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int16_t b = (int16_t)(rs2 & 0xFFFF);
+    int64_t prod = (int64_t)a * (int64_t)b;
+    return (uint32_t)(prod >> 16);
+}
+
+/**
+ * MULH.H1 - 32-bit multiply by high halfword, result high 16 bits
+ */
+uint32_t HELPER(mulh_h1)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int16_t b = (int16_t)((rs2 >> 16) & 0xFFFF);
+    int64_t prod = (int64_t)a * (int64_t)b;
+    return (uint32_t)(prod >> 16);
+}
+
+/**
+ * MULHSU.H0 - 32-bit signed multiply by unsigned
+ * low halfword, result high 16 bits
+ */
+uint32_t HELPER(mulhsu_h0)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    uint16_t b = (uint16_t)(rs2 & 0xFFFF);
+    int64_t prod = (int64_t)a * (uint64_t)b;
+    return (uint32_t)(prod >> 16);
+}
+
+/**
+ * MULHSU.H1 - 32-bit signed multiply by unsigned
+ * high halfword, result high 16 bits
+ */
+uint32_t HELPER(mulhsu_h1)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    uint16_t b = (uint16_t)((rs2 >> 16) & 0xFFFF);
+    int64_t prod = (int64_t)a * (uint64_t)b;
+    return (uint32_t)(prod >> 16);
+}
+
+/**
+ * PMULH.W.H0 - Multiply word by low halfword, result high word (RV64 only)
+ */
+uint64_t HELPER(pmulh_w_h0)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i * 2);
+        int64_t prod = (int64_t)e1 * (int64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 16);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULH.W.H1 - Multiply word by high halfword, result high word (RV64 only)
+ */
+uint64_t HELPER(pmulh_w_h1)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int64_t prod = (int64_t)e1 * (int64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 16);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHSU.W.H0 - Multiply signed word by unsigned
+ * low halfword, result high word (RV64 only)
+ */
+uint64_t HELPER(pmulhsu_w_h0)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i * 2);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 16);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULHSU.W.H1 - Multiply signed word by unsigned
+ * high halfword, result high word (RV64 only)
+ */
+uint64_t HELPER(pmulhsu_w_h1)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i * 2 + 1);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 16);
+        rd = INSERT32(rd, high, i);
+    }
+    return rd;
+}
+
+/**
+ * PMUL.H.B00 - Multiply halfword by low byte of each halfword
+ * For each halfword: rd[i] = rs1[i][7:0] * rs2[i][7:0]
+ */
+target_ulong HELPER(pmul_h_b00)(CPURISCVState *env,
+                                target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        int8_t s1_b0 = (int8_t)(s1_h & 0xFF);
+        int8_t s2_b0 = (int8_t)(s2_h & 0xFF);
+        int16_t mul = (int16_t)s1_b0 * (int16_t)s2_b0;
+        rd = INSERT16(rd, (uint16_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMUL.H.B01 - Multiply halfword low byte by halfword high byte
+ * For each halfword: rd[i] = rs1[i][7:0] * rs2[i][15:8]
+ */
+target_ulong HELPER(pmul_h_b01)(CPURISCVState *env,
+                                target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        int8_t s1_b0 = (int8_t)(s1_h & 0xFF);
+        int8_t s2_b1 = (int8_t)((s2_h >> 8) & 0xFF);
+        int16_t mul = (int16_t)s1_b0 * (int16_t)s2_b1;
+        rd = INSERT16(rd, (uint16_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMUL.H.B11 - Multiply halfword high byte by halfword high byte
+ * For each halfword: rd[i] = rs1[i][15:8] * rs2[i][15:8]
+ */
+target_ulong HELPER(pmul_h_b11)(CPURISCVState *env,
+                                target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        int8_t s1_b1 = (int8_t)((s1_h >> 8) & 0xFF);
+        int8_t s2_b1 = (int8_t)((s2_h >> 8) & 0xFF);
+        int16_t mul = (int16_t)s1_b1 * (int16_t)s2_b1;
+        rd = INSERT16(rd, (uint16_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULSU.H.B00 - Signed x unsigned multiply, low bytes
+ * For each halfword: rd[i] = (signed)rs1[i][7:0] * (unsigned)rs2[i][7:0]
+ */
+target_ulong HELPER(pmulsu_h_b00)(CPURISCVState *env,
+                                  target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        int8_t s1_b0 = (int8_t)(s1_h & 0xFF);
+        uint8_t s2_b0 = (uint8_t)(s2_h & 0xFF);
+        int16_t mul = (int16_t)s1_b0 * (uint16_t)s2_b0;
+        rd = INSERT16(rd, (uint16_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULSU.H.B11 - Signed x unsigned multiply, high bytes
+ * For each halfword: rd[i] = (signed)rs1[i][15:8] * (unsigned)rs2[i][15:8]
+ */
+target_ulong HELPER(pmulsu_h_b11)(CPURISCVState *env,
+                                  target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        int8_t s1_b1 = (int8_t)((s1_h >> 8) & 0xFF);
+        uint8_t s2_b1 = (uint8_t)((s2_h >> 8) & 0xFF);
+        int16_t mul = (int16_t)s1_b1 * (uint16_t)s2_b1;
+        rd = INSERT16(rd, (uint16_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULU.H.B00 - Unsigned multiply, low bytes
+ * For each halfword: rd[i] = rs1[i][7:0] * rs2[i][7:0] (unsigned)
+ */
+target_ulong HELPER(pmulu_h_b00)(CPURISCVState *env,
+                                 target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        uint8_t s1_b0 = (uint8_t)(s1_h & 0xFF);
+        uint8_t s2_b0 = (uint8_t)(s2_h & 0xFF);
+        uint16_t mul = (uint16_t)s1_b0 * (uint16_t)s2_b0;
+        rd = INSERT16(rd, mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULU.H.B01 - Unsigned multiply, rs1 low byte x rs2 high byte
+ * For each halfword: rd[i] = rs1[i][7:0] * rs2[i][15:8] (unsigned)
+ */
+target_ulong HELPER(pmulu_h_b01)(CPURISCVState *env,
+                                 target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        uint8_t s1_b0 = (uint8_t)(s1_h & 0xFF);
+        uint8_t s2_b1 = (uint8_t)((s2_h >> 8) & 0xFF);
+        uint16_t mul = (uint16_t)s1_b0 * (uint16_t)s2_b1;
+        rd = INSERT16(rd, mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULU.H.B11 - Unsigned multiply, high bytes
+ * For each halfword: rd[i] = rs1[i][15:8] * rs2[i][15:8] (unsigned)
+ */
+target_ulong HELPER(pmulu_h_b11)(CPURISCVState *env,
+                                 target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h = EXTRACT16(s1, i);
+        uint16_t s2_h = EXTRACT16(s2, i);
+        uint8_t s1_b1 = (uint8_t)((s1_h >> 8) & 0xFF);
+        uint8_t s2_b1 = (uint8_t)((s2_h >> 8) & 0xFF);
+        uint16_t mul = (uint16_t)s1_b1 * (uint16_t)s2_b1;
+        rd = INSERT16(rd, mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMUL.W.H00 - Multiply word by low halfword of each word
+ * For each word: rd[i] = rs1[i][15:0] * rs2[i][15:0]
+ */
+uint64_t HELPER(pmul_w_h00)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h0;
+        rd = INSERT32(rd, (uint32_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMUL.W.H01 - Multiply word by low halfword x high halfword
+ * For each word: rd[i] = rs1[i][15:0] * rs2[i][31:16]
+ */
+uint64_t HELPER(pmul_w_h01)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h1;
+        rd = INSERT32(rd, (uint32_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMUL.W.H11 - Multiply word by high halfword x high halfword
+ * For each word: rd[i] = rs1[i][31:16] * rs2[i][31:16]
+ */
+uint64_t HELPER(pmul_w_h11)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t mul = (int32_t)s1_h1 * (int32_t)s2_h1;
+        rd = INSERT32(rd, (uint32_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULSU.W.H00 - Signed x unsigned multiply, low halfwords
+ * For each word: rd[i] = (signed)rs1[i][15:0] * (unsigned)rs2[i][15:0]
+ */
+uint64_t HELPER(pmulsu_w_h00)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        int32_t mul = (int32_t)s1_h0 * (uint32_t)s2_h0;
+        rd = INSERT32(rd, (uint32_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULSU.W.H11 - Signed x unsigned multiply, high halfwords
+ * For each word: rd[i] = (signed)rs1[i][31:16] * (unsigned)rs2[i][31:16]
+ */
+uint64_t HELPER(pmulsu_w_h11)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        int32_t mul = (int32_t)s1_h1 * (uint32_t)s2_h1;
+        rd = INSERT32(rd, (uint32_t)mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULU.W.H00 - Unsigned multiply, low halfwords
+ * For each word: rd[i] = rs1[i][15:0] * rs2[i][15:0] (unsigned)
+ */
+uint64_t HELPER(pmulu_w_h00)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h0 = EXTRACT16(rs1, i * 2);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h0;
+        rd = INSERT32(rd, mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULU.W.H01 - Unsigned multiply, low halfword x high halfword
+ * For each word: rd[i] = rs1[i][15:0] * rs2[i][31:16] (unsigned)
+ */
+uint64_t HELPER(pmulu_w_h01)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h0 = EXTRACT16(rs1, i * 2);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h1;
+        rd = INSERT32(rd, mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMULU.W.H11 - Unsigned multiply, high halfwords
+ * For each word: rd[i] = rs1[i][31:16] * rs2[i][31:16] (unsigned)
+ */
+uint64_t HELPER(pmulu_w_h11)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h1 = EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        uint32_t mul = (uint32_t)s1_h1 * (uint32_t)s2_h1;
+        rd = INSERT32(rd, mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PM2SADD.H - Packed saturating multiply-add (non-crossed)
+ *
+ * For each 32-bit word:
+ *   result = sat32(rs1[31:16] * rs2[31:16] + rs1[15:0] * rs2[15:0])
+ *
+ * Special case: if both halfwords in both sources are 0x8000 (-32768),
+ *   result saturates to 0x7FFFFFFF and sets vxsat
+ */
+target_ulong HELPER(pm2sadd_h)(CPURISCVState *env,
+                                target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);  /* Number of 32-bit words */
+    int global_sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        /* Extract both halfwords from each source for this word */
+        uint32_t s1_word = EXTRACT32(s1, i);
+        uint32_t s2_word = EXTRACT32(s2, i);
+
+        int16_t s1_h0 = (int16_t)EXTRACT16(s1_word, 0);
+        int16_t s1_h1 = (int16_t)EXTRACT16(s1_word, 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(s2_word, 0);
+        int16_t s2_h1 = (int16_t)EXTRACT16(s2_word, 1);
+
+        uint32_t result;
+
+        /* Check for the special saturation case: all halfwords are -32768 */
+        if ((s1_h0 == -32768) && (s1_h1 == -32768) &&
+            (s2_h0 == -32768) && (s2_h1 == -32768)) {
+            result = 0x7FFFFFFF;
+            global_sat = 1;
+        } else {
+            /* Normal case: compute products and sum */
+            int32_t mul_00 = (int32_t)s1_h0 * (int32_t)s2_h0;
+            int32_t mul_11 = (int32_t)s1_h1 * (int32_t)s2_h1;
+
+            /* The sum may overflow 32 bits; the result is truncated. */
+            result = (uint32_t)(mul_00 + mul_11);
+        }
+
+        rd = INSERT32(rd, result, i);
+    }
+
+    if (global_sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PM2SADD.HX - Packed saturating multiply-add crossed
+ *
+ * For each 32-bit word:
+ *   result = sat32(rs1[31:16] * rs2[15:0] + rs1[15:0] * rs2[31:16])
+ *
+ * Special case: if both halfwords in both sources are 0x8000 (-32768),
+ *   result saturates to 0x7FFFFFFF and sets vxsat
+ */
+target_ulong HELPER(pm2sadd_hx)(CPURISCVState *env,
+                                 target_ulong s1, target_ulong s2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);  /* Number of 32-bit words */
+    int global_sat = 0;
+
+    for (int i = 0; i < elems; i++) {
+        /* Extract both halfwords from each source for this word */
+        uint32_t s1_word = EXTRACT32(s1, i);
+        uint32_t s2_word = EXTRACT32(s2, i);
+
+        int16_t s1_h0 = (int16_t)EXTRACT16(s1_word, 0);
+        int16_t s1_h1 = (int16_t)EXTRACT16(s1_word, 1);
+        int16_t s2_h0 = (int16_t)EXTRACT16(s2_word, 0);
+        int16_t s2_h1 = (int16_t)EXTRACT16(s2_word, 1);
+
+        uint32_t result;
+
+        /* Check for the special saturation case: all halfwords are -32768 */
+        if ((s1_h0 == -32768) && (s1_h1 == -32768) &&
+            (s2_h0 == -32768) && (s2_h1 == -32768)) {
+            result = 0x7FFFFFFF;
+            global_sat = 1;
+        } else {
+            /* Crossed products: s1_h0 * s2_h1 and s1_h1 * s2_h0 */
+            int32_t mul_01 = (int32_t)s1_h0 * (int32_t)s2_h1;
+            int32_t mul_10 = (int32_t)s1_h1 * (int32_t)s2_h0;
+
+            /* Sum the crossed products */
+            result = (uint32_t)(mul_01 + mul_10);
+        }
+
+        rd = INSERT32(rd, result, i);
+    }
+
+    if (global_sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * MUL.H00 - 32-bit signed multiply, low halfwords
+ * Returns product of low halfwords of rs1 and rs2
+ */
+uint32_t HELPER(mul_h00)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h0;
+    return (uint32_t)mul;
+}
+
+/**
+ * MUL.H01 - 32-bit signed multiply, rs1 low halfword x rs2 high halfword
+ * Returns product of low halfword of rs1 and high halfword of rs2
+ */
+uint32_t HELPER(mul_h01)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h1;
+    return (uint32_t)mul;
+}
+
+/**
+ * MUL.H11 - 32-bit signed multiply, high halfwords
+ * Returns product of high halfwords of rs1 and rs2
+ */
+uint32_t HELPER(mul_h11)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int32_t mul = (int32_t)s1_h1 * (int32_t)s2_h1;
+    return (uint32_t)mul;
+}
+
+/**
+ * MULSU.H00 - 32-bit signed x unsigned multiply, low halfwords
+ * Returns product of low halfword of rs1 (signed)
+ * and low halfword of rs2 (unsigned)
+ */
+uint32_t HELPER(mulsu_h00)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    int32_t mul = (int32_t)s1_h0 * (uint32_t)s2_h0;
+    return (uint32_t)mul;
+}
+
+/**
+ * MULSU.H11 - 32-bit signed x unsigned multiply, high halfwords
+ * Returns product of high halfword of rs1 (signed)
+ * and high halfword of rs2 (unsigned)
+ */
+uint32_t HELPER(mulsu_h11)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    int32_t mul = (int32_t)s1_h1 * (uint32_t)s2_h1;
+    return (uint32_t)mul;
+}
+
+/**
+ * MULU.H00 - 32-bit unsigned multiply, low halfwords
+ * Returns product of low halfwords of rs1 and rs2 (unsigned)
+ */
+uint32_t HELPER(mulu_h00)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint16_t s1_h0 = EXTRACT16(rs1, 0);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h0;
+    return mul;
+}
+
+/**
+ * MULU.H01 - 32-bit unsigned multiply, rs1 low halfword x rs2 high halfword
+ * Returns product of low halfword of rs1 and high halfword of rs2 (unsigned)
+ */
+uint32_t HELPER(mulu_h01)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint16_t s1_h0 = EXTRACT16(rs1, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h1;
+    return mul;
+}
+
+/**
+ * MULU.H11 - 32-bit unsigned multiply, high halfwords
+ * Returns product of high halfwords of rs1 and rs2 (unsigned)
+ */
+uint32_t HELPER(mulu_h11)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    uint16_t s1_h1 = EXTRACT16(rs1, 1);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint32_t mul = (uint32_t)s1_h1 * (uint32_t)s2_h1;
+    return mul;
+}
+
+/**
+ * MUL.W00 - 64-bit signed multiply, low word x low word
+ * Returns full 64-bit product of low 32 bits of rs1 and rs2
+ */
+uint64_t HELPER(mul_w00)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int64_t mul = (int64_t)s1_w0 * (int64_t)s2_w0;
+    return (uint64_t)mul;
+}
+
+/**
+ * MUL.W01 - 64-bit signed multiply, low word x high word
+ * Returns full 64-bit product of low 32 bits of rs1 and high 32 bits of rs2
+ */
+uint64_t HELPER(mul_w01)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t mul = (int64_t)s1_w0 * (int64_t)s2_w1;
+    return (uint64_t)mul;
+}
+
+/**
+ * MUL.W11 - 64-bit signed multiply, high word x high word
+ * Returns full 64-bit product of high 32 bits of rs1 and high 32 bits of rs2
+ */
+uint64_t HELPER(mul_w11)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t mul = (int64_t)s1_w1 * (int64_t)s2_w1;
+    return (uint64_t)mul;
+}
+
+/**
+ * MULSU.W00 - 64-bit signed x unsigned multiply, low word x low word
+ * Returns full 64-bit product of low 32 bits of rs1
+ * (signed) and low 32 bits of rs2 (unsigned)
+ */
+uint64_t HELPER(mulsu_w00)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    int64_t mul = (int64_t)s1_w0 * (uint64_t)s2_w0;
+    return (uint64_t)mul;
+}
+
+/**
+ * MULSU.W11 - 64-bit signed x unsigned multiply, high word x high word
+ * Returns full 64-bit product of high 32 bits of rs1
+ * (signed) and high 32 bits of rs2 (unsigned)
+ */
+uint64_t HELPER(mulsu_w11)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    int64_t mul = (int64_t)s1_w1 * (uint64_t)s2_w1;
+    return (uint64_t)mul;
+}
+
+/**
+ * MULU.W00 - 64-bit unsigned multiply, low word x low word
+ * Returns full 64-bit product of low 32 bits of rs1
+ * and low 32 bits of rs2 (unsigned)
+ */
+uint64_t HELPER(mulu_w00)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint32_t s1_w0 = EXTRACT32(rs1, 0);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    uint64_t mul = (uint64_t)s1_w0 * (uint64_t)s2_w0;
+    return mul;
+}
+
+/**
+ * MULU.W01 - 64-bit unsigned multiply, low word x high word
+ * Returns full 64-bit product of low 32 bits of rs1
+ * and high 32 bits of rs2 (unsigned)
+ */
+uint64_t HELPER(mulu_w01)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint32_t s1_w0 = EXTRACT32(rs1, 0);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    uint64_t mul = (uint64_t)s1_w0 * (uint64_t)s2_w1;
+    return mul;
+}
+
+/**
+ * MULU.W11 - 64-bit unsigned multiply, high word x high word
+ * Returns full 64-bit product of high 32 bits of rs1
+ * and high 32 bits of rs2 (unsigned)
+ */
+uint64_t HELPER(mulu_w11)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint32_t s1_w1 = EXTRACT32(rs1, 1);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    uint64_t mul = (uint64_t)s1_w1 * (uint64_t)s2_w1;
+    return mul;
+}
-- 
2.34.1


