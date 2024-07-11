Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC10C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsPD-0002SC-Ue; Thu, 11 Jul 2024 07:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPA-0002FC-Gz
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsP4-00046a-3H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rwLYzM+XG/SIwrXhb/QsxwVpotfgRBzv8GnRvmRARsc=;
 b=cHDdB3g3p3OfH/4JXtXzZ6Y0cCD9Bi3wMOIjRoo6Vn3xgynodB7diXT/PeRA/IRVWVW5oz
 gvhZw7nMBmSKfi86hV10mhNPd+qPR+L3Lt7/Embm4q/q2nMKeIxKcLlTACMshZjduteMGO
 DS0W9t6ZWwU36WYRwzgAt+BZICqKAmc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-gF9ntDqCOhSJ0icjF-IZeA-1; Thu,
 11 Jul 2024 07:55:56 -0400
X-MC-Unique: gF9ntDqCOhSJ0icjF-IZeA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA973195394D; Thu, 11 Jul 2024 11:55:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7AF41954228; Thu, 11 Jul 2024 11:55:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
Date: Thu, 11 Jul 2024 13:55:38 +0200
Message-ID: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The Avocado v88 that we use in QEMU is already on a life support
system: It is not supported by upstream anymore, and with the latest
versions of Python, it won't work anymore since it depends on the
"imp" module that has been removed in Python 3.12.

There have been several attempts to update the test suite in QEMU
to a newer version of Avocado, but so far no attempt has successfully
been merged yet.

Additionally, the whole "make check" test suite in QEMU is using the
meson test runner nowadays, so running the python-based tests via the
Avocodo test runner looks and feels quite like an oddball, requiring
the users to deal with the knowledge of multiple test runners in
parallel.

So instead of trying to update the python-based test suite in QEMU
to a newer version of Avocado, we should maybe try to better integrate
it with the meson test runner instead. Indeed most tests work quite
nicely without the Avocado framework already, as you can see with
this patch series - it does not convert all tests, just a subset since
it is just an RFC so far, but as you can see, many tests only need
small modifications to work without Avocado.

If you want to try it: Apply the patches, make sure that you have the
"pytest" program installed, then recompile and then run:

 make check-pytest

Things that need further attention though:

- All tests that use the LinuxTest / LinuxDistro classes (e.g. based
  on cloud-init images) really depend on the Avocado framework,
  thus we'd need a solution for those if we want to continue with
  this approach

- Same for all tests that require the LinuxSSHMixIn class - we'd
  need to provide a solution for ssh-based tests, too.

- We lose the way of running tests via the avocado tags this way...
  single targets can still be tested by running "make check-pytest-arm"
  for example, but running selected tests by other tags does not
  work anymore.

- I haven't looked into logging yet ... this still needs some work
  so that you could e.g. inspect the console output of the guests
  somewhere

- I did not work on documentation updates yet (will do that if we
  agree to continue with this patch series)

What's your thoughts? Is it worth to continue with this approach?
Or shall I rather forget about it and wait for the Avocado version
update?

 Thomas


Ani Sinha (1):
  tests/pytest: add pytest to the meson build system

Thomas Huth (7):
  tests/pytest: Add base classes for the upcoming pytest-based tests
  tests/pytest: Convert some simple avocado tests into pytests
  tests/pytest: Convert info_usernet and version test with small
    adjustments
  tests_pytest: Implement fetch_asset() method for downloading assets
  tests/pytest: Convert some tests that download files via fetch_asset()
  tests/pytest: Add a function for extracting files from an archive
  tests/pytest: Convert avocado test that needed avocado.utils.archive

 tests/Makefile.include                        |   4 +-
 tests/meson.build                             |   1 +
 tests/pytest/meson.build                      |  74 ++++
 tests/pytest/qemu_pytest/__init__.py          | 362 ++++++++++++++++++
 tests/pytest/qemu_pytest/utils.py             |  21 +
 .../test_arm_canona1100.py}                   |  16 +-
 .../test_cpu_queries.py}                      |   2 +-
 .../test_empty_cpu_model.py}                  |   2 +-
 .../test_info_usernet.py}                     |   6 +-
 .../test_machine_arm_n8x0.py}                 |  20 +-
 .../test_machine_avr6.py}                     |   7 +-
 .../test_machine_loongarch.py}                |  11 +-
 .../test_machine_mips_loongson3v.py}          |  19 +-
 .../test_mem_addr_space.py}                   |   3 +-
 .../test_ppc_bamboo.py}                       |  18 +-
 .../version.py => pytest/test_version.py}     |   8 +-
 .../test_virtio_version.py}                   |   2 +-
 17 files changed, 502 insertions(+), 74 deletions(-)
 create mode 100644 tests/pytest/meson.build
 create mode 100644 tests/pytest/qemu_pytest/__init__.py
 create mode 100644 tests/pytest/qemu_pytest/utils.py
 rename tests/{avocado/machine_arm_canona1100.py => pytest/test_arm_canona1100.py} (74%)
 rename tests/{avocado/cpu_queries.py => pytest/test_cpu_queries.py} (96%)
 rename tests/{avocado/empty_cpu_model.py => pytest/test_empty_cpu_model.py} (94%)
 rename tests/{avocado/info_usernet.py => pytest/test_info_usernet.py} (91%)
 rename tests/{avocado/machine_arm_n8x0.py => pytest/test_machine_arm_n8x0.py} (71%)
 rename tests/{avocado/machine_avr6.py => pytest/test_machine_avr6.py} (91%)
 rename tests/{avocado/machine_loongarch.py => pytest/test_machine_loongarch.py} (89%)
 rename tests/{avocado/machine_mips_loongson3v.py => pytest/test_machine_mips_loongson3v.py} (59%)
 rename tests/{avocado/mem-addr-space-check.py => pytest/test_mem_addr_space.py} (99%)
 rename tests/{avocado/ppc_bamboo.py => pytest/test_ppc_bamboo.py} (75%)
 rename tests/{avocado/version.py => pytest/test_version.py} (82%)
 rename tests/{avocado/virtio_version.py => pytest/test_virtio_version.py} (99%)

-- 
2.45.2


