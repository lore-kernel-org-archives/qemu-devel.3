Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA289F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjS-0001Bn-1U; Fri, 17 Apr 2026 06:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjK-00014V-Ds; Fri, 17 Apr 2026 06:47:22 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjG-0007yy-PO; Fri, 17 Apr 2026 06:47:22 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S7;
 Fri, 17 Apr 2026 18:47:12 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/14] target/riscv: rvp: add shift operations
Date: Fri, 17 Apr 2026 18:46:42 +0800
Message-Id: <20260417104652.17857-6-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S7
X-Coremail-Antispam: 1UD129KBjvAXoWftr1ruFyrAw48CrW7Zr1fWFg_yoW8Kr1rWo
 ZxKw1Yyw1fGr13u348uw48Xr1Iqry2vw1DJr4rZr4UXa97Wr12gF15J34kZF4xJrWayrW5
 XFZ3KF95JF1akr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOU7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
 3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtV
 W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
 6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
 Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
 Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
 CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbnNVPUU
 UUU==
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
 target/riscv/helper.h                   |  34 ++
 target/riscv/insn32.decode              |  44 ++
 target/riscv/insn_trans/trans_rvp.c.inc |  34 ++
 target/riscv/psimd_helper.c             | 736 ++++++++++++++++++++++++
 4 files changed, 848 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f6351ecd43..d97552eb58 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1449,3 +1449,37 @@ DEF_HELPER_3(mseq, i32, env, i32, i32)
 DEF_HELPER_3(mslt, i32, env, i32, i32)
 DEF_HELPER_3(msltu, i32, env, i32, i32)
 
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
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 2034041639..69514e2cb9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -40,6 +40,7 @@
 %imm_z6   26:1 15:5
 %imm_mop5 30:1 26:2 20:2
 %imm_mop3 30:1 26:2
+%imm_p_ui8  20:3
 %imm_p_ui16 20:4
 %imm_p_ui32 20:5
 %imm_p_ui64 20:6
@@ -108,6 +109,7 @@
 @mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
 @mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
 
+@p_ui8  ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui8  %rs1 %rd
 @p_ui16 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui16 %rs1 %rd
 @p_ui32 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui32 %rs1 %rd
 @p_ui64 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui64 %rs1 %rd
@@ -1219,3 +1221,45 @@ pminu_w    1110101 ..... ..... 110 ..... 0111011 @r
 pmax_w     1111001 ..... ..... 110 ..... 0111011 @r
 pmaxu_w    1111101 ..... ..... 110 ..... 0111011 @r
 
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
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index 27d482863c..d0b645d083 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -620,3 +620,37 @@ GEN_SIMD_TRANS_32(mseq)
 GEN_SIMD_TRANS_32(mslt)
 GEN_SIMD_TRANS_32(msltu)
 
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
+GEN_SIMD_TRANS_IMM(psslai_h)
+GEN_SIMD_TRANS_IMM_64(psslai_w)
+GEN_SIMD_TRANS_IMM_32(sslai)
+GEN_SIMD_TRANS_IMM(psrari_h)
+GEN_SIMD_TRANS_IMM_64(psrari_w)
+GEN_SIMD_TRANS_IMM_32(srari_32)
+GEN_SIMD_TRANS_IMM_64(srari_64)
+GEN_SIMD_TRANS(pssha_hs)
+GEN_SIMD_TRANS_64(pssha_ws)
+GEN_SIMD_TRANS(psshar_hs)
+GEN_SIMD_TRANS_64(psshar_ws)
+GEN_SIMD_TRANS_32(ssha)
+GEN_SIMD_TRANS_32(sshar)
+GEN_SIMD_TRANS_64(sha)
+GEN_SIMD_TRANS_64(shar)
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index 38207c3a39..ef556eb007 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -1967,3 +1967,739 @@ uint32_t HELPER(msltu)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
     return (rs1 < rs2) ? 0xFFFFFFFFU : 0x00000000U;
 }
 
