Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCC2EB105B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxxv-0006L5-Rp; Tue, 10 Mar 2026 10:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxxt-0006KK-Of
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:21:41 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxxs-0008OF-24
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:21:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F308E4D211;
 Tue, 10 Mar 2026 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773152498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mov2GOtY37Y+X1mq8loHhu5NyTNNJoBiH5aI7dlxX5U=;
 b=HlxJx4BmGmrXBZA0wnnSo9jN4BrN51CcfAhNTNFY22+vXbp76iiOJ4W93ERtdmbcyZ9rFc
 3OtDNmosFT3HV61pW2TMBO2yvjvgYgAZRxhzF/khYwtvIUzQ4gNm6UiCxdzeE8myE1l2+3
 CcQThtndUUsn0NZLyZO0VtSeXagHK2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773152498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mov2GOtY37Y+X1mq8loHhu5NyTNNJoBiH5aI7dlxX5U=;
 b=AOFv9LjMNoqMM7pZNLE7mqHZiYFiVVAFqZb0l26EBLiiZ3HcuwZ0WJhEkoRTUKNXRXG1jU
 X9blokv5am6ylMDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773152497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mov2GOtY37Y+X1mq8loHhu5NyTNNJoBiH5aI7dlxX5U=;
 b=dxq1tJ8uMowCr0aLuv0MgUyT0PJZz0/YYfeCXDktUUVhnOH5yrAw/hADCy8tDujSe/dVmT
 wNNCMv8QTbj3oYuboCikR7Av2r20vBBcDz6gMi/F7deA0lje4Pq6MOxmrroMS1K5xsKPmT
 rK1GfTv8pZ3CKMC80JlDL2JeagnAl/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773152497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mov2GOtY37Y+X1mq8loHhu5NyTNNJoBiH5aI7dlxX5U=;
 b=GafK3lf7CH/WydAfZ24+bspIUwJyx1YnTkdSAuE6/J51RdltVy0wYygzNJdImC+yYHq2l/
 DPcjJgo1Vouzd3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDB633F4CD;
 Tue, 10 Mar 2026 14:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D7evJPAosGnYDgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 14:21:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/8] migration-test: Plumbing
Date: Tue, 10 Mar 2026 11:21:34 -0300
Message-ID: <20260310142134.15137-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix leaks. A couple of normal ones and a few that happen due to a test
expecting failure in the destination side, but exit-on-error=true so
the coroutine just exits the entire process while a few resources are
still allocated, but outside of the scope of the migration code.

I brought a couple of cleanup patches from another in-flight series to
be able to force-set exit-on-error=false for the tests that are
causing leaks, that way we don't need to complicate the migration
cleanup code trying to reach into other subsystems to free memory when
QEMU is already exiting.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2375586934

--enable-asan --enable-ubsan build is clean for x86_64 migration-test --full

Fabiano Rosas (8):
  tests/qtest/migration: Fix leak of migration tests data
  tests/qtest/migration: Change validate_uuid test to not trigger
    exit(1)
  tests/qtest/migration: Fix misuse of listen_uri
  tests/qtest/migration: Stop invoking migrate_incoming from hooks
  tests/qtest/migration: Force exit-on-error=false when appropriate
  io: Fix TLS bye task leak
  tests/qtest/migration: Fix leak in CPR exec test
  migration/multifd: Fix leaks of TLS error objects

 io/channel-tls.c                          |  4 ++-
 migration/migration.c                     |  5 +++
 migration/multifd.c                       | 27 +++++++--------
 tests/qtest/migration/colo-tests.c        |  8 ++++-
 tests/qtest/migration/compression-tests.c | 18 ++++++----
 tests/qtest/migration/cpr-tests.c         | 25 +++++++++-----
 tests/qtest/migration/file-tests.c        | 41 ++++++++++++++++-------
 tests/qtest/migration/framework.c         | 31 ++++++++++++-----
 tests/qtest/migration/framework.h         |  7 ++++
 tests/qtest/migration/migration-util.c    | 19 ++++++++---
 tests/qtest/migration/migration-util.h    |  2 +-
 tests/qtest/migration/misc-tests.c        |  8 ++---
 tests/qtest/migration/precopy-tests.c     | 21 +++++++-----
 tests/qtest/migration/tls-tests.c         | 30 +++++++++++------
 14 files changed, 165 insertions(+), 81 deletions(-)

-- 
2.51.0


