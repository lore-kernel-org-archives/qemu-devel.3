Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA958C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpY1-0003gF-RV; Mon, 07 Jul 2025 13:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpVq-0000KY-17
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:19 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpVm-0004xT-Ia
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a528243636so1960000f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908812; x=1752513612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VwlvYMLKGx15+uSdEjsebhQs/sGbFO9TGa0DA+Ywmbs=;
 b=slskS9gbDezEGGyxN738Fe/nkwSs07DsVX6vV5fYM5Ha2FgbrrCkcj5a9Fkesoe1Au
 mOmEwtcZtIcDeYtALlXquN09jQsY1AUtpvcD86Aw2elJsJwOl/GdF//pEzvIKqbAHFKI
 kw/KdVMswAtzP6WEiPNLKR4CdKXM2SpjO6EhP2VDQOkHavvR3bfXmiFi5UvfiwvnUF2Y
 1CtzaUn2h1DBdEH9mRBGurbWH9UGGsuKIxN6O5Ygco5DFtDJdeS9igzjGMf3kJsac8rO
 SezMr0zTqM169KyzpB/WfUuthwFyNkf7XaldPCZGhKk4Z6svpTA3JuLCQFxNE1fH4C1H
 tTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908812; x=1752513612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VwlvYMLKGx15+uSdEjsebhQs/sGbFO9TGa0DA+Ywmbs=;
 b=RPSvydIa4BjkNUeOYyKaxcbHOKf762SYnPMpobH0/01ygLhjEh5uZB+gITl32N58zA
 +Pl/UJEAfg176DzS47mVxfsntRSzCe7ikI/gaAwSEwPVI3tA9vtfdwilY9+eKtjS/En7
 Bdp+y40aXN0D/sTlWEuPykstDJo+G9rgc6c6fw2wD1bPHlnft9H8ftkgJxmYuQL9/uSC
 sal9ysiCcPrUWaOK6FB5b+TT3D7fFhcsqcTh4jkxD0VWLCejZoRYOOrJcKNdYmveQezV
 V2B4ks2uqP2hCPLLh5GQO9raJyhiaF54QxDrcDMHxk2F/WuKUeTaDAE5eQuRXTfPOmH6
 BfSw==
X-Gm-Message-State: AOJu0YzVpXh2KlwNMVYhFup2BENN9KiJuWcLIjNcex4A4CZmAlcLwZ8a
 tWWC+viuYevy8Is8chg7cboSDb+iCmnuq6wG1UN4yXUIgHhF0VArOIsPAaOBpTMH31mPYgKYm/I
 zhzYfFKs=
X-Gm-Gg: ASbGncvNgk9wUuEfokicOfrL0g4dqdasCMdPqTu5aHVdg3gumHjKLBO30Ev1BkMk5mD
 0A4Hy7Og39W68RNjysOL0STLlXhHBhD64BRR08uZe68Gye/uHojPkT4mtyY6RlAGNiuzChBHG/e
 lb4+iwWQDRJ2Q7MjaIvtguTthRO/UTLC6NIZzFk5dSaDxuzv7BD02vbDP5Nd5VNhEp+viZDkUgD
 m7zFZax6M0LQ2wcxtGoyo1qP0xyg5xBvWBUzBUuvPq5XD0DLwYwxeIwT0ahKmjDgiCncanal6ZN
 1lsvZX7Echen1iYVyyC3xoA8oOEjc+zbS7ZROp0gstBetZ3MqhGVJ7FRUTRWPIvN6ed3NOw3qZ4
 WYNOhAc36F5ELfDijlrfAC3pDUUBJKZaAeWSS
X-Google-Smtp-Source: AGHT+IFXJaWZblJsvgvZ9YocoQ5qQUoqaCOLEEeQ4pK3oPMgd5g7JTcoK86RS82udO6VSR0rHXnl5A==
X-Received: by 2002:a05:6000:25e3:b0:3a8:38b3:1aa1 with SMTP id
 ffacd0b85a97d-3b49aa7746bmr6842620f8f.27.1751908811677; 
 Mon, 07 Jul 2025 10:20:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b472767a20sm10623419f8f.86.2025.07.07.10.20.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:20:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 v6 00/14] target-info: Add more API for VirtIO
 cleanups & introduce ARM macros
