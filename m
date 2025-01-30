Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208F3C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUOk-0007Kj-Lv; Thu, 30 Jan 2025 08:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOa-0007I5-Jy
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOX-0008Q7-9e
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ae8IlPPbVgJaBdBjZC51nBHpxAcwm5i97P3QJPh/91Q=;
 b=cnGYENTlFfSI6rO+IbapdbjnVah4uHx+NW7m2Z49eHgFgtH3NgqGWQ+vxz2DlQ8zkWjHC8
 Oy8xOz1INkj0AV++YIIJ6wmS12SYbbjxzScYJcPF2aNwZzeG8C3kzTjxG10y6sr7xTPHB6
 ArEexsMmgIKxpICoAIDUo/aKVqzseow=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-LDF16feAM1GM8wIkACrvkQ-1; Thu,
 30 Jan 2025 08:15:39 -0500
X-MC-Unique: LDF16feAM1GM8wIkACrvkQ-1
X-Mimecast-MFC-AGG-ID: LDF16feAM1GM8wIkACrvkQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6DAA1955DCB
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:15:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7602430001BE; Thu, 30 Jan 2025 13:15:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/20] Functional tests, s390x improvements and slirp fixes
Date: Thu, 30 Jan 2025 14:15:14 +0100
Message-ID: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

The following changes since commit 871af84dd599fab68c8ed414d9ecbdb2bcfc5801:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-01-29 09:51:03 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-01-30

for you to fetch changes up to f141caa270af536b4d5b7c8540820f1bdd245d71:

  net/slirp: libslirp 4.9.0 compatibility (2025-01-30 14:01:46 +0100)

----------------------------------------------------------------
* Convert more avocado tests to the functional framework
* Fix the broken aarch64_tcg_plugins test
* Add test for 64-bit mac99 machine
* Add a Linux-based test for the 40p machine
* Fix issues with record/replay of some s390x instructions
* Fix node.js crashes on emulated s390x due to a bug in the MVC instruction
* Enable virtio-balloon-pci and virtio-mem-pci on s390x
* Fix a libslirp v4.9.0 compilation problem

----------------------------------------------------------------
Cédric Le Goater (2):
      tests/functional: Add a ppc64 mac99 test
      tests/functional: Extend PPC 40p test with Linux boot

David Hildenbrand (2):
      virtio-mem-pci: Allow setting nvectors, so we can use MSI-X
      s390x/s390-virtio-ccw: Support plugging PCI-based virtio memory devices

Ilya Leoshkevich (4):
      target/s390x: Fix PPNO execution with icount
      target/s390x: Fix MVC not always invalidating translation blocks
      tests/tcg/s390x: Test modifying code using the MVC instruction
      hw/s390x/s390-virtio-ccw: Fix a record/replay deadlock

Michael Tokarev (1):
      net/slirp: libslirp 4.9.0 compatibility

Reza Arbab (1):
      virtio-balloon-pci: Allow setting nvectors, so we can use MSI-X

Thomas Huth (10):
      tests/functional/qemu_test/decorators: Fix bad check for imports
      tests/functional: Fix broken decorators with lamda functions
      tests/functional: Convert the migration avocado test
      tests/functional: Fix the aarch64_tcg_plugins test
      tests/functional/test_mips_malta: Fix comment about endianness of the test
      tests/functional: Add a decorator for skipping long running tests
      tests/functional: Add the ReplayKernelBase class
      tests/functional/test_mipsel_malta: Convert the mipsel replay tests
      tests/functional/test_mips64el_malta: Convert the mips64el replay tests
      tests/functional/test_mips_malta: Convert the mips big endian replay tests

 MAINTAINERS                                      |   3 +
 docs/devel/testing/functional.rst                |   8 ++
 target/s390x/tcg/insn-data.h.inc                 |   2 +-
 hw/core/machine.c                                |   4 +
 hw/s390x/s390-virtio-ccw.c                       |  44 +++++-
 hw/virtio/virtio-balloon-pci.c                   |  12 ++
 hw/virtio/virtio-mem-pci.c                       |  12 ++
 net/slirp.c                                      |  25 ++--
 target/s390x/tcg/mem_helper.c                    |   2 +-
 tests/tcg/s390x/mvc-smc.c                        |  82 +++++++++++
 tests/avocado/migration.py                       | 135 -------------------
 tests/avocado/replay_kernel.py                   | 165 -----------------------
 tests/functional/meson.build                     |  39 ++++++
 tests/functional/qemu_test/__init__.py           |   2 +-
 tests/functional/qemu_test/decorators.py         |  59 ++++----
 tests/functional/replay_kernel.py                |  84 ++++++++++++
 tests/functional/test_aarch64_sbsaref_alpine.py  |   5 +-
 tests/functional/test_aarch64_sbsaref_freebsd.py |   9 +-
 tests/functional/test_aarch64_tcg_plugins.py     |  15 ++-
 tests/functional/test_arm_quanta_gsj.py          |   6 +-
 tests/functional/test_migration.py               | 100 ++++++++++++++
 tests/functional/test_mips64el_replay.py         |  60 +++++++++
 tests/functional/test_mips_malta.py              |   2 +-
 tests/functional/test_mips_replay.py             |  55 ++++++++
 tests/functional/test_mipsel_replay.py           |  54 ++++++++
 tests/functional/test_ppc64_mac99.py             |  44 ++++++
 tests/functional/test_ppc_40p.py                 |  18 +++
 tests/tcg/s390x/Makefile.softmmu-target          |   1 +
 28 files changed, 687 insertions(+), 360 deletions(-)
 create mode 100644 tests/tcg/s390x/mvc-smc.c
 delete mode 100644 tests/avocado/migration.py
 create mode 100644 tests/functional/replay_kernel.py
 create mode 100755 tests/functional/test_migration.py
 create mode 100755 tests/functional/test_mips64el_replay.py
 create mode 100755 tests/functional/test_mips_replay.py
 create mode 100644 tests/functional/test_mipsel_replay.py
 create mode 100755 tests/functional/test_ppc64_mac99.py


