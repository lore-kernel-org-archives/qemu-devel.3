Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A341D37E3A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1Fe-0008Fc-7f; Wed, 14 Jan 2026 08:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1Fa-0008CF-5Z
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1FW-0002FW-JB
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768398565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qFvkqXPWeaOIwcBw6au0M5/7JA1wjvaARX5VBdGvL3g=;
 b=L9MKA18Ry4yDAr1si7W+BtWsh8N62TLgZxr+0krvUC+AEUh27ic+nsPvdDWQEgT2639Sik
 9ZrcvyFPWZw4pIh+47ZaNPdcJzvsFCvbVKPfcszba9FgmArXmb9sSglTAFigTiZHPvuEqI
 9847dlcdAlsb99377FQ24Bin945OxB0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-rThJC1OyMuKyeTB9xiJdvg-1; Wed, 14 Jan 2026 08:49:23 -0500
X-MC-Unique: rThJC1OyMuKyeTB9xiJdvg-1
X-Mimecast-MFC-AGG-ID: rThJC1OyMuKyeTB9xiJdvg_1768398563
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so3663785e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 05:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768398562; x=1769003362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qFvkqXPWeaOIwcBw6au0M5/7JA1wjvaARX5VBdGvL3g=;
 b=A+kdtVo37ZABC8G4veWF6LY0CieaapI+IuqWvR+y9pK1Q+FjES7G5nZzEsqZxXSr8p
 CIGjDRAvq4xJFt9TU7nTM2X8S2wgFEg5FSdmeRzgw40w4Cr0SnZ/45UFgptUkxtr2CUQ
 0eR8tQtExUqaWB+aT9wdqqF2ZN/l8CRJvzdhjW0gjqejx8GkWblKcgWGWgULsbhBnIoY
 2Z7yBLQiONMYJrxHOJCh8Uece4ps3lQGpWm4zu3XAorNut8GLd+9ehBJu9mTFiXleY42
 Nsgyo57DMjgs8LDyvz6s/8qjSH5QwuSrN1n21C7EXrBW4aQfwANBc+JYXskC+aHyM/9S
 Lmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768398562; x=1769003362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFvkqXPWeaOIwcBw6au0M5/7JA1wjvaARX5VBdGvL3g=;
 b=IjmQqMlFeHZXJ+xd6EKvsxKv4o1PgmqtJ5vKAwOvhSTHt/UqdCRxAGOFcehc2i70XF
 iVp4OSDHJX/0F/3ISwA/R9oiEI9kr+aigYEjAr0raVZthv8wIwBSDgdpDUBYK4YEFnQX
 lv9X0mrcm+X1p4YNBL8YF0vajj+Ffx3oKanWOOXzpwZhfjBEuB0eR3Co0qODwcHMviNf
 DucdoBMfWxr5o1UhcxscM8+hKMI5+dF/qlyYdn2dJFsaBFnkvcIY/6sDRsaFdn+Ic/bD
 PEYh7rbkXHSSjNDPB58e33ZWXVxy2BMiwd9dhJedQhRRJNGgN6aE+D7PmZSiBKc676wX
 NoEg==
X-Gm-Message-State: AOJu0YzGj50lqvB5uKGHO1d4LSTYgFheIqC7liLJRb+Z9qRwRYtMRKD2
 jBlaUiYaFP1ckpOJmyL+HLGKtxVnvuBRd9gkXLxkEXAkk4KtyIrfIh82N+2kugq6wlCI6R3cNNI
 bejFHNoAE14InYvTOjOp0liYq8ShvAbdjRWaDTXfphz2KK9RznZkfbTaXrkZi8dGMo6M2h60QS+
 mJSvmjpmpa7iK5/FdIdR7TFbG3l6AgUCkisrvvOD+w
X-Gm-Gg: AY/fxX5KELWioSvcgTpklsAeJh99l0RrMEh/n+3LQ9v4jNrx4GR2N0+2aHV3Y4iv2eo
 9MeEeEXZMUFH3bNhN8I3uCzLQC8eT59Banyp7a9O+e5JsTxxpE5F0PkNDV8xx27KW6rzet8NZcR
 MVMU7la3dyl/2LaSQfAn4DlI5SJ5Jk9v5EVt+seir166qCYwe0csL1kKgs6q1dWTjjoqXABfWNl
 b7077PpMylPeS/aXH3pvz7YT+bYp7fKPowwCO7nqKYpEnJX3/+aEjPY2Vr5osBxdPRfFiYO3/n5
 dPjXuu2nc6SZebDtjYDK1a2MBbJhp9qZKivkUevSelO326yuN6lEgHagqGQGmSDIqGziZwjyG9R
 Ob+PkBnzPtJrDpY45HdPbJz+fV7hLeoVCzLvIcJUL57FDaOCZOBgyCQn/JR9KVGeztuKihZzMum
 ij43sDv/N/b5KIZA==
X-Received: by 2002:a05:600c:811a:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47ee4833c16mr21688375e9.32.1768398561854; 
 Wed, 14 Jan 2026 05:49:21 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47ee4833c16mr21688115e9.32.1768398561381; 
 Wed, 14 Jan 2026 05:49:21 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee7d58f09sm18225835e9.12.2026.01.14.05.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 05:49:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 0/3] rust: reorganize binding generation, fix msys2 linking
