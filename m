Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D0CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 10:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLfFn-0001JL-Np; Sat, 09 May 2026 06:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wLfFm-0001D2-5A
 for qemu-devel@nongnu.org; Sat, 09 May 2026 06:49:50 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wLfFj-0002AF-4L
 for qemu-devel@nongnu.org; Sat, 09 May 2026 06:49:49 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso3082231eec.0
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 03:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778323783; cv=none;
 d=google.com; s=arc-20240605;
 b=Rl37OfM1Fx36fdfWcCLjjZ3Ac4M5CT7G+wkNH7yCK4CFzJ0TxS4Ne0+r0qwhETVg05
 +/Tl+oDfw00mAVb10u7qDFE0ncdYUr6YX9CDRkZTZnnqhFCm0lufgHNu6AZq5Edc1ck1
 8b4cpRE5vJSsJSZEofvO/aMjZEzSj9yDXDgMZkNDOzIdN1l1LQHdGYiAA2X0XYCGyUy3
 CljFSUZD6lQfInj3ncAY16hho41SnA1T0vNlDyJMSTUSC88rTi1LnX1AQxMaqGerNOgh
 UGBI1pzdXno48VG5piROI2QAwsH1Stbhf9fkEMF3vyty5f/6dYbeaT6RyOEKJvj/Qgrh
 Tl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pq638OI+DXKlxXFMZIBg28ksmYD0pDo9fs+ZkSsscX4=;
 fh=wVlDHPGR3Oxtm+P+HOr2DAF6mU9TAJqWiJExyRG2TB8=;
 b=TYB+0Sx6dF/9zKy0x/bk/soDknPRKwKAWX0SJeq4QKNKOtZdCvgeMF/pHDeHwomy4m
 uirTprtz2UVLZaZEDZMDRmiIvJj3zTkNL+U6NPbzE0HdDm9bG9ep5NZ4qrJEIGzH46Hr
 QHGUHAMYr7O3v5IR4Mm63/qbGxq0hGxYnFLhDusEiyDYf5wbxbVa98XGN7LhHYteX9Xi
 BYr1tFgjPF3MJxw+BhFoUxWqDZ/Bw8Mj8YYsTZAL8WG+UTmyes17ysgHkdBHCv6zGpoQ
 rZUVtO31l6fYsl7sz/VPXNgRQIeSfjn5C+q8tLD4+zs4XF+VeqwpRlYp7dRjK2nk7liE
 x1+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778323783; x=1778928583; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pq638OI+DXKlxXFMZIBg28ksmYD0pDo9fs+ZkSsscX4=;
 b=lIypoHsb5bsk3e6sEQmxp+OuBCMMfygTGqiB23gAV89Exv4R1juMrmnmXXi7RMFbRv
 F5G+3qnBaCtUEMdxKZxacODbFR+nvoZTwIuZO4Lb8XWoDHieHelhVMm1TI09urSDdKRq
 2OD279O+9sCuICuCySte6MkKHhshAOGgRDvIeVYerj9G4HtsD5LQg/2gwJgHY4rKOrZb
 zPCoJ7BT+8tBIzpNXz1riRo0H6VDODw/R749qKbXORwRwQukRy7cF3QSc1lO9BtOxdRQ
 QWiYUJpKYlxuZ3FeHTktj1w2QhccZ21UnQz9fVQF7it71x5kZJupTnyz8kaenjtnWItv
 wfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778323783; x=1778928583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq638OI+DXKlxXFMZIBg28ksmYD0pDo9fs+ZkSsscX4=;
 b=nQ7dhT6tgjM70EH5buis5VI050ZnrGsytb+eX4JqHKLjxHEn/GPiIToCjUw5oWBSg0
 34UHY698zjhaXIPFzSxn0FXJRhHLSnVsxLPmXhj1NSgswzU6KzqyyLdwmeG9MHZQLAY/
 C/HhNUZ5M3F6UOHq9GUOUplPZxfnsvGv9qjrFakvIWA8f+ACd6LGgVnNFQ+tVztWcjLl
 +V5o+F9nDZEpzWIeqARybMqECj/dxjy+m77CrpBuc/ac2/hIISxB/TDL/bJy7P2LyuIv
 ZLEoc2uPEHxycn0b1QevXvQsvN9lG/FPo0ppvz98c6hbpQF84X+jW4jOFaEJmBMta7Bp
 VxJw==
X-Gm-Message-State: AOJu0YxN6LULts5jejI0xzuNRC2lC+ms0sKPcMr8CdWYNBhItF5KWcZz
 kLIjjqWEzwyAJIFV4mzi7sB0iwqv+kdq7GrV+5esUfyjyRAX6dcKcNUs6ogRNUxG/clvLg9Cs8t
 5m5phaML/O50ixSBCU70eo74R1KYs+Tk1KFw/
X-Gm-Gg: Acq92OGe/gEMiV4aMJrCTmr+qDdQDneLMuXDjX24h6MSt/InpuabzOrba5KX/VxZI0j
 /K0Lef+EygTkYlzfz7RngW7QKLDGAmnYyhsFj6N7hGIvI1LnRdxy7x3dyrT2ugT7rzO8MwySGUJ
 3oI0Dzmd1fI+x5oaQw6XvWaT3aCl7QZ/v5YRHnBDdBzM2lShwk65hYxLvkLo4PUPXe20JIeTT4U
 5EMrmfnCPXPyvV93BnVREfCk/OIpSlclFQOgxbXwB66h7R+DMPlPUgfiV6f5LQtCAzml2+gFtnr
 39Bk9K/WlcOhpfv+VA==
