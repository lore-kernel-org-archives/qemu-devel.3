Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350FDCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAihV-0003IZ-T2; Mon, 20 Oct 2025 01:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAihQ-0003Fv-UK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:44:54 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vAihO-0007tx-Oi
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:44:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7B26C807BA;
 Mon, 20 Oct 2025 08:44:46 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:803e:400:cd4:cafc:37a3:de4])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TiN4Nb4FbmI0-MuEted86; Mon, 20 Oct 2025 08:44:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760939086;
 bh=V9FOOjB10GBn5fAP7xjOXkkA89Pz+nn+KfvWW3CovlI=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ls5Y1S3g9918k5ZBeVa+gHeRQhN/NSUvu/IcZJL4abR0o3Hno/9XrOE/Wn2ILwTpc
 5ayKgaIv1oE2MqhkI22FZVuiA511xzfKSSw203MbJmq4Jw6y7VaO6Bj/CwtLSnoq+Z
 sruK2CJ0tOMzYczHEydP+ljE2h0TieFVjBkKi5lw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH 1/2] vhost: support inflight save/load
Date: Mon, 20 Oct 2025 10:44:14 +0500
Message-Id: <20251020054413.2614932-2-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

vhost_dev_load_inflight and vhost_dev_save_inflight have been deleted
by:

abe9ff2 ("vhost: Remove unused vhost_dev_{load|save}_inflight")

So, now they are needed for future commit.
Return them, and their helper vhost_dev_resize_inflight.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c         | 56 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a..16ce9a6037 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2013,6 +2013,62 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
     return 0;
 }
 
+static int vhost_dev_resize_inflight(struct vhost_inflight *inflight,
+                                     uint64_t new_size)
+{
+    Error *err = NULL;
+    int fd = -1;
+    void *addr = qemu_memfd_alloc("vhost-inflight", new_size,
+                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                  &fd, &err);
+    if (err) {
+        error_report_err(err);
+        return -ENOMEM;
+    }
+
+    vhost_dev_free_inflight(inflight);
+    inflight->offset = 0;
+    inflight->addr = addr;
+    inflight->fd = fd;
+    inflight->size = new_size;
+
+    return 0;
+}
+
+void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f)
+{
+    if (inflight->addr) {
+        qemu_put_be64(f, inflight->size);
+        qemu_put_be16(f, inflight->queue_size);
+        qemu_put_buffer(f, inflight->addr, inflight->size);
+    } else {
+        qemu_put_be64(f, 0);
+    }
+}
+
+int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
+{
+    uint64_t size;
+
+    size = qemu_get_be64(f);
+    if (!size) {
+        return 0;
+    }
+
+    if (inflight->size != size) {
+        int ret = vhost_dev_resize_inflight(inflight, size);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    inflight->queue_size = qemu_get_be16(f);
+
+    qemu_get_buffer(f, inflight->addr, size);
+
+    return 0;
+}
+
 static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 08bbb4dfe9..da1f0c2361 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -402,6 +402,8 @@ int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
 
 void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
 void vhost_dev_free_inflight(struct vhost_inflight *inflight);
+void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
+int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
 int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev);
 int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
-- 
2.34.1


