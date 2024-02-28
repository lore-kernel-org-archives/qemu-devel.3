Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10862C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLkd-0006Vg-1w; Wed, 28 Feb 2024 10:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkb-0006Ub-Gx
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:41 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkW-0004dB-Je
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F0501F7FF;
 Wed, 28 Feb 2024 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8E7OZPyDHfMUrdHGQ8jBjHK2TWBb5gKj62dzTtWUri8=;
 b=o1r1jOwav6b+ZA+hnQ+NovLxkI6OD0R9IzQLh3roSgblCrnc1ks6OgUR+S0tgYdTnjWCis
 9NKWuG/TDqVvhuq8Wq1uP4Z07TyBUHWbIDrBEKwXLAXabV7+WK9dA3YxP3n4fMNXNwPoN2
 a7WjgRAB/E7QKPoPDAT2eYVYHVxlMdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8E7OZPyDHfMUrdHGQ8jBjHK2TWBb5gKj62dzTtWUri8=;
 b=VGKbiDvk1GMvV6Dp7WhzEksPlMQ2gqgQr5qFRlfZhduwZX7XGA82bxHXi9RxxExkgpfWO1
 fjdxseZKDcr4+nBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8E7OZPyDHfMUrdHGQ8jBjHK2TWBb5gKj62dzTtWUri8=;
 b=o1r1jOwav6b+ZA+hnQ+NovLxkI6OD0R9IzQLh3roSgblCrnc1ks6OgUR+S0tgYdTnjWCis
 9NKWuG/TDqVvhuq8Wq1uP4Z07TyBUHWbIDrBEKwXLAXabV7+WK9dA3YxP3n4fMNXNwPoN2
 a7WjgRAB/E7QKPoPDAT2eYVYHVxlMdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8E7OZPyDHfMUrdHGQ8jBjHK2TWBb5gKj62dzTtWUri8=;
 b=VGKbiDvk1GMvV6Dp7WhzEksPlMQ2gqgQr5qFRlfZhduwZX7XGA82bxHXi9RxxExkgpfWO1
 fjdxseZKDcr4+nBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE8A13A5D;
 Wed, 28 Feb 2024 15:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rwE1GXpP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:21:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 00/23] migration: File based migration with multifd and
 mapped-ram
Date: Wed, 28 Feb 2024 12:21:04 -0300
Message-Id: <20240228152127.18769-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
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

Based-on: 74aa0fb297 (migration: options incompatible with cpr) # peterx/migration-next

Hi,

In this v5:

- Rebased on migration-next;

- Renamed the feature to mapped-ram;

- Reworked recv_sync logic to only sync at RAM_SAVE_FLAG_MEM_SIZE and
  ignore/avoid all other RAM_FLAGS;

- Fixed and documented barriers at multifd_recv/multifd_recv_thread;

- Duplicated fds passed to multifd to avoid cross-channel effects;

- Dropped the direct-io and fdset patches. Will send them in a
  separate series.

The rest are minor changes, I have noted them in the patches
themselves.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1194172845

Series structure
================

This series enables mapped-ram in steps:

0) Cleanups                           [1]
1) QIOChannel interfaces              [2-6]
2) Mapped-ram format for precopy      [7-11]
3) Multifd adaptation without packets [12-15]
4) Mapped-ram format for multifd      [16-23]

* below will be sent separately *
5) Direct-io generic support          [TODO]
6) Direct-io for mapped-ram multifd with file: URI  [TODO]
7) Fdset interface for mapped-ram multifd  [TODO]

About mapped-ram
================

Mapped-ram is a new stream format for the RAM section designed to
supplement the existing ``file:`` migration and make it compatible
with ``multifd``. This enables parallel migration of a guest's RAM to
a file.

The core of the feature is to map RAM pages to migration file
offsets. This enables the ``multifd`` threads to write exclusively to
those offsets even if the guest is constantly dirtying pages
(i.e. live migration).

Another benefit is that the resulting file will have a bounded size,
since pages which are dirtied multiple times will always go to a fixed
location in the file, rather than constantly being added to a
sequential stream.

