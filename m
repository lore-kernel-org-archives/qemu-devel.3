Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526C6C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHZ5-0007pb-Ca; Mon, 27 Jul 2026 05:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woHYx-0007ow-KJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:23:56 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woHYv-0001gt-2c
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:23:55 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66R9NPiV087705
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jul 2026 18:23:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=MBT75aVp88xpVWTDqvkufgi643mzSeszVzLsGEi2twY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1785144219; v=1;
 b=BT/VHibgYEJqb2YiQhrz9dIU241Y2h4f2FW6YPhWKpqTwhWpKWMIXkysr1XKKDkx
 NyIiGQ6COxrUMrtXbs4Nc65ZbHNP50amEOi/p/BoOcGJInk/M/h1yuxATp/oJa/U
 dhohIfwM3t4jMhS/7954InijjVGFc1gSNp0dfye4aNMwL5N79TbOtS8YY7XWlcKj
 Ytk1wNwPxdOZro9JMEpYttf0cX6BWpsLtS4gdWREmnN+YuwWJbf7hkfDKncpufbl
 Y+Jj/M57pMEUczL5CfmDt6+iM8/CLoE9lB+LIPkFqj6KtevNy9LggzRaGOrdbMIY
 kVba4+/CVvAEwRz6+VfjWQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 18:23:25 +0900
Subject: [PATCH v2] hw/display/virtio-gpu: Reject non-migratable large
 blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-blob-v2-1-d0b9af38a975@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ6DIBQFr2L+uhDAirar3qNxAYj6bSMG1NQY7
 16wuy4nmTdvh2A92gD3bAdvVwzoxgjikoHp1dhZgk1kEExIVoqC6LfTpFJScVUVknEFUZ28bfF
 zZp71j8OiB2vmtE1Gj2F2fjt/Vp68v+TKCSetvOatbkqZ36qHDx01SJEuZHavzVFl6DBBfRzHF
 6me4N63AAAA
X-Change-ID: 20260725-blob-8a6a1a85601a
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=nmKZXOqfiSM/kWDWP3DAqOQdGaIABzlQIr5cdGI2cHc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1a68qw/k91sFvZPLJ8w4cy+m+dPmPdPybxmI/kyzN1vY
 3yrwJ7ajlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgImErWJk+H3Mev2/1xP2yiwM
 0K6P3melsvjqjfUHrj9Q/SLPJvdJo5WR4TR7/BSjQ5FuKoHLk67OO+9468eFhiW+iydHn4m+bK0
 tywcA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The blob size is encoded as a 64-bit integer in the virtio protocol, but
it is encoded as a 32-bit integer in the migration stream, and
a large blob whose size cannot be expressed in a 32-bit integer will
be corrupted after migration. Deny creating such large blobs.

Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blob=true"")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Add the Fixes: tag for f66767f75c9c.
- Add a TODO to encode blob_size as 64 bits in virtio-gpu/blob
  VMState version 2.
- Link to v1: https://lore.kernel.org/qemu-devel/20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp
---
 hw/display/virtio-gpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 718ba3039290..987b1b3ea860 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -352,6 +352,14 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
+    if (cblob.size > UINT32_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: blob too large (%" PRIu64 "> %" PRIu32 ")\n",
+                      __func__, cblob.size, UINT32_MAX);
+        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
+
     if (virtio_gpu_find_resource(g, cblob.resource_id)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
                       __func__, cblob.resource_id);
@@ -1435,7 +1443,14 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
         }
         assert(!res->image);
         qemu_put_be32(f, res->resource_id);
+
+        /*
+         * The migration stream encodes blob_size as a 32-bit integer for
+         * compatibility though virtio encodes it as a 64-bit integer. A newer
+         * version of the migration stream should encode it as a 64-bit integer.
+         */
         qemu_put_be32(f, res->blob_size);
+
         qemu_put_be32(f, res->iov_cnt);
         for (i = 0; i < res->iov_cnt; i++) {
             qemu_put_be64(f, res->addrs[i]);

---
base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
change-id: 20260725-blob-8a6a1a85601a

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


