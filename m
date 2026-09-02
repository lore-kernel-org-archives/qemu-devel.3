Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5174EC624D7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFo-0000sa-3c; Wed, 02 Sep 2026 18:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFm-0000rV-T0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:22 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFj-0002ME-NK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C438C1F890;
 Wed,  2 Sep 2026 22:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VECbQ16Pyfwt+Km5tvLWXVmNjwfcVmnaqwsu/9T7pLQ=;
 b=l07+U9FU8lYcNz6sfSMcNrX44zKga9ucFPfrU7pchmiCJ6prCb7WiH2ksLJd7w7FM7Adou
 yrZtfe+OpbRkPSvwksAd6obvrRvWoaqfXVMI9dlgmfg3zjMyHX3wT7wotN0S9NUqKVWMfa
 hpUYICgVBVDkWKVJUSUCfHL+Nj6xDl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VECbQ16Pyfwt+Km5tvLWXVmNjwfcVmnaqwsu/9T7pLQ=;
 b=4+Sx/FdTNlJn1d5mkIA5ErSVa4lIJnmsFvBWU6hj/f8WkBAF6jR0u/7YhjAleAVJY/skqG
 SIQQ6xCFAE+ZLCDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=psbeF0cm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GzXuwJBj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VECbQ16Pyfwt+Km5tvLWXVmNjwfcVmnaqwsu/9T7pLQ=;
 b=psbeF0cm7YSmyuAxavbKUQS5Kfjvnzc8fD4KE/tl3okmVOTAdAr6eQ2P6Xqz6xOCW7SGSY
 VjB95o3lBXARkMkNWdgTglfpMg11msxciG3lTCBSKn253foKQFhAl57E6Mop0BdmAzIsY8
 v8dbEQAJhHB92z2RHZPhF8v/ideyvZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VECbQ16Pyfwt+Km5tvLWXVmNjwfcVmnaqwsu/9T7pLQ=;
 b=GzXuwJBjZgIaTRLZo4zIaSSUXZUW/Oc46uvBYkxq71Jsb47Qhs0h+8rJ/inNYbNmLoI3mM
 2p/F2jiDBUo41/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8A0B13515;
 Wed,  2 Sep 2026 22:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +hm6LSSgmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 00/18] migration: MigrationParameters changes
Date: Wed,  2 Sep 2026 19:15:28 -0300
Message-ID: <20260902221547.1812481-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C438C1F890
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,gitlab.com:url];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, gitlab.com:url]
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
  migration: Validate that all params are set for query
  migration: Use keyval input visitor in HMP set command
  migration: Change HMP 'info migrate_parameters' output
  migration: Use output visitor in info command
  migration: Rewrite migrate_set_parameter_completion using QDict
  qapi/migration: Remove MigrationParameter
  migration: Add capabilities into MigrationParameters
  migration: Remove s->capabilities
  qapi/migration: Deprecate capabilities commands

 docs/about/deprecated.rst          |  13 +
 migration/migration-hmp-cmds.c     | 465 ++++++----------
 migration/migration.c              |  17 +-
 migration/migration.h              |   2 +-
 migration/options.c                | 848 ++++++++++++++---------------
 migration/options.h                |  26 +-
 migration/savevm.c                 |   8 +-
 qapi/migration.json                | 170 ++++--
 scripts/checkpatch.pl              |  11 +-
 tests/qemu-iotests/300             |  20 +-
 tests/qtest/migration/misc-tests.c | 460 ++++++++++++++++
 11 files changed, 1218 insertions(+), 822 deletions(-)

-- 
2.53.0


