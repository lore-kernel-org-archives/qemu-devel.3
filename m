Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7AAC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 07:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMFg-0003p4-A0; Mon, 29 Jan 2024 02:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rUMFe-0003oq-UX
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 02:40:18 -0500
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rUMFd-0001LZ-6N
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 02:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1706514014;
 bh=cEd+ECGCQCFiPKvn36Wn5mrHRMjsxsbPAlN+Maxznp4=;
 h=From:To:Cc:Subject:Date:From;
 b=26fC7OqStpx63IMwlBHQwqD+c9x8Pcb/AAlINXK5RVoOtOVB8ik9fcQOcU9EayX1s
 dA/s9PKEV7U26SHKfxIvKjOWYu0FKVWm0LiwkvKkTePe37jk+xNVubZmWR5uJj1dcJ
 db6yqIsgewuLZTok57WZYVSCkgTdLZVc/hTYJm2fVGkQXbAJ8xBGjOybw9qCetdN6x
 h082ETFyi0LCrtMLsK/+xqsEUXYakyS2Jnrt2q/6xyLWeMWlNKtOZzcW8wqud8tNEd
 9zavdjrbD/ZqRywYA4NmwvZA9W5RAzdTgPyV5q23f3pMiDeJKo/fCQlGRIur+0RyzO
 zdjlwPt583lZQ==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1BFBB37813FD;
 Mon, 29 Jan 2024 07:40:14 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-gpu: Correct virgl_renderer_resource_get_info()
 error check
Date: Mon, 29 Jan 2024 10:39:21 +0300
Message-ID: <20240129073921.446869-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

virgl_renderer_resource_get_info() returns errno and not -1 on error.
Correct the return-value check.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---

v2: - Fixed similar incorrect error-checking in vhost-user-gpu
    - Added r-b from Marc

 contrib/vhost-user-gpu/virgl.c | 6 +++---
 hw/display/virtio-gpu-virgl.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index d1ccdf7d0668..51da0e3667f9 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -327,7 +327,7 @@ virgl_get_resource_info_modifiers(uint32_t resource_id,
 #ifdef VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION
     struct virgl_renderer_resource_info_ext info_ext;
     ret = virgl_renderer_resource_get_info_ext(resource_id, &info_ext);
-    if (ret < 0) {
+    if (ret) {
         return ret;
     }
 
@@ -335,7 +335,7 @@ virgl_get_resource_info_modifiers(uint32_t resource_id,
     *modifiers = info_ext.modifiers;
 #else
     ret = virgl_renderer_resource_get_info(resource_id, info);
-    if (ret < 0) {
+    if (ret) {
         return ret;
     }
 
@@ -372,7 +372,7 @@ virgl_cmd_set_scanout(VuGpu *g,
         uint64_t modifiers = 0;
         ret = virgl_get_resource_info_modifiers(ss.resource_id, &info,
                                                 &modifiers);
-        if (ret == -1) {
+        if (ret) {
             g_critical("%s: illegal resource specified %d\n",
                        __func__, ss.resource_id);
             cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8bb7a2c21fe7..9f34d0e6619c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -181,7 +181,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         memset(&info, 0, sizeof(info));
         ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
 #endif
-        if (ret == -1) {
+        if (ret) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: illegal resource specified %d\n",
                           __func__, ss.resource_id);
-- 
2.43.0


