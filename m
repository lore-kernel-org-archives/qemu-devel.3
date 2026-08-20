Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC8FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5y0-0003en-GS; Thu, 20 Aug 2026 12:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5xy-0003eL-1A
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5xv-0005K9-3k
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pmomUgRB0Jq41gUHSdOOd6oYR2LM11JZIUgZnb4Wu98=;
 b=doWxdWR3k/0H/GFwELnFI4aTslTWWZ1nysl/ZV40GtQ0Db8o90i83lR+FwEFEcCzz+Fbtv
 XzLeo7LAPbTn6yi5wFtWu1fmW+4Zqd152lwp1T6dI2oc3V7KgZ9WruoS5805TJMycvXzTg
 bkuxgZh35qYdq724uboSHjqlDGGgpC4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-ap02FLIkPFye9dtn9q7zKQ-1; Thu, 20 Aug 2026 12:50:03 -0400
X-MC-Unique: ap02FLIkPFye9dtn9q7zKQ-1
X-Mimecast-MFC-AGG-ID: ap02FLIkPFye9dtn9q7zKQ_1787244602
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954b1c6310so381525e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244602; x=1787849402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pmomUgRB0Jq41gUHSdOOd6oYR2LM11JZIUgZnb4Wu98=;
 b=Hy4iCd1qrWBv5fAneIOw3gubQHz4G9TnWi37tPm23v0eif6daDoVbgivBTJBOp/B3o
 KfIMvTfqTTuXf9szDdArRchHsv9IH2gVZySbgtaUumufn9yfjz0CPBobVLF9opbvtJPt
 taCmrk6QRG5ILbKiI+/jqS0AlJwThMtk3wdAy22zFvZNyzo9HTzuxiKmYzlfOEq4tQKG
 SgTRwXYZClqMFRIw80YyBGbqc6/8fSLkXBLzeNkZlZrYNNE8Q1c8vedkVIsS9HYg/Ke2
 TLrBh4fBFhtgVP/+men+L0jM4gPj1hmGAyg0qjLToMkP1RSN6aOFFxd6aa67zBsqQ6ES
 zz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244602; x=1787849402;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pmomUgRB0Jq41gUHSdOOd6oYR2LM11JZIUgZnb4Wu98=;
 b=PqOHYtjWzBqF9yMnA614UNRNGN+xmxoa215naS5OJUipBmQnIMbDccuAvhaw/trtxT
 FF8Hxz4CI/lXBdhSv/n7tamkAR60GYbMf5Yekwrs+De6r3dRlKSZofpFHcP4AFhZzug7
 gYeVTlU6+t6s9WPEA+zDEUdz0QPUfkun6aY6xIurRk/focOBsa/eFGxknXI2gxtH6gpH
 4CxQlpOhBN3IBuiicIvjBMejiZ57GhDjDinSNK6xF7L9fhXpW9UiA8Qa/pwW1YsuEtOI
 HkjqOZoUqZUxpIM5NN5rPl6gtpDe0Vy2oAelVy/40TStls9G7qV67QFZdAlY9cPWwcwp
 Oe4A==
X-Gm-Message-State: AOJu0YytO+w5CxeW7R5vsVj2vq4i5g4/ulmYgT4X0gx1x47CPR/dyyYJ
 aYoiaVDqKLSF3LMmXoOeZQwVIlT+AAh/k9gTXkbVcUYlcEYLLF8lcZed2vfqnDOCCM/Acek7aln
 s9iyjViJEE2TQxdLLbp+fu+XGvX3i4GsnPp6r9TVpRx2W9f/H8ubSyVgHAmXAYW5JnKfRkXQbBB
 XUnSM5wbiYCQXt/rQL1M0oPOVkbjuWNHBKBxFS8gwu
X-Gm-Gg: AR+sD118TthhjLWTBVuTPtQXB0MSWTpP2pifxUb93wdjKgqCK74MMhXFyo/9uuATfcJ
 cxexmMtUNE9m6kPH3DO98V315VxrOemtyb9kWigKwMa+bABoe9jnQipWcyLLgZRXZr40b15X6Pn
 lp8c73qoD83DZP0etx+M6w0apel1qtYVE5DTSdPYxlYYx+NrZRcy2EoS3OBQ9Nf6bXo3rDIROJV
 +bR9Z9t67uP8t1WVkvIZCn/LjzAUvBGaVTITEHzjuy4KG/r2uPnbtBCKWGNJfq+69TPg4IYKP+r
 ulhuFqZtOReORffvhvHKlpykv0WZ9WcIDXTg7i0hLUG7XlZ4iZlchmgMWPej00etEPaKAgF8xcz
 n7r7lv2J8F9QjJcV3tWnLaMKdm4+CocUdazQEb5DoV9LIbwg6bh+HeL4tQkXkcULv2zqKgsFLiq
 kc8IM=
