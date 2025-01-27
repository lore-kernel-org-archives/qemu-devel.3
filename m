Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0A3C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 12:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNvf-0003V4-EO; Mon, 27 Jan 2025 07:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcNv8-0003PT-Lx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcNv4-0000VZ-MM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 07:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737979721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SWg2R22CrdP3ARnTmd3o+VO3c7TD+zQxVecVhaU9edA=;
 b=fpagPJDefE7tE77aiyadv6lBI6nJXfrTZ9XbJKC6RyJcMD9uDqth/SNwq/0BkCrqMPRPOP
 EjBKcApCQ1JJczPZKUg/u79ivZb0A1/NZR7fczFdzBiBbu1X0FkAU8eL8AWv12uOLJV6Sp
 WCpgAV/dd9alpreJK1O0c8ba7aQ0vGw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-YN2ODuD9NW-xBi8YlB46xQ-1; Mon,
 27 Jan 2025 07:08:37 -0500
X-MC-Unique: YN2ODuD9NW-xBi8YlB46xQ-1
X-Mimecast-MFC-AGG-ID: YN2ODuD9NW-xBi8YlB46xQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9DB419560A1; Mon, 27 Jan 2025 12:08:36 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.143])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3281800348; Mon, 27 Jan 2025 12:08:31 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v4 0/4] Allow to enable multifd and postcopy migration together
Date: Mon, 27 Jan 2025 17:38:19 +0530
Message-ID: <20250127120823.144949-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Prasad Pandit (4):
  migration/multifd: move macros to multifd header
  migration: refactor ram_save_target_page functions
  migration: enable multifd and postcopy together
  tests/qtest/migration: add postcopy tests with multifd

 migration/migration.c                     | 106 ++++++++++++++--------
 migration/multifd-nocomp.c                |   3 +-
 migration/multifd.c                       |   5 -
 migration/multifd.h                       |   5 +
 migration/options.c                       |   5 -
 migration/ram.c                           |  69 ++++----------
 tests/qtest/migration/compression-tests.c |  13 +++
 tests/qtest/migration/framework.c         |  13 +++
 tests/qtest/migration/framework.h         |   4 +
 tests/qtest/migration/postcopy-tests.c    |  23 +++++
 tests/qtest/migration/precopy-tests.c     |  19 ++++
 tests/qtest/migration/tls-tests.c         |  40 ++++++++
 12 files changed, 203 insertions(+), 102 deletions(-)

--
2.48.1


