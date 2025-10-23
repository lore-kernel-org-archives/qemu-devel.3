Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0319BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmj1-0000YF-6C; Thu, 23 Oct 2025 00:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmiz-0000Xe-II
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:14:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmix-00075L-1U
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:14:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-781251eec51so284148b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192889; x=1761797689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TC9ST5w810HGa9uPAOp2JqChSsuFmKsvxklpY77kCKg=;
 b=c30dxLy8UxJGjGsvnUj3Zhea8kIpZLoV+avQy0V+GqeBAa4CWIJQA0r/lXQ1SNlrpG
 BgiqTKVfVvFcKmq1nnsass3/nWJ1UBvRrMb8dn/kskYdZ8GLdrqVVfxR1sxJG6QI4JVq
 SZabCQrdu1soYyLTrkd20c7vnfeiBN3BY090BVV/aU1W2DcWjplTnXd12QYlBFUdsO9Y
 4Du83IsRFetA43g3vXvPc24KLatNTO41F4errXRdCpRPGTWZUOnpfigv3K1n/+Q8rkrF
 gMqu6nhcmAJ/HaGpgMBBchDAFpnb3I1jW1MlLPj1CTB+yRGNubtrT9F8DkmpOoWAsJY6
 ZUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192889; x=1761797689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TC9ST5w810HGa9uPAOp2JqChSsuFmKsvxklpY77kCKg=;
 b=d75vUQ7+l1bFGtjocbfXqjQRkrSgsKqLApYAGDBC9wFeO7i3dcMN1qZZYjkUXkvwEF
 Rhydb+UEWfTt7FKEeBAvmb9m+PeG/28oABXkzmknxrKUGH5NVK0ifPzrnoHyh1Rs1kSW
 XiW5WWQwl5LWItOZJTBNNuXlMEQ0+fFYqZ7E739VvVLpLSpkFhEjpiig+9S0IfB9Sgya
 N6Y/CmmsKowJZigq7W4Elc+88DTmcotBlNF2k5S2UgzA+Uy6gJiYS45w1RhJtzTAdyMV
 593tZIzAjkS/QWcPYdGgbPvruEPEyVzf0e7G8XPHHQftvnsvmuaXcmqjuPnsApb55bBe
 BaPw==
X-Gm-Message-State: AOJu0YzT/6aoXzxV2R3ISnjhZYMIHBbUk3sV/Q2yuzFtVM/1Z9FGp8U4
 UTovaq8YlitNYnTcZ9JVBcRvwTyH6RUz21K2ti0og8bdZ75EdEyX4EsL2kid8w==
X-Gm-Gg: ASbGncsxcM32xvGrd6ngWB9LF1HhWjDoWQnhvSiYnZEiv1p4LbtYCLOcKxr3wgNatHO
 TE1zojr4IAOQiPrA+JzWEiWWiPGSCaH9ezVuXQu5dGLTlkA/ZlETbECc25wLwWlXi6JeBiBJ0xU
 v08GdkRe9XXvACgY9chI9C5TWgMv4fubahPmNqb3KXwH1+wzwAd5Wyf/Fq6zikLTewo5AIg9UIk
 CFwonVKKRx55wIvg/mfZsgiwcoPF1v4eqWIYEm9j3JT1ytvQwDODfvR/FqPTv0FyfpbVpuCpD0/
 zCYd/J7GThxaTP+GZBlzDLXT2vKlPGKpsc04pSm4RpJRoMQ7rz86XpVC0h51MuTsskCB/amm0Df
 +oTTib4qqYWQAR1TP9AOacwDDn7pR35YLsM+dtdnwTG6FqFX3ktuPCj1B00JiZ3U/3DkbeCLHtq
 LPBS97uVYHK6T8DZeTfXm7TciXRAZ/gM8Dsowxg99Y82pG92RS2XfkJSgkViWJIzc7yBIwb2kPY
 TXE6lXSk4y/hA4IbXKE
X-Google-Smtp-Source: AGHT+IEHQvrdHHDa25IsuItueoB7OrluMwhYjltcDXAhTwcpWfnnau11TgczuBX9sRHJH38IAVePIQ==
X-Received: by 2002:a05:6a00:2e85:b0:781:187f:48d1 with SMTP id
 d2e1a72fcca58-7a274b85d39mr1376721b3a.1.1761192888951; 
 Wed, 22 Oct 2025 21:14:48 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:14:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/37] riscv-to-apply queue
Date: Thu, 23 Oct 2025 14:13:58 +1000
Message-ID: <20251023041435.1775208-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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

The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:

  Merge tag 'pull-vfio-20251022' of https://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20251023

for you to fetch changes up to 741566c3e07fd34ed28d4464d1d7fda67db12925:

  target/riscv: Make PMP CSRs conform to WARL constraints (2025-10-23 14:11:45 +1000)

----------------------------------------------------------------
Second RISC-V PR for 10.2

* Correct mmu-type property of sifive_u harts in device tree
* Centralize MO_TE uses in a pair of helpers
* Fix Ethernet interface support for microchip-icicle-kit
* Fix mask for smsiaddrcfgh
* Add support for MIPS P8700 CPU
* Fix env->priv setting in reset_regs_csr()
* Coverity-related fixes
* Fix riscv_cpu_sirq_pending() mask
* Fix a uninitialized variable warning
* Make PMP granularity configurable

