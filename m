Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B217AC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgBw-0007It-Df; Tue, 16 Jul 2024 07:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTgBv-0007Ex-CY; Tue, 16 Jul 2024 07:17:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTgBm-0001sA-SK; Tue, 16 Jul 2024 07:17:55 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WNc282wfnz6K66M;
 Tue, 16 Jul 2024 19:16:00 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id C7191140119;
 Tue, 16 Jul 2024 19:17:44 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.170.92) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 12:17:26 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <npiggin@gmail.com>, <harshpb@linux.ibm.com>, <linuxarm@huawei.com>, Shaoqin
 Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH V16 7/7] gdbstub: Add helper function to unregister GDB
 register space
Date: Tue, 16 Jul 2024 12:15:02 +0100
Message-ID: <20240716111502.202344-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716111502.202344-1-salil.mehta@huawei.com>
References: <20240716111502.202344-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.170.92]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add common function to help unregister the GDB register space. This shall be
done in context to the CPU unrealization.

Note: These are common functions exported to arch specific code. For example,
for ARM this code is being referred in associated arch specific patch-set:

Link: https://lore.kernel.org/qemu-devel/20230926103654.34424-1-salil.mehta@huawei.com/

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 gdbstub/gdbstub.c      | 13 +++++++++++++
 hw/core/cpu-common.c   |  5 ++++-
 include/exec/gdbstub.h |  6 ++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b9ad0a063e..5da17d6530 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -618,6 +618,19 @@ void gdb_register_coprocessor(CPUState *cpu,
     }
 }
 
+void gdb_unregister_coprocessor_all(CPUState *cpu)
+{
+    /*
+     * Safe to nuke everything. GDBRegisterState::xml is static const char so
+     * it won't be freed
+     */
+    g_array_free(cpu->gdb_regs, true);
+
+    cpu->gdb_regs = NULL;
+    cpu->gdb_num_regs = 0;
+    cpu->gdb_num_g_regs = 0;
+}
+
 static void gdb_process_breakpoint_remove_all(GDBProcess *p)
 {
     CPUState *cpu = gdb_get_first_cpu_in_process(p);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index b19e1fdacf..f6d62df34f 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -281,7 +281,10 @@ static void cpu_common_finalize(Object *obj)
         g_free(cpu->plugin_state);
     }
 #endif
-    g_array_free(cpu->gdb_regs, TRUE);
+    /* If cleanup didn't happen in context to gdb_unregister_coprocessor_all */
+    if (cpu->gdb_regs) {
+        g_array_free(cpu->gdb_regs, TRUE);
+    }
     qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
     qemu_mutex_destroy(&cpu->work_mutex);
     qemu_cond_destroy(cpu->halt_cond);
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 1bd2c4ec2a..d73f424f56 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -40,6 +40,12 @@ void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               const GDBFeature *feature, int g_pos);
 
+/**
+ * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
+ * @cpu - the CPU associated with registers
+ */
+void gdb_unregister_coprocessor_all(CPUState *cpu);
+
 /**
  * gdbserver_start: start the gdb server
  * @port_or_device: connection spec for gdb
-- 
2.34.1


