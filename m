Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E62CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDe-0004QH-QP; Fri, 17 Oct 2025 09:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDR-0003uQ-NI
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDA-0004cA-1U
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1805658f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706572; x=1761311372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIMpzyrAOcPtBPGdInfo4s/SrMi0/0YFf+KlykEpc/A=;
 b=Gu0rETGA9YAW9KSmV1MFUOMxC0lwdl15VZJdUjKqX7+3JCtQ39c5AFh6Zc30WuNtMH
 RgZ4r8zPbYFQrcAzomwJnASJE37XF79UzUr9hvc0LzSQbJXf+p8h0uhgC62F9eFhdanG
 Q3aqoA09JLYGt0qukPKqsJyEh+dqDz123jccoB6dYKL2IqQIDzE2NHhvR9yc9QRMwNpn
 4hsnEZj/6LedjWJSR+3t7zMzSQZYLlWi7Gmttgvf4A1kmFDo6O4+t+VnUq9PWHGEPosb
 7gyHc0Oclk/PhyaiAp8giYPpHytmleInpjtZG3jPIkxJDlm/pFV7/4qOn2emux9hpI4g
 MHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706572; x=1761311372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIMpzyrAOcPtBPGdInfo4s/SrMi0/0YFf+KlykEpc/A=;
 b=nyn1gkiH6Tq77FrtSVdrN/W/Njpfb8fvS+RAIUhXRmC/gGcpD6aEBqqaQAtJ5ZQ7TB
 Jv+CpltiUhb06BoM1c5/cfJJ3vRgL7X4pR4tgJqkpSZGdBS7m/6+HcPb03LcoAdEdF2h
 /XK+3WRdaJlJNzsewxQ3qeLfzK4XcaxzhIqV01BmWc7UvDvNMaTvpw/DjQl+RISK8FMt
 fajumitDX2HiVWsPc2O2jFd+shZZVqsKe6HyYr/S/O+LGMf5ED8thannRDuddD2uKAS/
 v4DTAeFGfHx2zBnIuea1C7ZKj9XLAL3tvJZGChchx02azYYm/ArOHucxvsAlPijaoFdk
 oODg==
X-Gm-Message-State: AOJu0YwH943IEFW4/bZyDGF8TYvq4u2gcfCekv9nBwj8oLdfoS+Ae7M0
 4PeLQizxCnmmr1dj56Yw7cfUNqvyb7WvZFuDU4/er52iipROWbM4ntuQ3LZicriwIYQa9uSHgVd
 5T0ojL+M=
X-Gm-Gg: ASbGncs8sbUM4W45I37jdkiLEwNA84WhFCP+PZLSzUVh/s/auU3p6wDHSODPQv+LO7g
 f6BeaCBWpxRRlUJtwFRm0YUAFpYwj2vh5ulSmGM2yUeH+YMJSHLXRiqRMHCqxS6IkMa9EUasQXh
 GrdgcyExI0w3sB1J9FhGp8FCh2D5+UfASrO2M0n627fUW7As0S2K/XkliH68hAz7sayIrpZmSKp
 kVYlcg5SIuyGPFr65nGYOk89bfBO+XjIcXSjx31P6ISGEXiN7p0HoIPaZDKccsVuQfa4abJfKHm
 mLN7KOcZWEGEJ2wo0p+ytXCbTqCEQhh5gO6KLkPRYmV122JYnV97cJ8O5uWMbUEIX7UIEe/Sa4i
 cBt6jeJxfXeq2EFBwRDOIKoPd8ygeqK3q3O2c/sTH3VxD9gpaOEORLIYxiVCByAMONhCWXDcaaV
 x/R8q2ay4B5fc/lp4ef/EQ66hI3J6mVfRspjX5Mzwu9owZzP9kDUa0M3W35TSQ
X-Google-Smtp-Source: AGHT+IEon46n634LcQ0NffQPGicHLJ4Uhp3AY22+O9e4mNcOr9dtEGd+houpek1WXCHRCcvEVx5I9w==
X-Received: by 2002:a05:6000:1868:b0:401:c55d:2d20 with SMTP id
 ffacd0b85a97d-426fb9b52f5mr5123154f8f.26.1760706572137; 
 Fri, 17 Oct 2025 06:09:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f975sm83398975e9.4.2025.10.17.06.09.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/20] hw/arm/virt: Remove VirtMachineClass::no_cpu_topology
 field
