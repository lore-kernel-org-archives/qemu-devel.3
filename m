Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836D4D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84IW-0000uD-Ur; Mon, 04 Nov 2024 16:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84IU-0000dD-S8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84IT-0005Oa-32
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ix86++93BtAOuMpEcgnrqz9oSyLAYBg4CUdSvCBsa08=;
 b=W+kPgSoDVza6+TM7xnKWey17Sq032VD3Ztr5MH3s8XRn+d4yoa6E2pCOGwYrtBLbUg7Kvo
 uhb8dLnuRVgoKBZFJwAQ1INhJKuEReQTelss+w+Oi48PYEkZBcr2nmI0yqvjNzUT7N2t1l
 2xjspSyc6CzAYM4HD0A7rLfdnHphGyI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-8sjD1VxRNLGHoVMHOemM6Q-1; Mon, 04 Nov 2024 16:07:35 -0500
X-MC-Unique: 8sjD1VxRNLGHoVMHOemM6Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so32899015e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754454; x=1731359254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ix86++93BtAOuMpEcgnrqz9oSyLAYBg4CUdSvCBsa08=;
 b=YldVJICPG1eG7rtrD5KKOe633QxG2ROIRkTxGdITQxGlGkrSi4tcuOkCbEkcOHsnz8
 J2lWhilxV3jca/5xfy4GupKT8d/h5bF6nmNWZvI2tf5NerLefKrKvrsbOMfcGTWOunmZ
 Pas7P4jiei4WZ+o2xbqmjqLwhmjW78kVYZifBCDu/R/pHTejU7gzXhOM+JrsdBk5Ub64
 /tBszkk6+F4pXLl1I20mCizOj5A+g6FooKilvlBxZ1zJxZwct9VUl63OjBBWgUX6n9Ac
 h+uCOSk3PCD7LvloysqecmAvBjn8OT2WY9CG4RN6ON3g6QNCYv8BdunR4cbACQBbR4TY
 nkvw==
X-Gm-Message-State: AOJu0YzDQT/KHXhMC8xabFuiVP0u+HGE6CAtKlVoSBXHKoXbSHN2N9zK
 DZGtNB15sAezsn+bqcqlScgjE83wi4U3dEV+JfqhTKjTXc1tzWEnKMJroQSjPyW2IJoyhFCqytQ
 tJFUqye6exi65zBdWQPJEK0k5ERfUkXLwo074bxjuLcR3O67xsIRe7RmVPjpyJ0MPZIZCUcnalK
 p190C3Plc1fJyL1xyk00uE8xRuyw/6MA==
X-Received: by 2002:a5d:64a8:0:b0:37d:46e3:4e88 with SMTP id
 ffacd0b85a97d-381be7654c6mr16200040f8f.9.1730754453799; 
 Mon, 04 Nov 2024 13:07:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTQXu/OsR2Iqo0IaPk7U1g3hSC4ZpEfmYmT/ChQEPBQGp8fLFZUaMC1Zhr5lSDjDLo1JXCEg==
X-Received: by 2002:a5d:64a8:0:b0:37d:46e3:4e88 with SMTP id
 ffacd0b85a97d-381be7654c6mr16200015f8f.9.1730754453261; 
 Mon, 04 Nov 2024 13:07:33 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10eaafdsm14173939f8f.63.2024.11.04.13.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:32 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 30/65] amd_iommu: Use shared memory region for Interrupt
 Remapping
Message-ID: <9fc9dbac61ddde7d8df37e84c8e02cec249d3222.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Use shared memory region for interrupt remapping which can be
aliased by all devices.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Message-Id: <20240927172913.121477-4-santosh.shukla@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  1 +
 hw/i386/amd_iommu.c | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index be417e51c4..e0dac4d9a9 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -356,6 +356,7 @@ struct AMDVIState {
     MemoryRegion mr_mmio;              /* MMIO region                  */
     MemoryRegion mr_sys;
     MemoryRegion mr_nodma;
+    MemoryRegion mr_ir;
     uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
     uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
     uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7c7760c573..9b923f6eb4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1443,7 +1443,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
          * |--------------------+-------------------+----------+
          * | amdvi-root         | 00000000-ffffffff |        0 |
          * |  amdvi-iommu_nodma  | 00000000-ffffffff |       0 |
-         * |  amdvi-iommu_ir     | fee00000-feefffff |      64 |
+         * |  amdvi-iommu_ir     | fee00000-feefffff |       1 |
          * |--------------------+-------------------+----------|
          */
         memory_region_init_iommu(&amdvi_dev_as->iommu,
@@ -1454,13 +1454,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         memory_region_init(&amdvi_dev_as->root, OBJECT(s),
                            "amdvi_root", UINT64_MAX);
         address_space_init(&amdvi_dev_as->as, &amdvi_dev_as->root, name);
-        memory_region_init_io(&amdvi_dev_as->iommu_ir, OBJECT(s),
-                              &amdvi_ir_ops, s, "amd_iommu_ir",
-                              AMDVI_INT_ADDR_SIZE);
-        memory_region_add_subregion_overlap(&amdvi_dev_as->root,
-                                            AMDVI_INT_ADDR_FIRST,
-                                            &amdvi_dev_as->iommu_ir,
-                                            64);
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             MEMORY_REGION(&amdvi_dev_as->iommu),
                                             0);
@@ -1472,6 +1465,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             &amdvi_dev_as->iommu_nodma,
                                             0);
+        /* Build the Interrupt Remapping alias to shared memory */
+        memory_region_init_alias(&amdvi_dev_as->iommu_ir, OBJECT(s),
+                                 "amdvi-ir", &s->mr_ir, 0,
+                                 memory_region_size(&s->mr_ir));
+        memory_region_add_subregion_overlap(MEMORY_REGION(&amdvi_dev_as->iommu),
+                                            AMDVI_INT_ADDR_FIRST,
+                                            &amdvi_dev_as->iommu_ir, 1);
 
         if (!x86_iommu->pt_supported) {
             memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
@@ -1633,6 +1633,12 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, 0,
                                         &s->mr_nodma, 0);
 
+    /* set up the Interrupt Remapping memory region */
+    memory_region_init_io(&s->mr_ir, OBJECT(s), &amdvi_ir_ops,
+                          s, "amdvi-ir", AMDVI_INT_ADDR_SIZE);
+    memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
+                                        &s->mr_ir, 1);
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
MST


