Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B339DC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 20:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txASI-0000TR-Vm; Tue, 25 Mar 2025 16:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txAS7-0000SO-9M
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txAS4-0002eX-Fz
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 16:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742932841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wePh+XGY4nIcrQ3n32GBNPf4gG+G3rcoUJ3QV0zpO+s=;
 b=V+dun9peGZcbDPuklOePhN9WgCGS/Zj7IWrWd5iB1XXm/ixEjU+7LsGnpPN8cQXJUvLKJb
 e8csJe5fetl84wotwRjc4JTS0kxWvmLMmmuf9p0q4MyPJiF3xr7ZxtThCHLnOKhKqTUs7/
 rPo2Mam91nmLF1SPzONtKzPBXuzrN48=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-9Sxw3RTjMXq-_jDHQyj4xw-1; Tue,
 25 Mar 2025 16:00:36 -0400
X-MC-Unique: 9Sxw3RTjMXq-_jDHQyj4xw-1
X-Mimecast-MFC-AGG-ID: 9Sxw3RTjMXq-_jDHQyj4xw_1742932835
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB28C1801A1A; Tue, 25 Mar 2025 20:00:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.142])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3E951801747; Tue, 25 Mar 2025 20:00:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for-10.1 00/15] Convert remaining Avocado tests to functional
Date: Tue, 25 Mar 2025 21:00:08 +0100
Message-ID: <20250325200026.344006-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These patches convert the remaining Avocado tests bit by bit to the
functional framework, or replace them with a test that has similar
test coverage. This way we are finally able to get rid of the
test/avocado folder in the end, everything is then integrated with
the meson test runner. It should be possible now to run almost all
tests in parallel by doing something like:

 make -j$(nproc) check SPEED=thorough


Thomas Huth (15):
  gitlab-ci: Remove the avocado tests from the CI pipelines
  tests/functional: Move the check for the parameters from avocado to
    functional
  tests/functional: Convert reverse_debugging tests to the functional
    framework
  tests/functional: Convert the i386 replay avocado test
  tests/avocado: Remove the LinuxKernelTest class
  tests/functional: Convert the 32-bit big endian Wheezy mips test
  tests/functional: Convert the 32-bit little endian Wheezy mips test
  tests/functional: Convert the 64-bit little endian Wheezy mips test
  tests/functional: Convert the 64-bit big endian Wheezy mips test
  tests/avocado: Remove the boot_linux.py tests
  tests/functional: Use the tuxrun kernel for the x86 replay test
  tests/functional: Use the tuxrun kernel for the aarch64 replay test
  tests/functional: Convert the SMMU test to the functional framework
  gitlab-ci: Update QEMU_JOB_AVOCADO and QEMU_CI_AVOCADO_TESTING
  Remove the remainders of the Avocado tests

 MAINTAINERS                                   |  15 +-
 docs/about/build-platforms.rst                |  10 +-
 docs/devel/build-system.rst                   |  11 +-
 docs/devel/codebase.rst                       |   5 -
 docs/devel/testing/avocado.rst                | 581 ------------------
 docs/devel/testing/ci-jobs.rst.inc            |  19 +-
 docs/devel/testing/functional.rst             |   3 -
 docs/devel/testing/index.rst                  |   1 -
 docs/devel/testing/main.rst                   |  15 -
 tests/avocado/README.rst                      |  10 -
 configure                                     |   2 +-
 .gitlab-ci.d/base.yml                         |   8 +-
 .gitlab-ci.d/buildtest-template.yml           |  13 +-
 .gitlab-ci.d/buildtest.yml                    |  33 +-
 pythondeps.toml                               |   8 +-
 tests/Makefile.include                        |  60 +-
 tests/avocado/avocado_qemu/__init__.py        | 424 -------------
 tests/avocado/avocado_qemu/linuxtest.py       | 253 --------
 tests/avocado/boot_linux.py                   | 132 ----
 tests/avocado/boot_linux_console.py           |  96 ---
 tests/avocado/linux_ssh_mips_malta.py         | 205 ------
 tests/avocado/replay_kernel.py                | 110 ----
 tests/avocado/replay_linux.py                 | 206 -------
 tests/avocado/smmu.py                         | 139 -----
 tests/functional/meson.build                  |  13 +-
 tests/functional/qemu_test/tuxruntest.py      |   9 +-
 .../reverse_debugging.py                      | 114 +---
 tests/functional/test_aarch64_replay.py       |  37 +-
 .../functional/test_aarch64_reverse_debug.py  |  37 ++
 tests/functional/test_aarch64_smmu.py         | 205 ++++++
 tests/functional/test_i386_replay.py          |  28 +
 tests/functional/test_mips64_malta.py         |  35 ++
 tests/functional/test_mips64el_malta.py       |  22 +
 tests/functional/test_mips_malta.py           | 108 +++-
 tests/functional/test_mipsel_malta.py         |  22 +
 tests/functional/test_ppc64_reverse_debug.py  |  41 ++
 tests/functional/test_x86_64_replay.py        |  43 +-
 tests/functional/test_x86_64_reverse_debug.py |  36 ++
 38 files changed, 672 insertions(+), 2437 deletions(-)
 delete mode 100644 docs/devel/testing/avocado.rst
 delete mode 100644 tests/avocado/README.rst
 delete mode 100644 tests/avocado/avocado_qemu/__init__.py
 delete mode 100644 tests/avocado/avocado_qemu/linuxtest.py
 delete mode 100644 tests/avocado/boot_linux.py
 delete mode 100644 tests/avocado/boot_linux_console.py
 delete mode 100644 tests/avocado/linux_ssh_mips_malta.py
 delete mode 100644 tests/avocado/replay_kernel.py
 delete mode 100644 tests/avocado/replay_linux.py
 delete mode 100644 tests/avocado/smmu.py
 rename tests/{avocado => functional}/reverse_debugging.py (66%)
 create mode 100755 tests/functional/test_aarch64_reverse_debug.py
 create mode 100755 tests/functional/test_aarch64_smmu.py
 create mode 100755 tests/functional/test_i386_replay.py
 create mode 100755 tests/functional/test_mips64_malta.py
 create mode 100755 tests/functional/test_ppc64_reverse_debug.py
 create mode 100755 tests/functional/test_x86_64_reverse_debug.py

-- 
2.49.0


