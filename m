Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71268D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 12:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSa4y-0007Bf-5q; Mon, 08 Dec 2025 07:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vSa4l-000720-3I
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:10:49 -0500
Received: from sg-1-101.ptr.blmpb.com ([118.26.132.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vSa4i-0003Ro-OG
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765195828; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=9fivGahwD7eJxbsYIpWsK5p26Hc0D9+NFC1zD62ElmQ=;
 b=CTregnjBbwjlmEvmTq4Ce10OHaHdkqN69DaHkoramvpKD1jicjkaqqDeMz20XxpVaP9s31
 iWxN1HmJg8xhuexP+5LxG9H3pNtJMsrge+ZxLBlzcLMeOp/ngIzGKXLFavlpNPqBxwu3Z5
 wMdnVKYPx4YckQKMcrkwWYrVu6qJ664eQ7T4hfUjpWOzZbuimotizW2ynDVn1G2VzvXwk5
 H8/D7JbP0lv7tmF/NFV9p1C2+v7Hw1KresIu/rFF3XvVrggJXLSPctMeEPiIb2/4VjPbgO
 v/tNLdh0OdBf9w5aWdTIHmLGtziVfALvZzU4zXUNcnNcrrIWY2GmIdWCWtoP4Q==
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Subject: [RFC v1 1/2] vhost: eliminate duplicate dirty_bitmap sync when log
 shared by multiple devices
Content-Transfer-Encoding: 7bit
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
X-Lms-Return-Path: <lba+26936c032+bdd0a6+nongnu.org+xuchuangxclwt@bytedance.com>
Cc: <mst@redhat.com>, <sgarzare@redhat.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@kernel.org>, 
 <philmd@linaro.org>, <farosas@suse.de>, 
 "xuchuangxclwt" <xuchuangxclwt@bytedance.com>
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
Date: Mon,  8 Dec 2025 20:09:51 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Message-Id: <20251208120952.37563-2-xuchuangxclwt@bytedance.com>
In-Reply-To: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=118.26.132.101;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-101.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: xuchuangxclwt <xuchuangxclwt@bytedance.com>

Although logs can now be shared among multiple vhost devices,
live migration still performs repeated vhost_log_sync for each
vhost device during bitmap_sync, which increases the time required
for bitmap_sync and makes it more difficult for dirty pages to converge.

Attempt to eliminate these duplicate sync.

Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 hw/virtio/vhost.c         | 30 ++++++++++++++++++++++--------
 include/hw/virtio/vhost.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a..d397ca327f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -268,14 +268,6 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     return 0;
 }
 
-static void vhost_log_sync(MemoryListener *listener,
-                          MemoryRegionSection *section)
-{
-    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
-                                         memory_listener);
-    vhost_sync_dirty_bitmap(dev, section, 0x0, ~0x0ULL);
-}
-
 static void vhost_log_sync_range(struct vhost_dev *dev,
                                  hwaddr first, hwaddr last)
 {
@@ -287,6 +279,27 @@ static void vhost_log_sync_range(struct vhost_dev *dev,
     }
 }
 
+static void vhost_log_sync(MemoryListener *listener,
+                          MemoryRegionSection *section)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    struct vhost_log *log = dev->log;
+
+    if (log && log->refcnt > 1) {
+        /*
+         * When multiple devices use same log, we implement the logic of
+         * vhost_log_sync just like what we do in vhost_log_put.
+         */
+        log->sync_cnt = (log->sync_cnt + 1) % log->refcnt;
+        if (!log->sync_cnt) {
+            vhost_log_sync_range(dev, 0, dev->log_size * VHOST_LOG_CHUNK - 1);
+        }
+    } else {
+        vhost_sync_dirty_bitmap(dev, section, 0x0, ~0x0ULL);
+    }
+}
+
 static uint64_t vhost_get_log_size(struct vhost_dev *dev)
 {
     uint64_t log_size = 0;
@@ -383,6 +396,7 @@ static struct vhost_log *vhost_log_get(VhostBackendType backend_type,
         ++log->refcnt;
     }
 
+    log->sync_cnt = 0;
     return log;
 }
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 08bbb4dfe9..43bf1c2150 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -50,6 +50,7 @@ typedef unsigned long vhost_log_chunk_t;
 struct vhost_log {
     unsigned long long size;
     int refcnt;
+    int sync_cnt;
     int fd;
     vhost_log_chunk_t *log;
 };
-- 
2.20.1

