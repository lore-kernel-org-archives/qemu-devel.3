Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE932CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo2w-0007JV-0Y; Tue, 26 May 2026 05:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2t-0007J5-HF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2q-0006w6-BO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JkkAt38p71b1zbovh5fGA3GId9CXu4rswtv8qbZWC9E=;
 b=ArT1RyOtNy+Q61dNv0U2z3YnqnKUxrYeMq3qg8jXv7eFv07nR+0tbkeZh/aCiLEAtHbUqk
 AuYDKgatYhZ0uiIiiey3jpKv7HiNGPWgUuIEfwt0FyJ6S6tks9j0lzw4GRaKSISje2nydG
 DqGuPe4kiuqaiMgdzOBFNvOYsEhI/4w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-cMxo-JzBN3eh5-igyoaxzw-1; Tue, 26 May 2026 05:25:49 -0400
X-MC-Unique: cMxo-JzBN3eh5-igyoaxzw-1
X-Mimecast-MFC-AGG-ID: cMxo-JzBN3eh5-igyoaxzw_1779787548
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4904ee02e72so26640905e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787548; x=1780392348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JkkAt38p71b1zbovh5fGA3GId9CXu4rswtv8qbZWC9E=;
 b=Scq3pste1FsHg7HLAzcHBg+3PQXO/4Z1CKWcbuqSjDIzWh0aJ7HYy+GCPVdgUApChG
 dW/bQFrmqx06Ml0WP1h7WLACXFmONC4KMM5XxAZ6+qG6/UPMLG5Doqd9B062iV128pjg
 T/r2GUGpt7SE1CZ8SdbduZN0kDtjxO64rKAoZSNNqYmp59PaQXE4Si1z6KiJW+a9hwAP
 03fKbFnOVDEQ96i2mpudCovN48rH2EeCXBwuah9od/TAdJgMiKNrj83I90AIgIP2ZYXW
 S4d93xV8q7FRSMcDLobdXP0aVwMgSWIlNcLVG6I4cXBeeAOLeTCBWQOVRQcnPrVGAiPX
 ZZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787548; x=1780392348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JkkAt38p71b1zbovh5fGA3GId9CXu4rswtv8qbZWC9E=;
 b=QYpo5hH2X+Ynt8FSg1JtbQ4BvhlPrjRRUtr5eNI89ikdz3UkCc1DdeRtBm7u2BIS+6
 mGQc33WzwyVz4ENS1hFUaNsPHOW0+2AJD4B5L7fSAtH7vnEz5QnbZrTQD1ENz1xZPMVn
 Pdg880INT/iMmcl1FJ0CSCk4g28uP/7oYOEdw2YJrcvgmKmYx/4jvJzpi7w1zPWpciV1
 93HjpnQUaXPMGow/K8M3GKm8hd7n3SNdM6yEsfMe1soJUVaRZo+hp34joqDW+MB+WJ7o
 KU71ENmziVqC/pyp2VWUrZ05/940G70jXFouNEHeKqhZbUFdIll958KZsk6eWgupBMF5
 3bUg==
X-Gm-Message-State: AOJu0Yyyl5FdJFYz6bdtD8aoixVREDFW7ms2xJuGl1DMc7YhW5NuJaFh
 DWrQj1y3THI44yqVxXAUf4/5GkU5QBnhM1VIyYZsySnTeTLt9qYRH8dk5QHgv3072higCDH9DX5
 CROYPrZeHFlc3zFD1PEnJ2Ppi/GO74Rinh65v/8pElLFvvPR1osWH6kdWGhgv1H8f65dFo6xoXD
 VFzmVv8LBmjp6mXYjyaxc475i9UdvvSMQzV1BbanES
