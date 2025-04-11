Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC0AC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Jq5-0003uw-Eh; Fri, 11 Apr 2025 15:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jq2-0003u7-Nm
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:14:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jpz-0005x5-Io
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:14:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F186221195;
 Fri, 11 Apr 2025 19:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pgMWrBxWHqCwnayEwE/uhH62nltucUBQGKFVIP5ZajQ=;
 b=zqzgAEZKibzCkhugqIrh3wDcgutA0/TpbeKJmwUU8LXMs7cluhh+tsFq3aSWhKTq4W2cY6
 /yW5XSEfhLTheZfZ2koppj98cy732wcDckmrfa3/zBAmsKHDU5s2Do+yo3WWOR7KkKNoNW
 /HOgjzIZZNFsQq/3sEzPmPD+fEwY2eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pgMWrBxWHqCwnayEwE/uhH62nltucUBQGKFVIP5ZajQ=;
 b=BXIAAKdADn4cLU2cjt/Fdvy6WYlC/6jOAUvDL2jZwYhjftPPsY9RNjxMRj4UhFOsWSIapz
 8LR90gz1ttgvE2AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zqzgAEZK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BXIAAKdA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pgMWrBxWHqCwnayEwE/uhH62nltucUBQGKFVIP5ZajQ=;
 b=zqzgAEZKibzCkhugqIrh3wDcgutA0/TpbeKJmwUU8LXMs7cluhh+tsFq3aSWhKTq4W2cY6
 /yW5XSEfhLTheZfZ2koppj98cy732wcDckmrfa3/zBAmsKHDU5s2Do+yo3WWOR7KkKNoNW
 /HOgjzIZZNFsQq/3sEzPmPD+fEwY2eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pgMWrBxWHqCwnayEwE/uhH62nltucUBQGKFVIP5ZajQ=;
 b=BXIAAKdADn4cLU2cjt/Fdvy6WYlC/6jOAUvDL2jZwYhjftPPsY9RNjxMRj4UhFOsWSIapz
 8LR90gz1ttgvE2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7070813886;
 Fri, 11 Apr 2025 19:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hEcWDCZq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:14:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 00/13] migration: Unify capabilities and parameters
Date: Fri, 11 Apr 2025 16:14:30 -0300
Message-Id: <20250411191443.22565-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F186221195
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Hi everyone, I did a cleanup (if it can be called that) of the user
input validation for capabilities and parameters and turned the two
concepts into a single 'options' to be stored in a MigrationConfig
object.

RFC mostly because this idea exposes (pre-existing) issues around how
to validate capabilities that are mutually excludent and options that
need to be enabled together.

I'd also like some feedback on what approach to take regarding
compatibility.

Let me know what you think. I know it's a lot to look at, any comments
are welcomed and don't worry on trying to cover everything. This is
long-term work. Thank you.

The reasons for this work are:
------------------------------

Capabilities are just boolean parameters that can only be set before
migration. For the majority of the code there's no distinction between
the two.

Having a single structure allows the qmp_migrate command to receive
the migration configuration all at once:

{ 'command': 'migrate',
  'data': {'*uri': 'str',
           '*channels': [ 'MigrationChannel' ],
+	   '*config': 'MigrationConfig',
           '*detach': 'bool', '*resume': 'bool' } }

+{ 'struct': 'MigrationConfig',
+  'data': { '*announce-initial': 'size',
+            '*announce-max': 'size',
+	     ...   <-- all parameters and capabilities as optional
+} }

(optionally fold 'detach' and 'resume' into MigrationConfig)

Other benefits of a single configuration struct:

- allows the removal of two commands:
  migrate-set-capabilities/query-capabilities which simplifies the
  user interface (migrate-set-parameters, or similar, is still
  required for options that need to be adjusted during migration);

- removes (some of) the triplication in migration.json;

- simplifies the (future) work of implementing a handshake feature for
  migration: only one structure to negotiate over and less reliance on
  commands other than 'migrate'.

The major changes in this series are:
-------------------------------------

- Add a (QAPI) type hierarchy:

                               MigrationConfigBase
                              (most config options)
                                       |
             +-------------------------|-------------------------+
             |                         |                         |
    MigrationConfig          MigrationParameters        MigrateSetParameters
 (internal use, s->config,   (compat with               (compat with
 new query/set-config)       query-migrate-parameters)  migrate-set-parameters)

- Remove migrate_params_test_apply. This function duplicates a lot of code;

- Add compatibility routines to convert from the existing QMP user
  input into the new MigrationConfig for internal use;

- Merge capabilities and parameters validation into one function;

- Convert qmp_migrate and qmp_migrate_incoming to use the new structure.

Open questions:
---------------

- Deprecations/compat?

I think we should deprecate migrate-set/query-capabilities and everything to do
with capabilities (specifically the validation in the JSON at the end of the
stream).

For migrate-set/query-parameters, we could probably keep it around indefinitely,
but it'd be convenient to introduce new commands so we can give them new
semantics.

- How to restrict the options that should not be set when the migration is in
progress?

i.e.:
  all options can be set before migration (initial config)
  some options can be set during migration (runtime)

I thought of adding another type at the top of the hierarchy, with
just the options allowed to change at runtime, but that doesn't really
stop the others being also set at runtime. I'd need a way to have a
set of options that are rejected 'if migration_is_running()', without
adding more duplication all around.

- What about savevm?

None of this solves the issue of random caps/params being set before
calling savevm. We still need to special-case savevm and reject
everything. Unless we entirely deprecate setting initial options via
set-parameters (or set-config) and require all options to be set as
savevm (and migrate) arguments.

- HMP?

Can we convert the strings passed via hmp_set_parameters without
having an enum of parameters? Duplication problem again.

- incoming defer?

It seems we cannot do the final step of removing
migrate-set-capabilites before we have a form of handshake
implemented. That would take the config from qmp_migrate on source and
send it to the destination for negotiation.

- last but definitely not least:

Changing caps from a list of bools into struct members complicates the
validation because some caps must be checked against every other cap
already set. And the user could be playing games with switching caps
on and off, so there's a lot of redundant checking the must be
made. The current code already has a bunch of gaps in that regard.

For this series I opted to not check has_* fields for capabilities,
i.e. to validate them all every time migrate_config_check() is called.

Fabiano Rosas (12):
  migration: Normalize tls arguments
  migration: Run a post update routine after setting parameters
  migration: Fix parameter validation
  migration: Reduce a bit of duplication in migration.json
  migration: Remove the parameters copy during validation
  migration: Introduce new MigrationConfig structure
  migration: Replace s->parameters with s->config
  migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE
  migration: Replace s->capabilities with s->config
  migration: Merge parameters and capability checks
  [PoC] migration: Add query/set commands for MigrationConfig
  [PoC] migration: Allow migrate commands to provide the migration
    config

Markus Armbruster (1):
  migration: Fix latent bug in migrate_params_test_apply()

 migration/migration-hmp-cmds.c |    5 +-
 migration/migration.c          |   52 +-
 migration/migration.h          |    5 +-
 migration/options.c            | 1386 ++++++++++++++++----------------
 migration/options.h            |   25 +-
 migration/page_cache.c         |    6 +-
 migration/ram.c                |    9 +-
 migration/savevm.c             |    8 +-
 migration/tls.c                |    2 +-
 qapi/migration.json            |  571 +++++++------
 system/vl.c                    |    3 +-
 11 files changed, 1079 insertions(+), 993 deletions(-)

-- 
2.35.3


