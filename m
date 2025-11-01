Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E10CCFA02
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 16:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFEqM-0002tt-Vd; Sat, 01 Nov 2025 12:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFEqK-0002sI-TJ; Sat, 01 Nov 2025 12:52:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFEqI-0006Xi-Dm; Sat, 01 Nov 2025 12:52:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7CECB5972E8;
 Sat, 01 Nov 2025 17:52:38 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 7DMw_nZe28nv; Sat,  1 Nov 2025 17:52:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 76E8B5972E3; Sat, 01 Nov 2025 17:52:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/ppc/pegasos: Fix memory leak
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
Date: Sat, 01 Nov 2025 17:52:36 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Commit 9099b430a4 introduced an early return that caused a leak of a
GString. Allocate it later to avoid the leak.

Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
Resolves: Coverity CID 1642027
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 3a498edd16..8ce185de3e 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -847,7 +847,7 @@ static struct {
 static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
 {
     FDTInfo *fi = opaque;
-    GString *node = g_string_new(NULL);
+    GString *node;
     uint32_t cells[(PCI_NUM_REGIONS + 1) * 5];
     int i, j;
     const char *name = NULL;
@@ -871,6 +871,7 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
             break;
         }
     }
+    node = g_string_new(NULL);
     g_string_printf(node, "%s/%s@%x", fi->path, (name ?: pn),
                     PCI_SLOT(d->devfn));
     if (PCI_FUNC(d->devfn)) {
-- 
2.41.3


