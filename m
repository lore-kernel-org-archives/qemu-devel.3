Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FACDCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHhP-0003MA-FS; Wed, 27 Aug 2025 11:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHhD-00031d-Ah; Wed, 27 Aug 2025 11:04:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHh7-0004py-4N; Wed, 27 Aug 2025 11:04:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 220B814C534;
 Wed, 27 Aug 2025 18:02:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0D31E26983C;
 Wed, 27 Aug 2025 18:03:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 12/59] target/riscv: do not call GETPC() in
 check_ret_from_m_mode()
Date: Wed, 27 Aug 2025 18:02:17 +0300
Message-ID: <20250827150323.2694101-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

GETPC() should always be called from the top level helper, e.g. the
first helper that is called by the translation code. We stopped doing
that in commit 3157a553ec, and then we introduced problems when
unwinding the exceptions being thrown by helper_mret(), as reported by
[1].

Call GETPC() at the top level helper and pass the value along.

[1] https://gitlab.com/qemu-project/qemu/-/issues/3020

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 3157a553ec ("target/riscv: Add Smrnmi mnret instruction")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/3020
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250714133739.1248296-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 16aa7771afeac422dcf7be2833d5426da6b814fa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 72dc48e58d..6a8c2e1940 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -353,21 +353,22 @@ target_ulong helper_sret(CPURISCVState *env)
 }
 
 static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
-                                  target_ulong prev_priv)
+                                  target_ulong prev_priv,
+                                  uintptr_t ra)
 {
     if (!(env->priv >= PRV_M)) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
 
     if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
                                     env->priv_ver,
                                     env->misa_ext) && (retpc & 0x3)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
     }
 
     if (riscv_cpu_cfg(env)->pmp &&
         !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
-        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
+        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, ra);
     }
 }
 static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
@@ -392,8 +393,9 @@ target_ulong helper_mret(CPURISCVState *env)
     target_ulong retpc = env->mepc;
     uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    uintptr_t ra = GETPC();
 
-    check_ret_from_m_mode(env, retpc, prev_priv);
+    check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
     target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
                              (prev_priv != PRV_M);
@@ -441,8 +443,9 @@ target_ulong helper_mnret(CPURISCVState *env)
     target_ulong retpc = env->mnepc;
     target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
     target_ulong prev_virt;
+    uintptr_t ra = GETPC();
 
-    check_ret_from_m_mode(env, retpc, prev_priv);
+    check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
     prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
                 (prev_priv != PRV_M);
-- 
2.47.2


