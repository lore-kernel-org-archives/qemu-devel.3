Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12747FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH0Q-0000Tx-2S; Mon, 27 Apr 2026 04:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0M-0000TO-JJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:07:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0K-00016v-C4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:07:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso80713535e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277262; x=1777882062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cRdKTwaViuti0IsXh3G6zVaoRtewZVdl6XkNeSs1K14=;
 b=Gac8VkXCWlctV+/bBLAE+RJeS57CNxVJrmXicov//0Zad4FIYVa+bihzqOjyruTFSc
 /APz5LfjcHsFdsexmJjgIMMUWkxgxaRjXN7tXKaTs8V1a2NfB8DK/oMvSV2ss6fu2IQr
 evrvvFn+E/bTmeGUYmubejFNS9/uChfDRVT7NQpToQJ2aIsy2cc28Z5/l4fgXkR0yc4G
 zgP8rvbDnTJR0tJeCQfIeth4jCQfpbGf8N3ipoVfG1gxR0RYpZ2rkdUi57Hu7V6z6cie
 cLDHyTGPEmdOASoObQgomq9zNMbosNMocm7hA38kAcP7gsmqeeJvsmSOWEnyMTAZxUtL
 AHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277262; x=1777882062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRdKTwaViuti0IsXh3G6zVaoRtewZVdl6XkNeSs1K14=;
 b=F7Qjd1RvT/C1UamRMJxllJPwnUdRk/s+mONsmRuzEhtJu++l4FH8NDk29VDhbBy26f
 1h5IbkQHLLWfJznBVACptCuKNaJb0kb+Lspo4Szqwr/c1LnhcWnsof+Ya6gMf8uz1A5A
 Y5JjpsPZWu655boWBVCU65gsDXvtgVL7jLDE1+qNWL+zYJaEv5TR3/V+TmMM3Fb9Bl0H
 5BhAhTMQdTTG6i0ldYL5qltYU78cC8+MCdn3Uog2ayxinVaWI+FLGjDLDP9J3wObDWVz
 KPylWvAUT3EEEktWBvHciuContWjqFYOkvwowuZJf8HrTW5p6zcQo6Su+dXJHwktI/5b
 EpQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+H4ftQDqJnWSvpHT3ufXBg5pB6O57Q5bxq6v8RvgWi7DwSRRkQUGguUAuWkxmKhG69oB7p+eIYFyHn@nongnu.org
X-Gm-Message-State: AOJu0Ywa2jBivXe3FSlROMhb0+Kxbo5ykeqr49arO/v//j/tw+RpG17D
 K/oRkdZhxnsR2lmoJcxm2Tdt1Vx7pTsd53Eeql1qRfRMbZkjGUVL4iUZ69T+HyPNtzSMvDb6AXb
 vtaGmems=
X-Gm-Gg: AeBDieuQBEmHYAwwE8YoMW1Z0p01aEISLJ7gVDihPfy35Un+ZbXSnwf7aCrII7ZCgDl
 BY1ppOj2fVIco2KO5Mhkjg8PzVMRYNDtMsOpIHV3ImHTrZG/VFb+v1/QtfwiVzKPPpCI5xlJoLC
 n4+EwUS8EN8sB3DP6gmctZcc3B9seuKU7eNfWP6gsn+a0ZvHtpNh0FfGlJRhyv5yIxfiF/q857T
 Erz7PzDEH/bULQjR0/4wkE9TqbqWhnNwmNpPcP0MaGgURAeaiBcJMAE7XoW+3o34WhGxy5uIRGL
 Ef1U32EorBrEA14vzr1kk4TDn0uEqjsdtjllyrksd2Kzk8ej+ywDpeno5EUkaBH1bwx2b7sGwDV
 YkLr4c8d8S2HCtrSezgS3a7QGGncUmvJ2qULDkYoYfYPiwWoEI/jyZ55j8jUKwVLiMOHE83Rpaz
 oaS6ONv0K/4jvWvg1XAjDhSwh8HitUPFUuq7uXaJznYT+t4uBRyj0N7x7LStfOhJPhgHynOWebm
 d4UO4tMCKioZrJyFAtwfA==
