Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B2C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAOH-0004Ug-RW; Wed, 12 Aug 2026 10:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANu-0004Ii-Nt; Wed, 12 Aug 2026 10:56:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuANr-0000dm-TD; Wed, 12 Aug 2026 10:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=/5bI8CbkXuhLAz9DBCs0/cxXj6OkBC82Ca6dNN8glwg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iCtPtmvn7yvDwR65gULI0085BMuOKWST6V+vKWHTWX9ohI+jxhc6NHbwOH8srgyI9
 NgGN52oPkt7lHUuN8EHH2le8Q1vhL420u3cGmcMPMVFuozcxpisf0dOl+/suD9KZ66
 04aBOXUb6YAJx5cqZNUPTisv6fpLRiMmmGPk2uwHATEleR289Ks3JpC/qJkwwxsRrc
 XYkfKHMh8wiNo9vV3iIbh+2iFlA9Y/Fsiy3u0EsLxhoiQP11/zYGyjQL6YV6T22eMz
 eLgyMl1TVhGQ8gKIofjQoxI1RhXiNEdXn4u0RQ5z9+UZQz8iuBPzQqSWqBq9a7tiol
 j+IcaIrpX5qQw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62C261CA640;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BD6F8409D82;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 29B1A2F9DB; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Michael S. Tsirkin <mst@redhat.com>
Subject: [Stable-11.0.4 060/120] hw/pci-host/q35.c: Always initialize
 smram-region even if SMM disabled
Date: Wed, 12 Aug 2026 17:48:43 +0300
Message-ID: <20260812144955.649205-60-mjt@tls.msk.ru>
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
index e85e4227b37..cea8fc461a0 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -585,11 +585,14 @@ static void mch_realize(PCIDevice *d, Error **errp)
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
@@ -597,6 +600,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
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


