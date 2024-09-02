Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D5ECA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl7Fl-000839-0l; Mon, 02 Sep 2024 09:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.klauchek@yadro.com>)
 id 1sl4P0-000119-Nk; Mon, 02 Sep 2024 06:35:19 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.klauchek@yadro.com>)
 id 1sl4Oy-0000nx-Ay; Mon, 02 Sep 2024 06:35:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A50DCC0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1725273298;
 bh=ezc+JC4ivNUFgixILBC+L5c+Mb1oZU6F8f5WPwh3r6I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=WgR0gUrZ2gdwhNPTT6HebB8Jor5MjIEOC1qGsN/5uXQ5+Cs8u2Msb3loCIMBz9Du1
 4SgtbGpw49ggPaft1OCoo5CaRRvQYxV8GT7527vZSZjzvAb1wVxejanRZEdSzgZgyv
 hhyhIbYlG+nOkakQwpJg1vBkXIjo1t+7X/FujUzdlo664uT3TSDTxVlyej/rJHs+/I
 8ZsPLpWaeRXja3WMoaSlzkLv0gkuRGOAV3eJW1W+xp8BQjV115TmSvZ2ca1Mq6cV3H
 iMGx5LFaBIbC/qCZgJvGBPn4GeOVZw8V9sy2A0mKJ1tRG0apocqwto6HlkbZhcLbBX
 wBodB9jzTFD1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1725273298;
 bh=ezc+JC4ivNUFgixILBC+L5c+Mb1oZU6F8f5WPwh3r6I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=vsWi4FkKJBlmyl+raBiyBs01kC2/khSBTCNtzILmjVbrptzwaGo8kgXHHB3uUCfoM
 O1cMiJlzPDdc8mAso+dfg+Bh82HqJEarzAVT51HKzj4M6gfiyWm5a6Ox9U2W+YDjwE
 3vKAdTKbM7/A5WRTHLpJWyMTcsWFEXuwsfIYH1thua4/Z3ceILfDTW5pr1my4PXSCc
 70yj1SzY1dlh59pgIy6oIsIqInP0lxzXWnjiOaY0cUJpZf18uVElyBWEyO7p519dQb
 rZLqzT5WAvn2rWl3JWJO9o5GD/BsCy/CVk70mBNp0PzDYeOytyHZPVwlq16skIoZjR
 B8voXJjdZ3WCQ==
From: Maria Klauchek <m.klauchek@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Maria Klauchek <m.klauchek@syntacore.com>
Subject: [PATCH 1/1] target/riscv/cpu.c: Add 'fcsr' register to QEMU log as a
 part of F extension
Date: Mon, 2 Sep 2024 13:34:33 +0300
Message-ID: <20240902103433.18424-1-m.klauchek@syntacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.klauchek@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Sep 2024 09:37:54 -0400
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

FCSR is a part of F extension. Print it to log if FPU option is enabled.

Signed-off-by: Maria Klauchek <m.klauchek@syntacore.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..6ff6096777 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -839,6 +839,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
     if (flags & CPU_DUMP_FPU) {
+        target_ulong val = 0;
+        RISCVException res = riscv_csrrw_debug(env, CSR_FCSR, &val, 0, 0);
+        if (res == RISCV_EXCP_NONE) {
+            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+                    csr_ops[CSR_FCSR].name, val);
+        }
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s %016" PRIx64,
                          riscv_fpr_regnames[i], env->fpr[i]);
-- 
2.25.1


