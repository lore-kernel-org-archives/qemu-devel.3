Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E1FC02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZSq-0000dl-C0; Thu, 30 Jan 2025 13:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdZSi-0000dC-LU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:40:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdZSg-0004sk-P9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:40:24 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11BAE2116E;
 Thu, 30 Jan 2025 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738262417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CQeMi9DG1q5QczzwlO2Ru7VhAvBgHP2PhzoZRUAsnf0=;
 b=mAynpwgSFbS6vgENkqSqRuQy+lVh4XUDT46GPQHLzF+B1grMjvobbXCTL+EfdFNBb/OFYG
 BWt2mD0+t9keipWt83iqcyeEFMBup7l4uX9Eno1HwSp6HshIUNpJEvlkA9qGP6Bu9plYbA
 QsyCkUrkrJC6eqwnl/QvDibXNhYE7kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738262417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CQeMi9DG1q5QczzwlO2Ru7VhAvBgHP2PhzoZRUAsnf0=;
 b=g5gtsh/q5GUaBettHe4+Zh/VzfqR29n0C8yFrVZDhb2xbt08dzsLWMyWaYNWbYWQMGepj9
 kJVUXSOEgYlTEIBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mAynpwgS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="g5gtsh/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738262417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CQeMi9DG1q5QczzwlO2Ru7VhAvBgHP2PhzoZRUAsnf0=;
 b=mAynpwgSFbS6vgENkqSqRuQy+lVh4XUDT46GPQHLzF+B1grMjvobbXCTL+EfdFNBb/OFYG
 BWt2mD0+t9keipWt83iqcyeEFMBup7l4uX9Eno1HwSp6HshIUNpJEvlkA9qGP6Bu9plYbA
 QsyCkUrkrJC6eqwnl/QvDibXNhYE7kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738262417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CQeMi9DG1q5QczzwlO2Ru7VhAvBgHP2PhzoZRUAsnf0=;
 b=g5gtsh/q5GUaBettHe4+Zh/VzfqR29n0C8yFrVZDhb2xbt08dzsLWMyWaYNWbYWQMGepj9
 kJVUXSOEgYlTEIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C54D1364B;
 Thu, 30 Jan 2025 18:40:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id plTJNo7Hm2d2OwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Jan 2025 18:40:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] migration: Reduce migration-test time for non-KVM archs
Date: Thu, 30 Jan 2025 15:40:10 -0300
Message-Id: <20250130184012.5711-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 11BAE2116E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi, continuing the work from the previous[1] series to reduce the time
migration-test takes during make check, here's a couple of patches to
create a smaller set of tests.

The change is that from now on, ./migration-test will only run a
limited set of tests (~12), while the full set (64) requires that the
--full flag is passed on. Only those calling the test manually need to
care about this new flag.

For everyone else, qtest/meson.build will automatically add --full in
case KVM is available for the target architecture. All other
architectures run the small set.

The choice of tests for the small set has been arbitrarily made in
patch 2. I expect that once we close in on a list of tests, new tests
will only be added under the --full flag and the small set will be
kept stable.

An unwritten but maybe obvious rule is that slow or flaky tests should
not be added to the small set and once detected should be moved to the
full set.

More details in patch 1.

Thanks!

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1647478788
1- https://lore.kernel.org/r/20241113194630.3385-1-farosas@suse.de

Fabiano Rosas (2):
  tests/qtest/migration: Add --full option
  tests/qtest/migration: Pick smoke tests

 tests/qtest/meson.build                   | 11 +++++++++-
 tests/qtest/migration-test.c              | 25 +++++++++++++++++++++++
 tests/qtest/migration/compression-tests.c | 15 +++++++++++---
 tests/qtest/migration/cpr-tests.c         |  6 ++++++
 tests/qtest/migration/file-tests.c        | 21 +++++++++++++------
 tests/qtest/migration/framework.h         |  1 +
 tests/qtest/migration/misc-tests.c        | 16 ++++++++++++---
 tests/qtest/migration/postcopy-tests.c    | 14 ++++++++++++-
 tests/qtest/migration/precopy-tests.c     | 23 ++++++++++++++-------
 tests/qtest/migration/tls-tests.c         | 14 +++++++++++--
 10 files changed, 123 insertions(+), 23 deletions(-)

-- 
2.35.3


