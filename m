Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52ECC531F3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 00:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtEFx-0005cx-HV; Thu, 19 Feb 2026 19:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEFw-0005cN-7J
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:20:28 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEFt-0004oT-8u
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:20:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771546803; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=csI7l1wN3NM8VQjIMgUN4laqslE3RU5XCPyUScucSbAgMRopwTSqduix2EGX5ejMGcyIvYSRc1WFmtZCDbG6c+WGhlucym5vLy+NKOmsTK51IdlZmDALb0QyR5ipJVR3sfUo/EjOyc31UAUlkcHzohqfaqBUO+ZqCxko+eivEYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771546803;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tmN9GsDmUioyMki0qY56sH5uCPoV9JvTsKogYuE8bOk=; 
 b=RlvGqqg/u7uYPzuU/fAVvAukqfzZsUJhLBh9ZVzDpxCMunBrWkHZtzkSSjSjkJ/EXcZKwAxmn4YCPtMagCvcrlu7KPVfmLW82a+INBvMDM00tHoPhTYsEUig/N5co1AIEihd4YRB6pyO+UHzFa3mh9ixWdetgd95TNlIfkUZauA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771546803; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tmN9GsDmUioyMki0qY56sH5uCPoV9JvTsKogYuE8bOk=;
 b=cot81C4jWLC24X52vjedqwwX5Vno6AZDqOjBtG9D1Xqwnnf7l/8yqktNvlun7yPB
 SQdz19ImOICDHb6A8RXbQD3Y6KqFo6KxdKBbmdTzvulMQ1jGjz0lIxyjhz56tj0dQXF
 /7PZo74+dwb6GS8lkYnNwj7bTzuJnsh17OvfhDeU=
Received: by mx.zohomail.com with SMTPS id 1771546802095430.317970915532;
 Thu, 19 Feb 2026 16:20:02 -0800 (PST)
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
Subject: [PATCH v19 00/20] Support virtio-gpu DRM native context and MAP_FIXED
 API
Date: Fri, 20 Feb 2026 03:16:14 +0300
Message-ID: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
virtio-gpu patches that has been reviewed previously and were waiting for
a new release of libvirglrenderer 1.3.0.

[1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-dmitry.osipenko@collabora.com/
[2] https://lore.kernel.org/qemu-devel/20260118162856.223796-1-dmitry.osipenko@collabora.com/

Based-on: 20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp

Changelog:

v19:- Further improved improved naming of functions and terminology RE
      GL context binding. Suggested by Akihiko Odaki.

    - Added new patch "ui/gdk: Restore original context after new context
      creation" in addition to improved "ui/sdl2: Restore original context"
      that now getd actual bound GL context and restores to it instead
      of restoring to the console's ctx, for consistency with the rest
      of GL context management fixes that ensure context is bound only
      when necessary.

    - Improved virtio_gpu_virgl_update_render_state() with force_ctx_0()
      and unbind_ctx() to make deferred GPU resetting maintain bound GL
      context properly.

v18:- Changed dpy_gl_ctx_make_current() to use first scanout when unsetting
      virgl's GL ctx0 and improved naming of cmd-processing function.
      Suggested by Akihiko Odaki.

    - Added "ui/gdk: Unset context after GL operations" patch after
      realizing GDK/GL code needed more gdk_gl_context_clear_current().

v17:- Rebased patches on recent upstream, updated doc patches with new
      drm native contexts supported by libvirglrenderer.

    - Applied minor change that was requested from Akihiko Odaki
      by moving virtio_gpu_device_realize() for MAP_FIXED v10.

    - Added virtio_gpu_virgl_update_render_state() to virtio_gpu_fence_poll()
      that was missed in MAP_FIXED v10.

    - Added new patches fixing another GL context switching problem I ran
      into recently with virgl commands unexpectedly processed from CPU
      thread instead main-loop:

        ui/sdl2: Unset context after GL operations
        ui/gtk-egl: Unset context after GL operations
        virtio-gpu: Unset context after GL operations

Alex Bennée (1):
  docs/system: virtio-gpu: Document host/guest requirements

Dmitry Osipenko (18):
  ui/gdk: Restore original context after new context creation
  ui/sdl2: Restore original context after new context creation
  ui/sdl2: Don't disable scanout when display is refreshed
  ui/gtk: Don't disable scanout when display is refreshed
  ui/sdl2: Unbind context after GL operations
  ui/gtk-egl: Unbind context after GL operations
  ui/gdk: Unbind context after GL operations
  virtio-gpu: Unbind context after GL operations
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

Pierre-Eric Pelloux-Prayer (1):
  ui/sdl2: Implement dpy dmabuf functions

 docs/system/devices/virtio/virtio-gpu.rst | 121 +++++-
 hw/display/trace-events                   |   2 +-
 hw/display/virtio-gpu-gl.c                |  62 +++-
 hw/display/virtio-gpu-virgl.c             | 427 ++++++++++++++++++++--
 hw/display/virtio-gpu.c                   |  15 +
 include/hw/virtio/virtio-gpu.h            |  23 +-
 include/ui/sdl2.h                         |   7 +
 meson.build                               |   8 +-
 ui/gtk-egl.c                              |  17 +-
 ui/gtk-gl-area.c                          |  28 +-
 ui/sdl2-gl.c                              |  81 +++-
 ui/sdl2.c                                 |  42 +++
 12 files changed, 760 insertions(+), 73 deletions(-)

-- 
2.52.0


