Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909CDF8FA9A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDhx-0001K4-GO; Tue, 21 Apr 2026 12:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wFDhv-0001JT-7U
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wFDhr-0000DZ-Hz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776787924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BY/7TFTwPMiMPlmmztYgB8mFgBIu0JsaGz+wXMfjMGQ=;
 b=btbRHvcRCtpqXLG5hW0fbdvCA3uJSVbd88F9OQ2iFUZEQW2WFEERM2ZCkULONir1aSdL3w
 rayPVzQ3/VvxHljZqb0sEhUbXD1U8tdVGneVoj6wijEfrK3/y0MzoSj6JZLs+9hZL7mybI
 npGgRNfTCv6Nuo6BFrEigBDtbaqqcbI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-_OntLI68Orim5OCyTDfXwA-1; Tue,
 21 Apr 2026 12:12:02 -0400
X-MC-Unique: _OntLI68Orim5OCyTDfXwA-1
X-Mimecast-MFC-AGG-ID: _OntLI68Orim5OCyTDfXwA_1776787921
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 677DA19560A2; Tue, 21 Apr 2026 16:12:01 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.173])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E3AA1800660; Tue, 21 Apr 2026 16:11:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 0/7] ide: Fix deadlock between TRIM and drain
Date: Tue, 21 Apr 2026 18:11:25 +0200
Message-ID: <20260421161132.99878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Patches 2 and 4 are the core of the fix, see their commit message for
details.

Kevin Wolf (7):
  blkdebug: Add 'delay-ns' option
  block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
  block: Add flags parameter to blk_*_pdiscard()
  ide: Minimal fix for deadlock between TRIM and drain
  ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
  ide-test: Factor out wait_dma_completion()
  ide-test: Test reset during TRIM

 qapi/block-core.json              |   4 +
 include/block/block-common.h      |  11 ++-
 include/system/block-backend-io.h |   6 +-
 block/blkdebug.c                  |  15 +++-
 block/block-backend.c             |  47 +++++++---
 block/export/virtio-blk-handler.c |   2 +-
 block/mirror.c                    |   4 +-
 hw/ide/core.c                     | 110 +++++++++++-------------
 nbd/server.c                      |   2 +-
 qemu-io-cmds.c                    |   2 +-
 tests/qtest/ide-test.c            | 137 ++++++++++++++++++++++++------
 tests/unit/test-block-iothread.c  |   4 +-
 12 files changed, 236 insertions(+), 108 deletions(-)

-- 
2.53.0


