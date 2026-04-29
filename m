Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017E5FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC44-0003Sh-9g; Wed, 29 Apr 2026 17:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC40-0003SL-Fm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC3y-0003Be-Gz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r3oSa83zjymYTA4wJzHr5ynKYatofS4KaV1vQrVllEs=;
 b=bElJo/xj+mlchTgHUwLDhq8nF1kQh9B39NPOxkJyYC9BshkJlXJqqtFvCQRm238XyCjmWe
 Qt9/DerdTGrJqfS0daXQ3o763Qy/nZ7+6uFWQDesmvWJiUCxDOwtOvPuIM1e5xGv6gPRHA
 GePoDe1yl7qyf25YA4m5jSGJi4iWZRg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-H9sj_JB2MSy5OBqoeyZezQ-1; Wed,
 29 Apr 2026 17:03:15 -0400
X-MC-Unique: H9sj_JB2MSy5OBqoeyZezQ-1
X-Mimecast-MFC-AGG-ID: H9sj_JB2MSy5OBqoeyZezQ_1777496594
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F355195609F; Wed, 29 Apr 2026 21:03:14 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDD0A1800480; Wed, 29 Apr 2026 21:03:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/26] ui: add standalone VNC server over D-Bus
Date: Thu, 30 Apr 2026 01:02:33 +0400
Message-Id: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMyw7CIBBFf6VhLQaGOqgr/8O4aGGwLPoQKtE0/
 XdpE1Ndnpt7zsQiBU+RnYuJBUo++r7LoHYFM03V3Yl7m5mBABRKAn9Q++SpM/yECM4cNAACy/c
 hkPOvNXW9ZW58HPvwXstJLus3ordIklzw8ki1tMbpWuMlkG2qcW/6li2VBJtZSvFjQjZByVKi0
 2iN+jPnef4AjHFfUtsAAAA=
X-Change-ID: 20260312-qemu-vnc-9662fc572262
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9597;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XZccesYayirKxP1kNjWgcUVsDNcyuofaX912irk6JjI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIL1XvkeyA7xTCecy1qeGUcPYrYnT/S6QeZ5
 c9tpsXoHSWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5VAwD/9WTvCWgVaVcgxmX1HN809EqalZyl27DR56OgWr0NYJq+Yz/dPQKHRoDKFzL8e7oSJoSBt
 /DkaegPnP+nx8ZODr+u0q5+IjTcdN3JBoNpvgjvkb19n5lwdzJWNESv/jTXsTPPi5st9IM39sgb
 bSCRRqrUsjW5OZ9HasVo7zskgHV/3fP/MVLC61uRUDz8wtDbWs97s5ohnKfugAtq0C4MTDRzyKI
 AIZAXOFPZEJf0FcK9tRvBt5f+f6IItc6u/fRwVSs8KjNObhLvyutc7kChGdvM2J87mXi02oodyd
 r8uw6PGlLByXKJGhbj6uqfnPvZnDRd3qzxQ1Hy2MxG4O93F4BlMGeNAe+BChDchdfCThhAG3exG
 lnyjeFs/+H9A+fczKpMBZQnG30IPAfMVfRSjwfZNRjuEely2L8PEAWSNlzOYAAogAHL4Gdo+B+5
 TsUuzkILuHCmcBKfTDvWc6gNzPEaL7e5Thpjc1T/x9Bbzqv1vKDBmZvMFTxMr8RtqqC1cnhNW5N
 fTOdDoFjhl4s2xV1zI2WSAQQ9hTsu+vooBWHEhYdBQHgyJDOgIg/iq0vbt496N3pNIOUfgWgErk
 1UmUs4qp03I0iJdtbpEOYddZLydarqEhxeNzxw7CX5Yud/UdQXEo8C8vJ4lH5QLDZn7cfuR8S8B
 TGSz9fvVjtOoF8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series adds qemu-vnc, a standalone VNC server that connects to a
running QEMU instance via the D-Bus display interface (org.qemu.Display1).
This allows serving a VNC display as a separate process with an independent
lifecycle and privilege domain, without requiring VNC support compiled into
the QEMU system emulator itself.

The bulk of the series is preparatory refactoring:

- Clean up VNC code: merge init/open, fix leaks, simplify error handling
- Extract and clean up VT100 emulation from console-vc into a reusable unit
- Reorganize ui/ code: move DisplaySurface functions, vgafont, datadir
and other pieces into their own files
- Refactor console APIs: rename methods, simplify listener registration,
return completion status from gfx_update
- Extract common ui sources into a static library that can be linked by
both the system emulator and the new standalone binary

