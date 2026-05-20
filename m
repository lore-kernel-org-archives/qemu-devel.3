Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E41CCD5BA6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgNh-00052b-Ii; Wed, 20 May 2026 08:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgNS-0004g6-H9; Wed, 20 May 2026 08:50:22 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgNP-0002hh-Hi; Wed, 20 May 2026 08:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=x1Bxl/TQvoQBd/db33jCJPJdp2N7s0gtyPw6QgUq9mA=; b=pYmtAJVLUmWUxZP
 M0Je8mpC9rYWjSU57IPiXTkqYkihVFhdpaT7CFTa3GAk4Oxpw8fBt6ujifXCyLmxu8BeLqE4Nj0FT
 yARPo531MU+KJ3glS0OUhoTCBZWXqZ8EP9U2vNkUWUZAS+/cNNkvQs8i1FTwbUMmuBg08nEfcAKcv
 b8=;
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v7 24/27] target/riscv: Introduce externally facing CSR access
 functions
Date: Wed, 20 May 2026 14:54:02 +0200
Message-ID: <20260520125406.28693-25-anjo@rev.ng>
In-Reply-To: <20260520125406.28693-1-anjo@rev.ng>
References: <20260520125406.28693-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert riscv_csr_[read|write]() into target_ulong angnostic CSR access
functions that can be safely used from outside of target/ without
knowledge of the target register size.  Replace the 4 existing CSR
accesses in hw/ and linux-user/.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  7 ++++++-
 target/riscv/csr.h        | 13 -------------
 hw/riscv/riscv_hart.c     |  7 +++----
 linux-user/riscv/signal.c |  5 +++--
 target/riscv/csr.c        | 15 +++++++++++++++
 5 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 097cb44e3b..a3ddae1e6a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -903,7 +903,12 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
-#include "target/riscv/csr.h"
+/*
+ * Externally facing CSR access functions, wrappers around riscv_csr*().
+ */
+
+RISCVException riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val);
+RISCVException riscv_csr_read_i64(CPURISCVState *env, int csrn, uint64_t *res);
 
 /*
  * The event id are encoded based on the encoding specified in the
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
index f45f9912c5..4cca3a000a 100644
--- a/target/riscv/csr.h
+++ b/target/riscv/csr.h
@@ -26,19 +26,6 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
                                  target_ulong new_value,
                                  target_ulong write_mask);
 
-static inline void riscv_csr_write(CPURISCVState *env, int csrno,
-                                   target_ulong val)
-{
-    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
-}
-
-static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
-{
-    target_ulong val = 0;
-    riscv_csrr(env, csrno, &val);
-    return val;
-}
-
 typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
                                                  int csrno);
 typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index e675358e1a..d1c7188369 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -67,12 +67,11 @@ static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
     RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
     CPURISCVState *env = &cpu->env;
 
-    int ret = RISCV_EXCP_NONE;
+    RISCVException ret = RISCV_EXCP_NONE;
     if (strcmp(cmd, "get_csr") == 0) {
-        ret = riscv_csrr(env, csrno, (target_ulong *)val);
+        ret = riscv_csr_read_i64(env, csrno, val);
     } else if (strcmp(cmd, "set_csr") == 0) {
-        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
-                          MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+        ret = riscv_csr_write_i64(env, csrno, *val);
     }
 
     g_assert(ret == RISCV_EXCP_NONE);
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 358fa1d82d..9d5ba300e4 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -90,7 +90,8 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
         __put_user(env->fpr[i], &sc->fpr[i]);
     }
 
-    uint32_t fcsr = riscv_csr_read(env, CSR_FCSR);
+    uint64_t fcsr;
+    riscv_csr_read_i64(env, CSR_FCSR, &fcsr);
     __put_user(fcsr, &sc->fcsr);
 }
 
@@ -159,7 +160,7 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
 
     uint32_t fcsr;
     __get_user(fcsr, &sc->fcsr);
-    riscv_csr_write(env, CSR_FCSR, fcsr);
+    riscv_csr_write_i64(env, CSR_FCSR, fcsr);
 }
 
 static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6cc3fcd4e3..45a2b013e1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5716,6 +5716,21 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
     return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask, ra);
 }
 
+RISCVException riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val)
+{
+    return riscv_csrrw(env, csrno, NULL, val,
+                       MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+}
+
+RISCVException riscv_csr_read_i64(CPURISCVState *env, int csrno, uint64_t *res)
+{
+    RISCVException ret;
+    target_ulong val = 0;
+    ret = riscv_csrr(env, csrno, &val);
+    *res = val;
+    return ret;
+}
+
 static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
                                         Int128 *ret_value,
                                         Int128 new_value,
-- 
2.52.0


