Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF1A1094463
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 10:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3tBy-0003hJ-Aa; Sat, 21 Mar 2026 06:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w3tBx-0003ga-2s
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 06:04:25 -0400
Received: from v5227.v57ae4e16.euw1.send.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w3tBt-0002wd-Rh
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 06:04:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1774087460; x=1774094660; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=P0eCPQz7NQO89Ee/DoQZcNv7gZm4ir9SUdszgWqF3LQ=;
 b=DP/ntKIj/SWAeaAfh2+/gKsT7Sv5jIOk6Qwu3q2xh0g4qVjS8b4FHiENNiFoRefAB7dUcebGtrauvUqPs3Wq214o+yu891ucjbzBw4KlfReLPnKdygA1ZwKq1OfLU1uVT9U1XG4GEglVi6/Tba+FT9qt0OiJ7DG4PSyyUYhKc4F/Oc1/s/UyhhMhEKEIEMJKDccjME5Bq+GAzyblgdA5UsGLEFAQ3gnGdtZO3tTAafZM6D8jwZnN791o3j19fODe41WmxSheZa04RGzQqMW9427LfEiGEcNOmnR/IfS70YIZa4xQrvrjbaSMatbMc8wRFoUJstn7bQ4hAWtIAZFgcQ==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 712eb054bc9015b0ebda65af28a98072b50f328f288845fcd2556865c8031c9b
 with SMTP id 69be6d244146bb649678c26c; Sat, 21 Mar 2026 10:04:20 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, pbonzini@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v3 3/3] hw/qdev: Consolidate qdev_get_printable_name() into
 qdev_get_human_name()
Date: Sat, 21 Mar 2026 11:04:05 +0100
Message-ID: <20260321100405.1525059-4-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321100405.1525059-1-alessandro@0x65c.net>
References: <20260321100405.1525059-1-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v5227.v57ae4e16.euw1.send.eu.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rename qdev_get_printable_name() to qdev_get_human_name(), remove
the old qdev_get_human_name() implementation, and switch the three
qdev_get_printable_name() callers in hw/virtio/virtio.c.

qdev_get_printable_name() subsumes qdev_get_human_name(): both
return the device ID when set and fall back to the canonical QOM
path, but qdev_get_printable_name() also tries the bus-specific
path first, providing more informative output.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/core/qdev.c         | 10 +---------
 hw/virtio/virtio.c     |  6 +++---
 include/hw/core/qdev.h | 26 +++++---------------------
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 904e710f8e..93347f67bb 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -411,7 +411,7 @@ char *qdev_get_dev_path(DeviceState *dev)
     return NULL;
 }
 
-const char *qdev_get_printable_name(DeviceState *dev)
+char *qdev_get_human_name(DeviceState *dev)
 {
     if (dev->id) {
         return g_strdup(dev->id);
@@ -857,14 +857,6 @@ Object *machine_get_container(const char *name)
     return container;
 }
 
-char *qdev_get_human_name(DeviceState *dev)
-{
-    g_assert(dev != NULL);
-
-    return dev->id ?
-           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
-}
-
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8fcf6cfd0b..63e2faee99 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -281,7 +281,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, packed);
     if (len < size) {
-        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+        g_autofree char *devname = qdev_get_human_name(DEVICE(vdev));
 
         virtio_error(vdev,
                 "Failed to map descriptor ring for device %s: "
@@ -294,7 +294,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+        g_autofree char *devname = qdev_get_human_name(DEVICE(vdev));
 
         virtio_error(vdev,
                 "Failed to map used ring for device %s: "
@@ -307,7 +307,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+        g_autofree char *devname = qdev_get_human_name(DEVICE(vdev));
 
         virtio_error(vdev,
                 "Failed to map avalaible ring for device %s: "
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index b87497906a..43d8e58432 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1049,13 +1049,12 @@ Object *machine_get_container(const char *name);
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
  *
- * .. note::
- *    This function is intended for user friendly error messages.
- *
- * Returns: A newly allocated string containing the device id if not null,
- * else the object canonical path.
+ * Returns: A newly allocated string suitable for user-facing error
+ * messages.
  *
- * Use g_free() to free it.
+ * Return the device's ID if it has one.  Else, return the path of a
+ * device on its bus if it has one.  Else return its canonical QOM
+ * path.
  */
 char *qdev_get_human_name(DeviceState *dev);
 
@@ -1085,21 +1084,6 @@ extern bool qdev_hot_removed;
  */
 char *qdev_get_dev_path(DeviceState *dev);
 
-/**
- * qdev_get_printable_name: Return human readable name for device
- * @dev: Device to get name of
- *
- * Returns: A newly allocated string containing some human
- * readable name for the device, suitable for printing in
- * user-facing error messages. The function will never return NULL,
- * so the name can be used without further checking or fallbacks.
- *
- * Return the device's ID if it has one.  Else, return the path of a
- * device on its bus if it has one.  Else return its canonical QOM
- * path.
- */
-const char *qdev_get_printable_name(DeviceState *dev);
-
 void qbus_set_hotplug_handler(BusState *bus, Object *handler);
 void qbus_set_bus_hotplug_handler(BusState *bus);
 
-- 
2.53.0


