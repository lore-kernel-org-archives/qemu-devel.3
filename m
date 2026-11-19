Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1292606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwox-0006xu-Gi; Thu, 19 Nov 2026 02:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoZ-0006vQ-At; Thu, 19 Nov 2026 02:44:17 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoU-0001jL-21; Thu, 19 Nov 2026 02:44:14 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S11;
 Thu, 19 Nov 2026 15:44:04 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 09/20] target/riscv: Add packed SIMD pack,
 merge and count-leading instructions
Date: Thu, 19 Nov 2026 07:43:29 +0000
Message-ID: <20261119074345.866125-10-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S11
X-Coremail-Antispam: 1UD129KBjvAXoW3CrWkJF17Aw48uryUJrWrXwb_yoW8JF4xWo
 Z3Cr15ZryrGry5X3sxCw48Xwn7ZrWIvan5Gr4rZw17Was7Xr1xWr1Dt34UZw1xXry5trW3
 Xa9ak3WYy3WSgwnrn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement packed pairing, sign-extension, reversal, zip and unzip,
shift-and-merge, narrowing clipping, and count-leading-sign operations.
Cover the supported element widths and signed and unsigned clipping
variants. Add the associated decode entries, translators and helpers.

Note that the narrowing clipping instructions combine elements from two
source registers and clamp each result to the destination element range.
They set vxsat when saturation occurs.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       |  41 ++++++
 target/riscv/insn32.decode                  |  42 ++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  57 ++++++++
 target/riscv/tcg/psimd_helper.c             | 152 ++++++++++++++++++++
 4 files changed, 292 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index bd1a03257a..4f13c7753d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1558,3 +1558,44 @@ DEF_HELPER_3(predsum_hs, tl, env, tl, tl)
 DEF_HELPER_3(predsumu_hs, tl, env, tl, tl)
 DEF_HELPER_3(predsum_ws, i64, env, i64, i64)
 DEF_HELPER_3(predsumu_ws, i64, env, i64, i64)
