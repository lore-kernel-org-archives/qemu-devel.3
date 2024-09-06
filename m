Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF116CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWy3-0001Qi-9v; Fri, 06 Sep 2024 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxE-0006hc-SS; Fri, 06 Sep 2024 07:16:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWxD-00087R-2p; Fri, 06 Sep 2024 07:16:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F23638C495;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0AEEF1336FF;
 Fri,  6 Sep 2024 14:13:27 +0300 (MSK)
Received: (nullmailer pid 353664 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 37/69] linux-user/elfload: Fix pr_pid values in core
 files
Date: Fri,  6 Sep 2024 14:12:46 +0300
Message-Id: <20240906111324.353230-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Analyzing qemu-produced core dumps of multi-threaded apps runs into:

    (gdb) info threads
      [...]
      21   Thread 0x3ff83cc0740 (LWP 9295) warning: Couldn't find general-purpose registers in core file.
    <unavailable> in ?? ()

The reason is that all pr_pid values are the same, because the same
TaskState is used for all CPUs when generating NT_PRSTATUS notes.

Fix by using TaskStates associated with individual CPUs.

Cc: qemu-stable@nongnu.org
Fixes: 243c47066253 ("linux-user/elfload: Write corefile elf header in one block")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240801202340.21845-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 5b0c2742c839376b7e03c4654914aaec6a8a7b09)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 60cf55b36c..0e00683dd2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4175,8 +4175,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, size_t sz, off_t offset)
     bswap_phdr(phdr, 1);
 }
 
-static void fill_prstatus_note(void *data, const TaskState *ts,
-                               CPUState *cpu, int signr)
+static void fill_prstatus_note(void *data, CPUState *cpu, int signr)
 {
     /*
      * Because note memory is only aligned to 4, and target_elf_prstatus
@@ -4186,7 +4185,7 @@ static void fill_prstatus_note(void *data, const TaskState *ts,
     struct target_elf_prstatus prstatus = {
         .pr_info.si_signo = signr,
         .pr_cursig = signr,
-        .pr_pid = ts->ts_tid,
+        .pr_pid = get_task_state(cpu)->ts_tid,
         .pr_ppid = getppid(),
         .pr_pgrp = getpgrp(),
         .pr_sid = getsid(0),
@@ -4501,8 +4500,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         CPU_FOREACH(cpu_iter) {
             dptr = fill_note(&hptr, NT_PRSTATUS, "CORE",
                              sizeof(struct target_elf_prstatus));
-            fill_prstatus_note(dptr, ts, cpu_iter,
-                               cpu_iter == cpu ? signr : 0);
+            fill_prstatus_note(dptr, cpu_iter, cpu_iter == cpu ? signr : 0);
         }
 
         if (dump_write(fd, header, data_offset) < 0) {
-- 
2.39.2


