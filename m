Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDDACD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV5x-0004bN-V9; Thu, 30 Apr 2026 13:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5a-0004W9-TG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5Y-00046d-Kc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w+Y43i4g2qgcHDH9E8TWPcA/YZwitEcSD8GhoYgEqes=;
 b=hAO0iw4ceHMCZ1cktLfnULgXg7qxyCzUuFvfstkK3DZOwBiEIqnvrLybsfLyggLHUZXfIV
 BdtTbuZAVcQf5xSrMmZq4Znza6wS5rjnuYLu6e6Eo5m1zshnz5MlpNTWkBhIwfPkhHwj/I
 hbebLMQTPZkSKE6ieFheR29rUiRiE00=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-CFMPEda8OHiPV02aKJCPyw-1; Thu, 30 Apr 2026 13:22:09 -0400
X-MC-Unique: CFMPEda8OHiPV02aKJCPyw-1
X-Mimecast-MFC-AGG-ID: CFMPEda8OHiPV02aKJCPyw_1777569728
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b459fa5f76so12021136d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569728; x=1778174528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=w+Y43i4g2qgcHDH9E8TWPcA/YZwitEcSD8GhoYgEqes=;
 b=m2y2K/Zh2IvaTD3A45xyrD0LNggf6R/Ib2v8mk8YpdplowELeTXXqjNA0xxzLXgGcE
 /dnGp7pv8owiGLVbGPjxz4SN34gt+bKr+CJsqULzWV7AciBD0hbC+6D0T/r7s13GqmoM
 OwJDdJ/vQrlw9NRQ2iWw/5sp9updWJW05KfdN0qD8RQktCyqrb3eCORESUsl2updcpdr
 loFzXBHMDCfbnBIUpaGpr3bn5jgnz1y6Kek9xMGSBgIT2D8bK5m51gwInrnOqo2MrRDs
 q3vIHjRPh/xCjeklT2JtcZ7SoOOYrwndjemroYdrUOBEsnezm32aFUiEzz8xd7dsbUgT
 b2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569728; x=1778174528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w+Y43i4g2qgcHDH9E8TWPcA/YZwitEcSD8GhoYgEqes=;
 b=G63H4pGheSYzVybwYqr5XL790wVKB2Y8e4guPRpGTERT6SqO9oYWHf123TtLS9d61Y
 eyt5t/tz6RpsVlH/sNMrQ7loSpjckE5+Oxaej7AVDHf/3Fwr2Pea0T5xeuLisQ3b6y7H
 zQTq85RvunPHRVMHOqKIEFY8ivtCAbW/Kv1nZvB/aCMMC9g35EUMrK8PW5bPdVa91Cyw
 +9bY6+jQHCNpn8VXUxf39zwpDFxnAJAtCGW/xtAFAGl+ZPiSjx/ZXbkfWuGoxna4006Y
 jLKRUiBWWCcLzigxMwt+ftG0uQbPID7AblrCwUiS+N0wZB7eHjUg9VPrOQmgdt9kDcB1
 BRjQ==
X-Gm-Message-State: AOJu0YyUNJ+ujWNgl/57MfjnUxyjT2iYDS8LBYYBy4nW6PmLdYt52u5k
 YaU7nF1OPRQQQf/riPD+VI9e2V6oz7xXFrnhB5I9W6G7YU7vQqyyZdZnPKN99aYo5DuyORdf5FL
 RAZbKtvbieb3HvPPU0EYB5mqpWgCKQD8YTCCTVoZ9xk6/7NSi+mDCvnWTBKtvVD5NbXWld/EBpX
 fRSUIq8Ub3o+yCt2C7lL00Om/2Ke6LnlJNjgRInx+s
