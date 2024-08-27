Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EA6C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIa-0002Hg-TO; Tue, 27 Aug 2024 07:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIY-0002Dt-OX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:42 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIU-0000hZ-Kv
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:42 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5334adf7249so6327762e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757816; x=1725362616; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oMVm/v+jQDrT8BtxJWUOTVTd+QdK/nIZHjMLBY365fs=;
 b=qAQYaRCez/GHhqdoXdaHNHdlLIuZgw3BbNOnQKqIheyxiNdQ6YNzQKTQ3TwfQlmvsu
 NAAN8T/WoNefvh5+Fl8iaB4Lf/pLa0IOe/5QS8870KCbcOX4mZPwA/mbX3p3ttxz3qgY
 psaveACyjwUVy9a4j33az9/ImVSk+2iXj2ozBdl0BTbXWIy+Dy5YXnAr6yRUIcUfelo1
 ey+eBGRD4ytOZYPEQp2eB3BuL33PAwfBnY9xpcXPAHTBqBsF6pqlg1uHctOsFwDop3Sa
 z/4gDO99ax/3oVYHZsrD3xNL5XWWINANwOuD7T2p5RvS2mmfOtH4vXtcHusIkEABPHTW
 3Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757816; x=1725362616;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oMVm/v+jQDrT8BtxJWUOTVTd+QdK/nIZHjMLBY365fs=;
 b=AM1jswJx5OoayPHVGMgVGqYZygdq8E+tmdxW2f39JaWjV2yrJSq7QfmI1o5GpQHQMg
 JJCDp02TvZxckTrccIaHuGGUu2MBAnQ6fSCnSwE6ZzzCUjUdpOVu/eaovnKBV8+OmJEm
 E4UNwfdAVA387a43m1ZnUPrfPXRYVCOLlsYuVQ2zebttGRFEUSKqOO3wNnx/ABjn3nDE
 X98dCpHGX6BrFKgLXltFrXEWTvEGRJmicxgb6cHLmBM+TZv/lun8vTRgNBZ/YNzbeq87
 C+CTPMmrdvhV7aQeMyrktnHIJXgfNmxx6RWFm80CSFJHqsufAoehmNnfAbBrP7F7E6SU
 3yFg==
X-Gm-Message-State: AOJu0YxD3WZBbO0GefePCJ3oMH08JxL/NsaDf1BawmE0LBvqSeBvzeK9
 i25R9I73kcN7XDx4oZ7kjqH454jhm9Vt9i1B/r7CD6sacvG1EA7kyFPzIy1iUdO9UZnJPStdwZt
 gY+E=
X-Google-Smtp-Source: AGHT+IFW7Upuwihz6szOKb2lIHRqKHodQ4VKVmG8/GYpjfYUbOJcaeekB8KMb1tsiLqmJPWWqX+q/A==
X-Received: by 2002:a05:6512:e9a:b0:530:c212:4a5a with SMTP id
 2adb3069b0e04-5344e3c9983mr1664718e87.22.1724757815721; 
 Tue, 27 Aug 2024 04:23:35 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:35 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v9 0/9] Add Rust build support, ARM PL011 device impl
