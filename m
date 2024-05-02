Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F10C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cxp-0007un-Ux; Thu, 02 May 2024 16:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cxj-0007tK-5t
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:27 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cxh-0002mt-5m
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E45821FD16;
 Thu,  2 May 2024 20:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NN3JX0vWv3PeUyF5U9ZmHuod2sogS2KvaQSZY3qUjUk=;
 b=nox7UyeYjnw0YhbwZ5igXawsjGokWcngUGglpY4Tyqn5ZjA63kViPBn2u3vRya1+ob6M1o
 HL1+RH0yupWFm3eO2bZ3UB9SY6krBxpTsqcBCcX8OSCvE9WtwVJA5Y4F88Hjv/K4t0N8gK
 lDuYFlu2ZuvrazrgHGl9pzBZTYs5PSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NN3JX0vWv3PeUyF5U9ZmHuod2sogS2KvaQSZY3qUjUk=;
 b=V8FyQEZwbQWhDSr1i9W6GVmlnbIfcE+FLfcE3XLXc5eW3k7T1lfMGjKuRjEonEksvJ52t8
 1c6FG9P5UxvKtxCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NN3JX0vWv3PeUyF5U9ZmHuod2sogS2KvaQSZY3qUjUk=;
 b=WXroNFHVrzul3H0rvm4OGKM3xXNr3f4OHZA/9r++4JLR/pRSqolw/wRrRu1fXDKFNAxKi5
 Dq5VAPPj7i2dCGxvUMBkk2nmvsM3tLXAtOfLPt+MeqrKtPzUInh1fmxyiUtajWxwmFLa7J
 wB8pZg1rVCkmaB9fYDO3fkty/sM1P8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NN3JX0vWv3PeUyF5U9ZmHuod2sogS2KvaQSZY3qUjUk=;
 b=QvuKgCdqD7yL48rZ5Zi10kqYgBTCf86Ay2+/Gn4AJ71mvoEDOUI5t2JNhU4HGwd0kXdbPC
 d+QDg8HTxsvUwsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0245513957;
 Thu,  2 May 2024 20:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PWLiLjf2M2ZZUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 May 2024 20:23:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/13] Migration patches for 2024-05-02
Date: Thu,  2 May 2024 17:23:03 -0300
Message-Id: <20240502202316.29924-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The following changes since commit 4977ce198d2390bff8c71ad5cb1a5f6aa24b56fb:

  Merge tag 'pull-tcg-20240501' of https://gitlab.com/rth7680/qemu into staging (2024-05-01 15:15:33 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240502-pull-request

for you to fetch changes up to 4f9f85a5e223fd488b4deb6d9449576e7dbe6819:

  hmp/migration: Fix documents for "migrate" command (2024-05-02 14:45:07 -0300)

----------------------------------------------------------------
Migration pull request

- Will's WITH_QEMU_LOCK_GUARD cleanup
- Vladimir's new exit-on-error parameter
- Fabiano's removals and deprecations series
  (block migration and non-multifd compression removed)
- Peter's documentation fix for HMP migrate command

----------------------------------------------------------------
Fabiano Rosas (6):
      migration: Remove 'skipped' field from MigrationStats
      migration: Remove 'inc' option from migrate command
      migration: Remove 'blk/-b' option from migrate commands
      migration: Remove block migration
      migration: Remove non-multifd compression
      migration: Deprecate fd: for file migration

Peter Xu (1):
      hmp/migration: Fix documents for "migrate" command

Vladimir Sementsov-Ogievskiy (5):
      migration: move trace-point from migrate_fd_error to migrate_set_error
      migration: process_incoming_migration_co(): complete cleanup on failure
      migration: process_incoming_migration_co(): fix reporting s->error
      migration: process_incoming_migration_co(): rework error reporting
      qapi: introduce exit-on-error parameter for migrate-incoming

