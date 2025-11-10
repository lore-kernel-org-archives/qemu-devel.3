Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38934CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPe7-0007kN-9T; Mon, 10 Nov 2025 06:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vIPJp-00082U-0t
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:40:17 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vIPJm-0002r8-Vk
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:40:16 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id F3942807B6;
 Mon, 10 Nov 2025 13:40:12 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8011:f00:439c:fb8b:9c87:386c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ndKaU81FteA0-1OW3t940; Mon, 10 Nov 2025 13:40:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762771212;
 bh=z8PGdUQGuutXpE5KQ/Zomo9S+sDSgjZY1LOIsQYZrpI=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=w2NGXcSVKRCxROZKqpIwNPDeva+omUqO6nNI2uQiR6AAYU/qxdDNNMGFwzzbZ8r8R
 IsM2imU3rDNemj5FviFSeWYnSmHea/5yY2IaqzN1mfMrMcYTl0TMwcEZNX/3tMia8z
 rKDZSv824BIBNgWI00kANVnc8Xj2S4dju7wkmxCk=
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
Subject: [PATCH v3 2/3] vhost: add vmstate for inflight region with inner
 buffer
Date: Mon, 10 Nov 2025 15:39:39 +0500
Message-Id: <20251110103937.1944486-3-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Prepare for future inflight region migration for vhost-user-blk.
We need to migrate size, queue_size, and inner buffer.

So firstly it migrate size and queue_size fields, then allocate memory for buffer with
migrated size, then migrate inner buffer itself.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c         | 42 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  6 ++++++
 2 files changed, 48 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c46203eb9c..9a746c9861 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2028,6 +2028,48 @@ const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
     }
 };
 
+static int vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
+{
+    info_report("vhost_inflight_region_buffer_pre_load");
+    struct vhost_inflight *inflight = opaque;
+
+    int fd = -1;
+    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
+                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                                  &fd, errp);
+    if (*errp) {
+        return -ENOMEM;
+    }
+
+    inflight->offset = 0;
+    inflight->addr = addr;
+    inflight->fd = fd;
+
+    return 0;
+}
+
+const VMStateDescription vmstate_vhost_inflight_region_buffer = {
+    .name = "vhost-inflight-region/buffer",
+    .pre_load_errp = vhost_inflight_buffer_pre_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_vhost_inflight_region = {
+    .name = "vhost-inflight-region",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(size, struct vhost_inflight),
+        VMSTATE_UINT16(queue_size, struct vhost_inflight),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_vhost_inflight_region_buffer,
+        NULL
+    }
+};
+
 const VMStateDescription vmstate_vhost_virtqueue = {
     .name = "vhost-virtqueue",
     .fields = (const VMStateField[]) {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 13ca2c319f..dd552de91f 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -596,6 +596,12 @@ extern const VMStateDescription vmstate_backend_transfer_vhost_inflight;
                            vmstate_backend_transfer_vhost_inflight, \
                            struct vhost_inflight)
 
+extern const VMStateDescription vmstate_vhost_inflight_region;
+#define VMSTATE_VHOST_INFLIGHT_REGION(_field, _state) \
+    VMSTATE_STRUCT_POINTER(_field, _state, \
+                           vmstate_vhost_inflight_region, \
+                           struct vhost_inflight)
+
 extern const VMStateDescription vmstate_vhost_dev;
 #define VMSTATE_BACKEND_TRANSFER_VHOST(_field, _state) \
     VMSTATE_STRUCT(_field, _state, 0, vmstate_vhost_dev, struct vhost_dev)
-- 
2.34.1


