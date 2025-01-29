Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E4FC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAVK-0003F7-3f; Wed, 29 Jan 2025 11:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVG-0003E0-Ch
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:24 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAV8-0005Co-Fk
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6556B1F387;
 Wed, 29 Jan 2025 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/7QBmfG3G/iHlcfa1mr8yPHNyEZydifai14v7BRK6G4=;
 b=ObF49vL06AmgeK37bpf0AjWDoljso7uZnaHmjftFb7UmQnyNQPEKqFEkI69EuZNMVfF8eN
 AsF8vV2REuJg1j6y96sBKbMqefcsb++Tmk/JaCzQialomVsYLOol4h500mlFETfoSlY/3l
 H7AeQGz/eCq5cuocYFsEnnZbKWrkYss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/7QBmfG3G/iHlcfa1mr8yPHNyEZydifai14v7BRK6G4=;
 b=kCGcvk2TGS8Owilp2VyHyx6SPEikJkToZJqCk9OCeCGKPWBwz6GKmMONIo5l7VwKAF/qHq
 Csa9VxRpizKfA9CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/7QBmfG3G/iHlcfa1mr8yPHNyEZydifai14v7BRK6G4=;
 b=ObF49vL06AmgeK37bpf0AjWDoljso7uZnaHmjftFb7UmQnyNQPEKqFEkI69EuZNMVfF8eN
 AsF8vV2REuJg1j6y96sBKbMqefcsb++Tmk/JaCzQialomVsYLOol4h500mlFETfoSlY/3l
 H7AeQGz/eCq5cuocYFsEnnZbKWrkYss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/7QBmfG3G/iHlcfa1mr8yPHNyEZydifai14v7BRK6G4=;
 b=kCGcvk2TGS8Owilp2VyHyx6SPEikJkToZJqCk9OCeCGKPWBwz6GKmMONIo5l7VwKAF/qHq
 Csa9VxRpizKfA9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D518137DB;
 Wed, 29 Jan 2025 16:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kY3RB8RQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/42] Migration patches for 2025-01-29
Date: Wed, 29 Jan 2025 13:00:17 -0300
Message-Id: <20250129160059.6987-1-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

The following changes since commit 7faf9d2f12ace4c1d04cf1a2b39334eef9a45f22:

  Merge tag 'pull-aspeed-20250127' of https://github.com/legoater/qemu into staging (2025-01-27 11:20:35 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250129-pull-request

for you to fetch changes up to bc38dc2f5f350310724fd7d4f0a09f8c3a4811fa:

  migration: refactor ram_save_target_page functions (2025-01-29 11:56:42 -0300)

----------------------------------------------------------------
Migration pull request

- Purge of ram_save_target_page_legacy
- Cleanups to postcopy, json writer, migration states
- New migration mode cpr-transfer
- Fix for a -Werror=maybe-uninitialized instance in savevm

----------------------------------------------------------------

Marc-André Lureau (1):
  migration: fix -Werror=maybe-uninitialized

Peter Xu (16):
  migration: Remove postcopy implications in should_send_vmdesc()
  migration: Do not construct JSON description if suppressed
  migration: Optimize postcopy on downtime by avoiding JSON writer
  migration: Avoid two src-downtime-end tracepoints for postcopy
  migration: Drop inactivate_disk param in qemu_savevm_state_complete*
  migration: Synchronize all CPU states only for non-iterable dump
  migration: Adjust postcopy bandwidth during switchover
  migration: Adjust locking in migration_maybe_pause()
  migration: Drop cached migration state in migration_maybe_pause()
  migration: Take BQL slightly longer in postcopy_start()
  migration: Notify COMPLETE once for postcopy
  migration: Unwrap qemu_savevm_state_complete_precopy() in postcopy
  migration: Cleanup qemu_savevm_state_complete_precopy()
  migration: Always set DEVICE state
  migration: Merge precopy/postcopy on switchover start
  migration: Trivial cleanup on JSON writer of vmstate_save()

Prasad J Pandit (1):
  migration: refactor ram_save_target_page functions