The final patch adds contrib/qemu-vnc, built when both VNC and D-Bus
display support are enabled.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v3:
- added "encoding" property to vc chardev, default to cp437 for <=11.0
- keep vnc_queue_new/free()
- added an assert(!vnc_display_find(id)) in vnc_display_new()
- modify vnc_cleanup(), pushing some work in vnc_display_close/free()
- drop "ui/vnc: expose vnc_disconnect_start()" patch
- added Server.AddClient method
- dropped dbus-vmstate patches
- rebased, collect trailer tags
- Link to v2: https://lore.kernel.org/qemu-devel/20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com

Changes in v2:
- renamed utf8_ DFA function/symbols with bh_ (Bjoern Hoehrmann) prefix
- use "QemuVT *vt = &s->vt;" to avoid some code churn
- use size_t for vt100_input()
- replace back compound literal usage for QEMUUIInfo, use variable
- add a preliminary patch to convert vnc_display_init/open() to return bool
- add doc comment for qemu_console_{un}register_listener()
- document GraphicsHwOps.gfx_update better
- add "ui/vnc: make the worker thread per-VncDisplay", and free it on vnc_display_free()
- add "ui/vnc: add vnc_cleanup()"
- add "replace VNC_DEBUG with trace-events"
- qemu-vnc: add sasl & authz support, doc updates
- move qemu-vnc under tools/
- rebased, collect trailer tags
- Link to v1: https://lore.kernel.org/qemu-devel/20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com

