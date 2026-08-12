Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FF4C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8f7-00022l-8w; Wed, 12 Aug 2026 09:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8eh-00015l-WD; Wed, 12 Aug 2026 09:06:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ee-0004y5-BE; Wed, 12 Aug 2026 09:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=xlTNzLFkAwWz66j1/WAnfe/F7Wl5HHYHawz74Hut5TI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KYyJISsKLFEgEv0TSHS8KwUnDM0xZyLvDILMFJF842kV5/75hMjIGdG5DcrNZO4J/
 uv7QWdo9TuVugDXjYrj+rHYz8KBeJPppnWxiKWNJui+1X8hrdmEScEMTGyKZadYF3j
 hYa9jgoQyP4KAvGlZvsLitmF9pc2o0CX01oqI6LiHVBtlqiDG55DUI24GY20p2Rpz9
 N5iuWFsBseXKuMqR05Ci7O5zOpp/XAZunt3y/vU/zuADnxDUW2ibhMZptX5hnZM+aP
 rwRhA/tNkfwHffSprjH5XoXT4HewP8MMdhWRKlAjN0mTchAuf8ptmG5Uh7drdtsvLZ
 C+Q0luK2ziWZw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AEFDB1CA4A1;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E559F409B84;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 244242F8D8; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 034/102] rutabaga: improve error handling,
 fix potential crash during init
Date: Wed, 12 Aug 2026 16:01:09 +0300
Message-ID: <20260812130233.621965-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When virtio_gpu_rutabaga_get_num_capsets() returns 0, virtio_init()
isn't called and the device later crashes during realize.
==72545==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x556ad6f7ba9e bp 0x7ffe6958f810 sp 0x7ffe6958f7e0 T0)
==72545==The signal is caused by a READ memory access.
==72545==Hint: address points to the zero page.
#0 0x556ad6f7ba9e in virtio_memory_listener_commit ../hw/virtio/virtio.c:4034
#1 0x556ad6a24c96 in listener_add_address_space ../system/memory.c:3128
#2 0x556ad6a25d15 in memory_listener_register ../system/memory.c:3216
#3 0x556ad6f7bf11 in virtio_device_realize ../hw/virtio/virtio.c:4075

Rework error handling of the function to set Error appropriately. 0
capset may be ok now.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 5322889f07b5cba09df9500a788daa42a977cc94)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index c235c3d31b0..3b71f389dc3 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1040,19 +1040,19 @@ static bool virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
     return true;
 }
 
-static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
+static bool
+virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g, uint32_t *num_capsets, Error **errp)
 {
     int result;
-    uint32_t num_capsets;
     VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
 
-    result = rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
+    result = rutabaga_get_num_capsets(vr->rutabaga, num_capsets);
     if (result) {
-        error_report("Failed to get capsets");
-        return 0;
+        error_setg_errno(errp, -result, "Failed to get num_capsets");
+        return false;
     }
-    vr->num_capsets = num_capsets;
-    return num_capsets;
+    vr->num_capsets = *num_capsets;
+    return true;
 }
 
 static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
@@ -1078,7 +1078,7 @@ static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
 static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
 {
-    int num_capsets;
+    uint32_t num_capsets;
     VirtIOGPUBase *bdev = VIRTIO_GPU_BASE(qdev);
     VirtIOGPU *gpudev = VIRTIO_GPU(qdev);
 
@@ -1091,8 +1091,7 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
-    num_capsets = virtio_gpu_rutabaga_get_num_capsets(gpudev);
-    if (!num_capsets) {
+    if (!virtio_gpu_rutabaga_get_num_capsets(gpudev, &num_capsets, errp)) {
         return;
     }
 
-- 
2.47.3


