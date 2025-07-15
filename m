Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64F2C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZGU-0004Yy-14; Tue, 15 Jul 2025 02:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZE2-0002TV-GF
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZDz-0003bi-AH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sLSkQO/FOiFqldZoDSpDVJbv1gFAH1Vs/BmVyGrB+/g=;
 b=WAsJwIj4akx7REw10i+lX64K5QPHQPlmplRWJHnWxqRWHDy7avyZbTvEM4i5bATmdsd7fE
 b279s7acBRozFWCqgmHt/LshSJ2tMzj0/qPe5kasEGxQJVyR/5kFLFPbT/DaSjFffRCaMw
 K5OWMTbhbeJktjemRqffNrb2+T+xKQQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-9k1VFhJSMTWjiH2RiAiY_A-1; Tue,
 15 Jul 2025 02:33:07 -0400
X-MC-Unique: 9k1VFhJSMTWjiH2RiAiY_A-1
X-Mimecast-MFC-AGG-ID: 9k1VFhJSMTWjiH2RiAiY_A_1752561186
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B33419560A1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 06:33:06 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 111DC18002B5; Tue, 15 Jul 2025 06:33:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 00/13] Ui patches
Date: Tue, 15 Jul 2025 10:32:46 +0400
Message-ID: <20250715063301.145191-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to df892b3954e5b2782165e6c59e5ffd55c2f7ec5a:

  tpm: "qemu -tpmdev help" should return success (2025-07-15 10:22:33 +0400)

----------------------------------------------------------------
UI-related for 10.1

- [PATCH v3 0/2] ui/vnc: Do not copy z_stream
- [PATCH v6 0/7] ui/spice: Enable gl=on option for non-local or remote clients
- [PATCH v6 0/1] Allow injection of virtio-gpu EDID name
- [PATCH 0/2] ui/gtk: Add keep-aspect-ratio and scale option

----------------------------------------------------------------

Akihiko Odaki (2):
  ui/vnc: Do not copy z_stream
  ui/vnc: Introduce the VncWorker type

Andrew Keesler (1):
  hw/display: Allow injection of virtio-gpu EDID name

Marc-André Lureau (1):
  tpm: "qemu -tpmdev help" should return success

Vivek Kasireddy (7):
  ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
  ui/spice: Enable gl=on option for non-local or remote clients
  ui/spice: Add an option for users to provide a preferred video codec
  ui/spice: Add an option to submit gl_draw requests at fixed rate
  ui/console-gl: Add a helper to create a texture with linear memory
    layout
  ui/spice: Create a new texture with linear layout when gl=on is
    specified
  ui/spice: Blit the scanout texture if its memory layout is not linear

Weifeng Liu (2):
  ui/gtk: Add keep-aspect-ratio option
  ui/gtk: Add scale option

 qapi/ui.json                        |  15 +-
 qapi/virtio.json                    |  18 +-
 include/hw/display/edid.h           |   2 +
 include/hw/qdev-properties-system.h |   5 +
 include/hw/virtio/virtio-gpu.h      |   3 +
 include/ui/console.h                |   3 +
 include/ui/gtk.h                    |   2 +
 include/ui/spice-display.h          |   5 +
 include/ui/surface.h                |   1 +
 ui/vnc.h                            |  49 +--
 hw/core/qdev-properties-system.c    |  44 +++
 hw/display/virtio-gpu-base.c        |  27 ++
 system/tpm.c                        |   5 +-
 ui/console-gl.c                     |  54 ++++
 ui/egl-helpers.c                    |   6 +
 ui/gtk.c                            |  58 ++--
 ui/spice-core.c                     |  32 ++
 ui/spice-display.c                  | 226 +++++++++++++-
 ui/vnc-enc-tight.c                  | 456 +++++++++++++++-------------
 ui/vnc-enc-zlib.c                   |  47 +--
 ui/vnc-enc-zrle.c                   | 122 ++++----
 ui/vnc-jobs.c                       |  13 +-
 ui/vnc.c                            |  83 +++--
 ui/vnc-enc-zrle.c.inc               |  20 +-
 qemu-options.hx                     |  13 +
 25 files changed, 883 insertions(+), 426 deletions(-)

-- 
2.50.0


