Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6363E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPYq-00005w-Do; Wed, 11 Dec 2024 11:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYl-0008Ao-EJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYh-0000Cn-Hx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vcbh0wU54u4cln27mRHhUKd6cSh5sGI+hr+czhapRFQ=;
 b=Kzzr0umiF4oE/KkAjQZLSlUB0Xo3yronOuz0xvwQLpDeilPyNYZWZjsk8e6qy8OImXLQJc
 yIvKyhoZ1E/BKcAZXJICYVXHmv5rsFQrwql4gDwUDyfrXykN60IEZeQ+qk8QKdtTHPhyBA
 m0l45ZdcUowjRbyWvCsWPEPO8BdsiOk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-eMk01x7YPnqVe9A8A-DySg-1; Wed, 11 Dec 2024 11:27:25 -0500
X-MC-Unique: eMk01x7YPnqVe9A8A-DySg-1
X-Mimecast-MFC-AGG-ID: eMk01x7YPnqVe9A8A-DySg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e27c5949so4177073f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934443; x=1734539243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vcbh0wU54u4cln27mRHhUKd6cSh5sGI+hr+czhapRFQ=;
 b=jjhKekdrhcLFpC27fiV9JCufoC4QdhiFG7Oep1MtFL1+JHdutx8k9+vZbB/sSSSp12
 lQZ2vVg7qg8/aUQP3VLhSFA0dUB96XMv+QhxigXp39zPrIWb51gUYr+hkwXbHzr5DQkW
 WOhlxhSwKyghMCW7n7G6i7E76ur5x7ennlnu580F9C0WqUz3H3OffHGnb5+3ZLGFqL6K
 0Ls2WGBJqehXJyfGAgQfZrBou7lSTQ060K2sCnOjsv4NVasTdW90xJpcPEPMHql70Gzh
 D9bx1ulL+ibudk6S3Y/ZDMBOzOTrdQuVCnTqCXdH/fvV3fk+DTPqLURZwVsAChpB68kt
 djpQ==
X-Gm-Message-State: AOJu0Yx5H8nE1xc7gowZKUbwFFKpbuR5UR6bvRGX3e66qDXzBxjBtiHd
 HkdkYQD2TpZS5qL5g3HJz9OmCFNvlWBLXtYIqBbWOdE4XXoExx2rDsMWW7AV90KIyc7OzkXNsCD
 aIJmwYsIxhdTyiq0yjGrtrvgKb8+RU4Wak9V3EXl12pyt9z975Q2LX/En24BdG1h4zkL3R8bF+z
 hByuJhmAWMKZr+DbxY5ouBJalyyP6w7CTFykbc
X-Gm-Gg: ASbGncvS7emSeP48D2TmzWy1/4s+dp3BehCMRfkJmV4mFLkLg3t2uE5o1c6avTwuQbi
 pZ22omtKlMB9Z0ncSW1k+dS+Musd10Zs/aWZd9TUO2O3LykdiBPKtD8pguLlABi6WPNDdZJ7g08
 uIUbSrUgO5mWdWZcTj626L8SRtDYmdVG5B0pghIAIzVetrPJ0mlV1NI6+WWVqDZvTSbj0+nAhGw
 SnDKbnOz6bg0KyCj+leshXQvj65HTYsL37VK3TqMsUjItB4IUBWr5CA
X-Received: by 2002:a5d:6d89:0:b0:385:f10a:335 with SMTP id
 ffacd0b85a97d-3878768dc29mr171093f8f.21.1733934443353; 
 Wed, 11 Dec 2024 08:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3O1JCVuN081k07IHVXaUTbbT2qdHhjVJcqdD6FZufdUOHDoXwts9z6ZWe76G6zMcaJRD/BA==
X-Received: by 2002:a5d:6d89:0:b0:385:f10a:335 with SMTP id
 ffacd0b85a97d-3878768dc29mr171073f8f.21.1733934442871; 
 Wed, 11 Dec 2024 08:27:22 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e323828sm13763055e9.0.2024.12.11.08.27.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/49] rust, QOM, kvm changes for 2024-12-11
