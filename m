Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C352CE7A9F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 21:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smJdl-0004zU-21; Thu, 05 Sep 2024 17:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smJdi-0004yE-6s
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 17:03:38 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smJdg-0007J9-I8
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 17:03:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35D381F836;
 Thu,  5 Sep 2024 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725570214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVHz7A+OtnY0MBJVQGgMqqKGXfePqGzVfrVZQkeY7wk=;
 b=1LvBn1voy98vyE7ODNg5/PkurHlcwpheXyDI59+HlE0hbx0NMBb6+w/LYiYkMUQaOOIDxk
 VQuwa2pP1WCEOLZDpUzrGWxTOMdPghmBa6XjXg0+g6Zg88NZcsTtIPRWergXogxGvVPwYY
 SNVejewsNb+CTHuSAySbLQH9rSTF3vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725570214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVHz7A+OtnY0MBJVQGgMqqKGXfePqGzVfrVZQkeY7wk=;
 b=gtauvchHQRQfBpNw3npLcJ5m7aB0qfZ57sqlvplD9iWWuc0zZZEg9cO+S0dcf3lzrE4mTQ
 gHUnjra61nNcjTCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725570213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVHz7A+OtnY0MBJVQGgMqqKGXfePqGzVfrVZQkeY7wk=;
 b=R/gvzMj2M0RB6aTPYC7VtxVCfFSgL9SIFQ3UvdxQP0M3UKxuWUhtGFgSEYNqilynqt1TUD
 YAn/KHsMX4uWY6huQrwZDeGBhI+I1Ef2EPXJP1pgXozMfvkMtuQcsRgeFubXGyGz0K3aG8
 PhYwYAjqbNPnulAwAn7UlfbUjsAprFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725570213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aVHz7A+OtnY0MBJVQGgMqqKGXfePqGzVfrVZQkeY7wk=;
 b=ncoqY06exB8nNl/flTeyW26ggEJDO8aeUH4OUQM2iuCMdv2ypyyu1GY6yRwPHRnaqgn+dK
 g/hR4h6hLCEn4MCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F1731395F;
 Thu,  5 Sep 2024 21:03:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xcZdFaMc2mYcBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Sep 2024 21:03:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH 0/2] qtest: Log verbosity changes
Date: Thu,  5 Sep 2024 18:03:26 -0300
Message-Id: <20240905210328.25393-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series silences QEMU stderr unless the QTEST_LOG variable is set
and silences -qtest-log unless both QTEST_LOG and gtest's --verbose
flag is passed.

This was motivated by Peter Maydell's ask to suppress deprecation
warn_report messages from the migration-tests and by my own
frustration over noisy output from qtest.

I'm open to suggestions on how to better implement this. One option
would be to ignore g_test_verbose() and have QTEST_LOG levels
(1,2,3,...), but before I get too deep into that, here are the raw
patches for discussion.

Note that it's not possible to use glib's g_test_trap_assert_stderr()
to silence the warnings because when using any verbose option the
output of QEMU, libqmp and qtest-log gets interleaved on stderr,
failing the match.

Thanks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1442270209

Fabiano Rosas (2):
  tests/qtest: Mute QEMU stderr
  tests/qtest: Mute -qtest-log

 tests/qtest/libqtest.c              | 8 +++++---
 tests/qtest/test-x86-cpuid-compat.c | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.35.3


