Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A91FCEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP6v-0008V6-AP; Tue, 18 Nov 2025 12:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6p-0008Sl-30
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6m-0004gg-02
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gg06qQoWLJFiZj9At+gZJLpG0k4QZjzMo+qFJs9C9kQ=;
 b=a4OM4AGU9URdlAWwvGgA4rj/46vhy95kly1Hud6ivzecr3a/B3GTG0j947oxNArBTHLDyz
 gOlA/eabm/nrmwOwPlUbg64lK7sEMXyg2kJ7uWybMgqo2P3fJrcr2LsjsFxJ+hZvk6gJwb
 G8MByAtaeWLyUojFTBelfVp71XJREvI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-xt-GR-lyOEyNAB-1NvabaA-1; Tue,
 18 Nov 2025 12:03:06 -0500
X-MC-Unique: xt-GR-lyOEyNAB-1NvabaA-1
X-Mimecast-MFC-AGG-ID: xt-GR-lyOEyNAB-1NvabaA_1763485385
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A1DC1800370; Tue, 18 Nov 2025 17:03:04 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94570300ABB4; Tue, 18 Nov 2025 17:03:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/19] Block layer patches
Date: Tue, 18 Nov 2025 18:02:37 +0100
Message-ID: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 711a1ddf899bef577907a10db77475c8834da52f:

  Merge tag 'pull-10.2-maintainer-171125-2' of https://gitlab.com/stsquad/qemu into staging (2025-11-18 09:18:23 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 837c04e9fc798cddafe721e2abbbd0d932571793:

  win32-aio: Run CB in original context (2025-11-18 18:01:57 +0100)

----------------------------------------------------------------
Block layer patches

- Multi-threading fixes in several block drivers

----------------------------------------------------------------
Hanna Czenczek (19):
      block: Note on aio_co_wake use if not yet yielding
      rbd: Run co BH CB in the coroutine’s AioContext
      iscsi: Run co BH CB in the coroutine’s AioContext
      nfs: Run co BH CB in the coroutine’s AioContext
      curl: Fix coroutine waking
      gluster: Do not move coroutine into BDS context
      nvme: Kick and check completions in BDS context
      nvme: Fix coroutine waking
      nvme: Note in which AioContext some functions run
      block/io: Take reqs_lock for tracked_requests
      qcow2: Re-initialize lock in invalidate_cache
      qcow2: Fix cache_clean_timer
      qcow2: Schedule cache-clean-timer in realtime
      ssh: Run restart_coroutine in current AioContext
      blkreplay: Run BH in coroutine’s AioContext
      block: Note in which AioContext AIO CBs are called
      iscsi: Create AIO BH in original AioContext
      null-aio: Run CB in original AioContext
      win32-aio: Run CB in original context

 block/qcow2.h                    |   5 +-
 include/block/aio.h              |  15 ++++
 include/block/block_int-common.h |   7 +-
 block/blkreplay.c                |   3 +-
 block/curl.c                     |  45 ++++++++----
 block/gluster.c                  |  17 +++--
 block/io.c                       |   3 +
 block/iscsi.c                    |  63 +++++++----------
 block/nfs.c                      |  41 +++++------
 block/null.c                     |   7 +-
 block/nvme.c                     | 113 +++++++++++++++++++++----------
 block/qcow2.c                    | 143 +++++++++++++++++++++++++++++++--------
 block/rbd.c                      |  12 ++--
 block/ssh.c                      |  22 +++---
 block/win32-aio.c                |  31 +++++++--
 15 files changed, 346 insertions(+), 181 deletions(-)


