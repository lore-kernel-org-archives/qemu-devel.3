Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826F6E6F096
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Ow-00010T-3i; Tue, 23 Dec 2025 09:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Op-0000wJ-HC
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3On-0003Wm-ID
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jRBZxUkNbyZU2DM7GgNiGFqqFhV4axwRoHUxVDDi2m0=;
 b=H0MHypPPrZTXS6ZayZi5ab2tD49pnGK2ES6aGLv+GookeXfFVl1hxkxpqzW6i80+5JYIJE
 hABnAHRA1+j+OJ33WCux3xF0oYd6Kz0vTdIcj/gRAad5Nz7Me3njU1yomrILXg9DRkdlfh
 k6celxYF1JHb3IW2vMV97QQx879zAzY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-1MMeeHN8NN63cz_HKfpYcg-1; Tue, 23 Dec 2025 09:30:02 -0500
X-MC-Unique: 1MMeeHN8NN63cz_HKfpYcg-1
X-Mimecast-MFC-AGG-ID: 1MMeeHN8NN63cz_HKfpYcg_1766500202
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b22d590227so628642085a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500202; x=1767105002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jRBZxUkNbyZU2DM7GgNiGFqqFhV4axwRoHUxVDDi2m0=;
 b=s4Oos9GEBMGehSGMkrPMaHMaCyhxiI29YKnJOuqjtEr0WvYF9CpDDhbnf3G6lRuRt+
 9LhkxOPJnnwPFbt1Asa3OIA+iLUtKaNlCtiG5vBMSpk9hof3YQ4qbdnYTRYGbMYhvOnJ
 bgF7qi2TPIkNWBR97jSJIV3kBzp2DHhAD9dNeH/dPmgpQ7fJjxAf6131/EHwFIRv6S8j
 hW5laoEJAsNqPlCWdPfThDzSVn8bnLEbMBiXDWGbGp6+2GHTpRMsbgmVUSxRT/SMLr4c
 aU7iJd41Y3cK0s41n4oZbgjwGTAZVlNyaJoYhGMEIfhPZnyg/Q8P3RNqToZ5Zpi6x3Om
 Snfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500202; x=1767105002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRBZxUkNbyZU2DM7GgNiGFqqFhV4axwRoHUxVDDi2m0=;
 b=psAAGSqxy8kqpq5wbBkXStaP9pbfIq8mVeQj4laLzbQhzQbKl2v7nxY5ZPo2f8HGsH
 OMxjBe/2CPs/21bm75595RnTLgKB52uxweYu3p3cE3fT4KKkIjQvBqjBCavLILLR3JlM
 4V2Kw21lYUXrbzSdCse3f74uhEDC6D5bNevU8Z+zNXLy9wcSBLmLhTbDLuH9JBp0LD9U
 fhyPrneddKJs0afSm3YttPAb7T1DyaA4oUvzZk3OgXEmmgoGB35qXNTZ+hXYsyFyXahi
 DjIODNSEz8na0ThSSLhq4SxGLWe1pkCYhz+tIh11kMcC4vdW9uZ7z0OGoCVhiYEmlfQl
 Wrlw==
X-Gm-Message-State: AOJu0Yxj3Zk5OuFVaYj9eUAf/hilN0m7j0dUSzsTX+kY0g3qKEBdI4qL
 C8wO7mH5WgPJTwiTd4RqSAHMSRPEPCq2VKOUJVlYuil0y5VFIKOwKvywFR4PY3tVF2/AkzMAOA/
 dS54vlSlfYj4oAE+pYTLL0jeAHdY3MuKThUweexL28An6Oeaoc2xH6EbNPSs9gu9TzJzErhl6fI
 z4CmjL8ULXtG7dwu/QK+P0tpAEFy27c3mIngrOhw==
X-Gm-Gg: AY/fxX5mIq7MaI288lPgX1BIUBDkb+SiQ57NwvQUkvQ6Qcs8GkgS7C1+wB6ZE3wwZdl
 Siq0w8P+5kgPKzIN6ezZWEF2ulrfbWVr6UzuN8/nGveYMay+SvXJQOIdvT6DXagjT+UeOW7jUvS
 JoQxufKhkW8rV4+8JNaEVB+acuNjwLiDZEKeau1iqIb+HO9fcPunK8xdjutZAWipIHrMsJ2yuza
 UEUVwbrqHB2NhmC46DCqnzI8BvfMs+1ygDLKqfiMXYCZqpaxNhAODxOH+EthB/l7owFCexUjNyg
 ntAIj/fQM81UDA2OySPiaHIGISBk4Us4dMzvOU4maglAoQREWqWS0yLuGHElnMmI2rHpp2AQlpm
 08/k=
