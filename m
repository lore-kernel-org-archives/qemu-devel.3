Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CEDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRscC-0001Uq-7i; Thu, 11 Jul 2024 08:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sRsc9-0001Ok-57; Thu, 11 Jul 2024 08:09:33 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sRsbz-0002s1-CO; Thu, 11 Jul 2024 08:09:32 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A4FBC47349;
 Thu, 11 Jul 2024 14:09:19 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com
Subject: [PATCH v3 0/2] backup: allow specifying minimum cluster size
Date: Thu, 11 Jul 2024 14:09:13 +0200
Message-Id: <20240711120915.310243-1-f.ebner@proxmox.com>
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

Discussion for v2:
https://lore.kernel.org/qemu-devel/20240528120114.344416-1-f.ebner@proxmox.com/

Changes in v3:
* Pass min_cluster_size option directly without checking
  has_min_cluster_size, because the default is 0 anyways.
* Calculate maximum of passed-in argument and default once at the
  beginning of block_copy_calculate_cluster_size()
* Update warning message to reflect actual value used
* Do not leak qdict in error case
* Use PRI{i,u}64 macros

Discussion for v1:
https://lore.kernel.org/qemu-devel/20240308155158.830258-1-f.ebner@proxmox.com/
-
Changes in v2:
* Use 'size' type in QAPI.
* Remove option in cbw_parse_options(), i.e. before parsing generic
  blockdev options.
* Reword commit messages hoping to describe the issue in a more
  straight-forward way.

In the context of backup fleecing, discarding the source will not work
when the fleecing image has a larger granularity than the one used for
block-copy operations (can happen if the backup target has smaller
cluster size), because cbw_co_pdiscard_snapshot() will align down the
discard requests and thus effectively ignore then.

To make @discard-source work in such a scenario, allow specifying the
minimum cluster size used for block-copy operations and thus in
particular also the granularity for discard requests to the source.

Fiona Ebner (2):
  copy-before-write: allow specifying minimum cluster size
  backup: add minimum cluster size to performance options

 block/backup.c             |  2 +-
 block/block-copy.c         | 36 ++++++++++++++++++++++++++----------
 block/copy-before-write.c  | 14 +++++++++++++-
 block/copy-before-write.h  |  1 +
 blockdev.c                 |  3 +++
 include/block/block-copy.h |  1 +
 qapi/block-core.json       | 17 ++++++++++++++---
 7 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.39.2



