Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D7EC43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNw6-0005E7-Et; Sun, 05 Jul 2026 10:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw4-0005Dq-Fs
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw2-000193-Lq
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8m9Fd1JZ474Z+kDkH9U0m9q8ELzUr5+kmXzicQoBzoo=;
 b=LcX8OpFwBSpRV4XbWB5wfUpwMXLFhEiPaP45v47PSpLuMRjIvcWRnUWKiM8UwcoVQC9Iy/
 f6080VFyF2FB+RoGB42A9V3s4EVXZ78QAxZptB/YeU3oSJ/sLrB/2zpQqyZw+eCJZKkWg1
 kxUSGihKCewXnYERX+M9+aJinE0ZVzU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-PYHrcTiBNd2YRkVDV3qkxw-1; Sun, 05 Jul 2026 10:35:04 -0400
X-MC-Unique: PYHrcTiBNd2YRkVDV3qkxw-1
X-Mimecast-MFC-AGG-ID: PYHrcTiBNd2YRkVDV3qkxw_1783262103
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4926596eebcso13163365e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262103; x=1783866903; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8m9Fd1JZ474Z+kDkH9U0m9q8ELzUr5+kmXzicQoBzoo=;
 b=PjLefHVRmDXgj8m8v5bUx9HjHUqT3F5EoWbIp1wO56Em4wsei0OdennA7yyYG6e4id
 K7ZIOo3WXel086+bG5Vp2IyVbsnSIUHRIcueScwA9YeSMumAMVXECqtMl0wBzWPq3oJ1
 sN4j8kO4Ecn+v67t9bsd3/5j2Y7Htl8PZng1MOtBKzSKkowF5eeE8iZzlPUzvyyu1qlB
 2Q6gUMmf28mBTqmIoPkBDyZeASiZ9q0ozaNYSnhIedyh/tbyriR94FaeahiFlXsyk2N8
 lSAKPdWUKj5YR0Qdi8pnO97ojfdHLopxlxBiOMHOKbRikEEs3Fyadu9o0cIDaYShXU0O
 X1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262103; x=1783866903;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8m9Fd1JZ474Z+kDkH9U0m9q8ELzUr5+kmXzicQoBzoo=;
 b=GNlnMUCI1QTNafufwMza6bYt3kSL3ybFmQv+qAmlwukJJdo/EPqlL+MtHjnOSkrbmN
 CCTGYgZn43yhWCfygQrJGwdDztc1bghbyp+y+4V6qGdezE051eg6sG4XDR2YIR66L0v0
 M+KUf0vF7ByHy0R8Rn1ofa2VUmoClk9hp7/Z0nbofNBHxAxJoQ1Isz+iEf0Y3LrdZjHq
 QEttQEkEq9L7f3gS0LpPUr5Vd4ofnyfj6FMCb8AiMGgQWSiP7mTZVIfuFyT4zjky6MjF
 a9jITQlYMf3XYQiR/YmTI2UfYobABR6Bh0yM0n3Z4hSeh693oLukRv2TmHCAGlT6IiHA
 7c+A==
X-Gm-Message-State: AOJu0Yw1s0mqO118U3yUH4UJyZYkxVLmysIS7ldT5ZlDxSkkIUZFvn4T
 gvN8Nxz88qPgKnFgxhqayEp4/Y5O2eIotsHF0e29v70qTLkI5JFkGtTBKnbT4C54EILku3VKVNY
 N1POdDoP4poZ6aCjLD5xFxor6Br7m0NbZQvSa1x5NLintW4hz0Aucue6u7hY8YfEZ8WlgWcrzDL
 1k+USqukvSFfpClhpHrfUVix7Lzo7eWNdA8w==
