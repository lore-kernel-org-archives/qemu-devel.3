Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E5DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlJ-0001xw-Id; Thu, 23 May 2024 15:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlH-0001wT-58
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:05:59 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlF-0004FP-5H
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:05:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90E912040D;
 Thu, 23 May 2024 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ij8cOSfI+xRa2ui7lPl75KDmRN5/OwylkhB0r/ed2+c=;
 b=a69GpudusntB8GuB+cwkZ86TzIAe1kXX5+EPxbTOQbUVE9eEBucS2MaGFagS/Y8pSCqpjs
 8hX/xTCfadoC0A7mL6ZuHeaM1m4i9/2dwz15qybmj5C1zk9inJL8C+mPjL1m32W4vd+i6H
 PLnwRM/qjNVVupiftxSjVM7nzHghoKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ij8cOSfI+xRa2ui7lPl75KDmRN5/OwylkhB0r/ed2+c=;
 b=Pj/0XjkYXpCOm/ZRc1Nq3iX8NGtAnDNmAXzzSgZAmYtZquD9YJX1t/OYxBFHcFJfu8gBy5
 /d08HEnQLTGdn6AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ij8cOSfI+xRa2ui7lPl75KDmRN5/OwylkhB0r/ed2+c=;
 b=a69GpudusntB8GuB+cwkZ86TzIAe1kXX5+EPxbTOQbUVE9eEBucS2MaGFagS/Y8pSCqpjs
 8hX/xTCfadoC0A7mL6ZuHeaM1m4i9/2dwz15qybmj5C1zk9inJL8C+mPjL1m32W4vd+i6H
 PLnwRM/qjNVVupiftxSjVM7nzHghoKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ij8cOSfI+xRa2ui7lPl75KDmRN5/OwylkhB0r/ed2+c=;
 b=Pj/0XjkYXpCOm/ZRc1Nq3iX8NGtAnDNmAXzzSgZAmYtZquD9YJX1t/OYxBFHcFJfu8gBy5
 /d08HEnQLTGdn6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3ED113A6B;
 Thu, 23 May 2024 19:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2fbyHY6TT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:05:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 00/18] migration/mapped-ram: Add direct-io support
Date: Thu, 23 May 2024 16:05:30 -0300
Message-Id: <20240523190548.23977-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

Thank you all for the comments in the previous version. I believe we
managed to remove much of the complexity of the fdset handling.

Major changes in this v2 are:

- The rework of fdset to be less weird when removing fds. Now we
  always remove after qmp_remove_fd() and never remove after the
  monitor closes. Also removed the ->removed flag.

- Properly check for direct-io during params_check. I'm not going with
  the meson.build approach because that's kind of novel for migration
  paramters and I don't want to make direct-io a special case. I also
  couldn't figure out a way of selecting on CONFIG_O_DIRECT that would
  not end up removing the direct_io fields from everywhere, forcing us
  to check the CONFIG all over the place.

New in this v2 are two options to make the usage of the feature more
uniform and require less special cases in the management layer:

- Precopy direct-io. When not using multifd, enable and disable
  O_DIRECT around the parts of the code known to be aligned.

- Implemented direct-io for the incoming side.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1302882857

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

Fabiano Rosas (17):
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
  io/channel-file: Add direct-io support
  migration: Add direct-io helpers
  migration/ram: Add direct-io support to precopy file migration

Peter Xu (1):
  monitor: Drop monitor_fdset_dup_fd_add()

 docs/devel/migration/main.rst       |  24 ++-
 docs/devel/migration/mapped-ram.rst |   6 +-
 include/io/channel-file.h           |   8 +
 include/monitor/monitor.h           |   3 +-
 include/qemu/osdep.h                |   2 +
 io/channel-file.c                   |  33 +++-
 migration/file.c                    |  42 +++-
 migration/file.h                    |   1 -
 migration/migration-hmp-cmds.c      |  11 ++
 migration/migration.c               |  54 +++++
 migration/migration.h               |   2 +
 migration/options.c                 |  28 +++
 migration/options.h                 |   1 +
 migration/qemu-file.c               |  29 +++
 migration/qemu-file.h               |   2 +-
 migration/ram.c                     |  40 +++-
 monitor/fds.c                       |  89 ++++-----
 monitor/hmp.c                       |   2 -
 monitor/monitor-internal.h          |   1 -
 monitor/qmp.c                       |   2 -
 qapi/migration.json                 |  21 +-
 stubs/fdset.c                       |   7 +-
 tests/qtest/migration-helpers.c     |  44 +++++
 tests/qtest/migration-helpers.h     |   8 +
 tests/qtest/migration-test.c        | 296 +++++++++++++++++++++++++---
 util/osdep.c                        |  34 ++--
 26 files changed, 652 insertions(+), 138 deletions(-)


base-commit: 7e1c0047015ffbd408e1aa4a5ec1abe4751dbf7e
-- 
2.35.3


