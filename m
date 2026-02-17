Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8079AE909D5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNpA-0005T9-U5; Tue, 17 Feb 2026 11:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNp7-0005SI-7e
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:21:17 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNp4-00059V-Ts
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:21:16 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D98F5BCE1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 16:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771345271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kupGdaLY3Mwbu/WVwy4xhPcKQs5fKRET+M1TvboSp5U=;
 b=eKW0ApRAnSYqktcYLe5hUilvIOCuYPKJiODvjgF1yGM8rCz97F5Lccl2AtW47dPePC5WgV
 5E7KIF7qT87J/RyHNyp67aMpdnCCdSsd4ss0m9TcIxJqvhF98wZnPu9iqBGddXwwxilXH5
 yzQ77C8o9HvFqxXIe7CDMksr9C9VEeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771345271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kupGdaLY3Mwbu/WVwy4xhPcKQs5fKRET+M1TvboSp5U=;
 b=e5SLL9xpioxs5h0YD70DdctaED2BnzGC1j39H7s6cUlaxneOW8GvprL+BT6PobJLYmM5UQ
 JjLXz/YxCc6PxIDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WoPVuYxh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fER3oiKH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771345270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kupGdaLY3Mwbu/WVwy4xhPcKQs5fKRET+M1TvboSp5U=;
 b=WoPVuYxhtHhRy92S6Ov1KMpnjIDdV8o7+TnrL4Jm8bOBaDBww/Pg3UX6oKjhW6wDkY2DIV
 hAoyXaMc+E8TNr4+o6MlLtQ1rW5XPp6/cAXV9pRDYvKluhd0Mn7/MTwEdmarmjtyadhcMb
 t3sI4fHky6Y50mEwN0pejxa2JmT/Yuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771345270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kupGdaLY3Mwbu/WVwy4xhPcKQs5fKRET+M1TvboSp5U=;
 b=fER3oiKHuKAiTeCwmTioZRZOPF4pqGPTePhTdmQZH5Tp3CemPwzCBN40AfJiDkrV49/Cjx
 H+2JzDUdJomDxdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A611E3EA65
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 16:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WkqlGnWVlGnPVAAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 16:21:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] QTest patches for 2026-02-17
Date: Tue, 17 Feb 2026 13:21:04 -0300
Message-ID: <20260217162106.13630-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6D98F5BCE1
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20260217-pull-request

for you to fetch changes up to a8f98ffd7b22a5c6554bc475096cf5de1d0cbd6f:

  tests/qtest: Add RISC-V IOMMU bare-metal test (2026-02-17 09:37:40 -0300)

----------------------------------------------------------------
QTest pull request

- RISCV IOMMU test

----------------------------------------------------------------

Chao Liu (2):
  tests/qtest/libqos: Add RISC-V IOMMU helper library
  tests/qtest: Add RISC-V IOMMU bare-metal test

 MAINTAINERS                          |   2 +
 tests/qtest/iommu-riscv-test.c       | 279 +++++++++++++++++++
 tests/qtest/libqos/meson.build       |   2 +-
 tests/qtest/libqos/qos-riscv-iommu.c | 403 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-riscv-iommu.h | 164 +++++++++++
 tests/qtest/meson.build              |   5 +-
 6 files changed, 853 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/iommu-riscv-test.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
 create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h

-- 
2.51.0


