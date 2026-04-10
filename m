Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB238F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHNi-0002FX-Az; Fri, 10 Apr 2026 15:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNg-0002Ey-2L
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHNc-0000L3-BV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qJqeKQIvI1wzoS4nC5CVuB9LnRSqFcvxOzeX5n0xkHU=;
 b=ZXuKmiYpRwDN1b30opi+Wmktv/QMGurBilBGiGvivvRtGmjhk271YaosEYtz/tQkXTFt3W
 PqKhBB/28fggUvysprulb22RnHk0wJwFF6OpPPlGyHDELtd/ToSKTgqBXRfrhtBofWGMFf
 Lq7jfJvfenYFGS06g707Cd446x+5oq0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-bdBxSP5oO3uF6XrYJ7P_xw-1; Fri,
 10 Apr 2026 15:18:54 -0400
X-MC-Unique: bdBxSP5oO3uF6XrYJ7P_xw-1
X-Mimecast-MFC-AGG-ID: bdBxSP5oO3uF6XrYJ7P_xw_1775848734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD0951956054; Fri, 10 Apr 2026 19:18:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DAFF1800B7F; Fri, 10 Apr 2026 19:18:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/67] ui: add standalone VNC server over D-Bus
Date: Fri, 10 Apr 2026 23:18:22 +0400
Message-Id: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMQQ7CIBCF4as0sxYDo4K68h6mixYGYVFQqETTc
 HexiXH5v7x8C2RKnjKcuwUSFZ99DC1w04F2Q7gR86Y1IEfJdwLZg6YnK0Gzk5Ro9UEhSoR2vye
 y/rVS176183mO6b3KRXzXH6L+SBGMs/2RRmG0VaOSl0TGDfNWxwn6WusHHQrTlaEAAAA=
