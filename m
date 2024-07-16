Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27ECC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmcY-0005kH-Cl; Tue, 16 Jul 2024 14:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcW-0005bV-2q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:09:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcU-0000tR-4u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:09:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso45015e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153384; x=1721758184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SaiD9U9AwP/1bByOyja0Uxov4Ba81ZpHCardor2uqFY=;
 b=uT1GU/nymVRWTg1jZG8mz2ULrusAkoP81bvrczqMDo0axZw2xvXdCxefKOZv++6369
 zhiyTeSXU9y3U65UY8dgHRbzzO7Ia9qcMIFRMD1De+U2+g7XiWhH0Z8aKEUxU58oThon
 uBsfkXh74BAcJMh4K2EvH355MXwpvKj/gm+bagWdPnFxIxwgju5lDL4pm+RiO7PWL6Va
 AGCcSYdbLRSDMJcG/3zsuaWYraoRIOhuohKhVMQQbUa3gHt5zTkzI5KMacgZ7nFjt2R/
 PL86Q8JLjl8yNiaImshAZ0JC3AoNLT9Izz8SCvRyYVQwFGyQMkD2TAi81FnuRJq1Y4mH
 Vbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153384; x=1721758184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SaiD9U9AwP/1bByOyja0Uxov4Ba81ZpHCardor2uqFY=;
 b=Cyat26W89Nn0TSOIEA9n9NNK60mvlA9GrGInYzRZaf4YupXI+13jrAWKVZ+exdZpty
 DhzunylTjlDs4wEkor/apCpFz5pztpcyM+UQReIP1/eG+Dw2sVF+37YOxbWpEH5wD7P6
 pKYaZZry46Ho4ENGgHPhp8VR7CttU40nnxYM+/0iAYptJvKQAyjpOnAaHwxKrvHzQk+/
 efFMv6ZY5wBFV9GXEx0xoRtirxypf26ifWAGAkc5HlTWHfHW9k8udfRxpLNcdwPRKBGY
 SG2Bg+fBpJvbPmF9wZ0T4q0hFG3ZQBKCny6Wls05NvUSTLHIfzi+VNT/uMqwnEbHvNuI
 iDDg==
X-Gm-Message-State: AOJu0YyXs8M2DXGw/SgSNr6LffXitNId7m98XSUWdw6OgXdwl4IQwZhB
 YPVifZzdasNTCuMri+vAb1KCFyOO0JQxMDaR2oKhE93N5MzUkWztd86HawBnh5lY8a3CR13yYw4
 aScnqOQ==
X-Google-Smtp-Source: AGHT+IGdZ8J1MEZFUCNw/TZ4hZJ4Bw4pdQzeIQfp/m1ouXl0MCN6qIvDvPzG4hAS0q0pgJadRt9hsQ==
X-Received: by 2002:a5d:6612:0:b0:360:866f:5083 with SMTP id
 ffacd0b85a97d-368274eb83cmr1973074f8f.32.1721153384049; 
 Tue, 16 Jul 2024 11:09:44 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccdffsm9762862f8f.54.2024.07.16.11.09.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:09:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/13] Misc HW/UI patches for 2024-07-16
Date: Tue, 16 Jul 2024 20:09:27 +0200
Message-ID: <20240716180941.40211-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit 959269e910944c03bc13f300d65bf08b060d5d0f:

  Merge tag 'python-pull-request' of https://gitlab.com/jsnow/qemu into staging (2024-07-16 06:45:23 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240716

for you to fetch changes up to 644a52778a90581dbda909f38b9eaf71501fd9cd:

  system/physmem: use return value of ram_block_discard_require() as errno (2024-07-16 20:04:08 +0200)

Ignored checkpatch error:

  WARNING: line over 80 characters
  #30: FILE: system/vl.c:1004:
  +    if (!ti->class_names[0] || module_object_class_by_name(ti->class_names[0])) {

Ignored CI failures:

 - bios-tables-test on cross-i686-tci
 - qtest-sparc on msys2-64bit

----------------------------------------------------------------
Misc HW & UI patches queue

- Allow loading safely ROMs larger than 4GiB (Gregor)
- Convert vt82c686 IRQ as named 'intr' (Bernhard)
- Clarify QDev GPIO API (Peter)
- Drop unused load_image_gzipped function (Ani)
- Make TCGCPUOps::cpu_exec_interrupt handler mandatory (Peter)
- Factor cpu_pause() out (Nicholas)
- Remove transfer size check from ESP DMA DATA IN / OUT transfers (Mark)
- Add accelerated cursor composition to Cocoa UI (Akihiko)
- Fix '-vga help' CLI (Marc-André)
- Fix displayed errno in ram_block_add (Zhenzhong)

----------------------------------------------------------------

Akihiko Odaki (4):
  ui/cocoa: Release CGColorSpace
  ui/console: Convert mouse visibility parameter into bool
  ui/cocoa: Add cursor composition
  ui/console: Remove dpy_cursor_define_supported()

Ani Sinha (1):
  loader: remove load_image_gzipped function as its not used anywhere

Bernhard Beschow (1):
  hw/isa/vt82c686: Turn "intr" irq into a named gpio

Gregor Haas (1):
  hw/core/loader: allow loading larger ROMs

Marc-André Lureau (1):
  vl: fix "type is NULL" in -vga help

Mark Cave-Ayland (1):
  esp: remove transfer size check from DMA DATA IN and DATA OUT
    transfers

Nicholas Piggin (1):
  system/cpus: Add cpu_pause() function

Peter Maydell (2):
  include/hw/qdev-core.h: Correct and clarify gpio doc comments
  accel/tcg: Make cpu_exec_interrupt hook mandatory

Zhenzhong Duan (1):
  system/physmem: use return value of ram_block_discard_require() as
    errno

 meson.build             |   3 +-
 include/hw/core/cpu.h   |   8 ++++
 include/hw/loader.h     |   4 +-
 include/hw/qdev-core.h  |  17 +++----
 include/ui/console.h    |   5 +-
 accel/tcg/cpu-exec.c    |   4 +-
 hw/core/loader.c        |  45 +++--------------
 hw/display/ati.c        |   2 +-
 hw/display/qxl-render.c |   4 --
 hw/display/virtio-gpu.c |   3 +-
 hw/display/vmware_vga.c |   8 ++--
 hw/isa/vt82c686.c       |   2 +-
 hw/mips/fuloong2e.c     |   2 +-
 hw/ppc/amigaone.c       |   5 +-
 hw/ppc/pegasos2.c       |   4 +-
 hw/scsi/esp.c           |   4 +-
 system/cpus.c           |  30 +++++++-----
 system/physmem.c        |   7 ++-
 system/vl.c             |  13 +++--
 target/tricore/cpu.c    |   6 +++
 ui/console.c            |  18 ++-----
 ui/dbus-listener.c      |   2 +-
 ui/gtk.c                |   2 +-
 ui/sdl2.c               |   4 +-
 ui/spice-display.c      |  11 +++--
 ui/vnc.c                |   2 +-
 ui/cocoa.m              | 104 +++++++++++++++++++++++++++++++++++++++-
 27 files changed, 200 insertions(+), 119 deletions(-)

-- 
2.41.0