X-Gm-Gg: Acq92OHS373RBlJezZfVjAnL6+Zk0r3u2TYNCTvgPRtzHUkipqbEih7m4GHQVwqF4HQ
 LvoMJSRs+ASnk1pXvwFcQphSZRSI4CMHIOWnSXt7Bq2srONapkazglx5roL5eqm/ufQeHxRLxsB
 72/nVqckQHxrqKu73lzgq36OkE7xvxHN+BTe2DYxyMl3LmPl0BXMIRqJlyQUK1mA++iua4vwbXR
 wElPCV5KDYrLh1c2pcTZzX6IENlBgpq3lZqUcAZ/j4uVZFrCVbzF7tIEv0GtRWZA2d+pUGErnsB
 87veRM2gjY4fxDlIO3lUk+UbeeTzBWPc7MxfPDQ65VvOttvLIor4lK54sqTX1hAv1Zll9Ecd94b
 9vagH+0CM+YPUy+1FHBFHgOihhy7TOyATfc5CYz54glOOSrnaXipiURj/Gb1lHjOWdXn7SL5MB+
 r34HYo/buckquFZRoqNjuI20vfSTE=
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id
 5b1f17b1804b1-49048df2f57mr269652655e9.26.1779787547805; 
 Tue, 26 May 2026 02:25:47 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id
 5b1f17b1804b1-49048df2f57mr269651825e9.26.1779787547115; 
 Tue, 26 May 2026 02:25:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454cfcaesm305908105e9.4.2026.05.26.02.25.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:25:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH preview 0/6] rust: use meson automatic parsing of Cargo.toml
Date: Tue, 26 May 2026 11:25:39 +0200
Message-ID: <20260526092546.149241-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These are relatively old patches, but it's time to post them now
that the light is visible at the end of the Meson tunnel.

Meson 1.11.x greatly increased the ability to parse Cargo.toml
and automatically build complete targets out of the information in
there---this was more or less always the intention when Manos decided
to build Rust crates with Meson, but it took some time to get there.

It still does not support cross compiling, but that should be added in
1.12.0 and should be completely transparent, so it is already possible
to post patches for the final shape of the Meson rules.

With this change, it is possible to have a much more compact
description of Rust devices in meson.build, compared to what
was used before:

  _libhpet_rs = cargo_ws.package('hpet').library()
  rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
    link_whole: [_libhpet_rs],
    variables: {'crate': 'hpet'},
  )])

For a description of Cargo support in Meson see
https://mesonbuild.com/Rust.html
and https://mesonbuild.com/Rust-module.html#workspace.

Paolo

