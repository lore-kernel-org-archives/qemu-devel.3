Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F6CCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYax-0005ph-2u; Fri, 22 May 2026 18:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wQYav-0005pV-Tt; Fri, 22 May 2026 18:43:53 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wQYat-0005FL-5M; Fri, 22 May 2026 18:43:53 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id 2815E1520E21;
 Sat, 23 May 2026 00:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1779489828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gt+3XdI9GUY7uKSSqjh/KNFg+RDpErPorn/Dt58zRmY=;
 b=lSnTGdGfBvbXCJFHZgIzY8MKe4VGljxU9IVMomeqFyI0SEW6LGEnHTXms2xBLzS5CefV/c
 NOPNTiBw6UfZ47j6Qu/65mZMk7o9nTlz2TXkpkaND9cHQjozDP4LtkJGY+/5zRx6cfV2Fh
 2DVV6A+yl8AXTgZ8NHbY+98fDhmrjpXE3ArVCnPVeSiuskBKiEro6O7JSVlgpeRTYtJOlY
 MQ3hoAmbblIXFLNGvR75nYodw0ThlYsYvbF+SU7fEenVl14jAOJHplXYz4xoMilkbzIy33
 XgC6R9V2frAOQbuRw4V4hOBUcf4rY6gy+Z7j97pMh3AeUJeAWQwFbThqODZYXQ==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v5 0/1] qcow2: add a way to repair bitmaps
Date: Sat, 23 May 2026 00:43:34 +0200
Message-ID: <20260522224335.1286291-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A v5 (and hopefully final :)) version of the patch.

The only change since v4 is that QSIMPLEQ_FOREACH is replaced by QSIMPLEQ_FOREACH_SAFE.
This to avoid a use after free when we free the 'bm' in the loop.

Thanks
Jean-Louis

Jean-Louis Dupond (1):
  qcow2: add functionality to repair bitmaps

 block/qcow2-bitmap.c   | 42 +++++++++++++++++++++++++++++++++++++++---
 block/qcow2-refcount.c |  3 ++-
 block/qcow2.c          | 16 ++++++++++++----
 block/qcow2.h          |  3 ++-
 4 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.54.0


