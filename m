Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B0BCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Zgl-0005jw-B9; Tue, 30 Sep 2025 08:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3Zgk-0005iy-1v
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:42:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3ZgY-0001Jr-NP
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:42:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so4928373f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759236141; x=1759840941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5D9Jn6L1grQE83K2A+0hDVtEfN8YBwR9togP5K5ulA8=;
 b=uyLo2+zovyfEBxfMKWLT8istmXs3sqi/tdjt9sOtrVd2FAe1lBEr/Q7V+4+w0ly0iv
 9m1aPxRa6iye9ALJmvX3juSY4FtLslbc/bP2kgYZIsh8HCkkhzB+lgF2GWYzrhKDEVVm
 z13PjVVFzBoaV64dR6Y49bBbwWct9j7fe8drapmm9DcY2Rv4ZVJwSYtZygY+JvSqaGia
 ERVCwrRnkSbx0FTQYX7KX9V9QDzzjmhpM0nbqmXodRIe3suT65WFH8t+O0ncNTDI0RRZ
 q6JR0bqfZJ8pMg0ApiF33VN69dd6NzHEcWORpnPoQkBBC6J5cwGDXWv4jgh5xcT9JBcB
 jdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759236141; x=1759840941;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5D9Jn6L1grQE83K2A+0hDVtEfN8YBwR9togP5K5ulA8=;
 b=O5tiQh2poJJsQIphrV5xIw8zwLeTfWCqnbyidVOi285vo4jgVtNCkweIfOmWdhvcXr
 xToY564UX5nVFCTb9ZafgdDspWXCtMAkQcXpbvS60aHr6IFkORtMjKi9EhkjaGELxUZu
 tFB4FDBstFXS7F8k6TokS2n+EJ2RYOAYnqpfkmkKNWuYPRlTYlJlOFQhHITNON9tPx62
 nBHCEdN9eIwaNqEbDOqijSFjJKsZN1DNbpiEaku7shjQ3nRxlqoRvgJB6Gmo0F8YB5ni
 VbYd0474QaFbsfuMsbAnd7CJC44nceYt+wUw/idc8p8BQQEObpu9p6mNcq4mLB4eTwhA
 Os5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWvfxWFbTL5+8UIvGAd1I77tUzkVlcN0Q6gNRdEYIEFcXcTkB7jDfLJuQTAjY5mmreLOzhmc3YqNOY@nongnu.org
X-Gm-Message-State: AOJu0YyxCN0qGgpgAducf59Msr4yeOBKw6ZqVZIPgPStiHCUbI7QAzZX
 Vy3EfVT2lV72A0UApBLTaPFe39mCkzqDipjGLggPyYY7OWaXdePllJa0QzjZO23yO+4=
X-Gm-Gg: ASbGncvmJRHxSD6Ce0Hzn8fNxn6sanTgmud+kXxt4R0HSck7qjWXuJi5vQmpfueng5c
 0iX42LA6xzGW9zDeZQvF+BiUD5xcStlbrF/ndaLo4viYvLanUFDtnqwmW5ZLhtfcXZZ0dTAcp/f
 OkhamAwiuTly/aptV1tvn23wYqxpCdDmKdroAZE/mmXX2pv7CceQxkZI4PSJVHqvtBUZYw/zXoz
 0OQen6xZISbLbbDw/7Gp2fMfAMJYxfnpFadPyLXts3T054TU9Ro0zRe5ND3d8npFJJoxVrjDLT9
 kJa27G3BABq0HcttPu02vJzD0yhYpvGAIwfwqmG28qFlEdRMBmXjuhu0zQ2XdvlGwcGXI609z6K
 0QZLB7n67ChMX5VjN+InL2cnixkxRrppDTHQFopnKGh0MK5M=
