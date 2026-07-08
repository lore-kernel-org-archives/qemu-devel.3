Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DC9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whR6c-0004Y8-G7; Wed, 08 Jul 2026 08:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6Z-0004Vm-RG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6X-0005pW-3B
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso566527f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783512615; x=1784117415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3xzKir4eMZg0At6RdgLttLphr54QRaQbGQkt+BPQ2AY=;
 b=WLY3220LTEMw0si3VBMoKhR1YWjKRTONS2XWllXKr+V5uZ00UAga9lqI+DsvAJKdY9
 N13Hpks0kgBdxxHh94mvGNbG4r8CqdPVwSN+eP5Z47BgOl05Y3mXYJlvqXcQNuWfv4zW
 FTnobtiwnh8838zab8sTo6jbjGF73a2avnaDkyahedYRykplBBHu3H4pLyPmRMJAUm+S
 sdfHrfd8rMk2AA75h2LD1Ds7ZTcMmrvxxn+yrytMhOgjfBIkmVn3SM/xU6h/HzXBu2FG
 hw0jnBbdmQyYn+XhjhzEyY2UC1zgW+v09uxgLWJRlN5oR2Inhdok+qYDoVRaGlWfG3Vy
 sk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512615; x=1784117415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3xzKir4eMZg0At6RdgLttLphr54QRaQbGQkt+BPQ2AY=;
 b=BvriNc3h9r4Y2Fvz85hy8jPaMwKxzHRrqQtx7ME1xe08s9hqUbZHczKU+yX+FSYYSD
 X4o/I+MobaBVTJ/AwKQMFZotiIN80PO1Nh2/rckH2Wm0HXFcX2e2g8drECQ+QGke6eUu
 aDQiRihkOkrZc1blfCtI4zjCSA9eK1CjTmfoqhSoGkYjQoAm0b6mVmOdMBiMB04sMsZ6
 Ds50Z8zgtByYl1TT7xhzo5E3af+CaZoVDqx9fXV3teStk8NtiAFOcDLf6tdNHW8NFMaz
 Y5H8DIMueluy4H+BoQnkWLksK18GOlrj6n5oog1B3o218VxwALA6+zRVOy6F5xzzFYZR
 z4JA==
X-Gm-Message-State: AOJu0YzEExgd6JPfHb8p3MyUgQiEzjLoWroGwLnpU5pNBbs2gAZOrR2+
 hmaKR4z1l3TTKSvys/T7gICpfSzjiWAE+UlLmatoU+MjrWB8uyKFHAklZJEdljMy8ba2b4eokfC
 KBI/UXybnjw==
X-Gm-Gg: AfdE7cnQOXgoyHqUO8XwYlPLpFZbPeBToxu7fD8P+lEriYY9cTnb0qwgT1aR3326vw+
 ebehgQNDLhOKmwy3P5QiE77zAPio351jB18HkZFCvIRAiS387z8JoqbDLzOeKmnpayz1C1pRsRO
 swshDO9U5rKCxzi3XvO/0vSdK7suHfZidUs4g2BInnD320kw6xlrEpoFIuwE7jHcByvuUMjsuU4
 aNH/+qD3GfPdEalyIW1sT6JEGNkky2/xiNI1LfNRqqbzS2i3nqc4R2x9dx2KEK+nimBWu/LmuSQ
 uro2P7NYUH9lohikEad+o+tszWFW+L5Y5Tb6r2VLvVRIC3qyjAo3csmCHBrpPgDEJvALkgzpwgW
 88bqJ8bcuoa7NANtWqrRlXsIsIZQiguGVEGqe6XNwJ+BWdl7S9sW+T6YCvMr/3aGgVLKyvCXEch
 4x3UwUP73FXCcjC/BfKnMfcpBZZSKTAwa2jI2kZ/unjmtfJHrVkYlgg6bfdhgLVH8s8b4fSldgU
 5rxlN4VkTJBppDxH9htamI+bfzSY5N3
X-Received: by 2002:a05:6000:2285:b0:475:f0c2:75ac with SMTP id
 ffacd0b85a97d-47df07baa0cmr2593756f8f.61.1783512615528; 
 Wed, 08 Jul 2026 05:10:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm43386298f8f.11.2026.07.08.05.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:10:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH 2/3] hw/pci-host/q35.c: Factor out creation of SMRAM MRs
Date: Wed,  8 Jul 2026 13:10:10 +0100
Message-ID: <20260708121011.1653365-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708121011.1653365-1-peter.maydell@linaro.org>
References: <20260708121011.1653365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

mch_realize has a large section that deals with initializing the
SMRAM-specific MemoryRegions.  Currently we do an early return from
the realize function if mch->has_smm_ranges is false, but this has
the potential for bugs if somebody adds new code at the end of the
function that isn't SMM-specific.  Pull the MR init code out into its
own function, so we can do the smm-ranges specific handling in the
realize function in a more obvious way.

This commit shouldn't change behaviour at all.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