X-Gm-Gg: AfdE7ck0DGSLBdkRZsWYfSKTUnZ4f4m/uNOwJQ9d7Ws1bViSNclvzZokUt5732ezt3X
 Iohbd46ecBJbRWZRiKKXi7DKWoOcagYfgZuWeO7caLQ1Ui5HqQWzldm9Oj++IEqF+iOmeTGHb+8
 PHoueAU18cFNstyh9xtbyljDva8iFVn2W/65HjLpQ27DebJ63rrQvFBsqKEm9jkgdbwjr1trX0b
 sduoi+RS5va/45vIzNuIZkaC60xhR1YKBpAgkvk4y7ZKvUML7RR0jlZ9SEcen4pY1Daj4i0HmRU
 43cgaEu4xAZj2yKJzK7CWrrHUgb2E/lwZvkiRWuNZfzorn97l/2phgA/sBChyYg8mqFJktXdM1a
 VT9yLv4nsm2Px+4BrZIJarkzW6GZs3tK/
X-Received: by 2002:a05:600c:154f:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-493d11f703dmr76966555e9.32.1783262103257; 
 Sun, 05 Jul 2026 07:35:03 -0700 (PDT)
X-Received: by 2002:a05:600c:154f:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-493d11f703dmr76966225e9.32.1783262102623; 
 Sun, 05 Jul 2026 07:35:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab3a8sm231740435e9.6.2026.07.05.07.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:02 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/44] hw/i386: hook sp-mem into the pc machine plug path
Message-ID: <a597e6791f6ebf2b012f54462d0c44c33a781334.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: fanhuang <FangSheng.Huang@amd.com>

Add the pc machine hookup for TYPE_SP_MEM so each sp-mem instance is
placed by the memory-device framework and reported to the guest as
E820_SOFT_RESERVED.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-5-FangSheng.Huang@amd.com>
---
 hw/i386/e820_memory_layout.h | 11 ++++++-----
 hw/i386/pc.c                 | 36 ++++++++++++++++++++++++++++++++++++
 hw/i386/Kconfig              |  2 ++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..6ef169db9c 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -10,11 +10,12 @@
 #define HW_I386_E820_MEMORY_LAYOUT_H
 
 /* e820 types */
-#define E820_RAM        1
-#define E820_RESERVED   2
-#define E820_ACPI       3
-#define E820_NVS        4
-#define E820_UNUSABLE   5
+#define E820_RAM           1
+#define E820_RESERVED      2
+#define E820_ACPI          3
+#define E820_NVS           4
+#define E820_UNUSABLE      5
+#define E820_SOFT_RESERVED 0xefffffff
 
 struct e820_entry {
     uint64_t address;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73a625327c..2bacece249 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -63,6 +63,7 @@
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/sp-mem.h"
 #include "e820_memory_layout.h"
 #include "trace.h"
 #include "sev.h"
@@ -1285,11 +1286,43 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
     memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
 }
 
+static void pc_sp_mem_pre_plug(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
+    SpMemDevice *spm = SP_MEM(dev);
+
+    if (ms->numa_state && spm->node >= ms->numa_state->num_nodes) {
+        error_setg(errp,
+                   "'node' property value %" PRIu32
+                   " exceeds the number of NUMA nodes (%d)",
+                   spm->node, ms->numa_state->num_nodes);
+        return;
+    }
+    memory_device_pre_plug(MEMORY_DEVICE(dev), ms, errp);
+}
+
+static void pc_sp_mem_plug(HotplugHandler *hotplug_dev,
+                           DeviceState *dev, Error **errp)
+{
+    SpMemDevice *spm = SP_MEM(dev);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(dev));
+    uint64_t addr, size;
+
+    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+
+    addr = mdc->get_addr(MEMORY_DEVICE(dev));
+    size = memory_region_size(host_memory_backend_get_memory(spm->hostmem));
+    e820_add_entry(addr, size, E820_SOFT_RESERVED);
+}
+
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
+        pc_sp_mem_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1326,6 +1359,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM)) {
+        pc_sp_mem_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1370,6 +1405,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_SP_MEM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 12473acaa7..e27d8816e5 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -84,6 +84,7 @@ config I440FX
     select PCI_I440FX
     select PIIX
     select DIMM
+    select SP_MEM
     select SMBIOS
     select SMBIOS_LEGACY
     select FW_CFG_DMA
@@ -113,6 +114,7 @@ config Q35
     select LPC_ICH9
     select AHCI_ICH9
     select DIMM
+    select SP_MEM
     select SMBIOS
     select FW_CFG_DMA
 
-- 
MST


