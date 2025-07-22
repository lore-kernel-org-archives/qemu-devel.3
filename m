Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E4BC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 23:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueMd5-0002GR-Qt; Tue, 22 Jul 2025 19:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMct-000290-Di
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:30 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMcp-0007p4-UY
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 959B11F789;
 Tue, 22 Jul 2025 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvU2p+cM0qQ+/YqjGMn880LSpJ+Za0whTbf2cEkOYl8=;
 b=G4uijM71n4nlf+9tnABm/wQ99uvZ9sfrX+vbMS/n7zO5ZSKiw6571OWlZQBYTwi67j2w6S
 pw1D1ixXf+hKQDSo3yz6etYBI1UCn1UZEMAiHaLXhsxqcCHpKb+QtpxzYKFoi1f9b6h8lQ
 d9v2/DlcttJAxtA1dGesVm32BCXOPd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvU2p+cM0qQ+/YqjGMn880LSpJ+Za0whTbf2cEkOYl8=;
 b=mSt93Z2DU3QYlAgoqvM4blddN4+zF1FMde68FHy0ov8pzCAxkm8Ziyq/s9TwjdSeO6FcA/
 0hcTyM0DDOcpkdCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TDpZAmzP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="glmnI7P/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvU2p+cM0qQ+/YqjGMn880LSpJ+Za0whTbf2cEkOYl8=;
 b=TDpZAmzPiCKj302AE8+kuYU3hwc85E0JqJl2ub/ZRgxMj1UcOU39WU8z0mQHIZ6P/CpJUZ
 ZiEdP3zTWq4m5uNzD5LZi++Aun5FFGBEbRyTL/5tGMzAK77Axi45DPv6Cs7uDR9tKurFsE
 D14dy40se8yLXGL30RL6341yZTQs0mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bvU2p+cM0qQ+/YqjGMn880LSpJ+Za0whTbf2cEkOYl8=;
 b=glmnI7P/UrLoDEXf63P5RquWjROgGwb2sdpMQvwd1VNpIYS0PnqslXlgXfIIAcA8fah/+X
 J2uVdxVfW/ISJCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8049F13A32;
 Tue, 22 Jul 2025 23:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gPEkD9ohgGiqOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Jul 2025 23:42:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/7] Migration patches for 2025-07-22
Date: Tue, 22 Jul 2025 20:42:08 -0300
Message-Id: <20250722234215.6807-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 959B11F789
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi, checkpatch.pl complains about patch 4/7 due to the generated
meson-buildoptions.sh file. Please ignore.

The following changes since commit 9e601684dc24a521bb1d23215a63e5c6e79ea0bb:

  Update version for the v10.1.0-rc0 release (2025-07-22 15:48:48 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250722-pull-request

for you to fetch changes up to 0db6f798024ea6f57ecf2020209b761b50a01d71:

  crypto: add tracing & warning about GNUTLS countermeasures (2025-07-22 19:39:30 -0300)

----------------------------------------------------------------
Migration pull request

- Fixes to postcopy blocktime latency display code
- Fix to QMP error message (not)shown when postcopy fails
- Workaround to a GNUTLS bug that crashes QEMU

----------------------------------------------------------------

Daniel P. Berrangé (5):
  migration: show error message when postcopy fails
  crypto: implement workaround for GNUTLS thread safety problems
  io: add support for activating TLS thread safety workaround
  migration: activate TLS thread safety workaround
  crypto: add tracing & warning about GNUTLS countermeasures

Fabiano Rosas (2):
  migration: HMP: Fix possible out-of-bounds access
  migration: HMP: Fix postcopy latency distribution label

 crypto/tlssession.c            | 103 ++++++++++++++++++++++++++++++++-
 crypto/trace-events            |   2 +
 include/crypto/tlssession.h    |  14 +++++
 include/io/channel.h           |   1 +
 io/channel-tls.c               |   5 ++
 meson.build                    |   9 +++
 meson_options.txt              |   2 +
 migration/migration-hmp-cmds.c |  10 ++--
 migration/tls.c                |   9 +++
 scripts/meson-buildoptions.sh  |   5 ++
 10 files changed, 152 insertions(+), 8 deletions(-)

--
2.35.3

