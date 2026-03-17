Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC21BF3381A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q8k-0005Vk-1y; Tue, 17 Mar 2026 04:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8Y-0005V3-MX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q8V-0002cx-4h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BCbvtbnEEi/St6boDobHTUWe6tDNAnNkugf+ym5iUXI=;
 b=KowqWPApl8a+g1PDzS3HdX5qfc/HBWVRgQzgZ/XgOPrBb5OSP7Zmb9Y/ezGReaiW/miBp1
 NgPbKWHdTaCNvkHYvKTrY1rf2nY/RVDQlAZ4PIrjA5u8FK1PhtYVuSPJoBk4FZXDNGIBRD
 VBK8xaGMXWUxRM74tIN52ibgFQq75Cc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-qCHL-pUHPHK4OiZwZpi1tA-1; Tue,
 17 Mar 2026 04:50:43 -0400
X-MC-Unique: qCHL-pUHPHK4OiZwZpi1tA-1
X-Mimecast-MFC-AGG-ID: qCHL-pUHPHK4OiZwZpi1tA_1773737442
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49122195608C
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:50:42 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4996F180075C
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:50:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/60] ui: add standalone VNC server over D-Bus
Date: Tue, 17 Mar 2026 12:50:14 +0400
Message-Id: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mj3cLU3FLdsrxkXUszM6O0ZFNzIyMzIyWg8oKi1LTMCrBR0bG1tQB
 /iidOWgAAAA==
X-Change-ID: 20260312-qemu-vnc-9662fc572262
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=11742;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6V0aWUOLFW2Qlyet0m6kHjKPJQ5oOJTAY/wR0Pb/emk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXZu+bFFBEfw3VotKv8wOzG3EK+C6SWARwgx
 d5W5sbW69eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2QAKCRDa6OEJdZac
 5dwVD/sG3/ahmxhXcMA+bonSVXxskNOpyB2RrtJcERirA4NpQGO19HvsbtK04+4/TJlAMw50din
 9spf4HmdgNf0EkIQxAs9SsUqNNIpU03k4s8VLhwBTD9HTM/H1ETqotTdTWfLUe8ETmJBMIoGFc9
 Mmmx/l82UiikBakD10tvXAaozx/by/tYM8aD7OXhyb8kluYxhVZqhCb1/Z7LE+Ukek3CuO9VvvQ
 lcIcUyODI+5/lFP9UOl079cuKUHLRZlF+q/xhSD+16H2BUGxEfsjoiQYHBDi+l7PJRGAcWmx+7P
 mxWennaEMOkhrH/Mz0S8ugKwCSxgY/+p4w7kojXx/e8Zi95NYQAN+MZNxq3eHu3B3RnbikLNfYv
 AWUFgUNRUAWTB7hl6CDY5t3qR7pHDnclWA5Niqjqob6q2aucxOYvMVUWNEaqdNdpjuD+HeHk3Io
 tOFSrSbeXmu8r2BPLtKdObW3rNfpxWTgFgI3exnI3t6NwIWCChhnpzrCZn0tawNxomNYAuQrqy/
 CI4DPcsxM7rUiXpxWkaCLmuJwaGrk0DmJ2VAL67RwSySJdihpy/X6sy/hcyC/2K5GRqOcX+Ip9t
 o3yv4L6MlCV0MZHir3b0mBrYYaZUPYFrqDgwG3GyB3PCDTWjnAOyCZ5fJnY1pOOp0uG+mUHXinb
 zIWEiiJDFz1HkBQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
