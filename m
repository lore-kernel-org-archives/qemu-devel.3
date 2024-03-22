Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481BAC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbXc-0003Tu-V1; Fri, 22 Mar 2024 05:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXa-0003RV-1b; Fri, 22 Mar 2024 05:50:22 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXW-00020i-Vq; Fri, 22 Mar 2024 05:50:21 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6869F419AB;
 Fri, 22 Mar 2024 10:50:14 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: [PATCH v3 0/4] fix two edge cases related to stream block jobs
Date: Fri, 22 Mar 2024 10:50:05 +0100
Message-Id: <20240322095009.346989-1-f.ebner@proxmox.com>
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

Changes in v3:
    * Also deal with edge case in bdrv_next_cleanup(). Haven't run
      into an actual issue there, but at least the caller in
      migration/block.c uses bdrv_nb_sectors() which, while not a
      coroutine wrapper itself (it's written manually), may call
      bdrv_refresh_total_sectors(), which is a generated coroutine
      wrapper, so AFAIU, the block graph can change during that call.
      And even without that, it's just better to be more consistent
      with bdrv_next().

Changes in v2:
    * Ran into another issue while writing the IO test Stefan wanted
      to have (good call :)), so include a fix for that and add the
      test. I didn't notice during manual testing, because I hadn't
      used a scripted QMP 'quit', so there was no race.

Fiona Ebner (3):
  block-backend: fix edge case in bdrv_next() where BDS associated to BB
    changes
  block-backend: fix edge case in bdrv_next_cleanup() where BDS
    associated to BB changes
  iotests: add test for stream job with an unaligned prefetch read

Stefan Reiter (1):
  block/io: accept NULL qiov in bdrv_pad_request

 block/block-backend.c                         | 18 ++--
 block/io.c                                    | 31 ++++---
 .../tests/stream-unaligned-prefetch           | 86 +++++++++++++++++++
 .../tests/stream-unaligned-prefetch.out       |  5 ++
 4 files changed, 117 insertions(+), 23 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/stream-unaligned-prefetch
 create mode 100644 tests/qemu-iotests/tests/stream-unaligned-prefetch.out

-- 
2.39.2



