Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E63E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 17:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJc23-00055c-1b; Fri, 06 Dec 2024 12:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc1P-0004AG-C7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 12:21:43 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc1M-0000yt-AL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 12:21:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 84CE1A443D3;
 Fri,  6 Dec 2024 17:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E23C113CF;
 Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733505687;
 bh=8f5rlp/zLYzDwVabAlAF4STsFI+Httk2p9sLwy5PZmQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hQG/9EQSt7YdLRSeY6VIZH0OmJkh88yPOszeKj5N54LWZQi3+S25mgDPOHGiyK3Zf
 pid0bA1gkVpp2BE3rc5Nfhu5vEjrdi4cyq+214Yn1YyooXgVQ2T5hOch/PRrJ/p8Lx
 7jHhsanyQjJX2CmGLzR9zVRmbSRGIG9Dar1eNIG65+lQykhME4jzoQmOcwPCpdON9B
 JRuMgjBs50tFd2RBcwK2ZWtEXPy7bOrToJnAwC4S1oeLBS53heju9Fg/OlrtUePC32
 4aBRZKTolhCYo5NoY5MCjJvy+LxC7L7Jxfet8tTby28S90tVATVdjeuHeDZbAHHJ0B
 RqsYhIiUzxQIg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJc18-00000005RKo-06P8; Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH 20/31] acpi/generic_event_device: add an APEI error device
Date: Fri,  6 Dec 2024 18:12:42 +0100
Message-ID: <01304a8ef8579959ae1866a8ef74bd55d9c2e39e.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Adds a generic error device to handle generic hardware error
events as specified at ACPI 6.5 specification at 18.3.2.7.2:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
using HID PNP0C33.

The PNP0C33 device is used to report hardware errors to
the guest via ACPI APEI Generic Hardware Error Source (GHES).

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/aml-build.c                    | 10 ++++++++++
 hw/acpi/generic_event_device.c         |  8 ++++++++
 include/hw/acpi/acpi_dev_interface.h   |  1 +
 include/hw/acpi/aml-build.h            |  2 ++
 include/hw/acpi/generic_event_device.h |  1 +
 5 files changed, 22 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 72282b173ec7..dc38b5810228 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2602,3 +2602,13 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
 
     return var;
 }
+
+/* ACPI 5.0b: 18.3.2.6.2 Event Notification For Generic Error Sources */
+Aml *aml_error_device(void)
+{
+    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    return dev;
+}
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index df6b4fab2d30..2213ec076958 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
     ACPI_GED_CPU_HOTPLUG_EVT,
+    ACPI_GED_ERROR_EVT,
 };
 
 /*
@@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_ERROR_EVT:
+                aml_append(if_ctx,
+                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
+                                      aml_int(0x80)));
+                break;
             case ACPI_GED_NVDIMM_HOTPLUG_EVT:
                 aml_append(if_ctx,
                            aml_notify(aml_name("\\_SB.NVDR"),
@@ -295,6 +301,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_MEM_HOTPLUG_EVT;
     } else if (ev & ACPI_POWER_DOWN_STATUS) {
         sel = ACPI_GED_PWR_DOWN_EVT;
+    } else if (ev & ACPI_GENERIC_ERROR) {
+        sel = ACPI_GED_ERROR_EVT;
     } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
         sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50aa..8294f8f0ccca 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -13,6 +13,7 @@ typedef enum {
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
+    ACPI_GENERIC_ERROR = 128,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 4fd5da49e7e6..771f6aa78a6c 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -252,6 +252,7 @@ struct CrsRangeSet {
 /* Consumer/Producer */
 #define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
 
+#define ACPI_APEI_ERROR_DEVICE   "GEDD"
 /**
  * init_aml_allocator:
  *
@@ -382,6 +383,7 @@ Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
 Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
+Aml *aml_error_device(void);
 
 /* Block AML object primitives */
 Aml *aml_scope(const char *name_format, ...) G_GNUC_PRINTF(1, 2);
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d2dac87b4a9f..1c18ac296fcb 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -101,6 +101,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
+#define ACPI_GED_ERROR_EVT          0x10
 
 typedef struct GEDState {
     MemoryRegion evt;
-- 
2.47.1


