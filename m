Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F48C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpSNA-0000C7-8R; Tue, 04 Mar 2025 08:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMs-00008X-FN; Tue, 04 Mar 2025 08:31:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMp-0004Yl-8a; Tue, 04 Mar 2025 08:31:30 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 137325C5C20;
 Tue,  4 Mar 2025 13:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85786C4AF09;
 Tue,  4 Mar 2025 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741095076;
 bh=Rwv2wLoIBvRhAgKWWClzSANMSkoeu+rvgHxKTeUDCH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RyBfluVh9AW1heRqsBLhFvuaz0KG7lK04XJMzCj2ULOWmlEcGb9Kj1BHCQHNyc7ZS
 85kXmjZToHjgfBNYI+kdhpZB7l9eNgL8rxPiWXJKr7CAnjj8swadsQwpwQVpFoQ8ky
 S32mbEliW+SLn3AMdEyHyDZXCrGnEdxXr7xOiqrzAF3Axab39wSp3P8z2KJ7baPiEy
 nqTbiyB/EjINL9zbKuXvV9xtgzo1mY5CUP+h02xEPlK5yR/adInpR06ZP9NteXsyph
 vxLVSpT0pEU79ZgQOroMQ9a5plYypgBz53F0rwr0x1GmHdwNu9nlhjVyHiHPXWy/EQ
 8p35LbpnceRNw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tpSMc-00000005rnX-28Ap; Tue, 04 Mar 2025 14:31:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/3] Add a GED device for RAS notification
Date: Tue,  4 Mar 2025 14:30:58 +0100
Message-ID: <453dbc6c5030c654489d3c7e4da078589f24f9ec.1741094512.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741094512.git.mchehab+huawei@kernel.org>
References: <cover.1741094512.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/i386/acpi-build.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c          |  7 +++----
 include/hw/i386/x86.h |  2 ++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cf11231b5fe6..ad829e2c75c8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1352,6 +1352,28 @@ static void build_acpi0017(Aml *table)
     aml_append(table, scope);
 }
 
+#define GED_COMMON_MMIO_BASE         0xfee00000
+#define GED_COMMON_MMIO_BASE_REGS    (GED_COMMON_MMIO_BASE + 0x100)
+#define GED_MMIO_IRQ          9
+
+static DeviceState *create_acpi_ged(X86MachineState *x86ms)
+{
+    DeviceState *dev = qdev_new(TYPE_ACPI_GED);
+
+    fprintf(stderr, "creating GED\n");
+
+    assert(x86ms->gsi);
+
+    qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_ERROR_EVT);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_COMMON_MMIO_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_COMMON_MMIO_BASE_REGS);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, x86ms->gsi[GED_MMIO_IRQ]);
+
+    return dev;
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1794,6 +1816,26 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, scope);
     }
 
+    /* Notification type SCI requires GED */
+    if (pcms->ras) {
+        if (!x86ms->ged_dev) {
+            x86ms->ged_dev = create_acpi_ged(x86ms);
+        }
+
+        sb_scope = aml_scope("_SB");
+        build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(x86ms->ged_dev),
+                      GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_COMMON_MMIO_BASE);
+        aml_append(sb_scope, aml_error_device());
+        aml_append(dsdt, sb_scope);
+
+        scope =  aml_scope("_GPE");
+        method = aml_method("L08", 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_notify(aml_name("\\_SB.GEDD"),
+                                      aml_int(0x80)));
+        aml_append(scope, method);
+        aml_append(dsdt, scope);
+    }
+
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
     acpi_table_end(linker, &table);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b9c32dbdbcd8..b4a2fe61da49 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1700,6 +1700,8 @@ static void virt_set_ras(Object *obj, bool value, Error **errp)
 
 static void pc_sci_error(Notifier *n, void *opaque)
 {
+    PCMachineState *pcms = container_of(n, PCMachineState, ghes_sci_notifier);
+    X86MachineState *x86ms = X86_MACHINE(pcms);
     uint16_t *source_id = opaque;
 
     fprintf(stderr, "GHES error for source ID: %d\n", *source_id);
@@ -1710,10 +1712,7 @@ static void pc_sci_error(Notifier *n, void *opaque)
 
     fprintf(stderr, "GHES error notified for QMP\n");
 
-    // TODO: add something equivalent to:
-    // PCMachineState *s = container_of(n, PCMachineState, ghes_sci_notifier);
-    // acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
-    // by calling acpi_update_sci();
+    acpi_send_event(x86ms->ged_dev, ACPI_GENERIC_ERROR);
 }
 
 static void pc_machine_initfn(Object *obj)
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d43cb3908e65..06d62a944835 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -54,6 +54,8 @@ struct X86MachineState {
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
 
+    DeviceState *ged_dev;
+
     /*
      * Map the whole BIOS just underneath the 4 GiB address boundary. Only used
      * in the ROM (-bios) case.
-- 
2.48.1


