Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B89C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKv-0008Ba-B4; Mon, 14 Jul 2025 19:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIg-0004f1-2t
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSId-0005tz-Jr
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQxn9QS/vMZYb/YDbv5LwymPvubtqzGJ3vEfbTcnRSM=;
 b=AVb2BBxWtXWBFcVMJo4uPGDVkOmIPgta0ZTk2nXczKKQooo8pA64JOSZaapm1L3MLFU2TH
 wCwjRJqu4ku+N8FdSujurObbzLzW+Df2ITSWfqcUfEPo9A38ImZ8ibFUqtbZ3WPy+hS9Ro
 Hz9QnlnPKcKDMMWl6T7+euNq9lyV9/o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-ihcVTHhMM3-Ji7QU-JOc2A-1; Mon, 14 Jul 2025 19:09:28 -0400
X-MC-Unique: ihcVTHhMM3-Ji7QU-JOc2A-1
X-Mimecast-MFC-AGG-ID: ihcVTHhMM3-Ji7QU-JOc2A_1752534568
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so3030604f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534567; x=1753139367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQxn9QS/vMZYb/YDbv5LwymPvubtqzGJ3vEfbTcnRSM=;
 b=dvXXD7cOG9qwky9Bzrn8ApGm27aELnhHkoFQqHBMTuMVg5pb14RDW3KCj2J6wUmTvj
 ZUqPFb7/hiBpJAqT0cVVFbvF3wc5xecMIgbGrNb2zCsokDQJZJY1tKV+705Fv+clt1hN
 JqQ6YkTKGPa7fzUwsps98mzuSZ8OXArqURn6z9iv1/FLBTqZ/rqVitK88a60VafbnLLb
 ovdoeW9/AbzX0jDDiqdmnPGjDk85bZKrk4p1Mboz20DriYLfuqZwpSNZjKvohWBAHrH3
 n+OBh/nBIqsqDoX8yYf4x99VBUiMmOdwjo2xQnSL/+czVr21WLbXiNgJ6c7Gs3IbY93m
 xhXA==
X-Gm-Message-State: AOJu0Yx3aarmOxaj9ABsucXazN/5RxMsGgQnzbuNUgIAri8t6Y8r2N99
 O1zQRQ8LGutQV87m71f4ASYJ+AvSQEbVWYD3RZEL4cN3DnilCYjkXE0pJZ7HLqsaz7GcqYhjOE+
 HPIu00gjYYHhvUarO9F9GQLpOb7qxC4BwUYLbrG42OySV43SOuCYnChhkAOaYT2e6wWtFAp4G21
 Z+e3g4/TwzlyuES4YagpZJP7b5bbu8SwxcxQ==
X-Gm-Gg: ASbGncvEMgeLIvUf0GB+C4pw/wClbnSjeA6xDRGtklU+dnTV3JlIGQlUFZvp+hlIpGt
 B5PcZMRveesNe4xI78OK+lNMXNdqpWpnjH5hdYkFWYaTdufka3BuBIkxo2MN8abUU78f3MuQwrR
 WjY/i2Rlz+r6hwdxMyZd64fmM38n7vufAhZjg/0Aqe+JUQp+2BEM+wFRlotbYrf6q4SqbXl0wuO
 YkLCdXGWvGSDig1rqXqD6AKfDS7anlQMGZ1mNR3r7CChIhcKVhtVavb9OU1rsL43Uu9LvkzRc0O
 /NqTZtQX4dNEuHSGWoqNktIvH6Nk39yB
X-Received: by 2002:a05:6000:3c9:b0:3a5:7895:7f6b with SMTP id
 ffacd0b85a97d-3b609525fd2mr1025431f8f.7.1752534567401; 
 Mon, 14 Jul 2025 16:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsHGCkbGRjjLtkot/O4pSBpQ7p+18CvPkQrwb3h2IHySJGr+T0l+qrJKAqZv67jUcV2RyePg==
