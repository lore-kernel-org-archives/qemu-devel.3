Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA45EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Cpf-0007BF-7t; Fri, 11 Apr 2025 07:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3CpU-00079D-0C
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3CpQ-0001PK-Np
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f/pn0TFqoRfF4XBZ9bUxRI27ST/I+AyTtUQG9xBXoQQ=;
 b=csKeu1p0MSdDyvXMczPs29bEbvtKfhzg+CkNBbWBNBrHNuw+npLlGjQ3Xehw7n4DDN8JBi
 0U8leNhcif6oJpOZ1hWsSYrUJtbrs+N8kRLY6qKhg3Zycc4wjU7tcX6hIVGSmTLvi5D3bQ
 ecT9ah8vCgvZ2g2IHIdwUZJzK7rmFmQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-iDogS1-sMg6u4fPwbWmDbQ-1; Fri,
 11 Apr 2025 07:45:46 -0400
X-MC-Unique: iDogS1-sMg6u4fPwbWmDbQ-1
X-Mimecast-MFC-AGG-ID: iDogS1-sMg6u4fPwbWmDbQ_1744371945
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DC8D1955BC9; Fri, 11 Apr 2025 11:45:44 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.160])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F33E18009BC; Fri, 11 Apr 2025 11:45:40 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v9 0/7] Allow to enable multifd and postcopy migration together
Date: Fri, 11 Apr 2025 17:15:27 +0530
Message-ID: <20250411114534.3370816-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

 Hello,


* This series (v9) does minor refactoring and reordering changes as
  suggested in the review of earlier series (v8). Also tried to
  reproduce/debug a qtest hang issue, but it could not be reproduced.
  From the shared stack traces it looked like Postcopy thread was
  preparing to finish before migrating all the pages.
===
67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             170.50s   81 subtests passed
===


v8: https://lore.kernel.org/qemu-devel/20250318123846.1370312-1-ppandit@redhat.com/T/#t
* This series (v8) splits earlier patch-2 which enabled multifd and
  postcopy options together into two separate patches. One modifies
  the channel discovery in migration_ioc_process_incoming() function,
  and second one enables the multifd and postcopy migration together.

  It also adds the 'save_postcopy_prepare' savevm_state handler to
  enable different sections to take an action just before the Postcopy
  phase starts. Thank you Peter for these patches.
===
67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             152.66s   81 subtests passed
===


v7: https://lore.kernel.org/qemu-devel/20250228121749.553184-1-ppandit@redhat.com/T/#t
* This series (v7) adds 'MULTIFD_RECV_SYNC' migration command. It is used
  to notify the destination migration thread to synchronise with the Multifd
  threads. This allows Multifd ('mig/dst/recv_x') threads on the destination
  to receive all their data, before they are shutdown.

  This series also updates the channel discovery function and qtests as
  suggested in the previous review comments.
===
67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             147.84s   81 subtests passed
===


v6: https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t
* This series (v6) shuts down Multifd threads before starting Postcopy
  migration. It helps to avoid an issue of multifd pages arriving late
  at the destination during Postcopy phase and corrupting the vCPU
  state. It also reorders the qtest patches and does some refactoring
  changes as suggested in previous review.
===
67/67 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             161.35s   73 subtests passed
===


v5: https://lore.kernel.org/qemu-devel/20250205122712.229151-1-ppandit@redhat.com/T/#t
* This series (v5) consolidates migration capabilities setting in one
  'set_migration_capabilities()' function, thus simplifying test sources.
  It passes all migration tests.
===
66/66 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             143.66s   71 subtests passed
===


v4: https://lore.kernel.org/qemu-devel/20250127120823.144949-1-ppandit@redhat.com/T/#t
* This series (v4) adds more 'multifd+postcopy' qtests which test
  Precopy migration with 'postcopy-ram' attribute set. And run
  Postcopy migrations with 'multifd' channels enabled.
