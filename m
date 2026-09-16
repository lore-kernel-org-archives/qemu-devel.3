Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1120AC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jkl-0005ny-G6; Wed, 16 Sep 2026 03:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkZ-0005cr-RL; Wed, 16 Sep 2026 03:08:11 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkT-0008JA-Q8; Wed, 16 Sep 2026 03:08:11 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S8;
 Wed, 16 Sep 2026 15:08:02 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 06/19] target/riscv: Add packed SIMD shift instructions
Date: Wed, 16 Sep 2026 07:07:08 +0000
Message-Id: <20260916070721.3279229-7-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
References: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S8
X-Coremail-Antispam: 1UD129KBjvAXoW3tF47GrW7Xw1fAFWxtr48tFb_yoW8GFykKo
 Z3Gw45Zr1rGr45Z345Cw48XwnFvr92vw4ktrWrZw1UWa92vryagrn8J348Z3WxAr1Yyry7
 XrZ3Gw15t3Z3W34Dn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOv7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
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
 x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
 67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULSdkUUUUU=
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

Implement packed logical left and right shifts, arithmetic right
shifts, saturating left shifts, rounding right shifts, and
bidirectional shift operations.  Cover immediate and
register-controlled variants across the supported element widths.
Add the associated decode entries, translators and helpers.

Note that saturating left-shift operations clamp results that cannot be
represented in the signed element domain to the corresponding minimum
or maximum signed value and set vxsat. Rounding right-shift operations
add the required rounding value before shifting and do not affect vxsat.
The helper implementation is equivalent to the operation defined in the
specification.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       |  43 +++++++
 target/riscv/insn32.decode                  |  57 +++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  43 +++++++
 target/riscv/tcg/psimd_helper.c             | 123 ++++++++++++++++++++
 4 files changed, 266 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index d9ea90a5c2e..53107334e1f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1454,3 +1454,46 @@ DEF_HELPER_3(pmaxu_w, i64, env, i64, i64)
 DEF_HELPER_3(mseq, i32, env, i32, i32)
 DEF_HELPER_3(mslt, i32, env, i32, i32)
 DEF_HELPER_3(msltu, i32, env, i32, i32)