Date: Fri, 17 Oct 2025 15:08:13 +0200
Message-ID: <20251017130821.58388-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The VirtMachineClass::no_cpu_topology field was
only used by virt-6.1 machine, which got removed.
Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h    |  2 -
 hw/arm/virt-acpi-build.c |  9 ++---
 hw/arm/virt.c            | 85 +++++++++++++++++++---------------------
 3 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 21d91a43d8b..ca2e59ec569 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -122,8 +122,6 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     bool no_highmem_compact;
-    /* Machines < 6.2 have no support for describing cpu topology to guest */
-    bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5db5baa7cf3..8d40570c1e3 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1110,7 +1110,6 @@ static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
@@ -1134,11 +1133,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, vms);
 
-    if (!vmc->no_cpu_topology) {
-        acpi_add_table(table_offsets, tables_blob);
-        build_pptt(tables_blob, tables->linker, ms,
-                   vms->oem_id, vms->oem_table_id);
-    }
+    acpi_add_table(table_offsets, tables_blob);
+    build_pptt(tables_blob, tables->linker, ms,
+               vms->oem_id, vms->oem_table_id);
 
     acpi_add_table(table_offsets, tables_blob);
     build_gtdt(tables_blob, tables->linker, vms);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3e7858d6e11..4243da3c87e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -431,7 +431,6 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     int cpu;
     int addr_cells = 1;
     const MachineState *ms = MACHINE(vms);
-    const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int smp_cpus = ms->smp.cpus;
 
     /*
@@ -488,57 +487,53 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
-        if (!vmc->no_cpu_topology) {
-            qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
-                                  qemu_fdt_alloc_phandle(ms->fdt));
-        }
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
+                              qemu_fdt_alloc_phandle(ms->fdt));
 
         g_free(nodename);
     }
 
-    if (!vmc->no_cpu_topology) {
-        /*
-         * Add vCPU topology description through fdt node cpu-map.
-         *
-         * See Linux Documentation/devicetree/bindings/cpu/cpu-topology.txt
-         * In a SMP system, the hierarchy of CPUs can be defined through
-         * four entities that are used to describe the layout of CPUs in
-         * the system: socket/cluster/core/thread.
-         *
-         * A socket node represents the boundary of system physical package
-         * and its child nodes must be one or more cluster nodes. A system
-         * can contain several layers of clustering within a single physical
-         * package and cluster nodes can be contained in parent cluster nodes.
-         *
-         * Note: currently we only support one layer of clustering within
-         * each physical package.
-         */
-        qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
+    /*
+     * Add vCPU topology description through fdt node cpu-map.
+     *
+     * See Linux Documentation/devicetree/bindings/cpu/cpu-topology.txt
+     * In a SMP system, the hierarchy of CPUs can be defined through
+     * four entities that are used to describe the layout of CPUs in
+     * the system: socket/cluster/core/thread.
+     *
+     * A socket node represents the boundary of system physical package
+     * and its child nodes must be one or more cluster nodes. A system
+     * can contain several layers of clustering within a single physical
+     * package and cluster nodes can be contained in parent cluster nodes.
+     *
+     * Note: currently we only support one layer of clustering within
+     * each physical package.
+     */
+    qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
 
-        for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
-            char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
-            char *map_path;
+    for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
+        char *cpu_path = g_strdup_printf("/cpus/cpu@%d", cpu);
+        char *map_path;
 
-            if (ms->smp.threads > 1) {
-                map_path = g_strdup_printf(
-                    "/cpus/cpu-map/socket%d/cluster%d/core%d/thread%d",
-                    cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads),
-                    (cpu / (ms->smp.cores * ms->smp.threads)) % ms->smp.clusters,
-                    (cpu / ms->smp.threads) % ms->smp.cores,
-                    cpu % ms->smp.threads);
-            } else {
-                map_path = g_strdup_printf(
-                    "/cpus/cpu-map/socket%d/cluster%d/core%d",
-                    cpu / (ms->smp.clusters * ms->smp.cores),
-                    (cpu / ms->smp.cores) % ms->smp.clusters,
-                    cpu % ms->smp.cores);
-            }
-            qemu_fdt_add_path(ms->fdt, map_path);
-            qemu_fdt_setprop_phandle(ms->fdt, map_path, "cpu", cpu_path);
-
-            g_free(map_path);
-            g_free(cpu_path);
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
         }
+        qemu_fdt_add_path(ms->fdt, map_path);
+        qemu_fdt_setprop_phandle(ms->fdt, map_path, "cpu", cpu_path);
+
+        g_free(map_path);
+        g_free(cpu_path);
     }
 }
 
-- 
2.51.0


