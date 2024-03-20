Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0030DCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2ur-0006qJ-K6; Wed, 20 Mar 2024 16:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2up-0006pc-R7
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:52:03 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2uo-0004VV-1J
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710967922; x=1742503922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L3vTPYUk5DmYw8gzl3iAc70BwhOAQ4bK8DaLyOprJrQ=;
 b=nH4MRn6x+X3ERTnC5SEd3fXQoTXpeCPEgpog74ifBG5mI9j0W7xMMey3
 I3XL74SZOabtIANTm1bWCuwXQIPqqtIzv0aRRp4UHJ9AjWmEyGb7Bs7Si
 4nuBjU9KXIEoHYJ0UdXdrXKPurpDrPSNi2JbX9Tn3ch2dWA2SGJGdaRH1
 LXa1v3OP00Tvqmkk7lS5usmpLI+quJnQ+aqyz2Qh4J1iXziUd23+T+Vm5
 v/Wqxq+CF5u22vqSsdwWOuuUmSPy5kLURNZ6k8tRSU5iuKb7xxRolaRtX
 z0I5uGDKhOFqPyI0MWkZ3dHvvxHsMkm+RF1aXJjJRP1ShnA85WXQIbSyw A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16463570"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="16463570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 13:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="14679718"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2024 13:51:55 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 3/3] ui/console: add methods for allocating,
 intializing and accessing QemuDmaBuf
Date: Wed, 20 Mar 2024 13:50:18 -0700
Message-Id: <20240320205018.3351984-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320205018.3351984-1-dongwon.kim@intel.com>
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This commit introduces new methods within ui/console to handle the allocation,
initialization, and field retrieval of QemuDmaBuf. By isolating these
operations within ui/console, it enhances safety and encapsulation of
the struct.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/console.h | 10 ++++++++
 ui/console.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 0bc7a00ac0..70903f1b0d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -279,6 +279,7 @@ typedef struct DisplayChangeListenerOps {
     /* optional */
     void (*dpy_gl_cursor_position)(DisplayChangeListener *dcl,
                                    uint32_t pos_x, uint32_t pos_y);
+
     /* optional */
     void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
                                   QemuDmaBuf *dmabuf);
@@ -358,6 +359,15 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
                           bool have_hot, uint32_t hot_x, uint32_t hot_y);
 void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint32_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences);
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/ui/console.c b/ui/console.c
index 43226c5c14..bac24756f0 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1132,6 +1132,60 @@ void dpy_gl_cursor_position(QemuConsole *con,
     }
 }
 
+QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
+                                 uint32_t stride, uint32_t x,
+                                 uint32_t y, uint32_t backing_width,
+                                 uint32_t backing_height, uint32_t fourcc,
+                                 uint32_t modifier, uint32_t dmabuf_fd,
+                                 bool allow_fences)
+{
+    QemuDmaBuf *dmabuf;
+
+    dmabuf = g_new0(QemuDmaBuf, 1);
+
+    dmabuf->width = width;
+    dmabuf->height = height;
+    dmabuf->stride = stride;
+    dmabuf->x = x;
+    dmabuf->y = y;
+    dmabuf->backing_width = backing_width;
+    dmabuf->backing_height = backing_height;
+    dmabuf->fourcc = fourcc;
+    dmabuf->modifier = modifier;
+    dmabuf->fd = dmabuf_fd;
+    dmabuf->allow_fences = allow_fences;
+    dmabuf->fence_fd = -1;
+
+    return dmabuf;
+}
+
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->width;
+    }
+
+    return 0;
+}
+
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->height;
+    }
+
+    return 0;
+}
+
+int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->fd;
+    }
+
+    return -1;
+}
+
 void dpy_gl_release_dmabuf(QemuConsole *con,
                           QemuDmaBuf *dmabuf)
 {
@@ -1145,6 +1199,7 @@ void dpy_gl_release_dmabuf(QemuConsole *con,
         if (dcl->ops->dpy_gl_release_dmabuf) {
             dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
         }
+        g_free(dmabuf);
     }
 }
 
-- 
2.34.1