Marc-André Lureau (60):
      ui/vnc-jobs: fix VncRectEntry leak on job cleanup
      ui/vnc-jobs: clear source tag
      ui/vnc-jobs: remove needless buffer_reset() before end
      ui/vnc: clarify intent using buffer_empty() function
      ui/vnc-jobs: vnc_has_job_locked() argument cannot be NULL
      ui/vnc-jobs: remove dead VncJobQueue.exit
      ui/vnc-jobs: remove vnc_queue_clear()
      ui/vnc-jobs: narrow taking the lock when pushing empty jobs
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
      ui/vnc: fix vnc_display_init() leak on failure
      ui/vnc: merge vnc_display_init() and vnc_display_open()
      ui/vnc: report an error for duplicate display id
      ui/vnc: defer listener registration until the console is known
      ui/vnc: explicitly link with png
      ui/vnc: add vnc-system unit, to allow different implementations
      ui/console: remove qemu_console_is_visible()
      ui/console: simplify registering display/console change listener
      ui/console: return completion status from gfx_update callback
      ui/console: rename public API to use consistent qemu_console_ prefix
      ui/console: move console_handle_touch_event() to input
      ui: extract common sources into a static library
      tests: rename the dbus-daemon helper script
      tests/qtest: fix dbus-vmstate-test compilation
      tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
      contrib/qemu-vnc: add standalone VNC server over D-Bus

 MAINTAINERS                                      |    5 +
 docs/conf.py                                     |    3 +
 docs/interop/dbus-display.rst                    |    2 +
 docs/interop/dbus-vnc.rst                        |   26 +
 docs/interop/index.rst                           |    1 +
 docs/meson.build                                 |    1 +
 docs/tools/index.rst                             |    1 +
 docs/tools/qemu-vnc.rst                          |  199 +
 meson.build                                      |   17 +
 contrib/qemu-vnc/qemu-vnc.h                      |   46 +
 contrib/qemu-vnc/trace.h                         |    4 +
 hw/display/qxl.h                                 |    2 +-
 include/ui/console.h                             |  146 +-
 include/ui/input.h                               |   15 +
 include/ui/qemu-pixman.h                         |    8 +
 include/ui/surface.h                             |    2 -
 ui/console-priv.h                                |    8 -
 ui/cp437.h                                       |   13 +
 ui/keymaps.h                                     |    1 +
 ui/vgafont.h                                     | 4618 +---------------------
 ui/vnc.h                                         |    9 +-
 ui/vt100.h                                       |   92 +
 contrib/qemu-vnc/audio.c                         |  307 ++
 contrib/qemu-vnc/chardev.c                       |  127 +
 contrib/qemu-vnc/clipboard.c                     |  378 ++
 contrib/qemu-vnc/console.c                       |  168 +
 contrib/qemu-vnc/dbus.c                          |  439 ++
 contrib/qemu-vnc/display.c                       |  456 +++
 contrib/qemu-vnc/input.c                         |  239 ++
 contrib/qemu-vnc/qemu-vnc.c                      |  450 +++
 contrib/qemu-vnc/stubs.c                         |   66 +
 contrib/qemu-vnc/utils.c                         |   59 +
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
 system/runstate.c                                |    3 +
 tests/qtest/dbus-vmstate-test.c                  |   13 +-
 tests/qtest/dbus-vnc-test.c                      |  733 ++++
 ui/console-vc-stubs.c                            |    9 +-
 ui/console-vc.c                                  | 1021 +----
 ui/console.c                                     |  471 +--
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
 ui/sdl2.c                                        |   24 +-
 ui/spice-display.c                               |   24 +-
 ui/vgafont.c                                     | 4616 +++++++++++++++++++++
 ui/vnc-jobs.c                                    |   54 +-
 ui/vnc-system.c                                  |   19 +
 ui/vnc.c                                         |  202 +-
 ui/vt100.c                                       |  987 +++++
 {system => util}/datadir.c                       |    0
 contrib/qemu-vnc/meson.build                     |   26 +
 contrib/qemu-vnc/qemu-vnc1.xml                   |  174 +
 contrib/qemu-vnc/trace-events                    |   20 +
 hw/display/apple-gfx.m                           |   26 +-
 meson_options.txt                                |    2 +
 scripts/meson-buildoptions.sh                    |    3 +
 system/meson.build                               |    1 -
 system/trace-events                              |    1 -
 tests/{dbus-vmstate-daemon.sh => dbus-daemon.sh} |   16 +-
 tests/qtest/meson.build                          |   13 +-
 ui/cocoa.m                                       |   23 +-
 ui/meson.build                                   |  103 +-
 util/meson.build                                 |    1 +
 util/trace-events                                |    3 +
 112 files changed, 10982 insertions(+), 6624 deletions(-)
---
base-commit: 559919ce54927d59b215a4665eda7ab6118a48aa
change-id: 20260312-qemu-vnc-9662fc572262

Best regards,
-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


