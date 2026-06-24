Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A04CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFrp-0004XX-6I; Wed, 24 Jun 2026 01:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFr7-0003jL-9x; Wed, 24 Jun 2026 01:09:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFr5-0005tA-4l; Wed, 24 Jun 2026 01:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277623; bh=1PSgP1Lnzw53pkRrgvFH4qcO74Fc3uJ1aHpPfIfbTxk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sBTRnwaGGXfUv2/5SRbkUVanO3PKpY2Mbn+GQzbY6Je9BVKmpuz8Eebu0cM845L97
 ajwTGzvCuUtELAal5Y+EkpfWraTylTOE610oZ4k4ducCXdtHjrirPOt/Qiw8tXgA1H
 1wajU86LSe4MSZ8FJyvgd5FmF0MyzIt66me7+olWBQc8hXV9eLcTf5N71BOoX5HIDc
 XGmKlFZcC5971nUgB1Gu/YA9h8ShbQ+wO+jSy5KXb/2Oz4U06t5XQCxcevZEw03RcH
 G2C3aHP2kQy6W+Zsa2inSQBbNhejfEyqlFt3yBolRoR/EUBEqyOqmHrYwIGzF2aFgz
 dUgJfevr1u8mQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FCBC1BA66C;
 Wed, 24 Jun 2026 08:07:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1A7963DDB09;
 Wed, 24 Jun 2026 08:07:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 78/95] target/riscv/cpu_helper.c: fault with reserved
 PTE.PBMT val
Date: Wed, 24 Jun 2026 08:05:13 +0300
Message-ID: <20260624050541.395079-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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
index 1bd6649f23..97a8fe308d 100644
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


