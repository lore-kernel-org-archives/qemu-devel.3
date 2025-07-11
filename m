Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84390C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEUq-0005C2-RJ; Fri, 11 Jul 2025 10:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaESh-0000pO-7A
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:10:56 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaESc-0006V7-Dv
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:10:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 925181F385;
 Fri, 11 Jul 2025 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V6+VR7NuErSwcbEFsdPfhzyVTiPuGHiJ6p8MNAHG3jo=;
 b=h6BwoZ8rJB9VsN2uA5yV1E6Ed312F+8maJCdglcdn1UKnwQo7uTrvj9vHxkAnqZiNgp/6b
 1zdYkN1ZFQUKiEMxV360Wy+UVTzWEUuJZzFiHdfv2amyxYSnnLHJ0E+yCqP7cvK431KLBi
 VV1ZnqUfYHz8i9+JbaUKxCdiSO8LU5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V6+VR7NuErSwcbEFsdPfhzyVTiPuGHiJ6p8MNAHG3jo=;
 b=tvrRKCXlcDjggZskO1NMc1TSLDuy5rcoDRH+hg9WSZwXyR0Q6tp3dZKGrCfvPWlT9izw0q
 FwZutP/hGy75hRCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V6+VR7NuErSwcbEFsdPfhzyVTiPuGHiJ6p8MNAHG3jo=;
 b=RwjNy4Vf480SXWfu0lQtyCcnLkbRsDoFG6gOWPO+T/KJ3TWnDmWXS+fE7YNqEodNtA+t6N
 XVP9g/SbknyqhTKrcCplLVnbFC1Hu78JjYLRbr3LSuQ8bHCJrhBHCFkH1ghiU0RwUMvVWC
 my6dRVx5t0h6f5+6bz8PozzwWH+pp1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V6+VR7NuErSwcbEFsdPfhzyVTiPuGHiJ6p8MNAHG3jo=;
 b=rBnsii1i41fmgY69w2KJUDzAEfwDs5wyhF1gAG+5s4de9yAszx7B6d4qN8qKZubj2fs6OJ
 IvoKPUaH8ua5fSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 770861388B;
 Fri, 11 Jul 2025 14:10:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 39xxDVobcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/26] Migration patches for 2025-07-11
Date: Fri, 11 Jul 2025 11:10:05 -0300
Message-Id: <20250711141031.423-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid]
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

The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba336:

  Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging (2025-07-07 09:22:41 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250711-pull-request

for you to fetch changes up to beeac2df5ff0850299e58f4ad27f83dae64c54df:

  migration: Rename save_live_complete_precopy_thread to save_complete_precopy_thread (2025-07-11 10:37:39 -0300)

----------------------------------------------------------------
Migration pull request

- General cleanups around: postcopy, bg-snapshot, migration hooks,
  migration completion and formatting of 'info migrate'.

- Overhaul of postcopy blocktime tracking.

----------------------------------------------------------------

Juraj Marcin (1):
  migration: Rename save_live_complete_precopy_thread to
    save_complete_precopy_thread

Peter Xu (25):
  migration/hmp: Reorg "info migrate" once more
  migration/hmp: Fix postcopy-blocktime per-vCPU results
  migration/docs: Move docs for postcopy blocktime feature
  migration/bg-snapshot: Do not check for SKIP in iterator
  migration: Drop save_live_complete_postcopy hook
  migration: Rename save_live_complete_precopy to save_complete
  migration: qemu_savevm_complete*() helpers
  migration/ram: One less indent for ram_find_and_save_block()
  migration/ram: Add tracepoints for ram_save_complete()
  migration: Rewrite the migration complete detect logic
  migration/postcopy: Avoid clearing dirty bitmap for postcopy too
  migration: Add option to set postcopy-blocktime
  migration/postcopy: Push blocktime start/end into page req mutex
  migration/postcopy: Drop all atomic ops in blocktime feature
  migration/postcopy: Make all blocktime vars 64bits
  migration/postcopy: Drop PostcopyBlocktimeContext.start_time
  migration/postcopy: Bring blocktime layer to ns level
  migration/postcopy: Add blocktime fault counts per-vcpu
  migration/postcopy: Report fault latencies in blocktime
  migration/postcopy: Initialize blocktime context only until listen
  migration/postcopy: Cache the tid->vcpu mapping for blocktime
  migration/postcopy: Cleanup the total blocktime accounting
  migration/postcopy: Optimize blocktime fault tracking with hashtable
  migration/postcopy: blocktime allows track / report non-vCPU faults
  migration/postcopy: Add latency distribution report for blocktime

 docs/devel/migration/main.rst         |   4 +-
 docs/devel/migration/postcopy.rst     |  36 +-
 docs/devel/migration/vfio.rst         |  16 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/s390x/s390-stattrib.c              |   2 +-
 hw/vfio/migration-multifd.c           |   4 +-
 hw/vfio/migration-multifd.h           |   2 +-
 hw/vfio/migration.c                   |   4 +-
 include/migration/misc.h              |   8 +-
 include/migration/register.h          |  36 +-
 include/qemu/typedefs.h               |   6 +-
 migration/block-dirty-bitmap.c        |   3 +-
 migration/migration-hmp-cmds.c        | 159 ++++++--
 migration/migration.c                 |  87 ++--
 migration/migration.h                 |   2 +-
 migration/multifd-device-state.c      |  10 +-
 migration/options.c                   |   2 +
 migration/postcopy-ram.c              | 563 ++++++++++++++++++++------
 migration/postcopy-ram.h              |   2 +
 migration/ram.c                       |  32 +-
 migration/savevm.c                    |  89 ++--
 migration/trace-events                |   9 +-
 qapi/migration.json                   |  38 ++
 tests/qtest/migration/migration-qmp.c |   5 +
 24 files changed, 799 insertions(+), 322 deletions(-)

-- 
2.35.3


