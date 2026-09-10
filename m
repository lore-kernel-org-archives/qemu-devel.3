Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E852C88E45
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nWS-0002aj-HN; Thu, 10 Sep 2026 18:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lLC-0002st-E7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lL0-0008No-St
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xy/HYzVNQBnkK+frgobWoz0pO/IVcyKqhz4VJS2NJ0=;
 b=TeCsFlfHLdWHVABxxRq308SCh5F/Kyxgg/fISAKXOUEyJTdWlFJb8nYeAoUYWJzUyHVcB7
 +3CHTnFVLnTsiGR/3+8cb6s8WGnp73O6ogKms/0qcHGPL2FyXKTmz40RiIEMAO33XfBl1C
 EQs3yfBvW0XQrqH8DylrsvX5QVuoFmo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-toXL85FKNHacrqzzYtqFew-1; Thu, 10 Sep 2026 16:15:24 -0400
X-MC-Unique: toXL85FKNHacrqzzYtqFew-1
X-Mimecast-MFC-AGG-ID: toXL85FKNHacrqzzYtqFew_1789071323
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso1748705e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071323; x=1789676123; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0xy/HYzVNQBnkK+frgobWoz0pO/IVcyKqhz4VJS2NJ0=;
 b=nHttDi+IN1dJMShL6748HDrwnRk1kIuUmpLglp1wQzPJxDDl8KuUsgO6dVAjiPJFlx
 vMedhx+u1EDNwJKyoSPwtkPtZUCRNx+9wg0ouXt+fv7jSLczeniCBoRnIE2Yb5e9fww8
 acEH7cP6bw+0WQ7xyFd2IuVnUUw8KBK1NXN1ssMSNuuYJth2dsdyoVkF3Hb3biTIZ/fn
 bbFk3jUkokKDfBHyOVtq1onlqtdGCsvYQo/3MaYyw48Gts02Rrds350lrq6QkxH8EeCU
 6Jyn2k/rYpajmaSlDyW+wz78Ut+T3rVdGctvr8pEWLipBP7VdI4TrZuqn9r/1/0MJ+sH
 Bymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071323; x=1789676123;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0xy/HYzVNQBnkK+frgobWoz0pO/IVcyKqhz4VJS2NJ0=;
 b=eV6WtgsK+F9IUMsXEmp4rWTow47d2QeJEGeUm4jf6pZi4gTKphc5oSDm6N5fQwheY3
 kDp2Vs9HxNIRb1YewwlBXLAlRqG3LqqNuRfjGALfOhF0uYXy8lWCl5Uy+5eocNoA9ECB
 ABsE2LbKyeJhkVJVhSOzgFcssD0H/SGBhhG5JNWyMWYGZaGTcOPLfucMTYZw8zJgfD0s
 wthZhA5CZ7oHxTxpM9eaN17bL3HOJKO8rGW1ehyKY3xN2SinefgLfqKS0GKWXmqUcqil
 uoO2nX49sZeRIPMlnk+IQzTIkjDTOvSnW6IQnqGfU+Cz2imVW+c+NP2vbc5YRM9gJoDK
 jueg==
X-Gm-Message-State: AFuF++kdKrP4LutfFL/3Rwi+eCJUYSuTJPODW57mA8wh3Ae5yDn6X7Bk
 lOc8LrrlemYj8LPAuVHYmWx4lqj5F4N96bk7/+ZuRcRSvBra/7YFaINVbw83oyOvG9mfEXDOCMu
 GIZLn/ED/t0sjAfiHnVVQAvJd1AVwbZC71i9Bq/m44ROSv7mF3y0dIDx/8Re7mc6PtpNkq2T4JN
 ANc1+syIUKZN4VIRD1exNFnuAghWktULGnbA==
X-Gm-Gg: AYBFou2yxHRVA/Uc3G3San5cwmz/C1kPSLwnHDatj5vFoA9I2MB+a4fZyJ8Trai+wDQ
 UTiRmNQZdg6/9ksuQAB1L8mI7UYlMbt9jyDe6Fc6gkEt3612/hIR43MuF0bAxtVkN9Lrf+0CZY1
 +68LjKXof+6YHdjRKDcQNcfp+nyz33EQiFx946jbh8LaFprGjYo8AuWvKv/Nn2ladk+cVDmMf3t
 B2rC2pBmB45A+GcYVVLE2Gmm3pD759OjPxC8DDKjn+TFxnV7fpQCCy0qybH8Imo8vNyUfWCVfPL
 DjiqdHUR/Kpu8hLJ62s2tbyXbVtdAc8m872OypMGITV7dXJcVOzeO/XLaY4XumXsnMcexTBKDw+
 NL3F7HwgG6ZmMbqI4AmompII=
X-Received: by 2002:a05:600c:4f8e:b0:49d:17d4:aff2 with SMTP id
 5b1f17b1804b1-49e619a1c3bmr16401835e9.1.1789071323253; 
 Thu, 10 Sep 2026 13:15:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4f8e:b0:49d:17d4:aff2 with SMTP id
 5b1f17b1804b1-49e619a1c3bmr16400755e9.1.1789071322578; 
 Thu, 10 Sep 2026 13:15:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a32803sm8333465e9.0.2026.09.10.13.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:22 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 79/90] hw/hotplug: Reduce some HotplugHandler variables scope
Message-ID: <fafe9655e1c650a4c03ebf99ac837eb9aa3d074b.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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