+
+/* Packed SIMD - Shift Operations */
+DEF_HELPER_3(pslli_b, tl, env, tl, tl)
+DEF_HELPER_3(psll_bs, tl, env, tl, tl)
+DEF_HELPER_3(pslli_h, tl, env, tl, tl)
+DEF_HELPER_3(psll_hs, tl, env, tl, tl)
+DEF_HELPER_3(pslli_w, i64, env, i64, i64)
+DEF_HELPER_3(psll_ws, i64, env, i64, i64)
+DEF_HELPER_3(psrli_b, tl, env, tl, tl)
+DEF_HELPER_3(psrl_bs, tl, env, tl, tl)
+DEF_HELPER_3(psrli_h, tl, env, tl, tl)
+DEF_HELPER_3(psrl_hs, tl, env, tl, tl)
+DEF_HELPER_3(psrli_w, i64, env, i64, i64)
+DEF_HELPER_3(psrl_ws, i64, env, i64, i64)
+DEF_HELPER_3(psrai_b, tl, env, tl, tl)
+DEF_HELPER_3(psra_bs, tl, env, tl, tl)
+DEF_HELPER_3(psrai_h, tl, env, tl, tl)
+DEF_HELPER_3(psra_hs, tl, env, tl, tl)
+DEF_HELPER_3(psrai_w, i64, env, i64, i64)
+DEF_HELPER_3(psra_ws, i64, env, i64, i64)
+DEF_HELPER_3(psslai_h, tl, env, tl, tl)
+DEF_HELPER_3(psslai_w, i64, env, i64, i64)
+DEF_HELPER_3(sslai, i32, env, i32, i32)
+DEF_HELPER_3(psrari_h, tl, env, tl, tl)
+DEF_HELPER_3(psrari_w, i64, env, i64, i64)
+DEF_HELPER_3(srari_32, i32, env, i32, i32)
+DEF_HELPER_3(srari_64, i64, env, i64, i64)
+DEF_HELPER_3(pssha_hs, tl, env, tl, tl)
+DEF_HELPER_3(pssha_ws, i64, env, i64, i64)
+DEF_HELPER_3(psshar_hs, tl, env, tl, tl)
+DEF_HELPER_3(psshar_ws, i64, env, i64, i64)
+DEF_HELPER_3(ssha, i32, env, i32, i32)
+DEF_HELPER_3(sshar, i32, env, i32, i32)
+DEF_HELPER_3(sha, i64, env, i64, i64)
+DEF_HELPER_3(shar, i64, env, i64, i64)
+DEF_HELPER_3(psshl_hs, tl, env, tl, tl)
+DEF_HELPER_3(psshlr_hs, tl, env, tl, tl)
+DEF_HELPER_3(psshl_ws, i64, env, i64, i64)
+DEF_HELPER_3(psshlr_ws, i64, env, i64, i64)
+DEF_HELPER_3(sshl, i32, env, i32, i32)
+DEF_HELPER_3(sshlr, i32, env, i32, i32)
+DEF_HELPER_3(shl, i64, env, i64, i64)
+DEF_HELPER_3(shlr, i64, env, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 32eb7b153aa..82434b10410 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -40,6 +40,7 @@
 %imm_z6   26:1 15:5
 %imm_mop5 30:1 26:2 20:2
 %imm_mop3 30:1 26:2
+%imm_p_ui8 20:3
 %imm_p_ui16 20:4
 %imm_p_ui32 20:5
 %imm_p_ui64 20:6
@@ -109,6 +110,7 @@
 @mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
 @mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
 
+@p_ui8  ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui8  %rs1 %rd
 @p_ui16 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui16 %rs1 %rd
 @p_ui32 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui32 %rs1 %rd
 @p_ui64 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui64 %rs1 %rd
@@ -1219,3 +1221,58 @@ pmin_w     1110001 ..... ..... 110 ..... 0111011 @r
 pminu_w    1110101 ..... ..... 110 ..... 0111011 @r
 pmax_w     1111001 ..... ..... 110 ..... 0111011 @r
 pmaxu_w    1111101 ..... ..... 110 ..... 0111011 @r
+
+# Packed SIMD - Shift Operations
+pslli_b    10000 0001... ..... 010 ..... 0011011 @p_ui8
+psll_bs    1000110 ..... ..... 010 ..... 0011011 @r
+pslli_h    10000 001.... ..... 010 ..... 0011011 @p_ui16
+psll_hs    1000100 ..... ..... 010 ..... 0011011 @r
+pslli_w    10000 01..... ..... 010 ..... 0011011 @p_ui32
+psll_ws    1000101 ..... ..... 010 ..... 0011011 @r
+psrli_b    10000 0001... ..... 100 ..... 0011011 @p_ui8
+psrl_bs    1000110 ..... ..... 100 ..... 0011011 @r
+psrli_h    10000 001.... ..... 100 ..... 0011011 @p_ui16
+psrl_hs    1000100 ..... ..... 100 ..... 0011011 @r
+psrli_w    10000 01..... ..... 100 ..... 0011011 @p_ui32
+psrl_ws    1000101 ..... ..... 100 ..... 0011011 @r
+psrai_b    11000 0001... ..... 100 ..... 0011011 @p_ui8
+psra_bs    1100110 ..... ..... 100 ..... 0011011 @r
+psrai_h    11000 001.... ..... 100 ..... 0011011 @p_ui16
+psra_hs    1100100 ..... ..... 100 ..... 0011011 @r
+psrai_w    11000 01..... ..... 100 ..... 0011011 @p_ui32
+psra_ws    1100101 ..... ..... 100 ..... 0011011 @r
+psslai_h   11010 001.... ..... 010 ..... 0011011 @p_ui16
+{
+  sslai    11010 01..... ..... 010 ..... 0011011 @p_ui32
+  psslai_w 11010 01..... ..... 010 ..... 0011011 @p_ui32
+}
+psrari_h   11010 001.... ..... 100 ..... 0011011 @p_ui16
+{
+  srari_32 11010 01..... ..... 100 ..... 0011011 @p_ui32
+  psrari_w 11010 01..... ..... 100 ..... 0011011 @p_ui32
+}
+srari_64   110101 ...... ..... 100 ..... 0011011 @p_ui64
+pssha_hs   1110100 ..... ..... 010 ..... 0011011 @r
+{
+  ssha     1110101 ..... ..... 010 ..... 0011011 @r
+  pssha_ws 1110101 ..... ..... 010 ..... 0011011 @r
+}
+psshar_hs  1111100 ..... ..... 010 ..... 0011011 @r
+{
+  sshar    1111101 ..... ..... 010 ..... 0011011 @r
+  psshar_ws 1111101 ..... ..... 010 ..... 0011011 @r
+}
+sha        1110111 ..... ..... 010 ..... 0011011 @r
+shar       1111111 ..... ..... 010 ..... 0011011 @r
+psshl_hs   1010100 ..... ..... 010 ..... 0011011 @r
+psshlr_hs  1011100 ..... ..... 010 ..... 0011011 @r
+{
+  psshl_ws 1010101 ..... ..... 010 ..... 0011011 @r
+  sshl     1010101 ..... ..... 010 ..... 0011011 @r
+}
+{
+  psshlr_ws 1011101 ..... ..... 010 ..... 0011011 @r
+  sshlr     1011101 ..... ..... 010 ..... 0011011 @r
+}
+shl        1010111 ..... ..... 010 ..... 0011011 @r
+shlr       1011111 ..... ..... 010 ..... 0011011 @r
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 81d3f90eb08..32b5de9f1b6 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -607,3 +607,46 @@ GEN_SIMD_TRANS_64(pmaxu_w)
 GEN_SIMD_TRANS_32(mseq)
 GEN_SIMD_TRANS_32(mslt)
 GEN_SIMD_TRANS_32(msltu)
+
+/* Packed SIMD - Shift Operations */
+GEN_SIMD_TRANS_IMM(pslli_b)
+GEN_SIMD_TRANS(psll_bs)
+GEN_SIMD_TRANS_IMM(pslli_h)
+GEN_SIMD_TRANS(psll_hs)
+GEN_SIMD_TRANS_IMM_64(pslli_w)
+GEN_SIMD_TRANS_64(psll_ws)
+GEN_SIMD_TRANS_IMM(psrli_b)
+GEN_SIMD_TRANS(psrl_bs)
+GEN_SIMD_TRANS_IMM(psrli_h)
+GEN_SIMD_TRANS(psrl_hs)
+GEN_SIMD_TRANS_IMM_64(psrli_w)
+GEN_SIMD_TRANS_64(psrl_ws)
+GEN_SIMD_TRANS_IMM(psrai_b)
+GEN_SIMD_TRANS(psra_bs)
+GEN_SIMD_TRANS_IMM(psrai_h)
+GEN_SIMD_TRANS(psra_hs)
+GEN_SIMD_TRANS_IMM_64(psrai_w)
+GEN_SIMD_TRANS_64(psra_ws)
+GEN_SIMD_TRANS_IMM_VXSAT(psslai_h)
+GEN_SIMD_TRANS_IMM_64_VXSAT(psslai_w)
+GEN_SIMD_TRANS_IMM_32_VXSAT(sslai)
+GEN_SIMD_TRANS_IMM(psrari_h)
+GEN_SIMD_TRANS_IMM_64(psrari_w)
+GEN_SIMD_TRANS_IMM_32(srari_32)
+GEN_SIMD_TRANS_IMM_64(srari_64)
+GEN_SIMD_TRANS_VXSAT(pssha_hs)
+GEN_SIMD_TRANS_64_VXSAT(pssha_ws)
+GEN_SIMD_TRANS_VXSAT(psshar_hs)
+GEN_SIMD_TRANS_64_VXSAT(psshar_ws)
+GEN_SIMD_TRANS_32_VXSAT(ssha)
+GEN_SIMD_TRANS_32_VXSAT(sshar)
+GEN_SIMD_TRANS_64(sha)
+GEN_SIMD_TRANS_64(shar)
+GEN_SIMD_TRANS_VXSAT(psshl_hs)
+GEN_SIMD_TRANS_VXSAT(psshlr_hs)
+GEN_SIMD_TRANS_64_VXSAT(psshl_ws)
+GEN_SIMD_TRANS_64_VXSAT(psshlr_ws)
+GEN_SIMD_TRANS_32_VXSAT(sshl)
+GEN_SIMD_TRANS_32_VXSAT(sshlr)
+GEN_SIMD_TRANS_64(shl)
+GEN_SIMD_TRANS_64(shlr)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 625928dc1dd..cd110aa1cdc 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2295,3 +2295,126 @@ GEN_PSIMD_BINOP(mslt, uint32_t, int32_t, uint32_t,
                 EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
 GEN_PSIMD_BINOP(msltu, uint32_t, uint32_t, uint32_t,
                 EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
+
+/* Shift operations (immediate and register) */
+
+GEN_PSIMD_SHIFTOP(pslli_b, target_ulong, uint8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SLL)
+GEN_PSIMD_SHIFTOP(psll_bs, target_ulong, uint8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x1f, PSIMD_DO_SLL)
+GEN_PSIMD_SHIFTOP(pslli_h, target_ulong, uint16_t, uint16_t,
+                  EXTRACT16, INSERT16, ELEMS_H, 0x0f, PSIMD_DO_SLL)
+GEN_PSIMD_SHIFTOP(psll_hs, target_ulong, uint16_t, uint16_t,
+                  EXTRACT16, INSERT16, ELEMS_H, 0x1f, PSIMD_DO_SLL)
+GEN_PSIMD_SHIFTOP(pslli_w, uint64_t, uint32_t, uint32_t,
+                  EXTRACT32, INSERT32, ELEMS_W, 0x1f, PSIMD_DO_SLL)
+GEN_PSIMD_SHIFTOP(psll_ws, uint64_t, uint32_t, uint32_t,
+                  EXTRACT32, INSERT32, ELEMS_W, 0x1f, PSIMD_DO_SLL)
+
+GEN_PSIMD_SHIFTOP(psrli_b, target_ulong, uint8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SRL)
+GEN_PSIMD_SHIFTOP(psrl_bs, target_ulong, uint8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x1f, PSIMD_DO_SRL)
+GEN_PSIMD_SHIFTOP(psrli_h, target_ulong, uint16_t, uint16_t,
+                  EXTRACT16, INSERT16, ELEMS_H, 0x0f, PSIMD_DO_SRL)
+GEN_PSIMD_SHIFTOP(psrl_hs, target_ulong, uint16_t, uint16_t,
+                  EXTRACT16, INSERT16, ELEMS_H, 0x1f, PSIMD_DO_SRL)
+GEN_PSIMD_SHIFTOP(psrli_w, uint64_t, uint32_t, uint32_t,
+                  EXTRACT32, INSERT32, ELEMS_W, 0x1f, PSIMD_DO_SRL)
+GEN_PSIMD_SHIFTOP(psrl_ws, uint64_t, uint32_t, uint32_t,
+                  EXTRACT32, INSERT32, ELEMS_W, 0x1f, PSIMD_DO_SRL)
+
+GEN_PSIMD_SHIFTOP(psrai_b, target_ulong, int8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SRA)
+GEN_PSIMD_SHIFTOP(psra_bs, target_ulong, int8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x1f, PSIMD_DO_SRA)
+GEN_PSIMD_SHIFTOP(psrai_h, target_ulong, int16_t, uint16_t,
+                  EXTRACT16, INSERT16, ELEMS_H, 0x0f, PSIMD_DO_SRA)
+GEN_PSIMD_SHIFTOP(psra_hs, target_ulong, int16_t, uint16_t,
+                  EXTRACT16, INSERT16, ELEMS_H, 0x1f, PSIMD_DO_SRA)
+GEN_PSIMD_SHIFTOP(psrai_w, uint64_t, int32_t, uint32_t,
+                  EXTRACT32, INSERT32, ELEMS_W, 0x1f, PSIMD_DO_SRA)
+GEN_PSIMD_SHIFTOP(psra_ws, uint64_t, int32_t, uint32_t,
+                  EXTRACT32, INSERT32, ELEMS_W, 0x1f, PSIMD_DO_SRA)
+
+/* Saturating shift operations */
+
+GEN_PSIMD_SAT_SHIFTOP(psslai_h, target_ulong, int16_t, int32_t,
+                      EXTRACT16, INSERT16, ELEMS_H, 0x0f,
+                      signed_saturate_h)
+GEN_PSIMD_SAT_SHIFTOP(psslai_w, uint64_t, int32_t, int64_t,
+                      EXTRACT32, INSERT32, ELEMS_W, 0x1f,
+                      signed_saturate_w)
+
+GEN_PSIMD_SAT_SHIFTOP(sslai, uint32_t, int32_t, int64_t,
+                      EXTRACT32, INSERT32, ELEMS_W, 0x1f,
+                      signed_saturate_w)
+
+/* Rounding shift operations */
+
+GEN_PSIMD_ROUND_SRAI(psrari_h, target_ulong, int16_t, int32_t,
+                     EXTRACT16, INSERT16, ELEMS_H, 0x0f)
+GEN_PSIMD_ROUND_SRAI(psrari_w, uint64_t, int32_t, int64_t,
+                     EXTRACT32, INSERT32, ELEMS_W, 0x1f)
+
+GEN_PSIMD_ROUND_SRAI(srari_32, uint32_t, int32_t, int64_t,
+                     EXTRACT32, INSERT32, ELEMS_W, 0x1f)
+
+/**
+ * SRARI (RV64) - Scalar arithmetic shift right with rounding
+ */
+uint64_t HELPER(srari_64)(CPURISCVState *env, uint64_t rs1, uint64_t imm)
+{
+    int64_t a = (int64_t)rs1;
+    uint8_t shamt = imm & 0x3F;
+
+    if (shamt == 0) {
+        return rs1;
+    }
+
+    return (uint64_t)((((__int128_t)a >> (shamt - 1)) + 1) >> 1);
+}
+
+/* Variable shift operations (with saturation and rounding) */
+
+GEN_PSIMD_VAR_SSHA(pssha_hs, target_ulong, int16_t, int32_t,
+                   EXTRACT16, INSERT16, ELEMS_H, 16, signed_saturate_h)
+GEN_PSIMD_VAR_SSHA(pssha_ws, uint64_t, int32_t, int64_t,
+                   EXTRACT32, INSERT32, ELEMS_W, 32, signed_saturate_w)
+
+GEN_PSIMD_VAR_SSHAR(psshar_hs, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, 16, SAT_MIN_H, SAT_MAX_H,
+                    signed_saturate_h)
+GEN_PSIMD_VAR_SSHAR(psshar_ws, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 32, SAT_MIN_W, SAT_MAX_W,
+                    signed_saturate_w)
+
+GEN_PSIMD_VAR_SSHA(ssha, uint32_t, int32_t, int64_t,
+                   EXTRACT32, INSERT32, ELEMS_W, 32, signed_saturate_w)
+GEN_PSIMD_VAR_SSHAR(sshar, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 32, SAT_MIN_W, SAT_MAX_W,
+                    signed_saturate_w)
+
+GEN_PSIMD_VAR_SRA64(sha, PSIMD_DO_SRA64)
+GEN_PSIMD_VAR_SRA64(shar, PSIMD_DO_RNDSRA64)
+
+GEN_PSIMD_VAR_USHL(psshl_hs, target_ulong, uint16_t, uint32_t,
+                   EXTRACT16, INSERT16, ELEMS_H, 16, unsigned_saturate_h)
+
+GEN_PSIMD_VAR_USHLR(psshlr_hs, target_ulong, uint16_t, uint32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, 16, unsigned_saturate_h)
+
+GEN_PSIMD_VAR_USHL(psshl_ws, uint64_t, uint32_t, uint64_t,
+                   EXTRACT32, INSERT32, ELEMS_W, 32, unsigned_saturate_w)
+
+GEN_PSIMD_VAR_USHLR(psshlr_ws, uint64_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 32, unsigned_saturate_w)
+
+GEN_PSIMD_VAR_USHL(sshl, uint32_t, uint32_t, uint64_t,
+                   EXTRACT32, INSERT32, ELEMS_W, 32, unsigned_saturate_w)
+
+GEN_PSIMD_VAR_USHLR(sshlr, uint32_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 32, unsigned_saturate_w)
+
+GEN_PSIMD_VAR_SRL64(shl, PSIMD_DO_SRL64)
+GEN_PSIMD_VAR_SRL64(shlr, PSIMD_DO_RNDSRL64)
-- 
2.34.1


