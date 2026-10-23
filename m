Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB38606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlS-00034e-AQ; Fri, 23 Oct 2026 15:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlG-00030R-6A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:08 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlE-00023e-PW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:05 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlA-00000007BFM-2CUU; Fri, 23 Oct 2026 21:17:00 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 06/13] spapr/xive: Split VM state change handler into start
 and stop parts
Date: Fri, 23 Oct 2026 21:16:17 +0200
Message-ID: <8945320039882c06fa33682db6fc0b097e11d7e5.1792758436.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This will allow moving the VM start part of this handler into
VM_CHANGE_STATE_PRI_HIGH.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/intc/spapr_xive_kvm.c | 74 ++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 26d30b41c15c..e1a4f0b640cb 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -498,39 +498,51 @@ static int kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
  * runs again. If an interrupt was queued while the VM was stopped,
  * simply generate a trigger.
  */
-static void kvmppc_xive_change_state_handler(void *opaque, bool running,
-                                             RunState state)
+static void kvmppc_xive_change_state_start(void *opaque, bool running,
+                                           RunState state)
+{
+    SpaprXive *xive = opaque;
+    XiveSource *xsrc = &xive->source;
+    int i;
+
+    if (!running) {
+        return;
+    }
+
+    /*
+     * Restore the sources to their initial state. This is called when
+     * the VM resumes after a stop or a migration.
+     */
+    for (i = 0; i < xsrc->nr_irqs; i++) {
+        uint8_t pq;
+        uint8_t old_pq;
+
+        if (!xive_eas_is_valid(&xive->eat[i])) {
+            continue;
+        }
+
+        pq = xive_source_esb_get(xsrc, i);
+        old_pq = xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8));
+
+        /*
+         * An interrupt was queued while the VM was stopped,
+         * generate a trigger.
+         */
+        if (pq == XIVE_ESB_RESET && old_pq == XIVE_ESB_QUEUED) {
+            kvmppc_xive_esb_trigger(xsrc, i);
+        }
+    }
+}
+
+static void kvmppc_xive_change_state_stop(void *opaque, bool running,
+                                          RunState state)
 {
     SpaprXive *xive = opaque;
     XiveSource *xsrc = &xive->source;
     Error *local_err = NULL;
     int i;
 
-    /*
-     * Restore the sources to their initial state. This is called when
-     * the VM resumes after a stop or a migration.
-     */
     if (running) {
-        for (i = 0; i < xsrc->nr_irqs; i++) {
-            uint8_t pq;
-            uint8_t old_pq;
-
-            if (!xive_eas_is_valid(&xive->eat[i])) {
-                continue;
-            }
-
-            pq = xive_source_esb_get(xsrc, i);
-            old_pq = xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8));
-
-            /*
-             * An interrupt was queued while the VM was stopped,
-             * generate a trigger.
-             */
-            if (pq == XIVE_ESB_RESET && old_pq == XIVE_ESB_QUEUED) {
-                kvmppc_xive_esb_trigger(xsrc, i);
-            }
-        }
-
         return;
     }
 
@@ -573,6 +585,16 @@ static void kvmppc_xive_change_state_handler(void *opaque, bool running,
     }
 }
 
+static void kvmppc_xive_change_state_handler(void *opaque, bool running,
+                                             RunState state)
+{
+    if (running) {
+        kvmppc_xive_change_state_start(opaque, running, state);
+    } else {
+        kvmppc_xive_change_state_stop(opaque, running, state);
+    }
+}
+
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
 {
     assert(xive->fd != -1);

