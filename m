Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF089F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHv2-0008QJ-IF; Fri, 10 Apr 2026 15:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHv1-0008PV-7c
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHuy-0000P8-P6
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso28729135e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850807; x=1776455607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJ7qV7zH96OL2L71+arnff/3Q9xB19XbqUaejFBbdEI=;
 b=k4FSiEr6TQj5ox3SHwB7EjrRvrYgyo/6pf5QNHkht7rYnlvIqaZ06b+Jhqg/pD+nLc
 ULlUOM0+w9NMyF+eD8jbuk8dAXLIJyEQ71FOmE9UHWqqlW2sm1vRm3FMifyVf5nwRJDH
 mXZ5xB2qqleMYSJZD68iSuiObkJqtaWT5k5+exkI4G5WlfFllk5WImy638vddbq2jH0E
 cT45IAfbLIcAFq1IfmozWYw8LR2yqOiJk/5wFsklttY37Cgd/foPPxiOG1TpUuVKKh3r
 pP+zufMKrBaXdcdNy0nG0opah1O8/FhxzPEB678SeebomEGnzVVO+EkcrEbsqsBUGtvt
 Cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850807; x=1776455607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJ7qV7zH96OL2L71+arnff/3Q9xB19XbqUaejFBbdEI=;
 b=qpiGbiVSgdI5vRQWcWiW7sFoKD+bJisXoGhbnDO/cMgPJqplI78NB6ddMb7cDgEOfj
 9HuERa2804YDMSstAQ8JywVtT45x0vMNG3mWuuF26Z/4KW2aEzs2W5IDUxVjRfdqnnNz
 wl0oKXzyGF8hLNnsF9ngMAQ99U0IQMOb8+Alk752y3TYh3KMnlWM8h8I71vH/5lXpSJO
 MLrAnjChVg+JYpCxw61L1KswGhiHZCGF8dMsi+OeqkY7r2+qTF7vl/8CVGpLJ1PAz/Fx
 2rtpcNJQDfpO+SlqgFOUIecyYRPIoY0ee4gYxdk5rAFc79V9rO69y6aj8MN8UTnWNwOf
 8N9g==
X-Gm-Message-State: AOJu0Yy/kT5vGHzGxRsRqPsWoe0tVBUyUP0CCAfCHHuqkY9oycdij9w7
 bDKwImaRSJsj3dfC5l9ZrJ/WxXQYdej9dDreOIAMNM0d7wOKiz4TNuJjqcm65uESRT2ya3T0tNm
 NwpTYMEo=
X-Gm-Gg: AeBDieubAoIrPjv6x098J6SiDy/2lsUbCEpSN/aK/QHE7SMJBy4AZHG18vZfUuwKJcs
 uUTEPjj8zkTQSZ6ndRkKqtEnmfP52fxrz0RTvscdNPsKrBKSZTKKekGXHa+dzDmB9cbxMYs2uuh
 rGGyfsBSy7JQfYmA6lFO6Jh5vnK1IDcAQZdT2aHn+9diK+RZao3l2gzIVr8iczpZ0cfS3KpxjIx
 Ot2cEyA7sDilsUtdE3LUiV8vHCZ2hSHwjVwk9dzo2am55NE+I5GGUVlc2OJ04NnbOf9zGGpQI2t
 CdbJMXK19LaOHdFxuP42Y0Qq9R4B9bSZYMAONT/sPYFlRmXiqwnmRsl1lwzwQAmR4o7k08iX6j6
 c3PIK8sjRTUs+lJjVdbEnOqPn3xNVPRG86Ojnr0Qqo1uwYEBNw1xtWL+QMjpuNzaevkJIVYKYfM
 n9yKXJU3dEXSlEQeod7Cs/NHfIl1ib7YA0K6yLwYD+1DOiIO9BiJP8P3Nrl/du6SMmJg5hvWdu
X-Received: by 2002:a05:6000:25c4:b0:439:c299:4d8f with SMTP id
 ffacd0b85a97d-43d64271215mr6998283f8f.17.1775850805518; 
 Fri, 10 Apr 2026 12:53:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46a85sm9883266f8f.24.2026.04.10.12.53.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:53:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/27] monitor: Remove need of per-target handlers
Date: Fri, 10 Apr 2026 21:52:54 +0200
Message-ID: <20260410195323.17937-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Changes needed for the single binary (and heterogeneous emulation).

Convert target_monitor_defs() and target_monitor_defs()
to SysemuCPUOps fields, adapting the 4 targets using these
'legacy' code.

