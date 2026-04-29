Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B744CFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5y8-00073M-VM; Wed, 29 Apr 2026 10:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5y7-000738-4e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:32:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5y5-0007pG-Aw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:32:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B5B55BD17
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777473162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23Dmm92/Zm5qYlsdIPqP7HhUhk2nYgxB45cn68M3vdk=;
 b=boTuh1glAHJYHdb7RGqlCnCeZLw4N0+uT0xK/zu0S+CdPQuuObjMEzVVb3kGhVC/DtFqvx
 NHEHpUcs8bNMu0lASXDTrb5rCL2rM1jQMpO4hYPFXY1mzazDYS8AbYKTExtxvNafUINqcG
 zuNRCiiu8/1tmX8tnvRJNbyrLXpTpVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777473162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23Dmm92/Zm5qYlsdIPqP7HhUhk2nYgxB45cn68M3vdk=;
 b=FNzlzfIZVupXtOrGdlsrLjwQ2saUzKqYVdp5Nedl2ojHWJMCSVjTL+bSCV39wWqQf5njth
 0G7w0yHvOVmgVtDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iAgZWfew;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dsma5vYt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777473158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23Dmm92/Zm5qYlsdIPqP7HhUhk2nYgxB45cn68M3vdk=;
 b=iAgZWfew4JgKyR7Zm+IyGYDozh6aJaqTZ1Oop3OfJ6yrMXmVEh5YboUYuZQ4LFl1nzakLk
 b4OcxISUMJlsFfujy46F4QQDdr7xkuFTtB7Xs2MmquzO6aLQCBkLcOT2YJVmHyrBAF/YRw
 73IVIUUhlS4bT4k6bWV5X16ALFK928o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777473158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=23Dmm92/Zm5qYlsdIPqP7HhUhk2nYgxB45cn68M3vdk=;
 b=dsma5vYtOvynYH+DpiHqbfAmNGsb3xpjxo6koEPRo8zBTt9AtZU679zryznkUjAUcHRQ3X
 SvXxPIjAqg1CxNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0237F593B2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zweXMIUW8mksagAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:32:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Qtest patches for 2026-04-29
Date: Wed, 29 Apr 2026 11:32:28 -0300
Message-ID: <20260429143235.25115-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,gitlab.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9B5B55BD17
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

The following changes since commit 759c456b1d22fe4083c8b384da27d3f56fd53f82:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-04-27 12:57:33 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20260429-pull-request

for you to fetch changes up to d808d32f963bdd038847ba18b7c022065e695517:

  tests/qtest: Make qtest_get_arch() cleverer (2026-04-29 10:37:26 -0300)

----------------------------------------------------------------
QTest pull request

- New test: iommu-intel-test
- Improvement of QEMU binary name parsing

----------------------------------------------------------------

Fengyuan Yu (2):
  tests/qtest/libqos: Add Intel IOMMU helper library
  tests/qtest: Add Intel IOMMU bare-metal test

Peter Maydell (1):
  tests/qtest: Make qtest_get_arch() cleverer

 MAINTAINERS                          |   2 +
 tests/qtest/iommu-intel-test.c       | 216 +++++++++++++
 tests/qtest/libqos/meson.build       |   3 +
 tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-intel-iommu.h | 185 +++++++++++
 tests/qtest/libqtest.c               |  41 ++-
 tests/qtest/meson.build              |   2 +
 7 files changed, 891 insertions(+), 12 deletions(-)
 create mode 100644 tests/qtest/iommu-intel-test.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.h

-- 
2.51.0


