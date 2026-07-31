Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654C2C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFa-0002df-2n; Fri, 31 Jul 2026 01:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeMA-0005v0-Cn; Thu, 30 Jul 2026 23:56:22 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM8-0002Jw-FE; Thu, 30 Jul 2026 23:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470175; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=62yiwq8K+mIfvMr+HXg569sklzBPLTqpmFcv2kAbwZ0=;
 b=JfO0xUKkqkQReqcZM2R1p2Tc1iLE02+DjoTNqbSfZcN0/ST8oSbBLmx3r8Vch1Koz+JC3zp5eKCk2NJIvzPufq8j7ePWCF+gVuK55E2CK2ajNzGRFwAdzVUMeKvHS3YrNoUg2DcpsJHktRUJHTHIG2JNeK5OuWdLxEIYMnCceBE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwWs_1785469862; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwWs_1785469862 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:51:03 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 15/17] accel/kvm: pin the vCPU threads of a CoVE guest
Date: Fri, 31 Jul 2026 11:50:09 +0800
Message-Id: <20260731035011.4178103-16-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
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

The TSM binds a TVM vCPU to the hart it first runs on, so the thread
running it has to stay on that host CPU.  With every host CPU running a
pinned vCPU thread the host is then starved, which shows up as RCU
stalls, hence the short sleep after each KVM_RUN.

Both are workarounds that do not belong in target independent code:
thread placement is normally left to the user or to the management layer,
and the sleep papers over a host scheduling problem.  Guidance on how to
express the TSM requirement properly would be appreciated.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 accel/kvm/kvm-accel-ops.c | 16 ++++++++++++++++
 accel/kvm/kvm-all.c       |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index c8e7aa3870..30e1cb181c 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -24,6 +24,7 @@
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
+#include "hw/riscv/cove.h"
 
 #include <linux/kvm.h>
 #include "kvm-cpus.h"
@@ -43,6 +44,21 @@ static void *kvm_vcpu_thread_fn(void *arg)
     r = kvm_init_vcpu(cpu, &error_fatal);
     kvm_init_cpu_signals(cpu);
 
+    /*
+     * The TSM binds a TVM vCPU to the hart it first runs on, so pin vCPU N
+     * to host CPU N before the first KVM_RUN.
+     */
+    if (riscv_cove_vm_active()) {
+        cpu_set_t cpuset;
+
+        CPU_ZERO(&cpuset);
+        CPU_SET(cpu->cpu_index, &cpuset);
+        if (sched_setaffinity(0, sizeof(cpuset), &cpuset) < 0) {
+            error_report("Unable to pin vCPU %d: %s", cpu->cpu_index,
+                         strerror(errno));
+        }
+    }
+
     /* signal CPU creation */
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aaaa88bd2b..7b33a9aa3a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3510,6 +3510,15 @@ int kvm_cpu_exec(CPUState *cpu)
          * as true, cpu->exit_request will always read as true.
          */
 
+        /*
+         * Yield briefly after each KVM_RUN of a CoVE guest: with one pinned
+         * vCPU thread per host CPU the host is otherwise starved and reports
+         * RCU stalls.
+         */
+        if (riscv_cove_vm_active()) {
+            usleep(100);
+        }
+
         attrs = kvm_arch_post_run(cpu, run);
 
 #ifdef KVM_HAVE_MCE_INJECTION
-- 
2.34.1


