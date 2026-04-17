Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC0EF4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjU-0001EB-Vr; Fri, 17 Apr 2026 06:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjP-00017F-38; Fri, 17 Apr 2026 06:47:27 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjK-0007zf-9k; Fri, 17 Apr 2026 06:47:26 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S11;
 Fri, 17 Apr 2026 18:47:17 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/14] target/riscv: rvp: add multiply-accumulate operations
Date: Fri, 17 Apr 2026 18:46:46 +0800
Message-Id: <20260417104652.17857-10-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S11
X-Coremail-Antispam: 1UD129KBjvAXoWfAw1fXr1xZF4xtF4DGr47CFg_yoWrJrWxto
 W3Gw1Yy395ur4xu3yF9w4UXr1jqrWIvw1DJw4Fvr43Xas7Gr9rKr15J34kAa4xCrWayrWr
 WrZayFyrtFy3C3sxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
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
 target/riscv/helper.h                   |  56 ++
 target/riscv/insn32.decode              |  92 +++
 target/riscv/insn_trans/trans_rvp.c.inc |  56 ++
 target/riscv/psimd_helper.c             | 946 ++++++++++++++++++++++++
 4 files changed, 1150 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4b3f01f8d0..54f8591672 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1605,3 +1605,59 @@ DEF_HELPER_3(mulsu_w11, i64, env, i64, i64)
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
index bd3b14af5b..9944d0b52c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1413,3 +1413,95 @@ mulsu_w11       11110 11 ..... ..... 011 ..... 0111011 @r
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
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index b01656ffb0..b3476c26ad 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -774,3 +774,59 @@ GEN_SIMD_TRANS_64(mulsu_w11)
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
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index b60fd3094c..7f32a13ba0 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -4682,3 +4682,949 @@ uint64_t HELPER(mulu_w11)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     uint64_t mul = (uint64_t)s1_w1 * (uint64_t)s2_w1;
     return mul;
 }
