Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC8BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 07:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0G8p-0001hP-LA; Fri, 26 Apr 2024 03:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1s0G8E-0001JQ-Iz; Fri, 26 Apr 2024 03:36:35 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiongyining1480@phytium.com.cn>)
 id 1s0G89-0002VW-G8; Fri, 26 Apr 2024 03:36:30 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnFwhqWStmB_j1CQ--.74S2;
 Fri, 26 Apr 2024 15:36:10 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAH2EtlWStmgmcAAA--.464S4;
 Fri, 26 Apr 2024 15:36:08 +0800 (CST)
From: Xiong Yining <xiongyining1480@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org,
 xiongyining1480 <xiongyining1480@phytium.com.cn>
Subject: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine
Date: Fri, 26 Apr 2024 07:35:53 +0000
Message-Id: <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAH2EtlWStmgmcAAA--.464S4
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQAHBmYqsHgCMQAAs3
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=xiongyinin
 g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw1fuw17CF4rXrWxurWxJFb_yoW5trWkpr
 4UKF9IvrWxCrnIvw4fW3W29FyrWw4Fqw47Aw47KrWrCwnxG34xXF40yryFkr1UWrn7uFy5
 uF4DCFyFgayvvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=xiongyining1480@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: xiongyining1480 <xiongyining1480@phytium.com.cn>

Enable CPU cluster support on SbsaQemu platform, so that users can
specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And
this topology can be passed to the firmware through DT cpu-map.

Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 docs/system/arm/sbsa.rst |  4 ++++
 hw/arm/sbsa-ref.c        | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index 2bf22a1d0b..783b87cad7 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -62,6 +62,7 @@ The devicetree reports:
    - platform version
    - GIC addresses
    - NUMA node id for CPUs and memory
+   - CPU topology information
 
 Platform version
 ''''''''''''''''
@@ -88,3 +89,6 @@ Platform version changes:
 
 0.3
   The USB controller is an XHCI device, not EHCI.
+
+0.4
+  CPU topology information is present in devicetree
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f5709d6c14..0c2ebe0417 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -210,7 +210,7 @@ static void create_fdt(SBSAMachineState *sms)
      *                        fw compatibility.
      */
     qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
-    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 3);
+    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 4);
 
     if (ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -264,9 +264,43 @@ static void create_fdt(SBSAMachineState *sms)
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
+        qemu_fdt_setprop_cell(sms->fdt, nodename, "phandle",
+                        qemu_fdt_alloc_phandle(sms->fdt));
+
         g_free(nodename);
     }
 
+    /*
+     * Add vCPU topology description through fdt node cpu-map.
+     * See fdt_add_cpu_nodes() on hw/arm/virt.c for longer description.
+     */
+    qemu_fdt_add_subnode(sms->fdt, "/cpus/cpu-map");
+
+    for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
+        char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
+        char *map_path;
+
+        if (ms->smp.threads > 1) {
+            map_path = g_strdup_printf(
+                "/cpus/cpu-map/socket%d/cluster%d/core%d/thread%d",
+                cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads),
+                (cpu / (ms->smp.cores * ms->smp.threads)) % ms->smp.clusters,
+                (cpu / ms->smp.threads) % ms->smp.cores,
+                cpu % ms->smp.threads);
+        } else {
+            map_path = g_strdup_printf(
+                "/cpus/cpu-map/socket%d/cluster%d/core%d",
+                cpu / (ms->smp.clusters * ms->smp.cores),
+                (cpu / ms->smp.cores) % ms->smp.clusters,
+                cpu % ms->smp.cores);
+        }
+        qemu_fdt_add_path(sms->fdt, map_path);
+        qemu_fdt_setprop_phandle(sms->fdt, map_path, "cpu", cpu_path);
+
+        g_free(map_path);
+        g_free(cpu_path);
+    }
+
     sbsa_fdt_add_gic_node(sms);
 }
 
@@ -886,6 +920,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
     mc->default_cpus = 4;
+    mc->smp_props.clusters_supported = true;
     mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
-- 
2.34.1