X-Change-ID: 20260312-qemu-vnc-9662fc572262
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabrice Bellard <fabrice@bellard.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13280;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0QvD4qt5z80S9jrNnycG6omPcKwKnuS1t50FGprv6a4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0SZ4WPEvgn8TJHBeBhtIGhPMq6ZXn/XlHAQ
 jXfAhmJPYCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEgAKCRDa6OEJdZac
 5e2pD/9KeKivluV0NKdCnilKe5d9uwhKmDq5c5UADh15YQqB2amFM87MKFpw2x8M7NyV/ClzY0C
 4igUp6fzG6eW6LVgoAss9nGNTkAh88CtRIfqqDpobDxTKcHzlBTIWrO6IhnhSPXdsrMJXUF3mqI
 /eikpmvUSzXdga43jFnPeRhA4dQyzNnP9cOafYRUr7sc9Nn3HsoXSzAJ7Ozo2USTEyTEAqPudzL
 1ObzeJJChf5/Xh967fa550WUjjPpwLf2P5Zarw8jEY7tZ8f9aU44Racay5eljwpi4JK56GajAoP
 VeRpoQfqyPeIa2XkJaYCqh/zRTge2gV/AHhy/tyo5ELm1fRZ2kDHemGpvhOuUSxSpXiDUXxkbbZ
 bDNyvANxvSeWiTbQok+EQAquwTSA2H4B3J8KgNmwlTmTglV+OabTXHsflZZe+AMnUZ/dLRm1Sh7
 r++u/1E3juGHAsasYrLtYkZsdQX/48z+wp+qheE4euYh2vtxCRehtFlpOoKgH/s/Mgd0CcnN4tQ
 5cxUimKX5awZAMJbv+C3Jb93GE7cJJDS0tPrr0G85GSLjWZMngX3cGXJ58Vl35DLA/x4iSI6I7p
 lhovC6tgdyNfUhJJ01ZhD9wEq+d+oWY61yTWkqeEJh0518cc6+YhKLuZ34W65XcPzQMWn/JClgi
 SeZTZMe4YRx3aGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Marc-André Lureau (67):
      ui/vnc-jobs: remove needless buffer_reset() before end
      ui/vnc: clarify intent using buffer_empty() function
      ui/vnc-jobs: vnc_has_job_locked() argument cannot be NULL
      ui/vnc-jobs: remove dead VncJobQueue.exit
      ui/vnc-jobs: remove vnc_queue_clear()
      ui/vnc-jobs: narrow taking the queue lock
      ui/vnc-jobs: drop redundant (and needless) qemu_thread_get_self()
      ui/console-vc: fix off-by-one in CSI J 2 (clear entire screen)
      ui/console-vc: add UTF-8 input decoding with CP437 rendering
      ui/console-vc: ignore string-type escape sequences
      ui/console-vc: fix comment shift-out/in comments
      ui/console: dispatch get_label() through QOM virtual method
      ui/console-vc: introduce QemuVT100
      ui/console-vc: set vt100 associated pixman image
      ui/console-vc: vga_putcharxy()->vt100_putcharxy()
      ui/console-vc: make invalidate_xy() take vt100
      ui/console-vc: make show_cursor() take vt100
      ui/console-vc: decouple VT100 display updates via function pointer
      ui/console-vc: console_refresh() -> vt100_refresh()
      ui/console-vc: move cursor blinking logic into VT100 layer
      ui/console-vc: console_scroll() -> vt100_scroll()
      ui/console-vc: refactor text_console_resize() into vt100_set_image()
      ui/console-vc: move vc_put_lf() to VT100 layer as vt100_put_lf()
      ui/console-vc: unify the write path
      ui/console-vc: move VT100 state machine and output FIFO into QemuVT100
      ui/console-vc: extract vt100_input() from vc_chr_write()
      ui/console-vc: extract vt100_keysym() from qemu_text_console_handle_keysym()
      ui/console-vc: extract vt100_init() and vt100_fini()
      ui/console: remove console_ch_t typedef and console_write_ch()
      ui: avoid duplicating vgafont16 in each translation unit
      ui/vgafont: add SPDX license header
      ui: move FONT_WIDTH/HEIGHT to vgafont.h
      ui/console-vc: move VT100 emulation into separate unit
      util: move datadir.c from system/
      ui: move DisplaySurface functions to display-surface.c
      ui: make qemu_default_pixelformat() static inline
      ui: make unregister_displaychangelistener() skip unregistered
      ui: minor code simplification
      system: make qemu_del_vm_change_state_handler accept NULL
      ui/vnc: assert preconditions instead of silently returning
      ui/vnc: simplify vnc_init_func error handling
      ui/vnc: VncDisplay.id is not const
      ui/keymaps: introduce kbd_layout_free()
      ui/vnc: fix vnc_display_init() leak on failure
      ui/vnc: make vnc_disconnect_finish() private
      ui/vnc: make the worker thread per-VncDisplay
      ui/vnc: vnc_display_init() and vnc_display_open() return bool
      ui/vnc: merge vnc_display_init() and vnc_display_open()
      ui/vnc: add vnc_cleanup()
      ui/vnc: report an error for duplicate display id
      ui/vnc: defer listener registration until the console is known
      ui/vnc: expose vnc_disconnect_start()
      ui/vnc: remove left-over dead code
      ui/vnc: explicitly link with png
      ui/vnc: add vnc-system unit, to allow different implementations
      ui/console: remove qemu_console_is_visible()
      ui/console: simplify registering display/console change listener
      ui/console: add doc comment for qemu_console_{un}register_listener()
      ui/console: return completion status from gfx_update callback
      ui/console: rename public API to use consistent qemu_console_ prefix
      ui/console: move console_handle_touch_event() to input
      ui/vnc: replace VNC_DEBUG with trace-events
      ui: extract common sources into a static library
      tests: rename the dbus-daemon helper script
      tests/qtest: fix dbus-vmstate-test compilation
      tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
      tools/qemu-vnc: add standalone VNC server over D-Bus

 MAINTAINERS                                      |    5 +
 docs/conf.py                                     |    3 +
 docs/interop/dbus-display.rst                    |    2 +
 docs/interop/dbus-vnc.rst                        |   26 +
 docs/interop/index.rst                           |    1 +
 docs/meson.build                                 |    1 +
 docs/tools/index.rst                             |    1 +
 docs/tools/qemu-vnc.rst                          |  222 ++
 meson.build                                      |   17 +
 hw/display/qxl.h                                 |    2 +-
 include/ui/console.h                             |  153 +-
 include/ui/input.h                               |   15 +
 include/ui/qemu-pixman.h                         |    8 +
 include/ui/surface.h                             |    2 -
 tools/qemu-vnc/qemu-vnc.h                        |   46 +
 tools/qemu-vnc/trace.h                           |    4 +
 ui/console-priv.h                                |    8 -
 ui/cp437.h                                       |   13 +
 ui/keymaps.h                                     |    1 +
 ui/vgafont.h                                     | 4618 +---------------------
 ui/vnc-jobs.h                                    |    3 +-
 ui/vnc.h                                         |   22 +-
 ui/vt100.h                                       |   92 +
 hw/arm/musicpal.c                                |    7 +-
 hw/display/artist.c                              |    8 +-
 hw/display/ati.c                                 |   16 +-
 hw/display/bcm2835_fb.c                          |   12 +-
 hw/display/bochs-display.c                       |   20 +-
 hw/display/cg3.c                                 |   11 +-
 hw/display/cirrus_vga.c                          |    8 +-
 hw/display/cirrus_vga_isa.c                      |    2 +-
 hw/display/dm163.c                               |   10 +-
 hw/display/exynos4210_fimd.c                     |   10 +-
 hw/display/g364fb.c                              |   19 +-
 hw/display/jazz_led.c                            |   24 +-
 hw/display/macfb.c                               |   12 +-
 hw/display/next-fb.c                             |    8 +-
 hw/display/omap_lcdc.c                           |   18 +-
 hw/display/pl110.c                               |    9 +-
 hw/display/qxl-render.c                          |   18 +-
 hw/display/qxl.c                                 |   25 +-
 hw/display/ramfb-standalone.c                    |    6 +-
 hw/display/ramfb.c                               |    4 +-
 hw/display/sm501.c                               |   14 +-
 hw/display/ssd0303.c                             |   14 +-
 hw/display/ssd0323.c                             |   16 +-
 hw/display/tcx.c                                 |   22 +-
 hw/display/vga-isa.c                             |    2 +-
 hw/display/vga-mmio.c                            |    2 +-
 hw/display/vga-pci.c                             |    6 +-
 hw/display/vga.c                                 |   60 +-
 hw/display/vhost-user-gpu.c                      |   22 +-
 hw/display/virtio-gpu-base.c                     |    7 +-
 hw/display/virtio-gpu-rutabaga.c                 |   10 +-
 hw/display/virtio-gpu-udmabuf.c                  |    4 +-
 hw/display/virtio-gpu-virgl.c                    |   20 +-
 hw/display/virtio-gpu.c                          |   26 +-
 hw/display/virtio-vga.c                          |   10 +-
 hw/display/vmware_vga.c                          |   21 +-
 hw/display/xenfb.c                               |   12 +-
 hw/display/xlnx_dp.c                             |   20 +-
 hw/vfio/display.c                                |   49 +-
 system/runstate.c                                |    8 +
 tests/qtest/dbus-vmstate-test.c                  |   13 +-
 tests/qtest/dbus-vnc-test.c                      | 1342 +++++++
 tools/qemu-vnc/audio.c                           |  307 ++
 tools/qemu-vnc/chardev.c                         |  127 +
 tools/qemu-vnc/clipboard.c                       |  378 ++
 tools/qemu-vnc/console.c                         |  168 +
 tools/qemu-vnc/dbus.c                            |  439 ++
 tools/qemu-vnc/display.c                         |  456 +++
 tools/qemu-vnc/input.c                           |  239 ++
 tools/qemu-vnc/qemu-vnc.c                        |  491 +++
 tools/qemu-vnc/stubs.c                           |   62 +
 tools/qemu-vnc/utils.c                           |   59 +
 ui/console-vc-stubs.c                            |    9 +-
 ui/console-vc.c                                  | 1021 +----
 ui/console.c                                     |  491 +--
 ui/cp437.c                                       |  205 +
 ui/curses.c                                      |   23 +-
 ui/dbus-console.c                                |   16 +-
 ui/dbus-listener.c                               |   37 +-
 ui/display-surface.c                             |  107 +
 ui/egl-headless.c                                |    8 +-
 ui/gtk-egl.c                                     |    6 +-
 ui/gtk-gl-area.c                                 |    6 +-
 ui/gtk.c                                         |   36 +-
 ui/input.c                                       |   65 +
 ui/keymaps.c                                     |   13 +-
 ui/sdl2-2d.c                                     |    2 +-
 ui/sdl2-gl.c                                     |    2 +-
 ui/sdl2.c                                        |   22 +-
 ui/spice-display.c                               |   24 +-
 ui/vgafont.c                                     | 4616 +++++++++++++++++++++
 ui/vnc-auth-sasl.c                               |   13 +-
 ui/vnc-enc-tight.c                               |    4 +-
 ui/vnc-enc-zlib.c                                |    4 +-
 ui/vnc-jobs.c                                    |  112 +-
 ui/vnc-system.c                                  |   19 +
 ui/vnc-ws.c                                      |   10 +-
 ui/vnc.c                                         |  291 +-
 ui/vt100.c                                       |  986 +++++
 {system => util}/datadir.c                       |    0
 hw/display/apple-gfx.m                           |   26 +-
 meson_options.txt                                |    2 +
 scripts/meson-buildoptions.sh                    |    3 +
 system/meson.build                               |    1 -
 system/trace-events                              |    1 -
 tests/{dbus-vmstate-daemon.sh => dbus-daemon.sh} |   16 +-
 tests/qtest/meson.build                          |   18 +-
 tools/qemu-vnc/meson.build                       |   26 +
 tools/qemu-vnc/qemu-vnc1.xml                     |  174 +
 tools/qemu-vnc/trace-events                      |   20 +
 ui/cocoa.m                                       |   23 +-
 ui/meson.build                                   |  103 +-
 ui/trace-events                                  |   29 +-
 util/meson.build                                 |    1 +
 util/trace-events                                |    3 +
 118 files changed, 11819 insertions(+), 6713 deletions(-)
---
base-commit: becd22fdc2a071783d9e04421526633772b3b98c
change-id: 20260312-qemu-vnc-9662fc572262

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