Having the pages at fixed offsets also allows the usage of O_DIRECT
for save/restore of the migration stream as the pages are ensured to
be written respecting O_DIRECT alignment restrictions.

Latest numbers (unchanged from v4)
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
mapped-ram         |    157975    216877   6672    834
  + multifd 8 ch.  |     95922    292178  10982   1372
     + direct-io   |     23268   1936897  45330   5666
-------------------------------------------------------

live               | time (ms)   pages/s   mb/s   MB/s
-------------------+-----------------------------------
file               |         -         -      -      - (file grew 4x the VM size)
  + bg-snapshot    |    357635    141747   2974    371
-------------------+-----------------------------------
mapped-ram         |         -         -      -      - (no convergence in 5 min)
  + multifd 8 ch.  |    230812    497551  14900   1862
     + direct-io   |     27475   1788025  46736   5842
-------------------------------------------------------

v4:
https://lore.kernel.org/r/20240220224138.24759-1-farosas@suse.de
v3:
https://lore.kernel.org/r/20231127202612.23012-1-farosas@suse.de
v2:
https://lore.kernel.org/r/20231023203608.26370-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20230330180336.2791-1-farosas@suse.de

Fabiano Rosas (20):
  migration/multifd: Cleanup multifd_recv_sync_main
  io: fsync before closing a file channel
  migration/qemu-file: add utility methods for working with seekable
    channels
  migration/ram: Introduce 'mapped-ram' migration capability
  migration: Add mapped-ram URI compatibility check
  migration/ram: Add outgoing 'mapped-ram' migration
  migration/ram: Add incoming 'mapped-ram' migration
  tests/qtest/migration: Add tests for mapped-ram file-based migration
  migration/multifd: Rename MultiFDSend|RecvParams::data to
    compress_data
  migration/multifd: Decouple recv method from pages
  migration/multifd: Allow multifd without packets
  migration/multifd: Allow receiving pages without packets
  migration/multifd: Add a wrapper for channels_created
  migration/multifd: Add outgoing QIOChannelFile support
  migration/multifd: Add incoming QIOChannelFile support
  migration/multifd: Prepare multifd sync for mapped-ram migration
  migration/multifd: Support outgoing mapped-ram stream format
  migration/multifd: Support incoming mapped-ram stream format
  migration/multifd: Add mapped-ram support to fd: URI
  tests/qtest/migration: Add a multifd + mapped-ram migration test

Nikolay Borisov (3):
  io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE for channel file
  io: Add generic pwritev/preadv interface
  io: implement io_pwritev/preadv for QIOChannelFile

 docs/devel/migration/features.rst   |   1 +
 docs/devel/migration/mapped-ram.rst | 138 ++++++++++
 include/exec/ramblock.h             |  13 +
 include/io/channel.h                |  83 ++++++
 include/migration/qemu-file-types.h |   2 +
 include/qemu/bitops.h               |  13 +
 io/channel-file.c                   |  69 +++++
 io/channel.c                        |  58 ++++
 migration/fd.c                      |  44 +++
 migration/fd.h                      |   2 +
 migration/file.c                    | 153 ++++++++++-
 migration/file.h                    |   8 +
 migration/migration.c               |  56 +++-
 migration/multifd-zlib.c            |  26 +-
 migration/multifd-zstd.c            |  26 +-
 migration/multifd.c                 | 405 ++++++++++++++++++++++------
 migration/multifd.h                 |  27 +-
 migration/options.c                 |  35 +++
 migration/options.h                 |   1 +
 migration/qemu-file.c               | 106 ++++++++
 migration/qemu-file.h               |   6 +
 migration/ram.c                     | 333 +++++++++++++++++++++--
 migration/ram.h                     |   1 +
 migration/savevm.c                  |   1 +
 migration/trace-events              |   2 +-
 qapi/migration.json                 |   6 +-
 tests/qtest/migration-test.c        | 127 +++++++++
 27 files changed, 1600 insertions(+), 142 deletions(-)
 create mode 100644 docs/devel/migration/mapped-ram.rst

-- 
2.35.3


