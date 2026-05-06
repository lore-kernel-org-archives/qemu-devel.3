Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E25CD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdfD-0006qh-Ta; Wed, 06 May 2026 10:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeJ-0006Rm-Af; Wed, 06 May 2026 10:54:56 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeG-0005sB-V1; Wed, 06 May 2026 10:54:54 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6ACEE80AF9;
 Wed, 06 May 2026 16:54:39 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH 0/3] block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to
 fix regression
Date: Wed,  6 May 2026 16:49:55 +0200
Message-ID: <20260506145424.10249-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778079171042
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

Commit 8599559580 ("fuse: Set direct_io and parallel_direct_writes")
broke use cases that require mmap() with MAP_SHARED on the export. In
particular, swtpm_setup using its 'file://' protocol requires this.
This is mentioned in the kernel documentation [0]:

> To allow shared mmap, the FUSE_DIRECT_IO_ALLOW_MMAP flag may be
> enabled in the FUSE_INIT reply.

[0]: https://www.kernel.org/doc/html/next/filesystems/fuse/fuse-io.html

Set the FUSE_DIRECT_IO_ALLOW_MMAP flag to restore compatibility with
users requiring shared mmap.

Fiona Ebner (3):
  block/export/fuse: use struct fuse_init_in
  block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix
    regression
  iotests: test shared mmap for fuse export

 block/export/fuse.c                           |  69 +++++++++---
 tests/qemu-iotests/tests/fuse-mmap-shared     | 103 ++++++++++++++++++
 tests/qemu-iotests/tests/fuse-mmap-shared.out |   5 +
 3 files changed, 161 insertions(+), 16 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/fuse-mmap-shared
 create mode 100644 tests/qemu-iotests/tests/fuse-mmap-shared.out

-- 
2.47.3