---
Marc-André Lureau (26):
      qemu-options.hx: document -chardev vc backend-specific behavior
      char: error out if given unhandled size options
      ui/console: add vc encoding=utf8/cp437 option
      ui/console: default vc encoding to cp437 for machine < 11.1
      ui/dbus: expose vc encoding via D-Bus Chardev.VCEncoding interface
      ui/console-vc: add UTF-8 input decoding with CP437 rendering
      ui/console-vc: move VT100 state machine and output FIFO into QemuVT100
      ui/console-vc: extract vt100_input() from vc_chr_write()
      ui/console-vc: extract vt100_keysym() from qemu_text_console_handle_keysym()
      ui/console-vc: extract vt100_init() and vt100_fini()
      ui/console: remove console_ch_t typedef and console_write_ch()
      ui: move FONT_WIDTH/HEIGHT to vgafont.h
      ui/console-vc: move VT100 emulation into separate unit
      ui/vnc: make the worker thread per-VncDisplay
      ui/vnc: vnc_display_init() and vnc_display_open() return bool
      ui/vnc: merge vnc_display_init() and vnc_display_open()
      ui/vnc: clean up VNC displays on exit
      ui/vnc: defer listener registration until the console is known
      ui/vnc: add vnc-system unit, to allow different implementations
      ui/console: simplify registering display/console change listener
      ui/console: add doc comment for qemu_console_{un}register_listener()
      ui/console: rename public API to use consistent qemu_console_ prefix
      ui/vnc: replace VNC_DEBUG with trace-events
      ui: extract common sources into a static library
      tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
      tools/qemu-vnc: add standalone VNC server over D-Bus

 MAINTAINERS                      |    5 +
 docs/conf.py                     |    3 +
 docs/interop/dbus-display.rst    |    2 +
 docs/interop/dbus-vnc.rst        |   26 +
 docs/interop/index.rst           |    1 +
 docs/meson.build                 |    1 +
 docs/tools/index.rst             |    1 +
 docs/tools/qemu-vnc.rst          |  226 +++++++
 meson.build                      |   17 +
 qapi/char.json                   |   30 +-
 include/chardev/char.h           |   21 +
 include/qemu/option.h            |    1 +
 include/ui/console.h             |  124 ++--
 tools/qemu-vnc/qemu-vnc.h        |   49 ++
 tools/qemu-vnc/trace.h           |    4 +
 ui/console-priv.h                |    1 -
 ui/cp437.h                       |   13 +
 ui/dbus.h                        |    1 +
 ui/vnc-jobs.h                    |    3 +-
 ui/vnc.h                         |   17 +-
 ui/vt100.h                       |   95 +++
 chardev/char.c                   |   22 +
 hw/arm/musicpal.c                |    4 +-
 hw/core/machine.c                |    4 +-
 hw/display/artist.c              |    4 +-
 hw/display/ati.c                 |   16 +-
 hw/display/bcm2835_fb.c          |    5 +-
 hw/display/bochs-display.c       |   14 +-
 hw/display/cg3.c                 |    6 +-
 hw/display/cirrus_vga.c          |    8 +-
 hw/display/cirrus_vga_isa.c      |    2 +-
 hw/display/dm163.c               |    6 +-
 hw/display/exynos4210_fimd.c     |    4 +-
 hw/display/g364fb.c              |   10 +-
 hw/display/jazz_led.c            |   18 +-
 hw/display/macfb.c               |    6 +-
 hw/display/next-fb.c             |    4 +-
 hw/display/omap_lcdc.c           |    4 +-
 hw/display/pl110.c               |    4 +-
 hw/display/qxl-render.c          |   12 +-
 hw/display/qxl.c                 |   18 +-
 hw/display/ramfb-standalone.c    |    2 +-
 hw/display/ramfb.c               |    4 +-
 hw/display/sm501.c               |    6 +-
 hw/display/ssd0303.c             |    4 +-
 hw/display/ssd0323.c             |    5 +-
 hw/display/tcx.c                 |   16 +-
 hw/display/vga-isa.c             |    2 +-
 hw/display/vga-mmio.c            |    2 +-
 hw/display/vga-pci.c             |    6 +-
 hw/display/vga.c                 |   56 +-
 hw/display/vhost-user-gpu.c      |   22 +-
 hw/display/virtio-gpu-base.c     |    4 +-
 hw/display/virtio-gpu-rutabaga.c |   10 +-
 hw/display/virtio-gpu-udmabuf.c  |    4 +-
 hw/display/virtio-gpu-virgl.c    |   20 +-
 hw/display/virtio-gpu.c          |   26 +-
 hw/display/virtio-vga.c          |    4 +-
 hw/display/vmware_vga.c          |   14 +-
 hw/display/xenfb.c               |    6 +-
 hw/display/xlnx_dp.c             |   10 +-
 hw/vfio/display.c                |   32 +-
 system/runstate.c                |    5 +
 tests/qtest/dbus-vmstate-test.c  |    2 -
 tests/qtest/dbus-vnc-test.c      | 1346 ++++++++++++++++++++++++++++++++++++++
 tools/qemu-vnc/audio.c           |  308 +++++++++
 tools/qemu-vnc/chardev.c         |  148 +++++
 tools/qemu-vnc/clipboard.c       |  378 +++++++++++
 tools/qemu-vnc/console.c         |  170 +++++
 tools/qemu-vnc/dbus.c            |  474 ++++++++++++++
 tools/qemu-vnc/display.c         |  456 +++++++++++++
 tools/qemu-vnc/input.c           |  239 +++++++
 tools/qemu-vnc/qemu-vnc.c        |  581 ++++++++++++++++
 tools/qemu-vnc/stubs.c           |   62 ++
 tools/qemu-vnc/utils.c           |   59 ++
 ui/console-vc-stubs.c            |    1 +
 ui/console-vc.c                  | 1074 +++---------------------------
 ui/console.c                     |  173 ++---
 ui/cp437.c                       |  205 ++++++
 ui/curses.c                      |   23 +-
 ui/dbus-chardev.c                |   10 +
 ui/dbus-console.c                |   10 +-
 ui/dbus-listener.c               |   37 +-
 ui/dbus.c                        |   59 ++
 ui/egl-headless.c                |    8 +-
 ui/gtk-egl.c                     |    6 +-
 ui/gtk-gl-area.c                 |    6 +-
 ui/gtk.c                         |   28 +-
 ui/sdl2-2d.c                     |    2 +-
 ui/sdl2-gl.c                     |    2 +-
 ui/sdl2.c                        |   14 +-
 ui/spice-display.c               |   24 +-
 ui/vnc-auth-sasl.c               |   13 +-
 ui/vnc-enc-tight.c               |    4 +-
 ui/vnc-enc-zlib.c                |    4 +-
 ui/vnc-jobs.c                    |   62 +-
 ui/vnc-system.c                  |   19 +
 ui/vnc-ws.c                      |   10 +-
 ui/vnc.c                         |  232 +++----
 ui/vt100.c                       |  984 ++++++++++++++++++++++++++++
 util/qemu-option.c               |   13 +
 hw/display/apple-gfx.m           |   16 +-
 meson_options.txt                |    2 +
 qemu-options.hx                  |   20 +-
 scripts/meson-buildoptions.sh    |    3 +
 tests/dbus-daemon.sh             |   16 +-
 tests/qtest/meson.build          |   13 +
 tools/qemu-vnc/meson.build       |   26 +
 tools/qemu-vnc/qemu-vnc1.xml     |  201 ++++++
 tools/qemu-vnc/trace-events      |   21 +
 ui/cocoa.m                       |   23 +-
 ui/dbus-display1.xml             |   18 +
 ui/meson.build                   |  103 +--
 ui/trace-events                  |   29 +-
 114 files changed, 7113 insertions(+), 1696 deletions(-)
---
base-commit: 282771e1f9b9b6e0147adf5f9d676325175b1767
change-id: 20260312-qemu-vnc-9662fc572262

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


