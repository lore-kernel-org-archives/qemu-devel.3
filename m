Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwr0-0007eh-Cn; Fri, 15 May 2026 14:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqb-0007Mz-FG
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:21 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqO-0001OK-A8
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=9am6gYHdbA5/081RdyVXNrSde+WPT2MqADZHWGGw6sA=; b=MHYqqxAYC30pjSD
 8RNcaq1qbMmGwpaXMBInXMnQgfLMAoKa+JtdtWeww8mGgYqg5ImVYsweolN4LognRw64OeXZndDOX
 2U5wzYMXHgeujGJzhDM2z618m9Mfwd3wIZI4FiBhZ2XJr895GIZAFpplPh4udRiD2mPTeteXgv1A6
 dM=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 21/27] target/riscv: Fix size of mseccfg
Date: Fri, 15 May 2026 20:04:31 +0200
Message-ID: <20260515180437.23620-22-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f34b19470b..126c4647c8 100644
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
index 17307ef88a..91130289d8 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -71,8 +71,8 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
                       target_ulong val);
 target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
 
-void mseccfg_csr_write(CPURISCVState *env, target_ulong val);
-target_ulong mseccfg_csr_read(CPURISCVState *env);
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
+uint64_t mseccfg_csr_read(CPURISCVState *env);
 
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 5391caa59c..bc4ab8ad15 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -659,7 +659,7 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 /*
  * Handle a write to a mseccfg CSR
  */
-void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val)
 {
     int i;
     uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
@@ -705,7 +705,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 /*
  * Handle a read from a mseccfg CSR
  */
-target_ulong mseccfg_csr_read(CPURISCVState *env)
+uint64_t mseccfg_csr_read(CPURISCVState *env)
 {
     trace_mseccfg_csr_read(env->mhartid, env->mseccfg);
     return env->mseccfg;
-- 
2.52.0


