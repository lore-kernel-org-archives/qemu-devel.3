Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9080EC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ14-0002I6-ME; Tue, 15 Jul 2025 02:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0h-0001tT-0v
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0e-0006yK-3u
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45610582d07so15535885e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560361; x=1753165161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g0sqOibqSPdGl3WuMtWvTYtbXoOWs5R7ZoQJ2IshoJo=;
 b=iuUQkKTSN6FkuX8kvILcL7YnJYEjadr0IIHHu1BTvlZIEXvzIsEoiTCt6k8n4aHAWC
 VTIms1qp2tVR+32x6xDBgtPGCfdPTJnJwxURwFeu189bM/ifnY1qwEYwRmMIVNrlwOdf
 paQAh1NVBzTytncBGlkLcYcGUILfz3GeCtSj1JveWfvMpTWo9BUmZ9gsHBetSuiKj59u
 YBlQXdPQ5ryy+tFZFScbC7xmZjYcto2PehmFuyUugLdLtxcwn8wQsdtShBXsJsXTWWS4
 hB4y4XUyPmnZ0v+y647zPeTH0oKNwo1slSkNUsnBNq0AGKl24U115pJqVSoltniS8DTj
 kBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560361; x=1753165161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g0sqOibqSPdGl3WuMtWvTYtbXoOWs5R7ZoQJ2IshoJo=;
 b=kevA14BgAM2wEN/Ju9mP6FD6xaspY08FXOtAGBXlAkAyvAM4DheQ6yNzfJMdEp4IqG
 THlFWqOXLsoV9u7fuMme/fDot5p4ipBZtTpZtv8/uArUtqmgTHXcsELEojrAgZGhxrkR
 aQe77aoWAzHorW7C3N+bCms277OQqRUMHq9uUifK/D0T7l+eM9d/6Vyk4gxj+WhXSXtj
 gnI1rVhxdgBIdxMbOOlIHEjZAmcaI4QeBreW9Eb697nqVap5MaUmM7HGB8Q2hqXt4sip
 Av22r9IKfqqBRF+mH1PHe5PPdHaz/LjGRJ8UquUhEeu+Ks8+4x78mPC+iqZ/VOsSH9K8
 Re6A==
X-Gm-Message-State: AOJu0Yx4ILMQd2MbPd/jRZ7MdCFWkTeTkdf5dsjNhFBYyKkRA/xC7vyp
 JTRtmjZBWkMJ9aKuwcmWllxm1kI9En6nn7rkkI7mkW4OtjQZmhP0z7N/aSiOLoUSLaHdCIMBssl
 NSnkC
X-Gm-Gg: ASbGncuIe/UwVqZSrRwWhQcatrR1P6AmrGSEtysSkgLuiN6/S0mn0nsyXiqlmbwWX0s
 HPpfNY2ux420Zv9gJITBzrDqNQcAESvMuIIL+jam0eRTIptaOUkL08wDNILGOTS2xe5G8Y3ND6O
 lDUxSQLuT1g3AvkVb1wzl2w8E1WvNQAuiK4RegvdzvNMgCwPqlnETnwvX4MWcaJrn4xDM4vXJL+
 hPLAX3OoP0n7fLHQfByO77v1okGZT8aUOzIkCTf6giDCl5R5Xv3kDT4hWlcVdKl96epp154zeZE
 RblKj3eeG7XnbNbrONQoOhpxQP2yY5SD4C9xQ0GrLbXrBl7ne1j0m0GpGeXDxh+AXxM2WdHix+X
 mmLEl/K6crQ2jMJY2JEAJjjCY5Fb/Gh7GZOvIAY/Xb06KXg4D959RbMxQ7qbKZKfrCSe2d0N9CH
 AUEEQz2s0=
X-Google-Smtp-Source: AGHT+IHeqU/X92XMMD7lPZGL+kjHsO3B8ZBarN1K1rlimVaRELx3y722Uq/z54UdzfYWdCPEhp6VbQ==
X-Received: by 2002:a05:600c:a216:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-45555e4c191mr98453515e9.9.1752560361304; 
 Mon, 14 Jul 2025 23:19:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45627962384sm6015875e9.2.2025.07.14.23.19.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 00/17] MIPS & Co. patches for 2025-07-15
