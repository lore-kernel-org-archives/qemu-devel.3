Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF84CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Ruw-0000Gb-6p; Sun, 05 Oct 2025 12:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Ruu-0000FP-6L; Sun, 05 Oct 2025 12:49:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rus-000756-ND; Sun, 05 Oct 2025 12:48:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 767CA15AA35;
 Sun, 05 Oct 2025 19:48:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B3822996F1;
 Sun,  5 Oct 2025 19:48:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Isaev <vladimir.isaev@syntacore.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 72/81] target/riscv: do not use translator_ldl in
 opcode_at
Date: Sun,  5 Oct 2025 19:47:52 +0300
Message-ID: <20251005164822.442861-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Vladimir Isaev <vladimir.isaev@syntacore.com>

opcode_at is used only in semihosting checks to match opcodes with expected
pattern.

This is not a translator and if we got following assert if page is not in TLB:
qemu-system-riscv64: ../accel/tcg/translator.c:363: record_save: Assertion
`offset == db->record_start + db->record_len' failed.

Fixes: 1f9c4462334f ("target/riscv: Use translator_ld* for everything")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250815140633.86920-1-vladimir.isaev@syntacore.com>
[ Changes by AF:
 - Fixup header includes after rebase
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit a86d3352ab70f33f5feabbf9bad9450d3c19d0bf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..6fc06c71f5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -24,6 +24,7 @@
 #include "exec/helper-gen.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
 #include "semihosting/semihost.h"
@@ -1166,7 +1167,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return translator_ldl(env, &ctx->base, pc);
+    return cpu_ldl_code(env, pc);
 }
 
 #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
-- 
2.47.3


