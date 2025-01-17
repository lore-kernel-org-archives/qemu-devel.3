Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47576C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpXb-0004El-6Z; Fri, 17 Jan 2025 11:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXX-0004Ck-T8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:47 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXT-0001ER-Ki
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:45 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44E691F38E
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7bmDq0P2u7/6nj3MECEu/MSguwOhxzBRHU8QfIp6/dw=;
 b=sVPuD+FQEBrbEC3ZyeGG8oGcHoevL7YaFYOtAHZRQQQpj3nSDMrFA/rE7QuciXyQRDS/Dy
 f1GHT2Uui1WlC0yl600Lukkt1T5Z9XetsPWD46makQzEkkknHSRJw4xUTO/ElmCqQMXuab
 s6aWfvWAyiKbPYxlkfaEVWOWxDMcLtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7bmDq0P2u7/6nj3MECEu/MSguwOhxzBRHU8QfIp6/dw=;
 b=gp9dfjmH8o5yKc16rNY4D0uPiUmu63yLH62jGm2oI/Y7e5ml+QMdsNPuIKxCX5F8jtd6SY
 d2xjVBVOXpPrlwDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7bmDq0P2u7/6nj3MECEu/MSguwOhxzBRHU8QfIp6/dw=;
 b=sVPuD+FQEBrbEC3ZyeGG8oGcHoevL7YaFYOtAHZRQQQpj3nSDMrFA/rE7QuciXyQRDS/Dy
 f1GHT2Uui1WlC0yl600Lukkt1T5Z9XetsPWD46makQzEkkknHSRJw4xUTO/ElmCqQMXuab
 s6aWfvWAyiKbPYxlkfaEVWOWxDMcLtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7bmDq0P2u7/6nj3MECEu/MSguwOhxzBRHU8QfIp6/dw=;
 b=gp9dfjmH8o5yKc16rNY4D0uPiUmu63yLH62jGm2oI/Y7e5ml+QMdsNPuIKxCX5F8jtd6SY
 d2xjVBVOXpPrlwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E44913332
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 16:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id huQMCyOKimftQgAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 16:49:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] QTest patches for 2025-01-17
Date: Fri, 17 Jan 2025 13:49:31 -0300
Message-Id: <20250117164936.22223-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 RCVD_TLS_ALL(0.00)[]
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

The following changes since commit 4d5d933bbc7cc52f6cc6b9021f91fa06266222d5:

  Merge tag 'pull-xenfv-20250116' of git://git.infradead.org/users/dwmw2/qemu into staging (2025-01-16 09:03:43 -0500)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20250117-pull-request

for you to fetch changes up to aa601bd4f1208d85906f7778679c57d91cef6c70:

  tests/qtest/test-x86-cpuid-compat: Remove tests related to pc-i440fx-2.3 (2025-01-17 11:48:44 -0300)

----------------------------------------------------------------
Qtest pull request

- RISCV CSR test
- migration recover changed to OOB
- removal of dead code in test-x86-cpuid-compat

----------------------------------------------------------------

Ivan Klokov (2):
  target/riscv: Add RISC-V CSR qtest support
  tests/qtest: QTest example for RISC-V CSR register

Juraj Marcin (2):
  tests/qtest: Introduce qtest_init_with_env_and_capabilities()
  tests/qtest/migration: Use out-of-band execution for migrate-recover

Thomas Huth (1):
  tests/qtest/test-x86-cpuid-compat: Remove tests related to
    pc-i440fx-2.3

 hw/riscv/riscv_hart.c                 | 55 ++++++++++++++++++++++++++
 tests/qtest/libqtest.c                | 45 ++++++++++++++++++++-
 tests/qtest/libqtest.h                | 31 +++++++++++++++
 tests/qtest/meson.build               |  2 +-
 tests/qtest/migration/framework.c     | 23 ++++++++++-
 tests/qtest/migration/framework.h     |  2 +
 tests/qtest/migration/migration-qmp.c |  2 +-
 tests/qtest/riscv-csr-test.c          | 56 +++++++++++++++++++++++++++
 tests/qtest/test-x86-cpuid-compat.c   | 18 ---------
 9 files changed, 210 insertions(+), 24 deletions(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.35.3


