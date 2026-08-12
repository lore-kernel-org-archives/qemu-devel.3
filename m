Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ADCC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAN6-0003g4-5d; Wed, 12 Aug 2026 10:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALD-0007Nj-7N; Wed, 12 Aug 2026 10:54:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAL9-0007GF-Fj; Wed, 12 Aug 2026 10:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=MXMbumYnYj7O92KQP4TJAgTvwrWy6CKfkriYDxZDnT0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oNuB6JKboC3hxit7v67MKY2tWW8EIowMq5wWKAeaSTPEYkUS4Jxfv9mIirJsc8AvG
 s7sRI/qAQ/sMCzYY9jkGvKBDz7ZMeigQwfEiKquPGHrblkB6kXWhxDwDduNUStGjee
 cz8W4jkZtXWSRzkAJgIyYWUMG74KuYnnfxugTLsNNMlk/hG9Alnq017Q5z1OcAjNRy
 tZvOXcE2mkxh2PLzDjxYAKH5PSr9NMKP7hcKDfoQhwU8aKpvYO3ml1QWCjweRYiKBV
 dqCSBaprZkJGY5LbKV+fA34LwI29A9TCUoSn6dXS8amPgCIwyE2geTahJtPvBlLyOt
 ZXJ2ON/e16jww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C28151CA62B;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 28CED409D6D;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 85A2C2F9B1; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <jianghaotian.sunday@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 039/120] virtio-gpu: fix NULL deref in rutabaga
 set_scanout
Date: Wed, 12 Aug 2026 17:48:22 +0300
Message-ID: <20260812144955.649205-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
(16), but does not check scanout_id < conf.max_outputs like the base
class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.

With the default max_outputs=1, virtio_gpu_base_device_realize only
initializes scanout[0].con. A guest submitting SET_SCANOUT with
scanout_id >= 1 takes the con=NULL path, and
qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
QEMU.

Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs in the
CHECK, since realization already ensures max_outputs <=
VIRTIO_GPU_MAX_SCANOUTS.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3897
Cc: qemu-stable@nongnu.org
Message-ID: <20260720071556.106003-1-jianghaotian.sunday@gmail.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
(cherry picked from commit 8ac0a1c7b98e11693db8fc6b390cc892b6e3e6c8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index e5e85fde583..17ccfa51170 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -302,7 +302,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
-    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
+    CHECK(ss.scanout_id < vb->conf.max_outputs, cmd);
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
-- 
2.47.3


