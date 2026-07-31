Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F7DC55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsGG-0003xI-3d; Fri, 31 Jul 2026 14:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wpsG7-0003wG-Jx
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:47:04 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wpsG6-0000lM-8H
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:47:03 -0400
Received: from laptop.localdomain (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 85E1A20B7167;
 Fri, 31 Jul 2026 11:46:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85E1A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785523603;
 bh=qzAKGinRpTm7h9cD+exUNPykINEVxI273EsPRDaQ1E8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jmbONyokHCE5sRvjv4mErLWcOwkosw3KQ/aUoiQDw4/eZ53A2P9b2qfMib47tNTjG
 Ftn08YevzjzzyqfLQl/hXZ8gI46+r6aaIicOBDtZRp4puoAkGXYFRn/AP1C+iJNjjM
 CVIQwp1O8PXXq/B9gqLWkWfef2yJ7G/71s3acz/w=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH v2 4/4] accel/mshv: break the vCPU run loop on exit_request
Date: Fri, 31 Jul 2026 21:46:42 +0300
Message-ID: <20260731184643.89604-5-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731184643.89604-1-dblanzeanu@linux.microsoft.com>
References: <20260731184643.89604-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Ignored VM exits can cause mshv_cpu_exec() to re-enter MSHV_RUN_VP
without returning to qemu_process_cpu_events(). A busy vCPU may
prevent pause_all_vcpus() from completing.

Check exit_request before re-entering MSHV_RUN_VP and return
EXCP_INTERRUPT so pending stop requests can be processed.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index afcb87b3b8..b7c1126fe0 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -780,6 +780,16 @@ static int mshv_cpu_exec(CPUState *cpu)
             cpu->vcpu_dirty = false;
         }
 
+        /*
+         * A kick/stop can't reliably break MSHV_RUN_VP out, so leave the run
+         * loop here too; otherwise a busy vCPU never reaches
+         * qemu_process_cpu_events() and pause_all_vcpus() hangs under the BQL.
+         */
+        if (cpu->stop || qatomic_load_acquire(&cpu->exit_request)) {
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+
         ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
         if (ret < 0) {
             error_report("Failed to run on vcpu %d", cpu->cpu_index);
-- 
2.53.0


