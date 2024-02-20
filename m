Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA15C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoE-0002sa-8F; Tue, 20 Feb 2024 17:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoA-0002ph-9v
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:51 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYo8-0006DI-4G
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:41:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B33001FB40;
 Tue, 20 Feb 2024 22:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B4h+LP1x2gAjEZE010XzzngoWhYZ+q4FGE6icJCsygo=;
 b=pK+ghggf42X1IAwO4KRo295cGD2pjg/3g0RjBGV0DQuey3rt6lV4PYtVkVsFqEqRk+H2DS
 8o/ZJyr0ExM4A39Yo8cwpPjjwfgDO2kA74IS6clKQ6rFFACbJogDEAWAUyJG7E60xSFM3j
 i9b46OTmgB3nA2ucLrBGkOrKydzu3XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B4h+LP1x2gAjEZE010XzzngoWhYZ+q4FGE6icJCsygo=;
 b=emrWHd2iJQ+p7mVr5xZmGQUmNxnMLF5X+g/9DN8B9IukpziXjx/mWQSqT3WkNfL3FpswhS
 rPLiTqx8qCodeCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B4h+LP1x2gAjEZE010XzzngoWhYZ+q4FGE6icJCsygo=;
 b=aqkKnExtMloPdtmzKSWvaQrHAbVuPyoRt5kqNABwznUAQd2vGejaa79oFHivvQEviX66ya
 hB71NhvP/ySK188itAqVPvTaAGUmfQbIw+/WyM2QSkcSGTNu2ZAOZNXBQ37BwZy+ruA72N
 jHvwxcR3DWajVsz2HPhkvZ0CjhTaHJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B4h+LP1x2gAjEZE010XzzngoWhYZ+q4FGE6icJCsygo=;
 b=dfCESmkfV0pzn6PfFj2j+2hYT54vxfRO38Cz+6+L2MOHvF99HgpP8KEJk2r/9O+5dm93b+
 fxYjjqBpAyNObpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13D1C139D0;
 Tue, 20 Feb 2024 22:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vuhPMqQq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:41:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 00/34] migration: File based migration with multifd and
 fixed-ram
Date: Tue, 20 Feb 2024 19:41:04 -0300
Message-Id: <20240220224138.24759-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aqkKnExt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dfCESmkf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: B33001FB40
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

In this v4:

- Added support for 'fd:'. With fixed-ram, that comes free by the
  existing routing to file.c. With multifd I added a loop to create
  the channels.

- Dropped support for direct-io with fixed-ram _without_ multifd. This
  is something I said I would do for this version, but I had to drop
  it because performance is really bad. I think the single-threaded
  precopy code cannot cope with the extra latency/synchronicity of
  O_DIRECT.

- Dropped QIOTask related changes. The file migration now calls
  multifd_channel_connect() directly. Any error can now be returned
  all the way up to migrate_fd_connect(). We can also skip the
  channels_created semaphore logic when using fixed-ram.

- Moved the pwritev_read_contiguous code into a migration-specific
  file and dropped the write_base trick.

- Reduced the number of syncs to just one every ram iteration and one
  at the end on the send side; and a single one at the end on the recv
  side. The EOS flag cannot be skipped because it is used in control
  flow at ram_load_precopy.

The rest are minor changes, I have noted them in the patches
themselves.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1183853433

Series structure
================

This series enables fixed-ram in steps:

0) Cleanups                           [1-5]
1) QIOChannel interfaces              [6-10]
2) Fixed-ram format for precopy       [11-15]
3) Multifd adaptation without packets [16-19]
4) Fixed-ram format for multifd       [20-26]
5) Direct-io generic support          [27]
6) Direct-io for fixed-ram multifd with file: URI  [28-29]
7) Fdset interface for fixed-ram multifd  [30-34]

The majority of changes for this version are at step 3 due to the
rebase on top of the recent multifd cleanups.

Please take a look at the later patches in the series, step 5 onwards.

About fixed-ram
===============

Fixed-ram is a new stream format for the RAM section designed to
supplement the existing ``file:`` migration and make it compatible
with ``multifd``. This enables parallel migration of a guest's RAM to
a file.

The core of the feature is to ensure that each RAM page has a specific
offset in the resulting migration file. This enables the ``multifd``
threads to write exclusively to those offsets even if the guest is
constantly dirtying pages (i.e. live migration).

Another benefit is that the resulting file will have a bounded size,
since pages which are dirtied multiple times will always go to a fixed
location in the file, rather than constantly being added to a
sequential stream.

Having the pages at fixed offsets also allows the usage of O_DIRECT
for save/restore of the migration stream as the pages are ensured to
be written respecting O_DIRECT alignment restrictions.

Latest numbers
==============

=> guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
=> host: 128 CPU AMD EPYC 7543 - 2 NVMe disks in RAID0 (8586 MiB/s) - xfs
=> pinned vcpus w/ NUMA shortest distances - average of 3 runs - results
   from query-migrate

non-live           | time (ms)   pages/s   mb/s   MB/s
-------------------+-----------------------------------
file               |    110512    256258   9549   1193
  + bg-snapshot    |    245660    119581   4303    537
