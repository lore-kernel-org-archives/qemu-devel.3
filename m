Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC57AF433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 04:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDEBI-0000r4-Im; Thu, 16 Apr 2026 00:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing>)
 id 1wCwP0-0004Oh-G7
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:19:18 -0400
Received: from v523.v5ed9ac7d.euw1.send.eu.mailgun.net ([141.193.32.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing>)
 id 1wCwOx-00049W-SC
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:19:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=slonk.ing; q=dns/txt;
 s=mta; t=1776244752; x=1776251952; 
 h=Cc: To: To: Message-Id: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Subject: Subject: Date: From: From: Sender: Sender; 
 bh=wfxP6BRW0Z5vudEw1tO1maLW1OLCibiTlJsKRc5xUl8=;
 b=ol2uH8baCd2JzvhYvUtJwyg0f3JTLaTlbri+iAGNja1t77EFlW9cHa9hDR+dUDfmzP5BQ9OvTyAS7ff3lkbfXrjmeKHKQ/Zq/ZcKZbVx9TyfWzVTRAYWHusspAqpkcyOJ2YhvcpOdf5gltLZeR0djV0kO/dEqZ5z5gqZjWQUlMAdxLIGXA45o0qa0dhobQGxyGZNH7e58CLcJh09r6UOTh3/cuj8XAro7qBESYzUnl4Z2oE9utY6jTVQhIhitBdn0GNUHtYppsljabXCarbkhSMlw++/e+aUXJOV5CZIgTozTwoB3PC4GW49kYzHfJMSQ3Sr+Kjq9MSRe5j8US1n/w==
X-Mailgun-Sid: WyI0MzM2NSIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsImEzOGY0Il0=
Received: from mail.slonk.ing (127.183.70.95.static.turk.net [95.70.183.127])
 by
 3227148c7315d7b8ed159b4eee550e840a3c5c9326b4dd5b32061137fbaa3c06 with SMTP id
 69df5810e1e94239b61f20ca; Wed, 15 Apr 2026 09:19:12 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
DKIM-Signature: v=1; a=rsa-sha256; s=202407r; d=slonk.ing; c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1776244749;
 bh=wfxP6BRW0Z5vudEw1tO1maL
 W1OLCibiTlJsKRc5xUl8=; b=H3jHXtS4ht47/oMg6LuXEcklIH0hPKJtJuQG7iyR9y6JxhICAS
 +kL/0fxpqpJFBS92H/9CXv9z9+D50hbPeyHtAicjCDJDCP4xqIxPVqPkAfT1K/uIoAFEjtiwO5x
 fPt0BPub3g6mOcgMta6RevI8s5IaczQoNPseMwoUl2/YRT7o2DO02KJHyDp7FqFuQnxY5yoKnQt
 X/HjIz0GUxBWi+SQY0Uu2XtvgGYQMeP0rCJvQQJLNEJRLEXNM75HzGV+dFzH6kY+pUWGLfXGZYj
 2jdpr33c2bc9+9c8dlGwnKqj4XUr4TEIuMCbRjFliV5nQBcN0g4neketftHfUHZteug==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202407e; d=slonk.ing;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1776244749; bh=wfxP6BRW0Z5vudEw1tO1maL
 W1OLCibiTlJsKRc5xUl8=; b=gb8ih4W9vcwgY+ZWOCbXwDndatojMc2HiNQ4OtD+PMlLnyE/bS
 2NZYSGMyapXxs27pgDJ16u6kl9UNvKt8EvDQ==;
Date: Wed, 15 Apr 2026 12:19:05 +0300
Subject: [PATCH v2] add a refresh_rate option to virtio-gpu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-virtio-gpu-refresh-rate-v2-1-b71599d84755@slonk.ing>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RhaKiAr72FYgIww0bRkWhsN6
 d2tXMDl+z///Q08CZOHrthAKLJnZzPoQwG3ZbAzIU+ZQZe6Lo0yGFkCO5zXFwrdhfyCMgTCqhm
 rtqVmmhoNeb3mlt+7+dpnXtgHJ5/9KKpf+t8ZFSo8namudEmjNnTxT2cfR7Yz9CmlL3s5D6K+A
 AAA
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
X-Mailman-Approved-At: Thu, 16 Apr 2026 00:18:04 -0400
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
Changes in v2:
- Update default value of refresh_rate to the old implied default of 75000
- Link to v1: https://lore.kernel.org/qemu-devel/20260414-virtio-gpu-refresh-rate-v1-1-59e6320eb24e@slonk.ing
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
index f69fc19462..e440535fa0 100644
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
+    DEFINE_PROP_UINT32("refresh_rate", _state, _conf.refresh_rate, 75000)
 
 typedef struct VGPUDMABuf {
     QemuDmaBuf *buf;

---
base-commit: 985062e2319e6bf4a4be9c216ede6d34379e5777
change-id: 20260414-virtio-gpu-refresh-rate-37b388e7dd72

Best regards,
-- 
slonkazoid <slonkazoid@slonk.ing>