Date: Tue, 27 Aug 2024 14:23:09 +0300
Message-Id: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB23zWYC/1WMywqDMBBFf0Vm3ZQ8TE1c9T9KF1qjDoiRiZUW8
 d87FQp1eS73nBVSIAwJymwFCgsmjCODP2Xw6KuxCwIbZtBS59KpXNAzzWIapFJiKYBvE4UWX3v
 idmfuMc2R3nuRH7z+ZHuUhRS+sMrY4J0z6jrgWFE8R+rg21ncn6vNwXXs1r61RX6pm6o1B3fbt
 g9ZjDza1wAAAA==
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=7838;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=kul2ENg99DUpnaWYBxvyPVd7Ry/m5MSOf9TcYNEzaHY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmN6MVdVYmtTSEtsM1A3OHVzK0JjSE9QY3QzClM5WU5BdXdpZ1VidnpqTEJ5
 dWlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM013QUt
 DUkIzS2Nkd2YzNEowRUlXRC85eHVZYlBpT1ROcjdzYUxYemRrb1VHZUhyWU5XQzUyR0dod04vcQ
 prcFVrOW8yeVRLWExyc1A3RWEreW1EbW5jZXlZZlU5Znd4NlpCbFhJVFBDM21mUTkzVnhnWHVEV
 ExGUEoySUVXCkNMdUVUQ0Vqb2kvU00vVVQyZFh2R1VscHBkbGpvazdWNmxBU1N6NDFkN0VYTzRH
 aE80KzBVR282d1BvaStzUTUKSXNLdXpVNzY3Snp5Q0dQQmJ2Q21RVTZBL2ZUUXFzM0dzMUpUUkp
 0a256bVV4NlVmWGZpNnJGU2JaSVhSTklwUgpvVzFJQTJHaE52YmZvNWRESXhYbFlFQVpUaTZHOT
 JmSXNtNS9FZDNwWFBUUFJLZDRYTjB3WU02Uzh1dVErZVNNCmltYU45a01YbjBrVnlKcG10VENzS
 HlyOHpiM0xyMEkrQmx6RlFvN3ZHelVMY3JKTExjdmZBeVhqM1d4d0hJUVIKLzB3U3pvNlNuejlt
 QXZhNE9IMW5MSzZBVTNSSEhqSGU0ajZyaDR4S2xDZG9BSWNqSHZGZktsa1lqR2UzY25mUQo3RHV
 NK3NhaW5GYTZNL2NXcW5haWZxcnFRUkM0dUNidWpBUkdva2dxQktxNy9JN2pVRDZ2cm5Id0NLWW
 9IV1NqCm84b3pONlJSUjFWRDRCamoyRHA5Wm9mbWZCZWloY0JXMFhFdGlBSEFQWWJmdSs2WnRaM
 nNDSXRVNXFBYk40ajcKSXpPb2pGN2ZCL2pQWnY1bk1heXFhUDB1UnJXZVZlQTN3TnBaRUZlYndt
 MGdlY0xBQ0cyR1dlNWFkc2l5YmtLZQpQY3dSblRKa1ZYcm5KNzNqaWRsVy9DNXVOSlBacTY5Zk9
 ldkNjNkpoQmdENzZPZEZ3ZXU2MXkyWFA4OWpvL1dWCkU2b0ZtQT09Cj1aVTYxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello everyone,

This series adds:

- build system support for the Rust compiler
- a small Rust library, qemu-api, which includes bindings to QEMU's C
  interface generated with bindgen, and qemu-api-macros, a procedural
  macro library.
- a proof of concept ARM PL011 device implementation in Rust, chosen for
  its low complexity. The device is used in the arm virt machine if qemu
  is compiled with rust enabled (./configure --enable-rust [...])

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v9:
- Addressed v8 review comment: removed rustfmt.toml symlink (Junjie Mao)
- Addressed v8 review comment: removed unused cstr files (Junjie Mao)
- Addressed v8 review comment: added HAVE_GLIB_WITH_ALIGNED_ALLOC config
  host def to check whether glib's aligned alloc functions are available (Junjie Mao)
- qemu_api: Changed default alignment condition in allocator (alignment
  is always nonzero)
- qemu_api: Enabled allocator by default in builds
- pl011: fixed invalid cast of byte buffer to u32 in pl011_receive()
  leading to misaligned read

- Link to v8: https://lore.kernel.org/r/20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org

Changes in v8:
- Allow for compilation of more than one Rust-based component in Meson
  by compiling all Rust static libraries into one "root" library before
  linking it to each target emulation executable.
- Added a qemu_api_macros procedural macro library.
- (minor) Moved generated bindings.rs to qemu_api crate using meson's
  structured_source() instead of compiling it as a standalone crate
  which was unnecessary.
- (minor) Removed unnecessary rustc optimization/debug flags (should be handled
  by meson instead).
- (minor) Moved build scripts under scripts/rust/
- (minor) Fixed license issues

Previous version was: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>

https://lore.kernel.org/qemu-devel/20240815-rust-pl011-v7-0-975135e98831@linaro.org/

Outstanding issues that are not blocking for merge are:

- Cross-compilation for aarch64 is not possible out-of-the-box because of this bug:
  <https://github.com/rust-lang/rust/issues/125619> in llvm which when
  fixed, must be ported to upstream rust's llvm fork. Since the problem
  is an extraneous symbol we could strip it with objcopy -N|--strip-symbol
  Update since last version: Fix is in upstream llvm, we're awaiting for
  rust upstream to pick it up.

---
Manos Pitsidianakis (7):
      build-sys: Add rust feature option
      rust: add bindgen step as a meson dependency
      .gitattributes: add Rust diff and merge attributes
      meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
      rust: add crate to expose bindings and interfaces
      rust: add utility procedural macro crate
      rust: add PL011 device model

