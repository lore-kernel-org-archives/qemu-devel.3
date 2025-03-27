Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA26EC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoOX-0006Tt-To; Thu, 27 Mar 2025 10:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOV-0006TX-5R
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:43 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOS-0005YI-SP
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16CB81F79A;
 Thu, 27 Mar 2025 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kBHbzpJTEY7HGfjt2830w2tqrTmlzXjC8e0dQZm6v4c=;
 b=Pi3rlBxn42zBTrH2IxJuWQ2mHT8cWhgKDGxRK00PZEpdDrjSl9HMwBHOmJtiEVPgIUXoj9
 e78pLCmKr2g+xlDjeJo4udhjRSjKeoCAVz45BcQhR8PYbRuWhlKAOMnuwGpAkUKYVyMEUc
 A3gh8/mLjw2aTTsdLf1GLP6SidT7m9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kBHbzpJTEY7HGfjt2830w2tqrTmlzXjC8e0dQZm6v4c=;
 b=6gx34ZV/jSLMENa/EdEuEG/MtexPS0UD69xuRL90srmdLmTHwaFzWvC+GyBbmEcZg043L5
 zIP+WuATFtOg75Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kBHbzpJTEY7HGfjt2830w2tqrTmlzXjC8e0dQZm6v4c=;
 b=Pi3rlBxn42zBTrH2IxJuWQ2mHT8cWhgKDGxRK00PZEpdDrjSl9HMwBHOmJtiEVPgIUXoj9
 e78pLCmKr2g+xlDjeJo4udhjRSjKeoCAVz45BcQhR8PYbRuWhlKAOMnuwGpAkUKYVyMEUc
 A3gh8/mLjw2aTTsdLf1GLP6SidT7m9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kBHbzpJTEY7HGfjt2830w2tqrTmlzXjC8e0dQZm6v4c=;
 b=6gx34ZV/jSLMENa/EdEuEG/MtexPS0UD69xuRL90srmdLmTHwaFzWvC+GyBbmEcZg043L5
 zIP+WuATFtOg75Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 088BF139D4;
 Thu, 27 Mar 2025 14:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o4NbLihj5WcVZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:39:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, berrange@redhat.com,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 0/4] migration: savevm testing
Date: Thu, 27 Mar 2025 11:39:30 -0300
Message-Id: <20250327143934.7935-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Hi, we had a bug report that enabling multifd and attempting
savevm/loadvm crashes QEMU. This seems to have been around for many
years.

I'm adding a fix for this in the form of a capabilities check for
snapshots.

I'm also adding a couple of tests that validate migration capabilities
are properly rejected by savevm.

There is a larger discussion to be had which is whether we want to
attempt to implement every migration capability for snapshots or
should we try to convert snapshots into a regular migration or some
third option. For now I'm trying to avoid this by not touching
capabilities that don't cause a crash, but let me know your thoughts.

Thanks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1738368896

Fabiano Rosas (4):
  migration/savevm: Add a compatibility check for capabilities
  tests/qtest/migration: Extract machine type resolution
  tests/qtest/migration: Add QMP helpers for snapshot
  tests/qtest/migration: Add savevm tests

 migration/options.c                   |  26 +++++
 migration/options.h                   |   1 +
 migration/savevm.c                    |   8 ++
 tests/qtest/meson.build               |   1 +
 tests/qtest/migration-test.c          |   1 +
 tests/qtest/migration/framework.c     |  54 ++++++----
 tests/qtest/migration/framework.h     |   5 +
 tests/qtest/migration/migration-qmp.c | 120 +++++++++++++++++++++
 tests/qtest/migration/migration-qmp.h |   4 +
 tests/qtest/migration/savevm-tests.c  | 144 ++++++++++++++++++++++++++
 10 files changed, 345 insertions(+), 19 deletions(-)
 create mode 100644 tests/qtest/migration/savevm-tests.c

-- 
2.35.3


