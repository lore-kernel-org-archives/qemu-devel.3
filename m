Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446EECCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8liY-00018R-4T; Tue, 14 Oct 2025 16:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liX-00018J-4q
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:57 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v8liU-0000WC-VX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=LZL3tyucp/Kwp7oVxhRZceaT9TBH2gMYcCEeX8cv5GM=; b=fLfougft+ZHB8Yx
 p9BglSMKw6ZOH5n26ojf+mAxjoT74D3S7tXyVK75Q1X1dV2ZUB68TSzC3z3n1yXc9YDIZx7xU+Xsd
 O7cP5Ma5BejBrUmXd5L0Pqi/CaPKxY1x8YoYNoiPbUDIhziiZ3ymA3Ld2CJSr7o/ZFETPd1ABFuKH
 ls=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [PATCH v3 28/34] target/riscv: Replace target_ulong in
 riscv_ctr_add_entry()
Date: Tue, 14 Oct 2025 22:35:05 +0200
Message-ID: <20251014203512.26282-29-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
References: <20251014203512.26282-1-anjo@rev.ng>
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

Widen to 64 bits in size to hold all relevant values.  Note: src and dst
arguments change from signed to unsigned but no functional change is
incurred.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h        | 5 +++--
 target/riscv/cpu_helper.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 09123f4373..85ad250a8f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -661,8 +661,9 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
                         bool virt_en);
 
-void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, privilege_mode_t prev_priv, bool prev_virt);
+void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
+                         enum CTRType type, privilege_mode_t prev_priv,
+                         bool prev_virt);
 void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b78bc510a6..7f2be3371c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -927,8 +927,9 @@ static bool riscv_ctr_check_xte(CPURISCVState *env,
  *    entry = isel - CTR_ENTRIES_FIRST;
  *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
  */
-void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, privilege_mode_t src_priv, bool src_virt)
+void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
+                         enum CTRType type, privilege_mode_t src_priv,
+                         bool src_virt)
 {
     bool tgt_virt = env->virt_enabled;
     uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);
-- 
2.51.0


