Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F7C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcEu-0000hD-Ly; Fri, 07 Mar 2025 13:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcEq-0000gn-ME
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:00 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcEo-00047v-MB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:00 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDCBB2118C;
 Fri,  7 Mar 2025 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8E+Idmbou/cWXK9o0//2th7/KbSEL18ohTUT99X5ko=;
 b=EvLwh5Km/7JewB93KK3TstRqdgVtG5iLMN+KANkp9EDMh6KHPAojiMLNaBYggDzJQkIIHF
 3SxVPundM8XyLnEMrd/KOaXB78vDok2W8b+f74Zr37mIYI0sOwBR3oMdyRJWnmD0yURPDN
 kgsOplvmrWp/0yBz0Iz4WV98Xl4PiJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8E+Idmbou/cWXK9o0//2th7/KbSEL18ohTUT99X5ko=;
 b=igGN7zFHeQd/WZz72AcYI20GtEhwj/qGOViD2LzFNfRBVTsfzWuQ3yD3hpr93bcPnZFJGC
 nVB//zmzpjcAbsCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8E+Idmbou/cWXK9o0//2th7/KbSEL18ohTUT99X5ko=;
 b=EvLwh5Km/7JewB93KK3TstRqdgVtG5iLMN+KANkp9EDMh6KHPAojiMLNaBYggDzJQkIIHF
 3SxVPundM8XyLnEMrd/KOaXB78vDok2W8b+f74Zr37mIYI0sOwBR3oMdyRJWnmD0yURPDN
 kgsOplvmrWp/0yBz0Iz4WV98Xl4PiJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S8E+Idmbou/cWXK9o0//2th7/KbSEL18ohTUT99X5ko=;
 b=igGN7zFHeQd/WZz72AcYI20GtEhwj/qGOViD2LzFNfRBVTsfzWuQ3yD3hpr93bcPnZFJGC
 nVB//zmzpjcAbsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B603913A22;
 Fri,  7 Mar 2025 18:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N6C7HNo3y2dNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 18:15:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/8] Migration patches for 2025-03-07
Date: Fri,  7 Mar 2025 15:15:43 -0300
Message-Id: <20250307181551.19887-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

The following changes since commit 98c7362b1efe651327385a25874a73e008c6549e:

  Merge tag 'accel-cpus-20250306' of https://github.com/philmd/qemu into staging (2025-03-07 07:39:49 +0800)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250307-pull-request

for you to fetch changes up to 5aee8eaea8ec1d5d364f529bf044f4129286b9f1:

  migration: Add qtest for migration over RDMA (2025-03-07 12:04:58 -0300)

Patch 8/8 triggers a bogus checkpatch error that doesn't apply to
qtest, please ignore:

 ERROR: Error messages should not contain newlines

----------------------------------------------------------------
Migration pull request

- Fix use-after-free in incoming migration
- Improve cpr migration blocker for volatile ram
- Fix RDMA migration
- RDMA migration test + helper script to setup an rdma link

----------------------------------------------------------------

Li Zhijian (6):
  migration: Prioritize RDMA in ram_save_target_page()
  migration: check RDMA and capabilities are compatible on both sides
  migration: disable RDMA + postcopy-ram
  migration/rdma: Remove redundant migration_in_postcopy checks
  migration: Unfold control_save_page()
  migration: Add qtest for migration over RDMA

Peter Xu (1):
  migration: Fix UAF for incoming migration on MigrationState

Steve Sistare (1):
  migration: ram block cpr blockers

 MAINTAINERS                           |  1 +
 include/exec/memory.h                 |  3 ++
 include/exec/ramblock.h               |  1 +
 migration/migration.c                 | 70 ++++++++++++++++++++++-----
 migration/options.c                   | 25 ++++++++++
 migration/options.h                   |  1 +
 migration/ram.c                       | 41 +++++-----------
 migration/rdma.c                      | 11 ++---
 migration/rdma.h                      |  3 +-
 migration/savevm.c                    |  2 +
 scripts/rdma-migration-helper.sh      | 48 ++++++++++++++++++
 system/physmem.c                      | 66 +++++++++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 69 ++++++++++++++++++++++++++
 13 files changed, 290 insertions(+), 51 deletions(-)
 create mode 100755 scripts/rdma-migration-helper.sh

-- 
2.35.3


