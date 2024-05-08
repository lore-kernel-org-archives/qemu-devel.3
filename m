Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5BBC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 23:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpE-0002cn-LP; Wed, 08 May 2024 19:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpC-0002c4-Ue
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:50 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4qpB-0002G7-0u
 for qemu-devel@nongnu.org; Wed, 08 May 2024 19:35:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF466228C6;
 Wed,  8 May 2024 23:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xLH5b0XM9a6L9Xd8WJxIECi8F0g2hFPWaDwhEQEL0fU=;
 b=MC4t4xhf2gM3pCfo54LcC/QCwBforgvzpDGf7e8QqRm0NORlDUEFfQUWn4I0cSChgCFTG8
 YiOxYAMPI7WQoEIQzp2owaTvFzAM/w3MRAjBBsC5QHVkose7D3A2EwjZHvn4qjk5zkWzhE
 NVIw4tj+AA0yqLoLHZ30v+mq4wREXPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xLH5b0XM9a6L9Xd8WJxIECi8F0g2hFPWaDwhEQEL0fU=;
 b=H68c/g7ez6fNGvu2ScdVFFZqCAd1on0L0Aw/4JIR0A9xeCf9IRXwaaz5eAYePnFRlV1x0X
 QFEU8JnRuOocKgBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nk2GWlw2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ajC0cse+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715211344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xLH5b0XM9a6L9Xd8WJxIECi8F0g2hFPWaDwhEQEL0fU=;
 b=Nk2GWlw2r/d4frVdipoqk4Ku0xguQBgfSBh/8wRFvm+0E4rz5YNe8i3u6lsiqpzBnM69WS
 arh2a8tB2CO2GpoT6sk84arnChrIq4QEybOL+85hZ6qZ0RH0hPswrNEmJgvqWmotgTs0dR
 3bbLZ2aTulH+NxKSORDdbtEKOCU1fiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715211344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xLH5b0XM9a6L9Xd8WJxIECi8F0g2hFPWaDwhEQEL0fU=;
 b=ajC0cse+ab7zXEIgXQYNRGq2yiK0y+Mw5bYHyKQjLydNKCxyVLjObGkLFS692QwImdx1WE
 CiBucVkGxknruLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C652D13A27;
 Wed,  8 May 2024 23:35:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o6MaIk8MPGZ7FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 23:35:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 00/13] Migration patches for 2024-05-08
Date: Wed,  8 May 2024 20:35:28 -0300
Message-Id: <20240508233541.2403-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EF466228C6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The following changes since commit 4e66a08546a2588a4667766a1edab9caccf24ce3:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-05-07 09:26:30 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240508-pull-request

for you to fetch changes up to db8cb7b6e73690233bc7c6abbb90979af3a18143:

  hmp/migration: Fix "migrate" command's documentation (2024-05-08 09:22:37 -0300)

----------------------------------------------------------------
Migration pull request

- Will's WITH_QEMU_LOCK_GUARD cleanup
- Vladimir's new exit-on-error parameter
- Fabiano's removals and deprecations series
  (block migration and non-multifd compression removed)
- Peter's documentation fix for HMP migrate command

v2:
- updated Peter's documentation fix.

----------------------------------------------------------------
Fabiano Rosas (6):
      migration: Remove 'skipped' field from MigrationStats
      migration: Remove 'inc' option from migrate command
      migration: Remove 'blk/-b' option from migrate commands
      migration: Remove block migration
      migration: Remove non-multifd compression
      migration: Deprecate fd: for file migration

Peter Xu (1):
      hmp/migration: Fix "migrate" command's documentation

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
 hmp-commands.hx                  |   23 +-
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
 34 files changed, 210 insertions(+), 3036 deletions(-)
 delete mode 100644 migration/block.c
 delete mode 100644 migration/block.h
 delete mode 100644 migration/ram-compress.c
 delete mode 100644 migration/ram-compress.h
 delete mode 100755 tests/qemu-iotests/183
 delete mode 100644 tests/qemu-iotests/183.out
--
2.35.3

