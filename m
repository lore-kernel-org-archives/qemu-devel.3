Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D33C79FBB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Q6q-0000UR-Np; Wed, 09 Sep 2026 17:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6o-0000TU-3e
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:34 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6l-0005KB-D8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5D81FCC4;
 Wed,  9 Sep 2026 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K5MXzp8KVQWiAS/xWpLyS2yXUQPZqTfrcLNlBEU+mbk=;
 b=R+MfZ1Xxbkv9LfvRAtuDp1WzK0paOseUTv0AnWf0Opca/vAIE2l74oj+N8FNUwQW1yAPb9
 Kdwpoatu7aArLyy5cVEnJHc8JM0mzNFp8zw9He6H8cmm4epBQ7V0OB/qNelPaIDubqS8cs
 NFmn0T69AFP8n6qSqmTMyVkWtG9P/sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K5MXzp8KVQWiAS/xWpLyS2yXUQPZqTfrcLNlBEU+mbk=;
 b=loj3agiNoNTGSh5pdV1rhMCI4maS0JGaXhkB0pOLiV8lhYSfQs0DJr/U5G9OVQh/moX7Z7
 +3XLfY6AYqKP7FCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pqlcwHLg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DCDCB+NX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K5MXzp8KVQWiAS/xWpLyS2yXUQPZqTfrcLNlBEU+mbk=;
 b=pqlcwHLgE7Tfn5ZKPD3RlwnqQpr+prPgtRXSZBHXmOBacq/sRD6CiF0+hIDq/va7z6qj5e
 knlKs+kxAns/4yzfB/uxxxxLrVJX8RpFAVGqA+CuI8a9sPCcIMFmdjZcjO9jwWtktu2LIc
 8m6YhRwOZnkaK9td6Qre+84duZPxM5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=K5MXzp8KVQWiAS/xWpLyS2yXUQPZqTfrcLNlBEU+mbk=;
 b=DCDCB+NX7Cj3u0ihHsUtUc+iXNk4vKHR3c+foOi46XSNeLxxe0n/E8lbIdWZe58CZFL4Fv
 YywqumvsyBdKoNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD5BB13223;
 Wed,  9 Sep 2026 21:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7wFDJWvToWqzawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 21:45:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 00/18] migration: MigrationParameters changes
Date: Wed,  9 Sep 2026 18:44:50 -0300
Message-ID: <20260909214509.237309-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A5D81FCC4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,gitlab.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

since v1:

- Made the commit message clearer on the checkpatch change.

- Renamed the variables in the merge function to indicate which
  structure is the one receiving the update.

- Rewrote the string parsing on the HMP test because it was allowing
  false positives and tripping on readline escape sequences.

- Dropped the has_* fields validation patch because it was simply
  doing nothing (thank you Peter for spotting it).

- Due to the above I decided to leave MigrateParameter (singular)
  untouched. The enum max is just too convenient to lose.

- Used an array instead of a switch for the capabilities compat
  function.

- Fixed the copy of MigrationCapability documentation over to
  MigrationParameters in migration.json which was not verbatim.

- Added missing return statement in migrate_params_check.

- Added CONFIG_HMP checks after rebase on master

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2834127646

---
v1:
https://lore.kernel.org/r/20260902221547.1812481-1-farosas@suse.de

Hi, this contains the pending work from my previous two series to
reduce duplication in the migration parameters handling and unify
migration parameters and capabilities.

Supersedes these series:
- [PATCH v3 00/51] migration: Unify capabilities and parameters
https://lore.kernel.org/r/20251215220041.12657-1-farosas@suse.de

- [PATCH v2 0/9] qapi: Use visitors for migration parameters handling
https://lore.kernel.org/r/20260202224101.20568-1-farosas@suse.de

I held on to the "pass full config to migration commands" changes for
now, let's put this^ scaffolding in first.

Changes from previous versions:

1) hacky qapi dealloc visitor replaced with a simple merge using
QDict.

  Suggested as one of the alternatives by Markus in:
  https://lore.kernel.org/r/871pio3d3h.fsf@pond.sub.org

This^ made me realise we've been doing manual checking in a lot of
places where a QAPI->QDict serialization would do the work
automatically, so:

2) New qtest to validate migration HMP commands.

  Good to have in general, but also this series touches that code
  heavily.

3) Rewrite of hmp_migrate_set_parameters, hmp_info_migrate_parameters
and hmp_migrate_set_parameter_completion.

  I want to remove all manual handling of migration parameters. These
  commands were the last heavy users of the "if params->has_foo,
  handle params->foo" pattern. We lose some user-friendliness here,
  but hopefully it's ok.

4) Remove MigrationParameter (singular).

  With this, migration.json now has only one place to define and
  document migration parameters, the MigrationParameters (plural).

5) New routine to validate has_* fields.

  Due to the above change, we lose MIGRATION_PARAMETER__MAX. Add a
  routine that ensures s->parameters has all has_ fields set to
  true. This is required for all the QAPI cloning and merging, etc.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2814719051

Fabiano Rosas (18):
  checkpatch: Fix checking of newlines in error messages
  migration/options.c: Don't export migrate_tls_opts_free
  migration: Rename variables in qmp_migrate_set_parameters
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
  migration: Merge parameter structs instead of assigning one by one
  migration: Open code migrate_params_apply
  migration: Stop freeing s->parameters members individually
  migration: Use migrate_params_free during finalize
  tests/qtest/migration: Add a test for HMP
  tests/qtest/migration: Add a test for HMP completion
  migration: HMP: Fix bandwidth parameters
  migration: Change HMP 'info migrate_parameters' output
  migration: Use keyval input visitor in HMP set command
  migration: Use output visitor in info command
  migration: Rewrite migrate_set_parameter_completion using QDict
  migration: Add capabilities into MigrationParameters
  migration: Remove s->capabilities
  qapi/migration: Deprecate capabilities commands

 docs/about/deprecated.rst          |  13 +
 migration/migration-hmp-cmds.c     | 457 ++++++------------
 migration/migration.c              |  17 +-
 migration/migration.h              |   2 +-
 migration/options.c                | 732 +++++++++++------------------
 migration/options.h                |  27 +-
 migration/savevm.c                 |   8 +-
 qapi/migration.json                | 140 +++++-
 scripts/checkpatch.pl              |  11 +-
 tests/qemu-iotests/300             |  20 +-
 tests/qtest/migration/misc-tests.c | 534 +++++++++++++++++++++
 11 files changed, 1155 insertions(+), 806 deletions(-)

-- 
2.53.0


