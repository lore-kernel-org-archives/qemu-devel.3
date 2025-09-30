Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7E4CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cQe-00083W-Hm; Tue, 30 Sep 2025 11:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cQc-000837-2v
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cQV-00046H-1X
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TqJY5vKuHYUM7fM1CWg648HsgEJdaABDWRIdG4d57L8=;
 b=YUV82eYOr22E+rP2WMTn3IYzmEbGoZvArsjgluFn1o9ac3In3b4vi3HBsurYCi1F3Xqw9U
 hlXOad5skos4gy/84x/dSVpii2A3+ZId96sCeZHF1Db/7YeF5wnjkr34O66+PdAG8ym3pT
 Y1YhNYWljyhrEPqGZwvHFRvEQoqH46o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-ZNAY5GEPNR2-EIe-x5xTYg-1; Tue,
 30 Sep 2025 11:37:54 -0400
X-MC-Unique: ZNAY5GEPNR2-EIe-x5xTYg-1
X-Mimecast-MFC-AGG-ID: ZNAY5GEPNR2-EIe-x5xTYg_1759246672
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC4D0195608E; Tue, 30 Sep 2025 15:37:51 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3250C180057A; Tue, 30 Sep 2025 15:37:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 00/23] Rust ci patches
Date: Tue, 30 Sep 2025 19:37:21 +0400
Message-ID: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 85a3fd1c4cb3ba7a9eb291c1e222f935e922d1f7:

  Merge tag 'pull-aspeed-20250929' of https://github.com/legoater/qemu into staging (2025-09-29 10:52:48 -0700)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/rust-ci-pull-request

for you to fetch changes up to 582a39beea414c092dbd8c178f3eff3a718eee77:

  build-sys: pass -fvisibility=default for wasm bindgen (2025-09-30 19:33:25 +0400)

----------------------------------------------------------------
CI/build-sys fixes for Rust

Collect CI/build-sys patches related to Rust.

----------------------------------------------------------------

Marc-André Lureau (23):
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
  build-sys: deprecate mips host
  build-sys: pass -fvisibility=default for wasm bindgen

 docs/about/build-platforms.rst                |   2 -
 docs/about/deprecated.rst                     |   9 +-
 configure                                     |  23 +++-
 meson.build                                   |  34 +++--
 .gitlab-ci.d/buildtest.yml                    |  62 +++++-----
 .gitlab-ci.d/cirrus.yml                       |   2 +-
 .gitlab-ci.d/crossbuilds.yml                  |  46 +++----
 .gitlab-ci.d/static_checks.yml                |   6 +-
 rust/bql/meson.build                          |   1 +
 rust/chardev/meson.build                      |   1 +
 rust/hw/char/pl011/meson.build                |   1 +
 rust/hw/core/meson.build                      |   1 +
 rust/migration/meson.build                    |   3 +-
 rust/qom/meson.build                          |   1 +
 rust/system/meson.build                       |   1 +
 rust/util/meson.build                         |   1 +
 scripts/archive-source.sh                     |  34 +++--
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |   5 +-
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |   5 +-
 scripts/rust-to-clang-target-test.sh          |  43 +++++++
 scripts/rust-to-clang-target.sh               |  60 +++++++++
 tests/docker/common.rc                        |  13 +-
 tests/docker/dockerfiles/alpine.docker        |   6 +-
 tests/docker/dockerfiles/centos9.docker       |   4 +
 .../dockerfiles/debian-amd64-cross.docker     |  18 ++-
 .../dockerfiles/debian-arm64-cross.docker     |  18 ++-
 .../dockerfiles/debian-armhf-cross.docker     |  21 ++--
 .../dockerfiles/debian-i686-cross.docker      |  20 +--
 .../dockerfiles/debian-mips64el-cross.docker  |   9 +-
 .../dockerfiles/debian-mipsel-cross.docker    |   9 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |  18 ++-
 .../dockerfiles/debian-riscv64-cross.docker   | 116 +++++++++++++++++-
 .../dockerfiles/debian-s390x-cross.docker     |  18 ++-
 tests/docker/dockerfiles/debian.docker        |  18 ++-
 .../dockerfiles/emsdk-wasm32-cross.docker     |   2 +-
 .../dockerfiles/fedora-rust-nightly.docker    |  18 ++-
 .../dockerfiles/fedora-win64-cross.docker     |  15 ++-
 tests/docker/dockerfiles/fedora.docker        |  18 ++-
 tests/docker/dockerfiles/opensuse-leap.docker |   7 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |   7 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   3 +-
 tests/lcitool/refresh                         |  49 +++++---
 tests/vm/freebsd                              |   4 +-
 44 files changed, 574 insertions(+), 180 deletions(-)
 create mode 100755 scripts/rust-to-clang-target-test.sh
 create mode 100644 scripts/rust-to-clang-target.sh

-- 
2.51.0