Paolo Bonzini (6):
  meson: use compiler_target() to get rustc target
  rust: switch to cargo subprojects
  rust: switch to autogenerated meson rules
  rust: remove unnecessary wrap files
  rust: use meson automatic parsing of Cargo.toml
  scripts: remove now dead parts of rustc_args.py

 configure                                     |  3 -
 meson.build                                   | 13 +--
 rust/Cargo.lock => Cargo.lock                 |  0
 rust/Cargo.toml => Cargo.toml                 |  6 +-
 rust/bindings/chardev-sys/meson.build         | 11 +--
 rust/bindings/hwcore-sys/meson.build          | 11 +--
 rust/bindings/migration-sys/meson.build       | 11 +--
 rust/bindings/qom-sys/meson.build             | 11 +--
 rust/bindings/system-sys/meson.build          | 11 +--
 rust/bindings/util-sys/meson.build            | 11 +--
 rust/bits/meson.build                         |  7 +-
 rust/bql/meson.build                          | 13 +--
 rust/chardev/meson.build                      |  8 +-
 rust/common/meson.build                       | 10 +--
 rust/hw/char/pl011/meson.build                | 22 +----
 rust/hw/core/meson.build                      | 10 +--
 rust/hw/timer/hpet/meson.build                | 17 +---
 rust/meson.build                              | 32 +-------
 rust/migration/meson.build                    |  8 +-
 rust/qemu-macros/meson.build                  | 12 +--
 rust/qom/meson.build                          |  8 +-
 rust/system/meson.build                       |  8 +-
 rust/trace/meson.build                        |  9 +--
 rust/util/meson.build                         |  7 +-
 scripts/qapi/rs_types.py                      |  2 +-
 scripts/rust/rustc_args.py                    | 80 +------------------
 subprojects/anyhow-1-rs.wrap                  |  7 --
 subprojects/arbitrary-int-1-rs.wrap           | 10 ---
 subprojects/attrs-0.2-rs.wrap                 |  7 --
 subprojects/bilge-0.2-rs.wrap                 | 10 ---
 subprojects/bilge-impl-0.2-rs.wrap            | 10 ---
 subprojects/either-1-rs.wrap                  | 10 ---
 subprojects/foreign-0.3-rs.wrap               |  7 --
 subprojects/glib-sys-0.21-rs.wrap             |  7 --
 subprojects/itertools-0.11-rs.wrap            | 10 ---
 subprojects/libc-0.2-rs.wrap                  |  7 --
 .../packagefiles/anyhow-1-rs/meson.build      | 33 --------
 .../anyhow-1-rs/meson/meson.build             |  9 +++
 .../arbitrary-int-1-rs/meson.build            | 21 -----
 .../packagefiles/attrs-0.2-rs/meson.build     | 33 --------
 .../packagefiles/bilge-0.2-rs/meson.build     | 31 -------
 .../bilge-impl-0.2-rs/meson.build             | 44 ----------
 .../bilge-impl-0.2-rs/meson/meson.build       |  3 +
 .../packagefiles/either-1-rs/meson.build      | 26 ------
 .../packagefiles/foreign-0.3-rs/meson.build   | 26 ------
 .../packagefiles/glib-sys-0.21-rs/meson.build | 33 --------
 .../itertools-0.11-rs/meson.build             | 32 --------
 .../packagefiles/libc-0.2-rs/meson.build      | 37 ---------
 .../libc-0.2-rs/meson/meson.build             | 16 ++++
 .../proc-macro-error-1-rs/meson.build         | 41 ----------
 .../proc-macro-error-1-rs/meson/meson.build   |  3 +
 .../proc-macro-error-attr-1-rs/meson.build    | 31 -------
 .../meson/meson.build                         |  3 +
 .../packagefiles/proc-macro2-1-rs/meson.build | 35 --------
 .../proc-macro2-1-rs/meson/meson.build        |  6 ++
 .../packagefiles/quote-1-rs/meson.build       | 31 -------
 .../packagefiles/serde-1-rs/meson.build       | 36 ---------
 .../packagefiles/serde_core-1-rs/meson.build  | 25 ------
 .../serde_core-1-rs/private.rs.in             |  6 ++
 .../serde_derive-1-rs/meson.build             | 35 --------
 subprojects/packagefiles/syn-2-rs/meson.build | 43 ----------
 .../unicode-ident-1-rs/meson.build            | 22 -----
 subprojects/probe-0.5-rs.wrap                 |  7 --
 subprojects/proc-macro-error-1-rs.wrap        | 10 ---
 subprojects/proc-macro-error-attr-1-rs.wrap   | 10 ---
 subprojects/proc-macro2-1-rs.wrap             | 10 ---
 subprojects/quote-1-rs.wrap                   | 10 ---
 subprojects/serde-1-rs.wrap                   |  5 +-
 subprojects/serde_core-1-rs.wrap              |  5 +-
 subprojects/serde_derive-1-rs.wrap            |  5 +-
 subprojects/syn-2-rs.wrap                     | 10 ---
 subprojects/unicode-ident-1-rs.wrap           | 10 ---
 72 files changed, 116 insertions(+), 1053 deletions(-)
 rename rust/Cargo.lock => Cargo.lock (100%)
 rename rust/Cargo.toml => Cargo.toml (97%)
 delete mode 100644 subprojects/anyhow-1-rs.wrap
 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
 delete mode 100644 subprojects/attrs-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 delete mode 100644 subprojects/either-1-rs.wrap
 delete mode 100644 subprojects/foreign-0.3-rs.wrap
 delete mode 100644 subprojects/glib-sys-0.21-rs.wrap
 delete mode 100644 subprojects/itertools-0.11-rs.wrap
 delete mode 100644 subprojects/libc-0.2-rs.wrap
 delete mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/attrs-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/either-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
 delete mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build
 delete mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
 delete mode 100644 subprojects/packagefiles/libc-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/libc-0.2-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson/meson.build
 delete mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/serde-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/serde_core-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/serde_core-1-rs/private.rs.in
 delete mode 100644 subprojects/packagefiles/serde_derive-1-rs/meson.build
 delete mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 delete mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build
 delete mode 100644 subprojects/probe-0.5-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
 delete mode 100644 subprojects/proc-macro2-1-rs.wrap
 delete mode 100644 subprojects/quote-1-rs.wrap
 delete mode 100644 subprojects/syn-2-rs.wrap
 delete mode 100644 subprojects/unicode-ident-1-rs.wrap

-- 
2.54.0


