Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3953C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7nH-00013N-BZ; Thu, 23 May 2024 08:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sA7n9-0000vg-Jc; Thu, 23 May 2024 08:43:33 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sA7n7-0001fN-62; Thu, 23 May 2024 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716468204; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=8e9MdqOcLcDa6gWbPDcZ5VG5FgdgOiw69vJ/4j06Dno=;
 b=t/iMNH1HUhW9Dr07/az7C6CE+B4RalXVpPZ8bBRHE/PsZO78nXRMpBoDcUDVLmrhnEYgo8iJzen1w6jLNdPgqTFgm5LWxKDTtR8f9FA826V0BlEPeUbapYxivVwxXETkGh7A+DpNaELitR7S575gyfxmqhrIh1GPbUtg8midN/I=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W72zXpD_1716468200; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W72zXpD_1716468200) by smtp.aliyun-inc.com;
 Thu, 23 May 2024 20:43:21 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH 3/6] target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
Date: Thu, 23 May 2024 20:40:42 +0800
Message-Id: <20240523124045.1964-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
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
---
 target/riscv/insn_trans/trans_rvzacas.c.inc | 13 -------------
 target/riscv/translate.c                    | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 5d274d4c08..fcced99fc7 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -22,19 +22,6 @@
     }                                     \
 } while (0)
 
-static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
-{
-    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
-    TCGv src1 = get_address(ctx, a->rs1, 0);
-    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
-
-    decode_save_opc(ctx);
-    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
-
-    gen_set_gpr(ctx, a->rd, dest);
-    return true;
-}
-
 static bool trans_amocas_w(DisasContext *ctx, arg_amocas_w *a)
 {
     REQUIRE_ZACAS(ctx);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f597542f1c..0ce188bc91 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1097,6 +1097,19 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     return true;
 }
 
+static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
+{
+    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv src1 = get_address(ctx, a->rs1, 0);
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-- 
2.25.1


