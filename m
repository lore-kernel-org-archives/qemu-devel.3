Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC69D1061B1C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HvL-0003la-RY; Mon, 30 Mar 2026 15:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7HvI-0003kM-DF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:16 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w7HvG-0005BU-Cp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 101064D24C;
 Mon, 30 Mar 2026 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BV6/ieqDhLD55ea54Y2LTQVshcZ5mIEbRV4dLloXh2c=;
 b=hsyTAimgHLIiIUYHfZYi4MUVLudzhJ3yaERv4WPIklM0qyFBqgPIulArb2Wc9c6U6obv2k
 Vw8gLcWe6voBLnXyd/U/hEtnF2QP+uz+M07zUeJVeRucGgglLFbwZ/xcWXudEyDUkI2gTo
 TltzYAh3nA4tV/i1Y75yPQkM/ZliNiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BV6/ieqDhLD55ea54Y2LTQVshcZ5mIEbRV4dLloXh2c=;
 b=IZA958xeYsxXHTp56vugzTpg5yW/tTh9j4L4kTM3sAfjixhgi2AzyGll2ih5Yz8iRmRFpu
 4eKiKh1HTPmDKBCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G6AzIfxD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZpDo5flX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BV6/ieqDhLD55ea54Y2LTQVshcZ5mIEbRV4dLloXh2c=;
 b=G6AzIfxDcf91/nrOS+3D6jnlrMr/vLhvB8cznhnJ0NryUhDYojnIInoJCmnLAgerIaWEzq
 bS/kZ9iuuSYmCsOOjrKLCaeyfT2NFbagg7I3anAL1Y5lJrgO3Yx8+9tHQLBrO/dFt47fjc
 c46M0g9qvXTtJs6b0ZdKAwNGfvO/jl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BV6/ieqDhLD55ea54Y2LTQVshcZ5mIEbRV4dLloXh2c=;
 b=ZpDo5flXZT5ux/opPu7vNKCC6UXhsHZaMg2iCmP2IDgxIrJ74WmfhPeGfhuHqD5u/Jl+xY
 UrWyMKOYe/XVN/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 452FD4A0A2;
 Mon, 30 Mar 2026 19:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eMV1BWbJymlGdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Mar 2026 19:05:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/3] Migration patches for 2026-03-30
Date: Mon, 30 Mar 2026 16:05:05 -0300
Message-ID: <20260330190508.8634-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, gitlab.com:url,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 101064D24C
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

The following changes since commit e389503e73f1726c997531447288ce154394d07a:

  Merge tag 'pull-request-2026-03-30' of https://gitlab.com/thuth/qemu into staging (2026-03-30 11:50:24 +0100)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260330-pull-request

for you to fetch changes up to 6f33b6eebb7d406871150b0285c36454a1b4d0d3:

  tests/qtest/migration: Fix slow test dirty_limit (2026-03-30 10:48:12 -0300)

----------------------------------------------------------------
Migration pull request

- Fix dirty limit (-m thorough) test
- Fix a few error message strings

----------------------------------------------------------------

Fabiano Rosas (1):
  tests/qtest/migration: Fix slow test dirty_limit

Markus Armbruster (2):
  migration: Fix up error message for max-cpu-throttle
  migration: Fix references to parameter names in error messages

 migration/options.c                   | 36 +++++++++++++--------------
 tests/qtest/migration/precopy-tests.c |  4 +--
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.51.0