X-Received: by 2002:a05:600c:3507:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-499b831df89mr4052435e9.7.1787244601502; 
 Thu, 20 Aug 2026 09:50:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3507:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-499b831df89mr4051135e9.7.1787244600802; 
 Thu, 20 Aug 2026 09:50:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11f832sm148544855e9.7.2026.08.20.09.49.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:49:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/53] CI, Rust, target/i386 changes for 2026-08-20
Date: Thu, 20 Aug 2026 18:49:03 +0200
Message-ID: <20260820164957.1895963-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit d49f87606ac1a6e15701b26c1b16c5d7e948ffcb:

  Merge tag 'linux-user-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-08-12 15:21:53 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3ac34c6d25d84353c882ab0e11ea25229d4f1a48:

  rust: remove bilge crate (2026-08-20 09:24:57 +0200)

----------------------------------------------------------------
* dockerfiles: cleanup, update CentOS 9 container to Python 3.11
* rust: fix issues in bits crate
* rust: replace bilge dependency with bitfield-struct
* rust: update build system for Meson 1.12.0
* serial: fix hot-unplug issue
* target/i386: emulate: simplify flags conversion and storage
* target/i386: tcg: small fixes
* target/i386: mshv: complete migration support
* target/i386: sev: add support for SEV features
* target/i386: whpx: bugfixes

----------------------------------------------------------------
Andrey Polivoda (2):
      target/i386: allow transition to virtual-8086 mode only if CPL == 0 and CPU is not in long mode
      target/i386: decode opcode extensions group 3 /1 as TEST

Craaijo, Jos (1):
      target/i386: fix long mode segment override prefix decoding

Magnus Kulke (13):
      target/i386: Skip supervisor in xsave decompaction
      target/i386/mshv: disable AMX TILE features
      target/i386/mshv: toggle fpu/xsave migration
      accel/mshv: introduce SaveVMHandler
      hw/i386/mshv: migrate REFERENCE_TIME
      accel/mshv: install dummy handler for SIG_IPI
      target/i386/mshv: migrate LAPIC state
      target/i386/mshv: migrate Synic SINT MSRs
      target/i386/mshv: migrate SIMP and SIEFP state
      target/i386/mshv: migrate STIMER state
      accel/mshv: write synthetic MSRs after migration
      target/i386/mshv: migrate MP_STATE
      hw/i386/mshv: drop initial msi vector 0

Mohamed Mediouni (6):
      whpx: i386: fix xsaves enablement in legacy probing path
      hw/i386: fw_cfg: do not set VMX feature control on WHPX
      whpx: i386: enable fast hypercall output
      whpx: i386: synchronise PAT too
      whpx: i386: work around Hyper-V FP state oddities
      whpx: i386: inject back db

Naveen N Rao (AMD) (10):
      target/i386: SEV: Generalize handling of SVM_SEV_FEAT_SNP_ACTIVE
      target/i386: SEV: Ensure SEV features are only set through qemu cli or IGVM
      target/i386: SEV: Consolidate SEV feature validation to common init path
      target/i386: SEV: Validate that SEV-ES is enabled when VMSA features are used
      target/i386: SEV: Enable use of KVM_SEV_INIT2 for SEV-ES guests
      target/i386: SEV: Add support for enabling debug-swap SEV feature
      target/i386: SEV: Add support for enabling Secure TSC SEV feature
      target/i386: SEV: Add support for setting TSC frequency for Secure TSC
      target/i386: SEV: Refactor check_sev_features()
      target/i386: SEV: Remove use of __func__

Nguyen Dinh Phi (2):
      rust/bits: Align SubAssign behavior with Sub
      rust/bits: Use checked_ilog2() in Binary::format to avoid panic

Paolo Bonzini (17):
      target/i386: use ESA_FEATURE_ALIGN64_MASK
      target/i386: emulate: stop torturing cc_src into carrying SF/PF
      serial: clear transmit retry callback on unrealize
      meson: make linker warnings non-fatal on Linux
      dockerfiles: remove packages required by Avocado
      dockerfiles: update CentOS Stream 9 to Python 3.11, Meson to 1.12
      python, meson: update meson required for Rust to 1.12.0
      rust: update Cargo.lock
      rust: switch to cargo subprojects
      rust: switch to autogenerated meson rules
      meson: use compiler_target() to get rustc target
      rust: use meson automatic parsing of Cargo.toml
      docs: rust: update for new-style build rules
      scripts: remove now dead parts of rustc_args.py
      rust: update Cargo dependencies
      rust: pl011: switch from bilge to bitfield-struct
      rust: remove bilge crate

