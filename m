Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D067FCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9fl-0002Z6-CZ; Sat, 17 Oct 2026 15:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9eS-0006wQ-Mc; Sat, 17 Oct 2026 15:01:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9eQ-0004JM-NK; Sat, 17 Oct 2026 15:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263430; bh=36KdazKZYk8egmIh6085uyxvohIyRpcxAwUdJB/IDVY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xdmOneCJYIAglr6pcI4+m++xwcim9JkhNQE875zc0qmqrXiHVIVloA5EMv/gdc9r9
 OImDUm4WkZvkHCSTCda8OXi16GJUXzZ1GbbHC6o8ZLCyliF/FxCLQfkiaNG6Nj6MyW
 bTuWaObtql1M6O/oqxZtQHK8QlE2bSUSOThetsS6Mk14fv7MUzaG247qPAN39DjjJV
 nyc6/Ieb2/We+KlY6SkLMZVNAqmTqj/XHicSAegr3T6ZExmGhvm+oYK8nUR6no/cpu
 VQSFecil7HmMWUOIZvtdcNJ02Dr0rCGx+MVI/zjlivseZxsYFwLKZDcghY59rwM8jn
 UYq+MQpinCQKw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1CA911DE6DC;
 Sat, 17 Oct 2026 21:57:10 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BFA274433A4;
 Sat, 17 Oct 2026 21:57:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, imaginos <imaginos32@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 57/63] target/riscv: check G-stage write permission
 for VS-stage A/D updates
Date: Sat, 17 Oct 2026 21:55:13 +0300
Message-ID: <20261017185528.722197-57-mjt@tls.msk.ru>
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

From: imaginos <imaginos32@gmail.com>

During a two-stage (VS-stage + G-stage) page-table walk with hardware
A/D updating enabled (Svadu / menvcfg.ADUE), a store that reaches a
VS-stage leaf PTE whose accessed or dirty bit is clear triggers a
hardware write-back of those bits into the PTE. That write-back is an
implicit store to the PTE's guest-physical address, so it must be
permitted by G-stage.

Fix this by re-running the G-stage translation of the guest PTE's
address with store semantics. get_physical_address() then also checks
that G-stage permits the guest PTE to be written, and raises a
guest-page store fault when it does not.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3426
Signed-off-by: imaginos <imaginos32@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260705140508.17692-1-imaginos32@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 366b4fba0fae0d9425b230e06c38842d72273d88)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0ac10835fe..e407c1b6df 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1413,6 +1413,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    hwaddr pte_gpa = 0;
     const hwaddr base_root = base;
     int i;
 
@@ -1449,6 +1450,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             }
 
             pte_addr = vbase + idx * ptesize;
+            pte_gpa = base + idx * ptesize;
         } else {
             pte_addr = base + idx * ptesize;
         }
@@ -1701,6 +1703,28 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             return TRANSLATE_FAIL;
         }
 
+        /*
+         * The implicit store that writes updated A/D bits back to a VS-stage
+         * (first-stage) PTE must itself be permitted by G-stage. Re-run the
+         * second-stage translation of the PTE's guest-physical address with
+         * store semantics. If G-stage denies write, raise G-stage store fault
+         * against the PTE address.
+         */
+        if (two_stage && first_stage) {
+            int gpa_prot;
+            hwaddr gpa_paddr;
+            int gpa_ret = get_physical_address(env, &gpa_paddr, &gpa_prot,
+                                               pte_gpa, NULL, MMU_DATA_STORE,
+                                               MMUIdx_U, false, true,
+                                               is_debug, false);
+            if (gpa_ret != TRANSLATE_SUCCESS) {
+                if (fault_pte_addr) {
+                    *fault_pte_addr = pte_gpa >> 2;
+                }
+                return TRANSLATE_G_STAGE_FAIL;
+            }
+        }
+
         pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
                                            sxlen_bytes, MMU_DATA_STORE, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
@@ -2379,6 +2403,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                  * doing VS-stage page table walk.
                  */
                 tinst = (riscv_cpu_xlen(env) == 32) ? 0x00002000 : 0x00003000;
+
+                if (cause == RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT) {
+                    tinst |= 0x20;
+                }
             } else {
                 /*
                  * The "Addr. Offset" field in transformed instruction is
-- 
2.47.3


