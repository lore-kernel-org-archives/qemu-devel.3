Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3602C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE3Q-0002DF-5Q; Wed, 30 Jul 2025 17:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhDnD-0004Qk-Qz
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:52:55 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhDnB-0002Iz-L7
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:52:55 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EFCC21A7D;
 Wed, 30 Jul 2025 20:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753908771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t8EEspwSVTt2dmNdLGQe+1vMwwze+CyLuVypkxMWUXQ=;
 b=AsFWLRleK2YCeS/Kw/GgBk75GTOyIF6Sjh7dCe1fu31lrRnXHj7QLMqHYZsh69tZf2qEO2
 C8t/rb177Q6gjnPCtLt0qpzJah2/AyttbrwoG3qLFIo9hgrG60WwpTvTW0+1qlycDychBH
 a2GXS3ng5spEBNaa7nGC2RiddP5uVJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753908771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t8EEspwSVTt2dmNdLGQe+1vMwwze+CyLuVypkxMWUXQ=;
 b=mwyLLSNt9PmReTDX7EeauiGtnVG++zsufovYVnsFwidoeHP8u/Ocpzt73BtIG4AGwC8OOg
 +vozQXqvlrJEi4Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eDjWaXvG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wpqK2lUZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753908769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t8EEspwSVTt2dmNdLGQe+1vMwwze+CyLuVypkxMWUXQ=;
 b=eDjWaXvGH9J4CH0opFAfUBC27EAj85augAundVgrI2wLxg0pXDuLov2kaPdYt+RiZWv4lP
 Nm4gFIFJeGU9D70gmyUgoeimVkzLz9S0+6xPJJth91yBsSqoaDF9Up9i/aFtmZW5boRBUd
 THZSujNMM+N2xAsO16vaBDpx+Z3Zdbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753908769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t8EEspwSVTt2dmNdLGQe+1vMwwze+CyLuVypkxMWUXQ=;
 b=wpqK2lUZe0UqxZ0f04wIGoXW52PUO5rv6NYkQKVJ5tc/otr1QBJ3Iu75rxT0iE7RmFvKTj
 TKCkbZg0qibOcqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E85A1388B;
 Wed, 30 Jul 2025 20:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0j9qACCGimjhPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 30 Jul 2025 20:52:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 0/3] migration: Fix aarch64 cpregs migration
Date: Wed, 30 Jul 2025 17:52:42 -0300
Message-Id: <20250730205245.2118-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EFCC21A7D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
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

Commit 655659a74a ("target/arm: Correct encoding of Debug
Communications Channel registers") removed one register and added two
more. This breaks TCG migration:

1) to 10.1 - older versions will have one unknown register

  { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32,
    .cp = 14, .crn = 0, .crm = 5, .opc1 = 3, .opc2 = 0 }

  kvmid: 0x40200000200e0298

2) from 10.1 - older versions will not accept more registers than
   their cpreg_vmstate_array_len (292 > 291).

I'm proposing a (RFC) stop-gap fix for (1) so 10.1 can be used as a
migration target until we figure out how to add some form of
versioning of the cpregs_indexes list and keep track of what has been
added/removed throughout the releases.

Even with infrastructure in place to do compatibility of the cpregs
list, there is still the need to avoid (or justify) guest-visible
changes resulting from some registers not being migrated.

Anyway, let's discuss.

PS: the extra patches are to enable cross-version testing on aarch64,
which would have flagged this early. My apologies as this is entirely
my fault because enabling these tests for arm has been on my list for
a long time.

Fabiano Rosas (3):
  target/arm: Fix migration to QEMU 10.1
  tests/qtest/migration: Only test aarch64 on TCG
  tests/qtest/migration: Change cpu for aarch64

 target/arm/machine.c              | 24 +++++++++++++++++++++++-
 tests/qtest/migration/framework.c | 19 ++++++++++++++-----
 2 files changed, 37 insertions(+), 6 deletions(-)

-- 
2.35.3


