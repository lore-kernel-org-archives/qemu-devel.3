Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E649D5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGcn-0002Vt-5z; Mon, 15 Dec 2025 17:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGcm-0002Vk-9j
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:00 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGck-0002Sj-CY
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:00 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A58FE3378B;
 Mon, 15 Dec 2025 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ge9ZSOmBMwrYVMvliex73uWSmdoFtdrh8ldHv24znJw=;
 b=LoLGdoczTnZjZttusd3+j/FIohstKe5sLBRHrOH1v00/MUZzsZ0VZmYG981/T7Q4j9nW3K
 FukpfKfglEzLJLgoJZ9M7DGD/z1XPG8o0Q4rtS3la52jIoyOO44fTCTWOsdZ/2FL2kQUnf
 WHlPvZVnJrbyXV0jbDTbNDNc26bgInM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ge9ZSOmBMwrYVMvliex73uWSmdoFtdrh8ldHv24znJw=;
 b=7mIBXE6C/eXAZyXyw3bTbvRX2PAOUPPMea4E1Fw4IXH0W9kaLYBCMd+SfdahvITXnPX4Go
 b3BD1lPJD54iEnAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ge9ZSOmBMwrYVMvliex73uWSmdoFtdrh8ldHv24znJw=;
 b=DBPoRYRkIH3ta6anUkOqnWV3/9Tx4htb6uUoyi+vfIOstaJfrhVBBrFUpWgNa7dhLYHvhz
 vc5MZEqye44lpHvS7xmhtmZsUA3W594hfjSPZkw0+pRdZCag/MBq+EAWcnZwulCwNb4Ncn
 J/aEr36fo2I9oDk8IbuBO0WHcTmVCN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ge9ZSOmBMwrYVMvliex73uWSmdoFtdrh8ldHv24znJw=;
 b=FfgBHzcB/2VG8eZgCy9/4aiEBgU+uGk5tkWr435lv7TLWtPrtAUamIwd4RTBi3QtELf+Ej
 G3DwOgM+Z9Tbw9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E68B3EA63;
 Mon, 15 Dec 2025 22:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rb9KNBSFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:00:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	armbru@redhat.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 00/51] migration: Unify capabilities and parameters
Date: Mon, 15 Dec 2025 18:59:46 -0300
Message-ID: <20251215220041.12657-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Hi, the scope of this series is the same as the previous versions, but
to be explicit, these are various parts of which it's comprised:

1) Remove duplication of migration parameters documentation in
   migration.json.

2) Merge migration capabilities and parameters in MigrationState (as
   visible internally in migration code).

3) Deprecate migration capabilities QMP commands. Functionality
   previously provided by "capabilities" commands are now provided by
   "parameters" commands.

4) Introduce new 'config' argument to migration commands taking the
   entire set of options to use for a migration. Obsoletes the usage
   of migrate-set-parameters, except for "runtime" options, which are
   as of yet uncovered by this proposal.

5) Adapt all migration-test(s) to use the new config API exclusively.

Notable changes in this v3:

- Added the setter for the new StrOrNull qdev property
- Move the visitor code into a new QAPI_MERGE macro
- Converted all tests to use config
  - Unfortunate side-quest: rework the TLS test hooks to support
    setting options before migrate_start.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2216127826

v2:
https://lore.kernel.org/r/20250630195913.28033-1-farosas@suse.de

v1:
https://lore.kernel.org/r/20250603013810.4772-1-farosas@suse.de

RFC:
https://lore.kernel.org/r/20250411191443.22565-1-farosas@suse.de

