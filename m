Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70964FCC067
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybCb-0004Go-AJ; Fri, 06 Mar 2026 14:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCN-0004BB-AW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCJ-0000Q6-3N
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:58 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852a8482fcso5060845e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826652; x=1773431452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RRsD9LOS1hSeZNCPBaDn+y7RmCBrA9WXQ73ZIq9hjNg=;
 b=THNa/YSibiURekPcdO8NkmOhzyOZsMDMzwERGKnuPjhqNtDrGVzFfpVv5DO9cox6Rd
 0gy6pbGnQOG0OPq3ItqY4prPIEZdG1aSQWAz6u0wF74B8I9YZpVV9WTxs2lJGGBSxcfP
 LmmyIZ9bGYM1TU8h5VwtKUsfIqzGLk1aprAPJYTolCI8uT4RgEqgYnXUb5/pu1KON31f
 XABqu+4tW4Icy0yX5Rz4JGubPp+cY4Z6eIplcdIRkU+iGnRhVZMilixWrzPeNZIgHMqX
 fJC1h93ZjiPMzdpMXT838Jbj7+ywCFaTflQRNt2rNT2ecRCO/HX5hL9xD0hZ4lDL/vN2
 eG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826652; x=1773431452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRsD9LOS1hSeZNCPBaDn+y7RmCBrA9WXQ73ZIq9hjNg=;
 b=NGt7u272MRXSTsU/GRIWxjq6VmDn7YljMBR6c+hEQXuO4Qj2e+o0scgDKvYPPGgknP
 ebubL7Z+EpwkYsNqlnyxxHupjQxELHZdUafEmv3wFVjOoeCUewBhckiFCseEed+1F25m
 A+Lp8XUHQ7wryAPLvZnkfCsrqlNbcuR9igPPha+rIPuwvMwliNfmAhsPAav1+mLVr4r7
 QYBwldroN+r/vaTMzPP9hveitxICOtaXJ24JRUD/SBe4MPpxxpd6kblJP8SIBO3Ocom+
 IKYzXbVilBoH5K1R/hO5e2gtduiOK72Qk/Ch38BEYN+qNASQOra8ne3Ay6sh3pgiQhyu
 +L2w==
X-Gm-Message-State: AOJu0YzD8YR8jXLA9oFeZJhGi1QA3+4t02N9Wu7VmLBcanTVqcjetQB9
 ocVQIwlrs5iY+myrGheSmbhkcdOhSWwEz3Dlih/sR0mgEb0uKodLOZkUAeKewy+qoz8=
X-Gm-Gg: ATEYQzzxART4LKN/f9LzzmK9+UP90vPNUttQw1i6ZHH4WaYITOW2vdh93r+uRtCVAI0
 OMTfN51ZKjSBsKzI7jGlkU7+VMRfgIiPvvL/UkXpqa04tQh8J3mELrkvqESUn1hnMjgu4p9pHCy
 wlNkf22aJnrZWx7iHcWZ5VRDUL1hpocvp410QSjrW6Bz8FjIxFwJMX+p8kTZJiWJbGt4bs8rLJL
 TKDxyYOCiC9jnR98Uy2puUxA8BTTvqFyQt8oHidh2UENX6m41wj7LHReXKkibRQxwIMcs0HBBFO
 sOA6UJnRmwG+Xh03k6T0bTedYj9ANL/uDJ7LrP0PG+2ko7LgvD4tED6xokfr2KpRk2Ucn6K0Am4
 JOfaFj4q0v45x3EEXFrlCqIPbpN2gOS6E9H1Ifr8YPJ8mhruGAVaMXKzGYS/CMKCECerY4JkdN2
 E6ph6RFmRUm+5unxamPmud2ok=
X-Received: by 2002:a05:600c:37cc:b0:485:2304:a1f7 with SMTP id
 5b1f17b1804b1-485269669e9mr53602045e9.23.1772826652045; 
 Fri, 06 Mar 2026 11:50:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad27dbsm113948475e9.2.2026.03.06.11.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E040D689CF;
 Fri, 06 Mar 2026 19:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/20] virtio-gpu updates (resolution, error handling, fences,
 native context)
Date: Fri,  6 Mar 2026 19:50:27 +0000
Message-ID: <20260306195048.2869788-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

The following changes since commit 900682c57287ea308850af4490339455512e92e7:

  Merge tag 'pull-target-arm-20260306-2' of https://gitlab.com/pm215/qemu into staging (2026-03-06 15:58:24 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.0-virtio-gpu-updates-060326-1

for you to fetch changes up to 4eb0aace85f507e21bb8ac323ad81c5860f7a52d:

  virtio-gpu: Support mapping hostmem blobs with map_fixed (2026-03-06 17:27:40 +0000)

----------------------------------------------------------------
virtio-gpu updates (resolution, error handling, fences, native context)

  - support per-head resolution definitions
  - don't disable scanouts on sdl and gtk when display refreshed
  - take care not confuse virgl with switching contexts
  - use dmabuf to import textures when we can
  - keep virtio BH processing to main-loop
  - improve error handling for fence creation
  - support async fences
  - add support for DRM native context
  - update virtio-gpu docs
  - remove superfluous memory region enabling
  - validate mapping offsets
  - destroy vrigl resources on reset
  - support mapping hostmem blobs with map_fixed

----------------------------------------------------------------
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

 docs/system/devices/virtio/virtio-gpu.rst | 121 ++++++++-
 meson.build                               |   8 +-
 qapi/virtio.json                          |  13 +-
 include/hw/virtio/virtio-gpu.h            |  26 +-
 include/hw/virtio/virtio.h                |  10 +
 include/ui/egl-context.h                  |   3 +-
 include/ui/sdl2.h                         |   7 +
 hw/display/virtio-gpu-base.c              |  16 ++
 hw/display/virtio-gpu-gl.c                |  62 +++--
 hw/display/virtio-gpu-udmabuf-stubs.c     |   2 +-
 hw/display/virtio-gpu-udmabuf.c           |  27 +-
 hw/display/virtio-gpu-virgl.c             | 410 +++++++++++++++++++++++++++---
 hw/display/virtio-gpu.c                   |  23 +-
 hw/virtio/virtio.c                        |  10 +
 ui/dbus.c                                 |   4 +-
 ui/egl-context.c                          |   6 +-
 ui/egl-headless.c                         |   4 +-
 ui/gtk-egl.c                              |   5 +-
 ui/gtk-gl-area.c                          |  13 +-
 ui/sdl2-gl.c                              |  76 +++++-
 ui/sdl2.c                                 |  48 ++++
 ui/spice-display.c                        |   4 +-
 hw/display/trace-events                   |   2 +-
 23 files changed, 794 insertions(+), 106 deletions(-)

-- 
2.47.3


