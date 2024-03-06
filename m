Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84908C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 22:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhzj8-0006Gp-4u; Wed, 06 Mar 2024 17:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rhzj3-0006GQ-PV
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 17:27:03 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rhzj2-0001so-9W
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 17:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709764020; x=1741300020;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BBjE9XClpmAwsjk06yoGeyZu7zAuV15lE4+CvBo3MJk=;
 b=T76yKrYjI06DDDeuNaRA7m3ijF1OW1DXs8L9HObPoMJwhxKaLq6tOssZ
 nuuUfyTgzB112xTcPfdgQ3z6zlZ+7HIW//8DxpuioSQ28zj25auWyO/kP
 pwzsSJfGHY6QY0lxHiyD5O2D8OaOgfngiJOjufanGtNZ7Gx0v1tllwRe2
 TR57YKPwhhFNaeoW46E0z6gwabPnvMYsHy+LegkrlynwMVrl+7LFEgAHE
 IgerDU5wSGqFobGMIHMXJJTrBKfht3Q6lsKGlVoQEqur/Ia5QU5qiq04s
 WqWZ35FBKeWbnHjNHMXSttK5Xo4isiPY0vi2TNw7nj4RJKNgaoiuGkfL6 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4254695"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4254695"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 14:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; d="scan'208";a="14553890"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa003.jf.intel.com with ESMTP; 06 Mar 2024 14:26:57 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-gpu: first surface update with blob scanout after
 resumed
Date: Wed,  6 Mar 2024 14:25:35 -0800
Message-Id: <20240306222535.3236855-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

v2: Rebased

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


