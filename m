Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415E7CF043B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNMz-00032D-NF; Tue, 08 Oct 2024 23:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNMw-0002kg-4w; Tue, 08 Oct 2024 23:28:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNMu-00053T-2h; Tue, 08 Oct 2024 23:28:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdX33Mjvz6LD6x;
 Wed,  9 Oct 2024 11:23:47 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 314E8140A34;
 Wed,  9 Oct 2024 11:28:06 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:27:47 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V4 26/33] tcg: Update tcg_register_thread() leg to handle
 region alloc for hotplugged vCPU
Date: Wed, 9 Oct 2024 04:18:08 +0100
Message-ID: <20241009031815.250096-27-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The TCG code cache consists of multiple regions shared among vCPUs in
multi-threaded TCG mode. For cold-plugged vCPUs, these regions are sized and
allocated during initialization in the `tcg_register_thread()` function when the
vCPUs are realized. Later, these regions must be reallocated for hot-plugged
vCPUs as well.

If region allocation fails for hot-plugged vCPUs—due to the code cache being
under stress—the TCG code cache must be flushed to create space for the newly
hot-plugged vCPU. The only safe way to perform `tb_flush()` is to execute it
synchronously within the `cpu_exec()` loop.

Reported-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 accel/tcg/tcg-accel-ops-mttcg.c |  2 +-
 accel/tcg/tcg-accel-ops-rr.c    |  2 +-
 include/tcg/startup.h           |  6 ++++++
 include/tcg/tcg.h               |  1 +
 tcg/region.c                    | 14 ++++++++++++++
 tcg/tcg.c                       | 13 ++++++++++++-
 6 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 49814ec4af..ab2f79d2c7 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -74,7 +74,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     force_rcu.notifier.notify = mttcg_force_rcu;
     force_rcu.cpu = cpu;
     rcu_add_force_rcu_notifier(&force_rcu.notifier);
-    tcg_register_thread();
+    tcg_register_thread(cpu);
 
     bql_lock();
     qemu_thread_get_self(cpu->thread);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 8ebadf8e9e..953231837c 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -186,7 +186,7 @@ static void *rr_cpu_thread_fn(void *arg)
     rcu_register_thread();
     force_rcu.notify = rr_force_rcu;
     rcu_add_force_rcu_notifier(&force_rcu);
-    tcg_register_thread();
+    tcg_register_thread(cpu);
 
     bql_lock();
     qemu_thread_get_self(cpu->thread);
diff --git a/include/tcg/startup.h b/include/tcg/startup.h
index f71305765c..a565071516 100644
--- a/include/tcg/startup.h
+++ b/include/tcg/startup.h
@@ -25,6 +25,8 @@
 #ifndef TCG_STARTUP_H
 #define TCG_STARTUP_H
 
+#include "hw/core/cpu.h"
+
 /**
  * tcg_init: Initialize the TCG runtime
  * @tb_size: translation buffer size
@@ -43,7 +45,11 @@ void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
  * accelerator's init_machine() method) must register with this
  * function before initiating translation.
  */
+#ifdef CONFIG_USER_ONLY
 void tcg_register_thread(void);
+#else
+void tcg_register_thread(CPUState *cpu);
+#endif
 
 /**
  * tcg_prologue_init(): Generate the code for the TCG prologue
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..e3328cc600 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -518,6 +518,7 @@ struct TCGContext {
 
     /* Track which vCPU triggers events */
     CPUState *cpu;                      /* *_trans */
+    bool tbflush_pend; /* TB flush pending due to vCPU hotplug */
 
     /* These structures are private to tcg-target.c.inc.  */
 #ifdef TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4..9007bfd71e 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -393,6 +393,20 @@ bool tcg_region_alloc(TCGContext *s)
 static void tcg_region_initial_alloc__locked(TCGContext *s)
 {
     bool err = tcg_region_alloc__locked(s);
+
+    /*
+     * Hotplugged vCPUs may initially fail to find even a single available
+     * region. This could be due to the TB cache being under stress from the
+     * existing vCPUs. To mitigate this, the TB cache should be flushed.
+     * Therefore, the region allocation failure should be ignored, and a flag
+     * set to mark `tb_flush()` as pending. The flush will be performed later,
+     * synchronously in the context of `cpu_exec_loop()`/`tb_gen_code()`.
+     */
+    if (err && s->cpu && DEVICE(s->cpu)->hotplugged) {
+            s->tbflush_pend = true;
+        return;
+    }
+
     g_assert(!err);
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 34e3056380..5e9c6b2b4b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -783,12 +783,13 @@ void tcg_register_thread(void)
     tcg_ctx = &tcg_init_ctx;
 }
 #else
-void tcg_register_thread(void)
+void tcg_register_thread(CPUState *cpu)
 {
     TCGContext *s = g_malloc(sizeof(*s));
     unsigned int i, n;
 
     *s = tcg_init_ctx;
+     s->cpu = cpu;
 
     /* Relink mem_base.  */
     for (i = 0, n = tcg_init_ctx.nb_globals; i < n; ++i) {
@@ -1388,6 +1389,16 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     TranslationBlock *tb;
     void *next;
 
+    /*
+     * The hotplugged vCPU's TCG context might not have any regions allocated.
+     * If this condition is detected, we should flush the TB cache to ensure
+     * that regions can be allocated for the newly hotplugged vCPU's TCGContext.
+     */
+    if (s->tbflush_pend) {
+        s->tbflush_pend = false;
+        return NULL;
+    }
+
  retry:
     tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
     next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
-- 
2.34.1


