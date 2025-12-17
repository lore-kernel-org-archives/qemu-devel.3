Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A17D65C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 16:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVufl-0004Q3-0R; Wed, 17 Dec 2025 11:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVuf8-0004GC-HM
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:46:13 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVuf0-00078c-T1
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 11:46:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 594325BCD3;
 Wed, 17 Dec 2025 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765989954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GflHCo7RBYrYhtZvzABS0DCrAarF1iGNGJd1Mhf/Vpw=;
 b=r8WD+01BtYLz8r9MXeQOJVRZS30R73WjbXy1yP5zZS0jFIXke9vYLURJAP376os3S1WAWc
 KZBKIwI7reeiIhWYysj+YZwZujrfB+jnCnn5mHipBlsEo39/++whrq1g1j6Ka9y4zppk19
 kgSKJXu2vbJ1J4ch3nJ7SSEhTTGTCIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765989954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GflHCo7RBYrYhtZvzABS0DCrAarF1iGNGJd1Mhf/Vpw=;
 b=us8GxZPjN5hBGltUg8gDJecuHmGapmMscdEmZQ5ERU1xotsjKSIk4gUIj9P2cJ2DwbvBag
 hISxlvux8JJ9HNCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rIdvvbSl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cdUTv5bC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765989953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GflHCo7RBYrYhtZvzABS0DCrAarF1iGNGJd1Mhf/Vpw=;
 b=rIdvvbSlozVIYZyRyoCPtZGYKpp1X4ZqztuAgf/sp/gtaQlOz33P99R1J8XAj3MjiVfdlm
 b0q/c7GkHc5VFmAeIlbGZummGwXwti5IAx3zIG7fMaJVIpHkhqx2Gp8fxq/73qFrW+PLlv
 it8NmoMIULuUwYfPjqeqIiCaXL60fFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765989953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GflHCo7RBYrYhtZvzABS0DCrAarF1iGNGJd1Mhf/Vpw=;
 b=cdUTv5bCu800mgLKKOQdcYf6yRCgdqTHZgKFLIaVafRpzhwTI095VGq+P4/2gSjQ6EwzWm
 lAji2I0yb/qfLXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 143C83EA63;
 Wed, 17 Dec 2025 16:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9xGIMT/eQmlyDQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Dec 2025 16:45:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 0/2] ppc: Fix migration issue with quiesced state
Date: Wed, 17 Dec 2025 13:45:46 -0300
Message-ID: <20251217164549.4311-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 594325BCD3
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

A while back, Fabian reported two issues with migration on ppc64le,
one of which was already fixed. There remains this one from the
previous series:

pseries migration causes a guest hang after migration due to a new
variable used to track the stopped state of vcpus, which is not
migrated. Fix is to migrate the new variable. To avoid breaking
backward migration, a compat property is added. For forward migration,
a heuritics based on the known QEMU code is used.

Thanks

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2220496446

v1:
https://lore.kernel.org/r/20250819223905.2247-1-farosas@suse.de

Fabiano Rosas (2):
  target/ppc: Fix env->quiesced migration
  tests/functional: Add a OS level migration test for pseries

 hw/ppc/spapr.c                           |  6 +++
 target/ppc/cpu.h                         |  1 +
 target/ppc/cpu_init.c                    |  7 +++
 target/ppc/machine.c                     | 63 ++++++++++++++++++++++++
 tests/functional/ppc64/test_migration.py | 12 +++++
 tests/functional/ppc64/test_pseries.py   | 35 +++++++++++++
 6 files changed, 124 insertions(+)

-- 
2.51.0