Simon Scherer (2):
      target/i386: Clear OF, SF, and AF for fcomi/fucomi
      target/i386: fix incorrect decoding of EXTRQ_i

 MAINTAINERS                                        |   1 +
 docs/devel/rust.rst                                |  85 ++---
 configure                                          |   7 +-
 meson.build                                        |  21 +-
 qapi/qom.json                                      |  17 +-
 include/hw/hyperv/hvgdk_mini.h                     |   5 +
 include/hw/i386/apic-msidef.h                      |   1 +
 include/system/mshv.h                              |   5 +
 include/system/mshv_int.h                          |  19 +-
 target/i386/cpu.h                                  |  12 +
 target/i386/sev.h                                  |   4 +-
 accel/mshv/mshv-all.c                              | 102 +++---
 hw/char/serial.c                                   |   1 +
 hw/i386/fw_cfg.c                                   |  13 +-
 hw/i386/mshv/apic.c                                | 405 +++++++++++++++++++++
 hw/i386/mshv/clock.c                               | 189 ++++++++++
 hw/i386/x86-cpu.c                                  |   6 +
 target/i386/cpu-apic.c                             |   3 +
 target/i386/emulate/x86_decode.c                   |   6 +
 target/i386/emulate/x86_flags.c                    |  65 ++--
 target/i386/machine.c                              |  46 +++
 target/i386/mshv/mshv-cpu.c                        | 327 +++++++++++------
 target/i386/mshv/msr.c                             |  40 ++
 target/i386/mshv/synic.c                           | 206 +++++++++++
 target/i386/sev.c                                  | 304 ++++++++++------
 target/i386/tcg/fpu_helper.c                       |  10 +-
 target/i386/tcg/seg_helper.c                       |   3 +-
 target/i386/whpx/whpx-all.c                        |  51 ++-
 target/i386/whpx/whpx-cpu-legacy.c                 |   2 +-
 target/i386/xsave_helper.c                         |  19 +-
 tests/tcg/x86_64/segment-prefixes.c                |  25 ++
 target/i386/tcg/decode-new.c.inc                   |  46 ++-
 tests/docker/dockerfiles/alpine.docker             |   3 -
 tests/docker/dockerfiles/centos9.docker            |  19 +-
 .../dockerfiles/debian-all-test-cross.docker       |   2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |   6 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   6 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   6 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |   6 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   6 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |   6 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   6 +-
 tests/docker/dockerfiles/debian.docker             |   6 +-
 .../docker/dockerfiles/fedora-rust-nightly.docker  |   6 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |   6 +-
 tests/docker/dockerfiles/fedora.docker             |   6 +-
 tests/docker/dockerfiles/opensuse-leap.docker      |   4 -
 tests/docker/dockerfiles/ubuntu2404.docker         |   6 +-
 .gitlab-ci.d/macos-14.vars                         |   2 +-
 .gitlab-ci.d/static_checks.yml                     |   4 +-
 rust/Cargo.lock => Cargo.lock                      | 158 +++-----
 rust/Cargo.toml => Cargo.toml                      |   7 +-
 accel/mshv/trace-events                            |   1 +
 hw/i386/meson.build                                |   1 +
 hw/i386/mshv/meson.build                           |   5 +
 python/scripts/vendor.py                           |   4 +-
 python/wheels/meson-1.11.1-py3-none-any.whl        | Bin 1078534 -> 0 bytes
 python/wheels/meson-1.12.0-py3-none-any.whl        | Bin 0 -> 1106208 bytes
 pythondeps.toml                                    |   4 +-
 rust/bindings/chardev-sys/meson.build              |  11 +-
 rust/bindings/hwcore-sys/meson.build               |  11 +-
 rust/bindings/migration-sys/meson.build            |  11 +-
 rust/bindings/qom-sys/meson.build                  |  11 +-
 rust/bindings/system-sys/meson.build               |  11 +-
 rust/bindings/util-sys/meson.build                 |  11 +-
 rust/bits/meson.build                              |   7 +-
 rust/bits/src/lib.rs                               |  24 +-
 rust/bql/meson.build                               |  13 +-
 rust/chardev/meson.build                           |   8 +-
 rust/common/meson.build                            |  10 +-
 rust/hw/char/pl011/Cargo.toml                      |   3 +-
 rust/hw/char/pl011/meson.build                     |  22 +-
 rust/hw/char/pl011/src/registers.rs                | 108 +++---
 rust/hw/core/meson.build                           |  10 +-
 rust/hw/timer/hpet/meson.build                     |  17 +-
 rust/meson.build                                   |  26 +-
 rust/migration/meson.build                         |   8 +-
 rust/migration/src/vmstate.rs                      |  45 +--
 rust/qemu-macros/meson.build                       |  12 +-
 rust/qom/meson.build                               |   8 +-
 rust/system/meson.build                            |   8 +-
 rust/trace/meson.build                             |   9 +-
 rust/util/meson.build                              |   7 +-
 scripts/archive-source.sh                          |   7 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml     |   4 -
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml   |   4 -
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml     |   4 -
 scripts/get-wraps-from-cargo-registry.py           |   6 -
 scripts/make-release                               |   4 +-
 scripts/rust/rustc_args.py                         |  80 +---
 subprojects/.gitignore                             |   8 +-
 subprojects/anyhow-1-rs.wrap                       |   5 +-
 subprojects/arbitrary-int-1-rs.wrap                |  10 -
 subprojects/attrs-0.2-rs.wrap                      |   3 +-
 subprojects/bilge-0.2-rs.wrap                      |  10 -
 subprojects/bilge-impl-0.2-rs.wrap                 |  10 -
 subprojects/bitfield-struct-0.13-rs.wrap           |   6 +
 subprojects/either-1-rs.wrap                       |  10 -
 subprojects/foreign-0.3-rs.wrap                    |   3 +-
 subprojects/glib-sys-0.21-rs.wrap                  |   3 +-
 subprojects/itertools-0.11-rs.wrap                 |  10 -
 subprojects/libc-0.2-rs.wrap                       |   5 +-
 subprojects/packagefiles/anyhow-1-rs/meson.build   |  33 --
 .../packagefiles/anyhow-1-rs/meson/meson.build     |   9 +
 .../packagefiles/arbitrary-int-1-rs/meson.build    |  21 --
 subprojects/packagefiles/attrs-0.2-rs/meson.build  |  33 --
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |  31 --
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |  44 ---
 subprojects/packagefiles/either-1-rs/meson.build   |  26 --
 .../packagefiles/foreign-0.3-rs/meson.build        |  26 --
 .../packagefiles/glib-sys-0.21-rs/meson.build      |  33 --
 .../packagefiles/itertools-0.11-rs/meson.build     |  32 --
 subprojects/packagefiles/libc-0.2-rs/meson.build   |  37 --
 .../packagefiles/libc-0.2-rs/meson/meson.build     |  16 +
 subprojects/packagefiles/probe-0.5-rs/meson.build  |  22 --
 .../packagefiles/proc-macro-error-1-rs/meson.build |  41 ---
 .../proc-macro-error-attr-1-rs/meson.build         |  31 --
 .../packagefiles/proc-macro2-1-rs/meson.build      |  35 --
 .../proc-macro2-1-rs/meson/meson.build             |   6 +
 subprojects/packagefiles/quote-1-rs/meson.build    |  31 --
 subprojects/packagefiles/syn-2-rs/meson.build      |  43 ---
 .../packagefiles/unicode-ident-1-rs/meson.build    |  22 --
 subprojects/probe-0.5-rs.wrap                      |   3 +-
 subprojects/proc-macro-error-1-rs.wrap             |  10 -
 subprojects/proc-macro-error-attr-1-rs.wrap        |  10 -
 subprojects/proc-macro2-1-rs.wrap                  |   4 +-
 subprojects/quote-1-rs.wrap                        |   3 +-
 subprojects/syn-2-rs.wrap                          |   3 +-
 subprojects/unicode-ident-1-rs.wrap                |   3 +-
 target/i386/mshv/meson.build                       |   1 +
 tests/lcitool/mappings.yml                         |  26 +-
 tests/lcitool/projects/qemu.yml                    |   4 -
 .../{opensuse-leap-15.yml => centos-stream-9.yml}  |   0
 tests/tcg/x86_64/Makefile.target                   |   1 +
 tests/vm/generated/freebsd.json                    |   4 -
 135 files changed, 1915 insertions(+), 1664 deletions(-)
 create mode 100644 hw/i386/mshv/apic.c
 create mode 100644 hw/i386/mshv/clock.c
 create mode 100644 target/i386/mshv/synic.c
 create mode 100644 tests/tcg/x86_64/segment-prefixes.c
 rename rust/Cargo.lock => Cargo.lock (69%)
 rename rust/Cargo.toml => Cargo.toml (96%)
 create mode 100644 hw/i386/mshv/meson.build
 delete mode 100644 python/wheels/meson-1.11.1-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.12.0-py3-none-any.whl
 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
 delete mode 100644 subprojects/bilge-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 create mode 100644 subprojects/bitfield-struct-0.13-rs.wrap
 delete mode 100644 subprojects/either-1-rs.wrap
 delete mode 100644 subprojects/itertools-0.11-rs.wrap
 delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
 delete mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build
 delete mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
 delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/probe-0.5-rs/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build
 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
 rename tests/lcitool/targets/{opensuse-leap-15.yml => centos-stream-9.yml} (100%)
-- 
2.55.0


