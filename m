Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C344EF9011
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR2-0003sS-7B; Wed, 04 Mar 2026 11:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQx-0003pP-U5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQt-0002P8-88
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:50 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-660fb578f8eso1411579a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643045; x=1773247845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pohZlbgxeUpjQCJW07Ar3LRcpYuxEuAnsTiN0R/I2/E=;
 b=beBiOp6syAAPBKSnC7ihAmMAuaZ/xAtmX/X0vH0XNwNGANY0Mn1hvyzNHKRlNpeNNv
 YEgL809Axz/VVBPSbdM1bs2OZWLY3X4rvbqvsuN29ZdRl8ab0jDN+dzJZ3SA69XA33U8
 luRd2g/LJc5HmPcdxVKKMdksmLFCeZ6dKSyh395UixG/GtXmZOhESTujRcrJ7h3Eb51Z
 uMZNkkU2R/DaZ09kvP0O4+G5dT4jmC7tPcBSCqhayjmZONLUySf/D0kkpa4Oxc9RsDhp
 7W/zOWpMCeptS++s/YyXgK8LivenbtMgW61HLTGtnY+vpAZFLY0pZTvuKReHmfYVETXg
 eFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643045; x=1773247845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pohZlbgxeUpjQCJW07Ar3LRcpYuxEuAnsTiN0R/I2/E=;
 b=Pt+jJ0TjwjifC/FPSSMD/wusHzgzyBSqmoU+ldb0lSBfDBxnjO+fg8Fwhr/BYunOmL
 leRKCfjEDyIrUg3tFViOMd6PBRPjWYXtX6oJ+Kxi3sKKyxTOhCZ+vwbKdSM9MMeDn+gR
 Nw+FZYMmOziivURQJiwwdyl4fnpMqGmWjJ7hDsJBntlhj2YAIHD4UebajmQtg3bZbaOg
 zHLXFKvOeVnDbGGhm1/92TUMfvr/GRjP3QWRq/+BqjTUEzCK77Q/Y2SkrR2Cay6fj4vs
 xJEuiCPxcHgk2vS5KznqnY19NTVNELFRdVklOdzw1PPmbO2pMEnhPqxMQd7Z1SA4+qJg
 3FKg==
X-Gm-Message-State: AOJu0Yx1Z6yWTt2bduhGF05dG87JixvicHPV50AQS+KFvrtJHqNj5IR5
 06iSpHk3mM/uvFIk2403pMM7i/4fmy08s/qS1NnwlvGTJinjKsps1uoa9ZD7h/2+Yzw=
X-Gm-Gg: ATEYQzxDkjcscnfH8+DYK+g11SSS0feK+5VdgrbGNXwg536XbbAnOobLA9pjrFzMq9a
 Fnkka6YvRB29rXGBbEub//xX7rKdY4o2ShiStAegm/yk2WlJEMwz37QYIwWzuqmqvtpiQTbsJzr
 NaOwsbyMOFHeeef1BoY7RFBv8Sj1msWDG3zSEL8qGo1aJ3yJsF+hF7aGf/lpmVu6lA+5jdvtY4n
 nlZerifmvosbxUdjFLBXdsigxQvRpIjMrpFookp7AsyKAg9qbIvSBQeD1XuYcaNpDip9Wg6AZBM
 uw8iTTdn28rDdql5HIkTZm/lVA4OJTXFimQ9JIl4p3sYRxJXLarVsPnnXob5XELuiFWq8g4x9y0
 7hrFUpYn0BBkUhgnaMZ0EJQwS9b+2CTxfAD+5F2XxzkgNfH2vMzrZZyapodtaqMqZKwtaWJM81/
 hFrK8oioutsHKNg/EwB8HmGUw=
X-Received: by 2002:a05:6402:35c2:b0:65f:8e80:4108 with SMTP id
 4fb4d7f45d1cf-660ef897451mr1775618a12.11.1772643045145; 
 Wed, 04 Mar 2026 08:50:45 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6d26dsm5904239a12.16.2026.03.04.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0B4E5F832;
 Wed, 04 Mar 2026 16:50:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/20] virtio-gpu/next - per-head resolution and native
 context (pre-PR)
Date: Wed,  4 Mar 2026 16:50:22 +0000
Message-ID: <20260304165043.1437519-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I haven't had much time to track virtio-gpu stuff this cycle so I've
just done a sweep of the mailing list archive to look for stuff that
is reviewed and looks ready.

I've had a tweak a few patches which I've done directly to avoid the
latency of getting the submitter to update. While the native-context
stuff doesn't break existing virtio-gpu invocations it would be nice
if we could have some functional tests to cover it.

The following are still need review:

  virtio-gpu: Ensure BHs are invoked only from main-loop thread
  ui/egl: Don't change bound GL context when creating new context

I intend to roll the PR on Friday.

Alex.

Alex Bennée (1):
  docs/system: virtio-gpu: Document host/guest requirements

Andrew Keesler (1):
  Support per-head resolutions with virtio-gpu

Dmitry Osipenko (16):
  ui/gtk: Don't disable scanout when display is refreshed
  ui/sdl2: Don't disable scanout when display is refreshed
  ui/egl: Don't change bound GL context when creating new context
  ui/gdk: Restore original context after new context creation
  ui/sdl2: Restore original context after new context creation
  virtio-gpu: Ensure BHs are invoked only from main-loop thread
  virtio-gpu: Handle virgl fence creation errors
  virtio-gpu: Support asynchronous fencing
  virtio-gpu: Support DRM native context
  docs/system: virtio-gpu: Add link to Mesa VirGL doc
  docs/system: virtio-gpu: Update Venus link
  virtio-gpu: Remove superfluous memory_region_set_enabled()
  virtio-gpu: Validate hostmem mapping offset
  virtio-gpu: Replace finish_unmapping with mapping_state
  virtio-gpu: Destroy virgl resources on virtio-gpu reset
  virtio-gpu: Support mapping hostmem blobs with map_fixed

Dongwon Kim (1):
  virtio-gpu: Fix scanout dmabuf cleanup during resource destruction

Pierre-Eric Pelloux-Prayer (1):
  ui/sdl2: Implement dpy dmabuf functions

 docs/system/devices/virtio/virtio-gpu.rst | 121 ++++++-
 meson.build                               |   8 +-
 qapi/virtio.json                          |  13 +-
 include/hw/virtio/virtio-gpu.h            |  26 +-
 include/hw/virtio/virtio.h                |  10 +
 include/ui/egl-context.h                  |   3 +-
 include/ui/sdl2.h                         |   7 +
 hw/display/virtio-gpu-base.c              |  16 +
 hw/display/virtio-gpu-gl.c                |  62 +++-
 hw/display/virtio-gpu-udmabuf-stubs.c     |   2 +-
 hw/display/virtio-gpu-udmabuf.c           |  25 +-
 hw/display/virtio-gpu-virgl.c             | 410 ++++++++++++++++++++--
 hw/display/virtio-gpu.c                   |  23 +-
 hw/virtio/virtio.c                        |  10 +
 ui/dbus.c                                 |   4 +-
 ui/egl-context.c                          |   6 +-
 ui/egl-headless.c                         |   4 +-
 ui/gtk-egl.c                              |   5 +-
 ui/gtk-gl-area.c                          |  13 +-
 ui/sdl2-gl.c                              |  76 +++-
 ui/sdl2.c                                 |  48 +++
 ui/spice-display.c                        |   4 +-
 hw/display/trace-events                   |   2 +-
 23 files changed, 792 insertions(+), 106 deletions(-)

-- 
2.47.3


