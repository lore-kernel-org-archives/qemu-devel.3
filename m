Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F330CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXme-0000pA-Cw; Mon, 08 Jun 2026 07:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wWXmX-0000mY-GL; Mon, 08 Jun 2026 07:04:37 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wWXmU-0006uO-Kh; Mon, 08 Jun 2026 07:04:37 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 9A2DC1520CAB;
 Mon, 08 Jun 2026 13:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1780916668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bKoo7sMcNXW1H7EGgclG1tbtwRnGcEbYvxB/IGeWn8E=;
 b=T7na00q3RkiHhxl9dPE0DWjt0o41CHZ23nyFvda3XRC7vJYTIYwO9DzhcFrzwx8NHB/qRH
 Axt9iHeHn4fS20XBiEOQITz53La1X79UB6i49o/EkCp3uJL3tR/UPpY8MDJ0AMCBO3bmYc
 DawWMcTDg9aEOYXglp4pp0vPPSp3I2/+4MzIdHCwjWeM06vbza6pdSUURH2RdqGcv+S7/P
 xdo9BGkIPWKDjRPpUmHrfiq5C43WuwzOQyrs24XyxZUxI41v8d+QRs0KrGDypsGNzhE+46
 QZneCfxODw/Uf+kZbnUT58ygZW1/K0SoQPLC1iqsmfcNVJ1sGv7yE/WLR69skQ==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 0/3] block: measure for commit
Date: Mon,  8 Jun 2026 13:03:43 +0200
Message-ID: <20260608110346.3231998-1-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
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

In some cases we want to calculate the size an image will be after we commit A into B.
This for example on block storage, where you need to resize the target storage before you start the merge.

These commits adds the functionality to do this.
First of all a commit that adds bdrv_open_backing_chain_until. So we can open an image up to base image B.

And then a modified qcow2_measure that calculates the size of B after A has been merged into it.
This with taking into account the discard-no-unref setting of the base.

Jean-Louis Dupond (3):
  block: add bdrv_open_backing_chain_until
  block: support measure for commit
  iotests/290: add test case for qemu-img measure

 block.c                            | 65 +++++++++++++++++----
 block/mirror.c                     |  2 +-
 block/qcow2.c                      | 90 +++++++++++++++++++++++++++---
 include/block/block-global-state.h |  7 ++-
 qemu-img-cmds.hx                   |  4 +-
 qemu-img.c                         | 37 ++++++++++--
 tests/qemu-iotests/178.out.qcow2   |  6 +-
 tests/qemu-iotests/178.out.raw     |  6 +-
 tests/qemu-iotests/290             | 45 +++++++++++++++
 tests/qemu-iotests/290.out         | 61 ++++++++++++++++++++
 10 files changed, 289 insertions(+), 34 deletions(-)

-- 
2.54.0


