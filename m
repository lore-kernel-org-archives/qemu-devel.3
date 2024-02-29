Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5181C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiMl-0005TQ-RM; Thu, 29 Feb 2024 10:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMh-0005R7-9Y
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:31 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMb-0005qZ-RG
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8C361F7F6;
 Thu, 29 Feb 2024 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WeZKMKYZrEXwJ12mXttpzW480bpIspYp3MAFmFvfwwA=;
 b=YURW8xlw++RdlHW7JVXoMEAQZ0F8yz3gcFmP9G4Fe3qDwDRqPMuXx+5gvJsQ+Ytn6P2Dg7
 RXbE7xhgPIAYetVxBUzql37Gxzyy8/Bfevr9tWABKHElQFr7wIBkCOs6flciBLK+d5W1/7
 veK4vMYf4Nqx1U47gNphqIviguyFS4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WeZKMKYZrEXwJ12mXttpzW480bpIspYp3MAFmFvfwwA=;
 b=JDm7Dij4CxFAwiXIILE/gV3ulgzK5ne4S3rwxecppTJsD2himtU8KtLLvSNk7M4YquhD0l
 vXPcdF+m+1ClxUDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WeZKMKYZrEXwJ12mXttpzW480bpIspYp3MAFmFvfwwA=;
 b=BqwhZuVT1YUukGA7ZziV/Fbg8FwKVvu7goB/rUFeIB7bJHuvfAyuTZ60f4bvrqkvszVA6G
 FDsgnx5oq3DPdfdgBYtX1YYuIcvtwL4RzB7kyFVJZkfVPLIqFMLkf/3GuZXzCFTU6PQjUV
 9ocYoLs8LlP8pP6Z/JKuciifMCftYT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WeZKMKYZrEXwJ12mXttpzW480bpIspYp3MAFmFvfwwA=;
 b=tcjsj2v4CnfYPjBgPj0AISgoerkuS0ewSVCB+qgedHUCczrp2He4vUPJLtADXy3LpZnszp
 QxHtQ1DUrYNxQpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42E1C13503;
 Thu, 29 Feb 2024 15:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Yw6yAgyj4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:30:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v6 00/23] migration: File based migration with multifd and
 mapped-ram
Date: Thu, 29 Feb 2024 12:29:54 -0300
Message-Id: <20240229153017.2221-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url];
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

In this v6:

- Minor fixes to 17/23 and 19/23

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1195796010

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

v5:
https://lore.kernel.org/r/20240228152127.18769-1-farosas@suse.de
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
 migration/file.c                    | 149 +++++++++-
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
 migration/ram.c                     | 345 ++++++++++++++++++++++--
 migration/ram.h                     |   1 +
 migration/savevm.c                  |   1 +
 migration/trace-events              |   2 +-
 qapi/migration.json                 |   6 +-
 tests/qtest/migration-test.c        | 127 +++++++++
 27 files changed, 1607 insertions(+), 143 deletions(-)
 create mode 100644 docs/devel/migration/mapped-ram.rst

-- 
2.35.3


