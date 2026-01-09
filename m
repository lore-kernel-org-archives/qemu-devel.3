Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393FCD232E6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6P3-0003TZ-7M; Fri, 09 Jan 2026 01:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Ox-0003IB-7B
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:16 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Ov-0002lh-5Q
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:14 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so381639b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941710; x=1768546510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4kCzV8SKF/VCOAOqVUBCL3eHkil6+RyiPVWq4lCM5Tk=;
 b=mrRx9jYKpE4qJ+loSXNLAcrw6ln3abpN+Qm3EiI30p02vU3R8NJbtaGhSl/ssT4KR2
 /pghdfK0f9n6xmWEIMkfKzMdxochtLXenah9OTRgCCGTQ958WYakI4oV4SbnSQ7sQEi0
 OeLjJd/v6C4i1QeRx96S4wiRh/8NInKt6p5eWrbi0ro6ruIH+myd0hitSBDLAYEVS60J
 /A9cIdP6D1x/pEFgwzNcXmVQ3dcZL8TCjTlHTgVse/ImryLMVKwcQyl16JVYoFHTDHMQ
 8KP55YaZSx8MUWR9z/rhR6LenTn1hTk2ss5dwZK6vcODNlg5ZC1l/6j3h5lRSTSpYwpB
 v4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941710; x=1768546510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kCzV8SKF/VCOAOqVUBCL3eHkil6+RyiPVWq4lCM5Tk=;
 b=qIHa6kv9du7Y1RFxgKvI5FYpEbmNOaPDIPsyRebjHKY/6bvBUHbR70OytWOBkyh6OW
 c4BeajxTVS6YSbUfXjPy8yGZhNuXS1jrA0WpmwPONJoEHyZhQbqwqKhGGEtVXNm/MaXj
 6u847ioVAQndGcAKbDcw18bGVOP6NsG3yfTTzIGlcFHT1yWQ3X40r7I5u5NAhzglyP03
 gbneURZmuqy3WSDhbhmAaPIiZNuvNjO7u5DnFq8XtM6jAHf8jNxe1OCJYgiREycgZEE/
 oTyDCpl8mlrDX6ahMzZKnz1X7NZ3vbCGo0ozfQn4n19QHWzoub5ppqd56qqcj65ZvGFj
 dgSg==
X-Gm-Message-State: AOJu0YzgJIoKwHgaL8JvGcRIbs38sYeDa3aFBKTwyzzEOSJy57N5Lza7
 3FB7UdTJ+HOOc2ZIZ9G6O6/MwBb4UbQkhprfIDVyHADrw+7KzmpSh7QUtHw6aA==
X-Gm-Gg: AY/fxX4+OrFPF57d8RN78qj2SxO6S56GrgPkIO8kN63fllTDP7PcZf/UJohskOda1cf
 wUZuBEGxh13igaO3qLq1dfRx7YU2icyUNhoDKHCW3WJ6gANsks9EgqIYUXGvZpWi6lJAxwddxtl
 edlCMkLCTk9wei89EnItqSK7mgSxxodazGqYCj9QKuSKc3Sk3vsoXW3N/k38B4vjmsBav8KGAYM
 IA6NRsDc9qqPQeFMRGvAX9Swedychrx1GQM3b7xDXIYRfcYrOSdDsk6vZn9au3W6kZ4FH87fRY0
 iKSPjqC4wBgpGGNYoWapZfLoYZglITk3FzKwjkGgumMubhMqZwve71wxX77xAo1qb+IPbKtdeJc
 iN2LNSg98s8KMJYz0xz+d5+twMp8BZWqSwiUBdZD1ZVAq8pAp2rnFsIzZlCh5h5jzWAB3Sh3gpb
 eFa5cH/+wqIozjgOidF3nlUPPEs4JPnAKu0P5tOfuNS8W/TKWaee9O4oMyw2985c4R6Bp1IZK6Y
 xCGug+sGaYWIRd52jsKnLD3Qwm+nA==
X-Google-Smtp-Source: AGHT+IGyNKMQDY1GR0JKD6NKiVyxwIMS5bv68m4Urb6pgcXUuXe921DW7A6uTeoH5eg5sl0rUEojiQ==
X-Received: by 2002:a05:6a20:430e:b0:35e:1a80:464 with SMTP id
 adf61e73a8af0-3898f9b994bmr8501483637.46.1767941709722; 
 Thu, 08 Jan 2026 22:55:09 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:08 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/34] riscv-to-apply queue
Date: Fri,  9 Jan 2026 16:54:25 +1000
Message-ID: <20260109065459.19987-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 3b5fe75e2c30e249acabe29924385782014c7632:

  Merge tag 'pull-monitor-2026-01-07' of https://repo.or.cz/qemu/armbru into staging (2026-01-08 17:45:15 +1100)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260109

for you to fetch changes up to e71111e26bdf5e98243d6a896c9e595e205dd9bb:

  test/functional: Add test for boston-aia board (2026-01-09 15:14:58 +1000)

----------------------------------------------------------------
First RISC-V PR for 11.

