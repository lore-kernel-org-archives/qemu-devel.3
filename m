Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5B5D149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mll-0001L6-LT; Fri, 25 Oct 2024 12:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mld-0000sn-GR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MlZ-0004kN-FA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EDSZQVWiueQzVaAJezy9gB9XbqbQU8PUMBbuaCygoPE=;
 b=HYlDRgWaxptGc7S4uvdTE72SY1alNlr1A0eZ0GaNeAOjBUyWdWPcm2E3tq47j7A0AZqPhj
 Xk/qoc7Kf6pGqPDeUrMgHiLPj1r/E05xSDaz6qgKcV+grGC1uCR90saspPORrAKOZR3wbM
 E+kW9gHu7XQJMXNTxru2UA/KljDUDy4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-jXDDzOsbPim817u8eyldAA-1; Fri, 25 Oct 2024 12:02:17 -0400
X-MC-Unique: jXDDzOsbPim817u8eyldAA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9a1b872d8bso150069766b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872136; x=1730476936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EDSZQVWiueQzVaAJezy9gB9XbqbQU8PUMBbuaCygoPE=;
 b=DGr5Hrpv0BIrOU7b4mn2yesmLcYbs/vkTLfLj8Srnp29XQFwuXUMr3r4cLVY8ZUP0Q
 HhUXukSxRFRUtfIH0vqm/gUJcf1enrFGqOJ6FbeQfdVBxx/wKqBIEno6PLD05ON0KVc0
 Mpt17AvE2+IOZoFX9w7CGZ6MPxfpzQpmTnkKwnxeHkslE35ecFSxdb25r2VE3xFq7Ie/
 ZRlN54tFW8ptQMYivI5Pb7mxpRh7/GqlkvVOCJYR/GRWDx3KRxu8iNSEsS9n8F/9MJeI
 4uGROgTqhEliNCB+4SZHyYQ+PBckqhp7bAJkCHESwlRPTnrYTQkba1PeyZooIs7EcTVT
 Arcg==
X-Gm-Message-State: AOJu0Ywgn4sBtNXAEw2OwBtdvlUKaYMW97aic6og4ix/u1BZ2TO6kNyO
 GZd1ky7P+PzRhudNz/LezVT1BmonRAbUpmNZKT8vM9nYDwNeh/We73fR9/iB4YtPG8yTRC3yqtS
 izBOrujVGyohliiZ66iECKAW9xTYuMxbse3w3HII2pBEpcg9/7PMRVZNasWudQCsfcXsrUnyPeP
 +r3v0x72MkBSi9pOlRw1gjHvoZrI1sOB6QoAg6524=
X-Received: by 2002:a17:907:7e98:b0:a99:f0d0:4ce3 with SMTP id
 a640c23a62f3a-a9abf890d76mr918043766b.17.1729872135507; 
 Fri, 25 Oct 2024 09:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/r+D9Kjzs6BOWQ5SYoEjloI0uoDwH3ja3DfI3QmwfP/xD1eVqbYBBObFbqovZBdraZmQmgg==
X-Received: by 2002:a17:907:7e98:b0:a99:f0d0:4ce3 with SMTP id
 a640c23a62f3a-a9abf890d76mr918034566b.17.1729872134643; 
 Fri, 25 Oct 2024 09:02:14 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b3a086c1esm84728466b.213.2024.10.25.09.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc and
 bindgen
Date: Fri, 25 Oct 2024 18:01:45 +0200
Message-ID: <20241025160209.194307-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since Manos helpfully posted his vmstate patches, this series is all that
is needed in order to enable Rust for at least the Debian, Fedora and
Ubuntu jobs.  I took his patches and isolated them from the procedural
macro experiment.

There are quite a few changes from the previous posting:

- new patches to bring pl011 mostly up to date with the C code (1-7)

- remove unnecessary .gitattributes file (8)

- apply rustfmt throughout

- add "rust: create a cargo workspace" to ensure a single version of the
  dependencies is used for all cargo commands (14, based on a suggestion by
  Junjie)

- add Junjie's syntax checks to the offset_of! macro.  I added a small
  struct with a From<> implementation, to make compile errors even easier
  to report (15).

- add final patch to enable rust in the Debian and Ubuntu system build
  jobs (23)

Note that this requires "meson subprojects update --reset" in order to do
an incremental build if you have already downloaded the Rust subprojects.
While I have a solution for that (modeled after scripts/git-submodule.sh),
I first need to check with the Meson folks whether my script is using only
stable interfaces.

