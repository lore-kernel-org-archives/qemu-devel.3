Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E61C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 23:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnS5B-0007OI-G3; Thu, 21 Mar 2024 19:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS59-0007Nh-F9
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:23 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS57-0007kU-UO
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711064663; x=1742600663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sI7svSTFRCL8NwyeTl20Ot0CS4c3XsqEdwHOLT2cXZo=;
 b=ggkzUKDv5ASRGCeR02zXh2BtVpH13rt8FoXCIQ5FP8DafUZcJeIlJApc
 8fTDnFafqCwZY5zOu+l8IKo5stSnjYLUxNW45Qx5DupPdBpYy7Gpf3F3/
 /9Jq3eDDOWhCIS4hoQpsywFFF9aTXDuDUWDaMr1F0K/oqvkdkTWIMvrto
 ah+I7TJ43Q7JZ6PkuIM7T6724H3Bw7sQHlLSxvnbVrHgqbg5S1x7gtywJ
 0ocHUWBs/DabvezcFbL44kQgI6dVkBs/S+uh77qimy65u3UpksA93ouhn
 LLYfnFGU09rKgab1rIV8qzYUYCs3Hg7fDyJibvVzP0jO+iHnjyYUTr9eR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6217228"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="6217228"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2024 16:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; d="scan'208";a="14743275"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa006.fm.intel.com with ESMTP; 21 Mar 2024 16:44:13 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH v4 2/3] ui/console: Introduce dpy_gl_dmabuf_get_fd() helper
Date: Thu, 21 Mar 2024 16:42:35 -0700
Message-Id: <20240321234236.3476163-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321234236.3476163-1-dongwon.kim@intel.com>
References: <20240321234236.3476163-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

dpy_gl_dmabuf_get_fd() is a helper for retrieving FD of the dmabuf
from QemuDmaBuf struct.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/console.h | 1 +
 hw/vfio/display.c    | 8 +++++++-
 ui/console.c         | 9 +++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 6064487fc4..d5334a806c 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -360,6 +360,7 @@ void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
 uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
 uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index c962e5f88f..676b2fc5f3 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -259,9 +259,15 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
 static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 {
+    int fd;
+
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
+    fd = dpy_gl_dmabuf_get_fd(&dmabuf->buf);
+    if (fd > -1) {
+        close(fd);
+    }
+
     dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
-    close(dmabuf->buf.fd);
     g_free(dmabuf);
 }
 
diff --git a/ui/console.c b/ui/console.c
index 1d0513a733..69560aac7e 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1504,6 +1504,15 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     }
 }
 
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->fd;
+    }
+
+    return -1;
+}
+
 int qemu_invalidate_text_consoles(void)
 {
     QemuConsole *s;
-- 
2.34.1


