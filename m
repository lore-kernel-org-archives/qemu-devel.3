Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A357C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 11:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5jvX-0005Wq-95; Fri, 18 Apr 2025 07:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u5jvT-0005Vo-DO
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:31 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u5jvI-0005nx-Dk
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:28 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 396D01C1687; Fri, 18 Apr 2025 13:29:58 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v3 7/9] h264: do not reduce vnc update speed while we have an
 active h264 stream
Date: Fri, 18 Apr 2025 13:29:51 +0200
Message-Id: <20250418112953.1744442-8-dietmar@proxmox.com>
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

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
---
 ui/vnc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index feab4c0043..6db03a1550 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3222,6 +3222,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     VncDisplay *vd = container_of(dcl, VncDisplay, dcl);
     VncState *vs, *vn;
     int has_dirty, rects = 0;
+    bool keep_dirty = false;
 
     if (QTAILQ_EMPTY(&vd->clients)) {
         update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_MAX);
@@ -3249,6 +3250,9 @@ static void vnc_refresh(DisplayChangeListener *dcl)
                     vs->h264->keep_dirty--;
                 }
             }
+            if (vs->h264->keep_dirty > 0) {
+                keep_dirty = true;
+            }
         }
 
         int count = vnc_update_client(vs, client_dirty);
@@ -3266,7 +3270,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
         /* vs might be free()ed here */
     }
 
-    if (has_dirty && rects) {
+    if ((has_dirty && rects) || keep_dirty) {
         vd->dcl.update_interval /= 2;
         if (vd->dcl.update_interval < VNC_REFRESH_INTERVAL_BASE) {
             vd->dcl.update_interval = VNC_REFRESH_INTERVAL_BASE;
-- 
2.39.5


