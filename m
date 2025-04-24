Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C38C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tEa-0000FI-8D; Thu, 24 Apr 2025 05:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7tEY-0000EJ-DR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7tET-0002wR-Jy
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:51:05 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxG6x9CQpoXjzFAA--.32473S3;
 Thu, 24 Apr 2025 17:50:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCx_cZ8CQpoIFeTAA--.43713S4;
 Thu, 24 Apr 2025 17:50:53 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org,
 --cc=richard.henderson@linaro.org, WANG Rui <wangrui@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/13] target/loongarch: Add CRC feature flag and use it to
 gate CRC instructions
Date: Thu, 24 Apr 2025 17:28:48 +0800
Message-Id: <20250424092849.3985437-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250424092849.3985437-1-gaosong@loongson.cn>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
 <20250424092849.3985437-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZ8CQpoIFeTAA--.43713S4
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: WANG Rui <wangrui@loongson.cn>

This patch replaces the obsolete IOCSR_BRD bit with CRC in cpucfg1[25],
in both LA464 and LA132 CPU initialization functions. The corresponding
field macro in `cpu.h` is updated to reflect this change.

Additionally, the availability macro `avail_CRC()` is introduced in
`translate.h` to check the CRC feature flag.

All CRC-related instruction translations are updated to be gated by
the new CRC feature flag instead of hardcoded CPU features.

This ensures correctness and configurability when enabling CRC
instructions based on hardware capabilities.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250418082103.447780-2-wangrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c                           |  4 ++--
 target/loongarch/cpu.h                           |  2 +-
 .../loongarch/tcg/insn_trans/trans_extra.c.inc   | 16 ++++++++--------
 target/loongarch/translate.h                     |  1 +
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index bf3d592574..588f5fd021 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -432,7 +432,7 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG1, EP, 1);
     data = FIELD_DP32(data, CPUCFG1, RPLV, 1);
     data = FIELD_DP32(data, CPUCFG1, HP, 1);
-    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
+    data = FIELD_DP32(data, CPUCFG1, CRC, 1);
     env->cpucfg[1] = data;
 
     data = 0;
@@ -531,7 +531,7 @@ static void loongarch_la132_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG1, EP, 0);
     data = FIELD_DP32(data, CPUCFG1, RPLV, 0);
     data = FIELD_DP32(data, CPUCFG1, HP, 1);
-    data = FIELD_DP32(data, CPUCFG1, IOCSR_BRD, 1);
+    data = FIELD_DP32(data, CPUCFG1, CRC, 1);
     env->cpucfg[1] = data;
 }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 254e4fbdcd..ab76a0b451 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -129,7 +129,7 @@ FIELD(CPUCFG1, RI, 21, 1)
 FIELD(CPUCFG1, EP, 22, 1)
 FIELD(CPUCFG1, RPLV, 23, 1)
 FIELD(CPUCFG1, HP, 24, 1)
-FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
+FIELD(CPUCFG1, CRC, 25, 1)
 FIELD(CPUCFG1, MSG_INT, 26, 1)
 
 /* cpucfg[1].arch */
diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index cfa361fecf..eda3d6e561 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -97,11 +97,11 @@ static bool gen_crc(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(crc_w_b_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
-TRANS(crc_w_h_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
-TRANS(crc_w_w_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
-TRANS(crc_w_d_w, 64, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
-TRANS(crcc_w_b_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
-TRANS(crcc_w_h_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
-TRANS(crcc_w_w_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
-TRANS(crcc_w_d_w, 64, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
+TRANS(crc_w_b_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(1))
+TRANS(crc_w_h_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(2))
+TRANS(crc_w_w_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(4))
+TRANS(crc_w_d_w, CRC, gen_crc, gen_helper_crc32, tcg_constant_tl(8))
+TRANS(crcc_w_b_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(1))
+TRANS(crcc_w_h_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(2))
+TRANS(crcc_w_w_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(4))
+TRANS(crcc_w_d_w, CRC, gen_crc, gen_helper_crc32c, tcg_constant_tl(8))
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 195f53573a..018dc5eb17 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -25,6 +25,7 @@
 #define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
 #define avail_LASX(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LASX))
 #define avail_IOCSR(C) (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
+#define avail_CRC(C)   (FIELD_EX32((C)->cpucfg1, CPUCFG1, CRC))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
-- 
2.34.1


