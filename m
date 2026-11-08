Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58055606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPj6395R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyWr-0007br-1z; Sun, 08 Nov 2026 03:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWm-0007YY-Of; Sun, 08 Nov 2026 03:45:29 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWj-0000HZ-DZ; Sun, 08 Nov 2026 03:45:28 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B710E448DB;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEAB1F008AB;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794127516;
 bh=dtj/JRYxHWgoRtzy0x5ktxY1NkPyMJTom3ccS1vcjsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iPj6395RmOlKm9HvPCW+J4JuYZtVTUt1oJSBplNAAKS5WHP5bQazVOpIACBpz7SlN
 XdEjYA6WfSe+VPKc/8hinxVbJRQUFbNn2Z6KKxstXmrha+337DmoomecysecmB8xYB
 x9rGdPo7SaRvyRyWnnJGbs4+Akx+4wnfLt5Xnoe0p+gOhYlqRCKC9pddNjrTnpOGST
 qrKpsS5BKY/O4PVMQnSTh0cLku2OC4Ti2OmgJJbyZzx8VKCI+u1k+V2aHinypspOa+
 0EXaDxeAuVOYEYtX6DDbjAn8nL2CRiSAw2k++JsiuvpOpiayvFPOSs/0g6RvUs02xX
 kYmEDPWAXLViA==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWY-00000005TMX-2bfH; Sun, 08 Nov 2026 09:45:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 4/8] hw/i386: add GHES support at ICH9 and PIIX4 PM
Date: Sun,  8 Nov 2026 09:45:05 +0100
Message-ID: <bd61e2e8fe67bb592e67477416d436285967dcd0.1794124132.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794124132.git.mchehab+huawei@kernel.org>
References: <cover.1794124132.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 91a22a8e9480..39303e681406 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -223,6 +223,24 @@ static const VMStateDescription vmstate_pcihp_state = {
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
@@ -245,6 +263,7 @@ const VMStateDescription vmstate_ich9_pm = {
         &vmstate_tco_io_state,
         &vmstate_cpuhp_state,
         &vmstate_pcihp_state,
+        &vmstate_ich9_hest,
         NULL
     }
 };
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a7d5356340be..854a1008deff 100644
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
@@ -561,6 +580,11 @@ static void piix4_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
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
@@ -617,6 +641,7 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+    adevc->get_ghes_state = piix4_get_ghes_state;
 
     object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_BASE_PROP,
                                          offsetof(PIIX4PMState,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index b55b5136a385..f321c2d6e95f 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -833,6 +833,11 @@ static const Property ich9_lpc_properties[] = {
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
@@ -900,6 +905,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = ich9_pm_is_hotpluggable_bus;
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
+    adevc->get_ghes_state = ich9_get_ghes_state;
     amldevc->build_dev_aml = build_ich9_isa_aml;
 
     object_class_property_add_uint8_ptr(klass, ACPI_PM_PROP_SCI_INT,
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 6956b2b9c9a2..67db16d93523 100644
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
2.56.0


