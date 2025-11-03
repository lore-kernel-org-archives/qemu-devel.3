Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E9ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFy41-0000aA-M7; Mon, 03 Nov 2025 12:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy3y-0000ZA-RY
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:50 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy3k-0000td-QP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=q6Opor7lQGZigqevcgCM7+jdNW3PiYzYgsH0ftxO0eA=; b=XPJ/G+YPstFDieE
 aKsPSJ85WUMoOZAKmb/EC2nBnQzALUmJjqjWVNm/R353nXcOIbnYxrhcys+MW2x+Uwz6JQCVWqq/7
 Hovo9r2DghZay9Xuzpat1RijB7dXJQ1IbHtuxQETqQl9EzWcVRBbdk1hvkWa9U8wW9Cu55Xi9u1Px
 HI=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 21/25] target/riscv: Fix size of mseccfg
Date: Mon,  3 Nov 2025 18:12:04 +0100
Message-ID: <20251103171208.24355-22-anjo@rev.ng>
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

mseccfg is defined in version 20250508 of the privileged specification
to be 64 bits in size.  Update relevant function arguments.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/pmp.h | 4 ++--
 target/riscv/pmp.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 153480846a..cc40d6c86c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -464,7 +464,7 @@ struct CPUArchState {
 
     /* physical memory protection */
     pmp_table_t pmp_state;
-    target_ulong mseccfg;
+    uint64_t mseccfg;
 
     /* trigger module */
     uint16_t mcontext;
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 271cf24169..e322904637 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -69,8 +69,8 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
                       target_ulong val);
 target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
 
-void mseccfg_csr_write(CPURISCVState *env, target_ulong val);
-target_ulong mseccfg_csr_read(CPURISCVState *env);
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
+uint64_t mseccfg_csr_read(CPURISCVState *env);
 
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..0b23b4b8ed 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -643,7 +643,7 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 /*
  * Handle a write to a mseccfg CSR
  */
-void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val)
 {
     int i;
     uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
@@ -689,7 +689,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 /*
  * Handle a read from a mseccfg CSR
  */
-target_ulong mseccfg_csr_read(CPURISCVState *env)
+uint64_t mseccfg_csr_read(CPURISCVState *env)
 {
     trace_mseccfg_csr_read(env->mhartid, env->mseccfg);
     return env->mseccfg;
-- 
2.51.0