Fabiano Rosas (51):
  migration: Fix leak of block_bitmap_mapping
  migration: Fix leak of cpr_exec_command
  migration: Add a qdev property for StrOrNull
  tests/qtest/migration: Add a NULL parameters test for TLS
  migration: Normalize tls arguments
  migration: Remove MigrateSetParameters
  qapi/migration: Don't document MigrationParameter
  migration: Run a post update routine after setting parameters
  migration: Add a flag to track block-bitmap-mapping input
  migration: Remove checks for s->parameters has_* fields
  migration: Do away with usage of QERR_INVALID_PARAMETER_VALUE
  migration: Extract code to mark all parameters as present
  migration: Use QAPI_CLONE_MEMBERS in query_migrate_parameters
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_test_apply
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
  qapi: Add QAPI_MERGE
  migration: Use QAPI_MERGE in migrate_params_test_apply
  migration: Cleanup hmp_info_migrate_parameters
  migration: Add capabilities into MigrationParameters
  migration: Remove s->capabilities
  qapi/migration: Deprecate capabilities commands
  migration: Store the initial values used for s->parameters
  migration: Allow migrate commands to provide the migration config
  migration: Allow incoming cmdline to take config
  tests/qtest/migration: Pass MigrateCommon into test functions
  tests/qtest/migration: Pass MigrateStart into cancel tests
  tests/qtest/migration: Fix misuse of listen_uri
  tests/qtest/migration: Stop invoking migrate_incoming from hooks
  tests/qtest/migration: Add config QDict
  tests/qtest/migration: Add temporary code to toggle usage of config
  tests/qtest/migration: Add a function for default capabilities
  tests/qtest/migration: Adapt convergence routines to config
  tests/qtest/migration: Adapt the incoming cmdline for config passing
  tests/qtest/migration: Use migrate_incoming_qmp where possible
  tests/qtest/migration: Add a config parameter to migrate_qmp functions
  tests/qtest/migration: Move tls hook data out of specific hooks
  tests/qtest/migration: Add new hook with data
  tests/qtest/migration: TLS x509: Refactor to use full hook
  tests/qtest/migration: TLS x509: Add init/cleanup routines
  tests/qtest/migration: TLS PSK: Refactor to use full hook
  tests/qtest/migration: TLS PSK: Add init/cleanup routines
  tests/qtest/migration: Remove multifd compression hook
  tests/qtest/migration: Convert postcopy tests to use config
  tests/qtest/migration: Convert TLS PSK tests to use config
  tests/qtest/migration: Convert TLS x509 tests to use config
  tests/qtest/migration: Convert compression tests to use config
  tests/qtest/migration: Convert file tests to use config
  tests/qtest/migration: Convert misc-tests to use config
  tests/qtest/migration: Convert precopy tests to use config
  tests/qtest/migration: Remove migrate_set_capabilities and code around
    it
  tests/qtest/migration: Further simplify TLS tests

 docs/about/deprecated.rst                 |   10 +
 include/qapi/type-helpers.h               |   29 +
 migration/migration-hmp-cmds.c            |  503 ++++++---
 migration/migration.c                     |   52 +-
 migration/migration.h                     |   14 +-
 migration/options.c                       | 1183 ++++++++++-----------
 migration/options.h                       |   30 +-
 migration/page_cache.c                    |    6 +-
 migration/ram.c                           |    5 +-
 migration/savevm.c                        |    8 +-
 migration/tls.c                           |    2 +-
 qapi/migration.json                       |  569 ++++------
 qapi/pragma.json                          |    1 +
 system/vl.c                               |  111 +-
 tests/qtest/migration/compression-tests.c |  179 ++--
 tests/qtest/migration/cpr-tests.c         |  137 +--
 tests/qtest/migration/file-tests.c        |  209 ++--
 tests/qtest/migration/framework.c         |  158 +--
 tests/qtest/migration/framework.h         |   29 +-
 tests/qtest/migration/migration-qmp.c     |   64 +-
 tests/qtest/migration/migration-qmp.h     |   21 +-
 tests/qtest/migration/migration-util.c    |   72 +-
 tests/qtest/migration/migration-util.h    |    9 +-
 tests/qtest/migration/misc-tests.c        |  132 +--
 tests/qtest/migration/postcopy-tests.c    |   80 +-
 tests/qtest/migration/precopy-tests.c     |  535 +++++-----
 tests/qtest/migration/tls-tests.c         |  897 +++++++---------
 tests/qtest/virtio-net-failover.c         |   24 +-
 28 files changed, 2512 insertions(+), 2557 deletions(-)

-- 
2.51.0


