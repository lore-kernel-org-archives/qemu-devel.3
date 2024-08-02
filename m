Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4158FC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtEx-0002Wj-Oh; Fri, 02 Aug 2024 10:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZtEw-0002TP-2l
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:26:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZtEu-00072X-Bi
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:26:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 066DA1FBA2;
 Fri,  2 Aug 2024 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722608797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iKjf799ve7G93WP2Hyz66OjGZYTy6N0xIIhJuY+Sh9U=;
 b=dJH4z/hvUmiwNms5aciRkBh/6WlP5xlbNA9ojZnk6zIQoZseNk9L22eRkW+F8ccOytn8yg
 C2PLI4onZAB3+a9+fZ5KOquIA7yJ4Tz3AYFJX2gB/SkygUmjh4EFNun/8kqRnUUe/fDObs
 dOAUOUZ+U0/yh8fvUoI7FeEMHrpnzOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722608797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iKjf799ve7G93WP2Hyz66OjGZYTy6N0xIIhJuY+Sh9U=;
 b=Y+U2l4qKBI22O5ozmqQqZQj3z5Y/w8YaQNe5EdIQARPqknwLuMIyMu/G28eKowaIq1VrxA
 rb6mFTaBGdJ+ZUBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722608797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iKjf799ve7G93WP2Hyz66OjGZYTy6N0xIIhJuY+Sh9U=;
 b=dJH4z/hvUmiwNms5aciRkBh/6WlP5xlbNA9ojZnk6zIQoZseNk9L22eRkW+F8ccOytn8yg
 C2PLI4onZAB3+a9+fZ5KOquIA7yJ4Tz3AYFJX2gB/SkygUmjh4EFNun/8kqRnUUe/fDObs
 dOAUOUZ+U0/yh8fvUoI7FeEMHrpnzOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722608797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iKjf799ve7G93WP2Hyz66OjGZYTy6N0xIIhJuY+Sh9U=;
 b=Y+U2l4qKBI22O5ozmqQqZQj3z5Y/w8YaQNe5EdIQARPqknwLuMIyMu/G28eKowaIq1VrxA
 rb6mFTaBGdJ+ZUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDBDE13999;
 Fri,  2 Aug 2024 14:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MjNEJJvsrGZ2AQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Aug 2024 14:26:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/3] Migration patches for 2024-08-02
Date: Fri,  2 Aug 2024 11:26:30 -0300
Message-Id: <20240802142633.19249-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The following changes since commit c4d242501a61093a8b80ee8f6dd071c5110a100c:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-08-02 15:53:54 +1000)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20240802-pull-request

for you to fetch changes up to 0bd5b9284fa94a6242a0d27a46380d93e753488b:

  migration/multifd: Fix multifd_send_setup cleanup when channel creation fails (2024-08-02 09:47:40 -0300)

----------------------------------------------------------------
Migration pull request

- Akihiko Odaki's fix for a memory leak on ppc migration
- Fabiano's fix for asserts during multifd error handling

----------------------------------------------------------------

Akihiko Odaki (1):
  migration: Free removed SaveStateEntry

Fabiano Rosas (2):
  migration: Fix cleanup of iochannel in file migration
  migration/multifd: Fix multifd_send_setup cleanup when channel
    creation fails

 migration/file.c    |  2 --
 migration/multifd.c | 26 +++++++++++++++-----------
 migration/savevm.c  |  2 ++
 3 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.35.3


