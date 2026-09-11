Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F36CC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBM-0007sc-R0; Fri, 11 Sep 2026 05:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAr-0005SY-BI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAp-0008OL-Kq
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xy/HYzVNQBnkK+frgobWoz0pO/IVcyKqhz4VJS2NJ0=;
 b=Ha+1QXHA6VrHlMT/nezCIYL33S+uu24XvuJM0ROYpIHUvCyTAmW88lxvJrOXIw49yrEqs1
 WQ/sit2zYn7Twa3PH92yCoI9Sp97nQ6xBblN+ByjDJSZ3dYSn1faLrsjpGIS2YgQ3TYVXg
 UiDK/xbFVyHnWkJjNQ7meg0afJJSbXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-OYkU4ms4Oaan7kgFGvn6uA-1; Fri, 11 Sep 2026 05:03:53 -0400
X-MC-Unique: OYkU4ms4Oaan7kgFGvn6uA-1
X-Mimecast-MFC-AGG-ID: OYkU4ms4Oaan7kgFGvn6uA_1789117433
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-485b0c83a89so531009f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117432; x=1789722232; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0xy/HYzVNQBnkK+frgobWoz0pO/IVcyKqhz4VJS2NJ0=;
 b=NjdJzcbKSshRK//FpwydApr2FsyIUeUvE2OKgJMP//FnAR1rao/0/pMM+Mq/7x68RT
 HMrE3UeEsokznuitF0XDFZStmtOWu4r0X5xloTeoZX2qH0mFNsWsX0utfchkw8O7Lu80
 aanNlYwrgRYOkRt/TCkOtIBgAVL9vnj89BSVrb4cUfpet/JWTmNqGu2k8WLpwruwxj8v
 /D/PMhpum8WBjVna3plnzV/SzF49W9csGZimT8T/2iSEsYk4OQM0X33xJRXpjpp25epW
 CvrmSMFHtOtPrKw4nZUOTllvd9z+GDtBtbRNJs+6LiOfMt1sa9hteBKaZdcUnboUSCbG
 yumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117432; x=1789722232;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0xy/HYzVNQBnkK+frgobWoz0pO/IVcyKqhz4VJS2NJ0=;
 b=S7qUoYGky5bGOYCNAsVC7sWLj2d5xmKYCTdGSt3KwUlitBz7sCO68M7/ef9Oky2qsc
 bm53VGqbIMYZ7ET3P95XRg6y8sFRq0d9lFpBQ41s5+f5tV+NT+1US1zvXt/ktnupVZ43
 euYfaCCPG20luAdBPlM6dOoh+iX+t/+Cmd21O9ApOHYlyUk/haUscNKCGq9m3PjzQbik
 sabrsvotYxpfEw/V1dYrDmtEjroXhG4asR9tVqAVmeN/A0EongQJuc4DXxGG2RElTgC7
 U0SBzHdCsQCXU45o6XQfkbdV82C7hQAAN1NAiI1d6W+T4PxThSk6D6DteKRHQmUnvNKv
 z1kw==
X-Gm-Message-State: AFuF++lIeYXEyNeBDxJhQ63Dh3a15JIgoJuTOGixVVW9nY0kBkK2Cny5
 +UBV3aJHNEKps3X7REIqds8xD+fi0NZmzMHgJ+3lJB8U/JGZxz7/GlVWhm3RZhGr+CAkMdYpuG+
 C+GHRm2D2RTiZuGW1Rz79Sqj+9bo30pGHjE4osd5fka/q8O/BAH1Iax4qESvjCeQZwbsDdKtABT
 WNOoHMRfzJxA0PH8JrtoAtZtCOISIo561GZw==
