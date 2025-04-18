Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79817C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 08:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5gx4-0008Nb-M6; Fri, 18 Apr 2025 04:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1u5gx3-0008NS-Jj
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:19:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1u5gx0-0003Rz-9H
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:19:57 -0400
Received: from loongson.cn (unknown [223.64.28.203])
 by gateway (Coremail) with SMTP id _____8CxqmonCwJoJJrBAA--.60156S3;
 Fri, 18 Apr 2025 16:19:51 +0800 (CST)
Received: from lvm.. (unknown [223.64.28.203])
 by front1 (Coremail) with SMTP id qMiowMBxn8UfCwJoYSyJAA--.12831S5;
 Fri, 18 Apr 2025 16:19:50 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, bibo mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, qemu@hev.cc,
 WANG Rui <wangrui@loongson.cn>
Subject: [PATCH v4 3/3] target/loongarch: Guard 64-bit-only insn translation
 with TRANS64 macro
Date: Fri, 18 Apr 2025 16:21:03 +0800
Message-ID: <20250418082103.447780-4-wangrui@loongson.cn>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418082103.447780-1-wangrui@loongson.cn>
References: <20250418082103.447780-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8UfCwJoYSyJAA--.12831S5
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tw1fXF1Dtw1UKF4rZw4xuFX_yoW8JFWxAo
 WrZr4UJF4xXwn8urWYkr1kt34qvr1xZa98A3yUJw4UWF95Za1j9wn3Cw1vva13u3ykAFyU
 Ww4fK3Z5Ja1fXrn7l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch replaces uses of the generic TRANS macro with TRANS64 for
instructions that are only valid when 64-bit support is available.

This improves correctness and avoids potential assertion failures or
undefined behavior during translation on 32-bit-only configurations.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
---
 .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++----------
 .../tcg/insn_trans/trans_extra.c.inc          |  8 +++--
 .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
 .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
 .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
 target/loongarch/translate.h                  |  4 +++
 6 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 3d70d75941..77eeedbc42 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -74,38 +74,38 @@ TRANS(sc_w, ALL, gen_sc, MO_TESL)
 TRANS(ll_d, 64, gen_ll, MO_TEUQ)
 TRANS(sc_d, 64, gen_sc, MO_TEUQ)
 TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
 TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
 TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
 TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
 TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
 TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
 TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
 TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
 TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
 TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
+TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
 TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
+TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
 TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
+TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
 TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
+TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
 TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
+TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
 TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
+TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
 TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
+TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
 TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
+TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
 TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index eda3d6e561..298a80cff5 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -69,6 +69,10 @@ static bool trans_rdtimeh_w(DisasContext *ctx, arg_rdtimeh_w *a)
 
 static bool trans_rdtime_d(DisasContext *ctx, arg_rdtime_d *a)
 {
+    if (!avail_64(ctx)) {
+        return false;
+    }
+
     return gen_rdtime(ctx, a, 0, 0);
 }
 
