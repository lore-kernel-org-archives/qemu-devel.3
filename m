Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E42C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTK-0003GF-Ij; Fri, 21 Jun 2024 13:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTE-0003Ev-4C
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTA-0003JF-Lt
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 035781F7F2;
 Fri, 21 Jun 2024 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKih3/ekCNCGZBJmxj32Xw0Sv30BGcQlrAemKqh4gwc=;
 b=Kf9oXV670mz6THPlGztwjiscxztiTmCqNsmkPJ4igLB2IygxVNrS3liVX1CFQxyLup8lJb
 OfROGlOiEt6HTVmSvWM1aeBCwXqSy4jw95xUOBztz1fdguxV7DJUxN4MdofdJ6FeXyTNyY
 +ECtJ1sQTbhWAGrUepeObugtsQ4Arm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKih3/ekCNCGZBJmxj32Xw0Sv30BGcQlrAemKqh4gwc=;
 b=ZmuFZjnP9W2wK7vc5ocVxGRUZXWo+bKr1NHiC/uf1crqIw+jOGLbCi5XXGnvFjU7i4BHcZ
 m6uAwAHBcAd0EpAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKih3/ekCNCGZBJmxj32Xw0Sv30BGcQlrAemKqh4gwc=;
 b=Kf9oXV670mz6THPlGztwjiscxztiTmCqNsmkPJ4igLB2IygxVNrS3liVX1CFQxyLup8lJb
 OfROGlOiEt6HTVmSvWM1aeBCwXqSy4jw95xUOBztz1fdguxV7DJUxN4MdofdJ6FeXyTNyY
 +ECtJ1sQTbhWAGrUepeObugtsQ4Arm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKih3/ekCNCGZBJmxj32Xw0Sv30BGcQlrAemKqh4gwc=;
 b=ZmuFZjnP9W2wK7vc5ocVxGRUZXWo+bKr1NHiC/uf1crqIw+jOGLbCi5XXGnvFjU7i4BHcZ
 m6uAwAHBcAd0EpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C965013AAA;
 Fri, 21 Jun 2024 17:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N5alIly+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:54:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/28] Migration patches for 2024-06-21
Date: Fri, 21 Jun 2024 14:54:06 -0300
Message-Id: <20240621175434.31180-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The following changes since commit 02d9c38236cf8c9826e5c5be61780c4444cb4ae0:

  Merge tag 'pull-tcg-20240619' of https://gitlab.com/rth7680/qemu into staging (2024-06-19 14:00:39 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240621-pull-request

for you to fetch changes up to 04b09de16d78cf2d163ca65d7c6d161bf2baceb6:

  migration: Remove unused VMSTATE_ARRAY_TEST() macro (2024-06-21 14:37:58 -0300)

----------------------------------------------------------------
Migration pull request

- Fabiano's fix for fdset + file migration truncating the migration
  file

- Fabiano's fdset + direct-io support for mapped-ram

- Peter's various cleanups (multifd sync, thread names, migration
  states, tests)

- Peter's new migration state postcopy-recover-setup

- Philippe's unused vmstate macro cleanup

----------------------------------------------------------------

Fabiano Rosas (15):
  migration: Drop reference to QIOChannel if file seeking fails
  migration: Fix file migration with fdset
  tests/qtest/migration: Fix file migration offset check
  tests/qtest/migration: Add a precopy file test with fdset
  monitor: Introduce monitor_fdset_*free
  monitor: Stop removing non-duplicated fds
  monitor: Simplify fdset and fd removal
  monitor: Report errors from monitor_fdset_dup_fd_add
  io: Stop using qemu_open_old in channel-file
  migration: Add direct-io parameter
  migration/multifd: Add direct-io support
  tests/qtest/migration: Add tests for file migration with direct-io
  monitor: fdset: Match against O_DIRECT
  migration: Add documentation for fdset with multifd + file
  tests/qtest/migration: Add a test for mapped-ram with passing of fds

Peter Xu (12):
  monitor: Drop monitor_fdset_dup_fd_find/_remove()
  migration/multifd: Avoid the final FLUSH in complete()
  migration: Rename thread debug names
  migration: Use MigrationStatus instead of int
  migration: Cleanup incoming migration setup state change
  migration/postcopy: Add postcopy-recover-setup phase
  migration/docs: Update postcopy recover session for SETUP phase
  tests/migration-tests: Drop most WIN32 ifdefs for postcopy failure
    tests
  tests/migration-tests: Always enable migration events
  tests/migration-tests: migration_event_wait()
  tests/migration-tests: Verify postcopy-recover-setup status
  tests/migration-tests: Cover postcopy failure on reconnect

Philippe Mathieu-Daudé (1):
  migration: Remove unused VMSTATE_ARRAY_TEST() macro

 docs/devel/migration/main.rst       |  24 +-
 docs/devel/migration/mapped-ram.rst |   6 +-
 docs/devel/migration/postcopy.rst   |  29 +-
 include/migration/vmstate.h         |  10 -
 include/monitor/monitor.h           |   3 +-
 include/qemu/osdep.h                |   2 +
 io/channel-file.c                   |   8 +-
 migration/colo.c                    |   2 +-
 migration/file.c                    |  45 ++-
 migration/file.h                    |   1 -
 migration/migration-hmp-cmds.c      |  11 +
 migration/migration.c               | 121 +++++--
 migration/migration.h               |   9 +-
 migration/multifd.c                 |   6 +-
 migration/options.c                 |  35 +++
 migration/options.h                 |   1 +
 migration/postcopy-ram.c            |  10 +-
 migration/postcopy-ram.h            |   3 +
 migration/ram.c                     |   4 -
 migration/savevm.c                  |   6 +-
 monitor/fds.c                       |  96 +++---
 monitor/hmp.c                       |   2 -
 monitor/monitor-internal.h          |   1 -
 monitor/monitor.c                   |   1 -
 monitor/qmp.c                       |   2 -
 qapi/migration.json                 |  25 +-
 stubs/fdset.c                       |   7 +-
 tests/qtest/libqtest.c              |  15 +-
 tests/qtest/libqtest.h              |   2 +
 tests/qtest/migration-helpers.c     |  76 ++++-
 tests/qtest/migration-helpers.h     |  10 +
 tests/qtest/migration-test.c        | 470 +++++++++++++++++++++++++---
 util/osdep.c                        |  34 +-
 33 files changed, 838 insertions(+), 239 deletions(-)

-- 
2.35.3