+
+/* Multiply-Accumulate Operations */
+
+/**
+ * PMHACC.H - Packed signed 16-bit multiply high with accumulate
+ */
+target_ulong HELPER(pmhacc_h)(CPURISCVState *env, target_ulong rs1,
+                              target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (int32_t)e2;
+        int16_t high = (int16_t)(prod >> 16);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCSU.H - Packed signed x unsigned 16-bit multiply high with accumulate
+ */
+target_ulong HELPER(pmhaccsu_h)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2;
+        int16_t high = (int16_t)(prod >> 16);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCU.H - Packed unsigned 16-bit multiply high with accumulate
+ */
+target_ulong HELPER(pmhaccu_h)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t d = (uint16_t)EXTRACT16(dest, i);
+        uint32_t prod = (uint32_t)e1 * (uint32_t)e2;
+        uint16_t high = (uint16_t)(prod >> 16);
+        uint16_t res = high + d;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHRACC.H - Packed signed 16-bit multiply high with rounding and accumulate
+ */
+target_ulong HELPER(pmhracc_h)(CPURISCVState *env, target_ulong rs1,
+                               target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (int32_t)e2 + (1 << 15);
+        int16_t high = (int16_t)(prod >> 16);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHRACCSU.H - Packed signed x unsigned 16-bit
+ * multiply high with rounding and accumulate
+ */
+target_ulong HELPER(pmhraccsu_h)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2 + (1 << 15);
+        int16_t high = (int16_t)(prod >> 16);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHRACCU.H - Packed unsigned 16-bit multiply
+ * high with rounding and accumulate
+ */
+target_ulong HELPER(pmhraccu_h)(CPURISCVState *env, target_ulong rs1,
+                                target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t d = (uint16_t)EXTRACT16(dest, i);
+        uint32_t prod = (uint32_t)e1 * (uint32_t)e2 + (1 << 15);
+        uint16_t high = (uint16_t)(prod >> 16);
+        uint16_t res = high + d;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACC.W - Packed signed 32-bit multiply high with accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhacc_w)(CPURISCVState *env, uint64_t rs1,
+                          uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (int64_t)e2;
+        int32_t high = (int32_t)(prod >> 32);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHRACC.W - Packed signed 32-bit multiply high
+ * with rounding and accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhracc_w)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (int64_t)e2 + (1LL << 31);
+        int32_t high = (int32_t)(prod >> 32);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCSU.W - Packed signed x unsigned 32-bit
+ * multiply high with accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhaccsu_w)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2;
+        int32_t high = (int32_t)(prod >> 32);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHRACCSU.W - Packed signed x unsigned 32-bit
+ * multiply high with rounding and accumulate
+ * (RV64 only)
+ */
+uint64_t HELPER(pmhraccsu_w)(CPURISCVState *env, uint64_t rs1,
+                             uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2 + (1LL << 31);
+        int32_t high = (int32_t)(prod >> 32);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCU.W - Packed unsigned 32-bit multiply high with accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhaccu_w)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t d = EXTRACT32(dest, i);
+        uint64_t prod = (uint64_t)e1 * (uint64_t)e2;
+        uint32_t high = (uint32_t)(prod >> 32);
+        uint32_t res = high + d;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHRACCU.W - Packed unsigned 32-bit multiply
+ * high with rounding and accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhraccu_w)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t d = EXTRACT32(dest, i);
+        uint64_t prod = (uint64_t)e1 * (uint64_t)e2 + (1LL << 31);
+        uint32_t high = (uint32_t)(prod >> 32);
+        uint32_t res = high + d;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * MHACC - 32-bit signed multiply high with accumulate
+ */
+uint32_t HELPER(mhacc)(CPURISCVState *env, uint32_t rs1,
+                        uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    int32_t b = (int32_t)rs2;
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (int64_t)b;
+    return (uint32_t)(d + (prod >> 32));
+}
+
+/**
+ * MHRACC - 32-bit signed multiply high with rounding and accumulate
+ */
+uint32_t HELPER(mhracc)(CPURISCVState *env, uint32_t rs1,
+                         uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    int32_t b = (int32_t)rs2;
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (int64_t)b + (1LL << 31);
+    return (uint32_t)(d + (prod >> 32));
+}
+
+/**
+ * MHACCSU - 32-bit signed x unsigned multiply high with accumulate
+ */
+uint32_t HELPER(mhaccsu)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    uint32_t b = rs2;
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (uint64_t)b;
+    return (uint32_t)(d + (prod >> 32));
+}
+
+/**
+ * MHRACCSU - 32-bit signed x unsigned multiply high
+ * with rounding and accumulate
+ */
+uint32_t HELPER(mhraccsu)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    uint32_t b = rs2;
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (uint64_t)b + (1LL << 31);
+    return (uint32_t)(d + (prod >> 32));
+}
+
+/**
+ * MHACCU - 32-bit unsigned multiply high with accumulate
+ */
+uint32_t HELPER(mhaccu)(CPURISCVState *env, uint32_t rs1,
+                         uint32_t rs2, uint32_t dest)
+{
+    uint32_t a = rs1;
+    uint32_t b = rs2;
+    uint32_t d = dest;
+    uint64_t prod = (uint64_t)a * (uint64_t)b;
+    return (uint32_t)(d + (prod >> 32));
+}
+
+/**
+ * MHRACCU - 32-bit unsigned multiply high with rounding and accumulate
+ */
+uint32_t HELPER(mhraccu)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint32_t dest)
+{
+    uint32_t a = rs1;
+    uint32_t b = rs2;
+    uint32_t d = dest;
+    uint64_t prod = (uint64_t)a * (uint64_t)b + (1LL << 31);
+    return (uint32_t)(d + (prod >> 32));
+}
+
+/**
+ * PMHACC.H.B0 - Multiply halfword by low byte and accumulate (high halfword)
+ */
+target_ulong HELPER(pmhacc_h_b0)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i * 2);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (int32_t)e2;
+        int16_t high = (int16_t)(prod >> 8);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACC.H.B1 - Multiply halfword by high byte and accumulate (high halfword)
+ */
+target_ulong HELPER(pmhacc_h_b1)(CPURISCVState *env, target_ulong rs1,
+                                 target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int8_t e2 = (int8_t)EXTRACT8(rs2, i * 2 + 1);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (int32_t)e2;
+        int16_t high = (int16_t)(prod >> 8);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCSU.H.B0 - Multiply signed halfword by unsigned low byte and accumulate
+ */
+target_ulong HELPER(pmhaccsu_h_b0)(CPURISCVState *env, target_ulong rs1,
+                                   target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i * 2);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2;
+        int16_t high = (int16_t)(prod >> 8);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCSU.H.B1 - Multiply signed halfword by unsigned high byte and accumulate
+ */
+target_ulong HELPER(pmhaccsu_h_b1)(CPURISCVState *env, target_ulong rs1,
+                                   target_ulong rs2, target_ulong dest)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        uint8_t e2 = EXTRACT8(rs2, i * 2 + 1);
+        int16_t d = (int16_t)EXTRACT16(dest, i);
+        int32_t prod = (int32_t)e1 * (uint32_t)e2;
+        int16_t high = (int16_t)(prod >> 8);
+        uint16_t res = (uint16_t)(high + d);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * MHACC.H0 - 32-bit multiply by low halfword high accumulate
+ */
+uint32_t HELPER(mhacc_h0)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    int16_t b = (int16_t)(rs2 & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (int64_t)b;
+    return (uint32_t)(d + (prod >> 16));
+}
+
+/**
+ * MHACC.H1 - 32-bit multiply by high halfword high accumulate
+ */
+uint32_t HELPER(mhacc_h1)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    int16_t b = (int16_t)((rs2 >> 16) & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (int64_t)b;
+    return (uint32_t)(d + (prod >> 16));
+}
+
+/**
+ * MHACCSU.H0 - 32-bit signed multiply by unsigned low halfword high accumulate
+ */
+uint32_t HELPER(mhaccsu_h0)(CPURISCVState *env, uint32_t rs1,
+                             uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    uint16_t b = (uint16_t)(rs2 & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (uint64_t)b;
+    return (uint32_t)(d + (prod >> 16));
+}
+
+/**
+ * MHACCSU.H1 - 32-bit signed multiply by unsigned high halfword high accumulate
+ */
+uint32_t HELPER(mhaccsu_h1)(CPURISCVState *env, uint32_t rs1,
+                             uint32_t rs2, uint32_t dest)
+{
+    int32_t a = (int32_t)rs1;
+    uint16_t b = (uint16_t)((rs2 >> 16) & 0xFFFF);
+    int32_t d = (int32_t)dest;
+    int64_t prod = (int64_t)a * (uint64_t)b;
+    return (uint32_t)(d + (prod >> 16));
+}
+
+/**
+ * PMHACC.W.H0 - Multiply word by low halfword high accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhacc_w_h0)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i * 2);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (int64_t)e2;
+        int32_t high = (int32_t)(prod >> 16);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACC.W.H1 - Multiply word by high halfword high accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhacc_w_h1)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int16_t e2 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (int64_t)e2;
+        int32_t high = (int32_t)(prod >> 16);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCSU.W.H0 - Multiply signed word by unsigned low halfword
+ * high accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhaccsu_w_h0)(CPURISCVState *env, uint64_t rs1,
+                                uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i * 2);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2;
+        int32_t high = (int32_t)(prod >> 16);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMHACCSU.W.H1 - Multiply signed word by unsigned high halfword
+ * high accumulate (RV64 only)
+ */
+uint64_t HELPER(pmhaccsu_w_h1)(CPURISCVState *env, uint64_t rs1,
+                                uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i * 2 + 1);
+        int32_t d = (int32_t)EXTRACT32(dest, i);
+        int64_t prod = (int64_t)e1 * (uint64_t)e2;
+        int32_t high = (int32_t)(prod >> 16);
+        uint32_t res = (uint32_t)(high + d);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PMACC.W.H00 - Packed multiply-accumulate, low halfwords
+ * For each word: rd[i] = dest[i] + (rs1[i][15:0] * rs2[i][15:0])
+ */
+uint64_t HELPER(pmacc_w_h00)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h0 = (int16_t)EXTRACT16(rs2, i * 2);
+        int32_t d_h = (int32_t)EXTRACT32(dest, i);
+        int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h0;
+        rd = INSERT32(rd, (uint32_t)(d_h + mul), i);
+    }
+    return rd;
+}
+
+/**
+ * PMACC.W.H01 - Packed multiply-accumulate, rs1 low x rs2 high
+ * For each word: rd[i] = dest[i] + (rs1[i][15:0] * rs2[i][31:16])
+ */
+uint64_t HELPER(pmacc_w_h01)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d_h = (int32_t)EXTRACT32(dest, i);
+        int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h1;
+        rd = INSERT32(rd, (uint32_t)(d_h + mul), i);
+    }
+    return rd;
+}
+
+/**
+ * PMACC.W.H11 - Packed multiply-accumulate, high halfwords
+ * For each word: rd[i] = dest[i] + (rs1[i][31:16] * rs2[i][31:16])
+ */
+uint64_t HELPER(pmacc_w_h11)(CPURISCVState *env, uint64_t rs1,
+                              uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        int16_t s2_h1 = (int16_t)EXTRACT16(rs2, i * 2 + 1);
+        int32_t d_h = (int32_t)EXTRACT32(dest, i);
+        int32_t mul = (int32_t)s1_h1 * (int32_t)s2_h1;
+        rd = INSERT32(rd, (uint32_t)(d_h + mul), i);
+    }
+    return rd;
+}
+
+/**
+ * PMACCSU.W.H00 - Packed signed x unsigned multiply-accumulate, low halfwords
+ * For each word: rd[i] = dest[i] +
+ * (signed)rs1[i][15:0] * (unsigned)rs2[i][15:0]
+ */
+uint64_t HELPER(pmaccsu_w_h00)(CPURISCVState *env, uint64_t rs1,
+                                uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h0 = (int16_t)EXTRACT16(rs1, i * 2);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        int32_t d_h = (int32_t)EXTRACT32(dest, i);
+        int32_t mul = (int32_t)s1_h0 * (uint32_t)s2_h0;
+        rd = INSERT32(rd, (uint32_t)(d_h + mul), i);
+    }
+    return rd;
+}
+
+/**
+ * PMACCSU.W.H11 - Packed signed x unsigned multiply-accumulate, high halfwords
+ * For each word: rd[i] = dest[i] +
+ * (signed)rs1[i][31:16] * (unsigned)rs2[i][31:16]
+ */
+uint64_t HELPER(pmaccsu_w_h11)(CPURISCVState *env, uint64_t rs1,
+                                uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t s1_h1 = (int16_t)EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        int32_t d_h = (int32_t)EXTRACT32(dest, i);
+        int32_t mul = (int32_t)s1_h1 * (uint32_t)s2_h1;
+        rd = INSERT32(rd, (uint32_t)(d_h + mul), i);
+    }
+    return rd;
+}
+
+/**
+ * PMACCU.W.H00 - Packed unsigned multiply-accumulate, low halfwords
+ * For each word: rd[i] = dest[i] + rs1[i][15:0] * rs2[i][15:0] (unsigned)
+ */
+uint64_t HELPER(pmaccu_w_h00)(CPURISCVState *env, uint64_t rs1,
+                               uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h0 = EXTRACT16(rs1, i * 2);
+        uint16_t s2_h0 = EXTRACT16(rs2, i * 2);
+        uint32_t d_h = EXTRACT32(dest, i);
+        uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h0;
+        rd = INSERT32(rd, d_h + mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMACCU.W.H01 - Packed unsigned multiply-accumulate, rs1 low x rs2 high
+ * For each word: rd[i] = dest[i] + rs1[i][15:0] * rs2[i][31:16] (unsigned)
+ */
+uint64_t HELPER(pmaccu_w_h01)(CPURISCVState *env, uint64_t rs1,
+                               uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h0 = EXTRACT16(rs1, i * 2);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        uint32_t d_h = EXTRACT32(dest, i);
+        uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h1;
+        rd = INSERT32(rd, d_h + mul, i);
+    }
+    return rd;
+}
+
+/**
+ * PMACCU.W.H11 - Packed unsigned multiply-accumulate, high halfwords
+ * For each word: rd[i] = dest[i] + rs1[i][31:16] * rs2[i][31:16] (unsigned)
+ */
+uint64_t HELPER(pmaccu_w_h11)(CPURISCVState *env, uint64_t rs1,
+                               uint64_t rs2, uint64_t dest)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t s1_h1 = EXTRACT16(rs1, i * 2 + 1);
+        uint16_t s2_h1 = EXTRACT16(rs2, i * 2 + 1);
+        uint32_t d_h = EXTRACT32(dest, i);
+        uint32_t mul = (uint32_t)s1_h1 * (uint32_t)s2_h1;
+        rd = INSERT32(rd, d_h + mul, i);
+    }
+    return rd;
+}
+
+/**
+ * MACC.H00 - 32-bit signed multiply-accumulate, low halfwords
+ * dest = dest + (rs1[15:0] * rs2[15:0])
+ */
+uint32_t HELPER(macc_h00)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s2_h0 = (int16_t)EXTRACT16(rs2, 0);
+    int32_t d_h = (int32_t)dest;
+    int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h0;
+    return (uint32_t)(d_h + mul);
+}
+
+/**
+ * MACC.H01 - 32-bit signed multiply-accumulate, rs1 low x rs2 high
+ * dest = dest + (rs1[15:0] * rs2[31:16])
+ */
+uint32_t HELPER(macc_h01)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int32_t d_h = (int32_t)dest;
+    int32_t mul = (int32_t)s1_h0 * (int32_t)s2_h1;
+    return (uint32_t)(d_h + mul);
+}
+
+/**
+ * MACC.H11 - 32-bit signed multiply-accumulate, high halfwords
+ * dest = dest + (rs1[31:16] * rs2[31:16])
+ */
+uint32_t HELPER(macc_h11)(CPURISCVState *env, uint32_t rs1,
+                          uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    int16_t s2_h1 = (int16_t)EXTRACT16(rs2, 1);
+    int32_t d_h = (int32_t)dest;
+    int32_t mul = (int32_t)s1_h1 * (int32_t)s2_h1;
+    return (uint32_t)(d_h + mul);
+}
+
+/**
+ * MACCSU.H00 - 32-bit signed x unsigned multiply-accumulate, low halfwords
+ * dest = dest + (rs1[15:0] * rs2[15:0]) with rs2 unsigned
+ */
+uint32_t HELPER(maccsu_h00)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h0 = (int16_t)EXTRACT16(rs1, 0);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    int32_t d_h = (int32_t)dest;
+    int32_t mul = (int32_t)s1_h0 * (uint32_t)s2_h0;
+    return (uint32_t)(d_h + mul);
+}
+
+/**
+ * MACCSU.H11 - 32-bit signed x unsigned multiply-accumulate, high halfwords
+ * dest = dest + (rs1[31:16] * rs2[31:16]) with rs2 unsigned
+ */
+uint32_t HELPER(maccsu_h11)(CPURISCVState *env, uint32_t rs1,
+                            uint32_t rs2, uint32_t dest)
+{
+    int16_t s1_h1 = (int16_t)EXTRACT16(rs1, 1);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    int32_t d_h = (int32_t)dest;
+    int32_t mul = (int32_t)s1_h1 * (uint32_t)s2_h1;
+    return (uint32_t)(d_h + mul);
+}
+
+/**
+ * MACCU.H00 - 32-bit unsigned multiply-accumulate, low halfwords
+ * dest = dest + (rs1[15:0] * rs2[15:0]) (unsigned)
+ */
+uint32_t HELPER(maccu_h00)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    uint16_t s1_h0 = EXTRACT16(rs1, 0);
+    uint16_t s2_h0 = EXTRACT16(rs2, 0);
+    uint32_t d_h = dest;
+    uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h0;
+    return d_h + mul;
+}
+
+/**
+ * MACCU.H01 - 32-bit unsigned multiply-accumulate, rs1 low x rs2 high
+ * dest = dest + (rs1[15:0] * rs2[31:16]) (unsigned)
+ */
+uint32_t HELPER(maccu_h01)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    uint16_t s1_h0 = EXTRACT16(rs1, 0);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint32_t d_h = dest;
+    uint32_t mul = (uint32_t)s1_h0 * (uint32_t)s2_h1;
+    return d_h + mul;
+}
+
+/**
+ * MACCU.H11 - 32-bit unsigned multiply-accumulate, high halfwords
+ * dest = dest + (rs1[31:16] * rs2[31:16]) (unsigned)
+ */
+uint32_t HELPER(maccu_h11)(CPURISCVState *env, uint32_t rs1,
+                           uint32_t rs2, uint32_t dest)
+{
+    uint16_t s1_h1 = EXTRACT16(rs1, 1);
+    uint16_t s2_h1 = EXTRACT16(rs2, 1);
+    uint32_t d_h = dest;
+    uint32_t mul = (uint32_t)s1_h1 * (uint32_t)s2_h1;
+    return d_h + mul;
+}
+
+/**
+ * MACC.W00 - 64-bit signed multiply-accumulate, low word x low word
+ * dest = dest + (rs1[31:0] * rs2[31:0])
+ */
+uint64_t HELPER(macc_w00)(CPURISCVState *env, uint64_t rs1,
+                          uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s2_w0 = (int32_t)EXTRACT32(rs2, 0);
+    int64_t d_w = (int64_t)dest;
+    int64_t mul = (int64_t)s1_w0 * (int64_t)s2_w0;
+    return (uint64_t)(d_w + mul);
+}
+
+/**
+ * MACC.W01 - 64-bit signed multiply-accumulate, low word x high word
+ * dest = dest + (rs1[31:0] * rs2[63:32])
+ */
+uint64_t HELPER(macc_w01)(CPURISCVState *env, uint64_t rs1,
+                          uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d_w = (int64_t)dest;
+    int64_t mul = (int64_t)s1_w0 * (int64_t)s2_w1;
+    return (uint64_t)(d_w + mul);
+}
+
+/**
+ * MACC.W11 - 64-bit signed multiply-accumulate, high word x high word
+ * dest = dest + (rs1[63:32] * rs2[63:32])
+ */
+uint64_t HELPER(macc_w11)(CPURISCVState *env, uint64_t rs1,
+                          uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    int32_t s2_w1 = (int32_t)EXTRACT32(rs2, 1);
+    int64_t d_w = (int64_t)dest;
+    int64_t mul = (int64_t)s1_w1 * (int64_t)s2_w1;
+    return (uint64_t)(d_w + mul);
+}
+
+/**
+ * MACCSU.W00 - 64-bit signed x unsigned
+ * multiply-accumulate, low word x low word
+ * dest = dest + (rs1[31:0] * rs2[31:0]) with rs2 interpreted as unsigned
+ */
+uint64_t HELPER(maccsu_w00)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w0 = (int32_t)EXTRACT32(rs1, 0);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    int64_t d_w = (int64_t)dest;
+    int64_t mul = (int64_t)s1_w0 * (uint64_t)s2_w0;
+    return (uint64_t)(d_w + mul);
+}
+
+/**
+ * MACCSU.W11 - 64-bit signed x unsigned
+ * multiply-accumulate, high word x high word
+ * dest = dest + (rs1[63:32] * rs2[63:32]) with rs2 interpreted as unsigned
+ */
+uint64_t HELPER(maccsu_w11)(CPURISCVState *env, uint64_t rs1,
+                            uint64_t rs2, uint64_t dest)
+{
+    int32_t s1_w1 = (int32_t)EXTRACT32(rs1, 1);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    int64_t d_w = (int64_t)dest;
+    int64_t mul = (int64_t)s1_w1 * (uint64_t)s2_w1;
+    return (uint64_t)(d_w + mul);
+}
+
+/**
+ * MACCU.W00 - 64-bit unsigned multiply-accumulate, low word x low word
+ * dest = dest + (rs1[31:0] * rs2[31:0]) (unsigned)
+ */
+uint64_t HELPER(maccu_w00)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    uint32_t s1_w0 = EXTRACT32(rs1, 0);
+    uint32_t s2_w0 = EXTRACT32(rs2, 0);
+    uint64_t d_w = dest;
+    uint64_t mul = (uint64_t)s1_w0 * (uint64_t)s2_w0;
+    return d_w + mul;
+}
+
+/**
+ * MACCU.W01 - 64-bit unsigned multiply-accumulate, low word x high word
+ * dest = dest + (rs1[31:0] * rs2[63:32]) (unsigned)
+ */
+uint64_t HELPER(maccu_w01)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    uint32_t s1_w0 = EXTRACT32(rs1, 0);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    uint64_t d_w = dest;
+    uint64_t mul = (uint64_t)s1_w0 * (uint64_t)s2_w1;
+    return d_w + mul;
+}
+
+/**
+ * MACCU.W11 - 64-bit unsigned multiply-accumulate, high word x high word
+ * dest = dest + (rs1[63:32] * rs2[63:32]) (unsigned)
+ */
+uint64_t HELPER(maccu_w11)(CPURISCVState *env, uint64_t rs1,
+                           uint64_t rs2, uint64_t dest)
+{
+    uint32_t s1_w1 = EXTRACT32(rs1, 1);
+    uint32_t s2_w1 = EXTRACT32(rs2, 1);
+    uint64_t d_w = dest;
+    uint64_t mul = (uint64_t)s1_w1 * (uint64_t)s2_w1;
+    return d_w + mul;
+}
-- 
2.34.1


