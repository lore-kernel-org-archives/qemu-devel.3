Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B759C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8gl-0003eL-7V; Wed, 12 Aug 2026 09:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gE-00034s-FR; Wed, 12 Aug 2026 09:07:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gB-0005IT-92; Wed, 12 Aug 2026 09:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=KhHzsDRHX6+Bd2Y+eJr7Btn0LoDcs31chUSFqfCnDGU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VlnLS3dCWEBX83bzNMFwLly3ul5W5WYKd51L0VIqSuD265igG+pWTENJO+WD3TuU6
 vZRL5tyqL05Ex+1fqBCgen7Sckp3JKKPQlnrEwfIvw3PDhmNdF3+OzYdduIUQJ9aDO
 4Vww+CqQFq6w0eWEOB5MBeagrbE9+LHP5QSfRrGUpIcNOGq2Ome39udUGlaj7uhztR
 zgftptP5pYOX3NvjkjjZOW18NMo8ySdyBLhh2eNw4kWVxkOf9a7HQ0awqOzggKBGyg
 H5WYH3w9yc+c6urTih97TJuPQJ6zXO2k4TbRf6jKN57bH9BTt/seM7HE/mIFF17CFc
 Td6NTa9Smvm9A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 017871CA4B1;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 38228409B94;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4D8C02F8F8; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [Stable-10.0.13 050/102] hw/pci-host/q35.c: Always initialize
 smram-region even if SMM disabled
Date: Wed, 12 Aug 2026 16:01:25 +0300
Message-ID: <20260812130233.621965-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

The MCHPCIState::smram_region looks like it ought to be SMM-specific,
but it isn't, because its behaviour is "alias the PCI address space
into system memory at the SMRAM_C_BASE offset", and it must be
enabled for "hide SMRAM", and disabled for "show SMRAM".  If the
SMRAM regions are disabled, we want "hide SMRAM", so we need to
initialize and place this MR.  Do this in the minimal way, by moving
the "bail out of realize if has_smm_ranges is false" check down below
the initialization code.

This fixes a bug where disabling SMM causes the VGA screen to be
blank during seabios output, until the OS graphics driver is
initialized.  This is most obvious for accelerators which have no SMM
support (e.g.  NVMM, HVF, WHPX) as there smm=off is the default, but
you can also see it on KVM and TCG if you explicitly pass smm=off:
 qemu-system-x86_64 -machine q35,accel=kvm,smm=off

The early return is bug-prone, so we can refactor the code to clean
it up, but this is the minimal bug fix for backports, and is what
Debian used to work around this:
 https://salsa.debian.org/qemu-team/qemu/-/commit/6e0766f0f897dc2b75ab87dd59da0d4639bb37ee

Another proposed fix for this:
 https://patchew.org/QEMU/20260413170407.57574-1-mohamed@unpredictable.fr/
also moves an early return in mch_update-smram() and tweaks
mch_update_smram() accordingly.  This shouldn't be necessary, because
in the no-SMM case smram_region should always be enabled and we don't
want to allow the guest to make it disabled.

NetBSD bug: https://gnats.NetBSD.org/59721

Cc: qemu-stable@nongnu.org
Fixes: b07bf7b7 ("q35: Introduce smm_ranges property for q35-pci-host")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2608
Reported-by: Kroese (gitlab @kroese)
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260708121011.1653365-2-peter.maydell@linaro.org>
(cherry picked from commit 7ea56dcc9406b1588699e510439f782da7067d3e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 133b775444e..d93b0d7930f 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -586,11 +586,14 @@ static void mch_realize(PCIDevice *d, Error **errp)
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
-    if (!mch->has_smm_ranges) {
-        return;
-    }
-
-    /* if *disabled* show SMRAM to all CPUs */
+    /*
+     * This memory region looks like it's SMM specific, but it is not.
+     * It's an alias that makes the pci_address_space appear in system
+     * memory at the SMRAM_C_BASE address. The alias is enabled when the
+     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
+     * visible. So for non-SMM configs we need to create the alias, and
+     * leave it permanently enabled.
+     */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
@@ -598,6 +601,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
                                         &mch->smram_region, 1);
     memory_region_set_enabled(&mch->smram_region, true);
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
                              mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
-- 
2.47.3


