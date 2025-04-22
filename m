Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE53C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7DLj-0004Ea-At; Tue, 22 Apr 2025 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7CNi-0008Bp-Sb; Tue, 22 Apr 2025 08:05:43 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7CNg-0002gX-G5; Tue, 22 Apr 2025 08:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745323516; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a9OPHnVQp39RcTCyqL3IuqMeU89cnqLCsZMhesRMs70NgUTl4Vq7/FaUtpXjqBIiwI+HdWnAA9ciwNDyfdNl2KExZ7OtRtcKgv5qoxbk6P0Py22b1qOXz8isc1X/NRSvQtJLVqiXVqKVrfIf8NpQP0VAJoMHw3Tu9+0BOkJo82o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745323516;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=a9HKWYzbKhJk4qFN+8oVwSiTpsecKA5fkKccQIdUnz8=; 
 b=CM5iXclnClAD4Prbw78HMBax90gCu6QVYq/pY9ano/ZV67pYQzqE8j1o6kUel7E/OpBpqki2ekOROFCznJpEqqbkwJ7ZegqGAxBfN15ikPlbwTA1P3SmJp+tfHBbZw3rhUhsJdK5SFNDP/1yNr786tgFF3QM5zRqAlXihS6zPWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745323516; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=a9HKWYzbKhJk4qFN+8oVwSiTpsecKA5fkKccQIdUnz8=;
 b=VaEjJR0Jn6u65cxaqoKj5zomRrRWtKxiD2ULq6lPsuZH6KjmqpDIqIs0E/gtnU0r
 b8/5ffWyJOhXRA/wyVK9wbkjYkvNzM4kopipPyWlMOowtfObjiTiLBvg9Za9c8oIuhy
 HmJR2YAnSObuxfSxWryXf4ek3JGCv0NJ8BEEhURU=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745323513788952.3340891978004;
 Tue, 22 Apr 2025 05:05:13 -0700 (PDT)
Date: Tue, 22 Apr 2025 20:05:13 +0800
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <1965d6357a1.dfa9d35b911644.778874035603636753@linux.beauty>
In-Reply-To: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
Subject: [PATCH V2 1/3] acpi: Add machine option to disable SPCR table
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Apr 2025 09:07:38 -0400
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
---

Changes since V1: add Reviewed-by and Acked-by

 hw/arm/virt-acpi-build.c       |  5 ++++-
 hw/core/machine.c              | 22 ++++++++++++++++++++++
 hw/loongarch/virt-acpi-build.c |  4 +++-
 hw/riscv/virt-acpi-build.c     |  5 ++++-
 include/hw/boards.h            |  1 +
 qemu-options.hx                |  5 +++++
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e178..f25c3b26ce 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -940,7 +940,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, vms);
+
+    if (ms->enable_spcr) {
+        spcr_setup(tables_blob, tables->linker, vms);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     build_dbg2(tables_blob, tables->linker, vms);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63c6ef93d2..d56f44f4e8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -590,6 +590,20 @@ static void machine_set_nvdimm(Object *obj, bool value, Error **errp)
     ms->nvdimms_state->is_enabled = value;
 }
 
+static bool machine_get_spcr(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->enable_spcr;
+}
+
+static void machine_set_spcr(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->enable_spcr = value;
+}
+
 static bool machine_get_hmat(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1294,6 +1308,14 @@ static void machine_initfn(Object *obj)
                                         "Table (HMAT)");
     }
 
+    /* SPCR */
+    ms->enable_spcr = true;
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
index fced6c445a..0e437bcf25 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -557,7 +557,9 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_srat(tables_blob, tables->linker, machine);
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, machine);
+
+    if (machine->enable_spcr)
+        spcr_setup(tables_blob, tables->linker, machine);
 
     if (machine->numa_state->num_nodes) {
         if (machine->numa_state->have_numa_distance) {
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 1ad6800508..7f6d221c63 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -680,7 +680,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     build_rhct(tables_blob, tables->linker, s);
 
     acpi_add_table(table_offsets, tables_blob);
-    spcr_setup(tables_blob, tables->linker, s);
+
+    if (ms->enable_spcr) {
+        spcr_setup(tables_blob, tables->linker, s);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f22b2e7fc7..cdf2791a50 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -444,6 +444,7 @@ struct MachineState {
     SmpCache smp_cache;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
+    bool enable_spcr;
 };
 
 /*
diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..953680595f 100644
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
2.49.0