X-Google-Smtp-Source: AGHT+IFHcN4ezLbEkK5407oHpU24l8zam7ye53Km4dDRhBn9Yd9IqiwC8wx2wjt69FWL/0BbOSY6lg==
X-Received: by 2002:a5d:5888:0:b0:3ea:e0fd:28ea with SMTP id
 ffacd0b85a97d-40e4bb2f5b7mr19471800f8f.39.1759236140954; 
 Tue, 30 Sep 2025 05:42:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9c32734sm23029452f8f.25.2025.09.30.05.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 05:42:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 746975F847;
 Tue, 30 Sep 2025 13:42:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  "Henderson, Richard"
 <richard.henderson@linaro.org>,  qemu-devel@nongnu.org,  Kyle Evans
 <kevans@freebsd.org>,  Yonggang Luo <luoyonggang@gmail.com>,  Li-Wen Hsu
 <lwhsu@freebsd.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Warner Losh <imp@bsdimp.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>,  devel@lists.libvirt.org,
 qemu-rust@nongnu.org,  Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH v2 00/27] CI/build-sys fixes to enable Rust more widely
In-Reply-To: <CAMxuvawY5PSwM0VNmbCmP7Z2t68D=z77W94Ab0SJfrm5_bRwKg@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 30 Sep 2025
 16:05:02 +0400")
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <87y0pzg6gt.fsf@draig.linaro.org>
 <CAMxuvawY5PSwM0VNmbCmP7Z2t68D=z77W94Ab0SJfrm5_bRwKg@mail.gmail.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 30 Sep 2025 13:42:19 +0100
Message-ID: <871pnojems.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> On Sat, Sep 27, 2025 at 9:18=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  marcandre.lureau@redhat.com writes:
>
>  > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  >
>  > Hi,
>  >
>  > This patch series fixes a number of issues with the build system and C=
I and
>  > enable Rust for many of our jobs, getting us closer to enable Rust by =
default.
>  >
>  > emscripten is difficult to enable, help welcome.
>
>  Also I think:
>
>    https://gitlab.com/stsquad/qemu/-/pipelines/2065603411
>
> Current ack/r-b series pass: https://gitlab.com/marcandre.lureau/qemu/-/p=
ipelines/2071701923
>
> I  guess I should end a PR.
>
>  And the:
>    debian-armhf-cross=20=20
>
>  debian-mipsel-cross
>    debian-mips64el-cross
>
>    debian-ppc64el-cross
>    debian-riscv64-cross
>
>  cross builds fail.=20
>
> Fixed with the --rust-target-triple patch sent earlier
>=20=20
>    debian-i686-cross
>
> This one fails with:
>  ../src/meson.build:3394:4: ERROR: Problem encountered: No accelerator
> available for target x86_64-softmmu

Ahh - because TCG on 32 bit no longer allows 64 bit guests we cannot
find an accelerator. I'll fix that up in my current testing/next series
by updating DEF_TARGETS