X-Gm-Gg: AYBFou0LLFk/5HXg9OMYHCrcLMloD+lYALWNR1c/GXE/Hi8GK2S5kxVcWMqDggzZdPf
 +n+hAz5S6r9yZhv/wop7ArFxjHWuhKz1b+zFvZyleeODKRNfdLwf02S68tJG70spsmnv0h8ip28
 ctnLNobKDzZftHMveG7PYwxtvvETyKS7Fwr9obsympnvEi9jTY6CHHi91PQM+Xe1fW3Sj6Q59Pe
 n2K1uRGfR3Hb+NQ/qPa3BJL4TvUGleKrjSmJ230aeUjCkvLtm7UFL8x3+DAbXLApqMBvm4Qgg7D
 34DA+UqIgBHWjjmo3XN7T9BU5i9ual9LJgcgNLSjk3uT0ko4ovSS9wWAQmCHC/gHjZK/H1mMGdi
 zNWAp+Pv8W4AKUfitj1dG0tU=
X-Received: by 2002:a05:6000:240c:b0:486:f282:5952 with SMTP id
 ffacd0b85a97d-486f2825c45mr627862f8f.2.1789117432427; 
 Fri, 11 Sep 2026 02:03:52 -0700 (PDT)
X-Received: by 2002:a05:6000:240c:b0:486:f282:5952 with SMTP id
 ffacd0b85a97d-486f2825c45mr627792f8f.2.1789117431807; 
 Fri, 11 Sep 2026 02:03:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf2esm5115074f8f.2.2026.09.11.02.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:51 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 64/75] hw/hotplug: Reduce some HotplugHandler variables scope
Message-ID: <187820773599ebb81463c2114a7a410df5651853.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903230245.65601-4-philmd@oss.qualcomm.com>
---
 hw/acpi/memory_hotplug.c | 3 ++-
 hw/acpi/pcihp.c          | 3 ++-
 hw/pci/shpc.c            | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 1ddfdd17b7..f482c835a1 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -119,7 +119,6 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
     MemStatus *mdev;
     ACPIOSTInfo *info;
     DeviceState *dev = NULL;
-    HotplugHandler *hotplug_ctrl = NULL;
     Error *local_err = NULL;
 
     if (!mem_st->dev_count) {
@@ -167,6 +166,8 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
             mdev->is_removing = false;
             trace_mhp_acpi_clear_remove_evt(mem_st->selector);
         } else if (data & 8) {
+            HotplugHandler *hotplug_ctrl;
+
             if (!mdev->is_enabled) {
                 trace_mhp_acpi_ejecting_invalid_slot(mem_st->selector);
                 break;
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index b26ddf0a26..336ebe1a13 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -173,7 +173,6 @@ static bool acpi_pcihp_pc_no_hotplug(AcpiPciHpState *s, PCIDevice *dev)
 
 static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slots)
 {
-    HotplugHandler *hotplug_ctrl;
     BusChild *kid, *next;
     int slot = ctz32(slots);
     PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
@@ -210,6 +209,8 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
                      */
                     qdev->pending_deleted_event = false;
                 } else {
+                    HotplugHandler *hotplug_ctrl;
+
                     hotplug_ctrl = qdev_get_hotplug_handler(qdev);
                     hotplug_handler_unplug(hotplug_ctrl, qdev, &error_abort);
                     object_unparent(OBJECT(qdev));
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 938602866d..1198e1ab8c 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -271,7 +271,6 @@ static void shpc_invalid_command(SHPCDevice *shpc)
 
 static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
 {
-    HotplugHandler *hotplug_ctrl;
     int devfn;
     int pci_slot = SHPC_IDX_TO_PCI(slot);
     for (devfn = PCI_DEVFN(pci_slot, 0);
@@ -279,6 +278,8 @@ static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
          ++devfn) {
         PCIDevice *affected_dev = shpc->sec_bus->devices[devfn];
         if (affected_dev) {
+            HotplugHandler *hotplug_ctrl;
+
             hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(affected_dev));
             hotplug_handler_unplug(hotplug_ctrl, DEVICE(affected_dev),
                                    &error_abort);
-- 
MST


