Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCE4CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9gH-0003o5-Hd; Sat, 17 Oct 2026 15:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9fI-0001Wg-KK; Sat, 17 Oct 2026 15:01:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9fF-0004Ls-5L; Sat, 17 Oct 2026 15:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263438; bh=Yt/8Q2QUuv0Ett89CgtDv/9I7FrcG+4VUWUHlrUzq2c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C66idgr5QknYqSKlTyMyHqna7DbnCNCA1wRhaV8O+f83975vl4gGg1v9CscnW/VtH
 8MLw32WWHfq/OPyfrjU3jjWebT3823pEb5V8DiW2CBppCKHtTDfpwHVeC6lW3APwVK
 BVj2GoZ1gjdhIPsJvezDgbbNAddZw3cNfvY1YQieFtULznumgxq2vkRMmVRrdx58wZ
 cVv0Zmw+iPMnCnNLPH+57XjEfXp2s2W2kUCY4jqrCJ70cTeGA8hk9pCeC7YyzN77Mg
 FeifzXb81FklVV1+SGIZiE1buzcQoPHSjHek0zIRKFZSHBzQGN4oF1UltZZI37IJBu
 VbW0nE69UjWCA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4B9EE1DE6E2;
 Sat, 17 Oct 2026 21:57:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2B7114433AA;
 Sat, 17 Oct 2026 21:57:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, dodochicha <kevincheng60303@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 63/63] target/riscv: Check Svnapot PTE before
 updating A/D bits
Date: Sat, 17 Oct 2026 21:55:19 +0300
Message-ID: <20261017185528.722197-63-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: dodochicha <kevincheng60303@gmail.com>

Reserved Svnapot PTE encodings must raise a page fault without
modifying the PTE. Currently the A/D bits may be updated before
the Svnapot encoding is validated.

Move the Svnapot validation before the A/D update so reserved
PTEs fault without changing the PTE.

Cc: qemu-stable@nongnu.org
Signed-off-by: dodochicha <kevincheng60303@gmail.com>
Message-ID: <20261005115916.21196-1-kevincheng60303@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit cb82463fa9bf46d90e6a1779bb20aff2bf76a1a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e407c1b6df..fafcad75b8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1682,6 +1682,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
     }
 
+    if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
+        napot_bits = ctzl(ppn) + 1;
+        if ((i != (levels - 1)) || (napot_bits != 4)) {
+            return TRANSLATE_FAIL;
+        }
+    }
+
     target_ulong updated_pte = pte;
 
     /*
@@ -1769,13 +1776,6 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     /* For superpage mappings, make a fake leaf PTE for the TLB's benefit. */
     target_ulong vpn = addr >> PGSHIFT;
 
-    if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
-        napot_bits = ctzl(ppn) + 1;
-        if ((i != (levels - 1)) || (napot_bits != 4)) {
-            return TRANSLATE_FAIL;
-        }
-    }
-
     napot_mask = (1 << napot_bits) - 1;
     *physical = (((ppn & ~napot_mask) | (vpn & napot_mask) |
                   (vpn & (((target_ulong)1 << ptshift) - 1))
-- 
2.47.3


