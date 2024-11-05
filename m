Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A976CD3177F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NzC-0004i7-2I; Tue, 05 Nov 2024 13:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nz9-0004hN-RS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:00 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nz6-0004rY-4G
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:08:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D69CA1F7FB;
 Tue,  5 Nov 2024 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cv0tOKuddn9gre3tsu9nBTObmj8zNgJz4jedHvPo6hA=;
 b=o9lLyeIcIB3YwyBPlKarVjOrKS3EIr8dfKz886v2oEuELZ+VUMaMAzaJI4ZbTJOeknpjsc
 MId/pX5Ob3s4reoEL9U7e2ETRSa3g3lkkyZ/FsauxFkewMKgdOLXlI2lQL6oq2s8ASkVBs
 X6EeuyYwDRwS3mY3awgoxK7OPGSeDkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cv0tOKuddn9gre3tsu9nBTObmj8zNgJz4jedHvPo6hA=;
 b=WNx409D1zXKgKjEKqcLnd3LBleyRvcyzpDQ5Ir6Y9O1FzOvMftVUw7tW/aRyekcQzMnzqn
 2VqSgRHhvsIcsaBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cv0tOKuddn9gre3tsu9nBTObmj8zNgJz4jedHvPo6hA=;
 b=yAWrDDBe7v0yuB1FFoaF96M2t8Fwb81Vk92B50gWYheu2+x/t4GqiiVAMcje4MnqoL3b4Q
 b+jD+aKHQykxE4Cz02H1O7OydBhOqOqTV9QFrhbUFNWTIT3s6twJXhlRU534DqJHsrvmxV
 MKDJf+4zu/Gd59n4rUE2YmvGuBkHoWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cv0tOKuddn9gre3tsu9nBTObmj8zNgJz4jedHvPo6hA=;
 b=HHLvW/7mAhCKckalb3lgEI/usykWGnAgEnoGDmtd74IuOe0R8310cBUQQsIeN02rLB+Qc6
 sq/yYsSVcaVAO/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DBD01394A;
 Tue,  5 Nov 2024 18:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TaYKATFfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:08:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/22] tests/qtest: migration-test refactoring
Date: Tue,  5 Nov 2024 15:08:15 -0300
Message-Id: <20241105180837.5990-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor migration-test.c and migration-helpers.c into multiple
smaller files structured like so:

qtest/migration/
    migration-common.c - test_precopy_common and similar
    migration-common.h

    migration-util.c - equivalent to migration-helpers.c
    migration-qmp.c - utilities for querying information via QMP
    migration-util.h

    bootfile.c - the guest code
    bootfile.h - formerly migration-test.h, the old name was confusing

    # test code, without main()
    compression-tests.c
    cpr-tests.c
    file-tests.c
    misc-tests.c
    postcopy-tests.c
    precopy-tests.c
    tls-tests.c

qtest/
    migration/ - the directory above

    # actual glib tests, with main()
    migration-test.c - all tests
    migration-test-smoke.c - a subset of smoke tests from each test group

The 'smoke' test runs for every TCG target while the full test runs
only if KVM is available. This saves ~3 minutes with make -j1 in a
build with all 4 migration targets. This strategy keeps the full
coverage as long as someone is running the tests in a KVM host, which
I think is fair as migrating KVM guests is the main use for migration.

Developers can still force the full set to run on TCG by calling:
./migration-test -m thorough

$ arch
x86_64
$ make -j16 check-qtest-migration
...
1/8 qemu:qtest+qtest-x86_64+qtest-migration / qtest-x86_64/migration-test-smoke    SKIP  0.02s
2/8 qemu:qtest+qtest-ppc64+qtest-migration / qtest-ppc64/migration-test            SKIP  0.02s
3/8 qemu:qtest+qtest-aarch64+qtest-migration / qtest-aarch64/migration-test        SKIP  0.02s
4/8 qemu:qtest+qtest-s390x+qtest-migration / qtest-s390x/migration-test            SKIP  0.02s
5/8 qemu:qtest+qtest-s390x+qtest-migration / qtest-s390x/migration-test-smoke      OK   16.31s  14 subtests passed
6/8 qemu:qtest+qtest-ppc64+qtest-migration / qtest-ppc64/migration-test-smoke      OK   19.81s  14 subtests passed
7/8 qemu:qtest+qtest-aarch64+qtest-migration / qtest-aarch64/migration-test-smoke  OK   26.05s  14 subtests passed
8/8 qemu:qtest+qtest-x86_64+qtest-migration / qtest-x86_64/migration-test          OK   81.17s  53 subtests passed

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1528477851

