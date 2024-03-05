Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F71C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 22:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhdCy-0002vE-Vo; Tue, 05 Mar 2024 17:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rhdCx-0002ug-1F
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:24:23 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rhdCv-00041P-Fh
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709677461; x=1741213461;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JVSLsCt100O5cumDAYulG0qVW0mpiqCQsOqGUNIs7uM=;
 b=BGQGzGdsCzjs4IIvvqXel1ycZFvz9P14YKrWYJ/0LpdxK4vbk4HJkQLA
 7t3ydTQWDp6kf673fE8ucIfgCqEdHhRsrefBF36qX+w6KvUpiXU5wGUAN
 GsbsP0eZ3eTqtvWk6YMchlL1528qscXH1gXE/2i+iDpFkpSp1V7exoIjM
 4XWm3hXCj8PaLuE42vhTmsYep6Q4/b41iRzPdV8FFaDa0rKJhIhcyFRW6
 pTjYKT/v1yps/Pv3EPb+nnowd78WKG5YNC7FQoJlWnJEFudOr6H4f3nWD
 DLS1P0CrBfcAl/D42gjOLXlorKiqLKNumhZidJr3bP35b16jJFDZHCT4d g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14910549"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; d="scan'208";a="14910549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 14:24:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; d="scan'208";a="40414937"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa002.jf.intel.com with ESMTP; 05 Mar 2024 14:24:12 -0800
From: dongwon.kim@intel.com
To: marcandre.lureau@gmail.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] virtio-gpu: first surface update with blob scanout after
 resumed
Date: Tue,  5 Mar 2024 14:22:52 -0800
Message-Id: <20240305222252.3232608-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305222252.3232608-1-dongwon.kim@intel.com>
References: <CAJ+F1CJjRZORH-LbA5dhY_0OZo0AHMbkJ3WkY=SA1ot9=-t0cg@mail.gmail.com>
 <20240305222252.3232608-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

The guest surface needs to be updated with a blob scanout after resumed
from saved vm state if blob is enabled.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1c1ee230b3..01bc4f9565 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1422,16 +1422,23 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
         if (!res) {
             return -EINVAL;
         }
-        scanout->ds = qemu_create_displaysurface_pixman(res->image);
-        if (!scanout->ds) {
-            return -EINVAL;
-        }
+
+        if (res->blob_size) {
+            assert(g->dmabuf.primary[i] != NULL);
+            g->dmabuf.primary[i]->buf.fd = res->dmabuf_fd;
+            dpy_gl_scanout_dmabuf(scanout->con, &g->dmabuf.primary[i]->buf);
+        } else {
+            scanout->ds = qemu_create_displaysurface_pixman(res->image);
+            if (!scanout->ds) {
+                return -EINVAL;
+            }
 #ifdef WIN32
-        qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
+            qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
 #endif
+            dpy_gfx_replace_surface(scanout->con, scanout->ds);
+            dpy_gfx_update_full(scanout->con);
+        }
 
-        dpy_gfx_replace_surface(scanout->con, scanout->ds);
-        dpy_gfx_update_full(scanout->con);
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
         }
-- 
2.34.1


