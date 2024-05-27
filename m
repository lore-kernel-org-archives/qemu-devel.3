Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79320C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZCp-0004sa-10; Mon, 27 May 2024 08:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sBZCm-0004qH-4K; Mon, 27 May 2024 08:11:57 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sBZCj-00014a-3D; Mon, 27 May 2024 08:11:54 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 0CA5DC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1716811908;
 bh=SWzH1z/+Kh0ee5cQlyrOJxpTPt2dW7nTXOthQ/PKTFU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fCdJTE/q/YTmouNm2ElY/2ym1WepxFSYVi0YwBxqgKQ03Zxxi/0oRFsUhzZ3Gt+MO
 nmZL3jSLn+2Txy5CUbdEg2XUidThe4Hxi/rRIg4emHudsQSo1IP+B+PpVwIyUiMSk5
 T301ebTeNsE68SAWyysiz0HsgXYJzkughIrrF3kr72omLWCtt2FsywGeK1+ZK61Yvd
 ql65fBtcUtjyqIhfE3//dDu/YjE5MBBp5ZZwo/YRY80VDMH2ndssgwPdgdhxqos61A
 hg4CglYRgbZ5xDkSO3Kb2FwuWukLFwnwTgmTxQdj8gNHwQ45zfBKihNWA2m84LqPrF
 TSe7mICPlB2SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1716811908;
 bh=SWzH1z/+Kh0ee5cQlyrOJxpTPt2dW7nTXOthQ/PKTFU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=z+04YcxUX85VKy7p8MOUmd4Gvy30KU0OPuXe5CO2BA6dCsQHx9Pw0QmwFR9U0Wb0o
 brV4eYl0d9j041gcJ0ZAiZrzc30qLgJHIPp2vEs/18sh6ibuikNJozWRWFfQgeF4KG
 DGsfrTCyCStmktfjj9G1ZtIleoHrcaebnG+6jeu6+CANbu1Yf86IX0M+7E2u6QBz6Z
 gbmEMyqG2IpByMTsQ78rPXCxrqWlPj8ipRfnOdM9bMQxrEc0oGDpOfeT3T/4udhnuZ
 Ye4oNnSMBkfH23QczZvpHy/w2MVETnp2UW49CQlooTFiSQcFUx4mA9KdLKaDpERnqj
 B82DEz1FFHg9g==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <alistair23@gmail.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <dbarboza@ventanamicro.com>,
 <jchan@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 1/2] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Date: Mon, 27 May 2024 15:11:37 +0300
Message-ID: <20240527121137.85206-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKmqyKNYFyVEOsRyOQCjZBMO_-Wut+k2Bn_5ep_uZdFi-5O-jQ@mail.gmail.com>
References: <CAKmqyKNYFyVEOsRyOQCjZBMO_-Wut+k2Bn_5ep_uZdFi-5O-jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fc090d729a..e3a7797d00 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1176,28 +1176,30 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
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


