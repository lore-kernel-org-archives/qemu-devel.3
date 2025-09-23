Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D756CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 15:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v14gG-0000IU-2f; Tue, 23 Sep 2025 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v14gD-0000HW-91
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:11:45 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v14gA-0000R5-No
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 11:11:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758640300; x=1758647500; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=rpuGODNpVNLsGNJORKOUv38W2o0k37vZymgKGsP72j4=;
 b=E9uGc72wiJ4pv5wKxB2YT87QvUxWh32Xh3hAfkI7irumBwbhQzIRSJaraK9lRy4/yUg5cbKv+PPZPXCtREkkvSJFaYxV/30x4cqMDh3emkg51EkeBCBSri4jgtDHQredAfcDbkF50SvylzJASeSPSDZzZSZjHc91EiFmNg83X95piVEzZkIv4jS3KzZxpjufnTpeszKMIZo94F2l3HaZnN3gmmN3GKLwt4nkI7plruZXPK7YR1pZJIiZEvcb0E0xjdWOaaORsXRIoF8h96Rvia0puC7VTmKr9qDWzLDIRjYiR6hkryvkgf7s+9xg+SXHnPH5o7lXqnKj99T5ogGUYA==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 3410bf604baf3b1186e1b7c3ddb9946731989e4e31ae93aebc8156634f8d87f1 with SMTP id
 68d2b8aaf13b9dd248e463f7; Tue, 23 Sep 2025 15:11:38 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alessandro.ratti@gmail.com, alex.bennee@linaro.org, armbru@redhat.com,
 berrange@redhat.com, mst@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v2] virtio: improve virtqueue mapping error messages
Date: Tue, 23 Sep 2025 17:09:25 +0200
Message-ID: <20250923151127.504186-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923151127.504186-1-alessandro@0x65c.net>
References: <20250923130034.486370-2-alessandro@0x65c.net>
 <20250923151127.504186-1-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m204-227.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Improve error reporting when virtqueue ring mapping fails by including a
device identifier in the error message.

Introduce a helper virtio_get_pretty_dev_name() that returns either:

 - the device ID, if explicitly provided (e.g. -device ...,id=foo)
 - the QOM path from qdev_get_dev_path(dev) otherwise
 - "<unknown device>" as a fallback when no identifier is present

This makes it easier to identify which device triggered the error in
multi-device setups or when debugging complex guest configurations.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
Buglink: https://bugs.launchpad.net/qemu/+bug/1919021

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/virtio/virtio.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..f5adc381a4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -235,6 +235,37 @@ static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
     }
 }
 
+static const char *virtio_get_pretty_dev_name(VirtIODevice *vdev)
+{
+    DeviceState *dev = DEVICE(vdev);
+
+    /*
+     * Return device ID if explicity set
+     * (e.g. -device virtio-blk-pci,id=foo)
+     * This allows users to correlate errors with their custom device
+     * names.
+     */
+    if (dev->id) {
+        return dev->id;
+    }
+    /*
+     * Fall back to the canonical QOM device path (eg. ID for PCI
+     * devices).
+     * This ensures the device is still uniquely and meaningfully
+     * identified.
+     */
+    const char *path = qdev_get_dev_path(dev);
+    if (path) {
+        return path;
+    }
+
+    /*
+     * Final fallback: if all else fails, return a placeholder string.
+     * This ensures the error message always contains a valid string.
+     */
+    return "<unknow device>";
+}
+
 void virtio_init_region_cache(VirtIODevice *vdev, int n)
 {
     VirtQueue *vq = &vdev->vq[n];
@@ -256,7 +287,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, packed);
     if (len < size) {
-        virtio_error(vdev, "Cannot map desc");
+        virtio_error(vdev,
+                "Failed to map descriptor ring for device %s: "
+                "invalid guest physical address or corrupted queue setup",
+                virtio_get_pretty_dev_name(vdev));
         goto err_desc;
     }
 
@@ -264,7 +298,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        virtio_error(vdev, "Cannot map used");
+        virtio_error(vdev,
+                "Failed to map used ring for device %s: "
+                "possible guest misconfiguration or insufficient memory",
+                virtio_get_pretty_dev_name(vdev));
         goto err_used;
     }
 
@@ -272,7 +309,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-        virtio_error(vdev, "Cannot map avail");
+        virtio_error(vdev,
+                "Failed to map avalaible ring for device %s: "
+                "possible queue misconfiguration or overlapping memory region",
+                virtio_get_pretty_dev_name(vdev));
         goto err_avail;
     }
 
-- 
2.39.5


