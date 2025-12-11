Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7555D41D68
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjwa-0001Ai-Ho; Thu, 11 Dec 2025 11:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTjwY-00019z-Og
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTjwW-0007Gl-Cw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765472103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=My+KXsPYZwIFJL6hbxGCP4m3aGqq0Z98Ndk4aLinfO0=;
 b=XJ4q6AqfRD5WQF8ATa36A7rz5EK155aLrOAfnovM8JY0btRY77ffBTJFclVtXRVFcwzQ+g
 Ug9J1uE5qtaD+8ZWczWFbJdO9sHcPpN503POh+XIlYbt3cOHDRKm6NmauM11njkfyoj8l/
 +cFCiXhcSj/lSzdJpCpyav3bdkgp7dw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-Zr_OTWGWOdON30jIbHMlXg-1; Thu,
 11 Dec 2025 11:55:00 -0500
X-MC-Unique: Zr_OTWGWOdON30jIbHMlXg-1
X-Mimecast-MFC-AGG-ID: Zr_OTWGWOdON30jIbHMlXg_1765472098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E15F1801223; Thu, 11 Dec 2025 16:54:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AAD4180049F; Thu, 11 Dec 2025 16:54:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Ryabinin <arbn@yandex-team.com>, qemu-stable@nongnu.org,
 mst@redhat.com, michael.roth@amd.com
Subject: [PATCH v2] q35: Fix migration of SMRAM state
Date: Thu, 11 Dec 2025 17:54:54 +0100
Message-ID: <20251211165454.288476-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
Cc: qemu-stable@nongnu.org
Cc: mst@redhat.com
Cc: arbn@yandex-team.com
Cc: michael.roth@amd.com
---
 hw/pci-host/q35.c      | 25 +++++++++++--------------
 tests/qtest/q35-test.c |  6 ------
 2 files changed, 11 insertions(+), 20 deletions(-)

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


