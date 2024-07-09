Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2A8C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9DU-00022Q-Bl; Tue, 09 Jul 2024 07:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sR9DJ-0001W4-Jr; Tue, 09 Jul 2024 07:40:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sR9DG-0003yL-Q1; Tue, 09 Jul 2024 07:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720525245; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=scsqCvQGSmwFs3/7q27n0oJg+Xzp8H68cgGJkfZxZ1Y=;
 b=wTKz70hruJ8SNld9Lm1CcB3JIzm0hINelMv+vZFnRnow4B8Ehz1tv++dazQk1NZdfQXv8j+vrmOSgGMrwmTYYNXczgV3LLiMxweiI+rP2PBw+CAUY2ybZEkLmNXyYlZOQ7cFPJCXmm87uDQEf8yHdTkhxNwBXW2K4ZLjP85hqFw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0WABv39p_1720525242; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WABv39p_1720525242) by smtp.aliyun-inc.com;
 Tue, 09 Jul 2024 19:40:43 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v4 04/11] disas/riscv: Support zcmop disassemble
Date: Tue,  9 Jul 2024 19:36:45 +0800
Message-Id: <20240709113652.1239-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
References: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Although in QEMU disassemble, we usually lift compressed instruction
to an normal format when display the instruction name. For C.MOP.n,
it is more reasonable to directly display its compressed name, because
its behavior can be redefined by later extension.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
---
 disas/riscv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 0b82ab2322..d29cb1ff7d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -946,6 +946,14 @@ typedef enum {
     rv_mop_rr_5    = 915,
     rv_mop_rr_6    = 916,
     rv_mop_rr_7    = 917,
+    rv_c_mop_1     = 918,
+    rv_c_mop_3     = 919,
+    rv_c_mop_5     = 920,
+    rv_c_mop_7     = 921,
+    rv_c_mop_9     = 922,
+    rv_c_mop_11    = 923,
+    rv_c_mop_13    = 924,
+    rv_c_mop_15    = 925,
 } rv_op;
 
 /* register names */
@@ -2176,6 +2184,14 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
     { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "c.mop.1",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.3",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.5",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.7",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.9",  rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.11", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.13", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "c.mop.15", rv_codec_ci_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2532,6 +2548,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
+            if (dec->cfg->ext_zcmop) {
+                if ((((inst >> 2) & 0b111111) == 0b100000) &&
+                    (((inst >> 11) & 0b11) == 0b0)) {
+                    op = rv_c_mop_1 + ((inst >> 8) & 0b111);
+                    break;
+                }
+            }
             switch ((inst >> 7) & 0b11111) {
             case 2: op = rv_op_c_addi16sp; break;
             default: op = rv_op_c_lui; break;
-- 
2.25.1


