Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB68FCC05C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vya40-0000xz-6K; Fri, 06 Mar 2026 13:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya3y-0000x8-M0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya3w-00062N-9A
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772822291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ilkxDF+DESNACwSo1Sdj67Tz4NHC+EuKelHM+jc+vjs=;
 b=YGzRkp2QeAaCiNM28m7BmsAiwui9sUkKDoEodRML1HBVi29udClRi3XT0LBmjXTP6Wto+O
 fRxoLLgs19C5SMqha/NHxN5Jn/7IfRvZgEuAel1KWWFKITusD6WtxVtNlMmjFMNnX2XQpv
 tRuSzlrLfiI6YDsdOrBXMCldQvKCuKM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-e10-HNhSPnWbrG4hbm6l8Q-1; Fri,
 06 Mar 2026 13:38:08 -0500
X-MC-Unique: e10-HNhSPnWbrG4hbm6l8Q-1
X-Mimecast-MFC-AGG-ID: e10-HNhSPnWbrG4hbm6l8Q_1772822287
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF0C61956053; Fri,  6 Mar 2026 18:38:06 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E8081800361; Fri,  6 Mar 2026 18:38:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/12] Block layer patches
Date: Fri,  6 Mar 2026 19:36:53 +0100
Message-ID: <20260306183705.410357-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:

  Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)

are available in the Git repository at:

  https://gitlab.com/kmwolf/qemu.git tags/for-upstream

for you to fetch changes up to a844ad5da2d0d16bab819c6b50c9cba0012ed202:

  iotests/244: Add test cases for keep_data_file (2026-03-06 17:45:16 +0100)

----------------------------------------------------------------
Block layer patches

- Wire up 'flat' mode also for 'query-block'
- Never drop BLOCK_IO_ERROR with action=stop for rate limiting
- qcow2: Add keep_data_file command-line option
- vmdk: fix OOB read in vmdk_read_extent()
- curl: fix concurrent completion handling
- nfs: Fix deadlock
- mirror: Fix missed dirty bitmap writes during startup
- throttle-groups: fix deadlock with iolimits and muliple iothreads

----------------------------------------------------------------
Antoine Damhet (1):
      block/curl: fix concurrent completion handling

Dmitry Guryanov (1):
      block/throttle-groups: fix deadlock with iolimits and muliple iothreads

Halil Oktay (oblivionsage) (1):
      block/vmdk: fix OOB read in vmdk_read_extent()

Hanna Czenczek (5):
      block/nfs: Do not enter coroutine from CB
      qcow2: Add keep_data_file command-line option
      qcow2: Simplify size round-up in co_create_opts
      iotests/common.filter: Sort keep_data_file
      iotests/244: Add test cases for keep_data_file

Kevin Wolf (2):
      mirror: Fix missed dirty bitmap writes during startup
      block: Never drop BLOCK_IO_ERROR with action=stop for rate limiting

Peter Krempa (2):
      block: Wire up 'flat' mode also for 'query-block'
      hmp_nbd_server_start: Don't ask for backing image data

 qapi/block-core.json             |  7 +++-
 include/block/block_int-common.h |  1 +
 include/block/throttle-groups.h  |  3 +-
 block/curl.c                     | 11 ++----
 block/mirror.c                   | 52 +++++++++++++++++-----------
 block/monitor/block-hmp-cmds.c   |  4 +--
 block/nfs.c                      | 19 +++++-----
 block/qapi.c                     |  8 ++---
 block/qcow2.c                    | 75 ++++++++++++++++++++++++++++++++++++----
 block/throttle-groups.c          | 21 ++++-------
 block/vmdk.c                     |  8 ++---
 monitor/monitor.c                | 21 ++++++++++-
 tests/qemu-iotests/082.out       | 18 ++++++++++
 tests/qemu-iotests/244           | 71 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/244.out       | 61 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/common.filter |  2 +-
 ui/cocoa.m                       |  2 +-
 17 files changed, 309 insertions(+), 75 deletions(-)


