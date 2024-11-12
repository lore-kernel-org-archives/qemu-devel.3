Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88231D42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuKi-0006vU-LA; Tue, 12 Nov 2024 12:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIa-0003Vc-6Y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIW-0001ZP-Re
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731431003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5hW+ko2CvgJ136Iuxuu+60x4pzVtirtMo/NDTCH6Ko=;
 b=NGXlCIHOYw4RZRXOkJcxPWW6/71sGk9OeDCOFv06jqmo/8goUiIdufSbhUWYPpgCOKCYyL
 rrDXh2ICfTcw6BuNTCsrk5L+S5NB3hi46OW4KH3v5att6l2vV3qkBdU5D9KihJacNXunGW
 ogSviZ1wdAfUUJWNyZnpebo5f+jyv1s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-TX2hogeKP4ShvciahbDvyQ-1; Tue,
 12 Nov 2024 12:03:13 -0500
X-MC-Unique: TX2hogeKP4ShvciahbDvyQ-1
X-Mimecast-MFC-AGG-ID: TX2hogeKP4ShvciahbDvyQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4238119560B0; Tue, 12 Nov 2024 17:03:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 924001956086; Tue, 12 Nov 2024 17:03:09 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: salil.mehta@huawei.com, mst@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, anisinha@redhat.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: [PATCH 2/7 for-9.2] Revert "hw/acpi: Update ACPI `_STA` method with
 QOM vCPU ACPI Hotplug states"
Date: Tue, 12 Nov 2024 18:02:53 +0100
Message-ID: <20241112170258.2996640-3-imammedo@redhat.com>
In-Reply-To: <20241112170258.2996640-1-imammedo@redhat.com>
References: <20241112170258.2996640-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit bf1ecc8dad6061914730a2a2d57af6b37c3a4f8d
which broke cpu hotplug in x86 after migration to older QEMU

Fixes: bf1ecc8dad606 (w/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug states)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/core/cpu.h |  1 -
 hw/acpi/cpu.c         | 38 ++++----------------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db8a6fbc6e..e7de77dc6d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -159,7 +159,6 @@ struct CPUClass {
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
     bool (*cpu_persistent_status)(CPUState *cpu);
-    bool (*cpu_enabled_status)(CPUState *cpu);
     void (*set_pc)(CPUState *cpu, vaddr value);
     vaddr (*get_pc)(CPUState *cpu);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 23443f09a5..9b03b4292e 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -50,18 +50,6 @@ void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
     }
 }
 
-static bool check_cpu_enabled_status(DeviceState *dev)
-{
-    CPUClass *k = dev ? CPU_GET_CLASS(dev) : NULL;
-    CPUState *cpu = CPU(dev);
-
-    if (cpu && (!k->cpu_enabled_status || k->cpu_enabled_status(cpu))) {
-        return true;
-    }
-
-    return false;
-}
-
 static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
 {
     uint64_t val = 0;
@@ -75,11 +63,10 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
     cdev = &cpu_st->devs[cpu_st->selector];
     switch (addr) {
     case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
-        val |= check_cpu_enabled_status(DEVICE(cdev->cpu)) ? 1 : 0;
+        val |= cdev->cpu ? 1 : 0;
         val |= cdev->is_inserting ? 2 : 0;
         val |= cdev->is_removing  ? 4 : 0;
         val |= cdev->fw_remove  ? 16 : 0;
-        val |= cdev->cpu ? 32 : 0;
         trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
         break;
     case ACPI_CPU_CMD_DATA_OFFSET_RW:
@@ -362,7 +349,6 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_REMOVE_EVENT  "CRMV"
 #define CPU_EJECT_EVENT   "CEJ0"
 #define CPU_FW_EJECT_EVENT "CEJF"
-#define CPU_PRESENT       "CPRS"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
@@ -423,9 +409,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
         /* tell firmware to do device eject, write only */
         aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
-        /* 1 if present, read only */
-        aml_append(field, aml_named_field(CPU_PRESENT, 1));
-        aml_append(field, aml_reserved_field(2));
+        aml_append(field, aml_reserved_field(3));
         aml_append(field, aml_named_field(CPU_COMMAND, 8));
         aml_append(cpu_ctrl_dev, field);
 
@@ -455,7 +439,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
         Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
         Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
-        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
         Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
         Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
         Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
@@ -484,26 +467,13 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         {
             Aml *idx = aml_arg(0);
             Aml *sta = aml_local(0);
-            Aml *ifctx2;
-            Aml *else_ctx;
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(idx, cpu_selector));
             aml_append(method, aml_store(zero, sta));
-            ifctx = aml_if(aml_equal(is_present, one));
+            ifctx = aml_if(aml_equal(is_enabled, one));
             {
-                ifctx2 = aml_if(aml_equal(is_enabled, one));
-                {
-                    /* cpu is present and enabled */
-                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
-                }
-                aml_append(ifctx, ifctx2);
-                else_ctx = aml_else();
-                {
-                    /* cpu is present but disabled */
-                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
-                }
-                aml_append(ifctx, else_ctx);
+                aml_append(ifctx, aml_store(aml_int(0xF), sta));
             }
             aml_append(method, ifctx);
             aml_append(method, aml_release(ctrl_lock));
-- 
2.43.0