Date: Mon,  7 Jul 2025 19:19:54 +0200
Message-ID: <20250707172009.3884-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Rather than re-spinning the whole "single-binary: Make hw/arm/
common" series, restrict to the API additions, but include
examples of their usefulness (hundreds of virtio objects
removed from default Linux build).
Time passed since I context-switched out of this work so I'm
not sure the DEFINE_MACHINE_WITH_INTERFACES() implementation
is in the form Zoltan asked.

Philippe Mathieu-Daudé (14):
  target/qmp: Use target_cpu_type()
  qemu/target-info: Factor target_arch() out
  qemu/target-info: Add %target_arch field to TargetInfo
  qemu/target-info: Introduce target_base_arch()
  qemu/target-info: Add target_endian_mode()
  qemu: Convert target_words_bigendian() to TargetInfo API
  gdbstub/helpers: Replace TARGET_BIG_ENDIAN -> target_big_endian()
  qemu: Declare all load/store helpert in 'qemu/bswap.h'
  hw/virtio: Build various files once
  hw/core/null-machine: Define machine as generic QOM type
  hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
  hw/boards: Introduce DEFINE_MACHINE_WITH_INTERFACES() macro
  hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64() macros

 meson.build                           |  1 +
 include/exec/tswap.h                  | 83 +--------------------------
 include/gdbstub/helpers.h             | 15 ++---
 include/hw/arm/machines-qom.h         | 31 ++++++++++
 include/hw/boards.h                   |  6 +-
 include/qemu/bswap.h                  | 73 +++++++++++++++++++++++
 include/qemu/target-info-impl.h       |  8 ++-
 include/qemu/target-info-qapi.h       | 36 ++++++++++++
 include/qemu/target-info.h            | 10 +++-
 include/system/memory.h               |  1 -
 include/user/abitypes.h               |  1 -
 target/ppc/mmu-hash64.h               |  2 -
 cpu-target.c                          |  7 ---
 hw/acpi/bios-linker-loader.c          |  2 -
 hw/arm/allwinner-r40.c                |  1 -
 hw/arm/boot.c                         |  2 +
 hw/arm/npcm7xx.c                      |  2 +-
 hw/block/hd-geometry.c                |  1 -
 hw/char/riscv_htif.c                  |  1 -
 hw/core/cpu-system.c                  |  2 +-
 hw/core/machine-qmp-cmds.c            |  8 +--
 hw/core/null-machine.c                | 20 ++++++-
 hw/cxl/cxl-events.c                   |  2 -
 hw/display/artist.c                   |  1 +
 hw/display/ati.c                      |  1 +
 hw/display/vga.c                      |  2 +-
 hw/net/can/ctucan_core.c              |  1 -
 hw/net/lan9118.c                      |  1 +
 hw/net/rtl8139.c                      |  1 +
 hw/net/vmxnet3.c                      |  1 -
 hw/pci-host/gt64120.c                 |  1 +
 hw/pci-host/pnv_phb3.c                |  1 +
 hw/pci-host/pnv_phb4.c                |  1 +
 hw/pci-host/ppce500.c                 |  1 -
 hw/pci-host/sh_pci.c                  |  1 -
 hw/s390x/s390-pci-inst.c              |  1 +
 hw/sensor/lsm303dlhc_mag.c            |  1 -
 hw/smbios/smbios.c                    |  1 +
 hw/vfio/migration-multifd.c           |  1 -
 hw/virtio/virtio-config-io.c          |  1 -
 hw/virtio/virtio-pci.c                |  1 +
 hw/virtio/virtio.c                    |  2 +-
 hw/vmapple/virtio-blk.c               |  1 -
 system/memory.c                       |  1 +
 system/qtest.c                        |  1 +
 target-info-qom.c                     | 24 ++++++++
 target-info-stub.c                    |  3 +
 target-info.c                         | 33 +++++++++++
 target/arm/arm-qmp-cmds.c             |  3 +-
 target/arm/cpu.c                      |  1 -
 target/arm/machine.c                  | 12 ++++
 target/i386/tcg/system/excp_helper.c  |  1 -
 target/i386/xsave_helper.c            |  1 -
 target/loongarch/loongarch-qmp-cmds.c |  3 +-
 target/mips/system/mips-qmp-cmds.c    |  3 +-
 target/riscv/vector_helper.c          |  1 -
 tests/tcg/plugins/mem.c               |  1 +
 hw/block/meson.build                  |  6 +-
 hw/virtio/meson.build                 | 20 ++++---
 59 files changed, 302 insertions(+), 149 deletions(-)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 include/qemu/target-info-qapi.h
 create mode 100644 target-info-qom.c

-- 
2.49.0


