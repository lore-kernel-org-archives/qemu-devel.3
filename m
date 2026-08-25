Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C17C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp8W-0004eU-FV; Tue, 25 Aug 2026 07:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp8P-0004YH-IP; Tue, 25 Aug 2026 07:16:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp8N-0000mm-KZ; Tue, 25 Aug 2026 07:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=9virRQQ19oZIiBUGfkfJEirwYq3490kgkUOfInWJh68=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q/yhb+ZFjG4ZbqeIhQCrUPhVTq143uunW9Q+AehdCbFxpJJNt6qohVvx+lnbGSPum
 BYiEkQUF1dHFaBXjCPUb/K337bxRMaKnr/yeyFqkslfmnBWK+FWhNNlV/2oDNCnVnA
 S25Bdz0G7+pqlQj8DkgQxtfa+DWSGDiswZPuWLY8GEEercze4XPTE+ErXGEW3FFR59
 OKqaRWFkg9TKilLq61jBKcAbAca/ePnENFEsvAhbNk8LGxBfixEBt8SBl/Yu0+xTw2
 CLOpS3l6IqpAByJOKDBOdo07tTS1Ihg8PnwvedTwSoq0BMqCLV356/kyP7PKRSNPp7
 UxsdXlTKA3hew==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8AD981CE4BF;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A3B9D41628B;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B6C4F325C1; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 163/166] target/riscv: honor zicbo* envcfg gating
 in linux-user mode
Date: Tue, 25 Aug 2026 14:11:59 +0300
Message-ID: <20260825111206.482723-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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
index 9e4f54d250f..bf4855ec02d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1116,6 +1116,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
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
index 0cdbb0138c6..c5dc18a27b9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -142,7 +142,16 @@ target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
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