Date: Wed, 11 Dec 2024 17:26:30 +0100
Message-ID: <20241211162720.320070-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit ae35f033b874c627d81d51070187fbf55f0bf1a7:

  Update version for v9.2.0 release (2024-12-10 16:20:54 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 166e8a1fd15bfa527b25fc15ca315e572c0556d2:

  rust: qom: change the parent type to an associated type (2024-12-11 15:57:19 +0100)

----------------------------------------------------------------
* rust: better integration with clippy, rustfmt and rustdoc
* rust: interior mutability types
* rust: add a bit operations module
* rust: first part of QOM rework
* kvm: remove unnecessary #ifdef
* clock: small cleanups, improve handling of Clock lifetimes

----------------------------------------------------------------
Junjie Mao (1):
      rust/qemu-api: Fix fragment-specifiers in define_property macro

Paolo Bonzini (32):
      ci: enable rust in the Debian and Ubuntu system build job
      rust: apply --cfg MESON to all crates
      rust: allow using build-root bindings.rs from cargo
      rust: build: move rustc_args.py invocation to qemu-api crate
      rust: build: restrict --cfg generation to only required symbols
      rust: build: generate lint flags from Cargo.toml
      rust: cargo: store desired warning levels in workspace Cargo.toml
      rust: build: move strict lints handling to rustc_args.py
      rust: fix a couple style issues from clippy
      rust: build: establish a baseline of lints across all crates
      rust: build: add "make clippy", "make rustfmt", "make rustdoc"
      rust: ci: add job that runs Rust tools
      rust: fix doc test syntax
      clock: clear callback on unparent
      clock: treat outputs and inputs the same in NamedClockList
      clock: inline most of qdev_init_clocklist
      kvm: remove unnecessary #ifdef
      bql: check that the BQL is not dropped within marked sections
      rust: cell: add BQL-enforcing Cell variant
      rust: cell: add BQL-enforcing RefCell variant
      rust: define prelude
      rust: add bindings for interrupt sources
      rust: add a bit operation module
      rust: qom: add default definitions for ObjectImpl
      rust: qom: rename Class trait to ClassInitImpl
      rust: qom: convert type_info! macro to an associated const
      rust: qom: move ClassInitImpl to the instance side
      rust: qdev: move device_class_init! body to generic function, ClassInitImpl implementation to macro
      rust: qdev: move bridge for realize and reset functions out of pl011
      rust: qom: move bridge for TypeInfo functions out of pl011
      rust: qom: split ObjectType from ObjectImpl trait
      rust: qom: change the parent type to an associated type

Zhao Liu (16):
      arm: Replace type_register() with type_register_static()
      hw/block: Replace type_register() with type_register_static()
      hw/net: Replace type_register() with type_register_static()
      ppc: Replace type_register() with type_register_static()
      hw/rtc: Replace type_register() with type_register_static()
      hw/scsi: Replace type_register() with type_register_static()
      hw/sensor: Replace type_register() with type_register_static()
      hw/usb: Replace type_register() with type_register_static()
      hw/virtio: Replace type_register() with type_register_static()
      i386: Replace type_register() with type_register_static()
      target/mips: Replace type_register() with type_register_static()
      target/sparc: Replace type_register() with type_register_static()
      target/xtensa: Replace type_register() with type_register_static()
      ui: Replace type_register() with type_register_static()
      script/codeconverter/qom_type_info: Deprecate MakeTypeRegisterStatic and MakeTypeRegisterNotStatic
      qom/object: Remove type_register()

 meson.build                                        |  57 +-
 include/hw/clock.h                                 |   8 -
 include/hw/i386/pc.h                               |   4 +-
 include/qemu/main-loop.h                           |  15 +
 include/qom/object.h                               |  14 -
 target/i386/kvm/kvm_i386.h                         |  11 +-
 hw/arm/armsse.c                                    |   2 +-
 hw/arm/smmuv3.c                                    |   4 +-
 hw/block/m25p80.c                                  |   2 +-
 hw/core/clock.c                                    |  22 +-
 hw/core/qdev-clock.c                               |  86 +--
 hw/net/e1000.c                                     |   2 +-
 hw/net/eepro100.c                                  |   2 +-
 hw/ppc/spapr.c                                     |   2 +-
 hw/rtc/m48t59-isa.c                                |   2 +-
 hw/rtc/m48t59.c                                    |   2 +-
 hw/scsi/megasas.c                                  |   2 +-
 hw/scsi/mptsas.c                                   |   2 +-
 hw/sensor/tmp421.c                                 |   2 +-
 hw/usb/hcd-ehci-pci.c                              |   2 +-
 hw/usb/hcd-uhci.c                                  |   2 +-
 hw/virtio/virtio-pci.c                             |   8 +-
 qom/object.c                                       |   7 +-
 stubs/iothread-lock.c                              |  15 +
 system/cpus.c                                      |  15 +
 target/arm/cpu.c                                   |   2 +-
 target/arm/cpu64.c                                 |   2 +-
 target/i386/cpu.c                                  |   2 +-
 target/mips/cpu.c                                  |   2 +-
 target/ppc/kvm.c                                   |   2 +-
 target/sparc/cpu.c                                 |   2 +-
 target/xtensa/helper.c                             |   2 +-
 ui/console-vc.c                                    |   2 +-
 ui/dbus.c                                          |   2 +-
 ui/gtk.c                                           |   2 +-
 ui/spice-app.c                                     |   2 +-
 .gitlab-ci.d/buildtest.yml                         |   4 +-
 .gitlab-ci.d/static_checks.yml                     |  24 +
 rust/Cargo.toml                                    |  82 ++
 rust/hw/char/pl011/.gitignore                      |   2 -
 rust/hw/char/pl011/Cargo.toml                      |   3 +
 rust/hw/char/pl011/src/device.rs                   | 124 ++--
 rust/hw/char/pl011/src/device_class.rs             |  34 -
 rust/hw/char/pl011/src/lib.rs                      |  19 +-
 rust/hw/char/pl011/src/memory_ops.rs               |   4 +-
 rust/meson.build                                   |  22 +
 rust/qemu-api-macros/Cargo.toml                    |   3 +
 rust/qemu-api/.gitignore                           |   2 +-
 rust/qemu-api/Cargo.toml                           |   8 +-
 rust/qemu-api/README.md                            |  10 +-
 rust/qemu-api/build.rs                             |  39 +-
 rust/qemu-api/meson.build                          |  14 +-
 rust/qemu-api/src/bindings.rs                      |  29 +
 rust/qemu-api/src/bitops.rs                        | 119 +++
 rust/qemu-api/src/cell.rs                          | 822 +++++++++++++++++++++
 rust/qemu-api/src/definitions.rs                   | 149 +++-
 rust/qemu-api/src/device_class.rs                  | 126 +++-
 rust/qemu-api/src/irq.rs                           |  91 +++
 rust/qemu-api/src/lib.rs                           |  29 +-
 rust/qemu-api/src/prelude.rs                       |  10 +
 rust/qemu-api/src/sysbus.rs                        |  33 +
 rust/qemu-api/src/zeroable.rs                      |   6 +-
 rust/qemu-api/tests/tests.rs                       |  43 +-
 .../codeconverter/codeconverter/qom_type_info.py   |  20 -
 scripts/rust/rustc_args.py                         | 181 ++++-
 .../docker/dockerfiles/fedora-rust-nightly.docker  |   4 +
 tests/lcitool/refresh                              |   4 +
 67 files changed, 1927 insertions(+), 445 deletions(-)
 delete mode 100644 rust/hw/char/pl011/.gitignore
 create mode 100644 rust/qemu-api/src/bindings.rs
 create mode 100644 rust/qemu-api/src/bitops.rs
 create mode 100644 rust/qemu-api/src/cell.rs
 create mode 100644 rust/qemu-api/src/irq.rs
 create mode 100644 rust/qemu-api/src/prelude.rs
 create mode 100644 rust/qemu-api/src/sysbus.rs
-- 
2.47.1


