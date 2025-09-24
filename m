Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D973CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jno-0005sR-0l; Wed, 24 Sep 2025 03:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jnh-0005pD-TG
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:32 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1JnZ-0003fm-7d
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ui9d7qGLrNXHd9ideOeuKiUKn3f8NG9mb5zPIxxyYtQ=; b=aN9wrBeUSbxiwkO
 tV/Qu02uCt0Xb9H6Jkm/k6fDJmeWLx1DHohd8L9j1C2MJY8bJmCysJGjPL4kkjoZvfQYVDPQJ0xb+
 VHtUZx1XBBXbL+rp6YLZO3G8oblyNT36BkNICK95VamJ9hm5KeLZbJaBRzovxAJBHpWrNSDUOH2cy
 2k=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 28/34] target/riscv: Replace target_ulong in
 riscv_ctr_add_entry()
Date: Wed, 24 Sep 2025 09:21:18 +0200
Message-ID: <20250924072124.6493-29-anjo@rev.ng>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
References: <20250924072124.6493-1-anjo@rev.ng>
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
index 1498ae063e..592c741947 100644
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


