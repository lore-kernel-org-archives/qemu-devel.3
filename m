Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FBCC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi76X-00066E-GV; Fri, 10 Jul 2026 05:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wi76M-0005x9-Ty
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:00:55 -0400
Received: from [160.191.52.36] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wi76J-0004Bf-1h
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:00:54 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 16EE3241FC94;
 Fri, 10 Jul 2026 17:00:39 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 5/8] target/loongarch: Dump host CSRs with LVZ state
Date: Fri, 10 Jul 2026 17:00:14 +0800
Message-ID: <647e3a352d4b0fc41e983d674ab599898275cd07.1783673526.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783673526.git.prcups@krgm.moe>
References: <cover.1783673526.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 160.191.52.36 (failed)
Received-SPF: pass client-ip=160.191.52.36; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update LoongArch ELF note generation to read ERA and BADV from the host
CSR bank directly, avoiding dependence on the currently selected system
state once LVZ adds a separate guest CSR bank.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/arch_dump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef96..13472188ae 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -116,7 +116,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 {
     struct loongarch_note note;
     CPULoongArchState *env = &LOONGARCH_CPU(cs)->env;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *host = &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
     int ret, i;
 
     loongarch_note_init(&note, s, "CORE", 5, NT_PRSTATUS,
@@ -127,8 +127,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     for (i = 0; i < 32; ++i) {
         note.prstatus.pr_reg.gpr[i] = cpu_to_dump64(s, env->gpr[i]);
     }
-    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, sys->CSR_ERA);
-    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, sys->CSR_BADV);
+    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, host->CSR_ERA);
+    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, host->CSR_BADV);
     ret = f(&note, LOONGARCH_PRSTATUS_NOTE_SIZE, s);
     if (ret < 0) {
         return -1;
-- 
2.52.0


