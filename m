Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67DDC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGXc-0000nA-AA; Tue, 08 Jul 2025 18:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGC5-0003Jh-9g
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:49:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGC2-0002u6-Ek
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:49:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so26452415e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752011374; x=1752616174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2TPssIGpA26FxAQRYqaDNvET5x0SuwepHaZsGlb/dBw=;
 b=JLzY3OL1QHHf8V6O5czWUXG+866YXlOfYEnhPO8Jkw1P/eeyngMWER0GDyLyabKcCE
 1utfK6NDDf8q5/u4UGgx7LpkxEZsA1/JdNs1LWYR/TnCGLUsx12EfZ5zo9hDo7AQuOar
 FSXk1emS2DVBS6WbDVpHHMf8r2wCTHX9HQeh/CHuPZJVDTGivBUJV8MzfBV8Fa1jFQ2a
 B5AjIcD+IBWqzgjS8OJ5O065iPWBd1cKvqTnhJGs5GXTaSbIjQXUg2tJS/LlhN4bbMGy
 4dtxdvhxLbz+aPoFt3XeiSFxJKHMhEd49TIfg33ADTKmlMMfsk6iWpUTW+elmrmsFIn2
 V+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011374; x=1752616174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2TPssIGpA26FxAQRYqaDNvET5x0SuwepHaZsGlb/dBw=;
 b=AQRV67+PTWrhiz/czeHGcXVP+6ZNWono5LHHs+Mb5JSkBAkbRd2unS+NB9AbKwmB4J
 O3xOr+k3xh97OWI/OqCuZqRe3zFVtXqtQry/tLonVI7yCC1Knaq2hODjxxmlfbp/6z12
 h32zxYu75ooQHyeDzc/kzMS8O2Owy2iBATw1DlRBwYtYa4v/qJ4QSzNH7cdOPv32Yhvg
 6ZpkiToaa1bGg1PLhMIDFLRn0zggCVxvg/U0odrBKLVZeO6qLnl17qIf85NCY6X7xsGB
 1Tf9j16Bnc8ka96W/48mkJanXCVexYBFoDPBzSnR6PIXSp3fjUAWv/OkBmc92sL8M76/
 Nlbg==
X-Gm-Message-State: AOJu0YyA+Yd2iFWymu8frIlfOAdBfaI7JnuOcuqligEl5PH0W4iu2yYV
 fHNQtVCaFpomxcvXy0LKurB/Cscq7drVghNUy4v25TnQGlq2lgJ+W/8v74HJH1AItOW9+XVt0Kr
 p7pse
X-Gm-Gg: ASbGncuMUjDlPbWwg3zN6CIsNYSr1xcYJV/Ceu/yaEzlNiuL0pNqMvdccUL4zLlyDPJ
 AkAKxfOZdWv/8lZzFKxqVlOZumvaKgRv9ngseQVq9ChsX6NNvbi+rL0cNCYstXzH/+r8DAVZ8Ex
 Z+ygczo6TK8IVxbCaqjxEsJ2Nur/yAwG+aaqI/H8aAxHlOGvm/QW8YkxwDwBH+JFE5gakatAF69
 vFU88m3uf2mMI+X6QmSI/7gRcETCX5qiOfs2iWOAOytzaQ23VnMp8WwNPe5cO2k4P6Jdr3DWuH2
 ZbCcCPPZiszVxopV0/QbiH1XIXRWs4s2Qt0wMTJgGlAQVSJAUmwqJtPLvwxsNSOkYqXza6buT3e
 tZhzK5NABjUuKcatoTAoCl1UnzXvnmtBZ+OHJ
X-Google-Smtp-Source: AGHT+IECnQy8a/pNsmle0teIaY8bm8tVZJN3JkeuFQQKRFkJMHybmXrieGz5GX9W1JJE3Jt7cI3S8A==
X-Received: by 2002:a05:600c:6745:b0:453:8042:ba9a with SMTP id
 5b1f17b1804b1-454d367340fmr10191195e9.28.1752011374251; 
 Tue, 08 Jul 2025 14:49:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d506120fsm680505e9.17.2025.07.08.14.49.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 14:49:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v8 0/8] target-info: Add more API for VirtIO cleanups
Date: Tue,  8 Jul 2025 23:49:09 +0200
Message-ID: <20250708214918.70076-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Missing review: #6 (gdbstub)

Since v7:
- Fixed e.g. typo
- Keep "do *not* use target_big_endian()" warning
- Do not use tswap() in gdbstub

Since v6:
- Added R-b tags
- Fixed typos
- Dropped "Introduce target_base_arch()" because unused so far
- Dropped unrelated patches

Philippe Mathieu-Daudé (8):
  target/qmp: Use target_cpu_type()
  qemu/target-info: Factor target_arch() out
  qemu/target-info: Add %target_arch field to TargetInfo
  qemu/target-info: Add target_endian_mode()
  qemu: Convert target_words_bigendian() to TargetInfo API
  gdbstub/helpers: Replace TARGET_BIG_ENDIAN -> target_big_endian()
  qemu: Declare all load/store helper in 'qemu/bswap.h'
  hw/virtio: Build various files once

 include/exec/tswap.h                  | 83 +--------------------------
 include/gdbstub/helpers.h             | 48 ++++++++++------
 include/qemu/bswap.h                  | 73 +++++++++++++++++++++++
 include/qemu/target-info-impl.h       |  6 +-
 include/qemu/target-info-qapi.h       | 29 ++++++++++
 include/qemu/target-info.h            | 14 ++++-
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
 target-info-stub.c                    |  2 +
 target-info.c                         | 23 ++++++++
 target/arm/arm-qmp-cmds.c             |  3 +-
 target/arm/cpu.c                      |  1 -
 target/i386/tcg/system/excp_helper.c  |  1 -
 target/i386/xsave_helper.c            |  1 -
 target/loongarch/loongarch-qmp-cmds.c |  3 +-
 target/mips/system/mips-qmp-cmds.c    |  3 +-
 target/riscv/vector_helper.c          |  1 -
 tests/tcg/plugins/mem.c               |  1 +
 hw/block/meson.build                  |  6 +-
 hw/virtio/meson.build                 | 20 ++++---
 53 files changed, 218 insertions(+), 156 deletions(-)
 create mode 100644 include/qemu/target-info-qapi.h

-- 
2.49.0


