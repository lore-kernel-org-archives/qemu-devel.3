Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEBACDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFrs-0004pP-2i; Wed, 24 Jun 2026 01:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFqo-00037o-Sb; Wed, 24 Jun 2026 01:08:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFql-0005t9-3i; Wed, 24 Jun 2026 01:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277623; bh=0qeQG38BzP/Bizi+dlJAjX3FnMzZTa7jiRiX9fH3TzQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lwDSOh1jrseKJUi0AZmri0mtUIdQY1/8eg4z88UMgmuLXSZLrJ1NSZaQvPWuCO4fj
 GoOYMNcjPGZjIVOYsOD3AbA7w5HOH+6s/QB8msLOOQ0MDZRtSw/tkDktFpOPR79WAo
 T657ziCBr5/XCSpY44LtoJFQGPHCeFJbpatUkFkE6H+Da1TQtEToDoTzmNPY5bKt68
 TlAW3MSoML0VvG+rQiJnXJVMiK2o2bsNDIDAMcIgU+nRuPom61KOFCydcMvaQhRPnn
 tvXyplHsjvu255p2sIL7fkPg7TPMhrwWIgAoPhWKOVb6FWqrVAiT8DIVe2g+2LTYuH
 YtcuJWmj78eXw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 210701BA66B;
 Wed, 24 Jun 2026 08:07:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B2943DDB08;
 Wed, 24 Jun 2026 08:07:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 77/95] target/riscv/insn_trans/trans_rvzicbo.c.inc:
 save opcode before helpers
Date: Wed, 24 Jun 2026 08:05:12 +0300
Message-ID: <20260624050541.395079-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

All helpers from this file can trigger ILLEGAL_INSN exceptions via
check_zicbo_envcfg() directly, bypassing the usual exception code from
translate.c.   If we don't save the opcode before each helper,
riscv_raise_exception() is triggered and env->bins won't be unwind during
cpu_loop_exit_restore() (code path cpu_restore_state ->
cpu_restore_state_from_tb() -> restore_state_to_opc()).

And finally, in riscv_cpu_do_interrupt(), we will set (m)tval = 0 when we can,
instead, set it to the cbo opcode that generated the exception.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3380
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520214704.1943652-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d6c5855c76b2ea849adb0fb91379dbb1e5a94dca)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index 15711c3140..096f7dde27 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -33,6 +33,8 @@ static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
@@ -42,6 +44,8 @@ static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
@@ -51,6 +55,8 @@ static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_inval(tcg_env, src);
     return true;
 }
@@ -60,6 +66,8 @@ static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
     REQUIRE_ZICBOZ(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_zero(tcg_env, src);
     return true;
 }
-- 
2.47.3


