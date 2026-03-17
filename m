Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C902BFED9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y53-0001wM-8r; Tue, 17 Mar 2026 13:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y4t-0001vz-Hw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y4q-0005JB-LL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773767968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T6BSK8DBmce9Y+BuiYRhi1P9uHDjL4l3FRKtss2mpcc=;
 b=eNNRLI+o71Y0BV4lJcwpMUXeVgOUeqiK1KHzn3r+sK4ubB/K0Ctxlh/ysxm4D8dd4nUOIR
 tLGiBO0K7duZmZwv81vhfjXWqPU7N38g3I/bbquwogocHrYB7kPPwWJIVy1xRdEriEsmEw
 FeKHXb1y7Tjg395PWxkwbI0vqRPdQNk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-DwTEpTyvO-eAZL9P4GTz0g-1; Tue,
 17 Mar 2026 13:19:25 -0400
X-MC-Unique: DwTEpTyvO-eAZL9P4GTz0g-1
X-Mimecast-MFC-AGG-ID: DwTEpTyvO-eAZL9P4GTz0g_1773767963
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 023BB195608C; Tue, 17 Mar 2026 17:19:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B025619560AB; Tue, 17 Mar 2026 17:19:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 00/16] ui/audio/dump patches for 11.0-rc
Date: Tue, 17 Mar 2026 21:19:00 +0400
Message-ID: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48aa:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-16 13:07:33 +0000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/for-11.0-pull-request

for you to fetch changes up to 461632f0b1cb2c5c29ba9875857637e3356b903c:

  coreaudio: Initialize the buffer for device change (2026-03-17 21:15:10 +0400)

----------------------------------------------------------------
Gather various audio/ui/dump patches for 11.0-rc

----------------------------------------------------------------

Akihiko Odaki (7):
  ui/console: Unify pixman-OpenGL format mapping
  ui/console: Remove DisplaySurface::mem_obj
  ui/surface: Avoid including epoxy/gl.h in header files
  coreaudio: Improve naming
  coreaudio: Commit the result of init in the end
  audio: Add functions to initialize buffers
  coreaudio: Initialize the buffer for device change

Dongwon Kim (1):
  ui/gtk-egl: Ensure EGL surface is available before drawing

Fiona Ebner (1):
  ui/vdagent: add migration blocker when machine version < 10.1

Marc-André Lureau (6):
  audio/mixeng: drop some needless checks
  rutabaga: improve error handling, fix potential crash during init
  virtio-gpu: fix overflow check when allocating 2d image
  virtio-gpu: use computed rowstride instead of deriving it from hostmem
  ui/dbus-listener: Fix FBO leak in dbus_cursor_dmabuf
  ui/dbus-listener: remove dbus_filter on connection close

Nikolai Barybin (1):
  dump: enhance dump_state_prepare fd initialization

 audio/audio_int.h                |   2 +
 audio/audio_template.h           |   6 -
 include/ui/console.h             |   4 +-
 include/ui/shader.h              |   2 -
 include/ui/spice-display.h       |   1 +
 include/ui/surface.h             |   6 +-
 audio/audio-mixeng-be.c          |  24 +++-
 dump/dump.c                      |   9 +-
 hw/core/machine.c                |   1 +
 hw/display/virtio-gpu-rutabaga.c |  19 ++-
 hw/display/virtio-gpu.c          |  43 +++++--
 ui/console-gl.c                  |  74 ++++++-----
 ui/dbus-listener.c               |  16 +++
 ui/gtk-egl.c                     |  12 +-
 ui/shader.c                      |   1 +
 ui/spice-display.c               |   9 +-
 ui/vdagent.c                     |  46 +++++++
 audio/coreaudio.m                | 204 ++++++++++++++++---------------
 18 files changed, 288 insertions(+), 191 deletions(-)

-- 
2.53.0