===
$ ../qtest/migration-test --tap -k -r '/x86_64/migration/multifd+postcopy' | grep -i 'slow test'
# slow test /x86_64/migration/multifd+postcopy/plain executed in 1.29 secs
# slow test /x86_64/migration/multifd+postcopy/recovery/tls/psk executed in 2.48 secs
# slow test /x86_64/migration/multifd+postcopy/preempt/plain executed in 1.49 secs
# slow test /x86_64/migration/multifd+postcopy/preempt/recovery/tls/psk executed in 2.52 secs
# slow test /x86_64/migration/multifd+postcopy/tcp/tls/psk/match executed in 3.62 secs
# slow test /x86_64/migration/multifd+postcopy/tcp/plain/zstd executed in 1.34 secs
# slow test /x86_64/migration/multifd+postcopy/tcp/plain/cancel executed in 2.24 secs
...
66/66 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             148.41s   71 subtests passed
===


v3: https://lore.kernel.org/qemu-devel/20250121131032.1611245-1-ppandit@redhat.com/T/#t
* This series (v3) passes all existing 'tests/qtest/migration/*' tests
  and adds a new one to enable multifd channels with postcopy migration.


v2: https://lore.kernel.org/qemu-devel/20241129122256.96778-1-ppandit@redhat.com/T/#u
* This series (v2) further refactors the 'ram_save_target_page'
  function to make it independent of the multifd & postcopy change.


v1: https://lore.kernel.org/qemu-devel/20241126115748.118683-1-ppandit@redhat.com/T/#u
* This series removes magic value (4-bytes) introduced in the
  previous series for the Postcopy channel.


v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u
* Currently Multifd and Postcopy migration can not be used together.
  QEMU shows "Postcopy is not yet compatible with multifd" message.

  When migrating guests with large (100's GB) RAM, Multifd threads
  help to accelerate migration, but inability to use it with the
  Postcopy mode delays guest start up on the destination side.

* This patch series allows to enable both Multifd and Postcopy
  migration together. Precopy and Multifd threads work during
  the initial guest (RAM) transfer. When migration moves to the
  Postcopy phase, Multifd threads are restrained and the Postcopy
  threads start to request pages from the source side.

* This series introduces magic value (4-bytes) to be sent on the
  Postcopy channel. It helps to differentiate channels and properly
  setup incoming connections on the destination side.


Thank you.
---
Peter Xu (2):
  migration: Add save_postcopy_prepare() savevm handler
  migration/ram: Implement save_postcopy_prepare()

Prasad Pandit (5):
  migration/multifd: move macros to multifd header
  migration: refactor channel discovery mechanism
  migration: enable multifd and postcopy together
  tests/qtest/migration: consolidate set capabilities
  tests/qtest/migration: add postcopy tests with multifd

 include/migration/register.h              |  15 +++
 migration/migration.c                     | 136 ++++++++++++----------
 migration/multifd-nocomp.c                |   3 +-
 migration/multifd.c                       |  12 +-
 migration/multifd.h                       |   5 +
 migration/options.c                       |   5 -
 migration/ram.c                           |  42 ++++++-
 migration/savevm.c                        |  33 ++++++
 migration/savevm.h                        |   1 +
 tests/qtest/migration/compression-tests.c |  38 +++++-
 tests/qtest/migration/cpr-tests.c         |   6 +-
 tests/qtest/migration/file-tests.c        |  58 +++++----
 tests/qtest/migration/framework.c         |  76 ++++++++----
 tests/qtest/migration/framework.h         |   9 +-
 tests/qtest/migration/misc-tests.c        |   4 +-
 tests/qtest/migration/postcopy-tests.c    |  35 +++++-
 tests/qtest/migration/precopy-tests.c     |  48 +++++---
 tests/qtest/migration/tls-tests.c         |  70 ++++++++++-
 18 files changed, 437 insertions(+), 159 deletions(-)

-- 
2.49.0