Date: Wed, 14 Jan 2026 14:49:16 +0100
Message-ID: <20260114134919.1476518-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Yet another joint work between Marc-André and myself, moving raw FFI
bindings generation to separate crates and finally getting the Rust
crate organization in a more-or-less definitive shape.

This makes it possible to reuse bindgen declarations for a header file
in its dependencies (this was not the case before this change), while
keeping multiple -sys crates to avoid rebuilding all the code whenever
something changes.

Because a script is now needed to handle bindgen command line
generation, I took the occasion to move the various output tweak
arguments (--rustified-enum, etc.) to Cargo.toml's metadata section.
This removes the need to touch meson.build files for this customization.
 
Also, because the -sys crates are generated in dependency order, this
also enforces that the crates are organized in something that resembles
the dependencies between C headers.  This highlights a mismatch between
dependency ordering on the C and Rust sides, which also causes a link
failure on msys2.  The mismatch has to be fixed by the reorganization of
the -sys crates, and patch 3 applies the same change to the high-level
bindings.

While the new approach has more source code lines, IMO that's balanced
by the many advantages (extra checks on dependency orders, more clarity
from placing bindgen tweaks in Cargo.toml, correctness brought by the
shared types, and compilation speed improvements).

Paolo


Marc-André Lureau (1):
  rust: move binding generation to bindings/