+/* Shift operations (immediate and register) */
+
+/**
+ * PSLLI.B - Packed 8-bit logical shift left immediate
+ * For each byte: rd[i] = rs1[i] << imm
+ */
+target_ulong HELPER(pslli_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+    uint8_t shamt = imm & 0x07;  /* 8-bit elements, max shift 7 */
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t res = e1 << shamt;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSLL.BS - Packed 8-bit logical shift left from register
+ * For each byte: rd[i] = rs1[i] << rs2[4:0]
+ */
+target_ulong HELPER(psll_bs)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+    uint8_t shamt = rs2 & 0x07;  /* rs2[2:0] for 8-bit */
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t res = e1 << shamt;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSLLI.H - Packed 16-bit logical shift left immediate
+ * For each halfword: rd[i] = rs1[i] << imm
+ */
+target_ulong HELPER(pslli_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    uint8_t shamt = imm & 0x0F;  /* 16-bit elements, max shift 15 */
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t res = e1 << shamt;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSLL.HS - Packed 16-bit logical shift left from register
+ * For each halfword: rd[i] = rs1[i] << rs2[4:0]
+ */
+target_ulong HELPER(psll_hs)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    uint8_t shamt = rs2 & 0x0F;  /* rs2[3:0] for 16-bit */
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t res = e1 << shamt;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSLLI.W - Packed 32-bit logical shift left immediate (RV64 only)
+ * For each word: rd[i] = rs1[i] << imm
+ */
+uint64_t HELPER(pslli_w)(CPURISCVState *env, uint64_t rs1, uint64_t imm)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    uint8_t shamt = imm & 0x1F;  /* 32-bit elements, max shift 31 */
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t res = e1 << shamt;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSLL.WS - Packed 32-bit logical shift left from register (RV64 only)
+ * For each word: rd[i] = rs1[i] << rs2[5:0]
+ */
+uint64_t HELPER(psll_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    uint8_t shamt = rs2 & 0x1F;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t res = e1 << shamt;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRLI.B - Packed 8-bit logical shift right immediate
+ * For each byte: rd[i] = rs1[i] >> imm
+ */
+target_ulong HELPER(psrli_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+    uint8_t shamt = imm & 0x07;
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t res = e1 >> shamt;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRL.BS - Packed 8-bit logical shift right from register
+ * For each byte: rd[i] = rs1[i] >> rs2[4:0]
+ */
+target_ulong HELPER(psrl_bs)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+    uint8_t shamt = rs2 & 0x07;
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        uint8_t res = e1 >> shamt;
+        rd = INSERT8(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRLI.H - Packed 16-bit logical shift right immediate
+ * For each halfword: rd[i] = rs1[i] >> imm
+ */
+target_ulong HELPER(psrli_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    uint8_t shamt = imm & 0x0F;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t res = e1 >> shamt;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRL.HS - Packed 16-bit logical shift right from register
+ * For each halfword: rd[i] = rs1[i] >> rs2[4:0]
+ */
+target_ulong HELPER(psrl_hs)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    uint8_t shamt = rs2 & 0x0F;
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t res = e1 >> shamt;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRLI.W - Packed 32-bit logical shift right immediate (RV64 only)
+ * For each word: rd[i] = rs1[i] >> imm
+ */
+uint64_t HELPER(psrli_w)(CPURISCVState *env, uint64_t rs1, uint64_t imm)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    uint8_t shamt = imm & 0x1F;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t res = e1 >> shamt;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRL.WS - Packed 32-bit logical shift right from register (RV64 only)
+ * For each word: rd[i] = rs1[i] >> rs2[5:0]
+ */
+uint64_t HELPER(psrl_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    uint8_t shamt = rs2 & 0x1F;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t res = e1 >> shamt;
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRAI.B - Packed 8-bit arithmetic shift right immediate
+ * For each byte: rd[i] = (int8_t)rs1[i] >> imm
+ */
+target_ulong HELPER(psrai_b)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+    uint8_t shamt = imm & 0x07;
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int8_t res = e1 >> shamt;  /* Arithmetic right shift */
+        rd = INSERT8(rd, (uint8_t)res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRA.BS - Packed 8-bit arithmetic shift right from register
+ * For each byte: rd[i] = (int8_t)rs1[i] >> rs2[4:0]
+ */
+target_ulong HELPER(psra_bs)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_B(rd);
+    uint8_t shamt = rs2 & 0x07;
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        int8_t res = e1 >> shamt;
+        rd = INSERT8(rd, (uint8_t)res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRAI.H - Packed 16-bit arithmetic shift right immediate
+ * For each halfword: rd[i] = (int16_t)rs1[i] >> imm
+ */
+target_ulong HELPER(psrai_h)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    uint8_t shamt = imm & 0x0F;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t res = e1 >> shamt;
+        rd = INSERT16(rd, (uint16_t)res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRA.HS - Packed 16-bit arithmetic shift right from register
+ * For each halfword: rd[i] = (int16_t)rs1[i] >> rs2[4:0]
+ */
+target_ulong HELPER(psra_hs)(CPURISCVState *env,
+                             target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    uint8_t shamt = rs2 & 0x0F;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t res = e1 >> shamt;
+        rd = INSERT16(rd, (uint16_t)res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRAI.W - Packed 32-bit arithmetic shift right immediate (RV64 only)
+ * For each word: rd[i] = (int32_t)rs1[i] >> imm
+ */
+uint64_t HELPER(psrai_w)(CPURISCVState *env, uint64_t rs1, uint64_t imm)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    uint8_t shamt = imm & 0x1F;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t res = e1 >> shamt;
+        rd = INSERT32(rd, (uint32_t)res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRA.WS - Packed 32-bit arithmetic shift right from register (RV64 only)
+ * For each word: rd[i] = (int32_t)rs1[i] >> rs2[5:0]
+ */
+uint64_t HELPER(psra_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    uint8_t shamt = rs2 & 0x1F;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t res = e1 >> shamt;
+        rd = INSERT32(rd, (uint32_t)res, i);
+    }
+    return rd;
+}
+
+/* Saturating shift operations */
+
+/**
+ * PSSLAI.H - Packed 16-bit saturating shift left immediate
+ * For each halfword: rd[i] = sat16(rs1[i] << imm)
+ */
+target_ulong HELPER(psslai_h)(CPURISCVState *env,
+                              target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+    uint8_t shamt = imm & 0x0F;
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int32_t shifted = (int32_t)e1 << shamt;
+        int16_t res = signed_saturate_h(shifted, &sat);
+        rd = INSERT16(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSSLAI.W - Packed 32-bit saturating shift left immediate (RV64 only)
+ * For each word: rd[i] = sat32(rs1[i] << imm)
+ */
+uint64_t HELPER(psslai_w)(CPURISCVState *env, uint64_t rs1, uint64_t imm)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    int sat = 0;
+    uint8_t shamt = imm & 0x1F;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int64_t shifted = (int64_t)e1 << shamt;
+        int32_t res = signed_saturate_w(shifted, &sat);
+        rd = INSERT32(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * SSLAL - 32-bit scalar saturating shift left immediate
+ */
+uint32_t HELPER(sslai)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    int32_t a = (int32_t)rs1;
+    uint8_t shamt = imm & 0x1F;
+    int64_t shifted = (int64_t)a << shamt;
+    int sat = 0;
+    int32_t res = signed_saturate_w(shifted, &sat);
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return (uint32_t)res;
+}
+
+/* Rounding shift operations */
+
+/**
+ * PSRARI.H - Packed 16-bit arithmetic shift right with rounding (immediate)
+ * For each halfword: rd[i] = round((int16_t)rs1[i] >> imm)
+ */
+target_ulong HELPER(psrari_h)(CPURISCVState *env,
+                              target_ulong rs1, target_ulong imm)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    uint8_t shamt = imm & 0x0F;
+
+    if (shamt == 0) {
+        return rs1;
+    }
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int32_t rounded = ((e1 >> (shamt - 1)) + 1) >> 1;
+        rd = INSERT16(rd, (int16_t)rounded, i);
+    }
+    return rd;
+}
+
+/**
+ * PSRARI.W - Packed 32-bit arithmetic shift right
+ * with rounding (immediate) (RV64 only)
+ * For each word: rd[i] = round((int32_t)rs1[i] >> imm)
+ */
+uint64_t HELPER(psrari_w)(CPURISCVState *env, uint64_t rs1, uint64_t imm)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    uint8_t shamt = imm & 0x1F;
+
+    if (shamt == 0) {
+        return rs1;
+    }
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int64_t rounded = ((e1 >> (shamt - 1)) + 1) >> 1;
+        rd = INSERT32(rd, (int32_t)rounded, i);
+    }
+    return rd;
+}
+
+/**
+ * SRARI_32 - 32-bit scalar arithmetic shift right with rounding
+ */
+uint32_t HELPER(srari_32)(CPURISCVState *env, uint32_t rs1, uint32_t imm)
+{
+    int32_t a = (int32_t)rs1;
+    uint8_t shamt = imm & 0x1F;
+
+    if (shamt == 0) {
+        return rs1;
+    }
+
+    return (uint32_t)(((a >> (shamt - 1)) + 1) >> 1);
+}
+
+/**
+ * SRARI_64 - 64-bit scalar arithmetic shift right with rounding
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
+    return (uint64_t)(((a >> (shamt - 1)) + 1) >> 1);
+}
+
+/* Variable shift operations (with saturation and rounding) */
+
+/**
+ * PSSHA.HS - Packed 16-bit variable shift with saturation
+ * Positive shift left (saturating), negative shift right (non-saturating)
+ */
+target_ulong HELPER(pssha_hs)(CPURISCVState *env,
+                              target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);  /* rs2[7:0] as signed */
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t res;
+
+        if (shamt >= 0) {
+            /* Left shift with saturation */
+            int32_t shifted = (int32_t)e1 << shamt;
+            res = signed_saturate_h(shifted, &sat);
+        } else {
+            /* Right shift (no saturation) */
+            int right = -shamt;
+            if (right >= 16) {
+                res = (e1 < 0) ? -1 : 0;
+            } else {
+                res = e1 >> right;
+            }
+        }
+
+        rd = INSERT16(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSSHA.WS - Packed 32-bit variable shift with saturation (RV64 only)
+ * Positive shift left (saturating), negative shift right (non-saturating)
+ */
+uint64_t HELPER(pssha_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t res;
+
+        if (shamt >= 0) {
+            int64_t shifted = (int64_t)e1 << shamt;
+            res = signed_saturate_w(shifted, &sat);
+        } else {
+            int right = -shamt;
+            if (right >= 32) {
+                res = (e1 < 0) ? -1 : 0;
+            } else {
+                res = e1 >> right;
+            }
+        }
+
+        rd = INSERT32(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSSHAR.HS - Packed 16-bit variable shift with rounding and saturation
+ * Positive shift left (saturating), negative shift right (rounded)
+ */
+target_ulong HELPER(psshar_hs)(CPURISCVState *env,
+                               target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        int16_t res;
+
+        if (shamt >= 0) {
+            /* Left shift with saturation */
+            int32_t shifted = (int32_t)e1 << shamt;
+            res = signed_saturate_h(shifted, &sat);
+        } else {
+            /* Right shift with rounding */
+            int right = -shamt;
+            if (right >= 16) {
+                res = (e1 < 0) ? -1 : 0;
+            } else {
+                int32_t rounded = ((e1 >> (right - 1)) + 1) >> 1;
+                res = (int16_t)rounded;
+            }
+        }
+
+        rd = INSERT16(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * PSSHAR.WS - Packed 32-bit variable shift with
+ * rounding and saturation (RV64 only)
+ * Positive shift left (saturating), negative shift right (rounded)
+ */
+uint64_t HELPER(psshar_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+    int sat = 0;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        int32_t res;
+
+        if (shamt >= 0) {
+            int64_t shifted = (int64_t)e1 << shamt;
+            res = signed_saturate_w(shifted, &sat);
+        } else {
+            int right = -shamt;
+            if (right >= 32) {
+                res = (e1 < 0) ? -1 : 0;
+            } else {
+                int64_t rounded = ((e1 >> (right - 1)) + 1) >> 1;
+                res = (int32_t)rounded;
+            }
+        }
+
+        rd = INSERT32(rd, res, i);
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return rd;
+}
+
+/**
+ * SSHA - 32-bit scalar variable shift with saturation
+ */
+uint32_t HELPER(ssha)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+    int sat = 0;
+    int32_t res;
+
+    if (shamt >= 0) {
+        int64_t shifted = (int64_t)a << shamt;
+        res = signed_saturate_w(shifted, &sat);
+    } else {
+        int right = -shamt;
+        if (right >= 32) {
+            res = (a < 0) ? -1 : 0;
+        } else {
+            res = a >> right;
+        }
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return (uint32_t)res;
+}
+
+/**
+ * SSHAR - 32-bit scalar variable shift with rounding and saturation
+ */
+uint32_t HELPER(sshar)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+    int sat = 0;
+    int32_t res;
+
+    if (shamt >= 0) {
+        int64_t shifted = (int64_t)a << shamt;
+        res = signed_saturate_w(shifted, &sat);
+    } else {
+        int right = -shamt;
+        if (right >= 32) {
+            res = (a < 0) ? -1 : 0;
+        } else {
+            int64_t rounded = ((a >> (right - 1)) + 1) >> 1;
+            res = (int32_t)rounded;
+        }
+    }
+
+    if (sat) {
+        env->vxsat = 1;
+    }
+    return (uint32_t)res;
+}
+
+/**
+ * SHA - 64-bit scalar variable shift
+ */
+uint64_t HELPER(sha)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int64_t a = (int64_t)rs1;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    if (shamt >= 0) {
+        return (uint64_t)(a << shamt);
+    } else {
+        int right = -shamt;
+        if (right >= 64) {
+            return (a < 0) ? (uint64_t)-1 : 0;
+        } else {
+            return (uint64_t)(a >> right);
+        }
+    }
+}
+
+/**
+ * SHAR - 64-bit scalar variable shift with rounding
+ */
+uint64_t HELPER(shar)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int64_t a = (int64_t)rs1;
+    int8_t shamt = (int8_t)(rs2 & 0xFF);
+
+    if (shamt >= 0) {
+        return (uint64_t)(a << shamt);
+    } else {
+        int right = -shamt;
+        if (right >= 64) {
+            return (a < 0) ? (uint64_t)-1 : 0;
+        } else {
+            __int128_t rounded = ((__int128_t)a >> (right - 1)) + 1;
+            return (uint64_t)((int64_t)(rounded >> 1));
+        }
+    }
+}
-- 
2.34.1


