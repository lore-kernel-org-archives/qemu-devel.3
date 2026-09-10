Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481FDC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mkb-0006qZ-CU; Thu, 10 Sep 2026 17:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lNx-0003dJ-L2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:57 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4lNl-000160-Hp
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D66CE1FEF1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 20:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/MCgc/kii26n1d6c0iRGevPEBTMCThMdy7MfNyvhAA=;
 b=dyPi2v1e8izklgwpp76AOA5RJOEL+8nMXdn6NYSYrV7Hkw8+qMvC4fqYaD8hCjSqkX+vt5
 1+j8oXnhxj0eiFvkLEGXVHWOcUm9sLLEJsbENSO//GOjTunnCxlkn3gJF7tnLtCyvcstJ0
 c2dJxistscLOch1HbH2z8yi17ekxFh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/MCgc/kii26n1d6c0iRGevPEBTMCThMdy7MfNyvhAA=;
 b=8X1xfk+3RNltLtq0YQTFlAIrRB7cYHxHI6g3Y21PPGh5TdgradTCk/+Ign8scbt4vThSyi
 eCUYORhojLrfdACw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789071966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/MCgc/kii26n1d6c0iRGevPEBTMCThMdy7MfNyvhAA=;
 b=01//YtpY+JJ2sYeVxC9Y7WPa0cMLjwTSTEzpNoJkF2Fue82ijdulh5WwHqDqhzhT9QIWXI
 EdcgFX2vdU3qLGfi5xpfwFVaq6M7u9hdTSwHhiyit8D+DnbyKA8J+4O9IjDJr2esh4oJbj
 QJN9V0GEYhgQk2KzVlW4HyeHr6ckNrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789071966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U/MCgc/kii26n1d6c0iRGevPEBTMCThMdy7MfNyvhAA=;
 b=2a6CJeHNrO7A48FAxNlWwyJE864np7OBxI/22XedSjGWkqRiMnHeQv88vZDNdU13NZqDzN
 nr13/0h+aPAyF9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09CF313180
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 20:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TrKjMl0So2pJPQAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 20:26:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Qtest patches for 2026-09-10
Date: Thu, 10 Sep 2026 17:25:52 -0300
Message-ID: <20260910202559.916866-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013fb7:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-09-10 11:08:04 +0100)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20260910-pull-request

for you to fetch changes up to bc4f7b451e1f38578427e5df186aa1327d739ee2:

  tests/qtest/ahci: fix a racy deadlock in the engine stop test (2026-09-10 17:22:02 -0300)

----------------------------------------------------------------
QTest pull request

- Improvements to fdc-test execution ordering
- Fix to a deadlock in ahci-test under host load
- Leak fixes to migration and IDE

----------------------------------------------------------------

Christian Quante (3):
  tests/qtest/fdc-test: give each test case its own QEMU instance
  tests/qtest/fdc-test: skip test cases when the 'pc' machine is missing
  tests/qtest/fdc-test: check that READ ID answers for the drive it
    names

Denis V. Lunev (1):
  tests/qtest/ahci: fix a racy deadlock in the engine stop test

Fabiano Rosas (3):
  ahci: Fix leak of IRQState
  migration: Drop iochannel reference during snapshot setup
  migration: Free the JSON writer during snapshots

 hw/ide/ahci.c           |   1 +
 migration/migration.c   |   2 +-
 migration/migration.h   |   1 +
 migration/savevm.c      |  10 +++-
 tests/qtest/ahci-test.c |   6 ++
 tests/qtest/fdc-test.c  | 127 +++++++++++++++++++++++++++++++++-------
 6 files changed, 124 insertions(+), 23 deletions(-)

-- 
2.53.0


