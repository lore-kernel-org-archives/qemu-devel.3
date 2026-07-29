Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6895C55162
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDAu-0002UZ-E0; Wed, 29 Jul 2026 18:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpDAs-0002UQ-Lm
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:54:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpDAq-0003mY-U0
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:54:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBE977CD37;
 Wed, 29 Jul 2026 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785365563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LtZrzcKLFxWkllB6LI0efDZo3qkkfhtHj2KOSCBk/Rk=;
 b=uaDrXk7fkfyaBjDxVjo9sfzuorGwrc7xd5t9FVO1S11+bSKmjNbuSGf5S9c/M+F5NgWtjw
 PFLnV1VRWikriRP1RzSSA0jklWhXIcxP3JpFpiU4hBbS4ut1eFGel15xD5XMOz9QsDhk7G
 fevRdNnI22eH2GD5sdRrx1GRLZkc7j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785365563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LtZrzcKLFxWkllB6LI0efDZo3qkkfhtHj2KOSCBk/Rk=;
 b=lDaFe9lU2JoBZvaBBDmKOvQPIyBfteUHIe7AequIKO9KVZ0mhoG2AE1iI7+Q9lAt8+UJk4
 oAMFIL8HrHtB8GDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hwJQhHrP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HgyAhwPT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785365558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LtZrzcKLFxWkllB6LI0efDZo3qkkfhtHj2KOSCBk/Rk=;
 b=hwJQhHrP99xyjROehnrtgPf2WaHpvExKgFjKoh/p1aGRf5J/8GrvPOkls7ELzYO2Aojg5Q
 ANY6lXJX7/R6NVslOStH5tEzCvL4xoecIE9HjZSuKQssweXxiH1itLLcrUdHy5sOGzo42I
 rTTeHt8+ZCi93owN6ZjNnylSsr/cGJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785365558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LtZrzcKLFxWkllB6LI0efDZo3qkkfhtHj2KOSCBk/Rk=;
 b=HgyAhwPT/qIjqAlo0KXf2RHcmWXNeEtgckZaMenQ1AIESMBbqRHKeh8ZQbKPZmXBQFSESJ
 xBt/2mbquhgOv1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC793779A1;
 Wed, 29 Jul 2026 22:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bKH3IjWEamqHFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jul 2026 22:52:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH 0/4] migration: Remove extra type-checking from vmstate macros
Date: Wed, 29 Jul 2026 19:52:23 -0300
Message-ID: <20260729225227.1170574-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DBE977CD37
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,gitlab.com:url,suse.de:mid,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Fabiano Rosas (4):
  migration: Remove VMSTATE_ARRAY_INT32_UNSAFE
  migration: Introduce VMStateOffset
  migration: Remove redundant flags
  migration: Remove duplicate vmstate macros

 include/migration/vmstate.h        | 255 ++++++++++-------------------
 migration/savevm.c                 |  10 +-
 migration/vmstate.c                |  50 ++++--
 rust/bindings/migration-sys/lib.rs |  15 +-
 rust/migration/src/vmstate.rs      |  30 +++-
 rust/tests/tests/vmstate_tests.rs  |  30 ++--
 6 files changed, 177 insertions(+), 213 deletions(-)

-- 
2.53.0


