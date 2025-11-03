Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DEFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFy4J-0000hL-Ty; Mon, 03 Nov 2025 12:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy46-0000b2-2y
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:58 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy3o-0000tk-7S
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=lzmZ31+4RMrnAe1lCBOO49+JZ+ZqCuvVlq3vEdgNDF0=; b=jzF2TQThdYVZs6L
 VTwf3ekV2uAqTvigaYR+n8VdEbjadjbHND0F4N1s0JPd7hdoIdVkeQ8RcGzCiurp1u5lepEnbUeUe
 32ZJTOBucyi+sENEnUmEkh/0sRUKFEHlfVgCgF2106TilX7psYeoGus/jPzQXgQiZTcTkVo8VJl3k
 EU=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 22/25] target/riscv: Move debug.h include away from cpu.h
Date: Mon,  3 Nov 2025 18:12:05 +0100
Message-ID: <20251103171208.24355-23-anjo@rev.ng>
In-Reply-To: <20251103171208.24355-1-anjo@rev.ng>
References: <20251103171208.24355-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All debug.h definitions except for RV_MAX_TRIGGERS are internal to
target/riscv.  Move RV_MAX_TRIGGERS to cpu.h and include debug.h from
all translation units which relied on the cpu.h include.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h         | 2 +-
 target/riscv/debug.h       | 2 --
 target/riscv/cpu.c         | 3 +++
 target/riscv/cpu_helper.c  | 2 +-
 target/riscv/csr.c         | 3 +++
 target/riscv/debug.c       | 1 +
 target/riscv/machine.c     | 2 +-
 target/riscv/tcg/tcg-cpu.c | 1 +
 8 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index cc40d6c86c..d1a8384646 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -186,12 +186,12 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
-#include "debug.h"
 #endif
 
 #define RV_VLEN_MAX 1024
 #define RV_MAX_MHPMEVENTS 32
 #define RV_MAX_MHPMCOUNTERS 32
+#define RV_MAX_TRIGGERS 2
 
 FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f944a..d3aae619db 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -24,8 +24,6 @@
 
 #include "exec/breakpoint.h"
 
-#define RV_MAX_TRIGGERS         2
-
 /* register index of tdata CSRs */
 enum {
     TDATA1 = 0,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3378c40dbf..2084b0d0bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -37,6 +37,9 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "target/riscv/debug.h"
+#endif
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 20ff05a4b2..ce3d1e86a2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -34,7 +34,7 @@
 #include "semihosting/common-semi.h"
 #include "exec/icount.h"
 #include "cpu_bits.h"
-#include "debug.h"
+#include "target/riscv/debug.h"
 #include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index debb236262..e60741def2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -31,6 +31,9 @@
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
 #include "internals.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "target/riscv/debug.h"
+#endif
 #include <stdbool.h>
 
 /* CSR function table public API */
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466749..30d39ee5cd 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "target/riscv/debug.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c6ebb58882..36f4c3251d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -22,7 +22,7 @@
 #include "system/kvm.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
-#include "debug.h"
+#include "target/riscv/debug.h"
 
 static bool pmp_needed(void *opaque)
 {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 850a383702..59ed7e796c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -37,6 +37,7 @@
 #include "hw/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
+#include "target/riscv/debug.h"
 #endif
 
 /* Hash that stores user set extensions */
-- 
2.51.0


