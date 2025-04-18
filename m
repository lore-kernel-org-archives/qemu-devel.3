Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76BC369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 11:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5jvZ-0005Xa-2q; Fri, 18 Apr 2025 07:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u5jvT-0005Vp-EK
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:31 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u5jvI-0005nw-Fa
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:30 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 3AAC31C1689; Fri, 18 Apr 2025 13:29:58 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v3 8/9] vnc: initialize gst during argument processing
Date: Fri, 18 Apr 2025 13:29:52 +0200
Message-Id: <20250418112953.1744442-9-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418112953.1744442-1-dietmar@proxmox.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

So that we can set --gst- options on the qemu command line.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 system/vl.c | 8 ++++++++
 ui/vnc.c    | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index ec93988a03..c7fff02da2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -140,6 +140,10 @@
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
 
+#ifdef CONFIG_GSTREAMER
+#include <gst/gst.h>
+#endif
+
 #define MAX_VIRTIO_CONSOLES 1
 
 typedef struct BlockdevOptionsQueueEntry {
@@ -2848,6 +2852,10 @@ void qemu_init(int argc, char **argv)
     bool userconfig = true;
     FILE *vmstate_dump_file = NULL;
 
+#ifdef CONFIG_GSTREAMER
+    gst_init(&argc, &argv);
+#endif
+
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
diff --git a/ui/vnc.c b/ui/vnc.c
index 6db03a1550..8f6287e2e6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4350,10 +4350,6 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     Error *local_err = NULL;
     char *id = (char *)qemu_opts_id(opts);
 
-#ifdef CONFIG_GSTREAMER
-    gst_init(NULL, NULL);
-#endif
-
     assert(id);
     vnc_display_init(id, &local_err);
     if (local_err) {
-- 
2.39.5


