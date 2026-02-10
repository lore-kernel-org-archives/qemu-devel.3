Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3905E9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdv0-0002Sn-TB; Mon, 09 Feb 2026 21:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vpdux-0002Qh-IP
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:55:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vpduu-0003x0-EA
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:55:59 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axz8M1noppfUoRAA--.55629S3;
 Tue, 10 Feb 2026 10:55:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxD8Mtnoppm59DAA--.61278S4;
 Tue, 10 Feb 2026 10:55:49 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/7] target/loongarch: Add am{swap/add}[_db].{b/h}
Date: Tue, 10 Feb 2026 10:30:35 +0800
Message-Id: <20260210023040.3507338-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260210023040.3507338-1-gaosong@loongson.cn>
References: <20260210023040.3507338-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxD8Mtnoppm59DAA--.61278S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Jiajie Chen <c@jia.je>

The new instructions are introduced in LoongArch v1.1:

- amswap.b
- amswap.h
- amadd.b
- amadd.h
- amswap_db.b
- amswap_db.h
- amadd_db.b
- amadd_db.h

The instructions are gated by CPUCFG2.LAM_BH.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.h                        |  1 +
 target/loongarch/disas.c                      |  8 ++++++++
 target/loongarch/insns.decode                 |  8 ++++++++
 .../tcg/insn_trans/trans_atomic.c.inc         |  8 ++++++++
 target/loongarch/translate.h                  | 19 ++++++++++---------
 5 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0485cdbda0..013525bf45 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -138,6 +138,7 @@ FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
 FIELD(CPUCFG2, HPTW, 24, 1)
+FIELD(CPUCFG2, LAM_BH, 27, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 63989a6282..1a0f527cb1 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -580,6 +580,14 @@ INSN(fldx_s,       frr)
 INSN(fldx_d,       frr)
 INSN(fstx_s,       frr)
 INSN(fstx_d,       frr)
+INSN(amswap_b,     rrr)
+INSN(amswap_h,     rrr)
+INSN(amadd_b,      rrr)
+INSN(amadd_h,      rrr)
+INSN(amswap_db_b,  rrr)
+INSN(amswap_db_h,  rrr)
+INSN(amadd_db_b,   rrr)
+INSN(amadd_db_h,   rrr)
 INSN(amswap_w,     rrr)
 INSN(amswap_d,     rrr)
 INSN(amadd_w,      rrr)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 62f58cc541..678ce42038 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -261,6 +261,14 @@ ll_w            0010 0000 .............. ..... .....     @rr_i14s2
 sc_w            0010 0001 .............. ..... .....     @rr_i14s2
 ll_d            0010 0010 .............. ..... .....     @rr_i14s2
 sc_d            0010 0011 .............. ..... .....     @rr_i14s2
+amswap_b        0011 10000101 11000 ..... ..... .....    @rrr
+amswap_h        0011 10000101 11001 ..... ..... .....    @rrr
+amadd_b         0011 10000101 11010 ..... ..... .....    @rrr
+amadd_h         0011 10000101 11011 ..... ..... .....    @rrr
+amswap_db_b     0011 10000101 11100 ..... ..... .....    @rrr
+amswap_db_h     0011 10000101 11101 ..... ..... .....    @rrr
+amadd_db_b      0011 10000101 11110 ..... ..... .....    @rrr
+amadd_db_h      0011 10000101 11111 ..... ..... .....    @rrr
 amswap_w        0011 10000110 00000 ..... ..... .....    @rrr
 amswap_d        0011 10000110 00001 ..... ..... .....    @rrr
 amadd_w         0011 10000110 00010 ..... ..... .....    @rrr
diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index b8c962b65a..17e72bab47 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -73,6 +73,14 @@ TRANS(ll_w, ALL, gen_ll, MO_LESL)
 TRANS(sc_w, ALL, gen_sc, MO_LESL)
 TRANS(ll_d, 64, gen_ll, MO_LEUQ)
 TRANS(sc_d, 64, gen_sc, MO_LEUQ)
+TRANS(amswap_b, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_SB)
+TRANS(amswap_h, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_LESW)
+TRANS(amadd_b, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_SB)
+TRANS(amadd_h, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LESW)
+TRANS(amswap_db_b, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_SB)
+TRANS(amswap_db_h, LAM_BH, gen_am, tcg_gen_atomic_xchg_tl, MO_LESW)
+TRANS(amadd_db_b, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_SB)
+TRANS(amadd_db_h, LAM_BH, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LESW)
 TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LESL)
 TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LEUQ)
 TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LESL)
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index bbe015ba57..eb424bb0da 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -21,15 +21,16 @@
 #define avail_ALL(C)   true
 #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) == \
                         CPUCFG1_ARCH_LA64)
-#define avail_FP(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
-#define avail_FP_SP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
-#define avail_FP_DP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
-#define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
-#define avail_LAM(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
-#define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
-#define avail_LASX(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
-#define avail_IOCSR(C) (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
-#define avail_CRC(C)   (FIELD_EX32((C)->cpucfg1, CPUCFG1, CRC))
+#define avail_FP(C)     (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
+#define avail_FP_SP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
+#define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
+#define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
+#define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
+#define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
+#define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
+#define avail_LASX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
+#define avail_IOCSR(C)  (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
+#define avail_CRC(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, CRC))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
-- 
2.52.0


