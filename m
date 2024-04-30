Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE4BC19F53
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oT0-0007Az-MH; Tue, 30 Apr 2024 10:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oSw-0007Ac-E4
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1oSs-0000AA-KA
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:28:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 036E11F7D2;
 Tue, 30 Apr 2024 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9t27U8Bm4PpH+Pcb/zMQs/WMNnFsKccJ6LBxoVF685U=;
 b=NaudfsA5bdZ9/PO+MkeIU4yKDRVSJyDfD+j5Qlbbi4tlq2hlw9fntoFO2lWYP5lP4EP7Py
 4Djef4xRzeFbFq347eA1Cg/cho7h3sRQVb3b/xC8YR2GWe6J0KW4Za64aTsayxHsTmhI3I
 Z0DaenMjRxK3JqHE/37MqR1v29vUJP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9t27U8Bm4PpH+Pcb/zMQs/WMNnFsKccJ6LBxoVF685U=;
 b=CJGg0saL1a64lfXY6BlhG6eyeTaJqop8LZie/eEInAtoE/OPBYOGBRBcfHmpXbr71CqbMy
 yVtABfOe1V4rhiDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NaudfsA5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CJGg0saL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714487293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9t27U8Bm4PpH+Pcb/zMQs/WMNnFsKccJ6LBxoVF685U=;
 b=NaudfsA5bdZ9/PO+MkeIU4yKDRVSJyDfD+j5Qlbbi4tlq2hlw9fntoFO2lWYP5lP4EP7Py
 4Djef4xRzeFbFq347eA1Cg/cho7h3sRQVb3b/xC8YR2GWe6J0KW4Za64aTsayxHsTmhI3I
 Z0DaenMjRxK3JqHE/37MqR1v29vUJP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714487293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9t27U8Bm4PpH+Pcb/zMQs/WMNnFsKccJ6LBxoVF685U=;
 b=CJGg0saL1a64lfXY6BlhG6eyeTaJqop8LZie/eEInAtoE/OPBYOGBRBcfHmpXbr71CqbMy
 yVtABfOe1V4rhiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99B0F133A7;
 Tue, 30 Apr 2024 14:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LEbWF/v/MGZjSQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Apr 2024 14:28:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org
Subject: [PATCH v3 0/6] migration removals & deprecations
Date: Tue, 30 Apr 2024 11:27:31 -0300
Message-Id: <20240430142737.29066-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 036E11F7D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
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

since v2:

- removed some more stuff which I missed:
   blk/inc options from hmp-commands.hx
   the entire ram-compress.h
   unused declarations from options.h
   unused compression functions from qemu-file.c

- removed must_remove_block_options earlier in the 'blk' patch

- added a deprecation warning to outgoing/incoming fd

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1272385260

v2:
https://lore.kernel.org/r/20240426131408.25410-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20240425150939.19268-1-farosas@suse.de

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
 hmp-commands.hx                  |   17 +-
 hw/core/machine.c                |    1 -
 include/migration/misc.h         |    6 -
 meson.build                      |    2 -
 meson_options.txt                |    2 -
 migration/block.c                | 1019 ------------------------------
 migration/block.h                |   52 --
 migration/colo.c                 |    1 -
 migration/fd.c                   |   12 +
 migration/meson.build            |    4 -
 migration/migration-hmp-cmds.c   |   97 +--
 migration/migration.c            |   70 +-
 migration/migration.h            |   11 -
 migration/options.c              |  229 -------
 migration/options.h              |   13 -
 migration/qemu-file.c            |   78 ---
 migration/qemu-file.h            |    4 -
 migration/ram-compress.c         |  564 -----------------
 migration/ram-compress.h         |   77 ---
 migration/ram.c                  |  169 +----
 migration/savevm.c               |    5 -
 qapi/migration.json              |  205 +-----
 scripts/meson-buildoptions.sh    |    4 -
 tests/qemu-iotests/183           |  147 -----
 tests/qemu-iotests/183.out       |   66 --
 tests/qemu-iotests/common.filter |    7 -
 tests/qtest/migration-test.c     |  139 ----
 32 files changed, 147 insertions(+), 3013 deletions(-)
 delete mode 100644 migration/block.c
 delete mode 100644 migration/block.h
 delete mode 100644 migration/ram-compress.c
 delete mode 100644 migration/ram-compress.h
 delete mode 100755 tests/qemu-iotests/183
 delete mode 100644 tests/qemu-iotests/183.out


base-commit: fd87be1dada5672f877e03c2ca8504458292c479
-- 
2.35.3


