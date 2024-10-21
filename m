Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD58D15DB8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v0q-0003xu-Pp; Mon, 21 Oct 2024 12:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v0o-0003xa-W5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v0m-0003B2-Jz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kbgV7uE9mFuNBWjwZy1tMkJmpoWC19AihPuOmM7yyn4=;
 b=EMMWu3e+Hbo3t6wr5lm6SiTPQjoHuEUEsbdw/G+sM4YyHFcgo9MpB1RFEXwvlBkP6VbOW1
 qWSzUALWTFdljkUKPEQpKlGxDkfdvb9r9ywwyr8ZxX83h3bBhVdfg7Bp2Gt1IgJzP/V+5t
 /mXo89nkav/Pc6QtKqKTfQ0gTRhcjKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-x8ygbiSwPW2B69vlS8RNjQ-1; Mon,
 21 Oct 2024 12:12:00 -0400
X-MC-Unique: x8ygbiSwPW2B69vlS8RNjQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E5961944F03; Mon, 21 Oct 2024 16:11:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1902B1956088; Mon, 21 Oct 2024 16:11:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/20] Test updates (tuxrun tests, new QTest maintainer, ...)
Date: Mon, 21 Oct 2024 18:11:44 +0200
Message-ID: <20241021161156.176427-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-18 10:42:56 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-21

for you to fetch changes up to c592ff35110a5f7e247d3933871d5aca74fc9288:

  tests/functional: Convert the Avocado sh4 tuxrun test (2024-10-21 16:41:39 +0200)

----------------------------------------------------------------
* Convert most Tuxrun Avocado tests to the new functional framework
* Update the OpenBSD CI image to OpenBSD v7.6
* Bump timeout of the ide-test
* New maintainer for the QTests
* Disable the pci-bridge on s390x by default

v2: Drop the troubled aarch64 tuxrun test (and modify the last patch
    to not remove the avocado test)

----------------------------------------------------------------
Brad Smith (1):
      tests/vm: update openbsd image to 7.6

Peter Maydell (1):
      tests/qtest: Raise the ide-test timeout

Thomas Huth (18):
      MAINTAINERS: A new maintainer for the qtests
      hw/pci-bridge: Add a Kconfig switch for the normal PCI bridge
      tests/functional: Add a base class for the TuxRun tests
      tests/functional: Convert the Avocado ppc64 tuxrun tests
      tests/functional: Convert the Avocado sparc64 tuxrun test
      tests/functional: Convert the Avocado s390x tuxrun test
      tests/functional: Convert the Avocado arm tuxrun tests
      tests/functional: Convert the Avocado riscv32 tuxrun tests
      tests/functional: Convert the Avocado riscv64 tuxrun tests
      tests/functional: Convert the Avocado i386 tuxrun test
      tests/functional: Convert the Avocado x86_64 tuxrun test
      tests/functional: Convert the Avocado mips tuxrun test
      tests/functional: Convert the Avocado mipsel tuxrun test
      tests/functional: Convert the Avocado mips64 tuxrun test
      tests/functional: Convert the Avocado mips64el tuxrun test
      tests/functional: Convert the Avocado ppc32 tuxrun test
      Revert "hw/sh4/r2d: Realize IDE controller before accessing it"
      tests/functional: Convert the Avocado sh4 tuxrun test

 MAINTAINERS                              |  18 +-
 hw/sh4/r2d.c                             |   2 +-
 hw/pci-bridge/Kconfig                    |   5 +
 hw/pci-bridge/meson.build                |   2 +-
 tests/avocado/tuxrun_baselines.py        | 396 -------------------------------
 tests/functional/meson.build             |  26 ++
 tests/functional/qemu_test/tuxruntest.py | 158 ++++++++++++
 tests/functional/test_arm_tuxrun.py      |  70 ++++++
 tests/functional/test_i386_tuxrun.py     |  35 +++
 tests/functional/test_mips64_tuxrun.py   |  35 +++
 tests/functional/test_mips64el_tuxrun.py |  35 +++
 tests/functional/test_mips_tuxrun.py     |  36 +++
 tests/functional/test_mipsel_tuxrun.py   |  36 +++
 tests/functional/test_ppc64_tuxrun.py    | 110 +++++++++
 tests/functional/test_ppc_tuxrun.py      |  35 +++
 tests/functional/test_riscv32_tuxrun.py  |  38 +++
 tests/functional/test_riscv64_tuxrun.py  |  38 +++
 tests/functional/test_s390x_tuxrun.py    |  34 +++
 tests/functional/test_sh4_tuxrun.py      |  57 +++++
 tests/functional/test_sparc64_tuxrun.py  |  34 +++
 tests/functional/test_x86_64_tuxrun.py   |  36 +++
 tests/qtest/meson.build                  |   1 +
 tests/vm/openbsd                         |   6 +-
 23 files changed, 836 insertions(+), 407 deletions(-)
 create mode 100644 tests/functional/qemu_test/tuxruntest.py
 create mode 100755 tests/functional/test_arm_tuxrun.py
 create mode 100755 tests/functional/test_i386_tuxrun.py
 create mode 100755 tests/functional/test_mips64_tuxrun.py
 create mode 100755 tests/functional/test_mips64el_tuxrun.py
 create mode 100755 tests/functional/test_mips_tuxrun.py
 create mode 100755 tests/functional/test_mipsel_tuxrun.py
 create mode 100755 tests/functional/test_ppc64_tuxrun.py
 create mode 100755 tests/functional/test_ppc_tuxrun.py
 create mode 100755 tests/functional/test_riscv32_tuxrun.py
 create mode 100755 tests/functional/test_riscv64_tuxrun.py
 create mode 100755 tests/functional/test_s390x_tuxrun.py
 create mode 100755 tests/functional/test_sh4_tuxrun.py
 create mode 100755 tests/functional/test_sparc64_tuxrun.py
 create mode 100755 tests/functional/test_x86_64_tuxrun.py


