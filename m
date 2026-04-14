Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A758F9D0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 20:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCkTy-00033Y-BL; Tue, 14 Apr 2026 16:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing>)
 id 1wCifs-0000LW-K8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:39:49 -0400
Received: from v523.v5ed9ac7d.euw1.send.eu.mailgun.net ([141.193.32.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing>)
 id 1wCifq-0003B8-5B
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:39:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=slonk.ing; q=dns/txt;
 s=mta; t=1776191976; x=1776199176; 
 h=Cc: To: To: Message-Id: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Subject: Subject: Date: From: From: Sender: Sender; 
 bh=94CCqUmlPsGu6DHgOGc7Wp+qzIdaSAoCrsPDJUOExm0=;
 b=FJ5tn3teUKAWPlxEErFtIGDgk+cvfZLVxXs11s39R/8N4h3+PXWYf/Mp2jltTNv76SC/XkGP8FKjBL8GoipnnRf5Dkc8LjToPtys4DogOag7TIph7ya5Dc5c4DtGEvx/hoPbxYlvgDmxS8/U8dOZFHalrKIb+E2ShUbmShT9mfoqS+LQQz7sKJ9ONMxYq9ikAsKiCKf94Y5OG9zBi4zY8pETXT+OGUMXVUiX+CFX6FgxjbM1mws1GyKUGcMu0ux363lJ2VAC+8ElwZxwT8rUUa+zhyLi8BKZDNIYKUwpHsbSZWgmSBCisMpr/VvgY8t/99awthnONvvq2JCQjImcVA==
X-Mailgun-Sid: WyI0MzM2NSIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsImEzOGY0Il0=
Received: from mail.slonk.ing (127.183.70.95.static.turk.net [95.70.183.127])
 by
 63e0de8118887752161783d0eb192d6253eb493147f266eb869d0dba74990965 with SMTP id
 69de89e899631a7c2e18cf36; Tue, 14 Apr 2026 18:39:36 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
DKIM-Signature: v=1; a=rsa-sha256; s=202407r; d=slonk.ing; c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1776191975;
 bh=94CCqUmlPsGu6DHgOGc7Wp+
 qzIdaSAoCrsPDJUOExm0=; b=tv1W5w4PX6/p4wgIiRa89fhP+hngDu2IbEKPJXxIiwe9Jrj2cz
 tBLyTwRGEvaw3FOheE9wo6Q+aI9RiNHTIMCCwMUBsMX/BFmutLgaPLUFdywFEnUzVSUoZbIhftV
 s3GTORvsVA77RMaJrGdrEe9uNCTjS5OWc2fdwOay/z9lCfLRxSb1zha5PDL+efA7x/RJwrYflIV
 nDE6ZM/JNnrb8g1gJTfh+17liFr7fuIGVWPSsFU6j/2sdJT3bcxr4SrdpHIe2oiUnVcgo+7Ce+D
 jT2YymyQql5KvctkfHrOH6qyGILN76I6Cu0nMw68BXnu60Q07p7vbYyYDV9BCS8qhug==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202407e; d=slonk.ing;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1776191975; bh=94CCqUmlPsGu6DHgOGc7Wp+
 qzIdaSAoCrsPDJUOExm0=; b=8EYqdmVJeLRc/PgY1XCViDcBWeSvT3PZz2l/MV61gStMUf6O2M
 1MAWtREDoGAs3rYYd2CZmmXJEchToL79YCAQ==;
Date: Tue, 14 Apr 2026 21:39:35 +0300
Subject: [PATCH] add a refresh_rate option to virtio-gpu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-virtio-gpu-refresh-rate-v1-1-59e6320eb24e@slonk.ing>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsEsUvpKdKjcdC8Wa0UQ/j3pO
 AwzLyQSpgRD9YLQzYn3WKCpK1jDHD0hu8Kgle5V13R4s5y8oz8uFNqEUkCZT8LWLK21ZJwzGkp
 9FMvPfx6nnD8lWuqPaQAAAA==
X-Change-ID: 20260414-virtio-gpu-refresh-rate-37b388e7dd72
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 slonkazoid <slonkazoid@slonk.ing>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=141.193.32.23;
 envelope-from=bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing;
 helo=v523.v5ed9ac7d.euw1.send.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Apr 2026 16:35:32 -0400
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
Reply-to:  slonkazoid <slonkazoid@slonk.ing>
From:  slonkazoid via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: slonkazoid <slonkazoid@slonk.ing>
---
currently, the virtio-gpu module does not set a refresh rate, making it
default to 75Hz in the qemu edid generation logic. i wrote a sloppy patch
that adds a `refresh_rate` option to virtio-gpu, which propagates to all
the devices based on it (i was interested in virtio-vga-gl). it's not of
much use by itself but when combined with something like Sunshine or
looking-glass, it can provide *far* smoother guest graphics than the
inbuilt display devices. i have done a bare minimum amount of manual
testing (virtio-vga-gl with venus XOR amdgpu drm native context streaming
video games) and it functions as intended, and should not break the code
path to fetch the refresh rate from the active display device (?), however,
i have never contributed to QEMU before and i don't know the customs
concerning testing, documentation, etc. if there's more i should do, please
tell me! if this is something that would benefit QEMU, feel free to merge it.
it's probably not a copyrightable change anyways.
---
 hw/display/virtio-gpu-base.c   | 1 +
 include/hw/virtio/virtio-gpu.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index cb76302e2d..d87f6604d0 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -232,6 +232,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
 
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
+    g->req_state[0].refresh_rate = g->conf.refresh_rate;
 
     for (output_idx = 0, node = g->conf.outputs;
          node && output_idx < g->conf.max_outputs;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f69fc19462..66cf921045 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -131,6 +131,7 @@ struct virtio_gpu_base_conf {
     uint32_t flags;
     uint32_t xres;
     uint32_t yres;
+    uint32_t refresh_rate;
     uint64_t hostmem;
     VirtIOGPUOutputList *outputs;
 };
@@ -176,7 +177,8 @@ struct VirtIOGPUBaseClass {
     DEFINE_PROP_BIT("edid", _state, _conf.flags, \
                     VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
     DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
-    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
+    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800), \
+    DEFINE_PROP_UINT32("refresh_rate", _state, _conf.refresh_rate, 60000)
 
 typedef struct VGPUDMABuf {
     QemuDmaBuf *buf;

---
base-commit: 985062e2319e6bf4a4be9c216ede6d34379e5777
change-id: 20260414-virtio-gpu-refresh-rate-37b388e7dd72

Best regards,
-- 
slonkazoid <slonkazoid@slonk.ing>


