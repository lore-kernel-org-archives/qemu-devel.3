Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35577CFC283
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eVR-0007T6-LE; Tue, 15 Oct 2024 06:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eUb-0006zm-Ai; Tue, 15 Oct 2024 06:09:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eUZ-0002WC-It; Tue, 15 Oct 2024 06:09:29 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSVDf3Bchz6K98R;
 Tue, 15 Oct 2024 18:08:50 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 93A68140451;
 Tue, 15 Oct 2024 18:09:24 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:09:04 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <eric.auger@redhat.com>,
 <will@kernel.org>, <ardb@kernel.org>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V5 25/30] tcg/mttcg: Introduce MTTCG thread unregistration
 leg
Date: Tue, 15 Oct 2024 11:00:07 +0100
Message-ID: <20241015100012.254223-26-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015100012.254223-1-salil.mehta@huawei.com>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.149]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Miguel Luis <miguel.luis@oracle.com>

Introduce the TCG thread unregistration leg which shall be called in context to
TCG/vCPU unrealize.

Reported-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 accel/tcg/tcg-accel-ops-mttcg.c |  1 +
 include/tcg/startup.h           |  7 +++++++
 tcg/tcg.c                       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index ab2f79d2c7..4b26164ffd 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -122,6 +122,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     bql_unlock();
     rcu_remove_force_rcu_notifier(&force_rcu.notifier);
     rcu_unregister_thread();
+    tcg_unregister_thread();
     return NULL;
 }
 
diff --git a/include/tcg/startup.h b/include/tcg/startup.h
index a565071516..c035d03f7e 100644
--- a/include/tcg/startup.h
+++ b/include/tcg/startup.h
@@ -51,6 +51,13 @@ void tcg_register_thread(void);
 void tcg_register_thread(CPUState *cpu);
 #endif
 
+/**
+ * tcg_unregister_thread: Unregister this thread with the TCG runtime
+ *
+ * This leg shall be called whenever TCG vCPU is hot-unplugged
+ */
+void tcg_unregister_thread(void);
+
 /**
  * tcg_prologue_init(): Generate the code for the TCG prologue
  *
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5e9c6b2b4b..3bdebdb332 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -811,6 +811,39 @@ void tcg_register_thread(CPUState *cpu)
 
     tcg_ctx = s;
 }
+
+static void tcg_free_plugin_context(TCGContext *s)
+{
+#ifdef CONFIG_PLUGIN
+    unsigned i;
+
+    if (s->plugin_tb) {
+        for (i = 0; i < s->plugin_tb->insns->len; i++) {
+            g_free(g_ptr_array_index(s->plugin_tb->insns, i));
+        }
+        g_ptr_array_free(s->plugin_tb->insns, TRUE);
+
+        if (!s->plugin_tb->insns) {
+            g_free(s->plugin_tb);
+        }
+    }
+#endif
+}
+
+void tcg_unregister_thread(void)
+{
+    TCGContext *s = tcg_ctx;
+    unsigned int n;
+
+    /* unclaim an entry in tcg_ctxs */
+    n = qatomic_fetch_dec(&tcg_cur_ctxs);
+    g_assert(n > 1);
+    qatomic_store_release(&tcg_ctxs[n - 1], 0);
+
+    tcg_free_plugin_context(s);
+
+    g_free(s);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 /* pool based memory allocation */
-- 
2.34.1


