Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6284E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpI-0003rz-E5; Thu, 12 Dec 2024 10:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpB-0003oj-Nr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:09:58 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkp9-0002yL-9t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:09:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 394DC2110B;
 Thu, 12 Dec 2024 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WgId7dnHAh9JZ6YizLaCn/MmxZBtir0fdUxeEJ5tYKM=;
 b=ilxb7tTSVt7Dpf/F7NoGlEQYrPErVU8HNzaBDibrVNX3scvDcfBy1IBYrI+sdk4ZlJLeHt
 aclZ12fQF8BsL9s6dx92VRyZSTjSyf5TBy9PGcKolF6ra98Xq6Wa0Mse8wgP1mLyluVnj0
 WuVO2uHwkEvBRZwi6q//Z/8MwjZ/eOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WgId7dnHAh9JZ6YizLaCn/MmxZBtir0fdUxeEJ5tYKM=;
 b=/+gouOxgdakVpJDJC7/34EifSu2zDP8V64fBPw5AprkzVo8xDPf8u0ZkJJTcdPLQQvCJ5M
 lJjB6dR4Syj/uCBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ilxb7tTS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/+gouOxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WgId7dnHAh9JZ6YizLaCn/MmxZBtir0fdUxeEJ5tYKM=;
 b=ilxb7tTSVt7Dpf/F7NoGlEQYrPErVU8HNzaBDibrVNX3scvDcfBy1IBYrI+sdk4ZlJLeHt
 aclZ12fQF8BsL9s6dx92VRyZSTjSyf5TBy9PGcKolF6ra98Xq6Wa0Mse8wgP1mLyluVnj0
 WuVO2uHwkEvBRZwi6q//Z/8MwjZ/eOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WgId7dnHAh9JZ6YizLaCn/MmxZBtir0fdUxeEJ5tYKM=;
 b=/+gouOxgdakVpJDJC7/34EifSu2zDP8V64fBPw5AprkzVo8xDPf8u0ZkJJTcdPLQQvCJ5M
 lJjB6dR4Syj/uCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3974713508;
 Thu, 12 Dec 2024 15:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PvcpAMD8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:09:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/22] QTest patches for 2024-12-12
Date: Thu, 12 Dec 2024 12:09:27 -0300
Message-Id: <20241212150949.16806-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 394DC2110B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit a5ba0a7e4e150d1350a041f0d0ef9ca6c8d7c307:

  Merge tag 'pull-aspeed-20241211' of https://github.com/legoater/qemu into staging (2024-12-11 15:16:47 +0000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20241212-pull-request

for you to fetch changes up to de8bc62cc4871fa97d1891ebb96e782b0c75b56a:

  tests/qtest/migration: Split validation tests + misc (2024-12-12 10:25:42 -0300)

----------------------------------------------------------------
Qtest pull request

- TIMEOUT_MULTIPLIER setting to allow tests to take longer when asan is enabled
- New qtest_system_reset() wrapper to properly wait for a system reset
- Split of migration-test.c into multiple files under qtest/migration/

----------------------------------------------------------------

Dmitry Frolov (1):
  tests/qtest: add TIMEOUT_MULTIPLIER

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

Nicholas Piggin (1):
  tests/qtest/migration-test: Fix and enable test_ignore_shared

Peter Maydell (3):
  tests/qtest: Add qtest_system_reset() utility function
  tests/qtest: Use qtest_system_reset() instead of open-coded versions
  tests/qtest: Use qtest_system_reset_nowait() where appropriate

 MAINTAINERS                                   |    5 +-
 scripts/mtest2make.py                         |    2 +-
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
 .../guestperf/shell.py                        |    3 +-
 .../guestperf/timings.py                      |    0
 .../initrd-stress.sh                          |    0
 .../meson.build                               |    0
 .../{migration => migration-stress}/stress.c  |    0
 tests/qtest/bios-tables-test.c                |    4 +-
 tests/qtest/boot-order-test.c                 |    7 +-
 tests/qtest/device-plug-test.c                |   11 +-
 tests/qtest/drive_del-test.c                  |    7 +-
 tests/qtest/hd-geo-test.c                     |    9 +-
 tests/qtest/libqtest.c                        |   16 +
 tests/qtest/libqtest.h                        |   25 +
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
 tests/qtest/migration/misc-tests.c            |  282 ++
 tests/qtest/migration/postcopy-tests.c        |  106 +
 tests/{ => qtest}/migration/ppc64/Makefile    |    0
 .../{ => qtest}/migration/ppc64/a-b-kernel.S  |    0
 .../{ => qtest}/migration/ppc64/a-b-kernel.h  |    0
 tests/qtest/migration/precopy-tests.c         | 1007 ++++
 tests/{ => qtest}/migration/s390x/Makefile    |    0
 tests/{ => qtest}/migration/s390x/a-b-bios.c  |    0
 tests/{ => qtest}/migration/s390x/a-b-bios.h  |    0
 tests/qtest/migration/tls-tests.c             |  791 ++++
 tests/qtest/q35-test.c                        |   12 +-
 tests/qtest/qos-test.c                        |    3 +-
 tests/qtest/stm32l4x5_gpio-test.c             |   10 +-
 tests/qtest/stm32l4x5_syscfg-test.c           |   12 +-
 tests/qtest/virtio-net-failover.c             |    3 +-
 61 files changed, 4869 insertions(+), 4423 deletions(-)
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
 rename tests/{migration => migration-stress}/guestperf/shell.py (98%)
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

-- 
2.35.3


