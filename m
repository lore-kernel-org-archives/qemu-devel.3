Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD080CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t7A-0002KR-53; Wed, 15 Oct 2025 00:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t77-0002Ex-Oo; Wed, 15 Oct 2025 00:27:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t71-0002zm-A4; Wed, 15 Oct 2025 00:27:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D33D15D9DE;
 Wed, 15 Oct 2025 07:25:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3FD9829FE85;
 Wed, 15 Oct 2025 07:25:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 11/13] target/riscv: Fix ssamoswap error handling
Date: Wed, 15 Oct 2025 07:25:35 +0300
Message-ID: <20251015042540.68611-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
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

From: Jim Shu <jim.shu@sifive.com>

Follow the RISC-V CFI v1.0 spec [1] to fix the exception type
when ssamoswap is disabled by xSSE.

[1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack Location

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250924074818.230010-4-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 0b16c7b6a854d461cdfd418769b51d58e43dd92a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 85d73e492d..e2e883151d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1284,3 +1284,8 @@ DEF_HELPER_4(vgmul_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_5(vsm4k_vi, void, ptr, ptr, i32, env, i32)
 DEF_HELPER_4(vsm4r_vv, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
+
+/* CFI (zicfiss) helpers */
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_1(ssamoswap_disabled, void, env)
+#endif
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 45686af4d6..f4a1c12ca0 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -91,7 +91,11 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     }
 
     if (!ctx->bcfi_enabled) {
+#ifndef CONFIG_USER_ONLY
+        gen_helper_ssamoswap_disabled(tcg_env);
+#else
         return false;
+#endif
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
@@ -116,7 +120,11 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
     }
 
     if (!ctx->bcfi_enabled) {
+#ifndef CONFIG_USER_ONLY
+        gen_helper_ssamoswap_disabled(tcg_env);
+#else
         return false;
+#endif
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6a8c2e1940..c34d8a4a9c 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -715,4 +715,53 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
 
+void helper_ssamoswap_disabled(CPURISCVState *env)
+{
+    int exception = RISCV_EXCP_ILLEGAL_INST;
+
+    /*
+     * Here we follow the RISC-V CFI spec [1] to implement the exception type
+     * of ssamoswap* instruction.
+     *
+     * [1] RISC-V CFI spec v1.0, ch2.7 Atomic Swap from a Shadow Stack Location
+     *
+     * Note: We have already checked some conditions in trans_* functions:
+     *   1. The effective priv mode is not M-mode.
+     *   2. The xSSE specific to the effictive priv mode is disabled.
+     */
+    if (!get_field(env->menvcfg, MENVCFG_SSE)) {
+        /*
+         * Disabled M-mode SSE always trigger illegal instruction when
+         * current priv mode is not M-mode.
+         */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+    if (!riscv_has_ext(env, RVS)) {
+        /* S-mode is not implemented */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    } else if (env->virt_enabled) {
+        /*
+         * VU/VS-mode with disabled xSSE will trigger the virtual instruction
+         * exception.
+         */
+        exception = RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+        goto done;
+    } else {
+        /*
+         * U-mode with disabled S-mode SSE will trigger the illegal instruction
+         * exception.
+         *
+         * Note: S-mode is already handled in the disabled M-mode SSE case.
+         */
+        exception = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+done:
+    riscv_raise_exception(env, exception, GETPC());
+}
+
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.3


