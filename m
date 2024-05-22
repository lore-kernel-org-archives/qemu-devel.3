Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D216C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fWm-0000nm-8h; Wed, 22 May 2024 02:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s9fWM-0000dg-DY; Wed, 22 May 2024 02:32:30 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s9fWK-0007cO-0v; Wed, 22 May 2024 02:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716359530; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=YX3b7gyIHNVCAvd8S5bVJ3cOPO+qEQCR+2ziMZGsxOw=;
 b=TyaGLahQnHgK81FgFMZQcjhEbYRgFn45+HIz/ijZzuFrCWXp9Jt6RrsLfJaY3Ji/W+qnSTneIRPlInwG7agQZTYVE354xVZzUFCV7CgFpKI2gqeXtmPexKNYldnbKVJ3yKEvt4LcGz5X6CeOSGeus+M9ES+eDCf7BqYEn4X6PGI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R951e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045075189;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W7-8m.W_1716359528; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W7-8m.W_1716359528) by smtp.aliyun-inc.com;
 Wed, 22 May 2024 14:32:09 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, iwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH 4/4] disas/riscv: Support zcmop disassemble
Date: Wed, 22 May 2024 14:29:05 +0800
Message-Id: <20240522062905.1799-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
References: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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
---
 disas/riscv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 4cd769f165..41050246f3 100644
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
@@ -2469,6 +2485,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
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


