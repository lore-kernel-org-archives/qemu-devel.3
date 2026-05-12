Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25761CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgVG-0000bb-Bk; Tue, 12 May 2026 02:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgV6-0000an-MX
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:21:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgV3-0003nY-Jp
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:21:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so33968365e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566906; x=1779171706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ea7PyUQXhY57XR1ShApSBGEwS4WPkPvBYx1aOuJ9yHk=;
 b=AGOoz6gK2Q9VEF4MywDKhM1wOmazJFixjLcdjQhlQUeDV6cIx6AdGfIsNimbzCCij7
 N0oCZRVwMArmtrZadJ6eA3NdShodyz0yAEpB68kvXXa8oZXtkxHSGXuMfbfpw37+GDfX
 7gU0rXELQaw3/ZaP547JjUP1MCxGFmDf/57nst59gjaEwyhntnTsmsg0qq2PFT/qXHra
 gQ7k+TEDs5/obm6tyISOUc5LaJuORVQCR+2Kp71Wb8ZuZXZfxg7CFDIk6DRxh1OAtJDC
 12FCeFcReR3nv9ue9cCqMCdbHuLG+J07HGJXUEo6Bq6I4cB4fRvmIsm+2TMDD5daR3cD
 X+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566906; x=1779171706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ea7PyUQXhY57XR1ShApSBGEwS4WPkPvBYx1aOuJ9yHk=;
 b=Ss1k2OF3EsNZA5KsequLI3cdjW15LbaCGbViRsKa0Eiex7jrWDv7BCiTSZXblV5IjE
 VHGzpaylsa3LXr2c8fHL/6vaWct2xVAemnNJ/CSUlBqr2lok6Ft81yIUIkrozVa2YfIi
 +mA/o0IpJZq24G88RiFVChhmfl6KCk6jHDwZJVSK261anBB6Q9rdAGwWbyXgPyURXqIn
 0SZUS7tJresL73vOY6XMAalsqweMTqAPee/AYFjaMbaLzXpeFFEXhcM1Aw03lM4yqDSb
 MjQNlNu5lpIHyRo8qx84Hqy3Q9k5SZ4dBZrqxhECb9odaHfvoFMC7ybP512gEnYeDov9
 k/Qg==
X-Gm-Message-State: AOJu0YyW5kpyluO0yH2U/rI+Fz0fw66BCJl11voHpd1ORaaZSE01TB1Y
 eUreDd2JbX623gpIRbhUrXitwXLnTMFrMenJ2VFY6b10XesLeWUfirQ4ameJRKyLW82de1OsqhD
 HcorD5AA=
X-Gm-Gg: Acq92OHZXhbBJCYV8hMJliQtKScIig34xYrA/jyLj0HC6dzy9CZ9uJU4myhHiTuncgc
 bqbk2hHDoqWVeK4tF6yDB8v8Yx7mA6smcJjJZYWJ+0Ll0O072cONFAtMcYD3D/Vr7D2VvyYaB+o
 KUkl6iM5WV6vp2DZFUNI8+YVWzkxomxBtiqL8QnCHHXWVaocObq4dPPSC4Qcm2TQr83ZhR6o78j
 6mR/7eMiyHdRkE39W/ut9lHbtyAQkiSe+a3cpK7CSfuxN7QSXelmSdpNy5hGtqk5nlOjvliWQVN
 O54RAYFSXY2ZPjo9bfrKEnFHHPYpfNEsGLv8zeyav+ZEn2l3hele36OLUJrEdG6lSJRJnq4avN4
 XXW29Qdu8H2QIF97isZ1T+Gu1u6jFavvXMd2o5hxstKPsYeFeR2cBkJ7mcZOSdlUCKZhRUoiKO1
 xoKUq41Rd+p2HyB668LLfXe3/azBgcNWle7ghED7ATGxxfzCB7S0rL1usYbnTrK0LwTiYaE54k
X-Received: by 2002:a05:600c:46d2:b0:48d:50a:6ef4 with SMTP id
 5b1f17b1804b1-48e8e210753mr29972475e9.11.1778566905184; 
 Mon, 11 May 2026 23:21:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e906a0615sm20790405e9.2.2026.05.11.23.21.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:21:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] Misc HW patches for 2026-05-12
