Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAB7C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMO-0002WW-Vy; Mon, 14 Jul 2025 19:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIx-0004or-Mg
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIr-0005vk-3X
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch85qCxvAmCXoJ+NOOx+afwY7JfNKRiohRHU3Ox1I3g=;
 b=N1nu3cCpl90dPHKE5TpGUvfj3PMt70JsyML4ozR9f3qGjEO27Tr89YH1sJJ2dm6mCFPVPs
 EGFczcbhdzdlxZNEbImtaMwy86vklj41pMo842L0o7xT4CWy9XBmSxA1l5pgjF+g7fU0di
 VVz9EXGnUO5xfTGUBcd4xhsMExxlnhk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Y0vbr7XnPhiOsEu2EkcPcw-1; Mon, 14 Jul 2025 19:09:42 -0400
X-MC-Unique: Y0vbr7XnPhiOsEu2EkcPcw-1
X-Mimecast-MFC-AGG-ID: Y0vbr7XnPhiOsEu2EkcPcw_1752534581
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso26562025e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534581; x=1753139381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ch85qCxvAmCXoJ+NOOx+afwY7JfNKRiohRHU3Ox1I3g=;
 b=wUWnbqLgU2o6AfGmm9H2thiYeJ/TTyXKP3M2aQ6iwPN9VbWnC8EBuW9sWTNsX6+xbt
 g8gkCPQBzavRQ0ZPl2ikPJQPk6AFuvavUXFXDzRGQTpUsteIkJX3C6MF31sFcyGsZca3
 2huPtnCfzHwq+r2TPAdxuqXIkfTakvHckHAc9gg8hkeyZchrncxpfku13zdfsotC2KSF
 g9Ud0wJkhutgGMsx6OZXczQiQ4hXNQOQPreVUWPpU8/reZplTZ2xNLT6WzL4cDmo/fNx
 eEjyODWqJPR7Rt9v5fWEwaXpsJtktjTkycgFLtNeaDZYoyK1SbSwJsa5Ma9BSnmHJhc6
 37pQ==
X-Gm-Message-State: AOJu0Yxv9xxXTCKgqJpwe3Uq4hctx2S2WhT2xmH94Qrk4otkrQr1/bMv
 FyPlbLZBx5gGR7gXRyrsqzQrNR+ql9uLgs5dDLiixcTZ1n7RFzc7DGDUWKFStLMl9wnwny+0wth
 VGy1ZLXkuo3IUuepqCnwOnpcKXWmNjn2ZwOjBFPIQQqptDe6xAcBz2OiMFVOCD8SAmdAtPDY9s/
 MyxdbRrgfpBRkBCKxrRCXt9lPaOLbczP87Zw==
X-Gm-Gg: ASbGnctgS/QJ4ILINYcBuXBUXpTcawEh/d0sovnxBOTAUpwaDPoJFKQQf82EjG1Jb+8
 JBBXN4JJc4gYE63IbbaTI8wPIMwu0mmyMKE8aU/RHVKcfj8CaJdu1+hepN0VJvI5kqnJL32WwM0
 Z6Zu4FLeAe2DeVXYbe09up/6Xh5g3DqgcFpKxcrA412vhWI+KDUMPY/HswEL6lSwPCikMJRbYbM
 6EFRmtd7BlkM4nROqXMtJwiT9ERwGalYx7Ft2Sajr8AadtdmFrPlY8CPvGkCgwjXgrBjdFGOeWS
 BMPs2ISrj9ZCsQB6IWl+dNHC+OFZgmYd
X-Received: by 2002:a05:6000:2a8a:b0:3a3:71cb:f0bd with SMTP id
 ffacd0b85a97d-3b5f188e702mr9336549f8f.23.1752534580688; 
 Mon, 14 Jul 2025 16:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIoRwndar8o46lZkgjDi+/pA/NlseW3O9MbPUamqQ5li/NgikHoiq6lzt4urFfskPmtoG4bw==
X-Received: by 2002:a05:6000:2a8a:b0:3a3:71cb:f0bd with SMTP id
 ffacd0b85a97d-3b5f188e702mr9336530f8f.23.1752534580294; 
 Mon, 14 Jul 2025 16:09:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd180fsm13369695f8f.2.2025.07.14.16.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:40 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 78/97] hw/arm/virt: Let virt support pci hotplug/unplug GED
 event
Message-ID: <28ac8a5662a55c40b377e9c94c2b49191db346c8.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set up the IO registers used to communicate between QEMU
and ACPI.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-33-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f127a668ef..ef6be3660f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -691,6 +691,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     SysBusDevice *sbdev;
     int irq = vms->irqmap[VIRT_ACPI_GED];
     uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    bool acpi_pcihp;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
@@ -709,6 +710,18 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
     sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
                          vms->memmap[VIRT_PCDIMM_ACPI].base);
+
+    acpi_pcihp = object_property_get_bool(OBJECT(dev),
+                                          ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, NULL);
+
+    if (acpi_pcihp) {
+        int pcihp_region_index;
+
+        pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
+                                                  vms->memmap[VIRT_ACPI_PCIHP].base);
+        assert(pcihp_region_index >= 0);
+    }
+
     sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
 
     return dev;
-- 
MST


