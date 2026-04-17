Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A8BF4368B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgjU-0001DX-F4; Fri, 17 Apr 2026 06:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjN-00015O-8P; Fri, 17 Apr 2026 06:47:27 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wDgjJ-0007za-FI; Fri, 17 Apr 2026 06:47:24 -0400
Received: from Huawei.localdomain (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3H2ulD+JpLDmSDQ--.804S9;
 Fri, 17 Apr 2026 18:47:15 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: xiaoou@iscas.ac.cn,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/14] target/riscv: rvp: add horizontal reduction, pack,
 merge and cout leading operations
Date: Fri, 17 Apr 2026 18:46:44 +0800
Message-Id: <20260417104652.17857-8-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3H2ulD+JpLDmSDQ--.804S9
X-Coremail-Antispam: 1UD129KBjvAXoWftFWxXrWkurWUWrW5ZryDAwb_yoW8ur4rXo
 Z3Gw15A34fGr1fZ34kCw47Xr17ZrZFvw1kWr4rursruas7Wr1agF15t3W8Aa4xGrWSyrW5
 X39aqF15J3W3u3sxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOU7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
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
 target/riscv/helper.h                   |  46 ++
 target/riscv/insn32.decode              |  44 ++
 target/riscv/insn_trans/trans_rvp.c.inc |  44 ++
 target/riscv/psimd_helper.c             | 619 ++++++++++++++++++++++++
 4 files changed, 753 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fc66712570..78ae034331 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1497,3 +1497,49 @@ DEF_HELPER_3(psas_wx, i64, env, i64, i64)
 DEF_HELPER_3(pssa_wx, i64, env, i64, i64)
 DEF_HELPER_3(paas_wx, i64, env, i64, i64)
 DEF_HELPER_3(pasa_wx, i64, env, i64, i64)
+
+/* Packed SIMD - Horizontal Reduction Operations */
+DEF_HELPER_3(predsum_bs, tl, env, tl, tl)
+DEF_HELPER_3(predsumu_bs, tl, env, tl, tl)
+DEF_HELPER_3(predsum_hs, tl, env, tl, tl)
+DEF_HELPER_3(predsumu_hs, tl, env, tl, tl)
+DEF_HELPER_3(predsum_ws, i64, env, i64, i64)
+DEF_HELPER_3(predsumu_ws, i64, env, i64, i64)
+
+/* Packed SIMD - Pack, Unpack, and Merge Operations */
+DEF_HELPER_3(ppaire_b, tl, env, tl, tl)
+DEF_HELPER_3(ppaireo_b, tl, env, tl, tl)
+DEF_HELPER_3(ppairoe_b, tl, env, tl, tl)
+DEF_HELPER_3(ppairo_b, tl, env, tl, tl)
+
+DEF_HELPER_3(ppaire_h, i64, env, i64, i64)
+DEF_HELPER_3(ppaireo_h, tl, env, tl, tl)
+DEF_HELPER_3(ppairoe_h, tl, env, tl, tl)
+DEF_HELPER_3(ppairo_h, tl, env, tl, tl)
+
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
+
+/* Packed SIMD - Count Leading Operations */
+DEF_HELPER_2(cls, tl, env, tl)
+DEF_HELPER_2(clsw, i64, env, i64)
+
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index ba003ed513..09bb69b302 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1277,3 +1277,47 @@ psas_wx    1001001 ..... ..... 110 ..... 0111011 @r
 pssa_wx    1001011 ..... ..... 110 ..... 0111011 @r
 paas_wx    1001101 ..... ..... 110 ..... 0111011 @r
 pasa_wx    1001111 ..... ..... 110 ..... 0111011 @r