Date: Tue, 12 May 2026 08:21:01 +0200
Message-ID: <20260512062142.67998-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260512

for you to fetch changes up to 275c8a594165a5c32bdc1a7aadcca626a64c4e9e:

  scripts: strip leading './' when searching MAINTAINERS file (2026-05-12 08:15:03 +0200)

----------------------------------------------------------------
Misc HW patches

- More ATI VGA fixes
- Add support for pre-setting RPMB authentication key on eMMC cards
- Fix VDPA on big-endian hosts
- Handle sub-page granularity in cpu_memory_rw_debug()
- Fix leak in pca955x_set_led()
- Mark IPv6 header structure as packed
- MAINTAINERS updates
----------------------------------------------------------------

Chad Jablonski (1):
  ati-vga: fix ati_set_dirty address calculation

Christian Speich (3):
  hw/sd: Switch read/write primitive to buf+len
  hw/sd/sd: Allow multi-byte read/write for generic paths
  hw/sd: Update trace events for buf+len data

Daniel P. Berrangé (1):
  scripts: strip leading './' when searching MAINTAINERS file

Jan Kiszka (2):
  scripts: mkemmc.sh: Fix output pollution on missing images
  hw/sd/sdcard: Add support for pre-setting the authentication key

Konstantin Shkolnyy (1):
  vdpa: Allow VDPA to work on big-endian machine

Magnus Kulke (1):
  MAINTAINERS: Add Doru Blânzeanu as MSHV reviewer

Marc-André Lureau (1):
  hw/gpio/pca9552: fix state_str leak in pca955x_set_led

Mauro Carvalho Chehab (1):
  MAINTAINERS: update HEST maintainership entries

Peter Maydell (29):
  hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
    pattern fills
  hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
    copies
  hw/i386/vapic: Cope with non-page-aligned return from
    cpu_get_phys_page_debug()
  target/riscv: Make get_phys_page_debug handle non-page-aligned addrs
  target/alpha: Make get_phys_page_debug handle non-page-aligned addrs
  target/microblaze: Make get_phys_page_attrs_debug handle
    non-page-aligned addrs
  target/sparc: Make get_phys_page_debug handle non-page-aligned addrs
  target/x86: Make get_phys_page_attrs_debug handle non-page-aligned
    addrs
  target/s390x: Make get_phys_page_debug handle non-page-aligned addrs
  target/ppc: Make get_phys_page_debug handle non-page-aligned addrs
  target: Rename get_phys_page_debug to get_phys_addr_debug
  target: Rename cpu_get_phys_page_{,attrs_}debug
  hw/core: Update docs for get_phys_addr_{attrs_, }debug
  target/arm: Rename arm_cpu_get_phys_page()
  monitor: hmp_gva2gpa: Don't page-align cpu_get_phys_addr_debug() arg
    and return
  plugins/api.c: Trust cpu_get_phys_addr_debug() return address
  hw/core: Implement new cpu_translate_for_debug()
  hw/core: Implement cpu_get_phys_addr_attrs_debug() with
    cpu_translate_for_debug()
  target/arm: Implement translate_for_debug
  system/physmem: Use translate_for_debug() in cpu_memory_rw_debug()
  hw/i386/vapic.c: Use cpu_translate_for_debug()
  target/sparc: Use cpu_translate_for_debug()
  hw/xtensa: Use cpu_translate_for_debug()
  target/xtensa/xtensa-semi: Use cpu_translate_for_debug()
  monitor/hmp-cmds: Use cpu_translate_for_debug()
  plugins/api.c: Use cpu_translate_for_debug()
  Remove cpu_get_phys_addr_debug() and cpu_get_phys_addr_attrs_debug()
  hw/i2c/microbit_i2c: Don't index off end of twi_read_sequence[]
  net: mark struct ip6_header as QEMU_PACKED

