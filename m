Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD16C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCY4-0007YU-7y; Fri, 24 Jul 2026 05:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCMK-0008IB-CN
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:38:24 -0400
Received: from m16.mail.163.com ([117.135.210.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCMF-00047A-7v
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gM
 /0gRgf8lzBqBS0ikqquzKTo/lOuE3qwinTchpVrn4=; b=UGSsvEZKGevCHBscJu
 GivQyU+q+hDIlQlTd7vT1zCn7FZvdJfkpPTjKoYe4LQSCLae3x8Ri87ewQ1cT/9V
 rnw0ZmN9130jM6m8uP8bsDiLFEFg/eWpTWIIHmepl/vF1kgDCNlyI1O45xKdPcsy
 X6I4XmFrioxl/2g+iM2q4YFvQ=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHYwJuMmNq8T8cKA--.247S2;
 Fri, 24 Jul 2026 17:37:53 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 1/3] hw/virtio: Optimize vhost_log_sync_range to avoid N^2
 complexity
Date: Fri, 24 Jul 2026 17:37:50 +0800
Message-ID: <20260724093750.810018-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHYwJuMmNq8T8cKA--.247S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw17uFW7uF15GFy3CrWrGrg_yoW8WFWrpr
 4qkF9xKr45J347Jw4fJ3yUuryFkws7Xws8JrZ7X3WDGw17Xr1ktan5K3WUt347CFyxZF1Y
 vFyqvF45uryruw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jggAwUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzREcq2pjMnH8ngAA3D
Received-SPF: pass client-ip=117.135.210.3; envelope-from=xiongwm2026@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 05:50:26 -0400
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

The vhost_log_sync_range() function iterates through all memory sections
for each call, resulting in O(N^2) complexity when syncing dirty
bitmaps. This is inefficient for guests with many memory sections.

Optimize this by:
1. Checking if a section overlaps with [first, last] range before
   calling vhost_sync_dirty_bitmap()
2. Early exit when section starts beyond the requested range

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/virtio/vhost.c | 18 +++++++++++++++--
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -280,11 +280,21 @@ static void vhost_log_sync(MemoryListener *listener,
 static void vhost_log_sync_range(struct vhost_dev *dev,
                                  hwaddr first, hwaddr last)
 {
-    int i;
-    /* FIXME: this is N^2 in number of sections */
-    for (i = 0; i < dev->n_mem_sections; ++i) {
-        MemoryRegionSection *section = &dev->mem_sections[i];
-        vhost_sync_dirty_bitmap(dev, section, first, last);
+    int i, j;
+    bool section_dirty = false;
+
+    for (i = 0; i < dev->n_mem_sections; ++i) {
+        MemoryRegionSection *section = &dev->mem_sections[i];
+        hwaddr section_start, section_end;
+
+        /* Skip sections that don't overlap with [first, last] */
+        section_start = section->offset_within_address_space;
+        section_end = section_start + int128_get64(section->size) - 1;
+
+        if (section_end < first || section_start > last) {
+            continue;
+        }
+
+        vhost_sync_dirty_bitmap(dev, section, first, last);
     }
 }
 