Instead of filtering the commands per target / device at
build time, add a new field to HMPCommand to filter them
at runtime, allowing to compile the command array once.

Philippe Mathieu-Daudé (27):
  monitor: Have MonitorDef::get_value() always return int64_t type
  monitor: Remove target_long use in get_monitor_def()
  monitor: Reduce target-specific methods further
  monitor: Remove 'monitor/hmp-target.h' header
  monitor: Forward-declare the MonitorDef type
  cpus: Introduce SysemuCPUOps::monitor_defs hook
  target/i386: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/m68k: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
  target/sparc: Replace target_monitor_defs ->
    SysemuCPUOps::monitor_defs
  monitor: Remove target_monitor_defs()
  cpus: Introduce SysemuCPUOps::monitor_get_register() hook
  target/riscv: Register target_get_monitor_def in SysemuCPUOps
  monitor: Remove target_get_monitor_def()
  monitor/meson: Use SPICE with migration HMP commands
  stubs: Rename monitor* -> qmp* files
  monitor: Make 'info via' a generic command
  monitor: Make Xen emulation commands generic ones
  system: Expose 'arch_init.h' as 'qemu/target-arch-defs.h'
  monitor: Introduce HMPCommand::arch_bitmask field
  hw/s390x: Reduce 'monitor/monitor.h' inclusions
  monitor: Do not check TARGET_S390X to build s390x commands
  monitor: Do not check TARGET_I386 to build target/i386/ commands
  monitor: Do not check TARGET_I386 to build 'info sgx' command
  monitor: Do not check TARGET_I386 to build 'info sev' command
  monitor: Do not check TARGET_I386/RISCV to build 'info mem' command
  monitor: Do not check multiple TARGET_* to build 'info tlb' command
  monitor: Merge hmp-target.c code within hmp-cmds.c

 MAINTAINERS                                   |  14 ++-
 include/hw/core/sysemu-cpu-ops.h              |  13 ++
 include/hw/s390x/storage-attributes.h         |   4 -
 include/hw/s390x/storage-keys.h               |   3 -
 include/monitor/hmp-target.h                  |  46 -------
 include/monitor/hmp.h                         |  21 ++++
 .../qemu/base-arch-defs.h                     |  10 +-
 include/qemu/typedefs.h                       |   1 +
 monitor/monitor-internal.h                    |   7 +-
 target/riscv/internals.h                      |   3 +
 hw/i386/kvm/xen-stubs.c                       |  12 ++
 hw/i386/sgx-hmp-stub.c                        |  16 +++
 hw/i386/sgx-stub.c                            |   6 -
 hw/i386/sgx.c                                 |   1 -
 hw/misc/mos6522-stub.c                        |  16 +++
 hw/pci/pci.c                                  |   2 +-
 hw/s390x/s390-skeys.c                         |   2 +
 hw/s390x/s390-stattrib.c                      |   2 +
 monitor/hmp-cmds.c                            |  41 ++++++-
 monitor/hmp-target.c                          | 115 ------------------
 monitor/hmp.c                                 |  53 +++++++-
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
 stubs/target-get-monitor-def.c                |  29 -----
 stubs/target-monitor-defs.c                   |   7 --
 system/arch_init.c                            |   2 +-
 system/qdev-monitor.c                         |   2 +-
 system/vl.c                                   |   2 +-
 target/i386/cpu-apic.c                        |   1 -
 target/i386/cpu.c                             |  24 ++++
 target/i386/monitor.c                         |  26 ----
 target/i386/sev-system-stub.c                 |   6 -
 target/i386/sev.c                             |   1 -
 target/m68k/cpu.c                             |  18 +++
 target/m68k/monitor.c                         |  22 ----
 target/ppc/monitor.c                          |   2 -
 target/riscv/cpu.c                            |   1 +
 target/riscv/monitor.c                        |   5 +-
 target/sh4/monitor.c                          |   1 -
 target/sparc/cpu.c                            |  19 +++
 target/sparc/monitor.c                        |  19 ---
 target/xtensa/monitor.c                       |   1 -
 hmp-commands-info.hx                          |  26 ++--
 hmp-commands.hx                               |  13 +-
 hw/i386/meson.build                           |   1 +
 hw/misc/meson.build                           |   1 +
 migration/meson.build                         |   2 +-
 monitor/meson.build                           |   5 +-
 stubs/meson.build                             |  23 ++--
 60 files changed, 368 insertions(+), 347 deletions(-)
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


