Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF34C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Gd4-0003Jv-2o; Mon, 14 Sep 2026 20:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6Gd1-0003Jn-Vh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:27 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x6Gd0-0004mL-8z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:02:27 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF30421E1B;
 Tue, 15 Sep 2026 00:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7vT2vUzn9gWXCh5K8wx9bQMsVYDGrMwJM+9uZRN6ul0=;
 b=oVq7ep59Ajftdalk1xg1TrRvseZXaYciXCm6hE02eKx4Cl/VqbE6A9hpmjIb3bNRqiAlI5
 jh6owSucxDw3d4OfUG9jbyFfvMhSlo54AZrTA+Pzx3Mxn7REuXvIOCWL9oPZ8V+espm1OR
 MS9Jc8ywNWVaxvA5voMa43QgRH5IEMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7vT2vUzn9gWXCh5K8wx9bQMsVYDGrMwJM+9uZRN6ul0=;
 b=eslv/d+/vDSCCMVRoTbfN+r7vfXGqZnU26CZPWerNaU407vD4YnLtzOVRBKjvuuH+1fPjh
 TVkhhiIS0R0kFwAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789430536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7vT2vUzn9gWXCh5K8wx9bQMsVYDGrMwJM+9uZRN6ul0=;
 b=BB0HLqJOuni8bUsBv6njOhpePE/84Ymrxz8Ifzlnfy92bRErNN7dPYAUEVVGGK8Ymp4Mxo
 IandeZyZfVw3Bgli7YKFQ7adHK6J91diQF7fBXSBdDTo8slPK9twWsUqRuCxSDn7jkIt2r
 octt0nv9Qf44MHTMaGaOtefXDf2ed/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789430536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7vT2vUzn9gWXCh5K8wx9bQMsVYDGrMwJM+9uZRN6ul0=;
 b=N2p+4ZqydmihsXSnLkrzdU+aJaZt+cJ49q4K9n22FJ6EIT3xeGTXKE4rMUyP/gUO3QQqYP
 GdAssbF5zGCOdHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B41A6136D9;
 Tue, 15 Sep 2026 00:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gk6xFQeLqGqIFAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Sep 2026 00:02:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 00/20] migration: MigrationParameters changes
Date: Mon, 14 Sep 2026 21:01:48 -0300
Message-ID: <20260915000209.3692668-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,gitlab.com:url];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

since v2:

- Better handling the cpr-exec-command special case by converting the
  string input to a QList.

- New clone visitor to replace the manual setting of has_* fields. It
  now happens once at instance_init before s->parameters is even
  available to the rest of the code.

- Removed MigrationParameter.

- Added some line breaks and spacing to the block-bitmap-mapping
  output (and lists in general).

- Simplified the completion test by using g_ptr_array.

- Updated the parameters test to call query-migrate since there's no
  MigrateParameter_lookup to list the parameters names anymore.

- Rebased on master and picked-up the new 'local' parameter.

(apologies if I might have missed some r-bs, my 'b4 trailers' is
broken at the moment)

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2848741815

v2:
https://lore.kernel.org/r/20260909214509.237309-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20260902221547.1812481-1-farosas@suse.de

Fabiano Rosas (20):
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
  migration: HMP: Change bandwidth parameters expected input unit
  migration: Change HMP 'info migrate_parameters' output
  migration: Use keyval input visitor in HMP set command
  migration: Use output visitor in info command
  migration: Rewrite migrate_set_parameter_completion using QDict
  migration: Add capabilities into MigrationParameters
  migration: Remove s->capabilities
  qapi/migration: Deprecate capabilities commands
  migration: Set the parameters present flag with a clone visitor
  qapi: Remove MigrationParameter

 docs/about/deprecated.rst          |  13 +
 include/qapi/clone-visitor.h       |   1 +
 migration/migration-hmp-cmds.c     | 445 +++++-----------
 migration/migration.c              |  19 +-
 migration/migration.h              |   2 +-
 migration/options.c                | 789 +++++++++++------------------
 migration/options.h                |  29 +-
 migration/savevm.c                 |   8 +-
 qapi/migration.json                | 168 ++++--
 qapi/qapi-clone-visitor.c          |  13 +
 scripts/checkpatch.pl              |  11 +-
 tests/qemu-iotests/300             |  20 +-
 tests/qtest/migration/misc-tests.c | 560 ++++++++++++++++++++
 13 files changed, 1173 insertions(+), 905 deletions(-)

-- 
2.53.0


