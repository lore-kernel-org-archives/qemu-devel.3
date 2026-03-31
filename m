Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41198109B47B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7adW-0003Ck-DR; Tue, 31 Mar 2026 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adU-0003Al-5h
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7adS-0002Xd-2O
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774969445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gmclVVQmUDbvXG0eDKKrT2xHsl/iqs3/FSIdcuphNIQ=;
 b=NJBZY6OxQbGftglLSqyMB2GToxJ07Mx/Ka9pp2+zB5XAa9uQA7CwG88kweQlM9RuMTNU4Y
 zSHBsY6BjQY/28KjbHDIs25N2pvrasgJHLQ38Lwc0mQ70/nmEonRqpfA6q5ChPJE4o/E1/
 qm9tZMX8mppsRZMKRDTevM8CTO473a8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-ckTuncBnPA6J7HMLIYN3UA-1; Tue,
 31 Mar 2026 11:04:02 -0400
X-MC-Unique: ckTuncBnPA6J7HMLIYN3UA-1
X-Mimecast-MFC-AGG-ID: ckTuncBnPA6J7HMLIYN3UA_1774969438
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F0A9180075A; Tue, 31 Mar 2026 15:03:57 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.50.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 307261953947; Tue, 31 Mar 2026 15:03:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 0/6] Block layer patches
Date: Tue, 31 Mar 2026 17:03:46 +0200
Message-ID: <20260331150352.256332-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

The following changes since commit 49ea0100202fe448be1d0f3ea5384cd51b5e6a58:

  Merge tag 'migration-20260330-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-03-31 09:39:52 +0100)

are available in the Git repository at:

  https://gitlab.com/kmwolf/qemu.git tags/for-upstream

for you to fetch changes up to a55402d5c3a8c63c801de86896f86c9abeda0ca8:

  block: Fix crash after setting latency historygram with single bin (2026-03-31 15:47:52 +0200)

----------------------------------------------------------------
Block layer patches

- ide: Fix potential assertion failure on VM stop for PIO read error
- scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable
- vhost-user-blk-server: fix opt_io_size=1 causing severe Windows I/O degradation
- monitor: Fix deadlock in monitor_cleanup
- Fix filename references in comments

----------------------------------------------------------------
Kevin Wolf (3):
      ide: Fix potential assertion failure on VM stop for PIO read error
      scsi: Don't consider LOGICAL UNIT NOT SUPPORTED guest recoverable
      block: Fix crash after setting latency historygram with single bin

Max Makarov (1):
      vhost-user-blk-server: fix opt_io_size=1 causing severe Windows I/O degradation

Yunjian Long (1):
      block: Fix references in bdrv_bsc_*() function comments

hongmianquan (1):
      monitor: Fix deadlock in monitor_cleanup

 block.c                              |  6 +++---
 block/accounting.c                   |  9 +++++++++
 block/export/vhost-user-blk-server.c |  4 ++--
 hw/ide/core.c                        |  1 +
 qapi/qmp-dispatch.c                  | 10 ++++++++++
 scsi/utils.c                         |  1 -
 6 files changed, 25 insertions(+), 6 deletions(-)


