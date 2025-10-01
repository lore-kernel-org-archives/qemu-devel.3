Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9F6CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJe-0005rx-8I; Wed, 01 Oct 2025 03:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJc-0005qA-5u
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:56 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJ9-0003cD-Fu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=4bp54/Y4VGV6rBPl7PK9ZoqhZTxrkQRn7RiytSIQX00=; b=KLPm5SqVTXMdMtg
 rfHXrfxaGrxa/27zeMQYh7Uwxx9A47UflEJfdZywwoGG1sNLyLPqVNRdJwG8lE8tLYNF/Od4mGndZ
 Rl4CgJOqm0Xm9t68C6vp/+E7wec4Kr2J5+djjIyDlEip9kVF9p04xxuzIK2+rUuGt8pOitUDNKbJA
 KA=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 30/33] target/riscv: Move debug.h include away from cpu.h
Date: Wed,  1 Oct 2025 09:33:03 +0200
Message-ID: <20251001073306.28573-31-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 target/riscv/cpu.h         | 4 ++--
 target/riscv/debug.h       | 2 --
 target/riscv/cpu.c         | 3 +++
 target/riscv/csr.c         | 3 +++
 target/riscv/debug.c       | 1 +
 target/riscv/tcg/tcg-cpu.c | 1 +
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a53981a09b..70e0f3718c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -177,14 +177,14 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 #define MAX_RISCV_PMPS (64)
 #define OLD_MAX_RISCV_PMPS (16)
 
-#if !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_LINUX_USER)
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
index 5206abe640..246ec81beb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -37,6 +37,9 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "debug.h"
+#endif
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 832f061711..0e7236098b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -32,6 +32,9 @@
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
 #include "internals.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "debug.h"
+#endif
 #include <stdbool.h>
 
 /* CSR function table public API */
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5664466749..f5b2043405 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "debug.h"
 #include "trace.h"
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 200759eaf0..08e9d2b554 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -37,6 +37,7 @@
 #include "hw/boards.h"
 #include "system/tcg.h"
 #include "exec/icount.h"
+#include "debug.h"
 #endif
 
 /* Hash that stores user set extensions */
-- 
2.51.0


