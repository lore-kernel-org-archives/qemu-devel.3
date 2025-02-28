Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6C0C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzJj-0004BE-Tq; Fri, 28 Feb 2025 07:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzJh-0004Az-JU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzJf-0001Fh-Iv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740745084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GUH+O0sC1Xl6rZyu9LHj5Ir8T0XfbUyoQobcjnvUcBw=;
 b=E7D70mOPhilG85ojUB9F0YYFXY5pBFMUKLbKG9TLtDAqMnBjNVyuwYYH+GWv06ngecuDiv
 +FZUOWcPMKW1N4k/kMm0Y6sjHQ18yBQtExU//XRVioE9CzPUC8/P6mid37sftjJlO7efLE
 cpNMdMHqbpUDam27ZC+9M7N4PQCLIKI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-4Dpg1WJCNpG5fyUClv28xw-1; Fri,
 28 Feb 2025 07:18:03 -0500
X-MC-Unique: 4Dpg1WJCNpG5fyUClv28xw-1
X-Mimecast-MFC-AGG-ID: 4Dpg1WJCNpG5fyUClv28xw_1740745082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29E321800877; Fri, 28 Feb 2025 12:18:01 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.175])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55E9B180094C; Fri, 28 Feb 2025 12:17:55 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v7 0/5] Allow to enable multifd and postcopy migration together
Date: Fri, 28 Feb 2025 17:47:44 +0530
Message-ID: <20250228121749.553184-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Prasad Pandit (5):
  migration/multifd: move macros to multifd header
  migration: enable multifd and postcopy together
  tests/qtest/migration: consolidate set capabilities
  tests/qtest/migration: add postcopy tests with multifd
  migration: add MULTIFD_RECV_SYNC migration command

 migration/migration.c                     | 136 +++++++++++++---------
 migration/multifd-nocomp.c                |  28 +++--
 migration/multifd.c                       |  17 +--
 migration/multifd.h                       |   6 +
 migration/options.c                       |   5 -
 migration/ram.c                           |   7 +-
 migration/savevm.c                        |  13 +++
 migration/savevm.h                        |   1 +
 tests/qtest/migration/compression-tests.c |  37 +++++-
 tests/qtest/migration/cpr-tests.c         |   6 +-
 tests/qtest/migration/file-tests.c        |  58 +++++----
 tests/qtest/migration/framework.c         |  76 ++++++++----
 tests/qtest/migration/framework.h         |   9 +-
 tests/qtest/migration/misc-tests.c        |   4 +-
 tests/qtest/migration/postcopy-tests.c    |  35 +++++-
 tests/qtest/migration/precopy-tests.c     |  48 +++++---
 tests/qtest/migration/tls-tests.c         |  69 ++++++++++-
 17 files changed, 388 insertions(+), 167 deletions(-)

-- 
2.48.1


