Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E655CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV6m-0003Qj-70; Sat, 13 Jun 2026 16:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6X-0002wZ-D6; Sat, 13 Jun 2026 16:37:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6S-0003QU-Rk; Sat, 13 Jun 2026 16:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382963; bh=EQ1/T6K5U0ItJX7O+kcFKps+jhA1+1znygudWJ+5mdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H19mQ0RScvm1etEUmSe4J6iDl+jVNFCoHJ1XGZ0UagQR5qQpwDj82vrF9j7EY4ETC
 cs6ZQW6HxdERPNUbdEtygsB4P8uz81gsAT1YnAoYowyu7J1Fly9cHfUpocWFmoX0La
 3zGM3ZF4iRdrMjjB/4jrTLVsRJfmbl6Um6u5E+tlVMzu1OxPG0SqRpFv40aCdRqPIr
 SsuHwMdLcKWUkSdICw6tmnajKC3WwVMaAxsRziRQl5FbehKUoQCcgBdscMUyV2pLRu
 JMG4tzv+KWYeWj+kaF2SqfqMfmHNUpCzxp+4QQ2ckJt33fiErBUHM2BTheG+J/o2iE
 O/Wy6MJRpT86A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3CA6B1B6EE8;
 Sat, 13 Jun 2026 23:36:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A647B3CE93A;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Portia Stephens <portias@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 14/72] target/riscv: Make hpmcounterh return the upper
 32-bits
Date: Sat, 13 Jun 2026 23:34:40 +0300
Message-ID: <20260613203542.1809153-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The counter value was not being bitshifted for a hpmcounterh read
resulting in hpmcounterh returning the bottom 32-bits.

Fixes:  cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3498
Cc: qemu-stable@nongnu.org
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260519043352.3685866-1-stephensportia@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 02284108376a6bcfdd56a11de1c6e0bcc3d0e53b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cf1fe6041c..0f14ea4689 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1392,8 +1392,9 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                    ctr_prev + ctr_val;
+        uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
+                                                             ctr_prev + ctr_val;
+        *val = extract64(cntr, start, length);
     } else {
         *val = ctr_val;
     }
-- 
2.47.3


