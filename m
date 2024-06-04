Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F52C27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQtu-0005Fy-56; Tue, 04 Jun 2024 05:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQts-0005FY-BS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQtp-000210-NK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-421392b8156so8474445e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717494971; x=1718099771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=frx2ed58EFc6Nfuk4DFVyc8wlrOm3fsgihGfinTcqsw=;
 b=wHkzcnq/pmWjnlCuu/9rZ842tr5PWkIG5QOYZIM5FNm2dHOcfrlMfYI8bAB9nIzyzQ
 w4zIiBu4yDD6GT39D872cs1066l8pH3DpJK03bFSmzoXhlKF6dP43Mqg8duyL0SFm/QH
 qlx35Gx3Pc0jZ/ikNr+a/xPP6Vt0uAhCKRhoI61QIBVeGYT78V9GhovOf2eZZAJW59Pp
 2P9cn1Tahrm+zqwj1wBpD7M924aB6ztOq+CKhFa6EQBhW3Z9LhxQyGSmUaYAnuCCwS2j
 cJE01KPBdyPA8DVw7lkiOpGGeSN4SP9u+P/aXd1tD3mSKzkc8B8Q4LNThbq/fJuMjzkh
 /jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717494971; x=1718099771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=frx2ed58EFc6Nfuk4DFVyc8wlrOm3fsgihGfinTcqsw=;
 b=aeoQPJoISLNPjPHKXBlh+o6piEm69FCIK6vZQ3pJsd27Cm82Vpm6WhNvnM66mI2aVI
 CKiEOgUjWBJ2T1LlFR+56dqAZpBCCnRnuiyBDrMW9pZpME/ppLnEW5LwMzVMJx3vl5QQ
 gSFPPywo5dGQ4K7UtS/jNeK7ctLLb9u3UPI0hHMw3MRad2gaOBH5QBJk/bAdTxUmqWtz
 E64Wgw3fFY2KmoQRgyogQtOvSaXxypb5huC+ZVMYiWoqs2QvxdZ8l2DWKfU6PV5eDmP9
 iYXX9Y6AxruWA/xNgkFYHPaJAzYHJg6DL/QijM3kjNShokIvdS6K+iHgnSJI9OciP8Cn
 QMkA==
X-Gm-Message-State: AOJu0YzwB2ECZznmUCezr55cQDGGF802B7d17W5EnkMqE08qP3HEu1X3
 ffmzRHD1zTkHWaeAvLvJHaRvr0tYEm0Bslsdu+vSq7RSi9c3uezHlRwTvqjVC50pVoGKw9S9u/F
 f
X-Google-Smtp-Source: AGHT+IFJnYibKpXczV+pMCwQdQWHBoUZgqhZ7RySY594p0dovOtPlgm2oJY3tE1WbLXh6ssoxhaH7Q==
X-Received: by 2002:a05:600c:a46:b0:421:4f34:3ada with SMTP id
 5b1f17b1804b1-4214f343b3bmr11449005e9.32.1717494971566; 
 Tue, 04 Jun 2024 02:56:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064afe3sm10923257f8f.97.2024.06.04.02.56.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/32] Misc HW / accel patches
Date: Tue,  4 Jun 2024 11:55:36 +0200
Message-ID: <20240604095609.12285-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 3ab42e46acf867c45bc929fcc37693e327a35a24:

  Merge tag 'pull-ufs-20240603' of https://gitlab.com/jeuk20.kim/qemu into staging (2024-06-03 08:18:14 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-accel-20240604

for you to fetch changes up to 7c2397643c1e025c157bab95088b3b480f0d98ae:

  usb: add config options for the hub and hid devices (2024-06-04 11:53:43 +0200)

