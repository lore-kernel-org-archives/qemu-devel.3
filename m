Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA2EC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 11:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4I1a-0003Tn-BX; Mon, 14 Apr 2025 07:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1U-0003Sp-AB
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4I1S-0003t9-AI
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 07:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744630240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yelokmZUq1qVyOQP97cDJAyorD63q5IYdqP/efcxbo8=;
 b=KE0qX1kMSEwt8/pujHS3GmrEly/Vhhv70EnDfYeEvIwkebQxnr+NZCHFogrIP1QxyN+OOH
 Ifg9r6BdbuWKl5KpD4QHsjBAILsiKgP3tYmOwv0KYG+0UQqOrmkGX2t79WJRmokD4yfqqZ
 2Z1FWtf+K5g+UtEMrzjMRxv9l9MNNpY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-gALvKLVNMp-wI2l-WuCS3A-1; Mon,
 14 Apr 2025 07:30:36 -0400
X-MC-Unique: gALvKLVNMp-wI2l-WuCS3A-1
X-Mimecast-MFC-AGG-ID: gALvKLVNMp-wI2l-WuCS3A_1744630235
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 382491800262; Mon, 14 Apr 2025 11:30:34 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13ECA1956094; Mon, 14 Apr 2025 11:30:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH v2 00/15] Convert remaining Avocado tests to functional
Date: Mon, 14 Apr 2025 13:30:14 +0200
Message-ID: <20250414113031.151105-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v2:
- Use separate gitlab issue tickets for the flaky reverse-debugging tests
- Mark the aarch64 reverse debugging test as flaky, too
- Rename QEMU_CI_FUNCTIONAL_TESTING to QEMU_CI_FUNCTIONAL

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
 .../functional/test_aarch64_reverse_debug.py  |  38 ++
 tests/functional/test_aarch64_smmu.py         | 205 ++++++
 tests/functional/test_i386_replay.py          |  28 +
 tests/functional/test_mips64_malta.py         |  35 ++
 tests/functional/test_mips64el_malta.py       |  22 +
 tests/functional/test_mips_malta.py           | 108 +++-
 tests/functional/test_mipsel_malta.py         |  22 +
 tests/functional/test_ppc64_reverse_debug.py  |  41 ++
 tests/functional/test_x86_64_replay.py        |  43 +-
 tests/functional/test_x86_64_reverse_debug.py |  36 ++
 38 files changed, 673 insertions(+), 2437 deletions(-)
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