This series can be found at branch rust-next of my git repository
(https://gitlab.com/bonzini/qemu.git), which also helps with the
problems in applying patch 8.  Everything up to commit f6a46d2a4eb
("rust: do not use TYPE_CHARDEV unnecessarily", 2024-10-25) will be
my next pull request, which I will send early next week (to give
people some more days to complain).

Paolo

Supersedes: <20241022100956.196657-1-pbonzini@redhat.com>

CI: https://gitlab.com/bonzini/qemu/-/pipelines/1512732399


Manos Pitsidianakis (6):
  rust: add definitions for vmstate
  rust/pl011: add support for migration
  rust/pl011: move CLK_NAME static to function scope
  rust/pl011: add TYPE_PL011_LUMINARY device
  rust/pl011: remove commented out C code
  rust/pl011: Use correct masks for IBRD and FBRD

Paolo Bonzini (17):
  rust/pl011: fix default value for migrate-clock
  rust: patch bilge-impl to allow compilation with 1.63.0
  rust: fix cfgs of proc-macro2 for 1.63.0
  rust: use std::os::raw instead of core::ffi
  rust: introduce a c_str macro
  rust: silence unknown warnings for the sake of old compilers
  rust: synchronize dependencies between subprojects and Cargo.lock
  rust: create a cargo workspace
  rust: introduce alternative implementation of offset_of!
  rust: do not use MaybeUninit::zeroed()
  rust: clean up detection of the language
  rust: allow version 1.63.0 of rustc
  rust: do not use --generate-cstr
  rust: allow older version of bindgen
  rust: make rustfmt optional
  dockerfiles: install bindgen from cargo on Ubuntu 22.04
  ci: enable rust in the Debian and Ubuntu system build job

 docs/about/build-platforms.rst                |  12 +
 meson.build                                   | 102 +++--
 .gitattributes                                |   2 +
 .gitlab-ci.d/buildtest.yml                    |   6 +-
 meson_options.txt                             |   2 +
 rust/{hw/char/pl011 =3D> }/Cargo.lock           |   4 +
 rust/Cargo.toml                               |   7 +
 rust/hw/char/pl011/Cargo.toml                 |   3 -
 rust/hw/char/pl011/src/device.rs              | 158 ++++++--
 rust/hw/char/pl011/src/device_class.rs        |  71 +++-
 rust/hw/char/pl011/src/lib.rs                 |   5 +-
 rust/hw/char/pl011/src/memory_ops.rs          |  14 +-
 rust/qemu-api-macros/Cargo.lock               |  47 ---
 rust/qemu-api-macros/Cargo.toml               |   5 +-
 rust/qemu-api-macros/src/lib.rs               |  81 +++-
 rust/qemu-api/Cargo.lock                      |   7 -
 rust/qemu-api/Cargo.toml                      |  10 +-
 rust/qemu-api/build.rs                        |   9 +
 rust/qemu-api/meson.build                     |  17 +-
 rust/qemu-api/src/c_str.rs                    |  53 +++
 rust/qemu-api/src/definitions.rs              |   2 +-
 rust/qemu-api/src/device_class.rs             |  43 +--
 rust/qemu-api/src/lib.rs                      |  19 +-
 rust/qemu-api/src/offset_of.rs                | 161 ++++++++
 rust/qemu-api/src/vmstate.rs                  | 358 ++++++++++++++++++
 rust/qemu-api/src/zeroable.rs                 |  91 ++++-
 rust/qemu-api/tests/tests.rs                  |  29 +-
 scripts/meson-buildoptions.sh                 |   4 +
 subprojects/bilge-impl-0.2-rs.wrap            |   1 +
 .../packagefiles/bilge-impl-1.63.0.patch      |  45 +++
 .../packagefiles/proc-macro2-1-rs/meson.build |   4 +-
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 tests/docker/dockerfiles/ubuntu2204.docker    |   5 +
 tests/lcitool/mappings.yml                    |   4 +
 tests/lcitool/refresh                         |  11 +-
 35 files changed, 1166 insertions(+), 227 deletions(-)
 rename rust/{hw/char/pl011 =3D> }/Cargo.lock (98%)
 create mode 100644 rust/Cargo.toml
 delete mode 100644 rust/qemu-api-macros/Cargo.lock
 delete mode 100644 rust/qemu-api/Cargo.lock
 create mode 100644 rust/qemu-api/src/c_str.rs
 create mode 100644 rust/qemu-api/src/offset_of.rs
 create mode 100644 rust/qemu-api/src/vmstate.rs
 create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

--=20
2.47.0


