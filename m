Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FB0C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZyL-0001ot-66; Tue, 01 Jul 2025 08:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1uWZxq-0001VC-Uv
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1uWZxi-00060O-So
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751372385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUi9WXLHbqXC4QJiEUarnTHY0dgJlY0JhYQEljuo24c=;
 b=U+ZY6/t0xlgrQ1iBIJ/sJxZkFqwFrshCEG6YtXH5hfAkF9JfSVBnWD1ZtWqErBeqsnGeX7
 8QTtdCYnhtpfQ+g2rjZGEwXikO51vieV/A8PWrkHGBe3AukI10M/7yWJbrg0ae9vtzbvfJ
 j1w+j491zw6HnAkrzL3e51ouz6Dq7M4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-t8iXtT_gNU2WRvXOwKbrtA-1; Tue,
 01 Jul 2025 08:18:33 -0400
X-MC-Unique: t8iXtT_gNU2WRvXOwKbrtA-1
X-Mimecast-MFC-AGG-ID: t8iXtT_gNU2WRvXOwKbrtA_1751372312
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB5EB19560BE; Tue,  1 Jul 2025 12:18:31 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.225.251])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AE9F19560AB; Tue,  1 Jul 2025 12:18:27 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [RFC 2/2] q35: add virtio-mmio slots
Date: Tue,  1 Jul 2025 14:18:15 +0200
Message-ID: <20250701121815.523896-3-osteffen@redhat.com>
In-Reply-To: <20250701121815.523896-1-osteffen@redhat.com>
References: <20250701121815.523896-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Add virtio-mmio slots to the q35 machine model, intended to be used by
an SVSM.

Disabled by default, enable using '-machine q35,x-svsm-virtio-mmio=on'.

When enabled it is possible to plug up to 4 virtio devices into the
slots virtio-mmio using '-device virtio-${kind}-device'.

The devices can be found at base address 0xfef00000, each slot on a
separate page.  No IRQ is wired up, the SVSM has to drive the devices
in polling mode.

The base addresses are communicated to the SVSM via the etc/hardware-info
fw_cfg file.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 hw/i386/pc.c         | 18 +++++++++++++++++-
 hw/i386/pc_q35.c     | 15 +++++++++++++++
 include/hw/i386/pc.h |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 432ab288a8..e1dbf8846d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1584,6 +1584,21 @@ static void pc_machine_set_smbios_ep(Object *obj, Visitor *v, const char *name,
     visit_type_SmbiosEntryPointType(v, name, &pcms->smbios_entry_point_type, errp);
 }
 
+static bool pc_machine_get_svsm_virtio_mmio(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->svsm_virtio_mmio;
+}
+
+static void pc_machine_set_svsm_virtio_mmio(Object *obj, bool value,
+                                            Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->svsm_virtio_mmio = value;
+}
+
 static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
@@ -1844,7 +1859,8 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set IGVM configuration");
 #endif
 
-
+    object_class_property_add_bool(oc, "x-svsm-virtio-mmio",
+        pc_machine_get_svsm_virtio_mmio, pc_machine_set_svsm_virtio_mmio);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cf871cfdad..b8511ae52a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -60,7 +60,9 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/i386/acpi-build.h"
+#include "hw/uefi/hardware-info.h"
 #include "target/i386/cpu.h"
+#include "exec/target_page.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -335,6 +337,19 @@ static void pc_q35_init(MachineState *machine)
         }
     }
 #endif
+
+    if (pcms->svsm_virtio_mmio) {
+        for (int dev = 0; dev < 4; dev++) {
+            HARDWARE_INFO_SIMPLE_DEVICE hwinfo = {
+                .mmio_address = cpu_to_le64(0xfef00000 + dev * TARGET_PAGE_SIZE),
+            };
+            sysbus_create_simple("virtio-mmio", hwinfo.mmio_address,
+                                 /* no irq */ NULL);
+            hardware_info_register(HardwareInfoVirtioMmioSvsm,
+                                   &hwinfo, sizeof(hwinfo));
+        }
+    }
+
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 79b72c54dd..9c9f947087 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -51,6 +51,7 @@ typedef struct PCMachineState {
     bool i8042_enabled;
     bool default_bus_bypass_iommu;
     bool fd_bootchk;
+    bool svsm_virtio_mmio;
     uint64_t max_fw_size;
 
     /* ACPI Memory hotplug IO base address */
-- 
2.50.0