Following checkpatch.pl error ignored:

  ERROR: suspect code indent for conditional statements (7, 10)
  #95: FILE: disas/microblaze.c:718:
          if ( ((((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) & 0xE000) == REG_PVR_MASK) {
  +          snprintf(tmpstr, sizeof(tmpstr), "%s%u", pvr_register_prefix,

  total: 1 errors, 0 warnings, 79 lines checked

----------------------------------------------------------------
Misc HW & accelerators patch queue

- Use async exit in debugexit model (Thomas)
- Fixed bug reading xlnx_dpdma descriptor (Peter)
- Initialise plugin state before vCPU/thread creation (Alex)
- Few sprintf() calls removed (Richard & Philippe)
- Few deprecated QMP events removed (Philippe)
- Housekeeping in Xen (Edgar & Philippe)
- Split USB HID/HUB & update MAINTAINERS (Gerd)

----------------------------------------------------------------

Alex Bennée (5):
  hw/core: expand on the alignment of CPUState
  cpu: move Qemu[Thread|Cond] setup into common code
  cpu-target: don't set cpu->thread_id to bogus value
  plugins: remove special casing for cpu->realized
  core/cpu-common: initialise plugin state before thread creation

Edgar E. Iglesias (3):
  xen: Add xen_mr_is_memory()
  physmem: Always pass offset + addr to xen_map_cache
  physmem: Replace check for RAMBlock offset 0 with xen_mr_is_memory

Gerd Hoffmann (2):
  MAINTAINERS: drop usb maintainership
  usb: add config options for the hub and hid devices

Peter Maydell (2):
  accel/kvm: Fix two lines with hard-coded tabs
  hw/dma/xlnx_dpdma: Read descriptor into buffer, not into
    pointer-to-buffer

Philippe Mathieu-Daudé (16):
  target/riscv: Remove unused 'instmap.h' header in translate.c
  target/riscv: Restrict 'rv128' machine to TCG accelerator
  target/riscv: Restrict riscv_cpu_do_interrupt() to sysemu
  target/mips: Remove unused 'hw/misc/mips_itu.h' header
  target/arm: Replace sprintf() by snprintf()
  disas/m68k: Replace sprintf() by snprintf()
  disas/microblaze: Replace sprintf() by snprintf()
  system/runstate: Remove unused 'qemu/plugin.h' header
  accel/tcg: Move common declarations to 'internal-common.h'
  hw/xen: Constify XenLegacyDevice::XenDevOps
  hw/xen: Constify xenstore_be::XenDevOps
  hw/xen: Make XenDevOps structures const
  hw/xen: Register framebuffer backend via xen_backend_init()
  hw/acpi: Remove the deprecated QAPI MEM_UNPLUG_ERROR event
  trace: Remove deprecated 'vcpu' field from QMP trace events
  qga: Remove deprecated 'blacklist' argument / config key

Richard Henderson (3):
  target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings
  util/hexdump: Remove b parameter from qemu_hexdump_line
  util/hexdump: Remove ascii parameter from qemu_hexdump_line

Thomas Weißschuh (1):
  hw/misc/debugexit: use runstate API instead of plain exit()

 MAINTAINERS                         |  4 +-
 docs/about/deprecated.rst           | 34 -----------------
 docs/about/removed-features.rst     | 33 ++++++++++++++++
 qapi/machine.json                   | 28 --------------
 qapi/trace.json                     | 27 ++-----------
 accel/tcg/internal-common.h         | 15 ++++++++
 accel/tcg/internal-target.h         | 14 -------
 include/hw/core/cpu.h               | 18 +++++++--
 include/hw/xen/xen-legacy-backend.h |  5 +--
 include/hw/xen/xen_pvdev.h          |  2 +-
 include/qemu/cutils.h               |  3 +-
 include/sysemu/xen.h                |  1 +
 target/riscv/cpu.h                  |  5 ++-
 accel/dummy-cpus.c                  |  3 --
 accel/hvf/hvf-accel-ops.c           |  4 --
 accel/kvm/kvm-accel-ops.c           |  3 --
 accel/kvm/kvm-all.c                 |  4 +-
 accel/tcg/tcg-accel-ops-mttcg.c     |  4 --
 accel/tcg/tcg-accel-ops-rr.c        | 14 +++----
 accel/tcg/tcg-all.c                 |  2 +-
 cpu-target.c                        |  1 -
 disas/m68k.c                        |  2 +-
 disas/microblaze.c                  | 25 +++++++-----
 hw/9pfs/xen-9p-backend.c            |  2 +-
 hw/acpi/memory_hotplug.c            |  8 ----
 hw/core/cpu-common.c                | 25 ++++++++----
 hw/display/xenfb.c                  | 13 +++++--
 hw/dma/xlnx_dpdma.c                 |  2 +-
 hw/misc/debugexit.c                 |  4 +-
 hw/ppc/spapr.c                      | 11 +-----
 hw/usb/xen-usb.c                    |  2 +-
 hw/virtio/vhost-vdpa.c              |  4 +-
 hw/xen/xen-hvm-common.c             | 10 ++++-
 hw/xen/xen-legacy-backend.c         |  8 ++--
 hw/xenpv/xen_machine_pv.c           |  2 -
 plugins/core.c                      |  6 +--
 qga/main.c                          |  6 ---
 system/physmem.c                    |  5 ++-
 system/runstate.c                   |  1 -
 target/arm/cpu64.c                  |  4 +-
 target/i386/kvm/kvm.c               | 11 +++---
 target/i386/nvmm/nvmm-accel-ops.c   |  3 --
 target/i386/whpx/whpx-accel-ops.c   |  3 --
 target/mips/tcg/sysemu/cp0_helper.c |  1 -
 target/riscv/cpu.c                  | 10 ++++-
 target/riscv/cpu_helper.c           |  7 +---
 target/riscv/translate.c            |  1 -
 trace/qmp.c                         |  2 -
 trace/trace-hmp-cmds.c              |  4 +-
 util/hexdump.c                      | 59 ++++++++++++++++-------------
 hw/usb/Kconfig                      | 10 +++++
 hw/usb/meson.build                  |  4 +-
 hw/virtio/trace-events              |  2 +-
 53 files changed, 216 insertions(+), 265 deletions(-)

-- 
2.41.0


