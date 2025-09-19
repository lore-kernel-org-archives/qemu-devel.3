Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91927CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbFG-0004n4-Ig; Fri, 19 Sep 2025 09:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbFE-0004ld-Ut
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbF3-0002dA-Lo
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3iWcHC4Jy7QP0nasLlGrpWxSR/JH6Jr0k3xgylX6sEs=;
 b=adgmyNkH0asL/OpI6bWVnfkVdHghBjb2uLzXDFIOAen2kaEWHwyxjkFc780naaYOtZW4Tl
 K/p1kWUTIpo5ISFG0EvCeSEOBojWSOxPgxhzuc2vGA+Q9rCcTDBsfz1UpbQWaprqTOHOxZ
 oElXYTpgsiv6nLei8L9VfuPtF0UL9TY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-izh62RH0PT6rx95m7nFJRg-1; Fri,
 19 Sep 2025 09:33:28 -0400
X-MC-Unique: izh62RH0PT6rx95m7nFJRg-1
X-Mimecast-MFC-AGG-ID: izh62RH0PT6rx95m7nFJRg_1758288806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 119EE1955F2A; Fri, 19 Sep 2025 13:33:26 +0000 (UTC)
Received: from localhost (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FDAD1800452; Fri, 19 Sep 2025 13:33:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 00/24] CI/build-sys fixes to enable Rust more widely
Date: Fri, 19 Sep 2025 17:32:54 +0400
Message-ID: <20250919133320.240145-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

This patch series fixes a number of issues with the build system and CI and
enable Rust for many of our jobs, getting us closer to enable Rust by default.

Marc-André Lureau (24):
  gitlab-ci: fix 'needs' property type must be array
  scripts/archive-source: speed up downloading subprojects
  scripts/archive-source: silence subprojects downloads
  configure: fix rust meson configuration
  configure: set the bindgen cross target
  RFC: configure: use the same machine as the host triple by default
  tests/docker/common: print errors to stderr
  tests/docker: use fully qualified image name for emsdk
  tests/docker/common: print meson log on configure failure
  lcitool: update, switch to f41
  lcitool/qemu: include libclang-rt for TSAN
  lcitool/alpine: workaround bindgen issue
  tests/lcitool: add missing rust-std dep
  tests: move mips to debian-legacy-test-cross
  tests/lcitool: update to debian13
  build-sys: cfi_debug and safe_stack are not compatible
  tests/docker: add ENABLE_RUST environment
  tests/lcitool: enable rust & refresh
  configure: set the meson executable suffix/ext
  tests/freebsd: enable Rust
  meson: rust-bindgen limit allowlist-file to srcdir/include
  WIP: tests/docker: add rust to debian-legacy-test-cross
  WIP: gitlab-ci: enable rust for msys2-64bit
  WIP: cirrus/macos: enable Rust

 configure                                     |  26 ++-
 meson.build                                   |  19 +-
 .gitlab-ci.d/buildtest.yml                    |  70 +++----
 .gitlab-ci.d/cirrus.yml                       |   4 +-
 .gitlab-ci.d/container-cross.yml              |  12 --
 .gitlab-ci.d/crossbuild-template.yml          |   4 +-
 .gitlab-ci.d/crossbuilds.yml                  |  72 ++-----
 .gitlab-ci.d/static_checks.yml                |   6 +-
 .gitlab-ci.d/windows.yml                      |   8 +-
 scripts/archive-source.sh                     |   5 +-
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |   5 +-
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |   5 +-
 tests/docker/Makefile.include                 |   1 -
 tests/docker/common.rc                        |  11 +-
 tests/docker/dockerfiles/alpine.docker        |   6 +-
 tests/docker/dockerfiles/centos9.docker       |   4 +
 .../dockerfiles/debian-all-test-cross.docker  |   8 -
 .../dockerfiles/debian-amd64-cross.docker     |  18 +-
 .../dockerfiles/debian-arm64-cross.docker     |  18 +-
 .../dockerfiles/debian-armhf-cross.docker     |  21 +-
 .../dockerfiles/debian-i686-cross.docker      |  20 +-
 .../debian-legacy-test-cross.docker           |  11 +-
 .../dockerfiles/debian-mips64el-cross.docker  | 180 ------------------
 .../dockerfiles/debian-mipsel-cross.docker    | 180 ------------------
 .../dockerfiles/debian-ppc64el-cross.docker   |  18 +-
 .../dockerfiles/debian-riscv64-cross.docker   |  10 +-
 .../dockerfiles/debian-s390x-cross.docker     |  18 +-
 tests/docker/dockerfiles/debian.docker        |  18 +-
 .../dockerfiles/emsdk-wasm32-cross.docker     |   2 +-
 .../dockerfiles/fedora-rust-nightly.docker    |  18 +-
 .../dockerfiles/fedora-win64-cross.docker     |  15 +-
 tests/docker/dockerfiles/fedora.docker        |  18 +-
 tests/docker/dockerfiles/opensuse-leap.docker |   7 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |   7 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   3 +-
 tests/lcitool/refresh                         |  56 +++---
 tests/vm/freebsd                              |   4 +-
 38 files changed, 320 insertions(+), 590 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

-- 
2.51.0


