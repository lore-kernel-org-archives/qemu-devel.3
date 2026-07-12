Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1A6C44501
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wileP-0006Qx-Tn; Sun, 12 Jul 2026 00:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wileN-00063Q-V2; Sun, 12 Jul 2026 00:18:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wileK-0006Zh-UB; Sun, 12 Jul 2026 00:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=7CkpURgUQObkG1LyBH77Mo2ekz62gASGNgmcwBX63Sc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dCx1iqRjETY9J9FEuzCZx6DMrKsBo6tLzgxomGsrMYYnNwzGzM3mG15mylFqmwoZY
 w5QOAcmUlv8E0GLlzSzYb67tNL0z6ulcSJ1BKaO+QNCLTZp/Jd7BnGne5xX5Dzu8I5
 hSM+KU7bs6Bu6Lbtw5v9Uqppg+k6p34m2RgY6EfO+mMSZa+CGHZzWQnDKeOAjgCVIY
 cHGxvp9ll5Dhqcq5R0ZMyJVewa3Ywxjm7F49qoCwcZdBmZJk3XAks/08eL4zZ6c4WG
 LMAUhkh7nv8kw72Lh3wlVd0pC37DrkQVs1blgh9/b3yIiG3uEwyOKXimNMz8P6kvix
 98e0TF64CVxjw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 54BF21C0BF7;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 88CBC3EB957;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 55C46133F1; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Inochi Amaoto <inochiama@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 28/75] target/riscv: Check PMP before updating PTE
Date: Sun, 12 Jul 2026 07:14:46 +0300
Message-ID: <20260712041539.108341-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Inochi Amaoto <inochiama@gmail.com>

According to the RISC-V spec, the PTE update is a supervisor write
operations, and it should also follow the CPU PMP configuration like
the PTE read.

Cc: qemu-stable@nongnu.org
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260622113402.563196-1-inochiama@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit fa2cf7488379d9b14041a7bcd76867c9bdad2b5e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5e0d436c73a..0ac10835fed 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1695,10 +1695,18 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
+        int pmp_prot, pmp_ret;
+
         if (!adue) {
             return TRANSLATE_FAIL;
         }
 
+        pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
+                                           sxlen_bytes, MMU_DATA_STORE, PRV_S);
+        if (pmp_ret != TRANSLATE_SUCCESS) {
+            return TRANSLATE_PMP_FAIL;
+        }
+
         /*
          * - if accessed or dirty bits need updating, and the PTE is
          *   in RAM, then we do so atomically with a compare and swap.
-- 
2.47.3


