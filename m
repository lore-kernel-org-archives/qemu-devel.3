Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2BBC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 18:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Pms-0005M5-KM; Tue, 07 May 2024 14:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4PmP-0005Hz-ID
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:43:12 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4PmN-0005LJ-Qw
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715107388; x=1746643388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RrsXBA3BArGZQhG128vhl9bHRq9JMxssTs3Xu4/f4EQ=;
 b=elFQo4iWGnM5cONobnGXEH1tq7GEbKLytv5BuKi3YYo1JQ79yC8txr9f
 75Vkw926vGN7ekRi3ltbq9r/M/UybhW6eoJEYkcK2z7yuMPveJeTUkcoq
 /CKhimA78f8ZEPQeZIIOxEfdpRIpbweuq0SMl7r8KCbxgCoFzHMiLGj+6
 AZYWEA4UVj17PnwDuACH06Z4l8oMYSrAfQV+UqaQ+TpaEbaODyjK18fzS
 bWDtK5fTgBdR3SThZPoFh+pVAkBI9hqClBBdL3DeV+5nNATIn4pATbaMY
 YYkPTUor3D2sTRfsj96ZsB9FS1Kn7AYxXtfPvaBU032jGVUUnT3GXM6Zy g==;
X-CSE-ConnectionGUID: 09hFhRwAStqDCEii4+6/3g==
X-CSE-MsgGUID: InyhNaEvQyuDlFwZwXg7wA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22321507"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="22321507"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 11:42:56 -0700
X-CSE-ConnectionGUID: BanM8RdeQWGE3WCE/9cUOw==
X-CSE-MsgGUID: Q5Zd4klBSo+xivRejpfpGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="29031364"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa006.jf.intel.com with ESMTP; 07 May 2024 11:42:56 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v13 6/6] ui/console: move QemuDmaBuf struct def to dmabuf.c
Date: Tue,  7 May 2024 11:37:57 -0700
Message-Id: <20240507183757.3383641-7-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507183757.3383641-1-dongwon.kim@intel.com>
References: <20240507183757.3383641-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

To complete privatizing process of QemuDmaBuf, QemuDmaBuf struct def
is moved to dmabuf.c

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/dmabuf.h | 19 +------------------
 ui/dmabuf.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index 4198cdf85a..dc74ba895a 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -10,24 +10,7 @@
 #ifndef DMABUF_H
 #define DMABUF_H
 
-typedef struct QemuDmaBuf {
-    int       fd;
-    uint32_t  width;
-    uint32_t  height;
-    uint32_t  stride;
-    uint32_t  fourcc;
-    uint64_t  modifier;
-    uint32_t  texture;
-    uint32_t  x;
-    uint32_t  y;
-    uint32_t  backing_width;
-    uint32_t  backing_height;
-    bool      y0_top;
-    void      *sync;
-    int       fence_fd;
-    bool      allow_fences;
-    bool      draw_submitted;
-} QemuDmaBuf;
+typedef struct QemuDmaBuf QemuDmaBuf;
 
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
                             uint32_t stride, uint32_t x,
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index e047d5ca26..df7a09703f 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -10,6 +10,25 @@
 #include "qemu/osdep.h"
 #include "ui/dmabuf.h"
 
+struct QemuDmaBuf {
+    int       fd;
+    uint32_t  width;
+    uint32_t  height;
+    uint32_t  stride;
+    uint32_t  fourcc;
+    uint64_t  modifier;
+    uint32_t  texture;
+    uint32_t  x;
+    uint32_t  y;
+    uint32_t  backing_width;
+    uint32_t  backing_height;
+    bool      y0_top;
+    void      *sync;
+    int       fence_fd;
+    bool      allow_fences;
+    bool      draw_submitted;
+};
+
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
                             uint32_t stride, uint32_t x,
                             uint32_t y, uint32_t backing_width,
-- 
2.34.1


