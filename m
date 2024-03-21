Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C16BC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 13:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnIYo-0003j8-1C; Thu, 21 Mar 2024 09:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnIYF-0003QO-UW; Thu, 21 Mar 2024 09:33:49 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnIY7-0007yE-HO; Thu, 21 Mar 2024 09:33:46 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C380740E8F;
 Thu, 21 Mar 2024 14:33:26 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: [PATCH v2 0/3] fix two edge cases related to stream block jobs
Date: Thu, 21 Mar 2024 14:33:20 +0100
Message-Id: <20240321133323.831133-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes in v2:
    * Ran into another issue while writing the IO test Stefan wanted
      to have (good call :)), so include a fix for that and add the
      test. I didn't notice during manual testing, because I hadn't
      used a scripted QMP 'quit', so there was no race.

Fiona Ebner (2):
  block-backend: fix edge case in bdrv_next() where BDS associated to BB
    changes
  iotests: add test for stream job with an unaligned prefetch read

Stefan Reiter (1):
  block/io: accept NULL qiov in bdrv_pad_request

 block/block-backend.c                         |  7 +-
 block/io.c                                    | 31 ++++---
 .../tests/stream-unaligned-prefetch           | 86 +++++++++++++++++++
 .../tests/stream-unaligned-prefetch.out       |  5 ++
 4 files changed, 113 insertions(+), 16 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/stream-unaligned-prefetch
 create mode 100644 tests/qemu-iotests/tests/stream-unaligned-prefetch.out

-- 
2.39.2



