Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B11E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK1n-0000B2-E9; Fri, 10 Jan 2025 13:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1h-0000Aj-Qy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1d-00014d-RQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sflwjc0tL1gMpYOzeVL6EmjxRPlyNgpEPjy2aYlxZVk=;
 b=eKidW0t9hza4rCW1NBPTsqrYc7Ww0j81kdtiIEiXOCjygzdpezOgrzsooFAUukJQli57fG
 PN0pZIufYjhc9UAqf2svZQOfo1Pdix0z6ZtH7ZoDTTfTUaEOiUtTISxn578prPqLIe6Eha
 0geum9H/46Lb+8+oyQGlCUVdl4ti/NU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-IVSy_A4XN36OeACVQ8rW0w-1; Fri, 10 Jan 2025 13:46:24 -0500
X-MC-Unique: IVSy_A4XN36OeACVQ8rW0w-1
X-Mimecast-MFC-AGG-ID: IVSy_A4XN36OeACVQ8rW0w
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa691c09772so216107766b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534783; x=1737139583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sflwjc0tL1gMpYOzeVL6EmjxRPlyNgpEPjy2aYlxZVk=;
 b=uzJ/M1v1mdcYTVj7O5tSwcgkHlXO5IfG0+Vn7bnNI+nZW1Z+50QnPIl25frQdvl4rs
 wm/5Td/FpKZobBdv8mfY4ZdHtfBi9sfseOjB/vNLSmZrZTuDMV6ZOq1fU1pg3PpjSVt1
 WhFLQvXkTex50TuJkDKoJZU8Fzus7tPUFqkv1GzDiE+gtZfOryfFJaXq3e9LmYpSC93I
 5jlmGPbQ0OhMpCKC8Y81CnqjM4ZV5P/aQ2IsWj3QqwYIOFhlggCe0slbUfz5NqDs6aU6
 d5ROJULs9LliFdu6V8qaw/6AA6t6woPaT9LHwDr3tLUfIeai6y0UQv1UBdLEp0Cd4mFz
 L1YA==
X-Gm-Message-State: AOJu0YwtG+kOWo01aclKSTfHJ+81bAhmwwBj2ltkpX7imD2qP+n7sUUA
 b/25AVXNEJ1DwUX9YtUDZWWOZvliYLeMSbYdCunwFaoKoHbozVm3yG6slIP3qLdVwPLlP8CoKLI
 Q6K/1efLJlE14mJx4kNnLqoHGOHLtk+EdKkSbV9Kg/JOatic22XOzzcJS9PKSxv2aO5FoydybbN
 IhTUmuNcwY6f47IyU64kzfuhzMlet1mgmti8COx5o=
X-Gm-Gg: ASbGncs2F7F5Kd9Fba/UFem4B1gke6Z1vSEb/lQfLq2jBS02f/YnRnANGHSYp+PrT1k
 uFGMc0YtiZlN8M8OMu/WFm+xkcVynyUbIOPZT+MriVmaMK/54wOJa919Q71rivs45CxuWSohhLa
 GXEBM2SejFBir+yyfJYpW65XoQ5r/9MPxQ31ZsO4XIanfwdvPrWNE2Ape2PEdd9KL/ZPSckFt/x
 IMJ5Wx9CLyoBA5iPVq6Nr6oAvdJtNyfj5z/2hdjLfJFwTs8Xg4ybwfd9O8=
X-Received: by 2002:a17:907:a784:b0:ab2:c1da:9217 with SMTP id
 a640c23a62f3a-ab2c1da92e5mr843358566b.1.1736534782646; 
 Fri, 10 Jan 2025 10:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWh/l6iuZTbqBsWo8D9TwCXjazDl4DJuvCNxaP2W33/5918T9gj6HuZ0lrHujIaB55w39FCg==
X-Received: by 2002:a17:907:a784:b0:ab2:c1da:9217 with SMTP id
 a640c23a62f3a-ab2c1da92e5mr843356466b.1.1736534782158; 
 Fri, 10 Jan 2025 10:46:22 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b20b1sm191180266b.157.2025.01.10.10.46.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] Rust, i386 patches for 2024-01-10
Date: Fri, 10 Jan 2025 19:45:41 +0100
Message-ID: <20250110184620.408302-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit 6528013b5f5ba6bb3934b7f5fe57a3110680530f:

  Merge tag 'qga-pull-2025-01-06' of https://github.com/kostyanf14/qemu into staging (2025-01-06 09:39:02 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to d56b3fe297c307292e76d25358e2e3e367226c43:

  i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX] (2025-01-10 19:44:25 +0100)

----------------------------------------------------------------
* rust: miscellaneous changes
* target/i386: small code generation improvements
* target/i386: various cleanups and fixes
* cpu: remove env->nr_cores

----------------------------------------------------------------
Paolo Bonzini (19):
      rust: fix --enable-debug-mutex
      rust: add --check-cfg test to rustc arguments
      rust: qom: add ParentField
      rust: add a utility module for compile-time type checks
      rust: macros: check that #[derive(Object)] requires #[repr(C)]
      rust: macros: check that the first field of a #[derive(Object)] struct is a ParentField
      rust: qom: automatically use Drop trait to implement instance_finalize
      rust: qom: move device_id to PL011 class side
      rust: pl011: only leave embedded object initialization in instance_init
      rust: qom: make INSTANCE_POST_INIT take a shared reference
      rust: qemu-api-macros: extend error reporting facility to parse errors
      rust: qemu-api-macros: add automatic TryFrom/TryInto derivation
      rust: qdev: expose inherited methods to subclasses of SysBusDevice
      rust: hide warnings for subprojects
      qom: remove unused field
      make-release: only leave tarball of wrap-file subprojects
      target/i386: improve code generation for BT
      target/i386: use shr to load high-byte registers into T0/T1
      target/i386/kvm: Replace ARRAY_SIZE(msr_handlers) with KVM_MSR_FILTER_MAX_RANGES

