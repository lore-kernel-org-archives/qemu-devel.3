Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A32D58D50
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaMK-0007VI-Al; Mon, 25 Nov 2024 09:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaM8-0007TT-WC; Mon, 25 Nov 2024 09:46:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaM7-00049f-4w; Mon, 25 Nov 2024 09:46:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27C2A21120;
 Mon, 25 Nov 2024 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nfqTv5yZCwaMCCt+pl/hg4x9hoLbaUHGBav8PnHqvg=;
 b=F6TFNx/0qJBHYrRE7cRgN0aVsovHnGXuQsjEi5E9YQvlP4r0pT8I3VZFXPbds9CTArA3Dh
 d7yAjBpP8vUB3p0g40tDMU78c3S4+ZsYqrWQns43X8V1J8CeE3Xu0Fa9xsCd8uZmTLbCBU
 VelMRqi2eZV8P97ecKy8CaNyHG/tDUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nfqTv5yZCwaMCCt+pl/hg4x9hoLbaUHGBav8PnHqvg=;
 b=HZAzH8FSP33VMgoC+4V4Xe2hjwhhfvQKZ81joAR9XCLjyNIAdEbVnyZrpgLYaSdlAaQMy9
 9NHNiGFienXaVvBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="F6TFNx/0";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HZAzH8FS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nfqTv5yZCwaMCCt+pl/hg4x9hoLbaUHGBav8PnHqvg=;
 b=F6TFNx/0qJBHYrRE7cRgN0aVsovHnGXuQsjEi5E9YQvlP4r0pT8I3VZFXPbds9CTArA3Dh
 d7yAjBpP8vUB3p0g40tDMU78c3S4+ZsYqrWQns43X8V1J8CeE3Xu0Fa9xsCd8uZmTLbCBU
 VelMRqi2eZV8P97ecKy8CaNyHG/tDUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0nfqTv5yZCwaMCCt+pl/hg4x9hoLbaUHGBav8PnHqvg=;
 b=HZAzH8FSP33VMgoC+4V4Xe2hjwhhfvQKZ81joAR9XCLjyNIAdEbVnyZrpgLYaSdlAaQMy9
 9NHNiGFienXaVvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1331F137D4;
 Mon, 25 Nov 2024 14:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id APmfMreNRGdRTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 14:46:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/5] migration: Fix the BDRV_O_INACTIVE assertion
Date: Mon, 25 Nov 2024 11:46:07 -0300
Message-Id: <20241125144612.16194-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 27C2A21120
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

At this point everyone is probably familiar with the assertion:

  bdrv_inactivate_recurse: Assertion `!(bs->open_flags &
  BDRV_O_INACTIVE)' failed.

The issue is that at the end of migration, the block layer is
deactivated to release the locks on the disks so that in a shared
storage scenario the migration destination can take over. Trying to
deactivate twice leads to the above assertion.

The reason deactivation is happening twice is due to the migration
capability "late-block-activate", which delays activation until the
destination VM receives a qmp_cont command. The reasoning for that cap
is:

    Activating the block devices causes the locks to be taken on
    the backing file.  If we're running with -S and the destination libvirt
    hasn't started the destination with 'cont', it's expecting the locks are
    still untaken.

    Don't activate the block devices if we're not going to autostart the VM;
    'cont' already will do that anyway.   This change is tied to the new
    migration capability 'late-block-activate' that defaults to off, keeping
    the old behaviour by default.

    bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854

However, the expected qmp_cont command never happens, because the user
may never decide to continue the VM and instead attempt another
migration while the VM is paused.

Fix this by assuming that the qmp_migrate command having been issued
is enough indication that it is now ok to take the locks again
(similarly to qmp_cont) and call bdrv_activate_all() at that
moment. This is the least invasive fix that won't require us to add
new qmp commands and go change libvirt, etc.

I'm also copying the block list (for obvious reasons, but also)
because Vladimir pointed out that asserts of this kind might not only
happen during migration. I know of at least
bdrv_co_write_req_prepare() which will assert if reached when a guest
is paused after a migration that used late-block-activate.

Patches 1-3 are just shuffling code;

Patch 4 is the fix;

Patch 5 is the test. To reproduce the issue revert patch 4 and run:

QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p \
/x86_64/migration/precopy/ping-pong/late-block-activate

References:
https://gitlab.com/qemu-project/qemu/-/issues/686
https://gitlab.com/qemu-project/qemu/-/issues/2395
https://lore.kernel.org/r/20240924125611.664315-1-andrey.drobyshev@virtuozzo.com

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1556902330

Fabiano Rosas (5):
  tests/qtest/migration: Move more code under only_target
  tests/qtest/migration: Don't use hardcoded strings for -serial
  tests/qtest/migration: Support cleaning up only one side of migration
  migration: Activate block devices if VM is paused when migrating
  tests/qtest/migration: Test successive migrations

 migration/migration.c           |  19 +++
 tests/qtest/migration-helpers.c |   8 +
 tests/qtest/migration-helpers.h |   2 +
 tests/qtest/migration-test.c    | 252 +++++++++++++++++++++++++-------
 4 files changed, 226 insertions(+), 55 deletions(-)


base-commit: 134b443512825bed401b6e141447b8cdc22d2efe
-- 
2.35.3


