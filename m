Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A2DCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNry-0000wR-Ah; Wed, 24 Jun 2026 09:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNrc-0000ZO-WD; Wed, 24 Jun 2026 09:42:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNrb-0001ux-4f; Wed, 24 Jun 2026 09:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308001; bh=uPPwjcq5ppvp1MZms9UGGsAC3WsimsfdOd6fgW4/rrI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LXbTwhQxHaC2LeICA+3E108fwED0XJSBoKmNcLZlIJGS+bwNfcrsgZSEfOxb9Nlh7
 1mzTJt9b+mXrJhdADTVUbEmM1Y9QLHmhc9ueVtohpAfsnWUt9FSygdTtwD6qH7nj0p
 Qvr1qZXKeV5Sfk2AkKOJOrN/foMT6g9cjNwQLv6hecD+le1TxDsmeP5BYFKZ1F6B62
 6IeGm9GNnrACB03jOvCDUaKb7OZlRZ9McPHTeGIBEjsyATcUtV52HFxAxiORPw+zNP
 GWYRZK0mtZ7dI3/bL6EnHokRv6UKkWbbpoOJ8Gvc3x3qeYiWwAwjhAU4VUnRk+Zdl5
 ifAtQzrYuBA3Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6EB1F1BAA0B;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0C4563DEA5A;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 089/107] target/riscv/cpu_helper.c: fault with
 reserved PTE.PBMT val
Date: Wed, 24 Jun 2026 16:31:34 +0300
Message-ID: <20260624133301.403266-89-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We need to fault during any access done while PTE bits 62-61 are both
set, according to the RISC-V priv spec.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3494
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260521130727.2311629-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 3e33da68f1db7ab586063b708aa571086e7400ce)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f631d008bd..d64c4d2e80 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1396,6 +1396,25 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                 return TRANSLATE_FAIL;
             }
 
+            /*
+             * priv spec, "Svpbmt" chapter:
+             * "For non-leaf PTEs, bits 62-61 are reserved for future
+             * standard use.  Until their use is defined by a standard
+             * extension, they must be cleared by software for forward
+             * compatibility, or else a page-fault exception is raised."
+             *
+             * For leaf PTEs the same bits are also reserved but in that
+             * case the page-fault is mandatory.  Make both cases consistent
+             * by also page faulting here.
+             */
+            if ((pte & PTE_PBMT) == PTE_PBMT) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
+                        "reserved but are set in PTE: "
+                        "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                        __func__, pte_addr, pte);
+                return TRANSLATE_FAIL;
+            }
+
             if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
                 /* Reserved without Svnapot extension */
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
@@ -1448,6 +1467,23 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return TRANSLATE_FAIL;
     }
 
+    /*
+     * priv spec, "Svpbmt" chapter:
+     * "For leaf PTEs, setting bits 62-61 to the value 3 is reserved
+     * for future standard use. Until this value is defined by a
+     * standard extension, using this reserved value in a leaf PTE
+     * raises a page-fault exception. "
+     *
+     * Raise a fault if 62-61 (i.e. PTE_PBMT) are set.
+     */
+    if ((pte & PTE_PBMT) == PTE_PBMT) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits 62 and 61 are "
+                      "reserved but are set in leaf PTE: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      __func__, pte_addr, pte);
+        return TRANSLATE_FAIL;
+    }
+
     target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
     /* Check for reserved combinations of RWX flags. */
     switch (rwx) {
-- 
2.47.3