X-Received: by 2002:a05:7300:6da5:b0:2b7:38cf:c2fd with SMTP id
 5a478bee46e88-2f54ae739a4mr7873675eec.26.1778323782904; Sat, 09 May 2026
 03:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 9 May 2026 14:49:32 +0400
X-Gm-Features: AVHnY4Jq89sxtIXNFBUC31jZmMT3_RqQXqBKhWgm36IQ7wSWGEFm4OarT7246ok
Message-ID: <CAJ+F1CJ4WadN6L0Ue_BerXaAaGuYG24Ri38BqHtNPCY3eJWAYw@mail.gmail.com>
Subject: Re: [PULL 00/32] UI patches
To: QEMU <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006030140651604577"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 MIME_BOUND_DIGITS_15=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000006030140651604577
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nack, I need to fix up the rebase..

Marc-Andr=C3=A9 Lureau

Le sam. 9 mai 2026, 11:37, <marcandre.lureau@redhat.com> a =C3=A9crit :

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit
> ee7eb612be8f8886d48c1d0c1f1c65e495138f83:
>
>   Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu
> into staging (2026-05-06 10:45:02 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to c1c9e7f20c33307b5662a4cc753d5651968eeb3b:
>
>   tools/qemu-vnc: add standalone VNC server over D-Bus (2026-05-09
> 10:25:50 +0400)
>
> ----------------------------------------------------------------
> - gtk clipboard fixes
> - dbus-vmstate test fixes
> - vt100 emulator support for utf8
> - qemu-vnc tool
>
> ----------------------------------------------------------------
>
> Fabiano Rosas (5):
>   tests/qtest/dbus-vmstate: Bring the test up-to-date
>   tests/qtest/dbus-vmstate: Mute Glib complaints about g_unsetenv
>     thread-safety
>   tests/qtest/dbus-vmstate: Honor QTEST_LOG env variable
>   tests/qtest/dbus-vmstate: Stop the daemons explicitly
>   tests/qtest/dbus-vmstate: Re-enable the test
>
> Jind=C5=99ich Makovi=C4=8Dka (1):
>   ui/gtk: Fix GTK assertion failure introduced with clipboard fixes
>
> Marc-Andr=C3=A9 Lureau (26):
>   ui/input: do not assert() when tracing invalid input
>   qemu-options.hx: document -chardev vc backend-specific behavior
>   char: error out if given unhandled size options
>   ui/console: add vc encoding=3Dutf8/cp437 option
>   ui/console: default vc encoding to cp437 for machine < 11.1
>   ui/dbus: expose vc encoding via D-Bus Chardev.VCEncoding interface
>   ui/console-vc: add UTF-8 input decoding with CP437 rendering
>   ui/console-vc: move VT100 state machine and output FIFO into QemuVT100
>   ui/console-vc: extract vt100_input() from vc_chr_write()
>   ui/console-vc: extract vt100_keysym() from
>     qemu_text_console_handle_keysym()
>   ui/console-vc: extract vt100_init() and vt100_fini()
>   ui/console: remove console_ch_t typedef and console_write_ch()
>   ui/console-vc: move VT100 emulation into separate unit
>   ui/vnc: make the worker thread per-VncDisplay
>   ui/vnc: vnc_display_init() and vnc_display_open() return bool
>   ui/vnc: merge vnc_display_init() and vnc_display_open()
>   ui/vnc: clean up VNC displays on exit
>   ui/vnc: defer listener registration until the console is known
>   ui/vnc: add vnc-system unit, to allow different implementations
>   ui/console: simplify registering display/console change listener
>   ui/console: add doc comment for qemu_console_{un}register_listener()
>   ui/console: rename public API to use consistent qemu_console_ prefix
>   ui/vnc: replace VNC_DEBUG with trace-events
>   ui: extract common sources into a static library
>   tests/qtest: drop DBUS_VMSTATE_TEST_TMPDIR
>   tools/qemu-vnc: add standalone VNC server over D-Bus
>
>  MAINTAINERS                      |    5 +
>  docs/conf.py                     |    3 +
>  docs/interop/dbus-display.rst    |    2 +
>  docs/interop/dbus-vnc.rst        |   26 +
>  docs/interop/index.rst           |    1 +
>  docs/meson.build                 |    1 +
>  docs/tools/index.rst             |    1 +
>  docs/tools/qemu-vnc.rst          |  226 +++++
>  meson.build                      |   17 +
>  qapi/char.json                   |   30 +-
>  include/chardev/char.h           |   21 +
>  include/qemu/option.h            |    1 +
>  include/ui/console.h             |  124 ++-
>  tools/qemu-vnc/qemu-vnc.h        |   49 ++
>  tools/qemu-vnc/trace.h           |    4 +
>  ui/console-priv.h                |    1 -
>  ui/cp437.h                       |   13 +
>  ui/dbus.h                        |    1 +
>  ui/vnc-jobs.h                    |    3 +-
>  ui/vnc.h                         |   17 +-
>  ui/vt100.h                       |   95 +++
>  chardev/char.c                   |   22 +
>  hw/arm/musicpal.c                |    4 +-
>  hw/core/machine.c                |    4 +-
>  hw/display/artist.c              |    4 +-
>  hw/display/ati.c                 |   16 +-
>  hw/display/bcm2835_fb.c          |    5 +-
>  hw/display/bochs-display.c       |   14 +-
>  hw/display/cg3.c                 |    6 +-
>  hw/display/cirrus_vga.c          |    8 +-
>  hw/display/cirrus_vga_isa.c      |    2 +-
>  hw/display/dm163.c               |    6 +-
>  hw/display/exynos4210_fimd.c     |    4 +-
>  hw/display/g364fb.c              |   10 +-
>  hw/display/jazz_led.c            |   18 +-
>  hw/display/macfb.c               |    6 +-
>  hw/display/next-fb.c             |    4 +-
>  hw/display/omap_lcdc.c           |    4 +-
>  hw/display/pl110.c               |    4 +-
>  hw/display/qxl-render.c          |   12 +-
>  hw/display/qxl.c                 |   18 +-
>  hw/display/ramfb-standalone.c    |    2 +-
>  hw/display/ramfb.c               |    4 +-
>  hw/display/sm501.c               |    6 +-
>  hw/display/ssd0303.c             |    4 +-
>  hw/display/ssd0323.c             |    5 +-
>  hw/display/tcx.c                 |   16 +-
>  hw/display/vga-isa.c             |    2 +-
>  hw/display/vga-mmio.c            |    2 +-
>  hw/display/vga-pci.c             |    6 +-
>  hw/display/vga.c                 |   56 +-
>  hw/display/vhost-user-gpu.c      |   22 +-
>  hw/display/virtio-gpu-base.c     |    4 +-
>  hw/display/virtio-gpu-rutabaga.c |   10 +-
>  hw/display/virtio-gpu-udmabuf.c  |    4 +-
>  hw/display/virtio-gpu-virgl.c    |   20 +-
>  hw/display/virtio-gpu.c          |   26 +-
>  hw/display/virtio-vga.c          |    4 +-
>  hw/display/vmware_vga.c          |   14 +-
>  hw/display/xenfb.c               |    6 +-
>  hw/display/xlnx_dp.c             |   10 +-
>  hw/vfio/display.c                |   32 +-
>  system/runstate.c                |    5 +
>  tests/qtest/dbus-vmstate-test.c  |  123 ++-
>  tests/qtest/dbus-vnc-test.c      | 1346 ++++++++++++++++++++++++++++++
>  tools/qemu-vnc/audio.c           |  308 +++++++
>  tools/qemu-vnc/chardev.c         |  148 ++++
>  tools/qemu-vnc/clipboard.c       |  376 +++++++++
>  tools/qemu-vnc/console.c         |  170 ++++
>  tools/qemu-vnc/dbus.c            |  474 +++++++++++
>  tools/qemu-vnc/display.c         |  456 ++++++++++
>  tools/qemu-vnc/input.c           |  239 ++++++
>  tools/qemu-vnc/qemu-vnc.c        |  581 +++++++++++++
>  tools/qemu-vnc/stubs.c           |   62 ++
>  tools/qemu-vnc/utils.c           |   59 ++
>  ui/console-vc-stubs.c            |    1 +
>  ui/console-vc.c                  | 1074 ++----------------------
>  ui/console.c                     |  173 ++--
>  ui/cp437.c                       |  205 +++++
>  ui/curses.c                      |   23 +-
>  ui/dbus-chardev.c                |   10 +
>  ui/dbus-console.c                |   10 +-
>  ui/dbus-listener.c               |   37 +-
>  ui/dbus.c                        |   59 ++
>  ui/egl-headless.c                |    8 +-
>  ui/gtk-clipboard.c               |    2 +-
>  ui/gtk-egl.c                     |    6 +-
>  ui/gtk-gl-area.c                 |    6 +-
>  ui/gtk.c                         |   28 +-
>  ui/input.c                       |    8 +-
>  ui/sdl2-2d.c                     |    2 +-
>  ui/sdl2-gl.c                     |    2 +-
>  ui/sdl2.c                        |   14 +-
>  ui/spice-display.c               |   24 +-
>  ui/vnc-auth-sasl.c               |   13 +-
>  ui/vnc-enc-tight.c               |    4 +-
>  ui/vnc-enc-zlib.c                |    4 +-
>  ui/vnc-jobs.c                    |   62 +-
>  ui/vnc-system.c                  |   19 +
>  ui/vnc-ws.c                      |   10 +-
>  ui/vnc.c                         |  232 +++--
>  ui/vt100.c                       |  984 ++++++++++++++++++++++
>  util/qemu-option.c               |   13 +
>  hw/display/apple-gfx.m           |   16 +-
>  meson_options.txt                |    2 +
>  qemu-options.hx                  |   20 +-
>  scripts/meson-buildoptions.sh    |    3 +
>  tests/dbus-daemon.sh             |   16 +-
>  tests/qtest/meson.build          |   23 +-
>  tools/qemu-vnc/meson.build       |   26 +
>  tools/qemu-vnc/qemu-vnc1.xml     |  201 +++++
>  tools/qemu-vnc/trace-events      |   21 +
>  ui/cocoa.m                       |   23 +-
>  ui/dbus-display1.xml             |   18 +
>  ui/meson.build                   |  103 +--
>  ui/trace-events                  |   29 +-
>  116 files changed, 7200 insertions(+), 1748 deletions(-)
>  create mode 100644 docs/interop/dbus-vnc.rst
>  create mode 100644 docs/tools/qemu-vnc.rst
>  create mode 100644 tools/qemu-vnc/qemu-vnc.h
>  create mode 100644 tools/qemu-vnc/trace.h
>  create mode 100644 ui/cp437.h
>  create mode 100644 ui/vt100.h
>  create mode 100644 tests/qtest/dbus-vnc-test.c
>  create mode 100644 tools/qemu-vnc/audio.c
>  create mode 100644 tools/qemu-vnc/chardev.c
>  create mode 100644 tools/qemu-vnc/clipboard.c
>  create mode 100644 tools/qemu-vnc/console.c
>  create mode 100644 tools/qemu-vnc/dbus.c
>  create mode 100644 tools/qemu-vnc/display.c
>  create mode 100644 tools/qemu-vnc/input.c
>  create mode 100644 tools/qemu-vnc/qemu-vnc.c
>  create mode 100644 tools/qemu-vnc/stubs.c
>  create mode 100644 tools/qemu-vnc/utils.c
>  create mode 100644 ui/cp437.c
>  create mode 100644 ui/vnc-system.c
>  create mode 100644 ui/vt100.c
>  create mode 100644 tools/qemu-vnc/meson.build
>  create mode 100644 tools/qemu-vnc/qemu-vnc1.xml
>  create mode 100644 tools/qemu-vnc/trace-events
>
> --
> 2.54.0
>
>
>

--0000000000006030140651604577
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+TmFjaywgSSBuZWVkIHRvIGZpeCB1cCB0aGUgcmViYXNlLi48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2IGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUi
Pk1hcmMtQW5kcsOpIEx1cmVhdTxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUgZ21haWxfcXVvdGVfY29udGFpbmVyIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxf
YXR0ciI+TGUgc2FtLiA5IG1haSAyMDI2LCAxMTozNywgICZsdDs8YSBocmVmPSJtYWlsdG86bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIj5tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb208L2E+
Jmd0OyBhIMOpY3JpdMKgOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij5Gcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgJmx0OzxhIGhyZWY9Im1haWx0
bzptYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVm
ZXJyZXIiPm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbTwvYT4mZ3Q7PGJyPg0KPGJyPg0KVGhl
IGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBlZTdlYjYxMmJlOGY4ODg2ZDQ4YzFkMGMx
ZjFjNjVlNDk1MTM4ZjgzOjxicj4NCjxicj4NCsKgIE1lcmdlIHRhZyAmIzM5O3NpbmdsZS1iaW5h
cnktMjAyNjA1MDYmIzM5OyBvZiA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vcGhpbG1kL3Fl
bXUiIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9n
aXRodWIuY29tL3BoaWxtZC9xZW11PC9hPiBpbnRvIHN0YWdpbmcgKDIwMjYtMDUtMDYgMTA6NDU6
MDIgLTA0MDApPGJyPg0KPGJyPg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkg
YXQ6PGJyPg0KPGJyPg0KwqAgPGEgaHJlZj0iaHR0cHM6Ly9naXRsYWIuY29tL21hcmNhbmRyZS5s
dXJlYXUvcWVtdS5naXQiIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cHM6Ly9naXRsYWIuY29tL21hcmNhbmRyZS5sdXJlYXUvcWVtdS5naXQ8L2E+IHRhZ3Mv
dWktcHVsbC1yZXF1ZXN0PGJyPg0KPGJyPg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRv
IGMxYzllN2YyMGMzMzMwN2I1NjYyYTRjYzc1M2Q1NjUxOTY4ZWViM2I6PGJyPg0KPGJyPg0KwqAg
dG9vbHMvcWVtdS12bmM6IGFkZCBzdGFuZGFsb25lIFZOQyBzZXJ2ZXIgb3ZlciBELUJ1cyAoMjAy
Ni0wNS0wOSAxMDoyNTo1MCArMDQwMCk8YnI+DQo8YnI+DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPg0KLSBndGsgY2xp
cGJvYXJkIGZpeGVzPGJyPg0KLSBkYnVzLXZtc3RhdGUgdGVzdCBmaXhlczxicj4NCi0gdnQxMDAg
ZW11bGF0b3Igc3VwcG9ydCBmb3IgdXRmODxicj4NCi0gcWVtdS12bmMgdG9vbDxicj4NCjxicj4N
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS08YnI+DQo8YnI+DQpGYWJpYW5vIFJvc2FzICg1KTo8YnI+DQrCoCB0ZXN0cy9xdGVz
dC9kYnVzLXZtc3RhdGU6IEJyaW5nIHRoZSB0ZXN0IHVwLXRvLWRhdGU8YnI+DQrCoCB0ZXN0cy9x
dGVzdC9kYnVzLXZtc3RhdGU6IE11dGUgR2xpYiBjb21wbGFpbnRzIGFib3V0IGdfdW5zZXRlbnY8
YnI+DQrCoCDCoCB0aHJlYWQtc2FmZXR5PGJyPg0KwqAgdGVzdHMvcXRlc3QvZGJ1cy12bXN0YXRl
OiBIb25vciBRVEVTVF9MT0cgZW52IHZhcmlhYmxlPGJyPg0KwqAgdGVzdHMvcXRlc3QvZGJ1cy12
bXN0YXRlOiBTdG9wIHRoZSBkYWVtb25zIGV4cGxpY2l0bHk8YnI+DQrCoCB0ZXN0cy9xdGVzdC9k
YnVzLXZtc3RhdGU6IFJlLWVuYWJsZSB0aGUgdGVzdDxicj4NCjxicj4NCkppbmTFmWljaCBNYWtv
dmnEjWthICgxKTo8YnI+DQrCoCB1aS9ndGs6IEZpeCBHVEsgYXNzZXJ0aW9uIGZhaWx1cmUgaW50
cm9kdWNlZCB3aXRoIGNsaXBib2FyZCBmaXhlczxicj4NCjxicj4NCk1hcmMtQW5kcsOpIEx1cmVh
dSAoMjYpOjxicj4NCsKgIHVpL2lucHV0OiBkbyBub3QgYXNzZXJ0KCkgd2hlbiB0cmFjaW5nIGlu
dmFsaWQgaW5wdXQ8YnI+DQrCoCBxZW11LW9wdGlvbnMuaHg6IGRvY3VtZW50IC1jaGFyZGV2IHZj
IGJhY2tlbmQtc3BlY2lmaWMgYmVoYXZpb3I8YnI+DQrCoCBjaGFyOiBlcnJvciBvdXQgaWYgZ2l2
ZW4gdW5oYW5kbGVkIHNpemUgb3B0aW9uczxicj4NCsKgIHVpL2NvbnNvbGU6IGFkZCB2YyBlbmNv
ZGluZz11dGY4L2NwNDM3IG9wdGlvbjxicj4NCsKgIHVpL2NvbnNvbGU6IGRlZmF1bHQgdmMgZW5j
b2RpbmcgdG8gY3A0MzcgZm9yIG1hY2hpbmUgJmx0OyAxMS4xPGJyPg0KwqAgdWkvZGJ1czogZXhw
b3NlIHZjIGVuY29kaW5nIHZpYSBELUJ1cyBDaGFyZGV2LlZDRW5jb2RpbmcgaW50ZXJmYWNlPGJy
Pg0KwqAgdWkvY29uc29sZS12YzogYWRkIFVURi04IGlucHV0IGRlY29kaW5nIHdpdGggQ1A0Mzcg
cmVuZGVyaW5nPGJyPg0KwqAgdWkvY29uc29sZS12YzogbW92ZSBWVDEwMCBzdGF0ZSBtYWNoaW5l
IGFuZCBvdXRwdXQgRklGTyBpbnRvIFFlbXVWVDEwMDxicj4NCsKgIHVpL2NvbnNvbGUtdmM6IGV4
dHJhY3QgdnQxMDBfaW5wdXQoKSBmcm9tIHZjX2Nocl93cml0ZSgpPGJyPg0KwqAgdWkvY29uc29s
ZS12YzogZXh0cmFjdCB2dDEwMF9rZXlzeW0oKSBmcm9tPGJyPg0KwqAgwqAgcWVtdV90ZXh0X2Nv
bnNvbGVfaGFuZGxlX2tleXN5bSgpPGJyPg0KwqAgdWkvY29uc29sZS12YzogZXh0cmFjdCB2dDEw
MF9pbml0KCkgYW5kIHZ0MTAwX2ZpbmkoKTxicj4NCsKgIHVpL2NvbnNvbGU6IHJlbW92ZSBjb25z
b2xlX2NoX3QgdHlwZWRlZiBhbmQgY29uc29sZV93cml0ZV9jaCgpPGJyPg0KwqAgdWkvY29uc29s
ZS12YzogbW92ZSBWVDEwMCBlbXVsYXRpb24gaW50byBzZXBhcmF0ZSB1bml0PGJyPg0KwqAgdWkv
dm5jOiBtYWtlIHRoZSB3b3JrZXIgdGhyZWFkIHBlci1WbmNEaXNwbGF5PGJyPg0KwqAgdWkvdm5j
OiB2bmNfZGlzcGxheV9pbml0KCkgYW5kIHZuY19kaXNwbGF5X29wZW4oKSByZXR1cm4gYm9vbDxi
cj4NCsKgIHVpL3ZuYzogbWVyZ2Ugdm5jX2Rpc3BsYXlfaW5pdCgpIGFuZCB2bmNfZGlzcGxheV9v
cGVuKCk8YnI+DQrCoCB1aS92bmM6IGNsZWFuIHVwIFZOQyBkaXNwbGF5cyBvbiBleGl0PGJyPg0K
wqAgdWkvdm5jOiBkZWZlciBsaXN0ZW5lciByZWdpc3RyYXRpb24gdW50aWwgdGhlIGNvbnNvbGUg
aXMga25vd248YnI+DQrCoCB1aS92bmM6IGFkZCB2bmMtc3lzdGVtIHVuaXQsIHRvIGFsbG93IGRp
ZmZlcmVudCBpbXBsZW1lbnRhdGlvbnM8YnI+DQrCoCB1aS9jb25zb2xlOiBzaW1wbGlmeSByZWdp
c3RlcmluZyBkaXNwbGF5L2NvbnNvbGUgY2hhbmdlIGxpc3RlbmVyPGJyPg0KwqAgdWkvY29uc29s
ZTogYWRkIGRvYyBjb21tZW50IGZvciBxZW11X2NvbnNvbGVfe3VufXJlZ2lzdGVyX2xpc3RlbmVy
KCk8YnI+DQrCoCB1aS9jb25zb2xlOiByZW5hbWUgcHVibGljIEFQSSB0byB1c2UgY29uc2lzdGVu
dCBxZW11X2NvbnNvbGVfIHByZWZpeDxicj4NCsKgIHVpL3ZuYzogcmVwbGFjZSBWTkNfREVCVUcg
d2l0aCB0cmFjZS1ldmVudHM8YnI+DQrCoCB1aTogZXh0cmFjdCBjb21tb24gc291cmNlcyBpbnRv
IGEgc3RhdGljIGxpYnJhcnk8YnI+DQrCoCB0ZXN0cy9xdGVzdDogZHJvcCBEQlVTX1ZNU1RBVEVf
VEVTVF9UTVBESVI8YnI+DQrCoCB0b29scy9xZW11LXZuYzogYWRkIHN0YW5kYWxvbmUgVk5DIHNl
cnZlciBvdmVyIEQtQnVzPGJyPg0KPGJyPg0KwqBNQUlOVEFJTkVSU8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoCA1ICs8YnI+DQrCoGRvY3MvY29uZi5wecKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIDMgKzxicj4NCsKgZG9jcy9pbnRlcm9wL2RidXMt
ZGlzcGxheS5yc3TCoCDCoCB8wqAgwqAgMiArPGJyPg0KwqBkb2NzL2ludGVyb3AvZGJ1cy12bmMu
cnN0wqAgwqAgwqAgwqAgfMKgIMKgMjYgKzxicj4NCsKgZG9jcy9pbnRlcm9wL2luZGV4LnJzdMKg
IMKgIMKgIMKgIMKgIMKgfMKgIMKgIDEgKzxicj4NCsKgZG9jcy9tZXNvbi5idWlsZMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIDEgKzxicj4NCsKgZG9jcy90b29scy9pbmRleC5yc3TC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCAxICs8YnI+DQrCoGRvY3MvdG9vbHMvcWVtdS12bmMu
cnN0wqAgwqAgwqAgwqAgwqAgfMKgIDIyNiArKysrKzxicj4NCsKgbWVzb24uYnVpbGTCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxNyArPGJyPg0KwqBxYXBpL2NoYXIuanNv
bsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMzAgKy08YnI+DQrCoGluY2x1ZGUv
Y2hhcmRldi9jaGFyLmjCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIxICs8YnI+DQrCoGluY2x1ZGUv
cWVtdS9vcHRpb24uaMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCAxICs8YnI+DQrCoGluY2x1ZGUv
dWkvY29uc29sZS5owqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTI0ICsrLTxicj4NCsKgdG9vbHMv
cWVtdS12bmMvcWVtdS12bmMuaMKgIMKgIMKgIMKgIHzCoCDCoDQ5ICsrPGJyPg0KwqB0b29scy9x
ZW11LXZuYy90cmFjZS5owqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgNCArPGJyPg0KwqB1aS9jb25z
b2xlLXByaXYuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCAxIC08YnI+DQrCoHVpL2Nw
NDM3LmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEzICs8YnI+DQrC
oHVpL2RidXMuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCAxICs8
YnI+DQrCoHVpL3ZuYy1qb2JzLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAg
MyArLTxicj4NCsKgdWkvdm5jLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCDCoDE3ICstPGJyPg0KwqB1aS92dDEwMC5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8wqAgwqA5NSArKys8YnI+DQrCoGNoYXJkZXYvY2hhci5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgwqAyMiArPGJyPg0KwqBody9hcm0vbXVzaWNwYWwuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoCA0ICstPGJyPg0KwqBody9jb3JlL21hY2hpbmUuY8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCA0ICstPGJyPg0KwqBody9kaXNwbGF5L2FydGlzdC5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgIDQgKy08YnI+DQrCoGh3L2Rpc3BsYXkvYXRpLmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDE2ICstPGJyPg0KwqBody9kaXNwbGF5L2Jj
bTI4MzVfZmIuY8KgIMKgIMKgIMKgIMKgIHzCoCDCoCA1ICstPGJyPg0KwqBody9kaXNwbGF5L2Jv
Y2hzLWRpc3BsYXkuY8KgIMKgIMKgIMKgfMKgIMKgMTQgKy08YnI+DQrCoGh3L2Rpc3BsYXkvY2cz
LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCA2ICstPGJyPg0KwqBody9kaXNwbGF5
L2NpcnJ1c192Z2EuY8KgIMKgIMKgIMKgIMKgIHzCoCDCoCA4ICstPGJyPg0KwqBody9kaXNwbGF5
L2NpcnJ1c192Z2FfaXNhLmPCoCDCoCDCoCB8wqAgwqAgMiArLTxicj4NCsKgaHcvZGlzcGxheS9k
bTE2My5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgNiArLTxicj4NCsKgaHcvZGlzcGxh
eS9leHlub3M0MjEwX2ZpbWQuY8KgIMKgIMKgfMKgIMKgIDQgKy08YnI+DQrCoGh3L2Rpc3BsYXkv
ZzM2NGZiLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxMCArLTxicj4NCsKgaHcvZGlzcGxh
eS9qYXp6X2xlZC5jwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMTggKy08YnI+DQrCoGh3L2Rpc3Bs
YXkvbWFjZmIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIDYgKy08YnI+DQrCoGh3L2Rp
c3BsYXkvbmV4dC1mYi5jwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgNCArLTxicj4NCsKgaHcv
ZGlzcGxheS9vbWFwX2xjZGMuY8KgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIDQgKy08YnI+DQrCoGh3
L2Rpc3BsYXkvcGwxMTAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIDQgKy08YnI+DQrC
oGh3L2Rpc3BsYXkvcXhsLXJlbmRlci5jwqAgwqAgwqAgwqAgwqAgfMKgIMKgMTIgKy08YnI+DQrC
oGh3L2Rpc3BsYXkvcXhsLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDE4ICstPGJy
Pg0KwqBody9kaXNwbGF5L3JhbWZiLXN0YW5kYWxvbmUuY8KgIMKgIHzCoCDCoCAyICstPGJyPg0K
wqBody9kaXNwbGF5L3JhbWZiLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCA0ICstPGJy
Pg0KwqBody9kaXNwbGF5L3NtNTAxLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCA2ICst
PGJyPg0KwqBody9kaXNwbGF5L3NzZDAzMDMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIDQg
Ky08YnI+DQrCoGh3L2Rpc3BsYXkvc3NkMDMyMy5jwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAg
NSArLTxicj4NCsKgaHcvZGlzcGxheS90Y3guY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMTYgKy08YnI+DQrCoGh3L2Rpc3BsYXkvdmdhLWlzYS5jwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgwqAgMiArLTxicj4NCsKgaHcvZGlzcGxheS92Z2EtbW1pby5jwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgIDIgKy08YnI+DQrCoGh3L2Rpc3BsYXkvdmdhLXBjaS5jwqAgwqAgwqAgwqAgwqAgwqAg
wqB8wqAgwqAgNiArLTxicj4NCsKgaHcvZGlzcGxheS92Z2EuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIMKgNTYgKy08YnI+DQrCoGh3L2Rpc3BsYXkvdmhvc3QtdXNlci1ncHUuY8KgIMKg
IMKgIHzCoCDCoDIyICstPGJyPg0KwqBody9kaXNwbGF5L3ZpcnRpby1ncHUtYmFzZS5jwqAgwqAg
wqB8wqAgwqAgNCArLTxicj4NCsKgaHcvZGlzcGxheS92aXJ0aW8tZ3B1LXJ1dGFiYWdhLmMgfMKg
IMKgMTAgKy08YnI+DQrCoGh3L2Rpc3BsYXkvdmlydGlvLWdwdS11ZG1hYnVmLmPCoCB8wqAgwqAg
NCArLTxicj4NCsKgaHcvZGlzcGxheS92aXJ0aW8tZ3B1LXZpcmdsLmPCoCDCoCB8wqAgwqAyMCAr
LTxicj4NCsKgaHcvZGlzcGxheS92aXJ0aW8tZ3B1LmPCoCDCoCDCoCDCoCDCoCB8wqAgwqAyNiAr
LTxicj4NCsKgaHcvZGlzcGxheS92aXJ0aW8tdmdhLmPCoCDCoCDCoCDCoCDCoCB8wqAgwqAgNCAr
LTxicj4NCsKgaHcvZGlzcGxheS92bXdhcmVfdmdhLmPCoCDCoCDCoCDCoCDCoCB8wqAgwqAxNCAr
LTxicj4NCsKgaHcvZGlzcGxheS94ZW5mYi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAg
NiArLTxicj4NCsKgaHcvZGlzcGxheS94bG54X2RwLmPCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDC
oDEwICstPGJyPg0KwqBody92ZmlvL2Rpc3BsYXkuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzC
oCDCoDMyICstPGJyPg0KwqBzeXN0ZW0vcnVuc3RhdGUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHzCoCDCoCA1ICs8YnI+DQrCoHRlc3RzL3F0ZXN0L2RidXMtdm1zdGF0ZS10ZXN0LmPCoCB8wqAg
MTIzICsrLTxicj4NCsKgdGVzdHMvcXRlc3QvZGJ1cy12bmMtdGVzdC5jwqAgwqAgwqAgfCAxMzQ2
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4NCsKgdG9vbHMvcWVtdS12bmMvYXVk
aW8uY8KgIMKgIMKgIMKgIMKgIMKgfMKgIDMwOCArKysrKysrPGJyPg0KwqB0b29scy9xZW11LXZu
Yy9jaGFyZGV2LmPCoCDCoCDCoCDCoCDCoHzCoCAxNDggKysrKzxicj4NCsKgdG9vbHMvcWVtdS12
bmMvY2xpcGJvYXJkLmPCoCDCoCDCoCDCoHzCoCAzNzYgKysrKysrKysrPGJyPg0KwqB0b29scy9x
ZW11LXZuYy9jb25zb2xlLmPCoCDCoCDCoCDCoCDCoHzCoCAxNzAgKysrKzxicj4NCsKgdG9vbHMv
cWVtdS12bmMvZGJ1cy5jwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQ3NCArKysrKysrKysrKzxicj4N
CsKgdG9vbHMvcWVtdS12bmMvZGlzcGxheS5jwqAgwqAgwqAgwqAgwqB8wqAgNDU2ICsrKysrKysr
Kys8YnI+DQrCoHRvb2xzL3FlbXUtdm5jL2lucHV0LmPCoCDCoCDCoCDCoCDCoCDCoHzCoCAyMzkg
KysrKysrPGJyPg0KwqB0b29scy9xZW11LXZuYy9xZW11LXZuYy5jwqAgwqAgwqAgwqAgfMKgIDU4
MSArKysrKysrKysrKysrPGJyPg0KwqB0b29scy9xZW11LXZuYy9zdHVicy5jwqAgwqAgwqAgwqAg
wqAgwqB8wqAgwqA2MiArKzxicj4NCsKgdG9vbHMvcWVtdS12bmMvdXRpbHMuY8KgIMKgIMKgIMKg
IMKgIMKgfMKgIMKgNTkgKys8YnI+DQrCoHVpL2NvbnNvbGUtdmMtc3R1YnMuY8KgIMKgIMKgIMKg
IMKgIMKgIHzCoCDCoCAxICs8YnI+DQrCoHVpL2NvbnNvbGUtdmMuY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHwgMTA3NCArKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+DQrCoHVpL2NvbnNv
bGUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDE3MyArKy0tPGJyPg0KwqB1
aS9jcDQzNy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMjA1ICsrKysr
PGJyPg0KwqB1aS9jdXJzZXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDC
oDIzICstPGJyPg0KwqB1aS9kYnVzLWNoYXJkZXYuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzC
oCDCoDEwICs8YnI+DQrCoHVpL2RidXMtY29uc29sZS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgMTAgKy08YnI+DQrCoHVpL2RidXMtbGlzdGVuZXIuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfMKgIMKgMzcgKy08YnI+DQrCoHVpL2RidXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHzCoCDCoDU5ICsrPGJyPg0KwqB1aS9lZ2wtaGVhZGxlc3MuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHzCoCDCoCA4ICstPGJyPg0KwqB1aS9ndGstY2xpcGJvYXJkLmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCDCoCAyICstPGJyPg0KwqB1aS9ndGstZWdsLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCA2ICstPGJyPg0KwqB1aS9ndGstZ2wtYXJlYS5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgNiArLTxicj4NCsKgdWkvZ3RrLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDI4ICstPGJyPg0KwqB1aS9p
bnB1dC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgOCArLTxicj4N
CsKgdWkvc2RsMi0yZC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgMiAr
LTxicj4NCsKgdWkvc2RsMi1nbC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAg
wqAgMiArLTxicj4NCsKgdWkvc2RsMi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgMTQgKy08YnI+DQrCoHVpL3NwaWNlLWRpc3BsYXkuY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIMKgMjQgKy08YnI+DQrCoHVpL3ZuYy1hdXRoLXNhc2wuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfMKgIMKgMTMgKy08YnI+DQrCoHVpL3ZuYy1lbmMtdGlnaHQuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfMKgIMKgIDQgKy08YnI+DQrCoHVpL3ZuYy1lbmMtemxpYi5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIMKgIDQgKy08YnI+DQrCoHVpL3ZuYy1qb2JzLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA2MiArLTxicj4NCsKgdWkvdm5jLXN5c3RlbS5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMTkgKzxicj4NCsKgdWkvdm5jLXdzLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxMCArLTxicj4NCsKgdWkvdm5jLmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyMzIgKysrLS08YnI+DQrC
oHVpL3Z0MTAwLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA5ODQgKysr
KysrKysrKysrKysrKysrKysrKzxicj4NCsKgdXRpbC9xZW11LW9wdGlvbi5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB8wqAgwqAxMyArPGJyPg0KwqBody9kaXNwbGF5L2FwcGxlLWdmeC5twqAgwqAg
wqAgwqAgwqAgwqB8wqAgwqAxNiArLTxicj4NCsKgbWVzb25fb3B0aW9ucy50eHTCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB8wqAgwqAgMiArPGJyPg0KwqBxZW11LW9wdGlvbnMuaHjCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyMCArLTxicj4NCsKgc2NyaXB0cy9tZXNvbi1idWlsZG9w
dGlvbnMuc2jCoCDCoCB8wqAgwqAgMyArPGJyPg0KwqB0ZXN0cy9kYnVzLWRhZW1vbi5zaMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIMKgMTYgKy08YnI+DQrCoHRlc3RzL3F0ZXN0L21lc29uLmJ1aWxk
wqAgwqAgwqAgwqAgwqAgfMKgIMKgMjMgKy08YnI+DQrCoHRvb2xzL3FlbXUtdm5jL21lc29uLmJ1
aWxkwqAgwqAgwqAgwqB8wqAgwqAyNiArPGJyPg0KwqB0b29scy9xZW11LXZuYy9xZW11LXZuYzEu
eG1swqAgwqAgwqB8wqAgMjAxICsrKysrPGJyPg0KwqB0b29scy9xZW11LXZuYy90cmFjZS1ldmVu
dHPCoCDCoCDCoCB8wqAgwqAyMSArPGJyPg0KwqB1aS9jb2NvYS5twqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyMyArLTxicj4NCsKgdWkvZGJ1cy1kaXNwbGF5MS54bWzC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDE4ICs8YnI+DQrCoHVpL21lc29uLmJ1aWxkwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTAzICstLTxicj4NCsKgdWkvdHJhY2UtZXZlbnRz
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMjkgKy08YnI+DQrCoDExNiBmaWxlcyBj
aGFuZ2VkLCA3MjAwIGluc2VydGlvbnMoKyksIDE3NDggZGVsZXRpb25zKC0pPGJyPg0KwqBjcmVh
dGUgbW9kZSAxMDA2NDQgZG9jcy9pbnRlcm9wL2RidXMtdm5jLnJzdDxicj4NCsKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRvY3MvdG9vbHMvcWVtdS12bmMucnN0PGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2
NDQgdG9vbHMvcWVtdS12bmMvcWVtdS12bmMuaDxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRv
b2xzL3FlbXUtdm5jL3RyYWNlLmg8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCB1aS9jcDQzNy5o
PGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgdWkvdnQxMDAuaDxicj4NCsKgY3JlYXRlIG1vZGUg
MTAwNjQ0IHRlc3RzL3F0ZXN0L2RidXMtdm5jLXRlc3QuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRvb2xzL3FlbXUtdm5jL2F1ZGlvLmM8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29s
cy9xZW11LXZuYy9jaGFyZGV2LmM8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9xZW11
LXZuYy9jbGlwYm9hcmQuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3FlbXUtdm5j
L2NvbnNvbGUuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3FlbXUtdm5jL2RidXMu
Yzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3FlbXUtdm5jL2Rpc3BsYXkuYzxicj4N
CsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3FlbXUtdm5jL2lucHV0LmM8YnI+DQrCoGNyZWF0
ZSBtb2RlIDEwMDY0NCB0b29scy9xZW11LXZuYy9xZW11LXZuYy5jPGJyPg0KwqBjcmVhdGUgbW9k
ZSAxMDA2NDQgdG9vbHMvcWVtdS12bmMvc3R1YnMuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRvb2xzL3FlbXUtdm5jL3V0aWxzLmM8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCB1aS9jcDQz
Ny5jPGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgdWkvdm5jLXN5c3RlbS5jPGJyPg0KwqBjcmVh
dGUgbW9kZSAxMDA2NDQgdWkvdnQxMDAuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L3FlbXUtdm5jL21lc29uLmJ1aWxkPGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcWVt
dS12bmMvcWVtdS12bmMxLnhtbDxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3FlbXUt
dm5jL3RyYWNlLWV2ZW50czxicj4NCjxicj4NCi0tIDxicj4NCjIuNTQuMDxicj4NCjxicj4NCjxi
cj4NCjwvYmxvY2txdW90ZT48L2Rpdj4NCg==
--0000000000006030140651604577--

