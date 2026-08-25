Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC076C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylJ4-0006cH-W4; Tue, 25 Aug 2026 03:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylJ3-0006To-D1; Tue, 25 Aug 2026 03:10:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylJ1-0006hb-M8; Tue, 25 Aug 2026 03:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=BiyEWaXsmCNxkFh+A4end053qlX7RS/9AoFRet1FFZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fpuUaT89l0Ac0W3lpEUQdAzLzdAZAMg/4/fi8xaumGHop4V46OGd99cBOnAfuPe0+
 gYWpaqGyQyxXKoGKXi61zSaXZ9BrUvpq5orYKVwleOOt7X8F0rash8sDvhQ1xdrnTj
 EIsV/E4PI9oXPvHwKulnzY+6gFS7haF/k1SAJ+a3rfNEmXSdSpVAZEQmLGLd+JuJSC
 f2IKlm2Orj89HAG+AQOMmVa4xxV9A0/Jx2olB8Zy2HWKa0xLWcBQ0P2tJh7lEFqhEo
 29U9M77At+ZAI8+6qz/57a0nql7n1iJH1Vg93Xo+KR366w77BxIRatqBQjD7YeLH4Z
 ReHwOkFwmMX/A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF7AB1CE237;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74723415FB2;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D9D0B3244E; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 82/91] disas/riscv: Fix rv32 encoding of zext.h
Date: Tue, 25 Aug 2026 10:05:54 +0300
Message-ID: <20260825070619.174584-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

For rv64, pack with rs2 = 0 does not encode zext.h.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-39-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d4151cf2675124e26b3383ae06f7352a23f17399)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/disas/riscv.c b/disas/riscv.c
index 82b962dc71f..aa58beeaf33 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3185,9 +3185,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 14: op = rv_op_rem; break;
             case 15: op = rv_op_remu; break;
             case 36:
-                switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_zext_h; break;
-                default: op = rv_op_pack; break;
+                if (isa == rv32 && !((inst >> 20) & 0b11111)) {
+                    op = rv_op_zext_h;
+                } else {
+                    op = rv_op_pack;
                 }
                 break;
             case 39: op = rv_op_packh; break;
-- 
2.47.3


