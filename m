Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FDAC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAOR-0004fd-EX; Wed, 12 Aug 2026 10:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANw-0004Ip-A4; Wed, 12 Aug 2026 10:57:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANt-0000fd-CK; Wed, 12 Aug 2026 10:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=uLP/a/QcV0T+YEJpa7z43KYjjzg21NjN5jAGVeIN2j0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QVahV31ifm9mqXlGNvGZ+RpczLFpTFKKGqyWFZSdAsSp+ZLQZR3B82DseIP0100oF
 mWJjJ9fr+M5gC5BYrPaSr9E+jbKc3IA43G/SIKkaEIUz9kKFV9A9YmD9YIVpsQEo6T
 03w1mcuiio/KEv6+88FMk1c9OjscrT55bXETfq2XoO/TxJQJcZEc7goIItAZeJRq2B
 zUY6HO4rekYHux8ecSsfrFRZGE9H7He/WOyCcQoCTJNFOCEG+TrBsM/u1NA13eCZnm
 2VRWFVQ4wraC3dSgLxwuTMuoHnbxGqiXWrma0bYKbxqP3SDM20bDqeM48UUJI4ph0h
 R+9votfWCRk6A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6CC621CA641;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C7DAE409D83;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 31CB12F9DD; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Michael S. Tsirkin <mst@redhat.com>
Subject: [Stable-11.0.4 061/120] hw/pci-host/q35.c: Factor out creation of
 SMRAM MRs
Date: Wed, 12 Aug 2026 17:48:44 +0300
Message-ID: <20260812144955.649205-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit a90fcf0080da2bd372f0a79dc243d8d2ede1b244)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index cea8fc461a0..e44f23c1d9f 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -561,49 +561,9 @@ static void mch_reset(DeviceState *qdev)
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
@@ -659,9 +619,52 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_set_enabled(&mch->smbase_window, false);
     memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
                                 &mch->smbase_window);
+}
+
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
 
-    object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&mch->smram));
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
2.47.3


