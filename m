Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B854C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 18:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lZY-0005tr-Mi; Wed, 08 May 2024 13:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4lZV-0005s9-OP
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:59:17 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4lZU-0002tb-2n
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715191157; x=1746727157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RrsXBA3BArGZQhG128vhl9bHRq9JMxssTs3Xu4/f4EQ=;
 b=lF/iMhRx2TT58iPTHfA5zzWio3FhPI2R4f2r0VzPkeYRh+Awmzefnh7t
 vKNVN4WeEEgfv4Iz8vpEv5gnHtG0DtqTmIXkJo6uZU+TVTjxafSYx4PZV
 /WgvfWAwPMdDo+vEnXP+XOVF7sY4BUO7jYqy4sZA454Y1fYV2vHhECmEq
 iuXkZKzMfiZipnr2d6cGZ9RRxgn55yMIG/46pQT7kiNp+dSAAUnuJRyW0
 vW8OYn7Cyjv7NBkTlrzN5dRZfRW42cv7yGZafTdyl9QFjdQyRVUfnYGEF
 WmqSpZgqBmg9lcwMBkGTDJ8CZExZnD5Ers6AEHtpLFcFeHP8bS3rEJEXM w==;
X-CSE-ConnectionGUID: 9WatMf4gT5CUnES7tDaCrQ==
X-CSE-MsgGUID: TExWEjs/TWK1inD68d6qhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14887692"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="14887692"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 10:59:03 -0700
X-CSE-ConnectionGUID: EOSCg8vhR9GE/GWYD5EmxA==
X-CSE-MsgGUID: Qj7fvrZIS/uy+EBvef3jTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="29541316"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa008.jf.intel.com with ESMTP; 08 May 2024 10:59:02 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v14 6/6] ui/console: move QemuDmaBuf struct def to dmabuf.c
Date: Wed,  8 May 2024 10:54:03 -0700
Message-Id: <20240508175403.3399895-7-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508175403.3399895-1-dongwon.kim@intel.com>
References: <20240508175403.3399895-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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


