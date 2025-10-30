Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E5ACCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 21:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEaWv-0006nc-Tj; Thu, 30 Oct 2025 17:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaWk-0006jO-1u
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaWX-0000Y4-Qh
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761860966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B2x4Ydz0YDAHO1cBmw+mmGIlAPnJPqKveuIqv61b0as=;
 b=OatxiBZJBe4FTgantOyit/EcDMkV/u0R7XQ8FwX7/eFjkGx5F4CVkmvBtrPEfZdvUcQpTm
 xN025MlM+RG2u8QDQNNiNt5Rx9ztIPhGbPGWiRm62jb+UqSW8CQakb0d7+/1HnEFFgZvXl
 iAdoWI2HZFfu7uAjpYrTW/K/GlGiP6E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-H32zSLs1PjOty-nPcIdPZg-1; Thu,
 30 Oct 2025 17:49:23 -0400
X-MC-Unique: H32zSLs1PjOty-nPcIdPZg-1
X-Mimecast-MFC-AGG-ID: H32zSLs1PjOty-nPcIdPZg_1761860962
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFAA419540EA; Thu, 30 Oct 2025 21:49:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.58])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75688180057E; Thu, 30 Oct 2025 21:49:19 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 0/7] migration: Introduce POSTCOPY_DEVICE state
Date: Thu, 30 Oct 2025 22:49:04 +0100
Message-ID: <20251030214915.1411860-1-jmarcin@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

V3 changes:

- rebased on top of https://gitlab.com/peterx/qemu/-/commits/staging

Patch 2:
- split into two separate patches

Patches 4, 5, 6 (was Patch 3)
- return to previous migration_incoming_state_destroy() that will not
  exit on error
- use existing exit-on-error option also for postcopy, in separate patch
- moved conversion of the postcopy listen thread to a joinable thread
  into a separate patch

Patch 7:
- added reset of postcopy_package_loaded_event

Juraj Marcin (6):
  migration: Move postcopy_ram_listen_thread() to postcopy-ram.c
  migration: Introduce postcopy incoming setup and cleanup functions
  migration: Refactor all incoming cleanup info
    migration_incoming_destroy()
  migration: Respect exit-on-error when migration fails before resuming
  migration: Make postcopy listen thread joinable
  migration: Introduce POSTCOPY_DEVICE state

Peter Xu (1):
  migration: Do not try to start VM if disk activation fails

 migration/migration.c                 | 116 ++++++++++++-------
 migration/migration.h                 |   4 +
 migration/postcopy-ram.c              | 160 ++++++++++++++++++++++++++
 migration/postcopy-ram.h              |   3 +
 migration/savevm.c                    | 134 +--------------------
 migration/savevm.h                    |   2 +
 migration/trace-events                |   3 +-
 qapi/migration.json                   |   8 +-
 tests/qtest/migration/precopy-tests.c |   3 +-
 9 files changed, 260 insertions(+), 173 deletions(-)

-- 
2.51.0


