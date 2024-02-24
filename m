Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89346C5478C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 00:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdgEX-0002Kh-Ax; Fri, 23 Feb 2024 19:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyeshwar.singh@intel.com>)
 id 1rdgEU-0002KJ-J6
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 19:49:38 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satyeshwar.singh@intel.com>)
 id 1rdgER-0004F2-Jg
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 19:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708735776; x=1740271776;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OF4AC9jXPv2xf6+wu6q+Bxa6uMXjEtKT2Zu/YAfY5Ls=;
 b=ipNVYRYwJs93wNZTY/wS0wiZYkFlatbRNZj297JUGObVnJqHxPhOLMgp
 EOueRefsQSYiRAEdBtRWTgs1T85Ah+6+xTtKttiYaT+cJ0ea+lXESxCrz
 jBiYNObGuSH4Osia1/4NY4X5AnxOvNcdcMo80UUcnlsvnTSxUKwXt2wOd
 jexouHAFoG9/G7LkZYjPNNMUFgOERMhBgtv0ZxWCMnqxrHGhPnFST7iYt
 QGe5D1ateWTAa2FiKGoSNzmyj8LWNWIDCP+hZRL0xoz/fsh8+lskb4BGo
 idD7rdSnKAR1BCqqMil8eUHUcVIhfgOGx2NQD+c8QHpva9A4hXtJ2lM68 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14508841"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; d="scan'208";a="14508841"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2024 16:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; d="scan'208";a="10767124"
Received: from ssingh-linux.fm.intel.com ([10.105.129.123])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2024 16:49:32 -0800
From: Satyeshwar Singh <satyeshwar.singh@intel.com>
To: qemu-devel@nongnu.org
Cc: satyeshwar.singh@intel.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH] virtio-gpu: Fix HW cursor visibility
Date: Fri, 23 Feb 2024 17:51:23 -0800
Message-Id: <20240224015123.1575580-1-satyeshwar.singh@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=satyeshwar.singh@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

When show-cursor is on, most of the time Windows VM draws the cursor by
itself and hands it over to Qemu as a separate resource. However,
sometimes, Windows OS gives control of the cursor to applications like
Notepad. In such cases a software cursor which is part of the overall
framebuffer is drawn by the application. Windows intimates the indirect
display driver (IDD) about this change through a flag and IDD is in turn
responsible for communicating with the hypervisor (Qemu) to hide the HW
cursor. This show/hide cursor can happen any time dynamically.

Unfortunately, it seems like Qemu doesn't expect this change to happen
dynamically. The code in virtio-gpu.c was written such that
update_cursor would first call dpy_cursor_define if the cursor shape has
changed and this is not a simple move operation (which indeed is the
case when moving to a SW cursor) and then call dpy_mouse_set.
dpy_cursor_define calls toolkits like GTK but in addition to creating
the cursor content, it also calls gdk_window_set_cursor thereby setting
the cursor. It is therefore, the right function to either show or hide
the cursor but there was no code present to hide the cursor. Changing
the cursor visibility in dpy_mouse_set has two issues. First,
dpy_cursor_define already decided to display the cursor so showing the
cursor in the previous call only to hide it in dpy_mouse_set doesn't
sound right. Second, dpy_mouse_set skips the rest of the code if we
are in absolute mode so adding this code there wouldn't work in that
mode.

Qemu makes the decision of whether to show or hide the cursor by
observing the cursor->resource_id flag in virtio-gpu.c as is evident
from the lines
	dpy_mouse_set(s->con, cursor->pos.x, cursor->pos.y,
                  cursor->resource_id ? 1 : 0);
The last parameter is considered the "visible" parameter in gdk code.
Therefore, in this patch we continue with the same model. Instead of
changing the function prototype and changing a dozen plus files, we are
adding the visible field in QEMUCursor data structure and passing
it from virtio-gpu to the GTK code where we check if the cursor is
visible or not. If not, we simply call gdk_window_set_cursor with NULL
parameter, thereby hiding the cursor. Once Windows VM switches back to
the HW cursor, then IDD would again provide a new resource_id to Qemu
and we can start displaying it once more.

Signed-off-by: Satyeshwar Singh <satyeshwar.singh@intel.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu.c | 1 +
 include/ui/console.h    | 1 +
 ui/gtk.c                | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1c1ee230b3..1ae9be605b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -98,6 +98,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_gpu_update_cursor *cursor)
 
         s->current_cursor->hot_x = cursor->hot_x;
         s->current_cursor->hot_y = cursor->hot_y;
+        s->current_cursor->visible = cursor->resource_id ? 1 : 0;
 
         if (cursor->resource_id > 0) {
             vgc->update_cursor_data(g, s, cursor->resource_id);
diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc64..47c39ed405 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -161,6 +161,7 @@ typedef struct QEMUCursor {
     uint16_t            width, height;
     int                 hot_x, hot_y;
     int                 refcount;
+    int                 visible;
     uint32_t            data[];
 } QEMUCursor;
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..12a76de570 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -478,6 +478,11 @@ static void gd_cursor_define(DisplayChangeListener *dcl,
         return;
     }
 
+    if(!c->visible) {
+        gdk_window_set_cursor(gtk_widget_get_window(vc->gfx.drawing_area), NULL);
+        return;
+    }
+
     pixbuf = gdk_pixbuf_new_from_data((guchar *)(c->data),
                                       GDK_COLORSPACE_RGB, true, 8,
                                       c->width, c->height, c->width * 4,
-- 
2.33.1