>
> Paolo, any idea?
>
>  >
>  > v2:
>  > - add a rust-to-clang-target-test.sh configure script
>  > - drop "RFC: configure: use the same machine as the host triple"
>  > - replace "tests: move mips to debian-legacy-test-cross" with "RFC: bu=
ild-sys: deprecate mips host"
>  > - start tackling emscripten
>  > - fix mis-placed submodule update
>  > - other minor changes, commit message tweaks, bz links
>  > - add r-b tags
>  >
>  > Marc-Andr=C3=A9 Lureau (27):
>  >   build-sys: require -lrt when no shm_open() in std libs
>  >   gitlab-ci: fix 'needs' property type must be array
>  >   scripts/archive-source: speed up downloading subprojects
>  >   scripts/archive-source: silence subprojects downloads
>  >   scripts/archive-source: use a bash array
>  >   configure: fix rust meson configuration
>  >   configure: set the bindgen cross target
>  >   tests/docker/common: print errors to stderr
>  >   tests/docker: use fully qualified image name for emsdk
>  >   tests/docker/common: print meson log on configure failure
>  >   build-sys: cfi_debug and safe_stack are not compatible
>  >   lcitool: update, switch to f41
>  >   lcitool/qemu: include libclang-rt for TSAN
>  >   lcitool/alpine: workaround bindgen issue
>  >   tests/lcitool: add missing rust-std dep
>  >   tests/lcitool: update to debian13
>  >   tests/docker: add ENABLE_RUST environment
>  >   tests/lcitool: enable rust & refresh
>  >   configure: set the meson executable suffix/ext
>  >   tests/freebsd: enable Rust
>  >   meson: rust-bindgen limit allowlist-file to srcdir/include
>  >   RFC: tests/docker: add rust to debian-legacy-test-cross
>  >   WIP: gitlab-ci: enable rust for msys2-64bit
>  >   WIP: cirrus/macos: enable Rust
>  >   RFC: build-sys: deprecate mips host
>  >   build-sys: pass -fvisibility=3Ddefault for wasm bindgen
>  >   WIP: enable rust for wasm/emscripten
>  >
>  >  docs/about/build-platforms.rst                |  2 -
>  >  docs/about/deprecated.rst                     |  9 +--
>  >  configure                                     | 27 +++++++-
>  >  meson.build                                   | 34 +++++++---
>  >  .gitlab-ci.d/buildtest-template.yml           |  2 +-
>  >  .gitlab-ci.d/buildtest.yml                    | 66 +++++++++----------
>  >  .gitlab-ci.d/cirrus.yml                       |  4 +-
>  >  .gitlab-ci.d/crossbuilds.yml                  | 46 ++++++-------
>  >  .gitlab-ci.d/static_checks.yml                |  6 +-
>  >  .gitlab-ci.d/windows.yml                      |  8 ++-
>  >  rust/bql/meson.build                          |  1 +
>  >  rust/chardev/meson.build                      |  1 +
>  >  rust/hw/char/pl011/meson.build                |  1 +
>  >  rust/hw/core/meson.build                      |  1 +
>  >  rust/migration/meson.build                    |  3 +-
>  >  rust/qom/meson.build                          |  1 +
>  >  rust/system/meson.build                       |  1 +
>  >  rust/util/meson.build                         |  1 +
>  >  scripts/archive-source.sh                     | 33 +++++++---
>  >  .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |  5 +-
>  >  .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |  5 +-
>  >  scripts/rust-to-clang-target-test.sh          | 43 ++++++++++++
>  >  scripts/rust-to-clang-target.sh               | 62 +++++++++++++++++
>  >  tests/docker/common.rc                        | 11 +++-
>  >  tests/docker/dockerfiles/alpine.docker        |  6 +-
>  >  tests/docker/dockerfiles/centos9.docker       |  4 ++
>  >  .../dockerfiles/debian-amd64-cross.docker     | 18 +++--
>  >  .../dockerfiles/debian-arm64-cross.docker     | 18 +++--
>  >  .../dockerfiles/debian-armhf-cross.docker     | 21 +++---
>  >  .../dockerfiles/debian-i686-cross.docker      | 20 ++++--
>  >  .../debian-legacy-test-cross.docker           |  9 ++-
>  >  .../dockerfiles/debian-mips64el-cross.docker  |  9 ++-
>  >  .../dockerfiles/debian-mipsel-cross.docker    |  9 ++-
>  >  .../dockerfiles/debian-ppc64el-cross.docker   | 18 +++--
>  >  .../dockerfiles/debian-riscv64-cross.docker   | 10 ++-
>  >  .../dockerfiles/debian-s390x-cross.docker     | 18 +++--
>  >  tests/docker/dockerfiles/debian.docker        | 18 +++--
>  >  .../dockerfiles/emsdk-wasm32-cross.docker     | 29 +++++++-
>  >  .../dockerfiles/fedora-rust-nightly.docker    | 18 +++--
>  >  .../dockerfiles/fedora-win64-cross.docker     | 15 +++--
>  >  tests/docker/dockerfiles/fedora.docker        | 18 +++--
>  >  tests/docker/dockerfiles/opensuse-leap.docker |  7 +-
>  >  tests/docker/dockerfiles/ubuntu2204.docker    |  7 +-
>  >  tests/docker/test-wasm                        | 12 ++++
>  >  tests/lcitool/libvirt-ci                      |  2 +-
>  >  tests/lcitool/projects/qemu.yml               |  3 +-
>  >  tests/lcitool/refresh                         | 48 +++++++++-----
>  >  tests/vm/freebsd                              |  4 +-
>  >  48 files changed, 531 insertions(+), 183 deletions(-)
>  >  create mode 100755 scripts/rust-to-clang-target-test.sh
>  >  create mode 100644 scripts/rust-to-clang-target.sh
>  >  create mode 100755 tests/docker/test-wasm
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