X-Received: by 2002:a05:620a:1a0d:b0:8bb:a675:aa61 with SMTP id
 af79cd13be357-8c09002798dmr2073940885a.79.1766500201961; 
 Tue, 23 Dec 2025 06:30:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEvhmed4LdmWgmZTmPga4Sjr1M5U6Po/tmuTyd/AudNHjKznqR0T/CN3RfhajV8fw5ohsBJw==
X-Received: by 2002:a05:620a:1a0d:b0:8bb:a675:aa61 with SMTP id
 af79cd13be357-8c09002798dmr2073935785a.79.1766500201239; 
 Tue, 23 Dec 2025 06:30:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:00 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 00/31] Next patches
Date: Tue, 23 Dec 2025 09:29:28 -0500
Message-ID: <20251223142959.1460293-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 8dd5bceb2f9cc58481e9d22355a8d998220896de:

  Open 11.0 development tree (2025-12-23 14:45:38 +1100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to bcb411a005fdf39b76e99c14f3618c7b70f7774d:

  MAINTAINERS: remove David from "Memory API" section (2025-12-23 09:27:02 -0500)

----------------------------------------------------------------
memory + migration pull

- Pawel's misc fixes to mapped-ram when x-ignore-share is enabled
- Peter's series to cleanup migration error reporting
- Peter's added debug property for x-ignore-shared
- Part of Fabiano's series on unify capabilities and parameters
- Chuang's log_clear optimization on unaligned ramblocks
- Maintainer file update from Ben (CPR++) and David (MemoryAPI-)

----------------------------------------------------------------

Ben Chaney (1):
  MAINTAINERS: Update reviewers for CPR

Chuang Xu (1):
  migration: merge fragmented clear_dirty ioctls

David Hildenbrand (Red Hat) (1):
  MAINTAINERS: remove David from "Memory API" section

Fabiano Rosas (15):
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
  tests/qtest/migration: Pass MigrateCommon into test functions
  tests/qtest/migration: Pass MigrateStart into cancel tests

Markus Armbruster (1):
  error: Poison g_autoptr(Error) to prevent its use

Pawel Zmarzly (4):
  migration: fix parsing snapshots with x-ignore-shared flag
  migration: Fix writing mapped_ram + ignore_shared snapshots
  scripts/analyze-migration: Rename RAM_SAVE_FLAG_COMPRESS to
    RAM_SAVE_FLAG_ZERO
  scripts/analyze-migration: Support mapped-ram snapshot format

Peter Xu (8):
  migration: Use explicit error_free() instead of g_autoptr
  Revert "error: define g_autoptr() cleanup function for the Error type"
  migration: Make migration_connect_set_error() own the error
  migration: Make multifd_send_set_error() own the error
  migration: Make multifd_recv_terminate_threads() own the error
  migration: Replace migrate_set_error() with migrate_error_propagate()
  migration: Use error_propagate() in migrate_error_propagate()
  migration/options: Add x-ignore-shared

 MAINTAINERS                               |   3 +-
 qapi/migration.json                       | 395 +---------------
 qapi/pragma.json                          |   1 +
 include/qapi/error.h                      |  20 +-
 include/system/physmem.h                  |   7 +-
 migration/migration.h                     |   9 +-
 migration/options.h                       |   1 +
 tests/qtest/migration/migration-qmp.h     |   1 +
 tests/qtest/migration/migration-util.h    |   8 +-
 accel/tcg/cputlb.c                        |   5 +-
 migration/channel.c                       |   1 -
 migration/cpr-exec.c                      |   5 +-
 migration/migration-hmp-cmds.c            |  13 +-
 migration/migration.c                     |  59 ++-
 migration/multifd-device-state.c          |   6 +-
 migration/multifd.c                       |  30 +-
 migration/options.c                       | 525 ++++++++++++----------
 migration/page_cache.c                    |   6 +-
 migration/postcopy-ram.c                  |   5 +-
 migration/ram.c                           | 102 +++--
 migration/savevm.c                        |  18 +-
 migration/tls.c                           |   2 +-
 system/memory.c                           |   2 +-
 system/physmem.c                          |  48 +-
 tests/qtest/migration/compression-tests.c | 131 +++---
 tests/qtest/migration/cpr-tests.c         |  75 ++--
 tests/qtest/migration/file-tests.c        | 202 ++++-----
 tests/qtest/migration/migration-qmp.c     |   9 +
 tests/qtest/migration/migration-util.c    |  26 +-
 tests/qtest/migration/misc-tests.c        | 112 ++---
 tests/qtest/migration/postcopy-tests.c    |  82 ++--
 tests/qtest/migration/precopy-tests.c     | 373 +++++++--------
 tests/qtest/migration/tls-tests.c         | 499 ++++++++++----------
 scripts/analyze-migration.py              |  72 ++-
 34 files changed, 1282 insertions(+), 1571 deletions(-)

-- 
2.50.1