+
+# Packed SIMD - Horizontal Reduction Operations
+predsum_bs   1001110 ..... ..... 100 ..... 0011011 @r
+predsumu_bs  1011110 ..... ..... 100 ..... 0011011 @r
+predsum_hs   1001100 ..... ..... 100 ..... 0011011 @r
+predsumu_hs  1011100 ..... ..... 100 ..... 0011011 @r
+predsum_ws   1001101 ..... ..... 100 ..... 0011011 @r
+predsumu_ws  1011101 ..... ..... 100 ..... 0011011 @r
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
+rev         01101 0111111 ..... 101 ..... 0010011 @r2
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
+
+# Packed SIMD - Count Leading Operations
+cls    01100 0000011 ..... 001 ..... 0010011 @r2
+clsw   01100 0000011 ..... 001 ..... 0011011 @r2
+
diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
index b24a8ef7c2..fc6254b395 100644
--- a/target/riscv/insn_trans/trans_rvp.c.inc
+++ b/target/riscv/insn_trans/trans_rvp.c.inc
@@ -668,3 +668,47 @@ GEN_SIMD_TRANS_64(psas_wx)
 GEN_SIMD_TRANS_64(pssa_wx)
 GEN_SIMD_TRANS_64(paas_wx)
 GEN_SIMD_TRANS_64(pasa_wx)
+
+/* Packed SIMD - Horizontal Reduction Operations */
+GEN_SIMD_TRANS(predsum_bs)
+GEN_SIMD_TRANS(predsumu_bs)
+GEN_SIMD_TRANS(predsum_hs)
+GEN_SIMD_TRANS(predsumu_hs)
+GEN_SIMD_TRANS_64(predsum_ws)
+GEN_SIMD_TRANS_64(predsumu_ws)
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
+GEN_SIMD_TRANS_R1(rev)
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
+
+/* Packed SIMD - Count Leading Operations */
+GEN_SIMD_TRANS_R1(cls)
+GEN_SIMD_TRANS_R1_64(clsw)
+
diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
index e48c9897ae..4080aab234 100644
--- a/target/riscv/psimd_helper.c
+++ b/target/riscv/psimd_helper.c
@@ -2997,3 +2997,622 @@ uint64_t HELPER(pasa_wx)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     }
     return rd;
 }