Paolo Bonzini (2):
      Require meson version 1.5.0
      configure, meson: detect Rust toolchain

 MAINTAINERS                                        |  21 +
 configure                                          |  50 +-
 meson.build                                        |  87 ++-
 rust/wrapper.h                                     |  39 ++
 .gitattributes                                     |   3 +
 Kconfig                                            |   1 +
 Kconfig.host                                       |   3 +
 hw/arm/Kconfig                                     |  33 +-
 meson_options.txt                                  |   3 +
 python/scripts/vendor.py                           |   4 +-
 python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 964928 -> 0 bytes
 python/wheels/meson-1.5.0-py3-none-any.whl         | Bin 0 -> 959846 bytes
 pythondeps.toml                                    |   2 +-
 rust/.gitignore                                    |   3 +
 rust/Kconfig                                       |   1 +
 rust/hw/Kconfig                                    |   2 +
 rust/hw/char/Kconfig                               |   3 +
 rust/hw/char/meson.build                           |   1 +
 rust/hw/char/pl011/.gitignore                      |   2 +
 rust/hw/char/pl011/Cargo.lock                      | 134 +++++
 rust/hw/char/pl011/Cargo.toml                      |  26 +
 rust/hw/char/pl011/README.md                       |  31 ++
 rust/hw/char/pl011/meson.build                     |  26 +
 rust/hw/char/pl011/src/definitions.rs              |  20 +
 rust/hw/char/pl011/src/device.rs                   | 594 +++++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs             |  59 ++
 rust/hw/char/pl011/src/lib.rs                      | 585 ++++++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs               |  57 ++
 rust/hw/meson.build                                |   1 +
 rust/meson.build                                   |   4 +
 rust/qemu-api-macros/Cargo.lock                    |  47 ++
 rust/qemu-api-macros/Cargo.toml                    |  25 +
 rust/qemu-api-macros/README.md                     |   1 +
 rust/qemu-api-macros/meson.build                   |  25 +
 rust/qemu-api-macros/src/lib.rs                    |  43 ++
 rust/qemu-api/.gitignore                           |   2 +
 rust/qemu-api/Cargo.lock                           |   7 +
 rust/qemu-api/Cargo.toml                           |  26 +
 rust/qemu-api/README.md                            |  17 +
 rust/qemu-api/build.rs                             |  14 +
 rust/qemu-api/meson.build                          |  24 +
 rust/qemu-api/src/definitions.rs                   | 109 ++++
 rust/qemu-api/src/device_class.rs                  | 128 +++++
 rust/qemu-api/src/lib.rs                           | 154 ++++++
 rust/qemu-api/src/tests.rs                         |  49 ++
 rust/rustfmt.toml                                  |   7 +
 scripts/archive-source.sh                          |   5 +-
 scripts/make-release                               |   5 +-
 scripts/meson-buildoptions.sh                      |   3 +
 scripts/rust/rust_root_crate.sh                    |  13 +
 scripts/rust/rustc_args.py                         |  84 +++
 subprojects/.gitignore                             |  11 +
 subprojects/arbitrary-int-1-rs.wrap                |   7 +
 subprojects/bilge-0.2-rs.wrap                      |   7 +
 subprojects/bilge-impl-0.2-rs.wrap                 |   7 +
 subprojects/either-1-rs.wrap                       |   7 +
 subprojects/itertools-0.11-rs.wrap                 |   7 +
 .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 +
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 ++
 subprojects/packagefiles/either-1-rs/meson.build   |  24 +
 .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
 .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
 .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
 .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
 subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
 subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
 .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
 subprojects/proc-macro-error-1-rs.wrap             |   7 +
 subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
 subprojects/proc-macro2-1-rs.wrap                  |   7 +
 subprojects/quote-1-rs.wrap                        |   7 +
 subprojects/syn-2-rs.wrap                          |   7 +
 subprojects/unicode-ident-1-rs.wrap                |   7 +
 tests/lcitool/mappings.yml                         |   2 +-
 75 files changed, 2991 insertions(+), 21 deletions(-)
---
base-commit: a733f37aef3b7d1d33bfe2716af88cdfd67ba64e
change-id: 20240814-rust-pl011-v7

Best regards,
-- 
γαῖα πυρί μιχθήτω