X-Gm-Gg: AeBDiesaX/1aWFvoQYqz8ZBYvlBZmsaIdHmU04OsmqndIP1eKm4IZAE7UnSFV4aHQ8W
 QN2Ip6jkOyrNhz5VBhsGa/7YZ5zPf7LXp7MAsbg66tvdk6uRpW7AB6OWqukPvwt77VQkzlK8l72
 n8PjQgmH8ZO2u4j46HgDgU0YMf1ZewwB4f6IhrlKF6zX2V8lKrw8fQZv5B62X1KJiqg4PLO7PHU
 QUNmnBeVyoOyK9QOBokxHnjnUCc9sTZua8R0+rLY7RebIwPhiy8wsK2VlHDzyarbJ4PD3FlTEOE
 9tcpzWXL4wxjib8EaTcXy20CSAJ5TXD4+4AdRl4gvPolKI3EJfEsczirrjF51LLtUZy6XLf/G6R
 qYjf6XZDUAiZCpzRYVCq2r52iEXYPXt+fKvYviggBiHwsR0WUju81pnsN6rb3J3FgN60bPyuwaP
 /Hgi0bNE4bWtjhrplRYA1E7DKye61qiuH6TwI=
X-Received: by 2002:ad4:4ea1:0:b0:896:fdd6:4a93 with SMTP id
 6a1803df08f44-8b3fece6533mr54720586d6.50.1777569727941; 
 Thu, 30 Apr 2026 10:22:07 -0700 (PDT)
X-Received: by 2002:ad4:4ea1:0:b0:896:fdd6:4a93 with SMTP id
 6a1803df08f44-8b3fece6533mr54719546d6.50.1777569727147; 
 Thu, 30 Apr 2026 10:22:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff308ed8sm25025536d6.4.2026.04.30.10.22.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/58] Misc patches for 2026-04-30
Date: Thu, 30 Apr 2026 19:21:06 +0200
Message-ID: <20260430172204.1006673-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit aa15257174da180c6a8a9d58f87319cfe61c5520:

  Merge tag 'pbouvier/pr/plugins-20260424' of https://gitlab.com/p-b-o/qemu into staging (2026-04-25 10:22:04 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f0eb0ef4d83068fc3d909a0266832c7c5fbccb7a:

  whpx: i386: documentation update (2026-04-30 17:55:04 +0200)

----------------------------------------------------------------
* hw/qdev: Consolidate qdev_get_printable_name() into qdev_get_human_name()
* target/i386: add new models for GMET, MMIO/GDS/RFDS mitigation and MBEC
* whpx improvements
* bump meson to 1.11.1
* tests: add test for json-streamer.c error recovery
* kconfig cleanups
* target/arm/hvf, target/i386/hvf: Pass MR-relative offset to memory_region_set_dirty()

----------------------------------------------------------------
Alessandro Ratti (3):
      hw/qdev: Clarify fallback order in qdev_get_printable_name()
      hw/qdev: Prefix bus type in qdev_get_printable_name() device paths
      hw/qdev: Consolidate qdev_get_printable_name() into qdev_get_human_name()

Jon Kohler (3):
      target/i386: add new AMD EPYC models for GMET enablement
      target/i386: add new Intel models for MMIO/GDS/RFDS mitigation status
      target/i386: add new Intel models for MBEC enablement

Magnus Kulke (1):
      target/i386: add de/compaction to xsave_helper

Mohamed Mediouni (34):
      whpx: i386: x2apic emulation
      whpx: i386: wire up feature probing
      whpx: i386: disable TbFlushHypercalls for emulated LAPIC
      whpx: i386: enable x2apic by default for user-mode LAPIC
      whpx: i386: reintroduce enlightenments for Windows 10
      whpx: i386: introduce proper cpuid support
      whpx: i386: kernel-irqchip=off fixes
      whpx: i386: use WHvX64RegisterCr8 only when kernel-irqchip=off
      whpx: i386: disable kernel-irqchip on Windows 10 when PIC enabled
      whpx: i386: IO port fast path cleanup
      whpx: i386: disable enlightenments and LAPIC for isapc
      whpx: i386: interrupt priority support
      hw/intc: apic: disallow APIC reads when disabled
      whpx: i386: fix CPUID[1:EDX].APIC reporting
      whpx: i386: set apicbase value only on success
      whpx: i386: enable GuestIdleReg enlightenment
      whpx: i386: unknown MSR configurability
      whpx: i386: don't increment eip on MSR access raising GPF
      target/i386: emulate, hvf: rdmsr/wrmsr GPF handling
      whpx: i386: tighten APIC base validity check
      whpx: i386: ignore vpassist when kernel-irqchip=off
      target: i386: HLT type that ignores EFLAGS.IF
      whpx: i386: add HV_X64_MSR_GUEST_IDLE when !kernel-irqchip
      whpx: i386: some x2APIC awareness
      whpx: i386: set WHvX64RegisterInitialApicId
      whpx: i386: Pause VM on fatal exception to be able to inspect state
      target/i386: emulate: use exception_payload for fault address
      target/i386: make xsave_buf present unconditionally
      whpx: xsave support
      whpx: i386: set APIC ID only when APIC present
      whpx: i386: update migration blocker message
      whpx: i386: add feature to intercept #GP MSR accesses
      whpx: i386: add SeparateSecurityDomain flag and make default
      whpx: i386: documentation update

