Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61128FED9F6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z4k-0003kZ-QH; Tue, 17 Mar 2026 14:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z4i-0003kO-Mo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:23:28 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2Z4g-00033z-UX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:23:28 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF73A5BE9B;
 Tue, 17 Mar 2026 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0BaTHpNzGOzsKl7piv4uWPgTrmEQE38ZXiz54nYl380=;
 b=v4PRPLjlUTlL7FBldCluJQyAPDrT4RAkoXXitJzn/0DruLq1lnP0QbW7S6e/k/1paSaGN5
 YA28H0lbNVMzW+SnKaqEwRainIukHxzEtCHXpqTHsgxHE23buNM4iCaGlrC4UrOi+ycFM/
 /JXlsC3XxzcXx9nrvW94PhEtUqhutEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0BaTHpNzGOzsKl7piv4uWPgTrmEQE38ZXiz54nYl380=;
 b=+nJ1X8M5/eVsHhgzcKa+XEsffT5dvcdn+WsqlAoUd/odkgoiQzZlg3a9RsV/NO78pspmsF
 RjvQrDfBVJzzAQDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773771803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0BaTHpNzGOzsKl7piv4uWPgTrmEQE38ZXiz54nYl380=;
 b=v4PRPLjlUTlL7FBldCluJQyAPDrT4RAkoXXitJzn/0DruLq1lnP0QbW7S6e/k/1paSaGN5
 YA28H0lbNVMzW+SnKaqEwRainIukHxzEtCHXpqTHsgxHE23buNM4iCaGlrC4UrOi+ycFM/
 /JXlsC3XxzcXx9nrvW94PhEtUqhutEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773771803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0BaTHpNzGOzsKl7piv4uWPgTrmEQE38ZXiz54nYl380=;
 b=+nJ1X8M5/eVsHhgzcKa+XEsffT5dvcdn+WsqlAoUd/odkgoiQzZlg3a9RsV/NO78pspmsF
 RjvQrDfBVJzzAQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D12554273B;
 Tue, 17 Mar 2026 18:23:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vH+EJRqcuWnXdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 18:23:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/10] Migration/Qtest patches for 2026-03-17
Date: Tue, 17 Mar 2026 15:23:10 -0300
Message-ID: <20260317182320.31991-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,gitlab.com:url]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed9f:

  Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu into staging (2026-03-17 10:20:30 +0000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260317-pull-request

for you to fetch changes up to 8f627bf1be077382f8ebf2cbda5cfb7e94006c54:

  tests/qtest/test-hmp: Free machine options (2026-03-17 14:58:09 -0300)

----------------------------------------------------------------
Migration/Qtest pull request

Various fixes

----------------------------------------------------------------

Aadeshveer Singh (1):
  migration: fix implicit integer division in migration_update_counters

Ani Sinha (1):
  migration: assert that the same migration handler is not being added
    twice

Fabiano Rosas (8):
  tests/qtest/migration: Fix leak of migration tests data
  io: Fix TLS bye task leak
  tests/qtest/migration: Fix leak in CPR exec test
  migration/multifd: Fix leaks of TLS error objects
  tests/qtest/migration: Force exit-on-error=false
  migration/options: Fix leaks in StrOrNull qdev accessors
  tests/qtest: Don't dup machine name in qtest_cb_for_every_machine
    callbacks
  tests/qtest/test-hmp: Free machine options

 io/channel-tls.c                       |  4 ++-
 migration/migration.c                  |  9 ++++++-
 migration/multifd.c                    | 27 +++++++++-----------
 migration/options.c                    | 35 +++++++++++++++-----------
 tests/qtest/cpu-plug-test.c            | 11 ++++----
 tests/qtest/dbus-vmstate-test.c        |  5 ++--
 tests/qtest/migration/cpr-tests.c      |  5 ++--
 tests/qtest/migration/framework.c      |  7 +++---
 tests/qtest/migration/framework.h      |  2 --
 tests/qtest/migration/migration-qmp.c  |  7 ++++++
 tests/qtest/migration/migration-util.c | 19 ++++++++++----
 tests/qtest/migration/migration-util.h |  2 +-
 tests/qtest/migration/misc-tests.c     |  4 +--
 tests/qtest/migration/precopy-tests.c  | 12 ++++-----
 tests/qtest/migration/tls-tests.c      | 14 ++++++-----
 tests/qtest/qom-test.c                 |  3 +--
 tests/qtest/test-hmp.c                 |  6 ++---
 17 files changed, 99 insertions(+), 73 deletions(-)

-- 
2.51.0