Date: Tue, 15 Jul 2025 08:19:00 +0200
Message-ID: <20250715061918.44971-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/mips-20250715

for you to fetch changes up to 6f8ce26bb00db66e6cec632f16df3cd13e4df934:

  esp.c: only allow ESP commands permitted in the current asc_mode (2025-07-15 00:25:21 +0200)

----------------------------------------------------------------
MIPS patches queue

- Implement CRC32[c] (Release 6) instructions
- Convert Octeon LX instructions to decodetree
- Restrict ITU to TCG
- Fix ESP issue affecting WinNT (INACCESSIBLE_BOOT_DEVICE BSOD)
- Add missing FDT dependency for some MicroBlaze machines
- Remove execute bit on hppa-firmware blobs

----------------------------------------------------------------

Aleksandar Rakic (1):
  tests/tcg/mips: Add tests for MIPS CRC32[c] instructions

Bernhard Beschow (1):
  hw/microblaze: Add missing FDT dependency

Cole Robinson (1):
  roms: re-remove execute bit from hppa-firmware*

Mark Cave-Ayland (7):
  esp.c: only raise IRQ in esp_transfer_data() for CMD_SEL, CMD_SELATN
    and CMD_TI commands
  esp.c: improve comment in esp_transfer_data()
  esp.h: remove separate ESPState typedef
  esp.c: only call dma_memory_read function if transfer length is
    non-zero
  esp.c: only call dma_memory_write function if transfer length is
    non-zero
  esp.c: add asc_mode property to indicate the current ESP mode
  esp.c: only allow ESP commands permitted in the current asc_mode

Philippe Mathieu-Daudé (6):
  target/mips: Extract gen_base_index_addr() helper
  target/mips: Extract generic gen_lx() helper
  target/mips: Convert Octeon LX instructions to decodetree
  target/mips: Have gen_[d]lsa() callers add 1 to shift amount argument
  hw/mips: Restrict ITU to TCG
  hw/intc/loongarch_extioi: Remove unnecessary 'qemu/typedefs.h' include

Yongbok Kim (1):
  target/mips: Add support for emulation of CRC32 instructions

 include/hw/scsi/esp.h                         |  15 +-
 target/mips/helper.h                          |   2 +
 target/mips/tcg/translate.h                   |   4 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  32 ++++
 target/mips/tcg/octeon.decode                 |   8 +
 target/mips/tcg/rel6.decode                   |   5 +
 hw/intc/loongarch_extioi_kvm.c                |   1 -
 hw/mips/cps.c                                 |   4 +-
 hw/scsi/esp.c                                 |  94 ++++++++++--
 target/mips/tcg/msa_translate.c               |   4 +-
 target/mips/tcg/octeon_translate.c            |  12 ++
 target/mips/tcg/op_helper.c                   |  26 ++++
 target/mips/tcg/rel6_translate.c              |  16 +-
 target/mips/tcg/translate.c                   | 102 +++++++------
 target/mips/tcg/translate_addr_const.c        |   4 +-
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 142 ++++++++++++++++++
 target/mips/cpu-defs.c.inc                    |  10 +-
 target/mips/tcg/micromips_translate.c.inc     |   2 +-
 target/mips/tcg/nanomips_translate.c.inc      |   7 +-
 hw/microblaze/Kconfig                         |   4 +-
 hw/mips/Kconfig                               |   2 +-
 hw/misc/Kconfig                               |   1 +
 hw/scsi/trace-events                          |   1 +
 pc-bios/hppa-firmware.img                     | Bin
 pc-bios/hppa-firmware64.img                   | Bin
 target/mips/meson.build                       |   1 +
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  40 +++++
 34 files changed, 1447 insertions(+), 86 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
 mode change 100755 => 100644 pc-bios/hppa-firmware.img
 mode change 100755 => 100644 pc-bios/hppa-firmware64.img
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile

-- 
2.49.0


