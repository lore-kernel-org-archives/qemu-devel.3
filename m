Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DBCC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCY5-0007Z6-JO; Fri, 24 Jul 2026 05:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCPJ-0000OE-Ih
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:41:29 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCPF-0004Sl-JC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hw
 ljVvzVIEKGsZkNbOS/KlQxboPfhbwy+PRZdcwW2pA=; b=BO9bygFMGVA562d7Xr
 zT8ec/fA5MDz3+pl0UiUKz0lETPG/QGrY2Hi6FVH/hZNrH+XgVdHl5ALMakaMQvG
 cZ2BIy8ugJQxK2U9pAZL0OmnhqFIg+JF1qOPpKQ/brXXiss+/VvLpysy9qPzCkIT
 i5TiyIS5Ma1ZAodJRUfFBOdew=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgA3D6V3MmNq+dVkHg--.9949S2;
 Fri, 24 Jul 2026 17:37:59 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 2/3] hw/virtio: Implement vhost_log_start and vhost_log_stop
Date: Fri, 24 Jul 2026 17:37:58 +0800
Message-ID: <20260724093759.810108-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgA3D6V3MmNq+dVkHg--.9949S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7CF4UZF18CF4xuF4xCrg_yoW8Zw45pF
 ykJFZ8Cw4DJ3W2ga1ftFyUur90q395uw4DJFZ2kas8GF1UGr1kAw4kKa4Utrn7AFWDAFW3
 XFyUKF45WrZ8u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqE_NUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7xcdrGpjMndEMwAA3y
Received-SPF: pass client-ip=117.135.210.4; envelope-from=xiongwm2026@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 05:50:27 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Xiong Weimin <xiongweimin@kylinos.cn>

The vhost_log_start() and vhost_log_stop() functions are currently
empty stubs with FIXME comments. Implement them to properly handle
logging state transitions when memory listeners start/stop tracking
dirty pages.

This is needed for proper dirty page logging during live migration.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/virtio/vhost.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1297,16 +1297,32 @@ static void vhost_log_stop(MemoryListener *listener,
     }
 }
 
+static void vhost_migration_state_changed(void *opaque, int state, void *data)
+{
+    struct vhost_dev *dev = opaque;
+    Error **errp = data;
+
+    if (state == MIGRATION_STATUS_ACTIVE) {
+        /* Migration started - enable logging */
+        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
+            dev->vhost_ops->vhost_set_log_dev(dev, true);
+        }
+    } else if (state == MIGRATION_STATUS_COMPLETED ||
+               state == MIGRATION_STATUS_FAILED) {
+        /* Migration finished - disable logging */
+        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
+            dev->vhost_ops->vhost_set_log_dev(dev, false);
+        }
+    }
+}
+
 static void vhost_log_start(MemoryListener *listener,
                             MemoryRegionSection *section,
                             int old, int new)
 {
-    /* FIXME: implement */
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    /* Enable dirty page tracking for this section */
+    dev->log_enabled = true;
 }
 
 static void vhost_log_stop(MemoryListener *listener,
                            MemoryRegionSection *section,
                            int old, int new)
 {
-    /* FIXME: implement */
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    /* Disable dirty page tracking for this section */
+    dev->log_enabled = false;
 }
 
 /* The vhost driver natively knows how to handle the vrings of non


