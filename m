Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586C7CCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 00:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiqO-0007X3-8s; Wed, 22 Oct 2025 20:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqN-0007Vu-1P; Wed, 22 Oct 2025 20:06:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqK-0004Y1-1V; Wed, 22 Oct 2025 20:06:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D2F5B5972EC;
 Thu, 23 Oct 2025 02:06:09 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id IXvh2wpz9IbW; Thu, 23 Oct 2025 02:06:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C542F5972EB; Thu, 23 Oct 2025 02:06:07 +0200 (CEST)
Message-ID: <366f14ce852415cc079727c54ac21a2aa6ff3917.1761176219.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761176219.git.balaton@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 01/12] ppc/vof: Make nextprop behave more like Open Firmware
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Thu, 23 Oct 2025 02:06:07 +0200 (CEST)
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

The FDT does not normally store name properties but reconstructs it
from path but Open Firmware specification says each node should at
least have this property. This is correctly handled in getprop but
nextprop should also return it even if not present as a property.

Explicit name properties are still allowed because they are needed
e.g. on the root node that guests expect to have specific names as
seen on real machines instead of being empty so sometimes the node
name may need to be overriden. For example on pegasos MorphOS checks
the name of "/" and expects to find bplan,Pegasos2 which is how it
identifies the machine.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/vof.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index f14efa3a7c..5ecfc68910 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -353,34 +353,50 @@ static uint32_t vof_nextprop(const void *fdt, uint32_t phandle,
 {
     int offset, nodeoff = fdt_node_offset_by_phandle(fdt, phandle);
     char prev[OF_PROPNAME_LEN_MAX + 1];
-    const char *tmp;
+    const char *tmp = NULL;
+    bool match = false;
 
     if (readstr(prevaddr, prev, sizeof(prev))) {
         return PROM_ERROR;
     }
-
-    fdt_for_each_property_offset(offset, fdt, nodeoff) {
-        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
-            return 0;
+    /*
+     * "name" may or may not be present in fdt but we should still return it.
+     * Do that first and then skip it if seen later.
+     */
+    if (prev[0] == '\0') {
+        tmp = "name";
+    } else {
+        if (strcmp(prev, "name") == 0) {
+            prev[0] = '\0';
         }
-        if (prev[0] == '\0' || strcmp(prev, tmp) == 0) {
-            if (prev[0] != '\0') {
-                offset = fdt_next_property_offset(fdt, offset);
-                if (offset < 0) {
-                    return 0;
-                }
-            }
+        fdt_for_each_property_offset(offset, fdt, nodeoff) {
             if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
                 return 0;
             }
-
-            if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
-                return PROM_ERROR;
+            if (strcmp(tmp, "name") == 0) {
+                continue;
+            }
+            if (match) {
+                break;
             }
-            return 1;
+            if (strcmp(prev, tmp) == 0) {
+                match = true;
+                continue;
+            }
+            if (prev[0] == '\0') {
+                break;
+            }
+        }
+        if (offset < 0) {
+            return 0;
         }
     }
-
+    if (tmp) {
+        if (VOF_MEM_WRITE(nameaddr, tmp, strlen(tmp) + 1) != MEMTX_OK) {
+            return PROM_ERROR;
+        }
+        return 1;
+    }
     return 0;
 }
 
-- 
2.41.3


