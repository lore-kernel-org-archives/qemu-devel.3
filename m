Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D7BC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 22:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTqlS-0000p4-Pw; Sat, 27 Jan 2024 17:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rTqlR-0000oR-QP
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 17:03:01 -0500
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rTqlQ-0007Sv-Bv
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 17:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1706392976;
 bh=NBZ5aWv+hc3gmcjREXnGwkhdCZvTct4Wr1/zV3u4Bc8=;
 h=From:To:Cc:Subject:Date:From;
 b=J6OyYiH860FaLdfZo1Ngx+weoDMLxQlvd0ExpP2CqmnPuWB0QIuSv9reEzTaGsvir
 gPNn/N9Rk4/yQ/DF+dAoEJrxOw/eFLU6FLna8n4qqAQFoqWCQs97Cc8pxrVVpCJ6jr
 fSYvwuoox/B2qMbWJw60x+k8pqmjjxR1ug0OBGKUkU/UmLASsOpB50Sz0BGghb2NiN
 VC+LUdfoaO3Ag06fdGVRsXojmWQRLcRGrXey0w2DiQKZT/C7A0AIUE/WSiZzu+MRCl
 d4A3Bz6vSOHDgbjYSwMkrjRCto9a52SaCa3TtoRlreDo0oKkrz4f1F3U6YWjqqQLor
 2+4Z8rUHTk2SA==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3B7283780029;
 Sat, 27 Jan 2024 22:02:56 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v1] virtio-gpu: Correct virgl_renderer_resource_get_info()
 error check
Date: Sun, 28 Jan 2024 00:52:53 +0300
Message-ID: <20240127215253.227583-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


