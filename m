Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5400CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNf-0007X8-Op; Thu, 16 Oct 2025 07:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMy-0007AR-65; Thu, 16 Oct 2025 07:42:08 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMl-0003WB-PO; Thu, 16 Oct 2025 07:42:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 82A66C01DD;
 Thu, 16 Oct 2025 14:41:36 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-dWOYgbb6; Thu, 16 Oct 2025 14:41:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614896;
 bh=X1G+ZxDLtXWMknznFE5+3sDhXLCW9VXnQrkCfUJ5yCQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=r3D+gfzLnMsePSUofIw/fKGqxRqPP61uV7NdkumYpP83jF6sHBmeuiJHF75yIRcI1
 WVIugTZqzTHXXnbyYGREcBJA3LPOfKEzUWcoGnr+iz73DpxgfiEmM7ptjyifogIRcE
 rWpu64D6hCjIeBeETu3baC4xKY8wkLBl6dDti3Qk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 17/25] vhost: add inflight region backend-transfer vmstate
Date: Thu, 16 Oct 2025 14:40:54 +0300
Message-ID: <20251016114104.1384675-18-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Prepare for future backend-transfer migration of vhost-user-blk.
Among other things we'll need to transfer the inflight region, let's
prepare for this.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c         | 26 ++++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 3e5192ec23..63036f8214 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1975,6 +1975,32 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
     }
 }
 
+static int vhost_inflight_backend_transfer_post_load(void *opaque,
+                                                     int version_id)
+{
+    struct vhost_inflight *inflight = opaque;
+
+    inflight->addr = mmap(0, inflight->size, PROT_READ | PROT_WRITE,
+                             MAP_SHARED, inflight->fd, inflight->offset);
+    if (inflight->addr == MAP_FAILED) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
+    .name = "vhost-inflight",
+    .post_load = vhost_inflight_backend_transfer_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FD(fd, struct vhost_inflight),
+        VMSTATE_UINT64(size, struct vhost_inflight),
+        VMSTATE_UINT64(offset, struct vhost_inflight),
+        VMSTATE_UINT16(queue_size, struct vhost_inflight),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
                            const uint64_t *features)
 {
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index af46d4b5f2..94a0c75fc8 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -587,4 +587,9 @@ static inline int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f,
 }
 #endif
 
+extern const VMStateDescription vmstate_backend_transfer_vhost_inflight;
+#define VMSTATE_BACKEND_TRANSFER_VHOST_INFLIGHT(_field, _state) \
+    VMSTATE_STRUCT_POINTER(_field, _state, vmstate_inflight, \
+                           struct vhost_inflight)
+
 #endif
-- 
2.48.1


