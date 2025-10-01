Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459DACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJX-0005ne-Fo; Wed, 01 Oct 2025 03:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJV-0005nP-My
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:49 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJ7-0003aD-DO
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=5ryoUQzopIh5+1Mk4U/8fFA6e/v5oFZl6J87GpWZuDE=; b=iQ1n5Vtl5QtPi9O
 sa6J9mitg/TC0f0wWgztJeo91++IFMwVd4vt3xiO4tqagF4g8tGsjYRUb6O9WdmNpVmuHCQRQxZrf
 MeqUAmMCCan/uKLBeewqFS8EJ5m7zMWc/jSw3joQDr6HwcRSMOrYnBEAddZOboFl4nnsfFEfVOt/S
 kY=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 27/33] target/riscv: Replace target_ulong in
 riscv_ctr_add_entry()
Date: Wed,  1 Oct 2025 09:33:00 +0200
Message-ID: <20251001073306.28573-28-anjo@rev.ng>
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

Widen to 64 bits in size to hold all relevant values.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h        | 2 +-
 target/riscv/cpu_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c1fbb67b08..b17aca0e02 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -653,7 +653,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 
 void riscv_cpu_set_mode(CPURISCVState *env, uint8_t newpriv, bool virt_en);
 
-void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
+void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
     enum CTRType type, uint8_t prev_priv, bool prev_virt);
 void riscv_ctr_clear(CPURISCVState *env);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2945a89a9c..4acfccc9d8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -925,8 +925,8 @@ static bool riscv_ctr_check_xte(CPURISCVState *env, uint8_t src_prv,
  *    entry = isel - CTR_ENTRIES_FIRST;
  *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
  */
-void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, uint8_t src_priv, bool src_virt)
+void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
+                         enum CTRType type, uint8_t src_priv, bool src_virt)
 {
     bool tgt_virt = env->virt_enabled;
     uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);
-- 
2.51.0