@@ -100,8 +104,8 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
 TRANS(crc_w_b_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
 TRANS(crc_w_h_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
 TRANS(crc_w_w_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
-TRANS(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
+TRANS64(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
 TRANS(crcc_w_b_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
 TRANS(crcc_w_h_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
 TRANS(crcc_w_w_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
-TRANS(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
+TRANS64(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index ecbfe23b63..34cfab8879 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -233,11 +233,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
 TRANS(iocsrrd_b, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_b)
 TRANS(iocsrrd_h, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_h)
 TRANS(iocsrrd_w, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_w)
-TRANS(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
+TRANS64(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
 TRANS(iocsrwr_b, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_b)
 TRANS(iocsrwr_h, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_h)
 TRANS(iocsrwr_w, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_w)
-TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
+TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
diff --git a/target/loongarch/tcg/insn_trans/trans_shift.c.inc b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
index 377307785a..136c4c8455 100644
--- a/target/loongarch/tcg/insn_trans/trans_shift.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_shift.c.inc
@@ -78,7 +78,7 @@ TRANS(sra_w, ALL, gen_rrr, EXT_SIGN, EXT_NONE, EXT_SIGN, gen_sra_w)
 TRANS(sll_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sll_d)
 TRANS(srl_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_srl_d)
 TRANS(sra_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_sra_d)
-TRANS(rotr_w, 64, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
+TRANS(rotr_w, ALL, gen_rrr, EXT_ZERO, EXT_NONE, EXT_SIGN, gen_rotr_w)
 TRANS(rotr_d, 64, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_rotr_d)
 TRANS(slli_w, ALL, gen_rri_c, EXT_NONE, EXT_SIGN, tcg_gen_shli_tl)
 TRANS(slli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shli_tl)
@@ -86,5 +86,5 @@ TRANS(srli_w, ALL, gen_rri_c, EXT_ZERO, EXT_SIGN, tcg_gen_shri_tl)
 TRANS(srli_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_shri_tl)
 TRANS(srai_w, ALL, gen_rri_c, EXT_NONE, EXT_NONE, gen_sari_w)
 TRANS(srai_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_sari_tl)
-TRANS(rotri_w, 64, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
+TRANS(rotri_w, ALL, gen_rri_v, EXT_NONE, EXT_NONE, gen_rotr_w)
 TRANS(rotri_d, 64, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_rotri_tl)
diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index dff92772ad..a6f5b346bb 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -4853,9 +4853,9 @@ static bool gen_g2x(DisasContext *ctx, arg_vr_i *a, MemOp mop,
 TRANS(vinsgr2vr_b, LSX, gen_g2v, MO_8, tcg_gen_st8_i64)
 TRANS(vinsgr2vr_h, LSX, gen_g2v, MO_16, tcg_gen_st16_i64)
 TRANS(vinsgr2vr_w, LSX, gen_g2v, MO_32, tcg_gen_st32_i64)
-TRANS(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
+TRANS64(vinsgr2vr_d, LSX, gen_g2v, MO_64, tcg_gen_st_i64)
 TRANS(xvinsgr2vr_w, LASX, gen_g2x, MO_32, tcg_gen_st32_i64)
-TRANS(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
+TRANS64(xvinsgr2vr_d, LASX, gen_g2x, MO_64, tcg_gen_st_i64)
 
 static bool gen_v2g_vl(DisasContext *ctx, arg_rv_i *a, uint32_t oprsz, MemOp mop,
                        void (*func)(TCGv, TCGv_ptr, tcg_target_long))
@@ -4886,15 +4886,15 @@ static bool gen_x2g(DisasContext *ctx, arg_rv_i *a, MemOp mop,
 TRANS(vpickve2gr_b, LSX, gen_v2g, MO_8, tcg_gen_ld8s_i64)
 TRANS(vpickve2gr_h, LSX, gen_v2g, MO_16, tcg_gen_ld16s_i64)
 TRANS(vpickve2gr_w, LSX, gen_v2g, MO_32, tcg_gen_ld32s_i64)
-TRANS(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
+TRANS64(vpickve2gr_d, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
 TRANS(vpickve2gr_bu, LSX, gen_v2g, MO_8, tcg_gen_ld8u_i64)
 TRANS(vpickve2gr_hu, LSX, gen_v2g, MO_16, tcg_gen_ld16u_i64)
 TRANS(vpickve2gr_wu, LSX, gen_v2g, MO_32, tcg_gen_ld32u_i64)
-TRANS(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
+TRANS64(vpickve2gr_du, LSX, gen_v2g, MO_64, tcg_gen_ld_i64)
 TRANS(xvpickve2gr_w, LASX, gen_x2g, MO_32, tcg_gen_ld32s_i64)
-TRANS(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
+TRANS64(xvpickve2gr_d, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
 TRANS(xvpickve2gr_wu, LASX, gen_x2g, MO_32, tcg_gen_ld32u_i64)
-TRANS(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
+TRANS64(xvpickve2gr_du, LASX, gen_x2g, MO_64, tcg_gen_ld_i64)
 
 static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
                         uint32_t oprsz, MemOp mop)
@@ -4923,11 +4923,11 @@ static bool gvec_dupx(DisasContext *ctx, arg_vr *a, MemOp mop)
 TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
 TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
 TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
-TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
+TRANS64(vreplgr2vr_d, LSX, gvec_dup, MO_64)
 TRANS(xvreplgr2vr_b, LASX, gvec_dupx, MO_8)
 TRANS(xvreplgr2vr_h, LASX, gvec_dupx, MO_16)
 TRANS(xvreplgr2vr_w, LASX, gvec_dupx, MO_32)
-TRANS(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
+TRANS64(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
 
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 018dc5eb17..bbe015ba57 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -14,6 +14,10 @@
     static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
     { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
 
+#define TRANS64(NAME, AVAIL, FUNC, ...) \
+    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+    { return avail_64(ctx) && avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
+
 #define avail_ALL(C)   true
 #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
                         CPUCFG1_ARCH_LA64)
-- 
2.49.0


