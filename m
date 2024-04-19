Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E98FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 19:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxtXA-0005vv-Dq; Fri, 19 Apr 2024 15:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxtX4-0005tP-An
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:04:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxtX2-0004ET-7O
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713553460; x=1745089460;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sO7a70G4LBuEj95EnA0tucUSAOBNfhfKnI1rEBBPdbc=;
 b=k+d8UWJwHJyj6W2qu/G3H9e7rZXQI5ZtRrL16nyG1sn+rLtGhy+Eu7E5
 Phrnyky3bD9ySzGL5HtWg+GLzRw5PUSB8Mb7x5PjNXU6H/so9rZpXFwZT
 bYjb7zmBsVr5tnQ9B8LawGB1QkxQcwGjUmmRnPXb5WKcT8WCIxYWnL1f6
 4WYoUhlSSLEhNbLyuQl74mTvh8Lztv+6vw8wDGMHk9pXh9kbaoSVhY8HG
 uRGc6QebeHUVixmaNzUusrZ8MR3XP0cSfNtZQhm2xWFvayJty2X/Zm8+p
 GQfvn2hgToiBg1jYjbnRBE2vV0tTeZP0/fDiLy7AnCQ/eizQPCdauWdFE Q==;
X-CSE-ConnectionGUID: /rijgTEhSZavws7aZLXXSw==
X-CSE-MsgGUID: dc3AMfoTQ8eya+3vFxl+EQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20565003"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; d="scan'208";a="20565003"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 12:04:08 -0700
X-CSE-ConnectionGUID: 6BGczYvMQZOk0Bl2ZygGag==
X-CSE-MsgGUID: i9K444ZKRr2deviIKWhP9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; d="scan'208";a="54346791"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa002.jf.intel.com with ESMTP; 19 Apr 2024 12:04:09 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v8 6/6] ui/console: move QemuDmaBuf struct def to dmabuf.c
Date: Fri, 19 Apr 2024 11:59:52 -0700
Message-Id: <20240419185952.991930-7-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419185952.991930-1-dongwon.kim@intel.com>
References: <20240419185952.991930-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
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
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/dmabuf.h | 19 +------------------
 ui/dmabuf.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index e332958c39..0723846a3a 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -27,24 +27,7 @@
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
index ef3b07956e..7a919160dc 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -27,6 +27,25 @@
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


