Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E358112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PPG-000277-0L; Wed, 11 Mar 2026 15:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PPE-00024y-ES; Wed, 11 Mar 2026 15:39:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PPC-0000lG-GT; Wed, 11 Mar 2026 15:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257670; bh=HqqeW9DN0m2r9qxws3IasQ7tmhvdTHpfk2tJ3Ob7gAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=djSG+ul3SepHe6LnJrw7ENzU+OKxRVxoQyX0NXTh/A2+0JXCkOK+q5ce625w0+QTJ
 DNHkSpuJmMHkciAk8BNyqiiqntBJQaPAxPsAOE0OGpbYaeiKOiKcIJrkyMKOLZbjwG
 ZTv7+8pyWRMl6j+UEojB5/e+tjujapbS1kPV6F3XMarOaVboM+IbW7N08MPyHXXEGy
 UH0xuMJoAa1051qmOLlc5T2+B+rBXZDHqncaIVa2uMfWGGXxNxE7oJozatk0KogxRp
 2+STPloavM0PbLucGKwMucEF2pBbrIfPK2VJqHgy971H/ZxHLOCW9Ys6FkNaz6l1iI
 in+cbcKwC5EWg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3EEAE19211A;
 Wed, 11 Mar 2026 22:34:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 82C5237C47F;
 Wed, 11 Mar 2026 22:35:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 50/53] hw: Make qdev_get_printable_name() consistently
 return freeable string
Date: Wed, 11 Mar 2026 22:34:43 +0300
Message-ID: <20260311193449.1096110-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The current implementation of qdev_get_printable_name() sometimes
returns a string that must not be freed (vdev->id or the fixed
fallback string "<unknown device>" and sometimes returns a string
that must be freed (the return value of qdev_get_dev_path()). This
forces callers to leak the string in the "must be freed" case.

Make the function consistent that it always returns a string that
the caller must free, and make the three callsites free it.

This fixes leaks like this that show up when running "make check"
with the address sanitizer enabled:

Direct leak of 13 byte(s) in 1 object(s) allocated from:
    #0 0x5561de21f293 in malloc (/home/pm215/qemu/build/san/qemu-system-i386+0x1a2d293) (BuildId: 6d6fad7130fd5c8dbbc03401df554f68b8034936)
    #1 0x767ad7a82ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5561deaf34f2 in pcibus_get_dev_path /home/pm215/qemu/build/san/../../hw/pci/pci.c:2792:12
    #3 0x5561df9d8830 in qdev_get_printable_name /home/pm215/qemu/build/san/../../hw/core/qdev.c:431:24
    #4 0x5561deebdca2 in virtio_init_region_cache /home/pm215/qemu/build/san/../../hw/virtio/virtio.c:298:17
    #5 0x5561df05f842 in memory_region_write_accessor /home/pm215/qemu/build/san/../../system/memory.c:491:5
    #6 0x5561df05ed1b in access_with_adjusted_size /home/pm215/qemu/build/san/../../system/memory.c:567:18
    #7 0x5561df05e3fa in memory_region_dispatch_write /home/pm215/qemu/build/san/../../system/memory.c
    #8 0x5561df0aa805 in address_space_stm_internal /home/pm215/qemu/build/san/../../system/memory_ldst.c.inc:85:13
    #9 0x5561df0bcad3 in qtest_process_command /home/pm215/qemu/build/san/../../system/qtest.c:480:13

Cc: qemu-stable@nongnu.org
Fixes: e209d4d7a31b9 ("virtio: improve virtqueue mapping error messages")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260307155046.3940197-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 1e3e1d51e20e8b38efa089bf54b5ee2cbbcca221)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index fab42a7270..ce0ee9fcef 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -420,7 +420,7 @@ const char *qdev_get_printable_name(DeviceState *vdev)
      * names.
      */
     if (vdev->id) {
-        return vdev->id;
+        return g_strdup(vdev->id);
     }
     /*
      * Fall back to the canonical QOM device path (eg. ID for PCI
@@ -437,7 +437,7 @@ const char *qdev_get_printable_name(DeviceState *vdev)
      * Final fallback: if all else fails, return a placeholder string.
      * This ensures the error message always contains a valid string.
      */
-    return "<unknown device>";
+    return g_strdup("<unknown device>");
 }
 
 void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 683026adc4..deb7c6695e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -258,10 +258,12 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, packed);
     if (len < size) {
+        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+
         virtio_error(vdev,
                 "Failed to map descriptor ring for device %s: "
                 "invalid guest physical address or corrupted queue setup",
-                qdev_get_printable_name(DEVICE(vdev)));
+                devname);
         goto err_desc;
     }
 
@@ -269,10 +271,12 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
+        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+
         virtio_error(vdev,
                 "Failed to map used ring for device %s: "
                 "possible guest misconfiguration or insufficient memory",
-                qdev_get_printable_name(DEVICE(vdev)));
+                devname);
         goto err_used;
     }
 
@@ -280,10 +284,12 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
+        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+
         virtio_error(vdev,
                 "Failed to map avalaible ring for device %s: "
                 "possible queue misconfiguration or overlapping memory region",
-                qdev_get_printable_name(DEVICE(vdev)));
+                devname);
         goto err_avail;
     }
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2caa0cbd26..774329bba9 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1065,6 +1065,22 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 extern bool qdev_hot_removed;
 
 char *qdev_get_dev_path(DeviceState *dev);
+
+/**
+ * qdev_get_printable_name: Return human readable name for device
+ * @dev: Device to get name of
+ *
+ * Returns: A newly allocated string containing some human
+ * readable name for the device, suitable for printing in
+ * user-facing error messages. The function will never return NULL,
+ * so the name can be used without further checking or fallbacks.
+ *
+ * If the device has an explicitly set ID (e.g. by the user on the
+ * command line via "-device thisdev,id=myid") this is preferred.
+ * Otherwise we try the canonical QOM device path (which will be
+ * the PCI ID for PCI devices, for example). If all else fails
+ * we will return the placeholder "<unknown device">.
+ */
 const char *qdev_get_printable_name(DeviceState *dev);
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler);
-- 
2.47.3