* Remove unused import statement from sifive_u test
* Free allocated memory in core/loader
* Add all available CSRs to 'info registers'
* Add 'riscv-aia' accel prop info to documentation
* Fix IOMMU MemoryRegion owner
* Make riscv cpu.h target partially independent
* Expand AIA target[i] source handling and refactor related code
* Don't look up DDT cache in Off and Bare modes
* Add Zilsd and Zclsd extension support
* Add RISCV ZALASR extension
* Add support for MIPS P8700 CPU

----------------------------------------------------------------
Akihiko Odaki (1):
      hw/riscv/riscv-iommu: Fix MemoryRegion owner

Alistair Francis (4):
      hw/core/loader: Fixup whitespace for get_image_size()
      hw/core/loader: Free the image file descriptor on error
      hw/core/loader: Free the allocated string from size_to_str()
      target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val

Anton Johansson (7):
      target/riscv: Fix size of trivial CPUArchState fields
      target/riscv: Fix size of mhartid
      target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read
      target/riscv: Combine mhpmevent and mhpmeventh
      target/riscv: Combine mcyclecfg and mcyclecfgh
      target/riscv: Combine minstretcfg and minstretcfgh
      target/riscv: Combine mhpmcounter and mhpmcounterh

Daniel Henrique Barboza (4):
      target/riscv/cpu: add riscv_dump_csr() helper
      target/riscv/cpu: print all FPU CSRs in riscv_cpu_dump_state()
      target/riscv: print all available CSRs in riscv_cpu_dump_state()
      docs/specs/riscv-aia.rst: add 'riscv-aia' accel prop info

Djordje Todorovic (12):
      target/riscv: Add cpu_set_exception_base
      target/riscv: Add MIPS P8700 CPU
      target/riscv: Add MIPS P8700 CSRs
      target/riscv: Add mips.ccmov instruction
      target/riscv: Add mips.pref instruction
      target/riscv: Add Xmipslsp instructions
      hw/misc: Add RISC-V CMGCR device implementation
      hw/misc: Add RISC-V CPC device implementation
      hw/riscv: Add support for RISCV CPS
      hw/riscv: Add support for MIPS Boston-aia board mode
      riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
      test/functional: Add test for boston-aia board

Frank Chang (1):
      hw/riscv: riscv-iommu: Don't look up DDT cache in Off and Bare modes

Nikita Novikov (2):
      hw/intc/riscv_aplic: Expand inactive source handling for AIA target[i]
      hw/intc/riscv_aplic: Factor out source_active() and remove duplicate checks

Roan Richmond (1):
      Add RISCV ZALASR extension

Thomas Huth (1):
      tests/functional/riscv64/test_sifive_u: Remove unused import statement

lxx (1):
      target/riscv: Add Zilsd and Zclsd extension support

 docs/specs/riscv-aia.rst                     |  43 ++-
 docs/system/riscv/mips.rst                   |  20 ++
 docs/system/target-riscv.rst                 |   1 +
 configs/devices/riscv64-softmmu/default.mak  |   1 +
 include/hw/misc/riscv_cmgcr.h                |  48 +++
 include/hw/misc/riscv_cpc.h                  |  64 ++++
 include/hw/riscv/cps.h                       |  66 ++++
 target/riscv/cpu-qom.h                       |   1 +
 target/riscv/cpu.h                           | 115 +++----
 target/riscv/cpu_cfg.h                       |   5 +
 target/riscv/cpu_vendorid.h                  |   1 +
 target/riscv/cpu_cfg_fields.h.inc            |   6 +
 target/riscv/insn16.decode                   |   8 +
 target/riscv/insn32.decode                   |  22 +-
 target/riscv/xmips.decode                    |  35 ++
 hw/core/loader.c                             |  15 +-
 hw/intc/riscv_aplic.c                        |  66 ++--
 hw/misc/riscv_cmgcr.c                        | 243 ++++++++++++++
 hw/misc/riscv_cpc.c                          | 265 +++++++++++++++
 hw/riscv/boston-aia.c                        | 476 +++++++++++++++++++++++++++
 hw/riscv/cps.c                               | 196 +++++++++++
 hw/riscv/riscv-iommu.c                       |  15 +-
 target/riscv/cpu.c                           | 157 +++++----
 target/riscv/cpu_helper.c                    |   2 +-
 target/riscv/csr.c                           | 239 +++++++-------
 target/riscv/machine.c                       |  99 +++---
 target/riscv/mips_csr.c                      | 217 ++++++++++++
 target/riscv/pmu.c                           | 150 ++-------
 target/riscv/tcg/tcg-cpu.c                   |  35 +-
 target/riscv/translate.c                     |   5 +
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 113 +++++++
 target/riscv/insn_trans/trans_xmips.c.inc    | 136 ++++++++
 target/riscv/insn_trans/trans_zilsd.c.inc    | 105 ++++++
 hw/misc/Kconfig                              |  17 +
 hw/misc/meson.build                          |   3 +
 hw/riscv/Kconfig                             |   6 +
 hw/riscv/meson.build                         |   3 +
 target/riscv/meson.build                     |   2 +
 tests/functional/riscv64/meson.build         |   2 +
 tests/functional/riscv64/test_boston.py      | 123 +++++++
 tests/functional/riscv64/test_sifive_u.py    |   1 -
 41 files changed, 2657 insertions(+), 470 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/xmips.decode
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
 create mode 100755 tests/functional/riscv64/test_boston.py

