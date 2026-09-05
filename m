Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03F3C624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaN-0005J1-4S; Sat, 05 Sep 2026 13:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaJ-0005Ey-2B; Sat, 05 Sep 2026 13:53:47 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaG-0008Jx-Vj; Sat, 05 Sep 2026 13:53:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AA6C44793;
 Sat,  5 Sep 2026 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB64B1F00ADE;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=ai+qCKVGooyNyHPnec0n28qWkLpI/YR341Xh8tbfMVA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lN5bpN34Vo4ZAjzpDJ8XyoAHg0R12di3aeGoDmYSR1uNMg+dtCNlLTgUrNtd8YIPe
 2WpsMTS14ojzZLeS1CmZqnaLxFGZot8AVJ7M8rhYuq86EnLwzvqpx4Evudl4G+kFCC
 YGGwz651Gc/i6DaVGvEvYbAcMyeZ6gsJEGhljnR6FTNipPl33381EoVTiGzG9KOLlf
 fSZ6AsFs5g9Vnr6XgXEFr8aMLXLmKplW1TlnRRZsPmip+ftojTLV+RJEPE1mYhl5F4
 0uPC1rm7CoSY3MwjfWbXrNhFqjnXl7SUkg8tutiLmbQ9WZLROo4E2/y/flrdZRsxjg
 kq3qyyzyfpZpA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bkrt-3BWb; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ani Sinha <anisinha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 4/8] hw/i386: add GHES support at ICH9 and PIIX4 PM
Date: Sat,  5 Sep 2026 19:53:24 +0200
Message-ID: <b8649bce2afeef273880bac6c7a1dc4fa2d947d1.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788630333.git.mchehab+huawei@kernel.org>
References: <cover.1788630333.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Enabling GHES support on x86 means that both PIIX4 and ICH9
PM controllers need to expose ghes state.

Implement that, as suggested by Igor.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250530164134.6c666b2e@imammedo.users.ipa.redhat.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ich9.c          | 19 +++++++++++++++++++
 hw/acpi/piix4.c         | 25 +++++++++++++++++++++++++
 hw/isa/lpc_ich9.c       |  6 ++++++
 include/hw/acpi/ich9.h  |  2 ++
 include/hw/acpi/piix4.h |  2 ++
 5 files changed, 54 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5e8f8a7eafa3..7e2199891431 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -222,6 +222,24 @@ static const VMStateDescription vmstate_pcihp_state = {
     }
 };
 
+static bool ich9_hest_needed(void *opaque)
+{
+    ICH9LPCPMRegs *pm = opaque;
+
+    return pm->ghes_state.hest_addr_le != 0;
+}
+
+static const VMStateDescription vmstate_ich9_hest = {
+    .name = "ich9_pm/hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ich9_hest_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(ghes_state.hest_addr_le, ICH9LPCPMRegs),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_ich9_pm = {
     .name = "ich9_pm",
     .version_id = 1,
@@ -244,6 +262,7 @@ const VMStateDescription vmstate_ich9_pm = {
         &vmstate_tco_io_state,
         &vmstate_cpuhp_state,
         &vmstate_pcihp_state,
+        &vmstate_ich9_hest,
         NULL
     }
 };
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7afac..48fa833c66ef 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -224,6 +224,24 @@ static bool vmstate_test_migrate_acpi_index(void *opaque, int version_id)
            !s->not_migrate_acpi_index;
 }
 
+static bool piix4_hest_needed(void *opaque)
+{
+    PIIX4PMState *s = opaque;
+
+    return s->ghes_state.hest_addr_le != 0;
+}
+
+static const VMStateDescription vmstate_piix4_hest = {
+    .name = "piix4_pm/hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = piix4_hest_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(ghes_state.hest_addr_le, PIIX4PMState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* qemu-kvm 1.2 uses version 3 but advertised as 2
  * To support incoming qemu-kvm 1.2 migration, change version_id
  * and minimum_version_id to 2 below (which breaks migration from
@@ -259,6 +277,7 @@ static const VMStateDescription vmstate_acpi = {
     .subsections = (const VMStateDescription * const []) {
          &vmstate_memhp_state,
          &vmstate_cpuhp_state,
+         &vmstate_piix4_hest,
          NULL
     }
 };
@@ -551,6 +570,11 @@ static void piix4_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     acpi_cpu_ospm_status(&s->cpuhp_state, list);
 }
 
+static AcpiGhesState *piix4_get_ghes_state(AcpiDeviceIf *adev)
+{
+    return &PIIX4_PM(adev)->ghes_state;
+}
+
 static void piix4_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 {
     PIIX4PMState *s = PIIX4_PM(adev);
@@ -607,6 +631,7 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+    adevc->get_ghes_state = piix4_get_ghes_state;
 }
 
 static const TypeInfo piix4_pm_info = {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8d4..00d940f16314 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -847,6 +847,11 @@ static const Property ich9_lpc_properties[] = {
                      pm.periodic_timer_enabled, true),
 };
 
+static AcpiGhesState *ich9_get_ghes_state(AcpiDeviceIf *adev)
+{
+    return &ICH9_LPC_DEVICE(adev)->pm.ghes_state;
+}
+
 static void ich9_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(adev);
@@ -911,6 +916,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = ich9_pm_is_hotpluggable_bus;
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
+    adevc->get_ghes_state = ich9_get_ghes_state;
     amldevc->build_dev_aml = build_ich9_isa_aml;
 }
 
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 30990fcef53f..772f1a8937d7 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -27,6 +27,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/ich9_tco.h"
+#include "hw/acpi/ghes.h"
 #include "hw/acpi/cpu.h"
 
 #define ACPI_PCIHP_ADDR_ICH9 0x0cc0
@@ -38,6 +39,7 @@ typedef struct ICH9LPCPMRegs {
      * PM1a_CNT_BLK = 2 in FADT so it is defined as uint16_t.
      */
     ACPIREGS acpi_regs;
+    AcpiGhesState ghes_state;
 
     MemoryRegion io;
     MemoryRegion io_gpe;
diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
index 863382a814ad..8732574e9c03 100644
--- a/include/hw/acpi/piix4.h
+++ b/include/hw/acpi/piix4.h
@@ -29,6 +29,7 @@
 #include "hw/i2c/pm_smbus.h"
 #include "hw/isa/apm.h"
 #include "hw/acpi/cpu.h"
+#include "hw/acpi/ghes.h"
 
 #define TYPE_PIIX4_PM "PIIX4_PM"
 OBJECT_DECLARE_SIMPLE_TYPE(PIIX4PMState, PIIX4_PM)
@@ -43,6 +44,7 @@ struct PIIX4PMState {
 
     MemoryRegion io_gpe;
     ACPIREGS ar;
+    AcpiGhesState ghes_state;
 
     APMState apm;
 
-- 
2.55.0