-------------------+-----------------------------------
fixed-ram          |    157975    216877   6672    834
  + multifd 8 ch.  |     95922    292178  10982   1372
     + direct-io   |     23268   1936897  45330   5666
-------------------------------------------------------

live               | time (ms)   pages/s   mb/s   MB/s
-------------------+-----------------------------------
file               |         -         -      -      - (file grew 4x the VM size)
  + bg-snapshot    |    357635    141747   2974    371
-------------------+-----------------------------------
fixed-ram          |         -         -      -      - (no convergence in 5 min)
  + multifd 8 ch.  |    230812    497551  14900   1862
     + direct-io   |     27475   1788025  46736   5842
-------------------------------------------------------

Previous versions of this patchset have shown performance closer to
disk saturation, but due to the query-migrate bug[1] it's hard to be
confident in the previous numbers. I don't discard the possibility of
a performance regression, but for now I can't spot anything that could
have caused it.

1- https://lore.kernel.org/r/20240219194457.26923-1-farosas@suse.de

v3:
https://lore.kernel.org/r/20231127202612.23012-1-farosas@suse.de
v2:
https://lore.kernel.org/r/20231023203608.26370-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20230330180336.2791-1-farosas@suse.de

Fabiano Rosas (31):
  docs/devel/migration.rst: Document the file transport
  tests/qtest/migration: Rename fd_proto test
  tests/qtest/migration: Add a fd + file test
  migration/multifd: Remove p->quit from recv side
  migration/multifd: Release recv sem_sync earlier
  io: fsync before closing a file channel
  migration/qemu-file: add utility methods for working with seekable
    channels
  migration/ram: Introduce 'fixed-ram' migration capability
  migration: Add fixed-ram URI compatibility check
  migration/ram: Add outgoing 'fixed-ram' migration
  migration/ram: Add incoming 'fixed-ram' migration
  tests/qtest/migration: Add tests for fixed-ram file-based migration
  migration/multifd: Rename MultiFDSend|RecvParams::data to
    compress_data
  migration/multifd: Decouple recv method from pages
  migration/multifd: Allow multifd without packets
  migration/multifd: Allow receiving pages without packets
  migration/multifd: Add outgoing QIOChannelFile support
  migration/multifd: Add incoming QIOChannelFile support
  migration/multifd: Prepare multifd sync for fixed-ram migration
  migration/multifd: Support outgoing fixed-ram stream format
  migration/multifd: Support incoming fixed-ram stream format
  migration/multifd: Add fixed-ram support to fd: URI
  tests/qtest/migration: Add a multifd + fixed-ram migration test
  migration: Add direct-io parameter
  migration/multifd: Add direct-io support
  tests/qtest/migration: Add tests for file migration with direct-io
  monitor: Honor QMP request for fd removal immediately
  monitor: Extract fdset fd flags comparison into a function
  monitor: fdset: Match against O_DIRECT
  migration: Add support for fdset with multifd + file
  tests/qtest/migration: Add a test for fixed-ram with passing of fds

Nikolay Borisov (3):
  io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE for channel file
  io: Add generic pwritev/preadv interface
  io: implement io_pwritev/preadv for QIOChannelFile

 docs/devel/migration/features.rst   |   1 +
 docs/devel/migration/fixed-ram.rst  | 137 +++++++++
 docs/devel/migration/main.rst       |  22 ++
 include/exec/ramblock.h             |  13 +
 include/io/channel.h                |  83 ++++++
 include/migration/qemu-file-types.h |   2 +
 include/qemu/bitops.h               |  13 +
 include/qemu/osdep.h                |   2 +
 io/channel-file.c                   |  69 +++++
 io/channel.c                        |  58 ++++
 migration/fd.c                      |  30 ++
 migration/fd.h                      |   1 +
 migration/file.c                    | 258 +++++++++++++++-
 migration/file.h                    |   9 +
 migration/migration-hmp-cmds.c      |  11 +
 migration/migration.c               |  68 ++++-
 migration/multifd-zlib.c            |  26 +-
 migration/multifd-zstd.c            |  26 +-
 migration/multifd.c                 | 436 +++++++++++++++++++++-------
 migration/multifd.h                 |  27 +-
 migration/options.c                 |  66 +++++
 migration/options.h                 |   2 +
 migration/qemu-file.c               | 106 +++++++
 migration/qemu-file.h               |   6 +
 migration/ram.c                     | 333 ++++++++++++++++++++-
 migration/ram.h                     |   1 +
 migration/savevm.c                  |   1 +
 monitor/fds.c                       |  27 +-
 qapi/migration.json                 |  24 +-
 tests/qtest/migration-helpers.c     |  42 +++
 tests/qtest/migration-helpers.h     |   1 +
 tests/qtest/migration-test.c        | 303 ++++++++++++++++++-
 util/osdep.c                        |   9 +
 33 files changed, 2041 insertions(+), 172 deletions(-)
 create mode 100644 docs/devel/migration/fixed-ram.rst

-- 
2.35.3


