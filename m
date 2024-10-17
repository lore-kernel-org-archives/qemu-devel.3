Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99352D374A0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RY9-0005Nc-45; Thu, 17 Oct 2024 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY6-0005N1-Qf
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:22 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY2-0003sS-Qk
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 578C31FD33;
 Thu, 17 Oct 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VGscQbkJKXwvSxhBXD+jrauxB3LvLeBk0WUJAUqrND4=;
 b=AEAynrvyu6143Px2ljTPJD+wlWpJG3jS8YUkbXNqOi4chgGehktd3gYmTPJ5tFogHYMSMK
 Ze6Lrzyi5oiL3OHH4Cw9iQcaO4NlJsek9zJWfbSMLvK7sDoa6V5IfDCq2r+ag0Gfn/CJfq
 EevmLVSADTtKHC1Nu1+vImZC+Ucm3ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VGscQbkJKXwvSxhBXD+jrauxB3LvLeBk0WUJAUqrND4=;
 b=3C50auJNYcAM6f4d7euO1CzNQ9ZdUJ8t42/rcl4+tyjdGCVuweKdHIGl1MHu2zVH/T0AO4
 ktW9jO7W0ds8XSBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VGscQbkJKXwvSxhBXD+jrauxB3LvLeBk0WUJAUqrND4=;
 b=AEAynrvyu6143Px2ljTPJD+wlWpJG3jS8YUkbXNqOi4chgGehktd3gYmTPJ5tFogHYMSMK
 Ze6Lrzyi5oiL3OHH4Cw9iQcaO4NlJsek9zJWfbSMLvK7sDoa6V5IfDCq2r+ag0Gfn/CJfq
 EevmLVSADTtKHC1Nu1+vImZC+Ucm3ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VGscQbkJKXwvSxhBXD+jrauxB3LvLeBk0WUJAUqrND4=;
 b=3C50auJNYcAM6f4d7euO1CzNQ9ZdUJ8t42/rcl4+tyjdGCVuweKdHIGl1MHu2zVH/T0AO4
 ktW9jO7W0ds8XSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3258B13A42;
 Thu, 17 Oct 2024 14:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EXosOu0fEWcDKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 14:32:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/4] tests/qtest: Move the bulk of migration tests into a
 separate target
Date: Thu, 17 Oct 2024 11:32:07 -0300
Message-Id: <20241017143211.17771-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

As promised, here are the changes to move most of the migration tests
into a separate check-migration target that is intended to be used by
migration maintainers and contributors.

A few tests will still be kept in another check-migration-quick
target, that will run as part of make check by default. Those are
there to catch changes in generic code that might affect migration and
the rare device code change that affects migration ("rare" because
migration-test runs with only default devices).

The are two main reasons for this:

- Reduce the time of the common 'make check' invocation.

  migration-test is notoriously wasteful in that it runs a migration
  for every test. We don't yet have a comprehensive coverage analysis
  nor the mechanisms for testing isolated parts of the code without
  resorting to a full migration.

  While the migration tests don't account for that much of make check
  time in a parallel run (only about 30s, see table below), I'd like
  to be able to write tests without encumbering every single make
  check run.

- Avoid breaking a developer's make check invocation and also CI when
  only non-migration changes are present.

  The migration tests are subject to races in the code that tend to be
  quite intermittent. Ideally, if a code change does not touch
  migration, it should not break migration-test.

make -j16                   before     after      migration suite included
--------------------------------------------------------------------------
check                       2m28.923s  1m56.178s  migration-quick
check SPEED=slow            6m07.854s  5m59.982s  migration
check SPEED=thorough       10m17.102s 10m02.416s  migration
check-qtest                 2m07.827s  1m24.065s  none
check-qtest SPEED=slow      5m06.149s  4m17.897s  none
check-qtest SPEED=thorough  5m7.601s   4m18.135s  none
check-migration                        3m41.927s  migration
check-migration-quick                  0m15.592s  migration-quick
--------------------------------------------------------------------------

Note that this series could very well be just patch 3 without any new
target, but then to be able to run the full set of migration tests
we'd need to also run all other slow tests from a set, either check or
check-qtest and that would add at least 2 minutest to the migration
run.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1499208871

Fabiano Rosas (4):
  tests/qtest: Add check-migration
  docs: Add migration tests documentation
  tests/qtest/migration: Move tests into g_test_slow()
  ci: Add check-migration-quick to the clang job

 .gitlab-ci.d/buildtest.yml       |   2 +-
 docs/devel/testing/index.rst     |   1 +
 docs/devel/testing/main.rst      |  13 ++
 docs/devel/testing/migration.rst | 275 +++++++++++++++++++++++++++++++
 docs/devel/testing/qtest.rst     |   1 +
 meson.build                      |   6 +-
 tests/Makefile.include           |   2 +
 tests/qtest/meson.build          |  47 +++++-
 tests/qtest/migration-helpers.c  |   9 +
 tests/qtest/migration-helpers.h  |  16 ++
 tests/qtest/migration-test.c     |  67 ++++----
 11 files changed, 392 insertions(+), 47 deletions(-)
 create mode 100644 docs/devel/testing/migration.rst


base-commit: 05adb38839ba656c7383a548b460d95c91e2febe
-- 
2.35.3


