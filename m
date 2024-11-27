Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624ACD6ACFC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMmq-0006Vy-Eu; Wed, 27 Nov 2024 13:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmn-0006VB-4p
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmk-0001qk-Q6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC7161F38D;
 Wed, 27 Nov 2024 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JIIlRijL4ppdXa/ItDmC9maVhfzVSsNpnHhzylWKGTc=;
 b=G2hnvKy3PmIOjTIBLKIxmcqgbHSrArk7Uz3btOxD4NLfSf07ogIwTJJE5EilcwGxnMBtYQ
 8JgVCR3Aq1cUwRJct23D2n09OQp/mDpJd+wwbmgl4XkHVBNBc6iF2s2iYdC5YUGzZVUlFx
 89MJzIrs+NxpWIJEz8CbdOox9Dh+Qrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JIIlRijL4ppdXa/ItDmC9maVhfzVSsNpnHhzylWKGTc=;
 b=jgC7a969h05hiCegp17JhgKcP9fcQX27dhksapiQkdQbVCPUcVQb09iQIo0G6X40m3XoQO
 n6tzqCtu1HRjtdBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G2hnvKy3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jgC7a969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JIIlRijL4ppdXa/ItDmC9maVhfzVSsNpnHhzylWKGTc=;
 b=G2hnvKy3PmIOjTIBLKIxmcqgbHSrArk7Uz3btOxD4NLfSf07ogIwTJJE5EilcwGxnMBtYQ
 8JgVCR3Aq1cUwRJct23D2n09OQp/mDpJd+wwbmgl4XkHVBNBc6iF2s2iYdC5YUGzZVUlFx
 89MJzIrs+NxpWIJEz8CbdOox9Dh+Qrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JIIlRijL4ppdXa/ItDmC9maVhfzVSsNpnHhzylWKGTc=;
 b=jgC7a969h05hiCegp17JhgKcP9fcQX27dhksapiQkdQbVCPUcVQb09iQIo0G6X40m3XoQO
 n6tzqCtu1HRjtdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D5B613941;
 Wed, 27 Nov 2024 18:29:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /tLxDPBkR2faYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 18:29:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 00/17] tests/qtest: migration-test refactoring
Date: Wed, 27 Nov 2024 15:28:44 -0300
Message-Id: <20241127182901.529-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC7161F38D
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

v3:
    - Fixed some more hook names I had missed;
    - Move addition of migration-qmp.c in meson to correct patch;
    - Moved QEMU_ENV_* variables to framework.c where they are used;
    - patch 7: improve commit message;
    - s/test-framework/framework/
    - meson.build style changes;
    - did *not* move migration-test into migration/, meson doesn't
      like it. We'd need a separate meson.build for that directory,
      which I don't think is worth it;
    - Drop the other build changes, this is now just the refactoring
      of migration-test.

Refactor migration-test.c and migration-helpers.c into multiple
smaller files structured like so:

qtest/
    migration-test.c

qtest/migration/
    framework.h
    framework.c - core tests infrastructure: migrate_start|end,
                  *_common, wait_for_*, check_guests_ram, etc.

    migration-util.h
    migration-util.c - general utilities, equivalent to
                       migration-helpers.c

    migration-qmp.h
    migration-qmp.c - utilities for querying information via QMP

    bootfile.h - formerly migration-test.h, the old name was confusing
    bootfile.c - the guest code

    # test code, without main()
    compression-tests.c
    cpr-tests.c
    file-tests.c
    misc-tests.c
    postcopy-tests.c
    precopy-tests.c
    tls-tests.c

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1563199058

v2:
https://lore.kernel.org/r/20241113194630.3385-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20241105180837.5990-1-farosas@suse.de
v0:
https://lore.kernel.org/r/20241017143211.17771-1-farosas@suse.de

Fabiano Rosas (17):
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

 MAINTAINERS                                   |    5 +-
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
 tests/qtest/meson.build                       |   27 +-
 tests/qtest/migration-test.c                  | 4031 +----------------
 tests/{ => qtest}/migration/Makefile          |    0
 tests/{ => qtest}/migration/aarch64/Makefile  |    0
 .../migration/aarch64/a-b-kernel.S            |    0
 .../migration/aarch64/a-b-kernel.h            |    0
 tests/qtest/migration/bootfile.c              |   70 +
 .../migration/bootfile.h}                     |    9 +-
 tests/qtest/migration/compression-tests.c     |  239 +
 tests/qtest/migration/cpr-tests.c             |   58 +
 tests/qtest/migration/file-tests.c            |  338 ++
 tests/qtest/migration/framework.c             |  971 ++++
 tests/qtest/migration/framework.h             |  230 +
 tests/{ => qtest}/migration/i386/Makefile     |    0
 .../migration/i386/a-b-bootblock.S            |    0
 .../migration/i386/a-b-bootblock.h            |    0
 .../migration-qmp.c}                          |  567 ++-
 tests/qtest/migration/migration-qmp.h         |   46 +
 tests/qtest/migration/migration-util.c        |  362 ++
 .../migration-util.h}                         |   27 +-
 tests/qtest/migration/misc-tests.c            |  275 ++
 tests/qtest/migration/postcopy-tests.c        |  106 +
 tests/{ => qtest}/migration/ppc64/Makefile    |    0
 .../{ => qtest}/migration/ppc64/a-b-kernel.S  |    0
 .../{ => qtest}/migration/ppc64/a-b-kernel.h  |    0
 tests/qtest/migration/precopy-tests.c         | 1007 ++++
 tests/{ => qtest}/migration/s390x/Makefile    |    0
 tests/{ => qtest}/migration/s390x/a-b-bios.c  |    0
 tests/{ => qtest}/migration/s390x/a-b-bios.h  |    0
 tests/qtest/migration/tls-tests.c             |  791 ++++
 tests/qtest/virtio-net-failover.c             |    3 +-
 49 files changed, 4806 insertions(+), 4358 deletions(-)
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
 rename tests/{ => qtest}/migration/Makefile (100%)
 rename tests/{ => qtest}/migration/aarch64/Makefile (100%)
 rename tests/{ => qtest}/migration/aarch64/a-b-kernel.S (100%)
 rename tests/{ => qtest}/migration/aarch64/a-b-kernel.h (100%)
 create mode 100644 tests/qtest/migration/bootfile.c
 rename tests/{migration/migration-test.h => qtest/migration/bootfile.h} (85%)
 create mode 100644 tests/qtest/migration/compression-tests.c
 create mode 100644 tests/qtest/migration/cpr-tests.c
 create mode 100644 tests/qtest/migration/file-tests.c
 create mode 100644 tests/qtest/migration/framework.c
 create mode 100644 tests/qtest/migration/framework.h
 rename tests/{ => qtest}/migration/i386/Makefile (100%)
 rename tests/{ => qtest}/migration/i386/a-b-bootblock.S (100%)
 rename tests/{ => qtest}/migration/i386/a-b-bootblock.h (100%)
 rename tests/qtest/{migration-helpers.c => migration/migration-qmp.c} (51%)
 create mode 100644 tests/qtest/migration/migration-qmp.h
 create mode 100644 tests/qtest/migration/migration-util.c
 rename tests/qtest/{migration-helpers.h => migration/migration-util.h} (67%)
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


base-commit: 7872e5fdf38ac0d8d0083aabb98d67da1f530ef4
-- 
2.35.3


