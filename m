Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F42C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LPI-0002vq-J0; Fri, 26 Apr 2024 09:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0LP9-0002uS-Nn
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:14:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0LP5-0001aR-LC
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:14:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5655720D01;
 Fri, 26 Apr 2024 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714137252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dxP8VQoO4C/ZshN9u4XPArJS2jJZ+F8zqTYo+Ma8UM0=;
 b=p6cYobXfjS2sJGQVdb0/r/niiSTdNthzNNUKT2lIYMxbzgUUU++0G9lSvl7haN2FO1Oqm+
 UhU82wy7j1QUcVp3/pPifUwZJFt5eW/4S2Y/VPOL8Si5RT/ISFlhlJ0/LSVohFSGeOxCvh
 Q3HikFJUX1d3Gisax1ulJZh9wBch9W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714137252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dxP8VQoO4C/ZshN9u4XPArJS2jJZ+F8zqTYo+Ma8UM0=;
 b=g5VoBzPxR52lmTvBjw0Ik9w8+gVaNm9+Yd5xZh7cT0rtcL/heWexi2jm+BPKG5uPcpWLK7
 Tn/s7mdBZpka5TBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714137252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dxP8VQoO4C/ZshN9u4XPArJS2jJZ+F8zqTYo+Ma8UM0=;
 b=p6cYobXfjS2sJGQVdb0/r/niiSTdNthzNNUKT2lIYMxbzgUUU++0G9lSvl7haN2FO1Oqm+
 UhU82wy7j1QUcVp3/pPifUwZJFt5eW/4S2Y/VPOL8Si5RT/ISFlhlJ0/LSVohFSGeOxCvh
 Q3HikFJUX1d3Gisax1ulJZh9wBch9W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714137252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dxP8VQoO4C/ZshN9u4XPArJS2jJZ+F8zqTYo+Ma8UM0=;
 b=g5VoBzPxR52lmTvBjw0Ik9w8+gVaNm9+Yd5xZh7cT0rtcL/heWexi2jm+BPKG5uPcpWLK7
 Tn/s7mdBZpka5TBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBA711398B;
 Fri, 26 Apr 2024 13:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id da9uK6KoK2bcXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 13:14:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org
Subject: [PATCH v2 0/6] migration removals & deprecations
Date: Fri, 26 Apr 2024 10:14:02 -0300
Message-Id: <20240426131408.25410-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

[respinning because master moved and there were conflicts]

Hi everyone,

Here's some cleaning up of deprecated code. It removes the old block
migration and compression code. Both have suitable replacements in the
form of the blockdev-mirror driver and multifd compression,
respectively.

There's also a deprecation for fd: + file to cope with the fact that
the new MigrationAddress API defines transports instead of protocols
(loose terms) like the old string API did. So we cannot map 1:1 from
fd: to any transport because fd: allows *both* file migration and
socket migration.

v1:
https://lore.kernel.org/r/20240425150939.19268-1-farosas@suse.de

Fabiano Rosas (6):
  migration: Remove 'skipped' field from MigrationStats
  migration: Remove 'inc' option from migrate command
  migration: Remove 'blk/-b' option from migrate commands
  migration: Remove block migration
  migration: Remove non-multifd compression
  migration: Deprecate fd: for file migration

 .gitlab-ci.d/buildtest.yml       |    2 +-
 MAINTAINERS                      |    1 -
 docs/about/deprecated.rst        |   51 +-
 docs/about/removed-features.rst  |  103 +++
 docs/devel/migration/main.rst    |    2 +-
 hw/core/machine.c                |    1 -
 include/migration/misc.h         |    6 -
 meson.build                      |    2 -
 meson_options.txt                |    2 -
 migration/block.c                | 1019 ------------------------------
 migration/block.h                |   52 --
 migration/colo.c                 |    1 -
 migration/meson.build            |    4 -
 migration/migration-hmp-cmds.c   |   97 +--
 migration/migration.c            |   70 +-
 migration/migration.h            |    7 -
 migration/options.c              |  229 -------
 migration/ram-compress.c         |  564 -----------------
 migration/ram.c                  |  166 +----
 migration/savevm.c               |    5 -
 qapi/migration.json              |  205 +-----
 scripts/meson-buildoptions.sh    |    4 -
 tests/qemu-iotests/183           |  147 -----
 tests/qemu-iotests/183.out       |   66 --
 tests/qemu-iotests/common.filter |    7 -
 tests/qtest/migration-test.c     |  139 ----
 26 files changed, 130 insertions(+), 2822 deletions(-)
 delete mode 100644 migration/block.c
 delete mode 100644 migration/block.h
 delete mode 100644 migration/ram-compress.c
 delete mode 100755 tests/qemu-iotests/183
 delete mode 100644 tests/qemu-iotests/183.out


base-commit: a118c4aff4087eafb68f7132b233ad548cf16376
-- 
2.35.3


