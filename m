Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BCEC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsO-0000VB-JM; Mon, 27 Jul 2026 15:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsJ-0000Oo-6J
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsH-0000dQ-FS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=myr2FfCTdeCEuGnVsWMQ9NAAavu++eEZIA6gyuM1QZg=;
 b=ipEyItSxPNeIS3Egzo7FdSQeKIKy9UYUCfjdLZaPvk8roGRuRtPwRzoAs3/86gfussatgM
 siF5WajMJPIeDnpCSdQivkf+uOdy5dkT79DqZqV/oSvZnYRPox5+M1qQmR+0zbR5+Ny4JD
 KBJS5gHDTcQvNsDJ5YwSBEDal5GPsek=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Vt1AJwZrOxyi65oU4-z5XQ-1; Mon, 27 Jul 2026 15:20:27 -0400
X-MC-Unique: Vt1AJwZrOxyi65oU4-z5XQ-1
X-Mimecast-MFC-AGG-ID: Vt1AJwZrOxyi65oU4-z5XQ_1785180026
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49571407d1dso23015875e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180026; x=1785784826; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=myr2FfCTdeCEuGnVsWMQ9NAAavu++eEZIA6gyuM1QZg=;
 b=dh5GYhx97iJp7zizvJ4V6BXY0NS0D+/6nJ2iCYqP1mQnPLammf6+0lDK/xO2Ee1nxB
 lBb8VK3S3H6pozg9ZI1d1gFHwS6FSL1SmGjfBRxanYFEgea4Olw1etxyUPTjcVIJqiI+
 KYmPjg4r/6GDarp+dr5NzHHsxbDFYyJV4Idve7w1EmRbxJMD2LizWCkDlxyZ7lA3wfI8
 yRqxWBkWZkZmRtX5972OdrgblC6NFGb2VfhWJPC4OMvo7nRC5X7tQbFITrWBcBNOghjN
 gtRPw7SDJe7lC3eXJsbar7H34F3GwioJy0gZxGR9cI0oY//wcyzJyDO7ofs2GktsIs/K
 rY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180026; x=1785784826;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=myr2FfCTdeCEuGnVsWMQ9NAAavu++eEZIA6gyuM1QZg=;
 b=L7tu4eWvmxh37TWu2FohM/GjIhO6S31osmulvZWC5L0r1lwwdxuX1ec+WHJIB+klsI
 I6DR0UM8qZV8w6YByh8TN14ZpQj6L/YZWxqyJcf64k4PYSORzUJJYlsq6cO356vBQMKc
 py95GFlaQxVJfrPIKGtmH5HPTMDnyyEfuRvGiR1hMJmfBmz3ygXWLs0OliFDgHixn1b1
 bxVjLP6ZdTy1Tt00NiuxoWBe2R5yL40T2UVSUXs47lf5qhr7MYhFd1ZmEsNslEX44W32
 jkoz1BReZsYBToWbR0gDlVGaipo5oohhFjxtEQKyEGNktvgYHSCvgjLSYULVGzIIMaQ7
 EBaw==
X-Gm-Message-State: AOJu0YySXexm0Mxd8FtMlPTv6LZrzugIKKaKt1NSmLohdcSZcpXOQwDi
 63h0ZVNl8AnGlx7vQco1UbJ3pY7L22mY38O4uGq8p8pl7HTIIh5Wh/qVLs/qB+xCZvtEEhUjq9e
 lt1FEdBdyRgQslr5UqyW2ugSMn79yLppKDnj/WD40wE/Fc85qTsPD6Pn/aLBeT1y0NukxGB0WKP
 L2Lq5FggPpGExXwWm/MbeXTcgPGHoVPMv1Ig==
X-Gm-Gg: AR+sD10ixoQqQv7/kKXByKm2xuViuEIvFVmKGichJPAeV4enF+apOdf8rLdp94PukXj
 LVqjVfHzSWFUz4FL+CzaQN0YiPwt+iXfOb2GPWPKXyg7ZVWv954DFV+/5XWpHLMdK6lJFV1lOZ0
 ccTKlacXiyjn25Ck4s86C/cuGN3AuQxeze9eJj0o8/AnAWh0pKvV85unhtr6LPXa1dZeKDrJVeE
 Zz1igi30gt6/LVxNw/S2lMGxynXSXhirAv2mv5XONy8ui1Si+YruVDOy3caitMogFCM7vBjSdX1
 i9dveEVTi/3qwJUyO20NYZCD7Hc4Sn86f2nlYo2yP+MLlhxagUge8UFaDtAjfAJ4JIrZlBD3eDY
 RyiuSfYO6tsssFrH7I3uyqA==