Paolo Bonzini (15):
      target/i386/tcg: simplify decoding of 0F 38 F0...FF
      tests: add test for json-streamer.c error recovery
      kconfig: remove duplicate declaration of CONFIG_CXL
      kconfig: remove duplicate declaration of CONFIG_MIPS_BOSTON_AIA
      minikconf: run through isort
      minikconf: small cleanups and dead code removal
      minikconf: move command-line assignment out of the parser
      minikconf: fix type mismatch in do_declaration
      minikconf: simplify self.tok
      minikconf: modernize handling of include chain
      minikconf: use .items()
      minikconf: pull main program into a function
      minikconf: remove unnecessary semicolons
      minikconf: replace else with early return and avoid unnecessary else
      minikconf: add mypy annotations

Pierrick Bouvier (1):
      pythondeps: bump to meson 1.11.1

Scott J. Goldman (1):
      target/arm/hvf, target/i386/hvf: Pass MR-relative offset to memory_region_set_dirty()

 docs/system/whpx.rst                        |   40 +-
 include/hw/core/qdev.h                      |   28 +-
 include/system/whpx-all.h                   |    1 +
 include/system/whpx-common.h                |    2 +-
 include/system/whpx-internal.h              |   30 +
 target/i386/cpu.h                           |   14 +-
 target/i386/emulate/x86_emu.h               |    4 +-
 target/i386/hvf/hvf-i386.h                  |    4 +-
 target/i386/whpx/whpx-i386.h                |   12 +
 accel/whpx/whpx-common.c                    |    7 +
 hw/core/qdev.c                              |   38 +-
 hw/intc/apic.c                              |    9 +
 hw/virtio/virtio.c                          |    6 +-
 target/arm/hvf/hvf.c                        |    2 +-
 target/arm/whpx/whpx-all.c                  |    5 +
 target/i386/cpu.c                           |  169 +++-
 target/i386/emulate/x86_emu.c               |   10 +-
 target/i386/emulate/x86_mmu.c               |    3 +-
 target/i386/hvf/hvf.c                       |   11 +-
 target/i386/hvf/x86hvf.c                    |    4 +-
 target/i386/whpx/whpx-all.c                 | 1396 ++++++++++++++++++++++-----
 target/i386/whpx/whpx-apic.c                |   83 +-
 target/i386/whpx/whpx-cpu-legacy.c          |  158 +++
 target/i386/xsave_helper.c                  |  256 +++++
 tests/unit/check-json-parser.c              |  159 +++
 target/i386/tcg/decode-new.c.inc            |   21 +-
 hw/Kconfig                                  |    1 -
 hw/cxl/Kconfig                              |    3 -
 hw/misc/Kconfig                             |    8 -
 hw/riscv/Kconfig                            |    4 +
 python/scripts/vendor.py                    |    4 +-
 python/tests/linters.py                     |    6 +
 python/wheels/meson-1.10.0-py3-none-any.whl |  Bin 1057029 -> 0 bytes
 python/wheels/meson-1.11.1-py3-none-any.whl |  Bin 0 -> 1078534 bytes
 pythondeps.toml                             |    4 +-
 scripts/minikconf.py                        |  465 ++++-----
 target/i386/meson.build                     |    7 +-
 target/i386/whpx/meson.build                |    1 +
 tests/unit/meson.build                      |    1 +
 39 files changed, 2384 insertions(+), 592 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h
 create mode 100644 target/i386/whpx/whpx-cpu-legacy.c
 create mode 100644 tests/unit/check-json-parser.c
 delete mode 100644 hw/cxl/Kconfig
 delete mode 100644 python/wheels/meson-1.10.0-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.11.1-py3-none-any.whl
-- 
2.54.0


