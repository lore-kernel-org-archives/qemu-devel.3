Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C61C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn6W-0002gt-9s; Tue, 25 Aug 2026 05:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn6V-0002fE-CX; Tue, 25 Aug 2026 05:05:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn6S-0003rc-Mp; Tue, 25 Aug 2026 05:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=GEbuyAsKrSiilrvV4DZ9pwVljR3bgmH+hzGGyWusRlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VM/u0CpggNoItg8oAHulWbuRFLPq3FFuHuf6zHyjBmAJ6PP3j3xZ1dr6Bb9rsx6o7
 unNVrg2WcC1D6596kP2aAvmppm4vbRHuDTRQ6IRFQ2lFfiNxbr9j53m6gW4QsVd+WF
 vqZs/RLH0b7GmuJICP7GVsb+qj18qFei3ALv1Um0FiluXvX6GO7yNfZZxseIq+XHZE
 fiG6K3N1IvO7TLqwAYhgtVqrJRYeq5PPDvsQ7CyitU8yufCJN26xzMNwGPuWoGXx5e
 UDqHJzC8AO6rhcK4HvoOL3LdtffxpkWTguMA8K1YNZT9mcYV8j2llyTDYD0i0nBUUI
 Pvfdl/xMtPErA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE5E21CE3CB;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BA2B441618D;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 197ED3257F; Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 193/196] target/riscv: honor zicbo* envcfg gating
 in linux-user mode
Date: Tue, 25 Aug 2026 12:01:50 +0300
Message-ID: <20260825090157.471948-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

In user-only builds check_zicbo_envcfg() skipped the envcfg check
entirely (#if !defined(CONFIG_USER_ONLY)), so cbo.inval/cbo.flush/
cbo.zero retired unconditionally in linux-user even though the
machine-level envcfg fields are never initialized.  Give the
user-mode build a senvcfg-based gate, and initialize SENVCFG_CBZE at
reset when ext_zicboz is enabled so cbo.zero stays usable while
cbo.inval/cbo.flush remain illegal, matching the user-mode view of a
typical firmware/kernel setup.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4107
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <9b2f22fc402b48b8ba81f72be8ed04bc@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 12289f2f9a0f1ffa6a75c2b189a0273dc455dfb0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 269ea35f6da..87b9afcf241 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -769,6 +769,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
+    /*
+     * Match the user-mode view of a typical firmware/kernel setup where
+     * cbo.zero is enabled for user mode; the CBCFE/CBIE bits stay zero,
+     * so the cache-management operations remain illegal in user mode.
+     */
+    if (riscv_cpu_cfg(env)->ext_zicboz) {
+        env->senvcfg |= SENVCFG_CBZE;
+    }
     env->menvcfg = 0;
 #endif
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 43251179efc..83d7023d075 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -164,7 +164,16 @@ target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
 static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
                                 uintptr_t ra)
 {
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * linux-user: the machine-level envcfg fields are not part of the
+     * user-mode environment; only the user-mode view of the enabling
+     * bits (senvcfg, as initialized for the guest) applies.
+     */
+    if (!get_field(env->senvcfg, envbits)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+#else
     if ((env->priv < PRV_M) && !get_field(env->menvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
-- 
2.47.3