Philippe Mathieu-Daudé (1):
  MAINTAINERS: Step up to maintain core machine code

 MAINTAINERS                      |  13 +++-
 docs/system/devices/emmc.rst     |  23 ++++++
 hw/display/cirrus_vga_rop2.h     |  52 +++++++++++--
 include/hw/core/cpu.h            |  40 +++++-----
 include/hw/core/sysemu-cpu-ops.h |  39 ++++++++--
 include/hw/sd/sd.h               |  22 ++++--
 include/net/eth.h                |   2 +-
 target/alpha/cpu.h               |   2 +-
 target/arm/cpu.h                 |   3 -
 target/arm/internals.h           |   4 +
 target/avr/cpu.h                 |   2 +-
 target/hppa/cpu.h                |   2 +-
 target/i386/cpu.h                |   2 +-
 target/loongarch/cpu-mmu.h       |   2 +-
 target/m68k/cpu.h                |   2 +-
 target/microblaze/cpu.h          |   2 +-
 target/mips/internal.h           |   2 +-
 target/or1k/cpu.h                |   2 +-
 target/ppc/cpu.h                 |   2 +-
 target/riscv/cpu.h               |   2 +-
 target/rx/cpu.h                  |   2 +-
 target/s390x/s390x-internal.h    |   1 -
 target/sh4/cpu.h                 |   2 +-
 target/sparc/cpu.h               |   2 +-
 target/tricore/cpu.h             |   2 +-
 target/xtensa/cpu.h              |   2 +-
 hw/core/cpu-system.c             |  47 +++++++-----
 hw/display/ati_2d.c              |  24 ++++--
 hw/gpio/pca9552.c                |   2 +-
 hw/i2c/microbit_i2c.c            |   7 +-
 hw/i386/vapic.c                  |  13 ++--
 hw/sd/core.c                     |  53 ++++++++++---
 hw/sd/sd.c                       | 125 +++++++++++++++++++++++--------
 hw/xtensa/sim.c                  |   6 +-
 hw/xtensa/xtfpga.c               |   6 +-
 monitor/hmp-cmds.c               |   8 +-
 net/vhost-vdpa.c                 |   5 +-
 plugins/api.c                    |   8 +-
 system/physmem.c                 |  38 ++++++----
 target/alpha/cpu.c               |   2 +-
 target/alpha/helper.c            |   3 +-
 target/arm/cpu.c                 |   2 +-
 target/arm/ptw.c                 |  39 ++++++----
 target/avr/cpu.c                 |   2 +-
 target/avr/helper.c              |   2 +-
 target/hppa/cpu.c                |   2 +-
 target/hppa/mem_helper.c         |   2 +-
 target/i386/cpu.c                |   2 +-
 target/i386/helper.c             |   4 +-
 target/i386/whpx/whpx-all.c      |   2 +-
 target/loongarch/cpu.c           |   2 +-
 target/loongarch/cpu_helper.c    |   2 +-
 target/m68k/cpu.c                |   2 +-
 target/m68k/helper.c             |   2 +-
 target/microblaze/cpu.c          |   2 +-
 target/microblaze/helper.c       |  11 ++-
 target/mips/cpu.c                |   2 +-
 target/mips/system/physaddr.c    |   2 +-
 target/or1k/cpu.c                |   2 +-
 target/or1k/mmu.c                |   2 +-
 target/ppc/cpu_init.c            |   2 +-
 target/ppc/mmu-hash32.c          |   2 +-
 target/ppc/mmu_common.c          |   4 +-
 target/riscv/cpu.c               |   2 +-
 target/riscv/cpu_helper.c        |   4 +-
 target/rx/cpu.c                  |   2 +-
 target/rx/helper.c               |   2 +-
 target/s390x/cpu-system.c        |   2 +-
 target/s390x/helper.c            |  20 ++---
 target/sh4/cpu.c                 |   2 +-
 target/sh4/helper.c              |   2 +-
 target/sparc/cpu.c               |   2 +-
 target/sparc/mmu_helper.c        |  23 ++++--
 target/tricore/cpu.c             |   2 +-
 target/tricore/helper.c          |   2 +-
 target/xtensa/cpu.c              |   2 +-
 target/xtensa/mmu_helper.c       |   2 +-
 target/xtensa/xtensa-semi.c      |   9 ++-
 hw/sd/trace-events               |   6 +-
 scripts/get_maintainer.pl        |   1 +
 scripts/mkemmc.sh                |   4 +-
 81 files changed, 508 insertions(+), 253 deletions(-)

-- 
2.53.0


