Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7252CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzN1-0005qh-7E; Mon, 03 Nov 2025 13:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzMx-0005qI-Va
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:33:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzMt-0006xH-0w
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762194796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wFJvzQJs4hG58LHZdY+Kl4E435V5JyesPRH0HvUREc0=;
 b=ak1/cQALbJ/3S1H7W8OCy4cVI93DaWnQFl5RakRI035KQH5YEWkMNp389dUORg0om8ipeN
 BEfLkuPMwdlCgvBPyMGrhOuqcawmaTfFIQ4vff03gjouJ632X7ZAUdaXTYHiU4Xbm6NtDC
 z/QP7LBuiWcPH5i36T+MDFr1l453Zk8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-pNZcHLVqOeSD7I5S3WyK2Q-1; Mon,
 03 Nov 2025 13:33:12 -0500
X-MC-Unique: pNZcHLVqOeSD7I5S3WyK2Q-1
X-Mimecast-MFC-AGG-ID: pNZcHLVqOeSD7I5S3WyK2Q_1762194789
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D9371955EB7; Mon,  3 Nov 2025 18:33:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.249])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE30F18004D8; Mon,  3 Nov 2025 18:33:04 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v4 0/8] migration: Introduce POSTCOPY_DEVICE state
Date: Mon,  3 Nov 2025 19:32:49 +0100
Message-ID: <20251103183301.3840862-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This series introduces a new POSTCOPY_DEVICE state that is active (both,
on source and destination side), while the destination loads the device
state. Before this series, if the destination machine failed during the
device load, the source side would stay stuck POSTCOPY_ACTIVE with no
way of recovery. With this series, if the migration fails while in
POSTCOPY_DEVICE state, the source side can safely resume, as destination
has not started yet.

RFC: https://lore.kernel.org/all/20250807114922.1013286-1-jmarcin@redhat.com/

V1: https://lore.kernel.org/all/20250915115918.3520735-1-jmarcin@redhat.com/

V2: https://lore.kernel.org/all/20251027154115.4138677-1-jmarcin@redhat.com/

V3: https://lore.kernel.org/all/20251030214915.1411860-1-jmarcin@redhat.com/

V4 changes:

- fixes for failing qemu-iotest 194
    - flush channel after sending CMD_PACKAGED data (new patch 1)
    - POSTCOPY_DEVICE state is now used only if return-path is open

Juraj Marcin (7):
  migration: Flush migration channel after sending data of CMD_PACKAGED
  migration: Move postcopy_ram_listen_thread() to postcopy-ram.c
  migration: Introduce postcopy incoming setup and cleanup functions
  migration: Refactor all incoming cleanup info
    migration_incoming_destroy()
  migration: Respect exit-on-error when migration fails before resuming
  migration: Make postcopy listen thread joinable
  migration: Introduce POSTCOPY_DEVICE state

Peter Xu (1):
  migration: Do not try to start VM if disk activation fails

 migration/migration.c                 | 123 +++++++++++++-------
 migration/migration.h                 |   4 +
 migration/postcopy-ram.c              | 161 ++++++++++++++++++++++++++
 migration/postcopy-ram.h              |   3 +
 migration/savevm.c                    | 138 ++--------------------
 migration/savevm.h                    |   2 +
 migration/trace-events                |   3 +-
 qapi/migration.json                   |  10 +-
 tests/qemu-iotests/194                |   2 +-
 tests/qtest/migration/precopy-tests.c |   3 +-
 10 files changed, 275 insertions(+), 174 deletions(-)

-- 
2.51.0


