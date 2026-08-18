Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94375C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOUg-0007y3-OL; Tue, 18 Aug 2026 14:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUf-0007u2-20
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:01 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwOUd-0002ym-3Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:25:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78A7C3E7D;
 Tue, 18 Aug 2026 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nnRwQGi/As+VEy2YLWWme6ptcZ5o2YU9MoKEkq3nN+c=;
 b=YkhVL8TAjWlarAt1d74DDur6oeFPGXMcGWNBzeIqrvkTzLqsRqL9afsVnr/gJIBobA1QV+
 9dMgZQpcn/yT4k8RE5jiBFIiPnD94rRB5Ste1H1h19EHQNpqIyXC/BABAmOrkVS94m/Cju
 cxsmpUDPQSXjhJymn9cqmX25ES5KHj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nnRwQGi/As+VEy2YLWWme6ptcZ5o2YU9MoKEkq3nN+c=;
 b=XwEBEWEBwlnGw6OT8l5sW0IhqKCwXmI7aBUK2t0vkTc9QkChBRgfaSers95njeQXwLY2m6
 4BFhsiI8leeEJQBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JFH6i3Vt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4RXWmbtx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787077489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nnRwQGi/As+VEy2YLWWme6ptcZ5o2YU9MoKEkq3nN+c=;
 b=JFH6i3VtmSSpxWF2Q00Kk/4QrSRvPOwn8XbuFk+rsuMR6aHWbMjWjoCJgucFChIyKK5nDg
 tVYQOVrRcD+SbCnl+TH0NG4rX2eZIZ+AeOeAOUQVQQNyMB5H5xJNisMrwWH8ht5/VjKj4U
 sCU008GIIKUy9NcEhkuoE8ejZ55jbJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787077489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nnRwQGi/As+VEy2YLWWme6ptcZ5o2YU9MoKEkq3nN+c=;
 b=4RXWmbtx1+Fm0562l9z3zrOht1rcMiMSbjAQU74hSWcUYSCnS1XwATsxXg8D+H8W/Q2Ywc
 Opx4kxGyNV0yOlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B8B0339C;
 Tue, 18 Aug 2026 18:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j687O2+jhGpYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Aug 2026 18:24:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/8] migration: Remove extra type-checking from vmstate
 macros
Date: Tue, 18 Aug 2026 15:24:33 -0300
Message-ID: <20260818182441.404790-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 78A7C3E7D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Changes in v2:

- Removed more unused vmstate macros
- Fixed the type check macro
- Renamed the new structure to something more explicit
- Added a new flag to indicate an empty vmstate
- Added the overflow and overallocation checks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2769617319
Also tested:
- migration-test --full --thorough
- x86_64 compat run forward and backwards for previous 3 QEMU releases
- s390x compat run forward and backwards for previous 2 QEMU releases
- ppc64 compat run forward and backwards for previous QEMU release
- migration-test smoke ASAN/UBSAN run

v1:
https://lore.kernel.org/r/20260729225227.1170574-1-farosas@suse.de

Hi, this is basically what I ranted about in:
https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de

I'm replacing the per-integer-size type checks with a single "int that
fits in 32bit" check. This allows several lines of duplicated code to
be removed.

I haven't changed the macro names in the device code yet. If this
series gets positive feedback then I'll send per-subsystem patches
doing that.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
Also tested:
- migration-test --full --thorough
- x86_64 compat run forwards and backwards for previous 3 QEMU releases
- s390x compat run forwards and backwards for previous 2 QEMU releases
- ppc64 compat run forwards and backwards for previous QEMU release
- migration-test smoke ASAN/UBSAN run

Fabiano Rosas (8):
  migration: Remove unused vmstate macros
  migration: Introduce VMStateStructMember
  migration: Remove redundant flags
  migration: Remove duplicate vmstate macros
  migration: Add VMS_NO_STATE flag
  migration: Check more vmstate flags
  migration: Harden vmstate_handle_alloc
  migration: Harden vmstate_size

 hw/pci/msix.c                      |   6 +-
 hw/scsi/scsi-bus.c                 |   6 +-
 include/migration/vmstate.h        | 388 +++++++++++++----------------
 migration/savevm.c                 |  29 ++-
 migration/vmstate.c                | 103 +++++---
 rust/bindings/migration-sys/lib.rs |  17 +-
 rust/migration/src/vmstate.rs      |  32 ++-
 rust/tests/tests/vmstate_tests.rs  |  32 +--
 8 files changed, 331 insertions(+), 282 deletions(-)

-- 
2.53.0


