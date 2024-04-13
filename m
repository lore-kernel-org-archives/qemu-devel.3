Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E801AC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 11:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvb6w-0000W9-RX; Sat, 13 Apr 2024 06:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvb6v-0000VI-2z; Sat, 13 Apr 2024 06:59:53 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvb6s-00027s-M6; Sat, 13 Apr 2024 06:59:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 7F2DFC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1713005985;
 bh=3CcDcXZJegh8W1uUIlJHgdnrNh4FFZdThdW2zm0ltzc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ULhSzDEcSnqaz5g+DJevZ6d96qxSIPGD97UO+PtbfEnmOspdbm+3exk+HHSFsSpOd
 ImTvVZ0GnjKWnAM6XTAk+t+9Th1Hfeg6PCxJoiTqr1MTRavMHi8d0LU4WnD72OAB+v
 xna3ywpmQ0SCj/4XBHJW0F1RkmfBa2QdwBPOg1I7DJRMe26OWxF4lNxQVPk/jMpfCS
 25kiDEVJdPfS78WNUxyIfUrtXzDHZCBf7Tij8VAeD2U+u03++7gLaGP6ndGSWyitOe
 ylohhVP9QOR9LArkHTvwSax7dvHTkuB7tEcFCl4GH/Lwv0LTTHUTWamxHtrkzG3RLQ
 qOkUmAfjPIHTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1713005985;
 bh=3CcDcXZJegh8W1uUIlJHgdnrNh4FFZdThdW2zm0ltzc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=lDcD4WWNebseyoTvfvIeyTiAQ00FWrw7cS/wI23j0Gezs1PnhJlhN5WqHjuGM3Pup
 UBtHGNNw3+KeBc5ncqeTDmgkP7fIV5NQMmejpQunOu1Fe+qNk6byw4+d1zgvL8lhBW
 Wxy3Rtr8dv6QWUIUb35vZh9vo0kAJi8Wlccbxql8W9fHxoN6OjCG0zub1FQ5KayBFz
 PJDjKvvxgEZLUjNehDEtQK3oQhZOnQXyWXZUdkavXg+vF46vYinjU/8f4enCrfltX3
 K9/fuPnwRwqBRhs5jp5N/Otl0A1NdtKyTPn0NziqgGfyNqeLROxgnVrzDZhD5MsC2q
 trRlMNUkfRkrQ==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>
CC: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Joseph Chan
 <jchan@ventanamicro.com>
Subject: [PATCH 1/2] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Date: Sat, 13 Apr 2024 13:59:28 +0300
Message-ID: <20240413105929.7030-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

raise_mmu_exception(), as is today, is prioritizing guest page faults by
checking first if virt_enabled && !first_stage, and then considering the
regular inst/load/store faults.

There's no mention in the spec about guest page fault being a higher
priority that PMP faults. In fact, privileged spec section 3.7.1 says:

"Attempting to fetch an instruction from a PMP region that does not have
execute permissions raises an instruction access-fault exception.
Attempting to execute a load or load-reserved instruction which accesses
a physical address within a PMP region without read permissions raises a
load access-fault exception. Attempting to execute a store,
store-conditional, or AMO instruction which accesses a physical address
within a PMP region without write permissions raises a store
access-fault exception."

So, in fact, we're doing it wrong - PMP faults should always be thrown,
regardless of also being a first or second stage fault.

The way riscv_cpu_tlb_fill() and get_physical_address() work is
adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
reflected in the 'pmp_violation' flag. What we need is to change
raise_mmu_exception() to prioritize it.

Reported-by: Joseph Chan <jchan@ventanamicro.com>
Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU translation stage")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bc70ab5abc..196166f8dd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1203,28 +1203,30 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
     switch (access_type) {
     case MMU_INST_FETCH:
-        if (env->virt_enabled && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
+        } else if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
         }
         break;
     case MMU_DATA_LOAD:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_LOAD_PAGE_FAULT;
         }
         break;
     case MMU_DATA_STORE:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
-                RISCV_EXCP_STORE_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
         }
         break;
     default:
-- 
2.34.1


