Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCD2C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzK9-0000Ry-7a; Tue, 25 Feb 2025 13:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ3-0008HQ-Qy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:23 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ1-0002Bs-BL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:21 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f3486062eso4995888f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506716; x=1741111516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aeWgldfF5Idz9YHODjOgtv9UXfco158ep0/S/kAtgfw=;
 b=f1BaSFD9phLyBA3u7pCiyid4WB18mnmNG98WdEOW4JgSUqmanLtbgp4O75Zle1H+yP
 mhDSkm1wyemeR6+43aJjYEu2t157Hp4gQ1lIHDOlnJOnL/FTh9viy9Icob/H+FLcW0Lr
 fiPyxUWx9PKQUN0HGpE3APxZVGYBgd5OefQGAKFI8sgxZsYJhWX3J/UegYSHg92lB7Sb
 SQRnfPqJysvfgDMbgYUIuaSYtzW20djyRPbOeKLuK68KZi4qekodDz7Aud+D518y1o+S
 WJxdElN5LEJQkZrMqMmZj/J6GU65kWCvlYY7UVeutmJQzdXDLqM29ngS5NShBKLd5Fzh
 YiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506716; x=1741111516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeWgldfF5Idz9YHODjOgtv9UXfco158ep0/S/kAtgfw=;
 b=LUOH0wJeNHl6GJ4iCy5dS5eNSDJIK5trYDLGdGWSscUf9j0Uvf0CEqjQfE7rr5/BYM
 JWu+kBXsWAVitbepMGi82sV87vC2ugt/nM8UN8TC80VkU8V0IMCJj8CjI235c4VE4pvx
 7h+iea4HiqsOn+cdClaqwsxTJpLxySVYv3qte4Cp8pgl/QX+rXFyKupSWWCTHx1rC0JP
 9R+Ro7l6E/EblcVRG2Dfv4Xjd3hYCTomdpyzwSSJUWvpgbpfkWZ124+ALpb+n4muz72d
 95pCjlWxwHE2CoxWL3E2t6rNHOKKTt6Op6EeJGhSYr9qI5U8XNn9tYKEcE5MmPYNqudt
 DMfg==
X-Gm-Message-State: AOJu0YyHLLhIRIg1chezqexZwpGttDS+5v47qcpBDzhcS03xqXSmqg3+
 jnssRiKJkcq20QT8xHoargGmCTSb+jAA7ilZrGpbzeI/U+PAmjwOETIXA7r1pVfm39ExkA2srgU
 b
X-Gm-Gg: ASbGncs0T5EsenO72esxUaEeBpXjWMG8ilpg+7zrVUmuwTr7UWgEAQR11sWRZ9zM6wd
 1ZUNr0s9W1IJ70o2LfFTmx3U9yQiqWwFxRu8jpaM8FVIC+KH2yUbHQiSkj7ftYcxWxf2CPhtnA7
 sAU/cnn5e0ObYgGSWVnVlKIA/oAGHuRRLVi6eXfT9n6W3gHyjZJi3uP/huR0JI7lKTwyFWU/mfC
 vooUGgezTtmnsG8xdhbnYhKNahlkjLuINaD/kCWcEmiG3M/7j+UM8HU8W2q1iKMvT9quM6Pp5gN
 6UZ16nCddk0mJnApPrbwQnKuXmKCtBw7
X-Google-Smtp-Source: AGHT+IG+1iA2JFkatPF2RuTwN2OmxSfCT0p8XkcyXv6hMB7x/BHFVSX+aan7GhFpQXKze3A6zopu4g==
X-Received: by 2002:a5d:5986:0:b0:38f:470c:932e with SMTP id
 ffacd0b85a97d-390d4f43d31mr271149f8f.29.1740506716116; 
 Tue, 25 Feb 2025 10:05:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/43] hw/arm/virt: Support larger highmem MMIO regions
Date: Tue, 25 Feb 2025 18:04:28 +0000
Message-ID: <20250225180510.1318207-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: "Matthew R. Ochs" <mochs@nvidia.com>

The MMIO region size required to support virtualized environments with
large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
(currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
new parameter, highmem-mmio-size, that specifies the MMIO size required
to support the VM configuration.

Example usage with 1TB MMIO region size:
	-machine virt,gic-version=3,highmem-mmio-size=1T

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250221145419.1281890-1-mochs@nvidia.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst |  4 ++++
 hw/arm/virt.c            | 52 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 0c9c2ce0351..adf446c0a29 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -144,6 +144,10 @@ highmem-mmio
   Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
   The default is ``on``.
 
+highmem-mmio-size
+  Set the high memory region size for PCI MMIO. Must be a power of 2 and
+  greater than or equal to the default size (512G).
+
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
   Valid values are:
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a5a9666e91..ee69081ef42 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -53,6 +53,7 @@
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
@@ -192,6 +193,10 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_MEM] =                { GiB, LEGACY_RAMLIMIT_BYTES },
 };
 
+/* Update the docs for highmem-mmio-size when changing this default */
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
+#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
+
 /*
  * Highmem IO Regions: This memory map is floating, located after the RAM.
  * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
@@ -207,13 +212,16 @@ static const MemMapEntry base_memmap[] = {
  * PA space for one specific region is always reserved, even if the region
  * has been disabled or doesn't fit into the PA space. However, the PA space
  * for the region won't be reserved in these circumstances with compact layout.
+ *
+ * Note that the highmem-mmio-size property will update the high PCIE MMIO size
+ * field in this array.
  */
 static MemMapEntry extended_memmap[] = {
     /* Additional 64 MB redist region (can contain up to 512 redistributors) */
     [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
     [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
     /* Second PCIe window */
-    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
+    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
 };
 
 static const int a15irqmap[] = {
@@ -2550,6 +2558,40 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
     vms->highmem_mmio = value;
 }
 
+static void virt_get_highmem_mmio_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
+
+    visit_type_size(v, name, &size, errp);
+}
+
+static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t size;
+
+    if (!visit_type_size(v, name, &size, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(size)) {
+        error_setg(errp, "highmem-mmio-size is not a power of 2");
+        return;
+    }
+
+    if (size < DEFAULT_HIGH_PCIE_MMIO_SIZE) {
+        char *sz = size_to_str(DEFAULT_HIGH_PCIE_MMIO_SIZE);
+        error_setg(errp, "highmem-mmio-size cannot be set to a lower value "
+                         "than the default (%s)", sz);
+        g_free(sz);
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
+}
 
 static bool virt_get_its(Object *obj, Error **errp)
 {
@@ -3207,6 +3249,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-size", "size",
+                                   virt_get_highmem_mmio_size,
+                                   virt_set_highmem_mmio_size,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-size",
+                                          "Set the high memory region size "
+                                          "for PCI MMIO");
+
     object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
-- 
2.43.0


