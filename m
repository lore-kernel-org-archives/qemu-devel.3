Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11320C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2MP-0006Zg-3g; Fri, 14 Feb 2025 15:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2M5-0006Ec-Lv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:32:11 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2M3-0002A6-DG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:32:09 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DB7A1F381;
 Fri, 14 Feb 2025 20:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=90B7p/Ym/HeTBXN7OpyW3lFyc2jjlpHhDDJgfh1BI5A=;
 b=ww4uMZu1KkuTyGajEULFdzQDQbj20lDnW/jodkHTqe8V812WKKcDcgoYD5mXmQihKPAJAT
 5A5yuSnJY+6uDeeAZB2cZnezO+yx6niVAjaT4CvI9KQxgA2kDJ8IZ5iQ8Vtqihm24+RWsg
 ljHgHICOb/CZPXKIHkhEN4+K5CieIac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=90B7p/Ym/HeTBXN7OpyW3lFyc2jjlpHhDDJgfh1BI5A=;
 b=BXOrN79TO/JQ0bqOiYHQLNNzMGTaBdeavEkTb5LoFZmJYo6pvfZpEY1WJWzqGuHP/bjmSi
 SOZ5j5R0XRiw0xAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=90B7p/Ym/HeTBXN7OpyW3lFyc2jjlpHhDDJgfh1BI5A=;
 b=ww4uMZu1KkuTyGajEULFdzQDQbj20lDnW/jodkHTqe8V812WKKcDcgoYD5mXmQihKPAJAT
 5A5yuSnJY+6uDeeAZB2cZnezO+yx6niVAjaT4CvI9KQxgA2kDJ8IZ5iQ8Vtqihm24+RWsg
 ljHgHICOb/CZPXKIHkhEN4+K5CieIac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=90B7p/Ym/HeTBXN7OpyW3lFyc2jjlpHhDDJgfh1BI5A=;
 b=BXOrN79TO/JQ0bqOiYHQLNNzMGTaBdeavEkTb5LoFZmJYo6pvfZpEY1WJWzqGuHP/bjmSi
 SOZ5j5R0XRiw0xAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCBA213285;
 Fri, 14 Feb 2025 20:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gMFYJUKor2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/22] Migration patches for 2025-02-14
Date: Fri, 14 Feb 2025 17:31:37 -0300
Message-Id: <20250214203159.30168-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:mid]
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

The following changes since commit 495de0fd82d8bb2d7035f82d9869cfeb48de2f9e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-02-14 08:19:05 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250214-pull-request

for you to fetch changes up to 5984870e02aa6cf471bc9225ae91640b544b31c8:

  guestperf: Add test result data into report (2025-02-14 15:19:07 -0300)

----------------------------------------------------------------
Migration pull request

- Proper TLS termination for multifd
- Fixes for bugs while cancelling migration
- Fix for a hang after migration failure (#2633)
- Tests for qmp_migrate_cancel
- Fix for CID 1590980
- Fixes and improvements to guestperf.py

----------------------------------------------------------------

Fabiano Rosas (17):
  crypto: Allow gracefully ending the TLS session
  io: tls: Add qio_channel_tls_bye
  crypto: Remove qcrypto_tls_session_get_handshake_status
  io: Add flags argument to qio_channel_readv_full_all_eof
  io: Add a read flag for relaxed EOF
  migration/multifd: Terminate the TLS connection
  migration/multifd: Add a compat property for TLS termination
  migration: Check migration error after loadvm
  migration: Set migration error outside of migrate_cancel
  migration: Unify migration_cancel and migrate_fd_cancel
  migration: Change migrate_fd_ to migration_
  migration: Fix hang after error in destination setup phase
  migration: Reject qmp_migrate_cancel after postcopy
  migration: Don't set FAILED state when cancelling
  tests/qtest/migration: Introduce migration_test_add_suffix
  tests/qtest/migration: Add a cancel test
  migration: Update migrate_cancel documentation

Hyman Huang (4):
  guestperf: Support deferred migration for multifd
  guestperf: Nitpick the inconsistent parameters
  guestperf: Introduce multifd compression option
  guestperf: Add test result data into report

Steve Sistare (1):
  migration: use parameters.mode in cpr_state_save

 crypto/tlssession.c                           |  96 ++++++----
 hw/core/machine.c                             |   1 +
 hw/remote/mpqemu-link.c                       |   2 +-
 include/crypto/tlssession.h                   |  46 +++--
 include/io/channel-tls.h                      |  12 ++
 include/io/channel.h                          |   3 +
 io/channel-tls.c                              |  92 ++++++++-
 io/channel.c                                  |   9 +-
 io/trace-events                               |   5 +
 migration/channel.c                           |   9 +-
 migration/cpr.c                               |   1 +
 migration/migration.c                         |  81 ++++----
 migration/migration.h                         |  37 +++-
 migration/multifd.c                           |  54 +++++-
 migration/multifd.h                           |   2 +
 migration/options.c                           |   2 +
 migration/ram.c                               |   4 +-
 migration/rdma.c                              |   2 +-
 migration/savevm.c                            |   6 +-
 migration/tls.c                               |   5 +
 migration/tls.h                               |   2 +-
 migration/trace-events                        |   4 +-
 qapi/migration.json                           |   4 +-
 .../migration-stress/guestperf/comparison.py  |  15 +-
 tests/migration-stress/guestperf/engine.py    |  43 ++++-
 tests/migration-stress/guestperf/report.py    |  20 ++
 tests/migration-stress/guestperf/scenario.py  |   7 +-
 tests/migration-stress/guestperf/shell.py     |   3 +
 tests/qtest/migration/migration-util.c        |  24 +++
 tests/qtest/migration/migration-util.h        |   2 +
 tests/qtest/migration/precopy-tests.c         | 176 ++++++++++++++++++
 tests/unit/test-crypto-tlssession.c           |  12 +-
 32 files changed, 651 insertions(+), 130 deletions(-)

-- 
2.35.3


