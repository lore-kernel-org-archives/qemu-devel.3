Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A4BC30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOp7W-0004Ea-Fx; Tue, 02 Jul 2024 21:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOp7U-0004Dp-MY; Tue, 02 Jul 2024 21:49:16 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOp7P-00026A-Qs; Tue, 02 Jul 2024 21:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719971346; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=/b7mwS365hkpGv9nBhkyjcyT36yySPwvVylyvd/20Ek=;
 b=VHNi1GxJRRDT9wUxaL8kgNZY4/HcpNCmnU29XJvR9X8vfS4NLiCsrWlXsC90JQFDT1wGhSQuPBewMoDCcka90I5myRMVhHYCKK/pA5HcMCk9TVMxCuz0HOCe/Rk3pI+jqg2kuZ5BcAXfksvkjgCr7KJldfRvcz3S5JQcvnRUsPU=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9kB1d2_1719971344; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9kB1d2_1719971344) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 09:49:05 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 02/11] disas/riscv: Support zimop disassemble
Date: Wed,  3 Jul 2024 09:46:26 +0800
Message-Id: <20240703014635.1020-3-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
References: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
---
 disas/riscv.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 90d6b26de9..3ecbdcbe8d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -906,6 +906,46 @@ typedef enum {
     rv_op_amocas_w = 875,
     rv_op_amocas_d = 876,
     rv_op_amocas_q = 877,
+    rv_mop_r_0     = 878,
+    rv_mop_r_1     = 879,
+    rv_mop_r_2     = 880,
+    rv_mop_r_3     = 881,
+    rv_mop_r_4     = 882,
+    rv_mop_r_5     = 883,
+    rv_mop_r_6     = 884,
+    rv_mop_r_7     = 885,
+    rv_mop_r_8     = 886,
+    rv_mop_r_9     = 887,
+    rv_mop_r_10    = 888,
+    rv_mop_r_11    = 889,
+    rv_mop_r_12    = 890,
+    rv_mop_r_13    = 891,
+    rv_mop_r_14    = 892,
+    rv_mop_r_15    = 893,
+    rv_mop_r_16    = 894,
+    rv_mop_r_17    = 895,
+    rv_mop_r_18    = 896,
+    rv_mop_r_19    = 897,
+    rv_mop_r_20    = 898,
+    rv_mop_r_21    = 899,
+    rv_mop_r_22    = 900,
+    rv_mop_r_23    = 901,
+    rv_mop_r_24    = 902,
+    rv_mop_r_25    = 903,
+    rv_mop_r_26    = 904,
+    rv_mop_r_27    = 905,
+    rv_mop_r_28    = 906,
+    rv_mop_r_29    = 907,
+    rv_mop_r_30    = 908,
+    rv_mop_r_31    = 909,
+    rv_mop_rr_0    = 910,
+    rv_mop_rr_1    = 911,
+    rv_mop_rr_2    = 912,
+    rv_mop_rr_3    = 913,
+    rv_mop_rr_4    = 914,
+    rv_mop_rr_5    = 915,
+    rv_mop_rr_6    = 916,
+    rv_mop_rr_7    = 917,
 } rv_op;
 
 /* register names */
@@ -2096,6 +2136,46 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "mop.r.0", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.1", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.2", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.3", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.4", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.5", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.6", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.7", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.8", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.9", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.10", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.11", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.12", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.13", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.14", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.15", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.16", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.17", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.18", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.19", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.20", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.21", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.22", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.23", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.24", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.25", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.26", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.27", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.28", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.29", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.30", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.r.31", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
+    { "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
+    { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3008,6 +3088,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 13: op = rv_op_lui; break;
         case 14:
+            if (dec->cfg->ext_zimop) {
+                int imm_mop5, imm_mop3;
+                if (extract32(inst, 12, 3) == 0b100) {
+                    if ((extract32(inst, 22, 10) & 0b1011001111)
+                        == 0b1000000111) {
+                        imm_mop5 = deposit32(deposit32(extract32(inst, 20, 2),
+                                                       2, 2,
+                                                       extract32(inst, 26, 2)),
+                                             4, 1, extract32(inst, 30, 1));
+                        op = rv_mop_r_0 + imm_mop5;
+                        break;
+                    } else if ((extract32(inst, 25, 7) & 0b1011001)
+                               == 0b1000001) {
+                        imm_mop3 = deposit32(extract32(inst, 26, 2),
+                                             2, 1, extract32(inst, 30, 1));
+                        op = rv_mop_rr_0 + imm_mop3;
+                        break;
+                    }
+                }
+            }
             switch (((inst >> 22) & 0b1111111000) |
                     ((inst >> 12) & 0b0000000111)) {
             case 0: op = rv_op_addw; break;
-- 
2.25.1


