Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E26CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44n4-0001R3-8h; Wed, 01 Oct 2025 17:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44mn-0001Hp-N6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:54:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44mY-0005p9-Pd
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:54:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E9C51F808;
 Wed,  1 Oct 2025 21:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hKSN8hGmZUHb7kr6m9FqH/JXx7Hi67L7PJwnl68BBLA=;
 b=Ncrg0KbmaCs+mgRRGWmAsvrrgIsxhRNgyYeenH9iAERm5TKPkdMgKgwpFTdZUQEZOLsK8K
 fTNeU2S3GxXJuSzDy8oxMrU/uCOzALywGQry1bVBePpkYIS5M/23X53VqwEGpIWCpgQYic
 T912Sk/nSeUQrb52rR7eBI3uEpqbO+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hKSN8hGmZUHb7kr6m9FqH/JXx7Hi67L7PJwnl68BBLA=;
 b=fjn0MkEoCVKkK/+UHnYpyoJiU/BsHQLbsVs1eNE5AQR3aacRkyxy1Y+Yet9hmqHLeo6kC8
 7nD3SgyEoww9bIDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hKSN8hGmZUHb7kr6m9FqH/JXx7Hi67L7PJwnl68BBLA=;
 b=pXNCglyUJKxfvLxdNv80q6VA0e8JNEnEdYZov0eLEUyfECnYrhOKz6QZd0L7GXmVAp5HrP
 evBcI7iwrWCiNbTvPGemwV/ytl8dDPOuUATM8RDITj/uoDhETKMmZmPuuaAZxupzweAni5
 EJpjo5Q0UQtdp+V/JuqtbimcAyY2PLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hKSN8hGmZUHb7kr6m9FqH/JXx7Hi67L7PJwnl68BBLA=;
 b=0aYBNz8k+M5R6lKyBvrtm//vmbDNC+UZa/nqLM0+f+3NxJzJqME4Xfs8ur8YY9wSHaH3ae
 ZADyBECsA2sQJ0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27A7513A3F;
 Wed,  1 Oct 2025 21:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cfL5Nbii3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:52:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/13] QTest patches for 2025-10-01
Date: Wed,  1 Oct 2025 18:52:41 -0300
Message-Id: <20251001215254.2863-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:

  Merge tag 'rust-ci-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20251001-pull-request

for you to fetch changes up to ca5be51a51fc6b6402838310ae8d0162fc03ecef:

  migration-test: strv parameter (2025-10-01 17:09:23 -0300)

----------------------------------------------------------------
Qtest pull request

- Fix for qtest_get_machines QEMU var caching
- Fixes for migration-test in --without-default-devices build
- Preparation patches for cpr-exec test

----------------------------------------------------------------

Steve Sistare (11):
  tests/qtest: optimize qtest_get_machines
  tests/qtest: export qtest_qemu_binary
  tests/qtest: qtest_qemu_args
  tests/qtest: qtest_create_test_state
  tests/qtest: qtest_qemu_spawn_func
  tests/qtest: qtest_init_after_exec
  migration-test: only_source option
  migration-test: shm path accessor
  migration-test: misc exports
  migration-test: migrate_args
  migration-test: strv parameter

Thomas Huth (2):
  tests/qtest: Add missing checks for the availability of machines
  tests/qtest/migration: Fix cpr-tests in case the machine is not
    available

 tests/qtest/bios-tables-test.c        |   2 +-
 tests/qtest/cpu-plug-test.c           |   2 +-
 tests/qtest/libqtest.c                | 120 ++++++++++++++++++--------
 tests/qtest/libqtest.h                |  25 ++++++
 tests/qtest/migration/bootfile.c      |   5 ++
 tests/qtest/migration/bootfile.h      |   1 +
 tests/qtest/migration/cpr-tests.c     |   5 +-
 tests/qtest/migration/framework.c     | 107 +++++++++++++++--------
 tests/qtest/migration/framework.h     |   7 +-
 tests/qtest/migration/migration-qmp.c |  16 ++++
 tests/qtest/migration/migration-qmp.h |   2 +
 tests/qtest/riscv-csr-test.c          |   4 +-
 12 files changed, 217 insertions(+), 79 deletions(-)

-- 
2.35.3


