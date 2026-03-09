Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2F7F3C250
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaKo-0006b8-57; Mon, 09 Mar 2026 09:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaKl-0006aW-1R
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:07:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaKe-0007wd-Qe
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:07:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 498544D218;
 Mon,  9 Mar 2026 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=penBJgBnKAnXd0dToeYZdrCVWowxsIIX4RdUmQ9Q1+U=;
 b=PkX18gTpeYMR+H4ff/XfzV8+0ebN+2ofJn4UjN4/ykpugObJWjvw3opPoelPlM28k10kpT
 +2+6L9aMV2ndx/Pddj+puXDt0h8TwABurN+0O5OT7C/D81vq2QhOuC3guOksi7TSYDHxNe
 8CNz5eLdxvDBm7+kGUWLrPWp292IqDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=penBJgBnKAnXd0dToeYZdrCVWowxsIIX4RdUmQ9Q1+U=;
 b=OtihI2MFtswj4d5Z0ZvJZ1Zao+w0CWhDLoifI1rcsyRDYp4Ey4FefmL+KnYF1cZoDrN3S/
 7xfF6VPrwNqev1Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=penBJgBnKAnXd0dToeYZdrCVWowxsIIX4RdUmQ9Q1+U=;
 b=PkX18gTpeYMR+H4ff/XfzV8+0ebN+2ofJn4UjN4/ykpugObJWjvw3opPoelPlM28k10kpT
 +2+6L9aMV2ndx/Pddj+puXDt0h8TwABurN+0O5OT7C/D81vq2QhOuC3guOksi7TSYDHxNe
 8CNz5eLdxvDBm7+kGUWLrPWp292IqDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=penBJgBnKAnXd0dToeYZdrCVWowxsIIX4RdUmQ9Q1+U=;
 b=OtihI2MFtswj4d5Z0ZvJZ1Zao+w0CWhDLoifI1rcsyRDYp4Ey4FefmL+KnYF1cZoDrN3S/
 7xfF6VPrwNqev1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5522D3EEF3;
 Mon,  9 Mar 2026 13:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UZXdBhXGrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:07:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/22] Migration patches for 2026-03-09
Date: Mon,  9 Mar 2026 10:07:05 -0300
Message-ID: <20260309130730.20526-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:

  Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260309-pull-request

for you to fetch changes up to 161e6039759a77debee9434ee55a086c8a85ed60:

  colo: Reuse the return path from migration on primary and secondary side (2026-03-09 08:53:34 -0300)

----------------------------------------------------------------
Migration pull request

- Fix for races when migration starts again after a failure
- New maintainer for COLO: Lukas Straub
- COLO cleanups and bug fixes
- COLO multifd support

----------------------------------------------------------------

Lukas Straub (21):
  MAINTAINERS: Add myself as maintainer for COLO migration framework
  MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
  colo: Setup ram cache in normal migration path
  colo: Replace migration_incoming_colo_enabled() with migrate_colo()
  colo: Remove ENABLE_COLO savevm command and mark it as deprecated
  ram: Remove colo special-casing
  multifd: Move ram state receive into multifd_ram_state_recv()
  multifd: Add COLO support
  Call colo_release_ram_cache() after multifd threads terminate
  colo: Fix crash during device vmstate load
  colo: Hold the BQL while sending ram state
  colo: Do not hold the BQL while receiving ram state.
  migration-test: Add COLO migration unit test
  Convert colo main documentation to restructuredText
  qemu-colo.rst: Miscellaneous changes
  qemu-colo.rst: Add my copyright
  qemu-colo.rst: Simplify the block replication setup
  multifd: Fix hang if send thread errors during sync
  colo: Use file lock in primary_vm_do_failover()
  migration: Keep s->rp_state.from_dst_file open until migration ends
  colo: Reuse the return path from migration on primary and secondary
    side

Prasad J Pandit (1):
  migration: introduce MIGRATION_STATUS_FAILING

 MAINTAINERS                           |   6 +-
 docs/COLO-FT.txt                      | 334 ------------------------
 docs/system/index.rst                 |   1 +
 docs/system/qemu-colo.rst             | 361 ++++++++++++++++++++++++++
 include/migration/colo.h              |   3 -
 migration/colo.c                      |  59 ++---
 migration/meson.build                 |   2 +-
 migration/migration.c                 | 112 ++++----
 migration/multifd-colo.c              |  41 +++
 migration/multifd-colo.h              |  23 ++
 migration/multifd-nocomp.c            |  10 +-
 migration/multifd.c                   |  30 ++-
 migration/multifd.h                   |   5 +-
 migration/options.c                   |  10 +-
 migration/ram.c                       |  12 +-
 migration/savevm.c                    |  37 +--
 migration/savevm.h                    |   1 -
 migration/trace-events                |   1 -
 qapi/migration.json                   |   9 +-
 tests/qtest/meson.build               |   7 +-
 tests/qtest/migration-test.c          |   1 +
 tests/qtest/migration/colo-tests.c    | 195 ++++++++++++++
 tests/qtest/migration/framework.c     |  13 +
 tests/qtest/migration/framework.h     |   5 +
 tests/qtest/migration/migration-qmp.c |   3 +-
 tests/qtest/migration/precopy-tests.c |   3 +-
 26 files changed, 798 insertions(+), 486 deletions(-)
 delete mode 100644 docs/COLO-FT.txt
 create mode 100644 docs/system/qemu-colo.rst
 create mode 100644 migration/multifd-colo.c
 create mode 100644 migration/multifd-colo.h
 create mode 100644 tests/qtest/migration/colo-tests.c

-- 
2.51.0


