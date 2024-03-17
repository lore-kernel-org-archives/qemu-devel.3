Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5648CC54E67
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 08:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlm1b-00070g-SB; Sun, 17 Mar 2024 04:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rlm1Z-00070K-Ta
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 04:37:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1rlm1Y-000861-0a
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 04:37:45 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TyBBF2jsJz1Q9x9;
 Sun, 17 Mar 2024 16:35:01 +0800 (CST)
Received: from kwepemi500026.china.huawei.com (unknown [7.221.188.247])
 by mail.maildlp.com (Postfix) with ESMTPS id 664431402C6;
 Sun, 17 Mar 2024 16:37:32 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 16:37:31 +0800
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Igor
 Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>
CC: <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
 <jiangkunkun@huawei.com>, <salil.mehta@huawei.com>
Subject: [PATCH v1 1/2] system/cpus: Fix pause_all_vcpus() under concurrent
 environment
Date: Sun, 17 Mar 2024 16:37:03 +0800
Message-ID: <20240317083704.23244-2-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20240317083704.23244-1-zhukeqian1@huawei.com>
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhukeqian1@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Keqian Zhu <zhukeqian1@huawei.com>
From:  Keqian Zhu via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Both main loop thread and vCPU thread are allowed to call
pause_all_vcpus(), and in general resume_all_vcpus() is called
after it. Two issues live in pause_all_vcpus():

1. There is possibility that during thread T1 waits on
qemu_pause_cond with bql unlocked, other thread has called
pause_all_vcpus() and resume_all_vcpus(), then thread T1 will
stuck, because the condition all_vcpus_paused() is always false.

2. After all_vcpus_paused() has been checked as true, we will
unlock bql to relock replay_mutex. During the bql was unlocked,
the vcpu's state may has been changed by other thread, so we
must retry.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 system/cpus.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 68d161d96b..4e41abe23e 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -571,12 +571,14 @@ static bool all_vcpus_paused(void)
     return true;
 }
 
-void pause_all_vcpus(void)
+static void request_pause_all_vcpus(void)
 {
     CPUState *cpu;
 
-    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
+        if (cpu->stopped) {
+            continue;
+        }
         if (qemu_cpu_is_self(cpu)) {
             qemu_cpu_stop(cpu, true);
         } else {
@@ -584,6 +586,14 @@ void pause_all_vcpus(void)
             qemu_cpu_kick(cpu);
         }
     }
+}
+
+void pause_all_vcpus(void)
+{
+    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
+
+retry:
+    request_pause_all_vcpus();
 
     /* We need to drop the replay_lock so any vCPU threads woken up
      * can finish their replay tasks
@@ -592,14 +602,23 @@ void pause_all_vcpus(void)
 
     while (!all_vcpus_paused()) {
         qemu_cond_wait(&qemu_pause_cond, &bql);
-        CPU_FOREACH(cpu) {
-            qemu_cpu_kick(cpu);
-        }
+        /* During we waited on qemu_pause_cond the bql was unlocked,
+         * the vcpu's state may has been changed by other thread, so
+         * we must request the pause state on all vcpus again.
+         */
+        request_pause_all_vcpus();
     }
 
     bql_unlock();
     replay_mutex_lock();
     bql_lock();
+
+    /* During the bql was unlocked, the vcpu's state may has been
+     * changed by other thread, so we must retry.
+     */
+    if (!all_vcpus_paused()) {
+        goto retry;
+    }
 }
 
 void cpu_resume(CPUState *cpu)
-- 
2.33.0