----------------------------------------------------------------
Akihiko Odaki (1):
      target/riscv: Fix a uninitialized variable warning

Daniel Henrique Barboza (3):
      target/riscv/kvm: fix env->priv setting in reset_regs_csr()
      target/riscv/riscv-qmp-cmds.c: coverity-related fixes
      target/riscv: fix riscv_cpu_sirq_pending() mask

Djordje Todorovic (13):
      hw/intc: Allow gaps in hartids for aclint and aplic
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

Guenter Roeck (4):
      hw/net/cadence_gem: Support two Ethernet interfaces connected to single MDIO bus
      hw/riscv: microchip_pfsoc: Connect Ethernet PHY channels
      hw/net/cadence_gem: Add pcs-enabled property
      microchip icicle: Enable PCS on Cadence Ethernet

Jay Chang (2):
      target/riscv: Make PMP granularity configurable
      target/riscv: Make PMP CSRs conform to WARL constraints

Jialong Yang (1):
      aplic: fix mask for smsiaddrcfgh

Philippe Mathieu-Daudé (12):
      target/riscv: Explode MO_TExx -> MO_TE | MO_xx
      target/riscv: Conceal MO_TE within gen_amo()
      target/riscv: Conceal MO_TE within gen_inc()
      target/riscv: Conceal MO_TE within gen_load() / gen_store()
      target/riscv: Conceal MO_TE within gen_load_idx() / gen_store_idx()
      target/riscv: Conceal MO_TE within gen_fload_idx() / gen_fstore_idx()
      target/riscv: Conceal MO_TE within gen_storepair_tl()
      target/riscv: Conceal MO_TE within gen_cmpxchg*()
      target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr() / gen_sc()
      target/riscv: Factor MemOp variable out when MO_TE is set
      target/riscv: Introduce mo_endian() helper
      target/riscv: Introduce mo_endian_env() helper

Zejun Zhao (1):
      hw/riscv: Correct mmu-type property of sifive_u harts in device tree

 docs/system/riscv/mips.rst                    |  20 ++
 docs/system/target-riscv.rst                  |   1 +
 configs/devices/riscv64-softmmu/default.mak   |   1 +
 include/hw/misc/riscv_cmgcr.h                 |  50 +++
 include/hw/misc/riscv_cpc.h                   |  64 ++++
 include/hw/net/cadence_gem.h                  |   4 +
 include/hw/riscv/cps.h                        |  66 ++++
 target/riscv/cpu-qom.h                        |   1 +
 target/riscv/cpu.h                            |   8 +
 target/riscv/cpu_cfg.h                        |   5 +
 target/riscv/cpu_vendorid.h                   |   1 +
 target/riscv/cpu_cfg_fields.h.inc             |   4 +
 target/riscv/xmips.decode                     |  35 ++
 hw/intc/riscv_aclint.c                        |  18 +-
 hw/intc/riscv_aplic.c                         |  42 ++-
 hw/misc/riscv_cmgcr.c                         | 248 ++++++++++++++
 hw/misc/riscv_cpc.c                           | 265 ++++++++++++++
 hw/net/cadence_gem.c                          |  31 +-
 hw/riscv/boston-aia.c                         | 476 ++++++++++++++++++++++++++
 hw/riscv/cps.c                                | 196 +++++++++++
 hw/riscv/microchip_pfsoc.c                    |   6 +
 hw/riscv/sifive_u.c                           |   2 +-
 target/riscv/cpu.c                            |  83 +++++
 target/riscv/cpu_helper.c                     |   3 +-
 target/riscv/kvm/kvm-cpu.c                    |   1 +
 target/riscv/mips_csr.c                       | 217 ++++++++++++
 target/riscv/op_helper.c                      |  30 +-
 target/riscv/pmp.c                            |  46 +++
 target/riscv/riscv-qmp-cmds.c                 |  22 +-
 target/riscv/tcg/tcg-cpu.c                    |  12 +-
 target/riscv/translate.c                      |  19 +-
 target/riscv/insn_trans/trans_rva.c.inc       |  50 +--
 target/riscv/insn_trans/trans_rvd.c.inc       |   6 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |   6 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  24 +-
 target/riscv/insn_trans/trans_rvzabha.c.inc   |  20 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  12 +-
 target/riscv/insn_trans/trans_rvzce.c.inc     |  12 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |   8 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  10 +-
 target/riscv/insn_trans/trans_xmips.c.inc     | 136 ++++++++
 target/riscv/insn_trans/trans_xthead.c.inc    |  98 +++---
 hw/misc/Kconfig                               |  17 +
 hw/misc/meson.build                           |   3 +
 hw/riscv/Kconfig                              |   6 +
 hw/riscv/meson.build                          |   3 +
 target/riscv/meson.build                      |   2 +
 tests/functional/riscv64/meson.build          |   2 +
 tests/functional/riscv64/test_boston.py       | 123 +++++++
 49 files changed, 2356 insertions(+), 159 deletions(-)
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
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100755 tests/functional/riscv64/test_boston.py