Xiaoyao Li (10):
      i386/cpu: Extract a common fucntion to setup value of MSR_CORE_THREAD_COUNT
      i386/cpu: Drop the variable smp_cores and smp_threads in x86_cpu_pre_plug()
      i386/cpu: Drop cores_per_pkg in cpu_x86_cpuid()
      i386/topology: Update the comment of x86_apicid_from_topo_ids()
      i386/topology: Introduce helpers for various topology info of different level
      i386/cpu: Track a X86CPUTopoInfo directly in CPUX86State
      i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT against threads_per_core
      cpu: Remove nr_cores from struct CPUState
      i386/cpu: Set up CPUID_HT in x86_cpu_expand_features() instead of cpu_x86_cpuid()
      i386/cpu: Set and track CPUID_EXT3_CMP_LEG in env->features[FEAT_8000_0001_ECX]

Zhao Liu (9):
      i386/cpu: Mark avx10_version filtered when prefix is NULL
      target/i386/kvm: Add feature bit definitions for KVM CPUID
      target/i386/kvm: Remove local MSR_KVM_WALL_CLOCK and MSR_KVM_SYSTEM_TIME definitions
      target/i386/kvm: Only save/load kvmclock MSRs when kvmclock enabled
      target/i386/kvm: Drop workaround for KVM_X86_DISABLE_EXITS_HTL typo
      target/i386/confidential-guest: Fix comment of x86_confidential_guest_kvm_type()
      target/i386/kvm: Clean up return values of MSR filter related functions
      target/i386/kvm: Return -1 when kvm_msr_energy_thread_init() fails
      target/i386/kvm: Clean up error handling in kvm_arch_init()

 include/hw/core/cpu.h                              |   2 -
 include/hw/i386/topology.h                         |  30 +++-
 include/qom/object.h                               |   5 +-
 target/i386/confidential-guest.h                   |   2 +-
 target/i386/cpu.h                                  |  31 +++-
 hw/core/cpu-common.c                               |   1 -
 hw/i386/kvm/clock.c                                |   5 +-
 hw/i386/x86-common.c                               |  22 +--
 qom/object.c                                       |   1 -
 system/cpus.c                                      |   1 -
 target/i386/cpu-system.c                           |  11 ++
 target/i386/cpu.c                                  | 119 ++++++-------
 target/i386/hvf/x86_emu.c                          |   3 +-
 target/i386/kvm/kvm.c                              | 197 ++++++++++-----------
 target/i386/tcg/system/misc_helper.c               |   3 +-
 target/i386/tcg/translate.c                        |   2 +-
 target/i386/tcg/emit.c.inc                         |  59 ++++--
 rust/hw/char/pl011/src/device.rs                   |  79 ++++-----
 rust/hw/char/pl011/src/lib.rs                      |  28 +--
 rust/qemu-api-macros/src/lib.rs                    | 150 ++++++++++++----
 rust/qemu-api-macros/src/utils.rs                  |  26 +++
 rust/qemu-api/meson.build                          |   3 +-
 rust/qemu-api/src/assertions.rs                    |  90 ++++++++++
 rust/qemu-api/src/irq.rs                           |   3 +-
 rust/qemu-api/src/lib.rs                           |   1 +
 rust/qemu-api/src/prelude.rs                       |   2 +
 rust/qemu-api/src/qom.rs                           |  85 +++++++--
 rust/qemu-api/src/sysbus.rs                        |  23 ++-
 rust/qemu-api/tests/tests.rs                       |   4 +-
 scripts/make-release                               |  31 +++-
 scripts/rust/rustc_args.py                         |   2 +
 subprojects/arbitrary-int-1-rs.wrap                |   3 +
 subprojects/bilge-0.2-rs.wrap                      |   3 +
 subprojects/bilge-impl-0.2-rs.wrap                 |   3 +
 subprojects/either-1-rs.wrap                       |   3 +
 subprojects/itertools-0.11-rs.wrap                 |   3 +
 .../packagefiles/arbitrary-int-1-rs/meson.build    |   1 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |   1 +
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |   1 +
 subprojects/packagefiles/either-1-rs/meson.build   |   1 +
 .../packagefiles/itertools-0.11-rs/meson.build     |   1 +
 .../packagefiles/proc-macro-error-1-rs/meson.build |   1 +
 .../proc-macro-error-attr-1-rs/meson.build         |   1 +
 .../packagefiles/proc-macro2-1-rs/meson.build      |   1 +
 subprojects/packagefiles/quote-1-rs/meson.build    |   1 +
 subprojects/packagefiles/syn-2-rs/meson.build      |   1 +
 .../packagefiles/unicode-ident-1-rs/meson.build    |   1 +
 subprojects/proc-macro-error-1-rs.wrap             |   3 +
 subprojects/proc-macro-error-attr-1-rs.wrap        |   3 +
 subprojects/proc-macro2-1-rs.wrap                  |   3 +
 subprojects/quote-1-rs.wrap                        |   3 +
 subprojects/syn-2-rs.wrap                          |   3 +
 subprojects/unicode-ident-1-rs.wrap                |   3 +
 subprojects/unicode-ident-1-rs/meson.build         |  20 ---
 54 files changed, 716 insertions(+), 369 deletions(-)
 create mode 100644 rust/qemu-api-macros/src/utils.rs
 create mode 100644 rust/qemu-api/src/assertions.rs
 delete mode 100644 subprojects/unicode-ident-1-rs/meson.build
-- 
2.47.1