Steve Sistare (24):
  backends/hostmem-shm: factor out allocation of "anonymous shared
    memory with an fd"
  physmem: fix qemu_ram_alloc_from_fd size calculation
  physmem: qemu_ram_alloc_from_fd extensions
  physmem: fd-based shared memory
  memory: add RAM_PRIVATE
  machine: aux-ram-share option
  migration: cpr-state
  physmem: preserve ram blocks for cpr
  hostmem-memfd: preserve for cpr
  hostmem-shm: preserve for cpr
  migration: enhance migrate_uri_parse
  migration: incoming channel
  migration: SCM_RIGHTS for QEMUFile
  migration: VMSTATE_FD
  migration: cpr-transfer save and load
  migration: cpr-transfer mode
  migration-test: memory_backend
  tests/qtest: optimize migrate_set_ports
  tests/qtest: defer connection
  migration-test: defer connection
  tests/qtest: enhance migration channels
  tests/qtest: assert qmp connected
  migration-test: cpr-transfer
  migration: cpr-transfer documentation

 backends/hostmem-epc.c                 |   2 +-
 backends/hostmem-file.c                |   2 +-
 backends/hostmem-memfd.c               |  14 +-
 backends/hostmem-ram.c                 |   2 +-
 backends/hostmem-shm.c                 |  51 +---
 docs/devel/migration/CPR.rst           | 184 ++++++++++++-
 hw/core/machine.c                      |  22 ++
 include/exec/memory.h                  |  10 +
 include/exec/ram_addr.h                |  13 +-
 include/hw/boards.h                    |   1 +
 include/migration/cpr.h                |  33 +++
 include/migration/misc.h               |   7 +
 include/migration/vmstate.h            |   9 +
 include/qemu/osdep.h                   |   1 +
 meson.build                            |   8 +-
 migration/cpr-transfer.c               |  71 +++++
 migration/cpr.c                        | 224 ++++++++++++++++
 migration/meson.build                  |   2 +
 migration/migration.c                  | 348 +++++++++++++++++++------
 migration/migration.h                  |   5 +-
 migration/options.c                    |   8 +-
 migration/qemu-file.c                  |  84 +++++-
 migration/qemu-file.h                  |   2 +
 migration/ram.c                        |  69 ++---
 migration/savevm.c                     | 116 ++++-----
 migration/savevm.h                     |   6 +-
 migration/trace-events                 |  13 +-
 migration/vmstate-types.c              |  24 ++
 migration/vmstate.c                    |   6 +-
 qapi/migration.json                    |  51 +++-
 qemu-options.hx                        |  34 +++
 stubs/vmstate.c                        |   7 +
 system/memory.c                        |   4 +-
 system/physmem.c                       | 150 +++++++++--
 system/trace-events                    |   1 +
 system/vl.c                            |  43 ++-
 tests/qemu-iotests/194.out             |   1 +
 tests/qemu-iotests/203.out             |   1 +
 tests/qemu-iotests/234.out             |   2 +
 tests/qemu-iotests/262.out             |   1 +
 tests/qemu-iotests/280.out             |   1 +
 tests/qtest/libqos/libqos.c            |   3 +-
 tests/qtest/libqtest.c                 | 103 +++++---
 tests/qtest/libqtest.h                 |  24 +-
 tests/qtest/migration/cpr-tests.c      |  62 +++++
 tests/qtest/migration/framework.c      |  80 +++++-
 tests/qtest/migration/framework.h      |  11 +
 tests/qtest/migration/migration-qmp.c  |  53 +++-
 tests/qtest/migration/migration-qmp.h  |  10 +-
 tests/qtest/migration/migration-util.c |  23 +-
 tests/qtest/migration/misc-tests.c     |   9 +-
 tests/qtest/migration/precopy-tests.c  |   6 +-
 tests/qtest/virtio-net-failover.c      |   8 +-
 util/memfd.c                           |  16 +-
 util/oslib-posix.c                     |  52 ++++
 util/oslib-win32.c                     |   6 +
 56 files changed, 1713 insertions(+), 386 deletions(-)
 create mode 100644 include/migration/cpr.h
 create mode 100644 migration/cpr-transfer.c
 create mode 100644 migration/cpr.c

-- 
2.35.3


