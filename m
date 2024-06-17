Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5876C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHXz-0003jZ-PT; Mon, 17 Jun 2024 14:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHXx-0003iv-Gx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:41 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHXv-0004kv-HC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:57:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9291121AD3;
 Mon, 17 Jun 2024 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ZH5ajB2JChd4EDlccYtqV386fNF6C0QzWW37sUwxds=;
 b=e73jz1kevySyWxOSBYGh2rFLxGxDpNExFhtNz+lW731LcGcI7MtJBO+WsVyE8ADfS8B4e8
 pxFtrj20Ga0/Y4w2k5hCtDNiDc9VMm5dunJyPVqOESU0AJ/3BxwJgxdqscKVHFn9YEUdsj
 TCEMMCrneTogXzEU2M4uDTJpDpHRmeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ZH5ajB2JChd4EDlccYtqV386fNF6C0QzWW37sUwxds=;
 b=p5KsH5uNTQMm4imjuvvmsqkxuVPAhpdfdEtbk1kavqKrF/m4RXA3t/JKZIRHbGuc+/am8e
 bAIgw0Kb0tJWXwAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ZH5ajB2JChd4EDlccYtqV386fNF6C0QzWW37sUwxds=;
 b=e73jz1kevySyWxOSBYGh2rFLxGxDpNExFhtNz+lW731LcGcI7MtJBO+WsVyE8ADfS8B4e8
 pxFtrj20Ga0/Y4w2k5hCtDNiDc9VMm5dunJyPVqOESU0AJ/3BxwJgxdqscKVHFn9YEUdsj
 TCEMMCrneTogXzEU2M4uDTJpDpHRmeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ZH5ajB2JChd4EDlccYtqV386fNF6C0QzWW37sUwxds=;
 b=p5KsH5uNTQMm4imjuvvmsqkxuVPAhpdfdEtbk1kavqKrF/m4RXA3t/JKZIRHbGuc+/am8e
 bAIgw0Kb0tJWXwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B133C139AB;
 Mon, 17 Jun 2024 18:57:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n/lwHR2HcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:57:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v3 00/16] migration/mapped-ram: Add direct-io support
Date: Mon, 17 Jun 2024 15:57:15 -0300
Message-Id: <20240617185731.9725-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[6]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

Not many changes since v2:

- new patch 1: drop IOC reference on offset check failure

- dropped 2 patches adding direct-io to the single threaded
  migration. We have agreed to use multifd with 1 channel for that
  use-case.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1335719164

Thanks

v2:
https://lore.kernel.org/r/20240523190548.23977-1-farosas@suse.de

v1:
https://lore.kernel.org/r/20240426142042.14573-1-farosas@suse.de

Hi everyone, here's the rest of the migration "mapped-ram" feature
that didn't get merged for 9.0. This series adds support for direct
I/O, the missing piece to get the desired performance improvements.

There's 3 parts to this:

1- The plumbing for the new "direct-io" migration parameter. With this
   we can already use direct-io with the file transport + multifd +
   mapped-ram. Patches 1-3.

Due to the alignment requirements of O_DIRECT and the fact that
multifd runs the channels in parallel with the migration thread, we
must open the migration file two times, one with O_DIRECT set and
another with it clear.

If the user is not passing in a file name which QEMU can open at will,
we must then require that the user pass the two file descriptors with
the flags already properly set. We'll use the already existing fdset +
QMP add-fd infrastructure for this.

2- Changes to the fdset infrastructure to support O_DIRECT. We need
   those to be able to select from the user-provided fdset the file
   descriptor that contains the O_DIRECT flag. Patches 4-5.

3- Some fdset validation to make sure the two-fds requirement is being
   met. Patches 6-7.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1269352083

Fabiano Rosas (15):
  migration: Drop reference to QIOChannel if file seeking fails
  migration: Fix file migration with fdset
  tests/qtest/migration: Fix file migration offset check
  tests/qtest/migration: Add a precopy file test with fdset
  monitor: Introduce monitor_fdset_*free
  monitor: Stop removing non-duplicated fds
  monitor: Simplify fdset and fd removal
  monitor: Report errors from monitor_fdset_dup_fd_add
  io: Stop using qemu_open_old in channel-file
  migration: Add direct-io parameter
  migration/multifd: Add direct-io support
  tests/qtest/migration: Add tests for file migration with direct-io
  monitor: fdset: Match against O_DIRECT
  migration: Add documentation for fdset with multifd + file
  tests/qtest/migration: Add a test for mapped-ram with passing of fds

Peter Xu (1):
  monitor: Drop monitor_fdset_dup_fd_find/_remove()

 docs/devel/migration/main.rst       |  24 ++-
 docs/devel/migration/mapped-ram.rst |   6 +-
 include/monitor/monitor.h           |   3 +-
 include/qemu/osdep.h                |   2 +
 io/channel-file.c                   |   8 +-
 migration/file.c                    |  45 ++++-
 migration/file.h                    |   1 -
 migration/migration-hmp-cmds.c      |  11 ++
 migration/migration.c               |  23 +++
 migration/options.c                 |  35 ++++
 migration/options.h                 |   1 +
 monitor/fds.c                       |  96 +++++-----
 monitor/hmp.c                       |   2 -
 monitor/monitor-internal.h          |   1 -
 monitor/monitor.c                   |   1 -
 monitor/qmp.c                       |   2 -
 qapi/migration.json                 |  21 ++-
 stubs/fdset.c                       |   7 +-
 tests/qtest/migration-helpers.c     |  44 +++++
 tests/qtest/migration-helpers.h     |   8 +
 tests/qtest/migration-test.c        | 263 +++++++++++++++++++++++++---
 util/osdep.c                        |  34 ++--
 22 files changed, 508 insertions(+), 130 deletions(-)


base-commit: 05ad1440b8428b0ade9b8e5c01469adb8fbf83e3
-- 
2.35.3


