Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E9ECA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umv5E-0006si-2f; Fri, 15 Aug 2025 10:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1umv5B-0006sG-9C; Fri, 15 Aug 2025 10:07:01 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1umv58-0001EL-0U; Fri, 15 Aug 2025 10:07:00 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id D94731A0003;
 Fri, 15 Aug 2025 14:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com D94731A0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1755266812; bh=TfI2U123P4tJk3C4/o7gWgqj3y0h3sxJsm7gwoUK07s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Go3nxwB0g5IK4fLdoRwLrMCpHmp5cMBORxLrQg9UjlLRjZiRs+vHTDGqHMdyvAjQQ
 pXK6vjt1tU5Dt81oNfAZLeIM8uq1v+NqUhWMneq/wFUMVrmi7mGWuLKVd4iaqtqNYN
 ECijkisN4uBKOzAijz5niGYjC8kyzL+b9ZQHpw2zu+gjEzNIC53j9YXzLTaS817Fp8
 JcgmOtiLilror0xo559tQm3Tw95QNlF0BslSR7Uiyf+6ZU5lEsckpKN7xGBwZK5he6
 NxUhdE+fEZX1/8DGNk8m0QxnJiQmiFmfMi6kBDuDdHrBN7mSymbcacIrYoc8p709TU
 mqFGR1IxSN3Ow==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Fri, 15 Aug 2025 14:06:52 +0000 (UTC)
Received: from visaev-hp.corp.yadro.com (10.199.26.51) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 17:06:30 +0300
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
To: <richard.henderson@linaro.org>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>
CC: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Vladimir Isaev
 <vladimir.isaev@syntacore.com>
Subject: [PATCH] target/riscv: do not use translator_ldl in opcode_at
Date: Fri, 15 Aug 2025 17:06:33 +0300
Message-ID: <20250815140633.86920-1-vladimir.isaev@syntacore.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.26.51]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/08/15 13:27:00 #27665518
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=vladimir.isaev@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

opcode_at is used only in semihosting checks to match opcodes with expected pattern.

This is not a translator and if we got following assert if page is not in TLB:
qemu-system-riscv64: ../accel/tcg/translator.c:363: record_save: Assertion `offset == db->record_start + db->record_len' failed.

Fixes: 1f9c4462334f ("target/riscv: Use translator_ld* for everything")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
 target/riscv/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b1e41cdbf1f6..980a67ea855e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -25,6 +25,7 @@
 #include "exec/helper-gen.h"
 
 #include "exec/translator.h"
+#include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "semihosting/semihost.h"
 
@@ -1143,7 +1144,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return translator_ldl(env, &ctx->base, pc);
+    return cpu_ldl_code(env, pc);
 }
 
 #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
-- 
2.50.1


