Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CACCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Rud-00007x-QV; Sun, 05 Oct 2025 12:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5RuZ-00005t-PK; Sun, 05 Oct 2025 12:48:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5RuX-000728-MS; Sun, 05 Oct 2025 12:48:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48AA115AA2B;
 Sun, 05 Oct 2025 19:48:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C80072996E9;
 Sun,  5 Oct 2025 19:48:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Gaurav Batra <gbatra@us.ibm.com>, David Christensen <drc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 64/81] ppc/spapr: init lrdr-capapcity phys with ram
 size if maxmem not provided
Date: Sun,  5 Oct 2025 19:47:44 +0300
Message-ID: <20251005164822.442861-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

lrdr-capacity contains phys field which communicates the maximum address
in bytes and therefore, the most memory that can be allocated to this
partition. This is usually populated when maxmem is provided alongwith
memory size on qemu command line. However since maxmem is an optional
param, this leads to bits being set to 0 in absence of maxmem param.
Fix this by initializing the respective bits as per total mem size in
such case.

Reported-by: Gaurav Batra <gbatra@us.ibm.com>
Tested-by: David Christensen <drc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Link: https://lore.kernel.org/r/20250506042903.76250-1-harshpb@linux.ibm.com
Message-ID: <20250506042903.76250-1-harshpb@linux.ibm.com>
(cherry picked from commit 6285eebd3a5fea018eb51d696b51079f44dd1eb3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1855a3cd8d..9e63671ece 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -907,6 +907,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
+    uint64_t max_device_addr = 0;
     uint32_t lrdr_capacity[] = {
         0,
         0,
@@ -917,13 +918,15 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 
     /* Do we have device memory? */
     if (MACHINE(spapr)->device_memory) {
-        uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
+        max_device_addr = MACHINE(spapr)->device_memory->base +
             memory_region_size(&MACHINE(spapr)->device_memory->mr);
-
-        lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
-        lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
+    } else if (ms->ram_size == ms->maxram_size) {
+        max_device_addr = ms->ram_size;
     }
 
+    lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
+    lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
+
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
     /* hypertas */
-- 
2.47.3


