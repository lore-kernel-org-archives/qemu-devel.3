Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62185EA810A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmeD-0000w4-T0; Tue, 10 Feb 2026 07:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpme7-0000u5-PD; Tue, 10 Feb 2026 07:15:12 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpme4-0000Ds-Ej; Tue, 10 Feb 2026 07:15:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5595B187DA6;
 Tue, 10 Feb 2026 15:13:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E59BA360CC8;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Andrey Ryabinin <arbn@yandex-team.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 68/78] q35: Fix migration of SMRAM state
Date: Tue, 10 Feb 2026 15:14:21 +0300
Message-ID: <20260210121438.67781-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

When migrating, dst QEMU by default has SMRAM unlocked,
and since wmask is not migrated, the migrated value of
MCH_HOST_BRIDGE_F_SMBASE in config space fall to prey of

  mch_update_smbase_smram()
    ...
    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
        *reg = 0x00;

and is getting cleared and leads to unlocked smram
on dst even if on source it's been locked.

As Andrey has pointed out [1], we should derive wmask
from config and not other way around.

Drop offending chunk and resync wmask based on MCH_HOST_BRIDGE_F_SMBASE
register value. That would preserve the register during
migration and set smram regions into corresponding state.

What that changes is:
that it would let guest write junk values in register
(with no apparent effect) until it's stumbles upon
reserved 0x1 [|] 0x2 values, at which point it
would be only possible to lock register and trigger
switch to SMRAM blackhole in CPU AS.

While at it, fix up test by removing junk discard before negotiation hunk.

PS2:
Instead of adding a dedicated post_load handler for it,
reuse mch_update->mch_update_smbase_smram call chain
that is called on write/reset/post_load to be consistent
with how we handle mch registers.

PS3:
for prosterity here is erro message Andrey got due to this bug:
    qemu: vfio_container_dma_map(0x..., 0x0, 0xa0000, 0x....) = -22 (Invalid argument)
    qemu: hardware error: vfio: DMA mapping failed, unable to continue

1) https://patchew.org/QEMU/20251203180851.6390-1-arbn@yandex-team.com/

Fixes: f404220e279c ("q35: implement 128K SMRAM at default SMBASE address")
Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251211165454.288476-1-imammedo@redhat.com>
(cherry picked from commit 66cf169e29b06dca104c5a229fba0da4ce33599c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a708758d36..946342ba58 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -432,30 +432,27 @@ static void mch_update_smbase_smram(MCHPCIState *mch)
     }
 
     if (*reg == MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
-        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
-            MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
         *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
         return;
     }
 
     /*
-     * default/reset state, discard written value
-     * which will disable SMRAM balackhole at SMBASE
+     * reg value can come from register write/reset/migration source,
+     * update wmask to be in sync with it regardless of source
      */
-    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
-        *reg = 0x00;
+    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_IN_RAM) {
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        return;
     }
-
-    memory_region_transaction_begin();
     if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
-        /* disable all writes */
-        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=
-            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        /* lock register at 0x2 and disable all writes */
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
         *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
-        lck = true;
-    } else {
-        lck = false;
     }
+
+    lck = *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK;
+    memory_region_transaction_begin();
     memory_region_set_enabled(&mch->smbase_blackhole, lck);
     memory_region_set_enabled(&mch->smbase_window, lck);
     memory_region_transaction_commit();
diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index 62fff49fc8..4e3a4457f6 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -206,12 +206,6 @@ static void test_smram_smbase_lock(void)
     qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
     g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
 
-    /* check that writing junk to 0x9c before before negotiating is ignored */
-    for (i = 0; i < 0xff; i++) {
-        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
-        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
-    }
-
     /* enable SMRAM at SMBASE */
     qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0xff);
     g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x01);
-- 
2.47.3


