Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABCCC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6L7-0003uw-35; Fri, 14 Mar 2025 10:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6L1-0003tK-Po
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:41 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tt6Kx-0001iM-Q2
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:48:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 60B661F74B;
 Fri, 14 Mar 2025 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+u+b1bhCZRc+clpsnOLU6RsTE8EAt9fb4DDXLy/dqo=;
 b=PKu0Uz3EGzk7+wd24c18KEGLJj8/VRxfFRE+OBN4h+3An9yzJQAsWfVgAy2GhD7YsMjvV/
 PUkk4yHVJKyyexhr4/hQbMSqkgNz4YChYCq61oqsXikBVHt+kWV94z18wnaXftap8cbwjh
 fLzsvNWpeJigLyHiv1wDNNgK8WrAP6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+u+b1bhCZRc+clpsnOLU6RsTE8EAt9fb4DDXLy/dqo=;
 b=chVVRgIASh+pl6ypNmxRmI+8mBfU5rfGFg4tTN5TA4yYXO+/KyJUqmT1s//R6dGdLqpzX3
 ikOWm4vYt/bqxjDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PKu0Uz3E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=chVVRgIA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741963710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+u+b1bhCZRc+clpsnOLU6RsTE8EAt9fb4DDXLy/dqo=;
 b=PKu0Uz3EGzk7+wd24c18KEGLJj8/VRxfFRE+OBN4h+3An9yzJQAsWfVgAy2GhD7YsMjvV/
 PUkk4yHVJKyyexhr4/hQbMSqkgNz4YChYCq61oqsXikBVHt+kWV94z18wnaXftap8cbwjh
 fLzsvNWpeJigLyHiv1wDNNgK8WrAP6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741963710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a+u+b1bhCZRc+clpsnOLU6RsTE8EAt9fb4DDXLy/dqo=;
 b=chVVRgIASh+pl6ypNmxRmI+8mBfU5rfGFg4tTN5TA4yYXO+/KyJUqmT1s//R6dGdLqpzX3
 ikOWm4vYt/bqxjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A2D0132DD;
 Fri, 14 Mar 2025 14:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RPrjB71B1GeVPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Mar 2025 14:48:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/4] Migration patches for 2025-03-14
Date: Fri, 14 Mar 2025 11:48:20 -0300
Message-Id: <20250314144824.1707-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60B661F74B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The following changes since commit 0462a32b4f63b2448b4a196381138afd50719dc4:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-03-14 09:31:13 +0800)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250314-pull-request

for you to fetch changes up to 8ffe0623a1f40803feb4280fce13549baa4b0b47:

  hw/qxl: fix cpr (2025-03-14 09:29:20 -0300)

----------------------------------------------------------------
Migration pull request

Fixes for cpr-transfer (live update functionality).

----------------------------------------------------------------

Steve Sistare (4):
  migration: cpr_is_incoming
  pflash: fix cpr
  hw/loader: fix roms during cpr
  hw/qxl: fix cpr

 hw/block/block.c        |  5 +++++
 hw/core/loader.c        |  5 ++++-
 hw/display/qxl.c        | 27 ++++++++++++++++++++++++---
 include/migration/cpr.h |  1 +
 migration/cpr.c         |  5 +++++
 5 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.35.3


