Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E12D6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaL-0008Ug-S9; Thu, 29 Jan 2026 11:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaJ-0008SR-MP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaG-0006YI-HL
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:31 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4327555464cso973485f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702967; x=1770307767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8pC6F/zj3QNaYDR/bID0RLslNcwqHXMeuqDP6SLHYeY=;
 b=zhpaf4xYqNleBOSx2gHy58TCVvoGJfsA3mM6MbDV/wWQX9T1VSpf45MaHe1FrAd3Tb
 M6mnkNGA4ptwCalHa+hcKCbXBvTSBKpJ0FRqOIt0zyYzDI9F+bVJf38cogKUDYF/Cpze
 OxOvS0oAmhM7M9Q1tXOh7CkHRNf461JZrjSkLxILVuljDPopNywKrueEcWNu01Zk6hjs
 UsM2VjU7wwunXe++F9WHUNL6sHgf2/wZ4SlZlVUehqoFAd1XVxKpxurRMV3hYqX4u0ID
 tBPqKLFZcjCmwTFptN6X475wTPj8qIF9UmT9a+1LeCgUtJ7WdYICzGOOi4weL8qct+4M
 oO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702967; x=1770307767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8pC6F/zj3QNaYDR/bID0RLslNcwqHXMeuqDP6SLHYeY=;
 b=S2ZjZI73ai1NGtIkuwvRcBhWRYZt6KmJov8C8sf5A3rwcD9YGl2AGWUNvEsNTAURxV
 +peogkn1sZOZXTDbSiFo271GXyJlhCIxc4wzuLOqZZLpQm4eEMSRxJAXoAvoroug0Sno
 czMYHet2pUqDbBAapbJPrW6kj/+YR+ShLKfStw/PbdhIzc2xiPrMDSMMt/oXLHXPIBdB
 Cyi0SUU+ihybv+pSgsjc5F97EOQHee8auV95qIzOgPLFP3bV8DLr6jQiqBJUMKQXsvLo
 Y9OadzsRmfXuH4hyZuG5C6ZQ+yZcaI1cUiOTx3t1mknh7qOFFmZ+HiBGTjLC3vXJX42u
 bqaQ==
X-Gm-Message-State: AOJu0Yzzyn+Dta5l3+cHmPhmxkGOVdzStga5rT5wjYWqJKYFDjTOspxF
 JQEZyqM3czsf0V7yynT61j7zvci3LMSMV/Lw9aEzUJNSORJxF0nvQEpEUk85Dc6SHAllfNConNL
 O/ZPIRps=
X-Gm-Gg: AZuq6aLnA3kU3bbjan5xhZ67Oi+0MH+M5auBaqrPebMZaA2ec23Ah0TJNe3h8g1orUk
 fHJDGT9aXIDtNpImqOabF2mG5mIYwbkGAqK5hipT4NQ5vmtJetep6pIvj29sji6urzN+jaDN9gG
 bhEUwkBkZtNlqrNLk6e7Hk1f8N8BSdD8v3bQDSKA/4pQbPvbetxmRx47Z7HO3xU+Nj48rCHKqn3
 YsWAh6OKQqe8RkzYt9VRhldOMx6ihM40PkcvUTDhfTDaAeYdY+RTut7U31r6j/b3ubS3LHCSLG6
 MeffGG8LA5Fnf+WZPnGABD+hLxgHw87AjswBRqrfWFs54vW2NR+BtSjMCIlS2oU7UpdKdshy/P1
 Wi6ew+3qAkbZrvSzhTEVUxKgSkv912ZCtKZWhi3HAy+zdK7wMgcB7dh10HpGeoDrub/GPmlfeHn
 8+SKVfI1Pb0jHNd6vFhhCbUCYP2O4o1Q==
X-Received: by 2002:a5d:5f54:0:b0:431:3a5:d9ae with SMTP id
 ffacd0b85a97d-435f3a6cc94mr184486f8f.4.1769702967096; 
 Thu, 29 Jan 2026 08:09:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/43] hw/arm/smmuv3-accel: Initialize shared system address
 space
Date: Thu, 29 Jan 2026 16:08:40 +0000
Message-ID: <20260129160917.1415092-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

To support accelerated SMMUv3 instances, introduce a shared system-wide
AddressSpace (shared_as_sysmem) that aliases the global system memory.
This shared AddressSpace will be used in a subsequent patch for all
vfio-pci devices behind all accelerated SMMUv3 instances within a VM.

Sharing a single system AddressSpace ensures that all devices behind
accelerated SMMUv3s use the same system address space pointer. This
allows VFIO/iommufd to reuse a single IOAS ID in iommufd_cdev_attach(),
enabling the Stage-2 page tables to be shared within the VM rather than
duplicated for each SMMUv3 instance.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-7-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 99ef0db8c4..b2eded743e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -11,6 +11,14 @@
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-accel.h"
 
+/*
+ * The root region aliases the global system memory, and shared_as_sysmem
+ * provides a shared Address Space referencing it. This Address Space is used
+ * by all vfio-pci devices behind all accelerated SMMUv3 instances within a VM.
+ */
+static MemoryRegion root, sysmem;
+static AddressSpace *shared_as_sysmem;
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -51,9 +59,27 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_address_space = smmuv3_accel_find_add_as,
 };
 
+static void smmuv3_accel_as_init(SMMUv3State *s)
+{
+
+    if (shared_as_sysmem) {
+        return;
+    }
+
+    memory_region_init(&root, OBJECT(s), "root", UINT64_MAX);
+    memory_region_init_alias(&sysmem, OBJECT(s), "smmuv3-accel-sysmem",
+                             get_system_memory(), 0,
+                             memory_region_size(get_system_memory()));
+    memory_region_add_subregion(&root, 0, &sysmem);
+
+    shared_as_sysmem = g_new0(AddressSpace, 1);
+    address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
+}
+
 void smmuv3_accel_init(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
 
     bs->iommu_ops = &smmuv3_accel_ops;
+    smmuv3_accel_as_init(s);
 }
-- 
2.43.0