+
+/* Packed SIMD - Pack, Unpack, and Merge Operations */
+DEF_HELPER_3(ppaire_b, tl, env, tl, tl)
+DEF_HELPER_3(ppaireo_b, tl, env, tl, tl)
+DEF_HELPER_3(ppairoe_b, tl, env, tl, tl)
+DEF_HELPER_3(ppairo_b, tl, env, tl, tl)
+DEF_HELPER_3(ppaire_h, i64, env, i64, i64)
+DEF_HELPER_3(ppaireo_h, tl, env, tl, tl)
+DEF_HELPER_3(ppairoe_h, tl, env, tl, tl)
+DEF_HELPER_3(ppairo_h, tl, env, tl, tl)
+DEF_HELPER_3(ppaireo_w, i64, env, i64, i64)
+DEF_HELPER_3(ppairoe_w, i64, env, i64, i64)
+DEF_HELPER_3(ppairo_w, i64, env, i64, i64)
+DEF_HELPER_2(psext_h_b, tl, env, tl)
+DEF_HELPER_2(psext_w_b, i64, env, i64)
+DEF_HELPER_2(psext_w_h, i64, env, i64)
+DEF_HELPER_2(rev, tl, env, tl)
+DEF_HELPER_2(rev16, i64, env, i64)
+DEF_HELPER_3(zip8p, i64, env, i64, i64)
+DEF_HELPER_3(zip8hp, i64, env, i64, i64)
+DEF_HELPER_3(unzip8p, i64, env, i64, i64)
+DEF_HELPER_3(unzip8hp, i64, env, i64, i64)
+DEF_HELPER_3(zip16p, i64, env, i64, i64)
+DEF_HELPER_3(zip16hp, i64, env, i64, i64)
+DEF_HELPER_3(unzip16p, i64, env, i64, i64)
+DEF_HELPER_3(unzip16hp, i64, env, i64, i64)
+DEF_HELPER_4(slx, tl, env, tl, tl, tl)
+DEF_HELPER_4(srx, tl, env, tl, tl, tl)
+DEF_HELPER_4(mvm, tl, env, tl, tl, tl)
+DEF_HELPER_4(mvmn, tl, env, tl, tl, tl)
+DEF_HELPER_4(merge, tl, env, tl, tl, tl)
+DEF_HELPER_3(pnclipp_b, i64, env, i64, i64)
+DEF_HELPER_3(pnclipup_b, i64, env, i64, i64)
+DEF_HELPER_3(pnclipp_h, i64, env, i64, i64)
+DEF_HELPER_3(pnclipup_h, i64, env, i64, i64)
+DEF_HELPER_3(pnclipp_w, i64, env, i64, i64)
+DEF_HELPER_3(pnclipup_w, i64, env, i64, i64)
+
+/* Packed SIMD - Count Leading Operations */
+DEF_HELPER_2(cls, tl, env, tl)
+DEF_HELPER_2(clsw, i64, env, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index edb8f03658..e4eb8d678c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1309,3 +1309,45 @@ predsum_hs   1001100 ..... ..... 100 ..... 0011011 @r
 predsumu_hs  1011100 ..... ..... 100 ..... 0011011 @r
 predsum_ws   1001101 ..... ..... 100 ..... 0011011 @r
 predsumu_ws  1011101 ..... ..... 100 ..... 0011011 @r
+
+# Packed SIMD - Pack, Unpack, and Merge Operations
+ppaire_b    1000000 ..... ..... 100 ..... 0111011 @r
+ppaireo_b   1001000 ..... ..... 100 ..... 0111011 @r
+ppairoe_b   1010000 ..... ..... 100 ..... 0111011 @r
+ppairo_b    1011000 ..... ..... 100 ..... 0111011 @r
+ppaireo_h   1001001 ..... ..... 100 ..... 0111011 @r
+ppairoe_h   1010001 ..... ..... 100 ..... 0111011 @r
+ppairo_h    1011001 ..... ..... 100 ..... 0111011 @r
+ppaire_h    1000001 ..... ..... 100 ..... 0111011 @r
+ppaireo_w   1001011 ..... ..... 100 ..... 0111011 @r
+ppairoe_w   1010011 ..... ..... 100 ..... 0111011 @r
+ppairo_w    1011011 ..... ..... 100 ..... 0111011 @r
+psext_h_b   1110000 00100 ..... 010 ..... 0011011 @r2
+psext_w_b   1110001 00100 ..... 010 ..... 0011011 @r2
+psext_w_h   1110001 00101 ..... 010 ..... 0011011 @r2
+rev_32      01101 0011111 ..... 101 ..... 0010011 @r2
+rev_64      01101 0111111 ..... 101 ..... 0010011 @r2
+rev16       01101 0110000 ..... 101 ..... 0010011 @r2
+zip8p       1111000 ..... ..... 010 ..... 0111011 @r
+zip8hp      1111010 ..... ..... 010 ..... 0111011 @r
+unzip8p     1110000 ..... ..... 010 ..... 0111011 @r
+unzip8hp    1110010 ..... ..... 010 ..... 0111011 @r
+zip16p      1111001 ..... ..... 010 ..... 0111011 @r
+zip16hp     1111011 ..... ..... 010 ..... 0111011 @r
+unzip16p    1110001 ..... ..... 010 ..... 0111011 @r
+unzip16hp   1110011 ..... ..... 010 ..... 0111011 @r
+slx         1000111 ..... ..... 001 ..... 0111011 @r
+srx         1010111 ..... ..... 001 ..... 0111011 @r
+mvm         1010100 ..... ..... 001 ..... 0111011 @r
+mvmn        1010101 ..... ..... 001 ..... 0111011 @r
+merge       1010110 ..... ..... 001 ..... 0111011 @r
+pnclipp_b   1100000 ..... ..... 010 ..... 0111011 @r
+pnclipup_b  1000000 ..... ..... 010 ..... 0111011 @r
+pnclipp_h   1100001 ..... ..... 010 ..... 0111011 @r
+pnclipup_h  1000001 ..... ..... 010 ..... 0111011 @r
+pnclipp_w   1100011 ..... ..... 010 ..... 0111011 @r
+pnclipup_w  1000011 ..... ..... 010 ..... 0111011 @r
+
+# Packed SIMD - Count Leading Operations
+cls    01100 0000011 ..... 001 ..... 0010011 @r2
+clsw   01100 0000011 ..... 001 ..... 0011011 @r2
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
index 726707b295..2c9a34b9a7 100644
--- a/target/riscv/tcg/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -672,3 +672,60 @@ GEN_SIMD_TRANS(predsum_hs)
 GEN_SIMD_TRANS(predsumu_hs)
 GEN_SIMD_TRANS_64(predsum_ws)
 GEN_SIMD_TRANS_64(predsumu_ws)
+
+/* Packed SIMD - Pack, Unpack, and Merge Operations */
+GEN_SIMD_TRANS(ppaire_b)
+GEN_SIMD_TRANS(ppaireo_b)
+GEN_SIMD_TRANS(ppairoe_b)
+GEN_SIMD_TRANS(ppairo_b)
+GEN_SIMD_TRANS_64(ppaire_h)
+GEN_SIMD_TRANS(ppaireo_h)
+GEN_SIMD_TRANS(ppairoe_h)
+GEN_SIMD_TRANS(ppairo_h)
+GEN_SIMD_TRANS_64(ppaireo_w)
+GEN_SIMD_TRANS_64(ppairoe_w)
+GEN_SIMD_TRANS_64(ppairo_w)
+GEN_SIMD_TRANS_R1(psext_h_b)
+GEN_SIMD_TRANS_R1_64(psext_w_b)
+GEN_SIMD_TRANS_R1_64(psext_w_h)
+#if defined(TARGET_RISCV32)
+static bool trans_rev_32(DisasContext *ctx, arg_rev_32 * a)
+{
+    REQUIRE_32BIT(ctx);
+    GEN_SIMD_TRANS_R1_BODY(rev, false);
+}
+
+GEN_SIMD_TRANS_UNAVAILABLE_64(rev_64)
+#else
+GEN_SIMD_TRANS_UNAVAILABLE_32(rev_32)
+
+static bool trans_rev_64(DisasContext *ctx, arg_rev_64 * a)
+{
+    REQUIRE_64BIT(ctx);
+    GEN_SIMD_TRANS_R1_BODY(rev, false);
+}
+#endif
+GEN_SIMD_TRANS_R1_64(rev16)
+GEN_SIMD_TRANS_64(zip8p)
+GEN_SIMD_TRANS_64(zip8hp)
+GEN_SIMD_TRANS_64(unzip8p)
+GEN_SIMD_TRANS_64(unzip8hp)
+GEN_SIMD_TRANS_64(zip16p)
+GEN_SIMD_TRANS_64(zip16hp)
+GEN_SIMD_TRANS_64(unzip16p)
+GEN_SIMD_TRANS_64(unzip16hp)
+GEN_SIMD_TRANS_ACC(slx)
+GEN_SIMD_TRANS_ACC(srx)
+GEN_SIMD_TRANS_ACC(mvm)
+GEN_SIMD_TRANS_ACC(mvmn)
+GEN_SIMD_TRANS_ACC(merge)
+GEN_SIMD_TRANS_64_VXSAT(pnclipp_b)
+GEN_SIMD_TRANS_64_VXSAT(pnclipup_b)
+GEN_SIMD_TRANS_64_VXSAT(pnclipp_h)
+GEN_SIMD_TRANS_64_VXSAT(pnclipup_h)
+GEN_SIMD_TRANS_64_VXSAT(pnclipp_w)
+GEN_SIMD_TRANS_64_VXSAT(pnclipup_w)
+
+/* Packed SIMD - Count Leading Operations */
+GEN_SIMD_TRANS_R1(cls)
+GEN_SIMD_TRANS_R1_64(clsw)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index a1e4fb64ef..9bcf94c727 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2472,3 +2472,155 @@ GEN_PSIMD_REDSUM(predsum_ws, uint64_t, int64_t, int32_t,
                  EXTRACT32, ELEMS_W, (int64_t)rs2)
 GEN_PSIMD_REDSUM(predsumu_ws, uint64_t, uint64_t, uint32_t,
                  EXTRACT32, ELEMS_W, rs2)
+
+/* Packing/unpacking operations */
+
+GEN_PSIMD_PAIR_PACK(ppaire_b, target_ulong, uint16_t,
+                    EXTRACT16, INSERT16, ELEMS_H, 0x00ff, 8,
+                    PSIMD_PAIR_LO, PSIMD_PAIR_LO)
+GEN_PSIMD_PAIR_PACK(ppaireo_b, target_ulong, uint16_t,
+                    EXTRACT16, INSERT16, ELEMS_H, 0x00ff, 8,
+                    PSIMD_PAIR_HI, PSIMD_PAIR_LO)
+GEN_PSIMD_PAIR_PACK(ppairoe_b, target_ulong, uint16_t,
+                    EXTRACT16, INSERT16, ELEMS_H, 0x00ff, 8,
+                    PSIMD_PAIR_LO, PSIMD_PAIR_HI)
+GEN_PSIMD_PAIR_PACK(ppairo_b, target_ulong, uint16_t,
+                    EXTRACT16, INSERT16, ELEMS_H, 0x00ff, 8,
+                    PSIMD_PAIR_HI, PSIMD_PAIR_HI)
+
+GEN_PSIMD_PAIR_PACK(ppaire_h, uint64_t, uint32_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 0x0000ffff, 16,
+                    PSIMD_PAIR_LO, PSIMD_PAIR_LO)
+GEN_PSIMD_PAIR_PACK(ppaireo_h, target_ulong, uint32_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 0x0000ffff, 16,
+                    PSIMD_PAIR_HI, PSIMD_PAIR_LO)
+GEN_PSIMD_PAIR_PACK(ppairoe_h, target_ulong, uint32_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 0x0000ffff, 16,
+                    PSIMD_PAIR_LO, PSIMD_PAIR_HI)
+GEN_PSIMD_PAIR_PACK(ppairo_h, target_ulong, uint32_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 0x0000ffff, 16,
+                    PSIMD_PAIR_HI, PSIMD_PAIR_HI)
+
+GEN_PSIMD_PAIR_WORD(ppaireo_w, 0, 1)
+GEN_PSIMD_PAIR_WORD(ppairoe_w, 1, 0)
+GEN_PSIMD_PAIR_WORD(ppairo_w, 1, 1)
+
+GEN_PSIMD_SIGN_EXTEND(psext_h_b, target_ulong, int8_t, int16_t,
+                      EXTRACT8, INSERT16, ELEMS_H, 2)
+GEN_PSIMD_SIGN_EXTEND(psext_w_b, uint64_t, int8_t, int32_t,
+                      EXTRACT8, INSERT32, ELEMS_W, 4)
+GEN_PSIMD_SIGN_EXTEND(psext_w_h, uint64_t, int16_t, int32_t,
+                      EXTRACT16, INSERT32, ELEMS_W, 2)
+
+/**
+ * REV - Reverse the bit order of the full XLEN-wide value
+ */
+target_ulong HELPER(rev)(CPURISCVState *env, target_ulong rs1)
+{
+    target_ulong rd = 0;
+
+    for (int i = 0; i < TARGET_LONG_BITS; i++) {
+        rd = (rd << 1) | (rs1 & 1);
+        rs1 >>= 1;
+    }
+
+    return rd;
+}
+
+/**
+ * REV16 - Reverse the order of 16-bit chunks (RV64 only)
+ */
+uint64_t HELPER(rev16)(CPURISCVState *env, uint64_t rs1)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint16_t chunk = EXTRACT16(rs1, i);
+        rd = (rd << 16) | chunk;
+    }
+
+    return rd;
+}
+
+GEN_PSIMD_ZIP(zip8p, uint8_t, EXTRACT8, 4, 8, 3)
+GEN_PSIMD_ZIP(zip8hp, uint8_t, EXTRACT8, 4, 8, 7)
+GEN_PSIMD_UNZIP(unzip8p, EXTRACT8, 4, 8, 0)
+GEN_PSIMD_UNZIP(unzip8hp, EXTRACT8, 4, 8, 1)
+
+GEN_PSIMD_ZIP(zip16p, uint16_t, EXTRACT16, 2, 16, 1)
+GEN_PSIMD_ZIP(zip16hp, uint16_t, EXTRACT16, 2, 16, 3)
+GEN_PSIMD_UNZIP(unzip16p, EXTRACT16, 2, 16, 0)
+GEN_PSIMD_UNZIP(unzip16hp, EXTRACT16, 2, 16, 1)
+
+/* Merge and mask operations */
+
+/**
+ * SLX - Shift left extended (concatenate rd and rs1, shift left, take upper)
+ */
+target_ulong HELPER(slx)(CPURISCVState *env, target_ulong rs1,
+                         target_ulong rs2, target_ulong rd)
+{
+    int shamt = (TARGET_LONG_BITS == 32) ? (rs2 & 0x1F) : (rs2 & 0x3F);
+    target_ulong xrs1 = 0;
+    target_ulong xrd = 0;
+
+    if (shamt == 0) {
+        xrd = rd;
+    } else if (shamt <= TARGET_LONG_BITS) {
+        xrs1 = rs1 >> (TARGET_LONG_BITS - shamt);
+        xrd = (rd << shamt) + xrs1;
+    } else {
+        xrd = rs1 << (shamt - TARGET_LONG_BITS);
+    }
+
+    return xrd;
+}
+
+/**
+ * SRX - Shift right extended (concatenate rs1 and rd, shift right, take lower)
+ */
+target_ulong HELPER(srx)(CPURISCVState *env, target_ulong rs1,
+                         target_ulong rs2, target_ulong rd)
+{
+    int shamt = (TARGET_LONG_BITS == 32) ? (rs2 & 0x1F) : (rs2 & 0x3F);
+    target_ulong xrs1 = 0;
+    target_ulong xrd = 0;
+
+    if (shamt == 0) {
+        xrd = rd;
+    } else if (shamt <= TARGET_LONG_BITS) {
+        xrs1 = rs1 << (TARGET_LONG_BITS - shamt);
+        xrd = (rd >> shamt) + xrs1;
+    } else {
+        xrd = rs1 >> (shamt - TARGET_LONG_BITS);
+    }
+
+    return xrd;
+}
+
+GEN_PSIMD_BIT_SELECT(mvm, rs2, rs1, rd)
+GEN_PSIMD_BIT_SELECT(mvmn, rs2, rd, rs1)
+GEN_PSIMD_BIT_SELECT(merge, rd, rs2, rs1)
+
+GEN_PSIMD_NCLIP_PACK(pnclipp_b, int16_t, int8_t,
+                     EXTRACT16, INSERT8, 4, signed_saturate_b)
+GEN_PSIMD_NCLIP_PACK(pnclipup_b, uint16_t, uint8_t,
+                     EXTRACT16, INSERT8, 4, unsigned_saturate_b)
+GEN_PSIMD_NCLIP_PACK(pnclipp_h, int32_t, int16_t,
+                     EXTRACT32, INSERT16, 2, signed_saturate_h)
+GEN_PSIMD_NCLIP_PACK(pnclipup_h, uint32_t, uint16_t,
+                     EXTRACT32, INSERT16, 2, unsigned_saturate_h)
+GEN_PSIMD_NCLIP_PACK(pnclipp_w, int64_t, int32_t,
+                     EXTRACT64, INSERT32_64, 1, signed_saturate_w)
+GEN_PSIMD_NCLIP_PACK(pnclipup_w, uint64_t, uint32_t,
+                     EXTRACT64, INSERT32_64, 1, unsigned_saturate_w)
+
+/* Count leading operations */
+
+#if TARGET_LONG_BITS == 64
+GEN_PSIMD_CLS(cls, target_ulong, uint64_t, clrsb64)
+#else
+GEN_PSIMD_CLS(cls, target_ulong, uint32_t, clrsb32)
+#endif
+
+GEN_PSIMD_CLS(clsw, uint64_t, uint32_t, clrsb32)
-- 
2.53.0


