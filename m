Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F0DE69E98
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 22:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEUG-00074e-HT; Mon, 02 Dec 2024 17:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUD-00074N-W8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:46 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUC-0003bt-12
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C5731F387;
 Mon,  2 Dec 2024 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EAKjftp9QoRrRhCJXLtG9A8H/lIiGCTCD/KCQqYaAHk=;
 b=ajpk6Qp9uvWSRfQMgjLzZdPIrimlk4yhtWvKzDdiGauyFpzXn3N/HEHUmkr05pS2ZWyHeq
 FAJE37zJIM/KNGatFD4HNC1K/7X4kuaaJpRTCX2DKdlEGhp8Sfmq3OqW3SARYEoGdtBDDb
 TJ6Dly68N8Pw+0j7kBr1GO4y1HpPiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EAKjftp9QoRrRhCJXLtG9A8H/lIiGCTCD/KCQqYaAHk=;
 b=hipxMziYuYBgQwTt5cSrMUcTSj2pmwdtmodeTtLSgx5e9hhyEAru4Q7Oek9bWvSeQ80MtK
 +NUIS3opXp2bv6AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ajpk6Qp9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hipxMziY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EAKjftp9QoRrRhCJXLtG9A8H/lIiGCTCD/KCQqYaAHk=;
 b=ajpk6Qp9uvWSRfQMgjLzZdPIrimlk4yhtWvKzDdiGauyFpzXn3N/HEHUmkr05pS2ZWyHeq
 FAJE37zJIM/KNGatFD4HNC1K/7X4kuaaJpRTCX2DKdlEGhp8Sfmq3OqW3SARYEoGdtBDDb
 TJ6Dly68N8Pw+0j7kBr1GO4y1HpPiN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EAKjftp9QoRrRhCJXLtG9A8H/lIiGCTCD/KCQqYaAHk=;
 b=hipxMziYuYBgQwTt5cSrMUcTSj2pmwdtmodeTtLSgx5e9hhyEAru4Q7Oek9bWvSeQ80MtK
 +NUIS3opXp2bv6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D60BB13A31;
 Mon,  2 Dec 2024 22:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t6+QJkQuTmdlIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Dec 2024 22:01:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/6] migration: Fix issues during qmp_migrate_cancel
Date: Mon,  2 Dec 2024 19:01:31 -0300
Message-Id: <20241202220137.32584-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C5731F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

While working on downstream issues with postcopy, I ended up writing a
set of tests for issuing qmp_migrate_cancel() at various points during
the migration. That exposed some bugs, which this series attempts to
fix.

There is also a fix for the issue Daniel found:

https://gitlab.com/qemu-project/qemu/-/issues/2633

I'm also sending the test code. It creates one test per
MIGRATION_STATUS_ state. Each test starts a migration, waits for that
specific state to be reached, issues qmp_migrate_cancel() and checks
that the migration state changes to cancelled (for now only cancelling
migration from the source side).

I was initially worried that this would be too racy, but so far each
test has survived 1000 iterations. I'm thinking it's worth merging,
specially because even after working on this I haven't been able to
clear the questions we have in our todo list [1], so we'll probably
need more work around this area in the future.

1- https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1569870481

Thanks

Fabiano Rosas (6):
  tests/qtest/migration: Introduce migration_test_add_suffix
  migration: Kick postcopy threads on cancel
  migration: Fix postcopy listen thread exit
  migration: Make sure postcopy recovery doesn't hang when cancelling
  migration: Fix hang after error in destination setup phase
  tests/qtest/migration: Add a cancel test

 migration/channel.c             |  11 +-
 migration/migration.c           |  58 +++++---
 migration/migration.h           |   2 +-
 migration/postcopy-ram.c        |  14 +-
 migration/savevm.c              |  60 ++++----
 tests/qtest/migration-helpers.c |  24 ++++
 tests/qtest/migration-helpers.h |   2 +
 tests/qtest/migration-test.c    | 243 ++++++++++++++++++++++++++++++++
 8 files changed, 365 insertions(+), 49 deletions(-)

-- 
2.35.3