Paolo Bonzini (2):
  rust: move class_init to an extension trait
  rust: move hwcore::sysbus to system crate

 docs/devel/rust.rst                           |  57 ++++++
 meson.build                                   |   3 +-
 rust/bindings/chardev-sys/wrapper.h           |  12 ++
 rust/bindings/hwcore-sys/wrapper.h            |  30 ++++
 rust/bindings/migration-sys/wrapper.h         |  10 ++
 rust/bindings/qom-sys/wrapper.h               |  17 ++
 rust/bindings/system-sys/wrapper.h            |  21 +++
 rust/bindings/util-sys/wrapper.h              |  39 +++++
 rust/bql/wrapper.h                            |  27 ---
 rust/chardev/wrapper.h                        |  28 ---
 rust/hw/core/wrapper.h                        |  32 ----
 rust/migration/wrapper.h                      |  51 ------
 rust/qom/wrapper.h                            |  27 ---
 rust/system/wrapper.h                         |  29 ----
 rust/util/wrapper.h                           |  32 ----
 rust/Cargo.lock                               |  68 ++++++++
 rust/{util => bindings}/build.rs              |  30 ++--
 rust/bindings/chardev-sys/Cargo.toml          |  28 +++
 rust/bindings/chardev-sys/build.rs            |   1 +
 .../chardev-sys/lib.rs}                       |   7 +-
 rust/bindings/chardev-sys/meson.build         |  12 ++
 rust/bindings/generate_bindgen_args.py        | 163 ++++++++++++++++++
 rust/bindings/hwcore-sys/Cargo.toml           |  32 ++++
 rust/bindings/hwcore-sys/build.rs             |   1 +
 .../hwcore-sys/lib.rs}                        |  17 +-
 rust/bindings/hwcore-sys/meson.build          |  12 ++
 rust/bindings/meson.build                     |  37 ++++
 rust/bindings/migration-sys/Cargo.toml        |  28 +++
 rust/bindings/migration-sys/build.rs          |   1 +
 rust/bindings/migration-sys/lib.rs            | 125 ++++++++++++++
 rust/bindings/migration-sys/meson.build       |  12 ++
 rust/bindings/qom-sys/Cargo.toml              |  25 +++
 rust/bindings/qom-sys/build.rs                |   1 +
 .../bindings.rs => bindings/qom-sys/lib.rs}   |   4 +
 rust/bindings/qom-sys/meson.build             |  12 ++
 rust/bindings/system-sys/Cargo.toml           |  30 ++++
 rust/bindings/system-sys/build.rs             |   1 +
 .../system-sys/lib.rs}                        |   4 +-
 rust/bindings/system-sys/meson.build          |  12 ++
 rust/bindings/util-sys/Cargo.toml             |  25 +++
 rust/bindings/util-sys/build.rs               |   1 +
 .../bindings.rs => bindings/util-sys/lib.rs}  |   2 +-
 rust/bindings/util-sys/meson.build            |  12 ++
 rust/bql/Cargo.toml                           |   1 +
 rust/bql/build.rs                             |   1 -
 rust/bql/meson.build                          |  30 +---
 rust/bql/src/bindings.rs                      |  27 ---
 rust/bql/src/lib.rs                           |   3 +-
 rust/chardev/Cargo.toml                       |   1 +
 rust/chardev/build.rs                         |   1 -
 rust/chardev/meson.build                      |  37 +---
 rust/chardev/src/lib.rs                       |   2 +-
 rust/hw/char/pl011/build.rs                   |   2 +-
 rust/hw/char/pl011/meson.build                |  21 +--
 rust/hw/char/pl011/src/bindings.rs            |   7 +-
 rust/hw/core/Cargo.toml                       |   2 +-
 rust/hw/core/build.rs                         |   1 -
 rust/hw/core/meson.build                      |  62 +------
 rust/hw/core/src/irq.rs                       |   4 +-
 rust/hw/core/src/lib.rs                       |   6 +-
 rust/hw/core/src/prelude.rs                   |   6 +-
 rust/hw/core/src/qdev.rs                      |  31 ++--
 rust/hw/core/tests/tests.rs                   |   4 +-
 rust/meson.build                              |   3 +-
 rust/migration/Cargo.toml                     |   1 +
 rust/migration/build.rs                       |   1 -
 rust/migration/meson.build                    |  40 +----
 rust/migration/src/bindings.rs                |  49 ------
 rust/migration/src/lib.rs                     |   3 +-
 rust/migration/src/vmstate.rs                 |  73 --------
 rust/qom/Cargo.toml                           |   1 +
 rust/qom/build.rs                             |   1 -
 rust/qom/meson.build                          |  29 +---
 rust/qom/src/lib.rs                           |   3 +-
 rust/qom/src/prelude.rs                       |   1 +
 rust/qom/src/qom.rs                           |   8 +-
 rust/system/Cargo.toml                        |   4 +
 rust/system/build.rs                          |   1 -
 rust/system/meson.build                       |  39 +----
 rust/system/src/lib.rs                        |   5 +-
 rust/system/src/memory.rs                     |   2 +-
 rust/system/src/prelude.rs                    |   5 +
 rust/{hw/core => system}/src/sysbus.rs        |  36 ++--
 rust/util/Cargo.toml                          |   1 +
 rust/util/meson.build                         |  42 +----
 rust/util/src/lib.rs                          |   3 +-
 86 files changed, 965 insertions(+), 753 deletions(-)
 create mode 100644 rust/bindings/chardev-sys/wrapper.h
 create mode 100644 rust/bindings/hwcore-sys/wrapper.h
 create mode 100644 rust/bindings/migration-sys/wrapper.h
 create mode 100644 rust/bindings/qom-sys/wrapper.h
 create mode 100644 rust/bindings/system-sys/wrapper.h
 create mode 100644 rust/bindings/util-sys/wrapper.h
 delete mode 100644 rust/bql/wrapper.h
 delete mode 100644 rust/chardev/wrapper.h
 delete mode 100644 rust/hw/core/wrapper.h
 delete mode 100644 rust/migration/wrapper.h
 delete mode 100644 rust/qom/wrapper.h
 delete mode 100644 rust/system/wrapper.h
 delete mode 100644 rust/util/wrapper.h
 rename rust/{util => bindings}/build.rs (55%)
 create mode 100644 rust/bindings/chardev-sys/Cargo.toml
 create mode 120000 rust/bindings/chardev-sys/build.rs
 rename rust/{chardev/src/bindings.rs => bindings/chardev-sys/lib.rs} (84%)
 create mode 100644 rust/bindings/chardev-sys/meson.build
 create mode 100644 rust/bindings/generate_bindgen_args.py
 create mode 100644 rust/bindings/hwcore-sys/Cargo.toml
 create mode 120000 rust/bindings/hwcore-sys/build.rs
 rename rust/{hw/core/src/bindings.rs => bindings/hwcore-sys/lib.rs} (71%)
 create mode 100644 rust/bindings/hwcore-sys/meson.build
 create mode 100644 rust/bindings/meson.build
 create mode 100644 rust/bindings/migration-sys/Cargo.toml
 create mode 120000 rust/bindings/migration-sys/build.rs
 create mode 100644 rust/bindings/migration-sys/lib.rs
 create mode 100644 rust/bindings/migration-sys/meson.build
 create mode 100644 rust/bindings/qom-sys/Cargo.toml
 create mode 120000 rust/bindings/qom-sys/build.rs
 rename rust/{qom/src/bindings.rs => bindings/qom-sys/lib.rs} (85%)
 create mode 100644 rust/bindings/qom-sys/meson.build
 create mode 100644 rust/bindings/system-sys/Cargo.toml
 create mode 120000 rust/bindings/system-sys/build.rs
 rename rust/{system/src/bindings.rs => bindings/system-sys/lib.rs} (88%)
 create mode 100644 rust/bindings/system-sys/meson.build
 create mode 100644 rust/bindings/util-sys/Cargo.toml
 create mode 120000 rust/bindings/util-sys/build.rs
 rename rust/{util/src/bindings.rs => bindings/util-sys/lib.rs} (88%)
 create mode 100644 rust/bindings/util-sys/meson.build
 delete mode 120000 rust/bql/build.rs
 delete mode 100644 rust/bql/src/bindings.rs
 delete mode 120000 rust/chardev/build.rs
 delete mode 120000 rust/hw/core/build.rs
 delete mode 120000 rust/migration/build.rs
 delete mode 100644 rust/migration/src/bindings.rs
 delete mode 120000 rust/qom/build.rs
 delete mode 120000 rust/system/build.rs
 rename rust/{hw/core => system}/src/sysbus.rs (76%)

-- 
2.52.0