Will Gyda (1):
      migration/ram.c: API Conversion qemu_mutex_lock(), and qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro

 .gitlab-ci.d/buildtest.yml       |    2 +-
 MAINTAINERS                      |    1 -
 docs/about/deprecated.rst        |   51 +-
 docs/about/removed-features.rst  |  103 ++++
 docs/devel/migration/main.rst    |    2 +-
 hmp-commands.hx                  |   22 +-
 hw/core/machine.c                |    1 -
 include/migration/misc.h         |    6 -
 meson.build                      |    2 -
 meson_options.txt                |    2 -
 migration/block.c                | 1019 --------------------------------------
 migration/block.h                |   52 --
 migration/colo.c                 |    1 -
 migration/fd.c                   |   12 +
 migration/meson.build            |    4 -
 migration/migration-hmp-cmds.c   |   99 +---
 migration/migration.c            |  121 ++---
 migration/migration.h            |   14 +-
 migration/options.c              |  229 ---------
 migration/options.h              |   13 -
 migration/qemu-file.c            |   78 ---
 migration/qemu-file.h            |    4 -
 migration/ram-compress.c         |  564 ---------------------
 migration/ram-compress.h         |   77 ---
 migration/ram.c                  |  181 +------
 migration/savevm.c               |    5 -
 migration/trace-events           |    2 +-
 qapi/migration.json              |  212 +-------
 scripts/meson-buildoptions.sh    |    4 -
 system/vl.c                      |    3 +-
 tests/qemu-iotests/183           |  147 ------
 tests/qemu-iotests/183.out       |   66 ---
 tests/qemu-iotests/common.filter |    7 -
 tests/qtest/migration-test.c     |  139 ------
 34 files changed, 209 insertions(+), 3036 deletions(-)
 delete mode 100644 migration/block.c
 delete mode 100644 migration/block.h
 delete mode 100644 migration/ram-compress.c
 delete mode 100644 migration/ram-compress.h
 delete mode 100755 tests/qemu-iotests/183
 delete mode 100644 tests/qemu-iotests/183.out

Fabiano Rosas (6):
  migration: Remove 'skipped' field from MigrationStats
  migration: Remove 'inc' option from migrate command
  migration: Remove 'blk/-b' option from migrate commands
  migration: Remove block migration
  migration: Remove non-multifd compression
  migration: Deprecate fd: for file migration

Peter Xu (1):
  hmp/migration: Fix documents for "migrate" command

Vladimir Sementsov-Ogievskiy (5):
  migration: move trace-point from migrate_fd_error to migrate_set_error
  migration: process_incoming_migration_co(): complete cleanup on
    failure
  migration: process_incoming_migration_co(): fix reporting s->error
  migration: process_incoming_migration_co(): rework error reporting
  qapi: introduce exit-on-error parameter for migrate-incoming

Will Gyda (1):
  migration/ram.c: API Conversion qemu_mutex_lock(), and
    qemu_mutex_unlock() to WITH_QEMU_LOCK_GUARD macro

 .gitlab-ci.d/buildtest.yml       |    2 +-
 MAINTAINERS                      |    1 -
 docs/about/deprecated.rst        |   51 +-
 docs/about/removed-features.rst  |  103 +++
 docs/devel/migration/main.rst    |    2 +-
 hmp-commands.hx                  |   22 +-
 hw/core/machine.c                |    1 -
 include/migration/misc.h         |    6 -
 meson.build                      |    2 -
 meson_options.txt                |    2 -
 migration/block.c                | 1019 ------------------------------
 migration/block.h                |   52 --
 migration/colo.c                 |    1 -
 migration/fd.c                   |   12 +
 migration/meson.build            |    4 -
 migration/migration-hmp-cmds.c   |   99 +--
 migration/migration.c            |  121 ++--
 migration/migration.h            |   14 +-
 migration/options.c              |  229 -------
 migration/options.h              |   13 -
 migration/qemu-file.c            |   78 ---
 migration/qemu-file.h            |    4 -
 migration/ram-compress.c         |  564 -----------------
 migration/ram-compress.h         |   77 ---
 migration/ram.c                  |  181 +-----
 migration/savevm.c               |    5 -
 migration/trace-events           |    2 +-
 qapi/migration.json              |  212 +------
 scripts/meson-buildoptions.sh    |    4 -
 system/vl.c                      |    3 +-
 tests/qemu-iotests/183           |  147 -----
 tests/qemu-iotests/183.out       |   66 --
 tests/qemu-iotests/common.filter |    7 -
 tests/qtest/migration-test.c     |  139 ----
 34 files changed, 209 insertions(+), 3036 deletions(-)
 delete mode 100644 migration/block.c
 delete mode 100644 migration/block.h
 delete mode 100644 migration/ram-compress.c
 delete mode 100644 migration/ram-compress.h
 delete mode 100755 tests/qemu-iotests/183
 delete mode 100644 tests/qemu-iotests/183.out

-- 
2.35.3


