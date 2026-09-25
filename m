Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1855EC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82G-0006ei-1X; Fri, 25 Sep 2026 11:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82E-0006eX-JG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82C-0004ap-MQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 873301F44E;
 Fri, 25 Sep 2026 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IgUyjCll8K8mhmXcsVbbTXtZgBusoBn4BfQWClBlkNw=;
 b=qXMVhnFYrKObTRScg54N5sUABCj9hha6JU1UQx9+uC6uDbclWgMCKpFWJIKuhMcl9DabJn
 u10XhnCGF/FrM4LtNpemlHI7b63zY26+wn6saKCQJxYe7B5SkikW6WtlfjpyoE4KrkbcUU
 zjEAnzTNtPb8pRf7mNhuQ8A/McPLSaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IgUyjCll8K8mhmXcsVbbTXtZgBusoBn4BfQWClBlkNw=;
 b=dZsiHIvYcA92oN6xXMYdAIpdqlv6aa3PL7OUy9WSjD583Hn58r4GwulQ+8Xfphlkf/yI3C
 oj9FWFt6OLVwShBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IgUyjCll8K8mhmXcsVbbTXtZgBusoBn4BfQWClBlkNw=;
 b=Dytbo5bC7bW01L+vPF2k2YnU6l+jI8HoY9VGoOqYsjQ1Ky+ls2+xMgvsUmAWxq2OKEgUKO
 82UN3I9XSPu3CZZR8xIw/0vGAuOloKoAgEZQs7uKvN830fpE+nWOQqogX3x69GEVpKgezF
 tc2Bpo3eVirgfOkv9oXY6q9yEHquDog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IgUyjCll8K8mhmXcsVbbTXtZgBusoBn4BfQWClBlkNw=;
 b=l2Yl46JWr0hrJVaiA210el4y0GFOR/H1twl0MlgMFsblSnnWRFjKhHe9RF5dYZdXcTzt5b
 u1qu+RhXyslPGLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8249E132C9;
 Fri, 25 Sep 2026 15:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 00/19] Migration patches for 2026-09-25
Date: Fri, 25 Sep 2026 12:39:51 -0300
Message-ID: <20260925154010.599247-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The following changes since commit 3876503faff51ce3a132dbbd0ab42c10f2269319:

  Merge tag 'target-misc-20260924' of https://github.com/philmd/qemu into staging (2026-09-24 13:30:19 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20260925-pull-request

for you to fetch changes up to bf8156b03d263a66c00707d38b3f852bd9560fb0:

  docs/migration: document that postcopy can be used with multifd (2026-09-25 11:29:14 -0300)

----------------------------------------------------------------
Migration pull request

- RDMA migration fixes and performance improvements
- Updates of call sites to new vmstate APIs (bool+errp)
- Removal of open-coded handling of QAPI structures
- Documentation updates and other minor fixes

----------------------------------------------------------------

Bin Guo (1):
  docs/migration: document that postcopy can be used with multifd

Fabiano Rosas (7):
  migration/options.c: Don't export migrate_tls_opts_free
  migration: Rename variables in qmp_migrate_set_parameters
  migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
  migration: Merge parameter structs instead of assigning one by one
  migration: Open code migrate_params_apply
  migration: Stop freeing s->parameters members individually
  migration: Use migrate_params_free during finalize

Marc-André Lureau (1):
  migration: remove duplicate VMSTATE_STRUCT_VARRAY

Markus Armbruster (1):
  qapi/migration: Make migration parameter @local consistently unstable

Vladimir Sementsov-Ogievskiy (2):
  tests/unit/test-vmstate: move to new migration APIs
  migration/vmstate-types: convert vmstate_info_g_byte_array to new APIs

Yanfei Xu (7):
  migration/rdma: Fix write-side shutdown
  migration/rdma: Post initial receive before accepting
  migration/rdma: Retry control sends on full queue
  migration/ram: Add RAM round synchronization notifiers
  migration/rdma: Drain writes at RAM round boundaries
  migration/rdma: Allow multiple in-flight writes per chunk
  migration/rdma: Remove unused transit bitmap

 docs/devel/migration/postcopy.rst |  26 ++
 include/migration/vmstate.h       |  10 -
 migration/migration.c             |   3 +-
 migration/multifd-nocomp.c        |  24 ++
 migration/options.c               | 383 ++++++++----------------------
 migration/options.h               |   2 +-
 migration/ram.c                   |  45 +++-
 migration/ram.h                   |  12 +
 migration/rdma.c                  | 186 ++++++++-------
 migration/trace-events            |   7 +-
 migration/vmstate-types.c         |  17 +-
 qapi/migration.json               |   6 +-
 tests/unit/test-vmstate.c         | 118 +++------
 13 files changed, 351 insertions(+), 488 deletions(-)

-- 
2.53.0


