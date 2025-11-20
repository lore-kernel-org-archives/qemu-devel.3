Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D64CD4F3E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 04:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLvyP-0001EI-9V; Wed, 19 Nov 2025 23:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLvyD-0001Ap-UC
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 23:08:34 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLvyC-0000bI-Ga
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 23:08:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763611697; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yb40tO17SMvpgqkv8l9or6OaRYcgCIR4jkzrPO17k0A6T2lvfT0glNti+KSg74LbHOtJTSAwzHoB3KgTk8D3kicv/9nfWocGezy8D1Tz48HBQxRE/v9WrjeiMiAjSoGu+f17Q2oedwlHNPXswzvKVvB+f2HCWkckYFTzE1svHPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763611697;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=US5J9PMAuacGziC2eTcGcipp4ALDzubHRnffxqoY5NI=; 
 b=OScS6yOA0cKG9mB+KYTvjQ0U7NO7cUOa3d9SlWPkzGbe0OxsBMsqNSknJKjGlYiDU6gOBlIbI6tSrV0nZGKVHcK+C1d85PttYemTlh/aH9iJamMYR2ecqBc0gdm91FWLIRhBkcfjAPvfJx6cmugWtkaVrh4245uIXkuIikIpqek=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763611697; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=US5J9PMAuacGziC2eTcGcipp4ALDzubHRnffxqoY5NI=;
 b=SVWWwNzrjnM69Vvhe37CGkeD7dh2hNOraNgx+mVQNqzY06ya+KOqprZpkhYwfPOk
 LHvPzNvGnPTCasT9zTrx9+ZRyniw31/jhacaNBoLRdJD60I1IGvGWmnltOaQUo3tXTT
 jKBnzip28Ik3Jm4p3pXnlExh1csHBP2+2C0SiQ6o=
Received: by mx.zohomail.com with SMTPS id 1763611696677510.8601168824182;
 Wed, 19 Nov 2025 20:08:16 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
Subject: [RFC PATCH v3 6/7] virtio-gpu: Make virtio_gpu_virgl_init() return -1
 on error
Date: Thu, 20 Nov 2025 07:06:31 +0300
Message-ID: <20251120040632.4036204-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
References: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Make virtio_gpu_virgl_init() return -1 on error to make it consistent
with virtio_gpu_virgl_reset() in regards to error handling codding style,
adhering to QEMU's devel/style recommendations.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c    | 2 +-
 hw/display/virtio-gpu-virgl.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index bca7d489c1e3..d65da4863923 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -78,7 +78,7 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         }
         /* fallthrough */
     case RS_START:
-        if (virtio_gpu_virgl_init(g)) {
+        if (virtio_gpu_virgl_init(g) < 0) {
             gl->renderer_state = RS_INIT_FAILED;
             return;
         }
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 24d329022da9..35201d629b9c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1357,7 +1357,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
              * Async-fence was bugged in virglrenderer versions <= 1.1.1.
              */
             error_report("drm requires egl display and virglrenderer >= 1.2.0");
-            return -EINVAL;
+            return -1;
         }
     }
 #endif
@@ -1365,7 +1365,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
-        return ret;
+        return -1;
     }
 
     gl->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-- 
2.51.1