Fabiano Rosas (22):
  tests/qtest/migration: Fix indentations
  tests/qtest/migration: Standardize hook names
  tests/qtest/migration: Stop calling everything "test"
  tests/migration: Disambiguate guestperf vs. a-b
  tests/qtest/migration: Move bootfile code to its own file
  tests/qtest/migration: Move qmp helpers to a separate file
  tests/qtest/migration: Rename migration-helpers.c
  tests/qtest/migration: Move ufd_version_check to utils
  tests/qtest/migration: Move kvm_dirty_ring_supported to utils
  tests/qtest/migration: Isolate test initialization
  tests/qtest/migration: Move common test code
  tests/qtest/migration: Split TLS tests from migration-test.c
  tests/qtest/migration: Split compression tests from migration-test.c
  tests/qtest/migration: Split postcopy tests
  tests/qtest/migration: Split file tests
  tests/qtest/migration: Split precopy tests
  tests/qtest/migration: Split CPR tests
  tests/qtest/migration: Split validation tests + misc
  tests/qtest/migration: Add migration-test-smoke
  tests/qtest/migration: Pick smoke tests
  tests/qtest: Add support for check-qtest-<subsystem>
  docs: Add migration tests documentation

 docs/devel/testing/index.rst                  |    1 +
 docs/devel/testing/main.rst                   |   13 +
 docs/devel/testing/migration.rst              |  261 ++
 docs/devel/testing/qtest.rst                  |    1 +
 tests/meson.build                             |    2 +-
 .../guestperf-batch.py                        |    0
 .../guestperf-plot.py                         |    0
 .../guestperf.py                              |    0
 .../guestperf/__init__.py                     |    0
 .../guestperf/comparison.py                   |    0
 .../guestperf/engine.py                       |    0
 .../guestperf/hardware.py                     |    0
 .../guestperf/plot.py                         |    0
 .../guestperf/progress.py                     |    0
 .../guestperf/report.py                       |    0
 .../guestperf/scenario.py                     |    0
 .../guestperf/shell.py                        |    0
 .../guestperf/timings.py                      |    0
 .../initrd-stress.sh                          |    0
 .../meson.build                               |    0
 .../{migration => migration-stress}/stress.c  |    0
 tests/qtest/meson.build                       |   48 +-
 tests/qtest/migration-test-smoke.c            |   40 +
 tests/qtest/migration-test.c                  | 4028 +----------------
 tests/{ => qtest}/migration/Makefile          |    0
 tests/{ => qtest}/migration/aarch64/Makefile  |    0
 .../migration/aarch64/a-b-kernel.S            |    0
 .../migration/aarch64/a-b-kernel.h            |    0
 tests/qtest/migration/bootfile.c              |   70 +
 .../migration/bootfile.h}                     |    9 +-
 tests/qtest/migration/compression-tests.c     |  243 +
 tests/qtest/migration/cpr-tests.c             |   64 +
 tests/qtest/migration/file-tests.c            |  336 ++
 tests/{ => qtest}/migration/i386/Makefile     |    0
 .../migration/i386/a-b-bootblock.S            |    0
 .../migration/i386/a-b-bootblock.h            |    0
 tests/qtest/migration/migration-common.c      |  963 ++++
 tests/qtest/migration/migration-common.h      |  234 +
 .../migration-qmp.c}                          |  566 ++-
 tests/qtest/migration/migration-util.c        |  355 ++
 .../migration-util.h}                         |   81 +-
 tests/qtest/migration/misc-tests.c            |  280 ++
 tests/qtest/migration/postcopy-tests.c        |  109 +
 tests/{ => qtest}/migration/ppc64/Makefile    |    0
 .../{ => qtest}/migration/ppc64/a-b-kernel.S  |    0
 .../{ => qtest}/migration/ppc64/a-b-kernel.h  |    0
 tests/qtest/migration/precopy-tests.c         | 1003 ++++
 tests/{ => qtest}/migration/s390x/Makefile    |    0
 tests/{ => qtest}/migration/s390x/a-b-bios.c  |    0
 tests/{ => qtest}/migration/s390x/a-b-bios.h  |    0
 tests/qtest/migration/tls-tests.c             |  796 ++++
 tests/qtest/virtio-net-failover.c             |    2 +-
 52 files changed, 5161 insertions(+), 4344 deletions(-)
 create mode 100644 docs/devel/testing/migration.rst
 rename tests/{migration => migration-stress}/guestperf-batch.py (100%)
 rename tests/{migration => migration-stress}/guestperf-plot.py (100%)
 rename tests/{migration => migration-stress}/guestperf.py (100%)
 rename tests/{migration => migration-stress}/guestperf/__init__.py (100%)
 rename tests/{migration => migration-stress}/guestperf/comparison.py (100%)
 rename tests/{migration => migration-stress}/guestperf/engine.py (100%)
 rename tests/{migration => migration-stress}/guestperf/hardware.py (100%)
 rename tests/{migration => migration-stress}/guestperf/plot.py (100%)
 rename tests/{migration => migration-stress}/guestperf/progress.py (100%)
 rename tests/{migration => migration-stress}/guestperf/report.py (100%)
 rename tests/{migration => migration-stress}/guestperf/scenario.py (100%)
 rename tests/{migration => migration-stress}/guestperf/shell.py (100%)
 rename tests/{migration => migration-stress}/guestperf/timings.py (100%)
 rename tests/{migration => migration-stress}/initrd-stress.sh (100%)
 rename tests/{migration => migration-stress}/meson.build (100%)
 rename tests/{migration => migration-stress}/stress.c (100%)
 create mode 100644 tests/qtest/migration-test-smoke.c
 rename tests/{ => qtest}/migration/Makefile (100%)
 rename tests/{ => qtest}/migration/aarch64/Makefile (100%)
 rename tests/{ => qtest}/migration/aarch64/a-b-kernel.S (100%)
 rename tests/{ => qtest}/migration/aarch64/a-b-kernel.h (100%)
 create mode 100644 tests/qtest/migration/bootfile.c
 rename tests/{migration/migration-test.h => qtest/migration/bootfile.h} (85%)
 create mode 100644 tests/qtest/migration/compression-tests.c
 create mode 100644 tests/qtest/migration/cpr-tests.c
 create mode 100644 tests/qtest/migration/file-tests.c
 rename tests/{ => qtest}/migration/i386/Makefile (100%)
 rename tests/{ => qtest}/migration/i386/a-b-bootblock.S (100%)
 rename tests/{ => qtest}/migration/i386/a-b-bootblock.h (100%)
 create mode 100644 tests/qtest/migration/migration-common.c
 create mode 100644 tests/qtest/migration/migration-common.h
 rename tests/qtest/{migration-helpers.c => migration/migration-qmp.c} (51%)
 create mode 100644 tests/qtest/migration/migration-util.c
 rename tests/qtest/{migration-helpers.h => migration/migration-util.h} (50%)
 create mode 100644 tests/qtest/migration/misc-tests.c
 create mode 100644 tests/qtest/migration/postcopy-tests.c
 rename tests/{ => qtest}/migration/ppc64/Makefile (100%)
 rename tests/{ => qtest}/migration/ppc64/a-b-kernel.S (100%)
 rename tests/{ => qtest}/migration/ppc64/a-b-kernel.h (100%)
 create mode 100644 tests/qtest/migration/precopy-tests.c
 rename tests/{ => qtest}/migration/s390x/Makefile (100%)
 rename tests/{ => qtest}/migration/s390x/a-b-bios.c (100%)
 rename tests/{ => qtest}/migration/s390x/a-b-bios.h (100%)
 create mode 100644 tests/qtest/migration/tls-tests.c


base-commit: 11b8920ed2093848f79f93d106afe8a69a61a523
-- 
2.35.3


