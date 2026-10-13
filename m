Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD4DCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcUp-0002JF-Bn; Tue, 13 Oct 2026 09:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUQ-0001mc-3X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcUN-0004hm-TO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOaoETgITj5P9ExjzXWTy+J4LHPbfkHFKJV4ZTdKIt0=;
 b=alI569C3LWS88S5Qqy/L5YuRbhxg6ewmo1uo+pTEh+zT2AJ4wU9e9YyPp4AXdfgGa2ZBLb
 IDGFG8TNaFv+dfKSNTZd5KUSuHJqtSdk16cJmNchq0vDM08TB+ej/kAWmhcNI1Q/1hLClZ
 gU5IDp7bD29UjX5nSapbYw89QteXBUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-sXJShXIuNHeqgDT8ZmLP9Q-1; Tue,
 13 Oct 2026 13:24:15 +0000
X-MC-Unique: sXJShXIuNHeqgDT8ZmLP9Q-1
X-Mimecast-MFC-AGG-ID: sXJShXIuNHeqgDT8ZmLP9Q_1791897854
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 648F7197703F; Tue, 13 Oct 2026 13:24:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25C1F418; Tue, 13 Oct 2026 13:24:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:11 +0400
Subject: [GIT PULL 14/40] hw/display/virtio-gpu: Block migration with large
 blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-14-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vkngzrh/WsfNn0Aen4jueFSYuzv1H82lVuHXuGKTvtQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCNu9lU499f5AV1ISaTBdFsWmcBdYZt1SD4
 hrrfAHWxKKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5fY8EAC28qvYh7Fz0FxkXMy9n5ba7nXVE8Qmi56s8zZG3qIdpZwoR4q37MheiSWgNx007MVaA6v
 tU1HdJjADqBQHW9CBbr5MXNSjeTG1zjCmSFnJwtcLlNAnAGKdl6X5ADeCJXtuNY966jl96WHXAt
 yQgiNO4Z7ivtcxJvWS45vpp0qRxte7Pfv0/w9spU/EcQe2rGvxRYzvcJ2m4bXvLVrugBBtxy+6J
 7EBXd/keeAgH6m5QurrHtcTfUO0KOwrBxSyrfpBNgCIrgT7lTC1t5E/C+VFaTSgmmyEJ55DBGUY
 Vk9HrsBD1Gix+AHEmrDc6e5ywUMmRw17TPC9HoS757gnY67tBnt68+Uv742Ota22CxBH38ewylg
 d8dEJQJBvb5Bq2YkOKMHHTJoTsIIRVOJ18zrdClk2vlCMPRrZlaNhvqfFfg+mLRPuYSRRhI2Rty
 Hp6Yc/tjoi73/XoiFYVR/4mlAK0ElEr4C/PROmdZnk9VKJ7OUJ3c11dC4JjmAJV6QSdBAZy79b8
 FEGCCucE6HHnT5N6HFDooczQSputcWDKRjiFJlwsSljVrnt/M8BCp2UEBixcKAyDvBYQDSkzVF0
 7KNsf5Kp8L6AkKGOSglYWw8zOjca2hyLWr8Nppm53lMgfXqpeEpOPcilCTSraqwWPZFD0ECS8Bd
 Ph3RKfHrSR7ISBQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The blob size is encoded as a 64-bit integer in the virtio protocol, but
it is encoded as a 32-bit integer in the migration stream, and
a large blob whose size cannot be expressed in a 32-bit integer will
be corrupted after migration.

Block migration with such large blobs, and, if it is not possible, deny
creating a large blob.

Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blob=true"")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260914-block-v1-1-4df9617573ca@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index bb0f41bb1e05..5d43ffb99184 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/core/qdev-properties.h"
+#include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qemu/memfd.h"
 #include "qemu/module.h"
@@ -35,6 +36,9 @@
 
 #define VIRTIO_GPU_VM_VERSION 1
 
+static size_t num_large_blobs;
+static Error *large_blob_blocker;
+
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
                                const char *caller, uint32_t *error);
@@ -355,6 +359,7 @@ end:
 static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
                                             struct virtio_gpu_ctrl_command *cmd)
 {
+    Error *local_err = NULL;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_create_blob cblob;
     int ret;
@@ -415,6 +420,26 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         }
     }
 
+    if (cblob.size > UINT32_MAX) {
+        if (!num_large_blobs) {
+            error_setg(&large_blob_blocker,
+                       "a large virtio-gpu blob is present");
+            if (migrate_add_blocker(&large_blob_blocker, &local_err)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: blocking migration for a large blob failed: %s\n",
+                              __func__, error_get_pretty(local_err));
+                error_free(local_err);
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+                virtio_gpu_fini_udmabuf(res);
+                virtio_gpu_cleanup_mapping(g, res);
+                g_free(res);
+                return;
+            }
+        }
+
+        num_large_blobs++;
+    }
+
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
@@ -460,6 +485,13 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
 {
     virtio_gpu_disable_scanout_for_resource(g, res->resource_id);
 
+    if (res->blob_size > UINT32_MAX) {
+        num_large_blobs--;
+        if (!num_large_blobs) {
+            migrate_del_blocker(&large_blob_blocker);
+        }
+    }
+
     qemu_pixman_image_unref(res->image);
     virtio_gpu_cleanup_mapping(g, res);
     QTAILQ_REMOVE(&g->reslist, res, next);

-- 
2.56.0.116.g6de20f6092dc