+
+/* Horizontal sum operations */
+
+/**
+ * PREDSUM.BS - Signed reduction sum of bytes
+ * rd = rs2 + sum(sign_extend(rs1[i]))
+ */
+target_ulong HELPER(predsum_bs)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    int64_t sum = (int64_t)(int32_t)rs2;
+    int elems = ELEMS_B(rs1);
+
+    for (int i = 0; i < elems; i++) {
+        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
+        sum += e1;
+    }
+
+    return (target_ulong)sum;
+}
+
+/**
+ * PREDSUMU.BS - Unsigned reduction sum of bytes
+ * rd = rs2 + sum(zero_extend(rs1[i]))
+ */
+target_ulong HELPER(predsumu_bs)(CPURISCVState *env,
+                                 target_ulong rs1, target_ulong rs2)
+{
+    uint64_t sum = rs2;
+    int elems = ELEMS_B(rs1);
+
+    for (int i = 0; i < elems; i++) {
+        uint8_t e1 = EXTRACT8(rs1, i);
+        sum += e1;
+    }
+
+    return (target_ulong)sum;
+}
+
+/**
+ * PREDSUM.HS - Signed reduction sum of halfwords
+ * rd = rs2 + sum(sign_extend(rs1[i]))
+ */
+target_ulong HELPER(predsum_hs)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    int64_t sum = (int64_t)(int32_t)rs2;
+    int elems = ELEMS_H(rs1);
+
+    for (int i = 0; i < elems; i++) {
+        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
+        sum += e1;
+    }
+
+    return (target_ulong)sum;
+}
+
+/**
+ * PREDSUMU.HS - Unsigned reduction sum of halfwords
+ * rd = rs2 + sum(zero_extend(rs1[i]))
+ */
+target_ulong HELPER(predsumu_hs)(CPURISCVState *env,
+                                 target_ulong rs1, target_ulong rs2)
+{
+    uint64_t sum = rs2;
+    int elems = ELEMS_H(rs1);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        sum += e1;
+    }
+
+    return (target_ulong)sum;
+}
+
+/**
+ * PREDSUM.WS - Signed reduction sum of words (RV64 only)
+ * rd = rs2 + sum(sign_extend(rs1[i]))
+ */
+uint64_t HELPER(predsum_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    int64_t sum = (int64_t)rs2;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
+        sum += e1;
+    }
+
+    return (uint64_t)sum;
+}
+
+/**
+ * PREDSUMU.WS - Unsigned reduction sum of words (RV64 only)
+ * rd = rs2 + sum(zero_extend(rs1[i]))
+ */
+uint64_t HELPER(predsumu_ws)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t sum = rs2;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        sum += e1;
+    }
+
+    return sum;
+}
+
+/* Packing/unpacking operations */
+
+/**
+ * PPAIRE.B - Pair low bytes of corresponding halfwords
+ * For each halfword: rd[i] = {rs2[i][7:0], rs1[i][7:0]}
+ */
+target_ulong HELPER(ppaire_b)(CPURISCVState *env,
+                               target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = ((e2 & 0x00FF) << 8) | (e1 & 0x00FF);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIREO.B - Pair high byte of rs2 with low byte of rs1
+ * For each halfword: rd[i] = {rs2[i][15:8], rs1[i][7:0]}
+ */
+target_ulong HELPER(ppaireo_b)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = ((e2 >> 8) << 8) | (e1 & 0x00FF);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIROE.B - Pair low byte of rs2 with high byte of rs1
+ * For each halfword: rd[i] = {rs2[i][7:0], rs1[i][15:8]}
+ */
+target_ulong HELPER(ppairoe_b)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = ((e2 & 0x00FF) << 8) | ((e1 >> 8) & 0x00FF);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIRO.B - Pair high bytes of corresponding halfwords
+ * For each halfword: rd[i] = {rs2[i][15:8], rs1[i][15:8]}
+ */
+target_ulong HELPER(ppairo_b)(CPURISCVState *env,
+                               target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        uint16_t e2 = EXTRACT16(rs2, i);
+        uint16_t res = ((e2 >> 8) << 8) | ((e1 >> 8) & 0x00FF);
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIRE.H - Pair low halfwords of corresponding words
+ * (RV64 only)
+ * For each word: rd[i] = {rs2[i][15:0], rs1[i][15:0]}
+ */
+uint64_t HELPER(ppaire_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    int elems = 2;
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = ((e2 & 0x0000FFFF) << 16) | (e1 & 0x0000FFFF);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIREO.H - Pair high halfword of rs2 with low halfword of rs1 (RV64 only)
+ */
+target_ulong HELPER(ppaireo_h)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = ((e2 >> 16) << 16) | (e1 & 0x0000FFFF);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIROE.H - Pair low halfword of rs2 with high halfword of rs1 (RV64 only)
+ */
+target_ulong HELPER(ppairoe_h)(CPURISCVState *env,
+                                target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = ((e2 & 0x0000FFFF) << 16) | ((e1 >> 16) & 0x0000FFFF);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIRO.H - Pair high halfwords of corresponding words (RV64 only)
+ */
+target_ulong HELPER(ppairo_h)(CPURISCVState *env,
+                               target_ulong rs1, target_ulong rs2)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_W(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint32_t e1 = EXTRACT32(rs1, i);
+        uint32_t e2 = EXTRACT32(rs2, i);
+        uint32_t res = ((e2 >> 16) << 16) | ((e1 >> 16) & 0x0000FFFF);
+        rd = INSERT32(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PPAIREO.W - Pair low word of rs2 with low word of rs1 (RV64 only)
+ */
+uint64_t HELPER(ppaireo_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    uint32_t e1 = EXTRACT32(rs1, 0);
+    uint32_t e2 = EXTRACT32(rs2, 1);
+    rd = ((uint64_t)e2 << 32) | e1;
+    return rd;
+}
+
+/**
+ * PPAIROE.W - Pair low word of rs2 with high word of rs1 (RV64 only)
+ */
+uint64_t HELPER(ppairoe_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    uint32_t e1 = EXTRACT32(rs1, 1);
+    uint32_t e2 = EXTRACT32(rs2, 0);
+    rd = ((uint64_t)e2 << 32) | e1;
+    return rd;
+}
+
+/**
+ * PPAIRO.W - Pair high word of rs2 with high word of rs1 (RV64 only)
+ */
+uint64_t HELPER(ppairo_w)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+    uint32_t e1 = EXTRACT32(rs1, 1);
+    uint32_t e2 = EXTRACT32(rs2, 1);
+    rd = ((uint64_t)e2 << 32) | e1;
+    return rd;
+}
+
+/**
+ * PSEXT.H.B - Sign-extend bytes to halfwords within each halfword
+ */
+target_ulong HELPER(psext_h_b)(CPURISCVState *env, target_ulong rs1)
+{
+    target_ulong rd = 0;
+    int elems = ELEMS_H(rd);
+
+    for (int i = 0; i < elems; i++) {
+        uint16_t e1 = EXTRACT16(rs1, i);
+        int8_t b0 = (int8_t)(e1 & 0xFF);
+        int16_t res = (int16_t)b0;
+        rd = INSERT16(rd, res, i);
+    }
+    return rd;
+}
+
+/**
+ * PSEXT.W.B - Sign-extend bytes to words (RV64 only)
+ */
+uint64_t HELPER(psext_w_b)(CPURISCVState *env, uint64_t rs1)
+{
+    uint64_t rd = 0;
+    int8_t b0 = (int8_t)EXTRACT8(rs1, 0);
+    int8_t b4 = (int8_t)EXTRACT8(rs1, 4);
+    uint32_t lo = (uint32_t)(int32_t)b0;
+    uint32_t hi = (uint32_t)(int32_t)b4;
+    rd = ((uint64_t)hi << 32) | lo;
+    return rd;
+}
+
+/**
+ * PSEXT.W.H - Sign-extend halfwords to words (RV64 only)
+ */
+uint64_t HELPER(psext_w_h)(CPURISCVState *env, uint64_t rs1)
+{
+    uint64_t rd = 0;
+    int16_t h0 = (int16_t)EXTRACT16(rs1, 0);
+    int16_t h2 = (int16_t)EXTRACT16(rs1, 2);
+    uint32_t lo = (uint32_t)(int32_t)h0;
+    uint32_t hi = (uint32_t)(int32_t)h2;
+    rd = ((uint64_t)hi << 32) | lo;
+    return rd;
+}
+
+/**
+ * REV - Reverse all bits
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
+ * REV16 - Reverse 16-bit chunks (RV64 only)
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
+/**
+ * ZIP8P - Interleave bytes from rs2 and rs1 (RV64 only)
+ * rd = {rs2[31:24], rs1[31:24], rs2[23:16], rs1[23:16],
+ *       rs2[15:8], rs1[15:8], rs2[7:0], rs1[7:0]}
+ */
+uint64_t HELPER(zip8p)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint8_t b1 = EXTRACT8(rs1, 3 - i);
+        uint8_t b2 = EXTRACT8(rs2, 3 - i);
+        rd = (rd << 16) | ((uint16_t)b2 << 8) | b1;
+    }
+
+    return rd;
+}
+
+/**
+ * ZIP8HP - Interleave high bytes from rs2 and rs1 (RV64 only)
+ */
+uint64_t HELPER(zip8hp)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint8_t b1 = EXTRACT8(rs1, 7 - i);
+        uint8_t b2 = EXTRACT8(rs2, 7 - i);
+        rd = (rd << 16) | ((uint16_t)b2 << 8) | b1;
+    }
+
+    return rd;
+}
+
+/**
+ * UNZIP8P - De-interleave bytes
+ * (RV64 only)
+ */
+uint64_t HELPER(unzip8p)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint64_t b1 = EXTRACT8(rs1, 2 * i) << 8 * i;
+        uint64_t b2 = EXTRACT8(rs2, 2 * i) << (32 + 8 * i);
+        rd = rd | b2 | b1;
+    }
+
+    return rd;
+}
+
+/**
+ * UNZIP8HP - De-interleave high bytes
+ * (RV64 only)
+ */
+uint64_t HELPER(unzip8hp)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 4; i++) {
+        uint64_t b1 = EXTRACT8(rs1, 2 * i + 1) << 8 * i;
+        uint64_t b2 = EXTRACT8(rs2, 2 * i + 1) << (32 + 8 * i);
+        rd = rd | b2 | b1;
+    }
+
+    return rd;
+}
+
+/**
+ * ZIP16P - Interleave halfwords from rs2 and rs1 (RV64 only)
+ */
+uint64_t HELPER(zip16p)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint16_t h1 = EXTRACT16(rs1, 1 - i);
+        uint16_t h2 = EXTRACT16(rs2, 1 - i);
+        rd = (rd << 32) | ((uint32_t)h2 << 16) | h1;
+    }
+
+    return rd;
+}
+
+/**
+ * ZIP16HP - Interleave high halfwords (RV64 only)
+ */
+uint64_t HELPER(zip16hp)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint16_t h1 = EXTRACT16(rs1, 3 - i);
+        uint16_t h2 = EXTRACT16(rs2, 3 - i);
+        rd = (rd << 32) | ((uint32_t)h2 << 16) | h1;
+    }
+
+    return rd;
+}
+
+/**
+ * UNZIP16P - De-interleave halfwords (RV64 only)
+ */
+uint64_t HELPER(unzip16p)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint64_t b1 = EXTRACT16(rs1, 2 * i) << 16 * i;
+        uint64_t b2 = EXTRACT16(rs2, 2 * i) << (32 + 16 * i);
+        rd = rd | b2 | b1;
+    }
+
+    return rd;
+}
+
+/**
+ * UNZIP16HP - De-interleave high halfwords (RV64 only)
+ */
+uint64_t HELPER(unzip16hp)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+{
+    uint64_t rd = 0;
+
+    for (int i = 0; i < 2; i++) {
+        uint64_t b1 = EXTRACT16(rs1, 2 * i + 1) << 16 * i;
+        uint64_t b2 = EXTRACT16(rs2, 2 * i + 1) << (32 + 16 * i);
+        rd = rd | b2 | b1;
+    }
+
+    return rd;
+}
+
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
+    if (shamt <= TARGET_LONG_BITS) {
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
+    if (shamt <= TARGET_LONG_BITS) {
+        xrs1 = rs1 << (TARGET_LONG_BITS - shamt);
+        xrd = (rd >> shamt) + xrs1;
+    } else {
+        xrd = rs1 >> (shamt - TARGET_LONG_BITS);
+    }
+
+    return xrd;
+}
+
+/**
+ * MVM - Move masked
+ * For each bit: rd[i] = rs2[i] ? rs1[i] : rd[i]
+ */
+target_ulong HELPER(mvm)(CPURISCVState *env, target_ulong rs1,
+                         target_ulong rs2, target_ulong rd)
+{
+    return (~rs2 & rd) | (rs2 & rs1);
+}
+
+/**
+ * MVMN - Move masked not
+ * For each bit: rd[i] = rs2[i] ? rd[i] : rs1[i]
+ */
+target_ulong HELPER(mvmn)(CPURISCVState *env, target_ulong rs1,
+                          target_ulong rs2, target_ulong rd)
+{
+    return (~rs2 & rs1) | (rs2 & rd);
+}
+
+/**
+ * MERGE - Merge
+ * For each bit: rd[i] = rd[i] ? rs2[i] : rs1[i]
+ */
+target_ulong HELPER(merge)(CPURISCVState *env, target_ulong rs1,
+                           target_ulong rs2, target_ulong rd)
+{
+    return (~rd & rs1) | (rd & rs2);
+}
+
+/* Count leading operations */
+
+/**
+ * CLS - Count leading redundant sign bits
+ */
+target_ulong HELPER(cls)(CPURISCVState *env, target_ulong rs1)
+{
+    target_long a = (target_long)rs1;
+    target_ulong cnt = 0;
+
+#if TARGET_LONG_BITS == 64
+    target_long lo_bound = 0xC000000000000000LL;
+    target_long hi_bound = 0x3FFFFFFFFFFFFFFFLL;
+#else
+    target_long lo_bound = 0xC0000000;
+    target_long hi_bound = 0x3FFFFFFF;
+#endif
+
+    while (cnt < TARGET_LONG_BITS - 1 && a >= lo_bound && a <= hi_bound) {
+        cnt++;
+        a <<= 1;
+    }
+
+    return cnt;
+}
+
+/**
+ * CLSW - Count leading redundant sign bits of low 32 bits (RV64)
+ */
+uint64_t HELPER(clsw)(CPURISCVState *env, uint64_t rs1)
+{
+    int32_t a = (int32_t)(rs1 & 0xFFFFFFFF);
+    int32_t lo_bound = 0xC0000000;
+    int32_t hi_bound = 0x3FFFFFFF;
+    int c = 0;
+
+    while (c < 31 && a >= lo_bound && a <= hi_bound) {
+        c++;
+        a <<= 1;
+    }
+
+    return c;
+}
-- 
2.34.1


