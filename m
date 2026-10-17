Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C147CCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB8O-0003ae-Rb; Sat, 17 Oct 2026 16:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB6T-0008NQ-OA; Sat, 17 Oct 2026 16:34:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB6S-0004jd-0I; Sat, 17 Oct 2026 16:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268907; bh=ysuUAH0hzUmMmYIYi6wZp/+zDmPbz/HAW6uwi0NnuwU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B+E7HB9LBYL6c6S+DMFgC33UDJ7/VTviM6FxPeKqJKWyj9gAdKNPOo+VVr1LEeaO+
 2ZfYTJc0abhZRwdU0PSaRENVzueatMMUwY1nBQlKEvkIUJyKEkUn2phQPwMXEk9Qf9
 fXUrErNE4DeNiMR+RrMLR7MDCjt9CA0vQvZ0IHeDSGEsDZTGcTpDiIjq5UnXhua5Hq
 VhoIs67Oyo4Mmj2oT6STE+4pIdqOTURLvY06+hcp+39s78arSTOcXAx/IAOu5yqomA
 QHwBVIWgXqWRX3ZKY7d5ETq6nCvr667Bv1mXPLEEwwMYJrNtRC7GaB1zgVScSI/GAB
 fCacFKMy3neCA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D3D691DE78A;
 Sat, 17 Oct 2026 23:28:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E080944345B;
 Sat, 17 Oct 2026 23:28:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, dodochicha <kevincheng60303@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 73/73] target/riscv: Check Svnapot PTE before updating
 A/D bits
Date: Sat, 17 Oct 2026 23:26:31 +0300
Message-ID: <20261017202638.728621-73-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 6115f65adb..8f1c84f05f 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -1405,6 +1405,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
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
@@ -1497,13 +1504,6 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
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


