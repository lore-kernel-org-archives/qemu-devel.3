Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80425C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taE33-0006hn-S6; Tue, 21 Jan 2025 08:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1taE32-0006hK-05
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1taE30-0000bN-1B
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737465120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FQtz6enTacfkq+YaPPg3ayjYgTgmoPN66/tLTeHJqr4=;
 b=hiffFsYIkTJqDKBJTwF/Re5kUeAQUA/3vcv/NBrRI3RN6Ty5d/P+/xIwDm5Axi7DOkYUwQ
 3CnP05Z/wUaAughfP19vsX/I6SfGX3zNCBZHmtrtsxdP4zo/OKjQqm0E2Ls3FFkKj2hkPS
 1KnC/i9Y7k53QEY2KWzB6WT2IwmXhDA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-ny1yOs_DPiS-sz_HEYRKRA-1; Tue,
 21 Jan 2025 08:10:49 -0500
X-MC-Unique: ny1yOs_DPiS-sz_HEYRKRA-1
X-Mimecast-MFC-AGG-ID: ny1yOs_DPiS-sz_HEYRKRA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D993719560BA; Tue, 21 Jan 2025 13:10:47 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.45])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30B0C19560A7; Tue, 21 Jan 2025 13:10:43 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3 0/4] Allow to enable multifd and postcopy migration together
Date: Tue, 21 Jan 2025 18:40:28 +0530
Message-ID: <20250121131032.1611245-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

* This series removes magic value (4-bytes) introduced in the
  previous series for the Postcopy channel. And refactoring of
  the 'ram_save_target_page' function is made independent of
  the multifd & postcopy change.

* This series passes all existing 'tests/qtest/migration/*' test
  cases and adds a new one to enable multifd channels with postcopy
  migration.

  v2: https://lore.kernel.org/qemu-devel/20241129122256.96778-1-ppandit@redhat.com/T/#u
  v1: https://lore.kernel.org/qemu-devel/20241126115748.118683-1-ppandit@redhat.com/T/#u
  v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u


Thank you.
---
Prasad Pandit (4):
  migration/multifd: move macros to multifd header
  migration: refactor ram_save_target_page functions
  migration: enable multifd and postcopy together
  tests/qtest/migration: add postcopy test with multifd

 migration/migration.c                  | 106 +++++++++++++++----------
 migration/multifd-nocomp.c             |   3 +-
 migration/multifd.c                    |   5 --
 migration/multifd.h                    |   5 ++
 migration/options.c                    |   5 --
 migration/ram.c                        |  69 +++++-----------
 tests/qtest/migration/framework.c      |   8 ++
 tests/qtest/migration/framework.h      |   3 +
 tests/qtest/migration/postcopy-tests.c |  10 +++
 9 files changed, 112 insertions(+), 102 deletions(-)

--
2.48.1


