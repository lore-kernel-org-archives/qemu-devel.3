Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06286C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidUv-0005xq-UW; Thu, 13 Feb 2025 12:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidUu-0005x9-Bk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:36 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidUs-00065y-8y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 980A31F795;
 Thu, 13 Feb 2025 17:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=djC6rIHdadrMr4Tm7Al+qAjWiiJXFuuplbMdnpAx310=;
 b=Z1EM0nN63Y/4J8ZNPNq6LhT6V6MIhrPogDOUPqqlU8qp8t89UlIyt3m4xjZEunWMFBhnnI
 oAI9h1XgNmmcISY0M/3kzHUVZXLJaAxdCZxqYpwHai8VJpYyEWETkm6aeM584ef7TmHqFc
 wW2xaYYfYcci6vCWw5z93US9fCBGnX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=djC6rIHdadrMr4Tm7Al+qAjWiiJXFuuplbMdnpAx310=;
 b=Fnr/uJ5UV11OkrXoExWaqk0kL8mcFTbFfy8KLOcmiwnUcyxW5UN6SeMsRlr6Az0/LlI50e
 KUPwi/3X0RQjmKDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z1EM0nN6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Fnr/uJ5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=djC6rIHdadrMr4Tm7Al+qAjWiiJXFuuplbMdnpAx310=;
 b=Z1EM0nN63Y/4J8ZNPNq6LhT6V6MIhrPogDOUPqqlU8qp8t89UlIyt3m4xjZEunWMFBhnnI
 oAI9h1XgNmmcISY0M/3kzHUVZXLJaAxdCZxqYpwHai8VJpYyEWETkm6aeM584ef7TmHqFc
 wW2xaYYfYcci6vCWw5z93US9fCBGnX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=djC6rIHdadrMr4Tm7Al+qAjWiiJXFuuplbMdnpAx310=;
 b=Fnr/uJ5UV11OkrXoExWaqk0kL8mcFTbFfy8KLOcmiwnUcyxW5UN6SeMsRlr6Az0/LlI50e
 KUPwi/3X0RQjmKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 433A213874;
 Thu, 13 Feb 2025 17:59:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xmewAAIzrmfqMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 17:59:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 0/9] migration: Fix issues during qmp_migrate_cancel
Date: Thu, 13 Feb 2025 14:59:18 -0300
Message-Id: <20250213175927.19642-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 980A31F795
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

changes from v2:

Added more if != CANCELLING where it was missing. We have other work
[1] pending around migration states, so I've kept this simple for
correctness only.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1670135398

1- https://lore.kernel.org/r/20250110100707.4805-1-shivam.kumar1@nutanix.com

v2:
https://lore.kernel.org/r/20250211150136.6781-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20241202220137.32584-1-farosas@suse.de

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

Fabiano Rosas (9):
  migration: Set migration error outside of migrate_cancel
  migration: Unify migration_cancel and migrate_fd_cancel
  migration: Change migrate_fd_ to migration_
  migration: Fix hang after error in destination setup phase
  migration: Reject qmp_migrate_cancel after postcopy
  migration: Don't set FAILED state when cancelling
  tests/qtest/migration: Introduce migration_test_add_suffix
  tests/qtest/migration: Add a cancel test
  migration: Update migrate_cancel documentation

 migration/channel.c                    |   9 +-
 migration/migration.c                  |  81 +++++++-----
 migration/migration.h                  |   4 +-
 migration/multifd.c                    |   2 +-
 migration/ram.c                        |   4 +-
 migration/rdma.c                       |   2 +-
 migration/trace-events                 |   4 +-
 qapi/migration.json                    |   4 +-
 tests/qtest/migration/migration-util.c |  24 ++++
 tests/qtest/migration/migration-util.h |   2 +
 tests/qtest/migration/precopy-tests.c  | 176 +++++++++++++++++++++++++
 11 files changed, 267 insertions(+), 45 deletions(-)

-- 
2.35.3


