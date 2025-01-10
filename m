Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A030E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuG-0001Np-C2; Fri, 10 Jan 2025 07:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuB-0001Mc-RA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:24 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDu9-0003Ia-Ru
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 871FE1F455;
 Fri, 10 Jan 2025 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=66T1TzkNVX0nQpzGGToKPM1zTcvg7KIZNEUnCdT6Rz0=;
 b=HKWMPVWtI/P6wUL79HvSfoPWd2zCwaEX1yJML1zhPPNRx2TNf0y2QdSdFiTXk3lRjrrJ5Y
 PlJMh3vDVoGzIAXGirE90pfyGhW5e6A4jCrEHLWXKwqXHpOjUcOMuP00o+rJlbSCdLDH6/
 XxXuv1JIOibF5AmIwWFzaobYR39YaFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=66T1TzkNVX0nQpzGGToKPM1zTcvg7KIZNEUnCdT6Rz0=;
 b=7u7PnV19sI+/ZwaA6IdJ1lvantq+mMpos39nuy9mYV2GTain1zpr8roBI894NtRQa8+oVR
 9cPcwJkN40T7OvBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=66T1TzkNVX0nQpzGGToKPM1zTcvg7KIZNEUnCdT6Rz0=;
 b=HKWMPVWtI/P6wUL79HvSfoPWd2zCwaEX1yJML1zhPPNRx2TNf0y2QdSdFiTXk3lRjrrJ5Y
 PlJMh3vDVoGzIAXGirE90pfyGhW5e6A4jCrEHLWXKwqXHpOjUcOMuP00o+rJlbSCdLDH6/
 XxXuv1JIOibF5AmIwWFzaobYR39YaFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=66T1TzkNVX0nQpzGGToKPM1zTcvg7KIZNEUnCdT6Rz0=;
 b=7u7PnV19sI+/ZwaA6IdJ1lvantq+mMpos39nuy9mYV2GTain1zpr8roBI894NtRQa8+oVR
 9cPcwJkN40T7OvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F7FF13A86;
 Fri, 10 Jan 2025 12:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HNYuFRgPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/25] Migration patches for 2025-01-10
Date: Fri, 10 Jan 2025 09:13:48 -0300
Message-Id: <20250110121413.12336-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

The following changes since commit bc6afa1c711da5b4f37c9685a812c77b114d84cb:

  Merge tag 'pull-xenfv-20250109-1' of https://gitlab.com/dwmw2/qemu into staging (2025-01-09 08:39:32 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250110-pull-request

for you to fetch changes up to a523bc52166c80d8a04d46584f9f3868bd53ef69:

  multifd: bugfix for incorrect migration data with qatzip compression (2025-01-09 17:40:27 -0300)

----------------------------------------------------------------
Migration pull request

- compression:
  Shameer's fix for CONFIG_UADK build
  Yuan Liu fixes for zero-page, QPL, qatzip

- multifd sync cleanups, prereq. for VFIO and postcopy work

- fixes for 9.2 regressions:
  multifd with pre-9.0 -> post-9.1 migrations (#2720)
  s390x migration (#2704)

- fix for assertions during paused migrations; rework of
  late-block-activate logic (#2395, #686)

- fixes for compressed arrays creation and parsing, mostly affecting
  s390x

----------------------------------------------------------------

Fabiano Rosas (7):
  migration/multifd: Fix compat with QEMU < 9.0
  migration: Add more error handling to analyze-migration.py
  migration: Remove unused argument in vmsd_desc_field_end
  migration: Fix parsing of s390 stream
  migration: Rename vmstate_info_nullptr
  migration: Fix arrays of pointers in JSON writer
  s390x: Fix CSS migration

Peter Xu (14):
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
  migration: Dump correct JSON format for nullptr replacement

Shameer Kolothum (1):
  migration/multifd: Fix compile error caused by page_size usage

Yuan Liu (3):
  multifd: bugfix for migration using compression methods
  multifd: bugfix for incorrect migration data with QPL compression
  multifd: bugfix for incorrect migration data with qatzip compression

 hw/s390x/s390-virtio-ccw.c   |   2 +-
 include/migration/misc.h     |   4 +
 migration/block-active.c     |  94 ++++++++++++++++++++++
 migration/colo.c             |   2 +-
 migration/meson.build        |   1 +
 migration/migration.c        | 136 ++++++++++++-------------------
 migration/migration.h        |   6 +-
 migration/multifd-nocomp.c   |  77 +++++++++++++++++-
 migration/multifd-qatzip.c   |   1 +
 migration/multifd-qpl.c      |   1 +
 migration/multifd-uadk.c     |   2 +-
 migration/multifd.c          |  32 +++++---
 migration/multifd.h          |  27 ++++++-
 migration/ram.c              |  89 +++++++++------------
 migration/ram.h              |  28 +++++++
 migration/rdma.h             |   7 --
 migration/savevm.c           |  46 +++++------
 migration/trace-events       |   3 +
 migration/vmstate-types.c    |   2 +-
 migration/vmstate.c          | 151 ++++++++++++++++++++++++++++-------
 monitor/qmp-cmds.c           |  22 +++--
 scripts/analyze-migration.py | 142 +++++++++++++++++++++++---------
 22 files changed, 602 insertions(+), 273 deletions(-)
 create mode 100644 migration/block-active.c

-- 
2.35.3


