Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB39C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jkf-0005fZ-U4; Wed, 16 Sep 2026 03:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkZ-0005cX-E7; Wed, 16 Sep 2026 03:08:11 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkT-0008J5-Rw; Wed, 16 Sep 2026 03:08:10 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S6;
 Wed, 16 Sep 2026 15:08:01 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 04/19] target/riscv: Add packed SIMD averaging and rounding
 instructions
Date: Wed, 16 Sep 2026 07:07:06 +0000
Message-Id: <20260916070721.3279229-5-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rAw1xWr13AF4xAw4DXFb_yoWxCFyxpa
 n7G343JFW8tFWaqFySkr45tw13Wws3K3yUur43KFySvay5JF93Jw1Utr4aka13XryDWr1j
 9ayFyr98AFWFq3JanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
 IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
 14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbKZX7UUUUU==
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

Implement averaging addition and subtraction operations.  Cover signed
and unsigned variants across the supported element widths. Add the
associated decode entries, translators and helpers.

These instructions add or subtract corresponding packed elements and
shift each intermediate result right by one bit. The helpers use wider
intermediate types to preserve the bits required by the add or subtract
operation before shifting, and then truncate each result back to the
original element width.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/helper.h                       | 18 ++++++++++
 target/riscv/insn32.decode                  | 26 ++++++++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 18 ++++++++++
 target/riscv/tcg/psimd_helper.c             | 40 +++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 23741b2e827..0b0f5791874 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1398,3 +1398,21 @@ DEF_HELPER_3(sati_32, i32, env, i32, i32)
 DEF_HELPER_3(usati_32, i32, env, i32, i32)
 DEF_HELPER_3(sati_64, i64, env, i64, i64)
 DEF_HELPER_3(usati_64, i64, env, i64, i64)
+
+/* Packed SIMD - Averaging and Rounding Operations */
+DEF_HELPER_3(paadd_b, tl, env, tl, tl)
+DEF_HELPER_3(paadd_h, tl, env, tl, tl)
+DEF_HELPER_3(paadd_w, i64, env, i64, i64)
+DEF_HELPER_3(paaddu_b, tl, env, tl, tl)
+DEF_HELPER_3(paaddu_h, tl, env, tl, tl)
+DEF_HELPER_3(paaddu_w, i64, env, i64, i64)
+DEF_HELPER_3(aadd, i32, env, i32, i32)
+DEF_HELPER_3(aaddu, i32, env, i32, i32)
+DEF_HELPER_3(pasub_b, tl, env, tl, tl)
+DEF_HELPER_3(pasub_h, tl, env, tl, tl)
+DEF_HELPER_3(pasub_w, i64, env, i64, i64)
+DEF_HELPER_3(pasubu_b, tl, env, tl, tl)
+DEF_HELPER_3(pasubu_h, tl, env, tl, tl)
+DEF_HELPER_3(pasubu_w, i64, env, i64, i64)
+DEF_HELPER_3(asub, i32, env, i32, i32)
+DEF_HELPER_3(asubu, i32, env, i32, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index afd096cf5db..e06cc82bdef 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1149,3 +1149,29 @@ pusati_h   10100 001.... ..... 100 ..... 0011011 @p_ui16
 }
 sati_64    111001 ...... ..... 100 ..... 0011011 @p_ui64
 usati_64   101001 ...... ..... 100 ..... 0011011 @p_ui64
+
+# Packed SIMD - Averaging and Rounding Operations
+paadd_b    1001110 ..... ..... 000 ..... 0111011 @r
+paadd_h    1001100 ..... ..... 000 ..... 0111011 @r
+{
+  aadd     1001101 ..... ..... 000 ..... 0111011 @r
+  paadd_w  1001101 ..... ..... 000 ..... 0111011 @r
+}
+paaddu_b   1011110 ..... ..... 000 ..... 0111011 @r
+paaddu_h   1011100 ..... ..... 000 ..... 0111011 @r
+{
+  aaddu    1011101 ..... ..... 000 ..... 0111011 @r
+  paaddu_w 1011101 ..... ..... 000 ..... 0111011 @r
+}
+pasub_b    1101110 ..... ..... 000 ..... 0111011 @r
+pasub_h    1101100 ..... ..... 000 ..... 0111011 @r
+{
+  asub     1101101 ..... ..... 000 ..... 0111011 @r
+  pasub_w  1101101 ..... ..... 000 ..... 0111011 @r
+}
+pasubu_b   1111110 ..... ..... 000 ..... 0111011 @r
+pasubu_h   1111100 ..... ..... 000 ..... 0111011 @r
+{
+  asubu    1111101 ..... ..... 000 ..... 0111011 @r
+  pasubu_w 1111101 ..... ..... 000 ..... 0111011 @r
+}
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 0c91aac5060..820d11c33b2 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -551,3 +551,21 @@ GEN_SIMD_TRANS_IMM_32_VXSAT(sati_32)
 GEN_SIMD_TRANS_IMM_32_VXSAT(usati_32)
 GEN_SIMD_TRANS_IMM_64_VXSAT(sati_64)
 GEN_SIMD_TRANS_IMM_64_VXSAT(usati_64)
+
+/* Packed SIMD - Averaging and Rounding Operations */
+GEN_SIMD_TRANS(paadd_b)
+GEN_SIMD_TRANS(paadd_h)
+GEN_SIMD_TRANS_64(paadd_w)
+GEN_SIMD_TRANS(paaddu_b)
+GEN_SIMD_TRANS(paaddu_h)
+GEN_SIMD_TRANS_64(paaddu_w)
+GEN_SIMD_TRANS_32(aadd)
+GEN_SIMD_TRANS_32(aaddu)
+GEN_SIMD_TRANS(pasub_b)
+GEN_SIMD_TRANS(pasub_h)
+GEN_SIMD_TRANS_64(pasub_w)
+GEN_SIMD_TRANS(pasubu_b)
+GEN_SIMD_TRANS(pasubu_h)
+GEN_SIMD_TRANS_64(pasubu_w)
+GEN_SIMD_TRANS_32(asub)
+GEN_SIMD_TRANS_32(asubu)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 8702b7398b0..e2796230710 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2160,3 +2160,43 @@ GEN_PSIMD_SATI(sati_64, uint64_t, int64_t, int64_t,
                EXTRACT64, INSERT64, ELEMS_D, 0x3f)
 GEN_PSIMD_USATI(usati_64, uint64_t, int64_t, uint64_t, uint64_t,
                 EXTRACT64, INSERT64, ELEMS_D, 1ULL)
+
+/* Averaging Operations (non-saturating) */
+
+GEN_PSIMD_AVG_BINOP(paadd_b, target_ulong, int8_t, int16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paadd_h, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paadd_w, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+GEN_PSIMD_AVG_BINOP(paaddu_b, target_ulong, uint8_t, uint16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paaddu_h, target_ulong, uint16_t, uint32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(paaddu_w, uint64_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+GEN_PSIMD_AVG_BINOP(aadd, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+GEN_PSIMD_AVG_BINOP(aaddu, uint32_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+GEN_PSIMD_AVG_BINOP(pasub_b, target_ulong, int8_t, int16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasub_h, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasub_w, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+
+GEN_PSIMD_AVG_BINOP(pasubu_b, target_ulong, uint8_t, uint16_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasubu_h, target_ulong, uint16_t, uint32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(pasubu_w, uint64_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+
+GEN_PSIMD_AVG_BINOP(asub, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+GEN_PSIMD_AVG_BINOP(asubu, uint32_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
-- 
2.34.1


