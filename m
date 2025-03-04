Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B34EC282D6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpU9L-0001pY-BX; Tue, 04 Mar 2025 10:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <35b3e1bc74c4f2825acb98252398d2f8805fc99f@kylie.crudebyte.com>)
 id 1tpU9J-0001pJ-KR; Tue, 04 Mar 2025 10:25:37 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <35b3e1bc74c4f2825acb98252398d2f8805fc99f@kylie.crudebyte.com>)
 id 1tpU9G-0006sn-CU; Tue, 04 Mar 2025 10:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=m8DroyTwpV8qTc1v/guRmRYiivJS6APMhAtiLpmXLWA=; b=g8vfL
 MRJdPOcnm0w4n/FU99SBABs0zkptm8XRncmlJnm9jFvUC0tckjarvDmglXrr6kdJCnn/FHpbVG6Si
 g1IJ+qmwAQNv/pkRk0Zrwu8XBI57ApPL2bGAKfl/ErLLi1aVpFjF7INBNfJP3Igd5uPhC8Qoog97i
 U8OCYndjx4lbiUz+w2N8wP6tWqjPaJWp7AwkNW5wptoE+eNZrZAZqsFpzuC63jhYUw+GZfKoonVQQ
 +BkASp6t2gwUC3Kl24zXCXhUXNqDmNk/sM0fVa4ce9tWDjXfx1a4IDcSEtibIksq78Hrir9fKZGKZ
 ZfmfckKMnu6Xxdlp6yoK4A65EzrGzCXhxFeWwEmr3NW+15kP+7nnsnZ7nN1FX9EHtmxHLdtHTPkii
 GTj2/vJY1Ss24fOTuEEbD0sRmtH3/gGgARWroOYOqmmodtLM7oKk9A/iA+FtfzvNpGxGsEc73PkNd
 p2oGCfi8gwPTVdImiUbF0jLFP6eyoCj1Y5+zODL+PCTuv8p1/5Weis5b+wUyaySpCz09CMv06zg11
 rdLQWHpSOxnuekqfEbZ08yioUpv2yLb9LNmZrT/VgvepBF8GZ/yZtgCJ9PoWhwKf5+0qS/KjYX87E
 Uh7JBuVbBdMg6meeT2zvCgblgmbYuO+UJ5n19WK+zhElbJ5FrASMUBXLoIXo5U=;
Message-Id: <cover.1741101468.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 4 Mar 2025 16:17:48 +0100
Subject: [PATCH 0/2] 9pfs: v9fs_reclaim_fd() fixes
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    qemu-stable@nongnu.org
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=35b3e1bc74c4f2825acb98252398d2f8805fc99f@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Two fixes for 9p server's v9fs_reclaim_fd() function:

* Patch 1 fixes a concurrency issue.

* Patch 2 optimizes overall latency. On a test machine with ~800,000 FIDs, this
  reduced execution duration of v9fs_reclaim_fd() from 30ms to 1ms.

Christian Schoenebeck (2):
  9pfs: fix concurrent v9fs_reclaim_fd() calls
  9pfs: reduce latency of v9fs_reclaim_fd()

 hw/9pfs/9p.c | 36 +++++++++++++++++++++++++++---------
 hw/9pfs/9p.h |  1 +
 2 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.39.5


