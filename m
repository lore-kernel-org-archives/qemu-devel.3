Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022CEC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZ3-0000zW-AC; Fri, 14 Jun 2024 13:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZ1-0000yp-LC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:11 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAYz-00042K-Ln
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB298339FA;
 Fri, 14 Jun 2024 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XtmapDCJXY1KXQq00vMKMZxcoJp1mbQebTbvKQRF1AI=;
 b=0Yn1GDO4su32qQ/LFRytnrQw8/0/RV6Q4Jt4k9nElUi7JkZziXICC9KhQ5Hic0UsybKt7z
 0pD5ymo9228cGffzYsxbHRnWdziOojX55Jn6fF66QqNDHND3ca7IGG1ovSfGFEgqEhfZFB
 nZFiZyWMnn3pkYl/WIaHQ1WEoI9XmQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XtmapDCJXY1KXQq00vMKMZxcoJp1mbQebTbvKQRF1AI=;
 b=rmgBSREWP8NYGkMwmGIJZWWgWIun5MITUBKIMTx0o3AV+xe4Cn6RRYD4Gs8+EP4/e6yhsm
 RHa9fyP7ZFYhgSDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=puN1MTem;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a7IRWfsa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XtmapDCJXY1KXQq00vMKMZxcoJp1mbQebTbvKQRF1AI=;
 b=puN1MTem2/b/3WRBKET0Mpu8xQmjqEniBzq6YDFNPyY11X1kwOq7ANxdWdnFJgvmc8zxLx
 I73YkTuYZTSd4x9QDUeDikIiOEGGDSUPWvK4hwugcdMqxYHgVkC+38j2eGOUOzXsKBdXel
 HTBSVFIYjFbqo0Rbs/ZC28aUsQvQ+Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XtmapDCJXY1KXQq00vMKMZxcoJp1mbQebTbvKQRF1AI=;
 b=a7IRWfsaaKNG79Cv0bD0sUzcSJI/f6JMKYSL88R7JnbDJbMYr/TZFjz9J+1aC0sbcgJjDo
 faVjw5OeXQ3ZC8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C309F13AB1;
 Fri, 14 Jun 2024 17:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tgIjIkx7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/18] Migration patches for 2024-06-14
Date: Fri, 14 Jun 2024 14:17:44 -0300
Message-Id: <20240614171802.28451-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB298339FA
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,gitlab.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 046a64b9801343e2e89eef10c7a48eec8d8c0d4f:

  Merge tag 'pull-request-2024-06-12' of https://gitlab.com/thuth/qemu into staging (2024-06-13 07:51:58 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240614-pull-request

for you to fetch changes up to c519caa825f5eba6e204bed5a464df167a5421d0:

  tests/migration-test: add uadk compression test (2024-06-14 14:01:30 -0300)

----------------------------------------------------------------
Migration pull request

- Nick's reenabling of ppc64 tests + speed improvements
- Yuan's IAA/QPL compression support for multifd
- Shameer's UADK compression support for multifd

----------------------------------------------------------------

Nicholas Piggin (4):
  tests/qtest: Move common define from libqos-spapr.h to new ppc-util.h
  tests/qtest/migration-test: Quieten ppc64 QEMU warnings
  tests/qtest/migration-test: Enable on ppc64 TCG
  tests/qtest/migration-test: Use custom asm bios for ppc64

Shameer Kolothum (7):
  docs/migration: add uadk compression feature
  configure: Add uadk option
  migration/multifd: add uadk compression framework
  migration/multifd: Add UADK initialization
  migration/multifd: Add UADK based compression and decompression
  migration/multifd: Switch to no compression when no hardware support
  tests/migration-test: add uadk compression test

Yuan Liu (7):
  docs/migration: add qpl compression feature
  migration/multifd: put IOV initialization into compression method
  configure: add --enable-qpl build option
  migration/multifd: add qpl compression method
  migration/multifd: implement initialization of qpl compression
  migration/multifd: implement qpl compression and decompression
  tests/migration-test: add qpl compression test

 docs/devel/migration/features.rst         |   2 +
 docs/devel/migration/qpl-compression.rst  | 260 ++++++++
 docs/devel/migration/uadk-compression.rst | 144 ++++
 hw/core/qdev-properties-system.c          |   2 +-
 meson.build                               |  22 +
 meson_options.txt                         |   4 +
 migration/meson.build                     |   2 +
 migration/multifd-qpl.c                   | 762 ++++++++++++++++++++++
 migration/multifd-uadk.c                  | 369 +++++++++++
 migration/multifd-zlib.c                  |   7 +
 migration/multifd-zstd.c                  |   8 +-
 migration/multifd.c                       |  22 +-
 migration/multifd.h                       |   6 +-
 qapi/migration.json                       |  11 +-
 scripts/meson-buildoptions.sh             |   6 +
 tests/migration/Makefile                  |   2 +-
 tests/migration/migration-test.h          |   1 +
 tests/migration/ppc64/Makefile            |  15 +
 tests/migration/ppc64/a-b-kernel.S        |  66 ++
 tests/migration/ppc64/a-b-kernel.h        |  42 ++
 tests/qtest/boot-serial-test.c            |   2 +-
 tests/qtest/libqos/libqos-spapr.h         |   7 -
 tests/qtest/migration-test.c              | 100 +--
 tests/qtest/ppc-util.h                    |  19 +
 tests/qtest/prom-env-test.c               |   2 +-
 tests/qtest/pxe-test.c                    |   2 +-
 26 files changed, 1816 insertions(+), 69 deletions(-)
 create mode 100644 docs/devel/migration/qpl-compression.rst
 create mode 100644 docs/devel/migration/uadk-compression.rst
 create mode 100644 migration/multifd-qpl.c
 create mode 100644 migration/multifd-uadk.c
 create mode 100644 tests/migration/ppc64/Makefile
 create mode 100644 tests/migration/ppc64/a-b-kernel.S
 create mode 100644 tests/migration/ppc64/a-b-kernel.h
 create mode 100644 tests/qtest/ppc-util.h

-- 
2.35.3


