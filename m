Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F13CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OEw-0000nQ-Cn; Wed, 24 Sep 2025 08:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OEt-0000nD-T1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OEp-0005jp-7h
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758715480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S/Tzce3iDVdQ1im0ZywxX1RvtEKxuWFPWWOh186SC8Y=;
 b=N8NV5e2jz6Fd9UjT2tc4psSWbc8DsoOxh3Ig4IqNWF8rYA8GgXmeQAw2jA5kUV2KRrxLhh
 efAifnUJUX4xJbGVw6itcnrhwke3KhG9TquMxbBPizhNWnevyO4u4x1lC5TJ27eOh17Lj1
 WMn2IYRzEfewHzr7escbde77ARQweoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-J0RQG2rnPR-5J7SjKPZGPQ-1; Wed,
 24 Sep 2025 08:04:37 -0400
X-MC-Unique: J0RQG2rnPR-5J7SjKPZGPQ-1
X-Mimecast-MFC-AGG-ID: J0RQG2rnPR-5J7SjKPZGPQ_1758715474
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2423F180028D; Wed, 24 Sep 2025 12:04:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3D4119560B1; Wed, 24 Sep 2025 12:04:29 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PATCH v2 00/27] CI/build-sys fixes to enable Rust more widely
Date: Wed, 24 Sep 2025 16:03:57 +0400
Message-ID: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

This patch series fixes a number of issues with the build system and CI and
enable Rust for many of our jobs, getting us closer to enable Rust by default.

emscripten is difficult to enable, help welcome.

v2:
- add a rust-to-clang-target-test.sh configure script
- drop "RFC: configure: use the same machine as the host triple"
- replace "tests: move mips to debian-legacy-test-cross" with "RFC: build-sys: deprecate mips host"
- start tackling emscripten
- fix mis-placed submodule update
- other minor changes, commit message tweaks, bz links
- add r-b tags

Marc-André Lureau (27):
  build-sys: require -lrt when no shm_open() in std libs
  gitlab-ci: fix 'needs' property type must be array
  scripts/archive-source: speed up downloading subprojects
  scripts/archive-source: silence subprojects downloads
  scripts/archive-source: use a bash array
  configure: fix rust meson configuration
  configure: set the bindgen cross target
  tests/docker/common: print errors to stderr
  tests/docker: use fully qualified image name for emsdk
  tests/docker/common: print meson log on configure failure
  build-sys: cfi_debug and safe_stack are not compatible
  lcitool: update, switch to f41
  lcitool/qemu: include libclang-rt for TSAN
  lcitool/alpine: workaround bindgen issue
  tests/lcitool: add missing rust-std dep
  tests/lcitool: update to debian13
  tests/docker: add ENABLE_RUST environment
  tests/lcitool: enable rust & refresh
  configure: set the meson executable suffix/ext
  tests/freebsd: enable Rust
  meson: rust-bindgen limit allowlist-file to srcdir/include
  RFC: tests/docker: add rust to debian-legacy-test-cross
  WIP: gitlab-ci: enable rust for msys2-64bit
  WIP: cirrus/macos: enable Rust
  RFC: build-sys: deprecate mips host
  build-sys: pass -fvisibility=default for wasm bindgen
  WIP: enable rust for wasm/emscripten

 docs/about/build-platforms.rst                |  2 -
 docs/about/deprecated.rst                     |  9 +--
 configure                                     | 27 +++++++-
 meson.build                                   | 34 +++++++---
 .gitlab-ci.d/buildtest-template.yml           |  2 +-
 .gitlab-ci.d/buildtest.yml                    | 66 +++++++++----------
 .gitlab-ci.d/cirrus.yml                       |  4 +-
 .gitlab-ci.d/crossbuilds.yml                  | 46 ++++++-------
 .gitlab-ci.d/static_checks.yml                |  6 +-
 .gitlab-ci.d/windows.yml                      |  8 ++-
 rust/bql/meson.build                          |  1 +
 rust/chardev/meson.build                      |  1 +
 rust/hw/char/pl011/meson.build                |  1 +
 rust/hw/core/meson.build                      |  1 +
 rust/migration/meson.build                    |  3 +-
 rust/qom/meson.build                          |  1 +
 rust/system/meson.build                       |  1 +
 rust/util/meson.build                         |  1 +
 scripts/archive-source.sh                     | 33 +++++++---
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |  5 +-
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |  5 +-
 scripts/rust-to-clang-target-test.sh          | 43 ++++++++++++
 scripts/rust-to-clang-target.sh               | 62 +++++++++++++++++
 tests/docker/common.rc                        | 11 +++-
 tests/docker/dockerfiles/alpine.docker        |  6 +-
 tests/docker/dockerfiles/centos9.docker       |  4 ++
 .../dockerfiles/debian-amd64-cross.docker     | 18 +++--
 .../dockerfiles/debian-arm64-cross.docker     | 18 +++--
 .../dockerfiles/debian-armhf-cross.docker     | 21 +++---
 .../dockerfiles/debian-i686-cross.docker      | 20 ++++--
 .../debian-legacy-test-cross.docker           |  9 ++-
 .../dockerfiles/debian-mips64el-cross.docker  |  9 ++-
 .../dockerfiles/debian-mipsel-cross.docker    |  9 ++-
 .../dockerfiles/debian-ppc64el-cross.docker   | 18 +++--
 .../dockerfiles/debian-riscv64-cross.docker   | 10 ++-
 .../dockerfiles/debian-s390x-cross.docker     | 18 +++--
 tests/docker/dockerfiles/debian.docker        | 18 +++--
 .../dockerfiles/emsdk-wasm32-cross.docker     | 29 +++++++-
 .../dockerfiles/fedora-rust-nightly.docker    | 18 +++--
 .../dockerfiles/fedora-win64-cross.docker     | 15 +++--
 tests/docker/dockerfiles/fedora.docker        | 18 +++--
 tests/docker/dockerfiles/opensuse-leap.docker |  7 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |  7 +-
 tests/docker/test-wasm                        | 12 ++++
 tests/lcitool/libvirt-ci                      |  2 +-
 tests/lcitool/projects/qemu.yml               |  3 +-
 tests/lcitool/refresh                         | 48 +++++++++-----
 tests/vm/freebsd                              |  4 +-
 48 files changed, 531 insertions(+), 183 deletions(-)
 create mode 100755 scripts/rust-to-clang-target-test.sh
 create mode 100644 scripts/rust-to-clang-target.sh
 create mode 100755 tests/docker/test-wasm

-- 
2.51.0


