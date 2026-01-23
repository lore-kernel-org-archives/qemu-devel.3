Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAB2D778AE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEH-0001tl-Jg; Fri, 23 Jan 2026 14:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEG-0001tP-5a
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:00 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEE-0003RM-Af
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:53:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2ACA93385F;
 Fri, 23 Jan 2026 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eb0h5KN16q9E68NeEgTRQS1lm1IUkESVgo+A1w46jE0=;
 b=BBM7RrSex3X0o0EFdhulq6Sn9XE61P5LE+RIeGLL+ISMge3wgmInXq1rDqQ2A3dN5pWPtc
 pCwGgHB6gp4cikJ9xFoiCjjm6wlz1R5BQRiKrdyA7PBEmaXlzDPB4hT7JqPMTQ3+4u+Kx3
 WRLqRnly9ESMI8VGq3YSN0u+BpQ+CK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eb0h5KN16q9E68NeEgTRQS1lm1IUkESVgo+A1w46jE0=;
 b=AZE4pmfDVNO1wu8AMLl2LStNgfduXojkubIHW4wk8xKEUsMAWv8IHw23B+H6Tpt29lpqW8
 4vb7vDDAsxO5qXAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eb0h5KN16q9E68NeEgTRQS1lm1IUkESVgo+A1w46jE0=;
 b=BBM7RrSex3X0o0EFdhulq6Sn9XE61P5LE+RIeGLL+ISMge3wgmInXq1rDqQ2A3dN5pWPtc
 pCwGgHB6gp4cikJ9xFoiCjjm6wlz1R5BQRiKrdyA7PBEmaXlzDPB4hT7JqPMTQ3+4u+Kx3
 WRLqRnly9ESMI8VGq3YSN0u+BpQ+CK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eb0h5KN16q9E68NeEgTRQS1lm1IUkESVgo+A1w46jE0=;
 b=AZE4pmfDVNO1wu8AMLl2LStNgfduXojkubIHW4wk8xKEUsMAWv8IHw23B+H6Tpt29lpqW8
 4vb7vDDAsxO5qXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9D81395E;
 Fri, 23 Jan 2026 19:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iQ+qL9LRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:53:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/36] Migration patches for 2026-01-23
Date: Fri, 23 Jan 2026 16:53:15 -0300
Message-ID: <20260123195352.12850-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:

  Merge tag 'hw-misc-20260120' of https://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260123-pull-request

for you to fetch changes up to 03a680c9782ecbbdf2a604918326413527d69322:

  migration/channel: Centralize calling migration_channel_connect_outgoing (2026-01-23 11:34:25 -0300)

----------------------------------------------------------------
Migration pull request

- Removal of deprecated query-migrationthreads command
- Removal of deprecated QMP migrate argument 'detach'
- Removal of deprecated zero-blocks capability
- Removal of deprecated migration to file using fd: URI
- Improvements to fd handling in QEMUFile
- Cleanups to postcopy tests
- Cleanup of migration channel connection code

----------------------------------------------------------------

Fabiano Rosas (25):
  migration: Remove redundant state change
  migration: Fix state change at migration_channel_process_incoming
  migration/tls: Remove unused parameter
  migration: Cleanup TLS handshake hostname passing
  migration: Move postcopy_try_recover into migration_incoming_process
  migration: Use migrate_mode() to query for cpr-transfer
  migration: Free the error earlier in the resume case
  migration: Move error reporting out of migration_cleanup
  migration: Expand migration_connect_error_propagate to cover
    cancelling
  migration: yank: Move register instance earlier
  migration: Fold migration_cleanup() into
    migration_connect_error_propagate()
  migration: Handle error in the early async paths
  migration: Move setting of QEMUFile into
    migration_outgoing|incoming_setup
  migration/rdma: Use common connection paths
  migration: Start incoming from channel.c
  migration/channel: Rename migration_channel_connect
  migration: Rename instances of start
  migration: Move channel code to channel.c
  migration: Move transport connection code into channel.c
  migration: Move channel parsing to channel.c
  migration: Move URI parsing to channel.c
  migration: Free cpr-transfer MigrationAddress along with gsource
  migration: Move CPR HUP watch to cpr-transfer.c
  migration: Remove qmp_migrate_finish
  migration/channel: Centralize calling
    migration_channel_connect_outgoing

Markus Armbruster (2):
  migration: Drop deprecated QMP command query-migrationthreads
  migration: Drop deprecated QMP migrate argument @detach

Peter Xu (4):
  tests/migration-test: Remove postcopy_data from MigrateCommon
  tests/migration-test: Remove postcopy_recovery_fail_stage from
    MigrateCommon
  migration: Remove zero-blocks capability
  migration: Remove fd: support on files

Vladimir Sementsov-Ogievskiy (5):
  vmstate-types: get_fd(): handle qemu_file_get_fd() failure
  qemu-file: qemu_file_get_fd(): fail if no expected fd come
  qemu-file: qemu_file_get_fd(): get byte in one shot
  qemu-file: qemu_file_get_fd(): check service byte itself
  qemu-file: qemu_file_get_fd(): improve interface

 docs/about/deprecated.rst              |  33 --
 docs/about/removed-features.rst        |  30 ++
 include/migration/cpr.h                |   5 +
 migration/channel.c                    | 374 ++++++++++++++--
 migration/channel.h                    |  27 +-
 migration/cpr-exec.c                   |   2 +-
 migration/cpr-transfer.c               |  23 +
 migration/exec.c                       |  11 +-
 migration/exec.h                       |   8 +-
 migration/fd.c                         |  26 +-
 migration/fd.h                         |   9 +-
 migration/file.c                       |  20 +-
 migration/file.h                       |   7 +-
 migration/meson.build                  |   1 -
 migration/migration-hmp-cmds.c         |   2 +-
 migration/migration.c                  | 570 ++++++-------------------
 migration/migration.h                  |  15 +-
 migration/multifd.c                    |  22 +-
 migration/multifd.h                    |   2 +-
 migration/options.c                    |  10 +-
 migration/postcopy-ram.c               |   2 +-
 migration/qemu-file.c                  |  41 +-
 migration/qemu-file.h                  |   2 +-
 migration/rdma.c                       |  46 +-
 migration/rdma.h                       |   6 +-
 migration/socket.c                     |  30 +-
 migration/socket.h                     |   6 +-
 migration/threadinfo.c                 |  64 ---
 migration/threadinfo.h                 |  25 --
 migration/tls.c                        |  33 +-
 migration/tls.h                        |   9 +-
 migration/trace-events                 |  20 +-
 migration/vmstate-types.c              |   5 +-
 qapi/migration.json                    |  50 ---
 tests/qtest/migration/framework.c      |  25 +-
 tests/qtest/migration/framework.h      |   7 +-
 tests/qtest/migration/postcopy-tests.c |  12 +-
 tests/qtest/migration/precopy-tests.c  |  41 --
 tests/qtest/migration/tls-tests.c      |   8 +-
 39 files changed, 734 insertions(+), 895 deletions(-)
 delete mode 100644 migration/threadinfo.c
 delete mode 100644 migration/threadinfo.h

-- 
2.51.0