X-Received: by 2002:a05:6000:3c9:b0:3a5:7895:7f6b with SMTP id
 ffacd0b85a97d-3b609525fd2mr1025410f8f.7.1752534566936; 
 Mon, 14 Jul 2025 16:09:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e3bdsm13361937f8f.81.2025.07.14.16.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:25 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 73/97] hw/acpi/pcihp: Remove root arg in acpi_pcihp_init
Message-ID: <ca03efda91ca69db24b7033ea4c07c18bd12f7c3.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Let pass the root bus to ich9 and piix4 through a property link
instead of through an argument passed to acpi_pcihp_init().

Also make sure the root bus is set at the entry of acpi_pcihp_init().

The rationale of that change is to be consistent with the forecoming ARM
implementation where the machine passes the root bus (steming from GPEX)
to the GED device through a link property.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-28-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/pcihp.h         | 2 +-
 hw/acpi/acpi-pci-hotplug-stub.c | 2 +-
 hw/acpi/ich9.c                  | 7 ++++++-
 hw/acpi/pcihp.c                 | 4 ++--
 hw/acpi/piix4.c                 | 5 ++++-
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 9ff548650b..ca6a258825 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -62,7 +62,7 @@ typedef struct AcpiPciHpState {
     bool use_acpi_root_pci_hotplug;
 } AcpiPciHpState;
 
-void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
+void acpi_pcihp_init(Object *owner, AcpiPciHpState *,
                      MemoryRegion *io, uint16_t io_base);
 
 bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus);
diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index b7bc6e40a1..d58ea726a8 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -4,7 +4,7 @@
 
 const VMStateDescription vmstate_acpi_pcihp_pci_status;
 
-void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
+void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
                      MemoryRegion *address_space_io, uint16_t io_base)
 {
 }
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 967b67485e..2b3b493c01 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -322,9 +322,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     }
 
     if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
+        object_property_set_link(OBJECT(lpc_pci), "bus",
+                                 OBJECT(pci_get_bus(lpc_pci)), &error_abort);
         acpi_pcihp_init(OBJECT(lpc_pci),
                         &pm->acpi_pci_hotplug,
-                        pci_get_bus(lpc_pci),
                         pci_address_space_io(lpc_pci),
                         ACPI_PCIHP_ADDR_ICH9);
 
@@ -428,6 +429,10 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
+    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
+                             (Object **)&pm->acpi_pci_hotplug.root,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, pm);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index f1594e664a..4922bbc778 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -493,13 +493,13 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
     },
 };
 
-void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
+void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
                      MemoryRegion *io, uint16_t io_base)
 {
     s->io_len = ACPI_PCIHP_SIZE;
     s->io_base = io_base;
 
-    s->root = root_bus;
+    assert(s->root);
 
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index d98b80df6d..7a18f18dda 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -567,7 +567,8 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
 
     if (s->acpi_pci_hotplug.use_acpi_hotplug_bridge ||
         s->acpi_pci_hotplug.use_acpi_root_pci_hotplug) {
-        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
+        object_property_set_link(OBJECT(s), "bus", OBJECT(bus), &error_abort);
+        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, parent,
                         ACPI_PCIHP_ADDR_PIIX4);
         qbus_set_hotplug_handler(BUS(pci_get_bus(PCI_DEVICE(s))), OBJECT(s));
     }
@@ -611,6 +612,8 @@ static const Property piix4_pm_properties[] = {
                      acpi_pci_hotplug.use_acpi_hotplug_bridge, true),
     DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCI_ROOTHP, PIIX4PMState,
                      acpi_pci_hotplug.use_acpi_root_pci_hotplug, true),
+    DEFINE_PROP_LINK("bus", PIIX4PMState, acpi_pci_hotplug.root,
+                     TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
     DEFINE_PROP_BOOL("smm-compat", PIIX4PMState, smm_compat, false),
-- 
MST


