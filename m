Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2CCC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0Hm-0006eg-W0; Wed, 16 Jul 2025 07:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0CD-0001l0-LS; Wed, 16 Jul 2025 07:21:09 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0CB-00013U-7B; Wed, 16 Jul 2025 07:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752664813; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h56aqE1lIb4fXncE8zwikK5HSfeEQ27frip9S/5rz1s4+TAojxpIKXq2D+uFerkOUOZZ6IRu4DM9AT28YnM6qN5mjDLUfT3N2o5BI/tNlw73Tx3SKLR9Z9aY0VyVFmJHx7Xx2eMjH9cc1YGQTtKjeUtLZaOxgLPoFOxfvQCraBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752664813;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PbWXELrNFK36KaZSrte+NesZIbPeFodr3uFNaBSeM1c=; 
 b=IOAJ9X+mQYjZu6xNpcG+OcfoOvaXVXIiIR/QaNTLc9uDh2RT36YXFPhVWOfHTI+G+TaZko+r/NpL3XpGZ3j2jabVr+31bU6Cot9M94/QUd/eDafNVon4UUmjewKtRjk8otOikmV4c0wGW4vK9le7k5qqMeQpqORuoNnCmiYlovo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752664813; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=PbWXELrNFK36KaZSrte+NesZIbPeFodr3uFNaBSeM1c=;
 b=h47/argpBUdI3AXPYWmWqiB7+uk/6tPQPmfGRQg14THTlDNVE2viT4CunIBivE7B
 im4yz6hqBBzo/pg5eZJGHwGgUWSEhGKwgdzNZr4izDeyqkxzJNHpZ1RlDuv/R7cf2Em
 kEYcMO2orOrfNZSgRPPfceN0+Wxs8j0NZpzz40a4=
Received: by mx.zohomail.com with SMTPS id 175266481068276.30808314738442;
 Wed, 16 Jul 2025 04:20:10 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Song Gao" <gaosong@loongson.cn>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Cc: Bibo Mao <maobibo@loongson.cn>,
	Gavin Shan <gshan@redhat.com>
Subject: [PATCH v5 1/4] acpi: Add machine option to disable SPCR table
Date: Wed, 16 Jul 2025 19:19:53 +0800
Message-ID: <20250716111959.404917-2-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716111959.404917-1-me@linux.beauty>
References: <20250716111959.404917-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112; envelope-from=me@linux.beauty;
 helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Li Chen <chenl311@chinatelecom.cn>

The ACPI SPCR (Serial Port Console Redirection) table allows firmware
to specify a preferred serial console device to the operating system.
On ARM64 systems, Linux by default respects this table: even if the
kernel command line does not include a hardware serial console (e.g.,
"console=ttyAMA0"), the kernel still register the serial device
referenced by SPCR as a printk console.

While this behavior is standard-compliant, it can lead to situations
where guest console behavior is influenced by platform firmware rather
than user-specified configuration. To make guest console behavior more
predictable and under user control, this patch introduces a machine
option to explicitly disable SPCR table exposure:

    -machine spcr=off

By default, the option is enabled (spcr=on), preserving existing
behavior. When disabled, QEMU will omit the SPCR table from the guest's
ACPI namespace, ensuring that only consoles explicitly declared in the
kernel command line are registered.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---

Notes:
Changes since v3: 1. Add Reviewed-by from Sunil V L <sunilvl@ventanamicro.com>
2. rename enable_spcr to acpi_spcr_enabled as
suggested by Philippe Mathieu-Daudé
Changes since V2: Add Reviewed-by from Gavin Shan <gshan@redhat.com>
for the first patch and fix style issue.
Changes since V1: add Reviewed-by and Acked-by

 hw/arm/virt-acpi-build.c       |  5 ++++-
 hw/core/machine.c              | 22 ++++++++++++++++++++++
 hw/loongarch/virt-acpi-build.c |  4 +++-
 hw/riscv/virt-acpi-build.c     |  5 ++++-
 include/hw/boards.h            |  1 +
 qemu-options.hx                |  5 +++++
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0dfb8ec2c3..782b17b966 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1023,7 +1023,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, vms);
+
+    if (ms->acpi_spcr_enabled) {
+        spcr_setup(tables_blob, tables->linker, vms);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     build_dbg2(tables_blob, tables->linker, vms);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e869821b22..ceee058cad 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -577,6 +577,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
     ms->nvdimms_state->is_enabled = value;
 }
 
+static bool machine_get_spcr(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->acpi_spcr_enabled;
+}
+
+static void machine_set_spcr(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->acpi_spcr_enabled = value;
+}
+
 static bool machine_get_hmat(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1281,6 +1295,14 @@ static void machine_initfn(Object *obj)
                                         "Table (HMAT)");
     }
 
+    /* SPCR */
+    ms->acpi_spcr_enabled = true;
+    object_property_add_bool(obj, "spcr", machine_get_spcr, machine_set_spcr);
+    object_property_set_description(obj, "spcr",
+                                   "Set on/off to enable/disable "
+                                   "ACPI Serial Port Console Redirection "
+                                   "Table (spcr)");
+
     /* default to mc->default_cpus */
     ms->smp.cpus = mc->default_cpus;
     ms->smp.max_cpus = mc->default_cpus;
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 2cd2d9d842..8c2228a772 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -557,7 +557,9 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, machine);
+
+    if (machine->acpi_spcr_enabled)
+        spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
         if (machine->numa_state->have_numa_distance) {
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8b5683dbde..ee1416d264 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -894,7 +894,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, s);
+
+    if (ms->acpi_spcr_enabled) {
+        spcr_setup(tables_blob, tables->linker, s);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f424b2b505..f94713e6e2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -443,6 +443,7 @@ struct MachineState {
     SmpCache smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
+    bool acpi_spcr_enabled;
 };
 
 /*
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a6..9b2d5f4b7a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
+    "                spcr=on|off controls ACPI SPCR support (default=on)\n"
 #ifdef CONFIG_POSIX
     "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
 #endif
@@ -105,6 +106,10 @@ SRST
         Enables or disables ACPI Heterogeneous Memory Attribute Table
         (HMAT) support. The default is off.
 
+    ``spcr=on|off``
+        Enables or disables ACPI Serial Port Console Redirection Table
+        (SPCR) support. The default is on.
+
     ``aux-ram-share=on|off``
         Allocate auxiliary guest RAM as an anonymous file that is
         shareable with an external process.  This option applies to
-- 
2.50.0


