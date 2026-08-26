Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3D0C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEd3-00014q-Sw; Wed, 26 Aug 2026 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEd2-00014M-DQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:24 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEd0-0001OB-71
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27B4C1F811;
 Wed, 26 Aug 2026 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KK0goH56OB6/jLO0oxiZSleKyLUeCGLI5qPSr924mGU=;
 b=QUhrY1udAD4TcT1VVLNg+b22PJjUHwlk+vffGJ5mJVH+5N598/c9goOOOPtt2Nn/RAu18z
 ootP5fxP/NI0fiFxTPL0mnto5utDQnP8SIh48v5narzGpIFTVz96GA3Rv7TlkC3klEPBs3
 YBa9fLpR4GJeuXxWcHIfgobXiQ6iBXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KK0goH56OB6/jLO0oxiZSleKyLUeCGLI5qPSr924mGU=;
 b=DN2NaCb1zlwTO8aN31LD9HjW5nuyJJX/H+LcH5aP8nwNIs0ON7ZEPWkrj+yx3NN97JBpQK
 bFFRZoBYwuvF05AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KK0goH56OB6/jLO0oxiZSleKyLUeCGLI5qPSr924mGU=;
 b=XpN7hEJB4QZTYSEiTokWcM1jXanh0fFK3+0nxq378TJS7FVh/7Pltf3VDELRZnFiov9oBw
 HBmrKQLebi+L/iEktQCnXVP11AJNIBhwhQo7zJ0oOT7SYgfWUrTUvtZa8LqyoJ+1Lcs0Nw
 Haor4mziGCXQIqRzgCH7ac2eW9R+i6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KK0goH56OB6/jLO0oxiZSleKyLUeCGLI5qPSr924mGU=;
 b=dOl6/Ww4q5rtVOcgfGdeKB8D008oQMi6XggsuzRwDw9h82srwXasf4UCs0d7hwoAHhZf90
 oTYjwhbzmcwsJHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 648EC13354;
 Wed, 26 Aug 2026 14:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zXezDTT4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/30] Migration patches for 2026-08-26
Date: Wed, 26 Aug 2026 11:28:35 -0300
Message-ID: <20260826142905.2315503-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.18)[-0.884];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,gitlab.com:url,suse.de:mid]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,gitlab.com:url];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:

  Merge tag 'fixes-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260826-pull-request

for you to fetch changes up to baa4631ec2731c1b03e9704c4b398d85e4e90f1f:

  migration/postcopy: fix page_requested leak for vhost-user shared pages (2026-08-26 10:07:27 -0300)

----------------------------------------------------------------
Migration pull request

- New feature: Fast Snapshot Load
- Cleanups and hardening of RDMA code
- Cleanups and hardening of vmstate code
- Fix for vhost-user postcopy hang
- Fix for CVE-2026-6426

----------------------------------------------------------------

Aadeshveer Singh (11):
  migration: Propagate error in postcopy setup functions
  migration: Extract blocktime marking helper
  migration: Rename postcopy_listen_thread_bh
  migration: Use file_bmap for RAMBlock during incoming file load
  migration: Make qemu_get_buffer_at() thread-safe
  migration: add RAMBlock field and helper for fast snapshot load
  migration: add support for fault thread to load pages from disk
  migration: add eager load thread and setup for fast snapshot load
  migration: update capability conflict test for postcopy-ram+mapped-ram
  migration/tests: Add test for fast snapshot load
  docs/migration: Add documentation for fast snapshot load feature

Fabiano Rosas (8):
  migration: Remove unused vmstate macros
  migration: Introduce VMStateStructMember
  migration: Remove redundant flags
  migration: Remove duplicate vmstate macros
  migration: Add VMS_NO_STATE flag
  migration: Check more vmstate flags
  migration: Harden vmstate_handle_alloc
  migration: Harden vmstate_size

Peter Xu (10):
  migration/rdma: Introduce RDMA_CONTROL_NUM
  migration/rdma: Remove unregister code
  migration/rdma: Stick with rdma_ prefix for all tracepoints
  migration/rdma: Drop RDMALocalBlock.is_ram_block
  migration/rdma: Drop RDMALocalBlock.unregister_bitmap
  migration/rdma: Drop RDMARegister.key.chunk
  migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST on buflen
  migration/rdma: Sanity check RDMA_CONTROL_REGISTER_REQUEST chunks
  migration/rdma: Sanity check upper bound of register MR address
  migration/rdma: Sanity check compress request ranges

hongmianquan (1):
  migration/postcopy: fix page_requested leak for vhost-user shared
    pages

 docs/devel/migration/fast-snapshot-load.rst |  82 +++++
 docs/devel/migration/features.rst           |   1 +
 hw/pci/msix.c                               |   6 +-
 hw/scsi/scsi-bus.c                          |   6 +-
 include/migration/vmstate.h                 | 388 +++++++++-----------
 include/qemu/notify.h                       |   2 +
 include/system/ramblock.h                   |   6 +
 migration/migration.c                       |  66 ++--
 migration/migration.h                       |   5 +
 migration/options.c                         |  20 +-
 migration/postcopy-ram.c                    | 365 +++++++++++++++---
 migration/postcopy-ram.h                    |   8 +-
 migration/qemu-file.c                       |  11 +-
 migration/qemu-file.h                       |   4 +-
 migration/ram.c                             | 101 ++++-
 migration/rdma.c                            | 349 ++++++------------
 migration/savevm.c                          |  45 ++-
 migration/savevm.h                          |   2 +
 migration/trace-events                      |  83 ++---
 migration/vmstate.c                         | 103 ++++--
 rust/bindings/migration-sys/lib.rs          |  17 +-
 rust/migration/src/vmstate.rs               |  32 +-
 rust/tests/tests/vmstate_tests.rs           |  32 +-
 tests/qtest/migration/file-tests.c          |  24 ++
 tests/qtest/migration/misc-tests.c          |  52 ---
 util/notify.c                               |   5 +
 26 files changed, 1102 insertions(+), 713 deletions(-)
 create mode 100644 docs/devel/migration/fast-snapshot-load.rst

-- 
2.53.0


