Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422B3D1BDC7
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrIk-0000kU-Op; Wed, 03 Dec 2025 13:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbn@yandex-team.com>)
 id 1vQrIj-0000jg-97; Wed, 03 Dec 2025 13:10:05 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbn@yandex-team.com>)
 id 1vQrIg-0001dj-Pq; Wed, 03 Dec 2025 13:10:05 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8D6C7C025D;
 Wed, 03 Dec 2025 21:09:55 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id i9pC1H0FiiE0-TW3owxNw; Wed, 03 Dec 2025 21:09:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1764785394;
 bh=5VEwO6j3obQQ2TRfdfxCT6aJ77MYSAFjHU/OOToQmDE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=1YSXKKk5Aif1tHig/autYfoiCDrqYTEEYFYEqbz63NFt6Wvzgen50EvKsk+jIsz9U
 hq1O8U06LgjlJYNXH6sdhy8vKuPohf24hUkc19HAnip5Bs+8yu4N1bdw3EKnDgGPoz
 KnRvvk+CKsiTELrAzcT83DqCrbGhTBpQS9UMC74U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Andrey Ryabinin <arbn@yandex-team.com>, qemu-stable@nongnu.org
Subject: [PATCH] q35: Fix migration of SMRAM state
Date: Wed,  3 Dec 2025 19:08:51 +0100
Message-ID: <20251203180851.6390-1-arbn@yandex-team.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72; envelope-from=arbn@yandex-team.com;
 helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

mch_update_smbase_smram() essentially uses wmask[MCH_HOST_BRIDGE_F_SMBASE]
to track SMBASE area state. Since 'wmask' state is not migrated is not
migrated, the destination QEMU always sees
 wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff

As a result, when mch_update() calls mch_update_smbase_smram() on the
destination, it resets ->config[MCH_HOST_BRIDGE_F_SMBASE] and disables
the smbase-window memory region—even if it was enabled on the source.

'info mtree' on source:
  address-space: KVM-SMRAM
    0000000000000000-ffffffffffffffff (prio 0, i/o): mem-container-smram
      0000000000000000-00000000ffffffff (prio 10, i/o): smram
        0000000000030000-000000000004ffff (prio 0, i/o): alias smbase-window @pc.ram
        00000000000a0000-00000000000bffff (prio 0, i/o): alias smram-low @pc.ram
        000000007f000000-000000007fffffff (prio 0, i/o): alias tseg-window @pc.ram
      0000000000000000-ffffffffffffffff (prio 0, i/o): alias mem-smram @system

'info mtree' on dest after migration:
  address-space: KVM-SMRAM
    0000000000000000-ffffffffffffffff (prio 0, i/o): mem-container-smram
      0000000000000000-00000000ffffffff (prio 10, i/o): smram
        00000000000a0000-00000000000bffff (prio 0, i/o): alias smram-low @pc.ram
        000000007f000000-000000007fffffff (prio 0, i/o): alias tseg-window @pc.ram
      0000000000000000-ffffffffffffffff (prio 0, i/o): alias mem-smram @system

This mismatch in memory regions breaks CPR-transfer migration with VFIO:
the DMA mappings sent via VFIO_IOMMU_MAP_DMA on the destination must
match the source. Otherwise, the destination QEMU aborts:

    qemu: vfio_container_dma_map(0x..., 0x0, 0xa0000, 0x....) = -22 (Invalid argument)
    qemu: hardware error: vfio: DMA mapping failed, unable to continue

According to mch_update_smbase_smram() the valid combinations of
->config and ->wmask for MCH_HOST_BRIDGE_F_SMBASE are:

  1) ->config[] == 0x0 && ->wmask[] == 0xff
  2) ->config[] == MCH_HOST_BRIDGE_F_SMBASE_IN_RAM &&
          ->wmask[] == MCH_HOST_BRIDGE_F_SMBASE_LCK
  3) ->config[] == MCH_HOST_BRIDGE_F_SMBASE_LCK &&
          ->wmask[] == 0

Add mch_smbase_smram_post_load() to restore ->wmask of
MCH_HOST_BRIDGE_F_SMBASE based on ->config[] value, ensuring that the
follow-up call to mch_update_smbase_smram() correctly reinstates the
smbase-window region if it was enabled on the source.

Cc: qemu-stable@nongnu.org
Fixes: f404220e279c ("q35: implement 128K SMRAM at default SMBASE address")
Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 hw/pci-host/q35.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a708758d36..2466a1aded 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -517,9 +517,27 @@ static void mch_update(MCHPCIState *mch)
                      IO_APIC_DEFAULT_ADDRESS - 1);
 }
 
+static void mch_smbase_smram_post_load(MCHPCIState *mch)
+{
+    PCIDevice *pd = PCI_DEVICE(mch);
+    uint8_t *reg = pd->config + MCH_HOST_BRIDGE_F_SMBASE;
+
+    if (!mch->has_smram_at_smbase) {
+        return;
+    }
+
+    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_IN_RAM) {
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
+            MCH_HOST_BRIDGE_F_SMBASE_LCK;
+    } else if (*reg == MCH_HOST_BRIDGE_F_SMBASE_LCK) {
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
+    }
+}
 static int mch_post_load(void *opaque, int version_id)
 {
     MCHPCIState *mch = opaque;
+
+    mch_smbase_smram_post_load(mch);
     mch_update(mch);
     return 0;
 }
-- 
2.51.2