X-Received: by 2002:a05:600c:1d1e:b0:495:5cda:52ec with SMTP id
 5b1f17b1804b1-496c4f9ca55mr4185825e9.16.1785180026198; 
 Mon, 27 Jul 2026 12:20:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1e:b0:495:5cda:52ec with SMTP id
 5b1f17b1804b1-496c4f9ca55mr4185415e9.16.1785180025540; 
 Mon, 27 Jul 2026 12:20:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm56595396f8f.19.2026.07.27.12.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:25 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL v2 22/30] hw/pci-host/q35.c: Factor out creation of SMRAM MRs
Message-ID: <a90fcf0080da2bd372f0a79dc243d8d2ede1b244.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

mch_realize has a large section that deals with initializing the
SMRAM-specific MemoryRegions.  Currently we do an early return from
the realize function if mch->has_smm_ranges is false, but this has
the potential for bugs if somebody adds new code at the end of the
function that isn't SMM-specific.  Pull the MR init code out into its
own function, so we can do the smm-ranges specific handling in the
realize function in a more obvious way.

This commit shouldn't change behaviour at all.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260708121011.1653365-3-peter.maydell@linaro.org>
---
 hw/pci-host/q35.c | 91 ++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 47e726c41d..e42b84b978 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -572,49 +572,9 @@ static void mch_reset(DeviceState *qdev)
     mch_update(mch);
 }
 
-static void mch_realize(PCIDevice *d, Error **errp)
+static void mch_init_smram_regions(MCHPCIState *mch)
 {
-    int i;
-    MCHPCIState *mch = MCH_PCI_DEVICE(d);
-
-    if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
-        error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
-                   mch->ext_tseg_mbytes);
-        return;
-    }
-
-    /* setup pci memory mapping */
-    pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
-
-    /* PAM */
-    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
-             mch->system_memory, mch->pci_address_space,
-             PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
-        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
-                 mch->system_memory, mch->pci_address_space,
-                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
-    }
-
-    /*
-     * This memory region looks like it's SMM specific, but it is not.
-     * It's an alias that makes the pci_address_space appear in system
-     * memory at the SMRAM_C_BASE address. The alias is enabled when the
-     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
-     * visible. So for non-SMM configs we need to create the alias, and
-     * leave it permanently enabled.
-     */
-    memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
-                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
-                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
-    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
-                                        &mch->smram_region, 1);
-    memory_region_set_enabled(&mch->smram_region, true);
-
-    if (!mch->has_smm_ranges) {
-        return;
-    }
-
+    /* Initialize all the SMRAM specific MemoryRegions */
     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
                              mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
@@ -670,9 +630,52 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_set_enabled(&mch->smbase_window, false);
     memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
                                 &mch->smbase_window);
+}
 
-    object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&mch->smram));
+static void mch_realize(PCIDevice *d, Error **errp)
+{
+    int i;
+    MCHPCIState *mch = MCH_PCI_DEVICE(d);
+
+    if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
+        error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
+                   mch->ext_tseg_mbytes);
+        return;
+    }
+
+    /* setup pci memory mapping */
+    pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
+
+    /* PAM */
+    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
+             mch->system_memory, mch->pci_address_space,
+             PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
+        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
+                 mch->system_memory, mch->pci_address_space,
+                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+    }
+
+    /*
+     * This memory region looks like it's SMM specific, but it is not.
+     * It's an alias that makes the pci_address_space appear in system
+     * memory at the SMRAM_C_BASE address. The alias is enabled when the
+     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
+     * visible. So for non-SMM configs we need to create the alias, and
+     * leave it permanently enabled.
+     */
+    memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
+                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                                        &mch->smram_region, 1);
+    memory_region_set_enabled(&mch->smram_region, true);
+
+    if (mch->has_smm_ranges) {
+        mch_init_smram_regions(mch);
+        object_property_add_const_link(qdev_get_machine(), "smram",
+                                       OBJECT(&mch->smram));
+    }
 }
 
 static const Property mch_props[] = {
-- 
MST


