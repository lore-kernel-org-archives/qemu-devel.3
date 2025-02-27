Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48461C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekB-0006mj-Sb; Thu, 27 Feb 2025 09:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnek9-0006h3-J7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnek5-0003TN-Cr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zXo3u30w+/k/HJ37k5XXSMZnhq4Zco28xSz4dahNjvg=;
 b=Gq4etQtmnHVTxaKPdx2A7E0gSP6HGuwU7M9hqlNt3pMOJ7M8auUXd6bgZfrUtjwdf7vv9Y
 d0LzGmzmIn2+1Bd9m8akeLaDOltoFWrLer+iV4X91QJT62zUg9DC8DuderU9VzgyKWgD4s
 pJRxJC+Knx3uvLAk49QoQTzPMDLNzV8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-8X5momk0PIeRebRlQ-pLhQ-1; Thu, 27 Feb 2025 09:19:58 -0500
X-MC-Unique: 8X5momk0PIeRebRlQ-pLhQ-1
X-Mimecast-MFC-AGG-ID: 8X5momk0PIeRebRlQ-pLhQ_1740665997
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab77dd2c243so200376666b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665996; x=1741270796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXo3u30w+/k/HJ37k5XXSMZnhq4Zco28xSz4dahNjvg=;
 b=kSQeSBn4Hb2yeU3KY5nI9V3qYoapE7QLoHvOePBsOpjQZOotLAm00+pCTvjbDmVcFi
 mPoM/KTB1CU7a9E6wBlSnP3T7YXuvIbZ3iIcNeNrHIuEkytkG6hIuOP36H+1PmbiNN9p
 zyNCASq70qrYS/rfnIcoSjl+Y87ITcyMM1byT+pe4G97gSgpTjPwn/+MekudZm9oS/t9
 tcoA0+xwxHshSZRZrFEMLcnotDoeCq/uIijtCdfhd4S20EiDnoTh5TQFgqyOr46oMN5o
 yvyD0ju3cJGm1IGNT8Z3TA14JR1ctSVgZ5kbIMEd56PM1pXryOo9qz6WOAYc1+0n2R9x
 aOrw==
X-Gm-Message-State: AOJu0YzmSk3g2mVx0EI+F+xJ31z1sNIBEXn80BzbYo0j9YjznS1v7pgb
 xr7izR8dLBFMoTB3MQttm/z8k1UGnwBIjSL9nkZCrvdpma+9wKleEvchFinMBvujJ8JVDGDe9pb
 Ky4Y5Q1V43cHTNM6/4Y0Ozu1X7t4bFCw0oer+mRet2DpBqOxx5PK/j2dGDUTxu8GKqWD5H9lDWy
 eQJJUDOwTmAxItxNnZV/p5/jGqinBn4i5vQ/agulI=
X-Gm-Gg: ASbGnctNPqVBqygRimb5DLL4mSinIvtkJByaY+Cg3S6eS4rP6J4N3LAPhSht26i3GuU
 pJlC+sE3QKrfkWZnkMS/XjQ1ZgUhC/KaYMYMXZ0hoRXA1zHynwhjgTM2WEAJwcIqzd5KDKzilzB
 bs9I6QJZkwtY+WQy6nwwRll4EFpeixm1TKb551WPlED6chDggJS7s41qHfIZFjIWDjh6pHR4WwJ
 z78M750D3IH07UKqWtZs3wtvDbTPih/TDdN88fXvwE8R/pKy7C6aZCKOuw+ulCzJHD030UHmt8W
 NWWMX0I2U3PMQJIQAzcE
X-Received: by 2002:a17:907:1c9c:b0:ab7:d454:11c9 with SMTP id
 a640c23a62f3a-abed0c77dd6mr1562381566b.8.1740665995982; 
 Thu, 27 Feb 2025 06:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEr7e5Cs7NXbmmI6fc3TL2iRMO4DC6jswPnRWpcteq6uuOpzBgDtBY/Vg8kaYEiDAOKWH+Uw==
X-Received: by 2002:a17:907:1c9c:b0:ab7:d454:11c9 with SMTP id
 a640c23a62f3a-abed0c77dd6mr1562367666b.8.1740665994088; 
 Thu, 27 Feb 2025 06:19:54 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dcb12sm129181566b.74.2025.02.27.06.19.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:19:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] i386, Rust, build system, QOM patches for 2025-02-27
Date: Thu, 27 Feb 2025 15:19:18 +0100
Message-ID: <20250227141952.811410-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a4e749780bd20593c0c386612a51bf4d64a80132:

  target/i386: Mask CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin CPUs (2025-02-26 09:56:18 +0100)

----------------------------------------------------------------
* qom: Use command line syntax for default values in help
* i386: support cache topology with machine's configuration
* rust: fix duplicate symbols from monitor-fd.c
* rust: add module to convert between success/-errno and io::Result
* rust: move class_init implementation from trait to method
* pvg: configuration improvements
* kvm guestmemfd: replace assertion with error
* riscv: cleanups
* target/i386/hvf: cleanups to emulation
* target/i386: add Zhaoxin and Yongfeng CPU model

----------------------------------------------------------------
Akihiko Odaki (1):
      qom: Use command line syntax for default values in help

