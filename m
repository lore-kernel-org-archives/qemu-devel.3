Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3DED3CC9F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 08:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIT1-00030o-Ea; Thu, 15 Jan 2026 03:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vgIT0-0002xr-1d; Thu, 15 Jan 2026 03:12:30 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vgISy-0006B5-HE; Thu, 15 Jan 2026 03:12:29 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D464C80860;
 Thu, 15 Jan 2026 11:12:26 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:973::1:c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PBQgfR0Ar8c0-cwpZoIb6; Thu, 15 Jan 2026 11:12:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768464746;
 bh=yWibqi19WvTNo5ModM1nu+rTjbF5ptLfVCEPC+ZLWJY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BrwDHAtbF7P6eQSj50sMp+ZcbTdmDyEL87+1vKdQfXEFooucrSJ9gfdRsFjhTssH3
 2fS8lvAKG4j3qGcbAMF4dX5J9b8f+JrtyhGm5NnIZE96L6jzClvARGKPOVwnLxBf2e
 XhEBtPiw9rAEjz6rt92gb4lcG0Q3LDGiaXUOb1DQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mzamazal@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v7 4/5] vhost: add vmstate for inflight region with inner
 buffer
Date: Thu, 15 Jan 2026 13:11:07 +0500
Message-Id: <20260115081103.655749-5-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115081103.655749-1-dtalexundeer@yandex-team.ru>
References: <20260115081103.655749-1-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Prepare for future inflight region migration for vhost-user-blk.
We need to migrate size, queue_size, and inner buffer.

So firstly it migrate size and queue_size fields, then allocate memory
for buffer with
migrated size, then migrate inner buffer itself.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/vhost.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 31e9704cdc..7ec2f6fc23 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1916,6 +1916,63 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
     }
 }
 
+static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
+{
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
+    return true;
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
+static bool vhost_inflight_region_post_load(void *opaque,
+                                           int version_id,
+                                           Error **errp)
+{
+    struct vhost_inflight *inflight = opaque;
+
+    if (inflight->addr == NULL) {
+        error_setg(errp, "inflight buffer subsection has not been loaded");
+        return false;
+    }
+
+    return true;
+}
+
+const VMStateDescription vmstate_vhost_inflight_region = {
+    .name = "vhost-inflight-region",
+    .post_load_errp = vhost_inflight_region_post_load,
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
 void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
                            const uint64_t *features)
 {
-- 
2.34.1


