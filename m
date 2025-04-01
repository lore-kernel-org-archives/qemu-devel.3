Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF8BC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 19:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzhgV-00023f-OJ; Tue, 01 Apr 2025 15:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzhgP-00022T-N1
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 15:54:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzhgN-0004DJ-H2
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 15:54:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7CC2C1F38E;
 Tue,  1 Apr 2025 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743537237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ge5FjxAOes90Hd/Iy4BK3VSMwsP1rDxhceCzkyTd7PY=;
 b=d16P/vavQ3Nu6mqUbY77r/ZzU5JRZZmsy9hUN56DVxFL9J+BQJlzr8u8AHYGzlO5jdJgwn
 8PHFz229nD9HWsl21PtFPkKKRe7Bxx2Hpab3DLeZTThEnbdh5l7mk/eDGuDqNtH2dbdPOQ
 02A5CBggX/Ok4/ofvkcpDvYnNjDFc7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743537237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ge5FjxAOes90Hd/Iy4BK3VSMwsP1rDxhceCzkyTd7PY=;
 b=Nmc134BRrwEagLAK9orvUzV9RXkiYj5dPx/PigzfKStluegWj72R1tQZXBn7oKTp+7saMG
 SpBpnSQ3gXEy6aAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743537237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ge5FjxAOes90Hd/Iy4BK3VSMwsP1rDxhceCzkyTd7PY=;
 b=d16P/vavQ3Nu6mqUbY77r/ZzU5JRZZmsy9hUN56DVxFL9J+BQJlzr8u8AHYGzlO5jdJgwn
 8PHFz229nD9HWsl21PtFPkKKRe7Bxx2Hpab3DLeZTThEnbdh5l7mk/eDGuDqNtH2dbdPOQ
 02A5CBggX/Ok4/ofvkcpDvYnNjDFc7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743537237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ge5FjxAOes90Hd/Iy4BK3VSMwsP1rDxhceCzkyTd7PY=;
 b=Nmc134BRrwEagLAK9orvUzV9RXkiYj5dPx/PigzfKStluegWj72R1tQZXBn7oKTp+7saMG
 SpBpnSQ3gXEy6aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 638D5138A5;
 Tue,  1 Apr 2025 19:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fC9bCFRE7GdNSAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 01 Apr 2025 19:53:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/1] Migration patches for 2025-04-01
Date: Tue,  1 Apr 2025 16:53:52 -0300
Message-Id: <20250401195353.803-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.29 / 50.00]; BAYES_HAM(-2.99)[99.95%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

The following changes since commit 0f15892acaf3f50ecc20c6dad4b3ebdd701aa93e:

  Merge tag 'pull-riscv-to-apply-20250328' of https://github.com/alistair23/qemu into staging (2025-03-28 08:06:53 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250401-pull-request

for you to fetch changes up to c0b32426ce56182c1ce2a12904f3a702c2ecc460:

  migration: fix SEEK_CUR offset calculation in qio_channel_block_seek (2025-03-31 09:17:01 -0300)

----------------------------------------------------------------
Migration pull request

Fix QIOChannelBlock's seek routine

----------------------------------------------------------------

Marco Cavenati (1):
  migration: fix SEEK_CUR offset calculation in qio_channel_block_seek

 migration/channel-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.35.3