Alireza Sanaee (1):
      i386/cpu: add has_caches flag to check smp_cache configuration

EwanHai (4):
      target/i386: Add support for Zhaoxin CPU vendor identification
      target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
      target/i386: Introduce Zhaoxin Yongfeng CPU model
      target/i386: Mask CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin CPUs

Ilya Leoshkevich (1):
      stub: Remove monitor-fd.c

Paolo Bonzini (16):
      hpet: do not overwrite properties on post_load
      rust: subprojects: add libc crate
      rust: add module to convert between success/-errno and io::Result
      rust: tests: do not import bindings::*
      docs: rust: fix typos
      docs: rust: update description of crates
      physmem: replace assertion with error
      pvg: do not enable it on cross-architecture targets
      pvg: add option to configure it out
      rust: add IsA bounds to QOM implementation traits
      rust: add SysBusDeviceImpl
      rust: qom: add ObjectImpl::CLASS_INIT
      rust: pl011, qemu_api tests: do not use ClassInitImpl
      rust: qom: get rid of ClassInitImpl
      target/riscv: remove unused macro DEFINE_CPU
      target/riscv: move 128-bit check to TCG realize

Wei Liu (6):
      target/i386/hvf: fix a typo in a type name
      target/i386/hvf: fix the declaration of hvf_handle_io
      target/i386/hvf: use x86_segment in x86_decode.c
      target/i386/hvf: move and rename {load, store}_regs
      target/i386/hvf: move and rename simulate_{rdmsr, wrmsr}
      target/i386/hvf: drop some dead code

Zhao Liu (5):
      i386: Fix the missing Rust HPET configuration option
      rust: prefer importing std::ptr over core::ptr
      i386/cpu: Support module level cache topology
      i386/cpu: Update cache topology with machine's configuration
      i386/pc: Support cache topology in -machine for PC machine

 docs/devel/rust.rst                              |  19 +-
 meson.build                                      |  14 +-
 include/hw/boards.h                              |   3 +
 target/i386/cpu.h                                |  41 ++-
 target/i386/hvf/hvf-i386.h                       |   4 +-
 target/i386/hvf/x86.h                            |   8 +-
 target/i386/hvf/x86_descr.h                      |   6 +-
 target/i386/hvf/x86_emu.h                        |   7 +-
 target/i386/hvf/x86_task.h                       |   2 +-
 target/i386/hvf/x86hvf.h                         |   3 +
 hw/core/machine-smp.c                            |   2 +
 hw/i386/pc.c                                     |   4 +
 hw/timer/hpet.c                                  |  38 +--
 qom/object_interfaces.c                          |  24 +-
 stubs/monitor-fd.c                               |   9 -
 system/physmem.c                                 |   6 +-
 target/i386/cpu.c                                | 200 ++++++++++++-
 target/i386/hvf/hvf.c                            | 295 +++++++++++++++++--
 target/i386/hvf/x86.c                            |   4 +-
 target/i386/hvf/x86_decode.c                     |  20 +-
 target/i386/hvf/x86_descr.c                      |   8 +-
 target/i386/hvf/x86_emu.c                        | 273 +-----------------
 target/i386/hvf/x86_task.c                       |  26 +-
 target/riscv/cpu.c                               |  16 --
 target/riscv/tcg/tcg-cpu.c                       |   9 +
 Kconfig.host                                     |   3 +
 hw/display/Kconfig                               |   4 -
 hw/display/meson.build                           |   9 +-
 meson_options.txt                                |   2 +
 qemu-options.hx                                  |  30 +-
 rust/Cargo.lock                                  |   7 +
 rust/hw/char/pl011/src/device.rs                 |  46 +--
 rust/hw/char/pl011/src/device_class.rs           |   6 +-
 rust/hw/timer/Kconfig                            |   1 +
 rust/hw/timer/hpet/src/hpet.rs                   |   5 +-
 rust/qemu-api/Cargo.toml                         |   1 +
 rust/qemu-api/meson.build                        |   4 +
 rust/qemu-api/src/assertions.rs                  |  28 ++
 rust/qemu-api/src/errno.rs                       | 345 +++++++++++++++++++++++
 rust/qemu-api/src/irq.rs                         |   3 +-
 rust/qemu-api/src/lib.rs                         |   1 +
 rust/qemu-api/src/prelude.rs                     |   2 +
 rust/qemu-api/src/qdev.rs                        |  40 ++-
 rust/qemu-api/src/qom.rs                         | 168 +++++------
 rust/qemu-api/src/sysbus.rs                      |  19 +-
 rust/qemu-api/tests/tests.rs                     |  35 +--
 scripts/archive-source.sh                        |   2 +-
 scripts/make-release                             |   2 +-
 scripts/meson-buildoptions.sh                    |   3 +
 stubs/meson.build                                |   2 +-
 subprojects/.gitignore                           |   1 +
 subprojects/libc-0.2-rs.wrap                     |   7 +
 subprojects/packagefiles/libc-0.2-rs/meson.build |  37 +++
 53 files changed, 1275 insertions(+), 579 deletions(-)
 delete mode 100644 stubs/monitor-fd.c
 create mode 100644 rust/qemu-api/src/errno.rs
 create mode 100644 subprojects/libc-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
-- 
2.48.1