X-Received: by 2002:a05:600c:1d22:b0:48a:6798:52e9 with SMTP id
 5b1f17b1804b1-48a6798548fmr170265015e9.0.1777277261992; 
 Mon, 27 Apr 2026 01:07:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891f98728dsm169172445e9.23.2026.04.27.01.07.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:07:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 00/32] monitor: Remove need of per-target handlers
Date: Mon, 27 Apr 2026 10:07:06 +0200
Message-ID: <20260427080738.77138-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Missing review: 32

Since v3:
- Rebased

Since v2:
- Addressed rth review comments

Changes needed for the single binary (and heterogeneous emulation).

Convert target_monitor_defs() and target_monitor_defs()
to SysemuCPUOps fields, adapting the 4 targets using these
'legacy' code.

Instead of filtering the commands per target / device at
build time, add a new field to HMPCommand to filter them
at runtime, allowing to compile the command array once.

Philippe Mathieu-Daudé (32):
  monitor/hmp: : Include missing 'exec/target_long.h' header
  target/sparc/monitor: Dump all registers as 32-bit
  monitor: Remove MonitorDef::type field and MD_TLONG / MD_I32
  monitor: Extract completion declarations to 'monitor/hmp-completion.h'
  stubs: Rename monitor* -> qmp* files
  monitor/meson: Use SPICE with migration HMP commands
  monitor: Restrict monitor_set_cpu() method scope
  monitor: Make 'info via' a generic command
  monitor: Make Xen emulation commands generic ones
  system: Expose 'arch_init.h' as 'qemu/base-arch-defs.h'
  monitor: Introduce HMPCommand::arch_bitmask field
  hw/s390x: Reduce 'monitor/monitor.h' inclusions
  monitor: Do not check TARGET_S390X to build s390x commands
  monitor: Do not check TARGET_I386 to build target/i386/ commands
  monitor: Do not check TARGET_I386 to build 'info sgx' command
  monitor: Do not check TARGET_I386 to build 'info sev' command
  monitor: Do not check TARGET_I386/RISCV to build 'info mem' command
  monitor: Do not check multiple TARGET_* to build 'info tlb' command
  cpus: Introduce SysemuCPUOps::monitor_get_register() hook
  target/riscv: Register target_get_monitor_def in SysemuCPUOps
  monitor: Remove target_get_monitor_def()
  monitor: Have MonitorDef::get_value() always return int64_t type
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header
  monitor: Forward-declare the MonitorDef type
  cpus: Introduce SysemuCPUOps::monitor_defs hook
  target/i386: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/m68k: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/sparc: Replace target_monitor_defs ->
    SysemuCPUOps::monitor_defs
  monitor: Remove target_monitor_defs()
  monitor: Merge hmp-target.c code within hmp-cmds.c
  monitor: Remove hmp_info_pic() left-over declaration

 MAINTAINERS                                   |  16 ++-
 include/hw/core/sysemu-cpu-ops.h              |  14 ++
 include/hw/s390x/storage-attributes.h         |   4 -
 include/hw/s390x/storage-keys.h               |   3 -
 include/monitor/hmp-completion.h              |  40 ++++++
 include/monitor/hmp-target.h                  |  50 -------
 include/monitor/hmp.h                         |  43 +++---
 include/monitor/monitor.h                     |   1 -
 .../qemu/base-arch-defs.h                     |  10 +-
 include/qemu/typedefs.h                       |   1 +
 monitor/monitor-internal.h                    |  13 +-
 target/riscv/internals.h                      |   3 +
 chardev/char-hmp-cmds.c                       |   1 +
 hw/i386/kvm/xen-stubs.c                       |  12 ++
 hw/i386/sgx-hmp-stub.c                        |  16 +++
 hw/i386/sgx-stub.c                            |   6 -
 hw/i386/sgx.c                                 |   1 -
 hw/misc/mos6522-stub.c                        |  16 +++
 hw/pci/pci.c                                  |   2 +-
 hw/s390x/s390-skeys.c                         |   2 +
 hw/s390x/s390-stattrib.c                      |   2 +
 migration/migration-hmp-cmds.c                |   1 +
 monitor/hmp-cmds.c                            |  41 +++++-
 monitor/hmp-target.c                          | 124 ------------------
 monitor/hmp.c                                 |  45 ++++++-
 net/net-hmp-cmds.c                            |   1 +
 qom/qom-hmp-cmds.c                            |   1 +
 stubs/hmp-cmd-info_mem.c                      |  12 ++
 stubs/hmp-cmd-info_sev.c                      |  16 +++
 stubs/hmp-cmd-info_tlb.c                      |  12 ++
 stubs/hmp-cmds-hw-s390x.c                     |  15 +++
 stubs/hmp-cmds-target-i386.c                  |  13 ++
 stubs/{monitor-arm-gic.c => qmp-arm-gic.c}    |   0
 ...or-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |   0
 .../{monitor-cpu-s390x.c => qmp-cpu-s390x.c}  |   0
 stubs/{monitor-cpu.c => qmp-cpu.c}            |   0
 stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}  |   0
 stubs/{monitor-i386-sev.c => qmp-i386-sev.c}  |   0
 stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}  |   0
 stubs/{monitor-i386-xen.c => qmp-i386-xen.c}  |   0
 stubs/target-get-monitor-def.c                |  29 ----
 stubs/target-monitor-defs.c                   |   7 -
 system/arch_init.c                            |   2 +-
 system/qdev-monitor.c                         |   3 +-
 system/runstate-hmp-cmds.c                    |   1 +
 system/vl.c                                   |   2 +-
 target/i386/cpu-apic.c                        |   1 -
 target/i386/cpu.c                             |  29 ++++
 target/i386/monitor.c                         |  26 ----
 target/i386/sev-system-stub.c                 |   6 -
 target/i386/sev.c                             |   1 -
 target/m68k/cpu.c                             |  18 +++
 target/m68k/monitor.c                         |  22 ----
 target/ppc/monitor.c                          |   2 -
 target/riscv/cpu.c                            |   1 +
 target/riscv/monitor.c                        |  12 +-
 target/sh4/monitor.c                          |   1 -
 target/sparc/cpu.c                            |  19 +++
 target/sparc/monitor.c                        |  19 ---
 target/xtensa/monitor.c                       |   1 -
 trace/trace-hmp-cmds.c                        |   1 +
 ui/ui-hmp-cmds.c                              |   1 +
 hmp-commands-info.hx                          |  26 ++--
 hmp-commands.hx                               |  13 +-
 hw/i386/meson.build                           |   1 +
 hw/misc/meson.build                           |   1 +
 migration/meson.build                         |   2 +-
 monitor/meson.build                           |   5 +-
 stubs/meson.build                             |  23 ++--
 69 files changed, 425 insertions(+), 387 deletions(-)
 create mode 100644 include/monitor/hmp-completion.h
 delete mode 100644 include/monitor/hmp-target.h
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)
 create mode 100644 hw/i386/sgx-hmp-stub.c
 create mode 100644 hw/misc/mos6522-stub.c
 delete mode 100644 monitor/hmp-target.c
 create mode 100644 stubs/hmp-cmd-info_mem.c
 create mode 100644 stubs/hmp-cmd-info_sev.c
 create mode 100644 stubs/hmp-cmd-info_tlb.c
 create mode 100644 stubs/hmp-cmds-hw-s390x.c
 create mode 100644 stubs/hmp-cmds-target-i386.c
 rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
 rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
 rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
 rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
 rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
 rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
 rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
 rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)
 delete mode 100644 stubs/target-get-monitor-def.c
 delete mode 100644 stubs/target-monitor-defs.c

-- 
2.53.0


