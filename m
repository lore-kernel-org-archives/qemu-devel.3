Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7597D2CE02
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4f-0000Vb-OE; Tue, 22 Oct 2024 12:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4X-0000GD-GL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4K-00063x-PX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+6RKmCXEOw0VB8nIPP1b8VbzxGXdQrcrSKrzHEUxgkE=;
 b=cVl8cG5n3ujVkNvnqPLIovuItKFJbrfLK71rAaQMXS5Q9aSKLZGQI10VHH7wDx1C2m1lx1
 mWdPjrj31gPTS0a8TWlnlHeypQR/1nF/ZGvTQ6A9B9fahzEjMP3kDNaHQ0VOBRX5TLmPpV
 ubKcoJK20NuSXBLZfGdEtRRmp6HHfpQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-WRoiZ-XEM3ayCSzo8-lyyw-1; Tue,
 22 Oct 2024 12:49:13 -0400
X-MC-Unique: WRoiZ-XEM3ayCSzo8-lyyw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A39C1955F3C; Tue, 22 Oct 2024 16:49:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 853A81956056; Tue, 22 Oct 2024 16:49:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/9] Block layer patches
Date: Tue, 22 Oct 2024 18:48:54 +0200
Message-ID: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:

  Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 04bbc3ee52b32ac465547bb40c1f090a1b8f315a:

  raw-format: Fix error message for invalid offset/size (2024-10-22 17:52:49 +0200)

----------------------------------------------------------------
Block layer patches

- Event throttling for BLOCK_IO_ERROR
- iotests: Fix backup-discard-source test for XFS
- Coverity fixes
- raw-format: Fix error message for invalid offset/size

----------------------------------------------------------------
Kevin Wolf (1):
      raw-format: Fix error message for invalid offset/size

Leonid Kaplan (1):
      block-backend: per-device throttling of BLOCK_IO_ERROR reports

Peter Maydell (4):
      block/gluster: Use g_autofree for string in qemu_gluster_parse_json()
      block/ssh.c: Don't double-check that characters are hex digits
      tests/qemu-iotests/211.out: Update to expect MapEntry 'compressed' field
      block/vdi.c: Make SECTOR_SIZE constant 64-bits

Vladimir Sementsov-Ogievskiy (3):
      iotests/backup-discard-source: convert size variable to be int
      iotests/backup-discard-source: don't use actual-size
      qapi: add qom-path to BLOCK_IO_ERROR event

 qapi/block-core.json                           |  9 ++++--
 block/block-backend.c                          | 21 +++++++++++---
 block/gluster.c                                |  7 ++---
 block/raw-format.c                             |  4 +--
 block/ssh.c                                    | 12 ++++----
 block/vdi.c                                    |  4 +--
 monitor/monitor.c                              |  7 +++--
 tests/qemu-iotests/211.out                     |  6 ++--
 tests/qemu-iotests/tests/backup-discard-source | 39 +++++++++++++++++---------
 9 files changed, 70 insertions(+), 39 deletions(-)


