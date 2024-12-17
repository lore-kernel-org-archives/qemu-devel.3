Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE9BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbgy-0005mW-VQ; Tue, 17 Dec 2024 12:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbgt-0005ly-AN
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:03 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbgr-0007Zt-LD
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:03 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1D111F395;
 Tue, 17 Dec 2024 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a87cQIK/obwFca/RZswdQH9QU5AhJ5V3nJ68iwWAMXE=;
 b=q2RQJeqinamgWpXyfABL+/TuQUkIRi/0+NSKu/AX0yvqEv6cW5GTf8EIUB8yOMBVm5bdJg
 mGqfTDw9Rrpv0uWEtxADf/ZdUuGGN4s2HuZyJCerFtD5n0IiiiruJqhm/khfK8HE225wCc
 ueAmdAJOjokmPR3oJVxDPkmw2pwFW9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a87cQIK/obwFca/RZswdQH9QU5AhJ5V3nJ68iwWAMXE=;
 b=LWIOsklc8gOmcTN+24ikNx5ybaid1Xhf7KoYZ7gtViRugXRhM2Hi9fohUpp+YTF7gsK8Sm
 QQompefJvyhx3fAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a87cQIK/obwFca/RZswdQH9QU5AhJ5V3nJ68iwWAMXE=;
 b=q2RQJeqinamgWpXyfABL+/TuQUkIRi/0+NSKu/AX0yvqEv6cW5GTf8EIUB8yOMBVm5bdJg
 mGqfTDw9Rrpv0uWEtxADf/ZdUuGGN4s2HuZyJCerFtD5n0IiiiruJqhm/khfK8HE225wCc
 ueAmdAJOjokmPR3oJVxDPkmw2pwFW9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a87cQIK/obwFca/RZswdQH9QU5AhJ5V3nJ68iwWAMXE=;
 b=LWIOsklc8gOmcTN+24ikNx5ybaid1Xhf7KoYZ7gtViRugXRhM2Hi9fohUpp+YTF7gsK8Sm
 QQompefJvyhx3fAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2F7513A3C;
 Tue, 17 Dec 2024 17:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uNbDIYm5YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:48:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/17] Migration patches for 2024-12-17
Date: Tue, 17 Dec 2024 14:48:38 -0300
Message-Id: <20241217174855.24971-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:

  Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20241217-pull-request

for you to fetch changes up to 1bed6df0c71d3a74286f53c01fafd21fde8777f4:

  tests/qtest/migration: Fix compile errors when CONFIG_UADK is set (2024-12-17 13:51:19 -0300)

----------------------------------------------------------------
Migration pull request

- Shameer's fixes for CONFIG_UADK code

- Peter's multifd sync cleanups, prereq. for VFIO and postcopy work

- Fabiano's fix for multifd regression in pre-9.0 -> post-9.1
  migrations (#2720)

- Fabiano's fix for s390x migration regression (#2704)

- Peter's fix for assertions during paused migrations; reworks
  late-block-activate logic (#2395, #686)

----------------------------------------------------------------

Fabiano Rosas (2):
  migration/multifd: Fix compat with QEMU < 9.0
  s390x: Fix CSS migration

Peter Xu (13):
  migration/multifd: Further remove the SYNC on complete
  migration/multifd: Allow to sync with sender threads only
  migration/ram: Move RAM_SAVE_FLAG* into ram.h
  migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH messages
  migration/multifd: Remove sync processing on postcopy
  migration/multifd: Cleanup src flushes on condition check
  migration/multifd: Document the reason to sync for save_setup()
  migration: Add helper to get target runstate
  qmp/cont: Only activate disks if migration completed
  migration/block: Make late-block-active the default
  migration/block: Apply late-block-active behavior to postcopy
  migration/block: Fix possible race with block_inactive
  migration/block: Rewrite disk activation

Shameer Kolothum (2):
  migration/multifd: Fix compile error caused by page_size usage
  tests/qtest/migration: Fix compile errors when CONFIG_UADK is set

 hw/s390x/s390-virtio-ccw.c                |   2 +-
 include/migration/misc.h                  |   4 +
 migration/block-active.c                  |  94 +++++++++++++++
 migration/colo.c                          |   2 +-
 migration/meson.build                     |   1 +
 migration/migration.c                     | 136 +++++++++-------------
 migration/migration.h                     |   6 +-
 migration/multifd-nocomp.c                |  74 +++++++++++-
 migration/multifd-uadk.c                  |   2 +-
 migration/multifd.c                       |  32 +++--
 migration/multifd.h                       |  27 ++++-
 migration/ram.c                           |  89 +++++++-------
 migration/ram.h                           |  28 +++++
 migration/rdma.h                          |   7 --
 migration/savevm.c                        |  46 ++++----
 migration/trace-events                    |   3 +
 monitor/qmp-cmds.c                        |  22 ++--
 tests/qtest/migration/compression-tests.c |  54 ---------
 18 files changed, 372 insertions(+), 257 deletions(-)
 create mode 100644 migration/block-active.c

-- 
2.35.3


