Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE80C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWCjH-00060e-Ir; Mon, 30 Jun 2025 07:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWCis-0005tA-Hk; Mon, 30 Jun 2025 07:30:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWCio-0004kJ-9P; Mon, 30 Jun 2025 07:30:52 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B7AFC4422F;
 Mon, 30 Jun 2025 13:30:39 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net
Subject: [PATCH 0/4] refresh filter parents when child was resized
Date: Mon, 30 Jun 2025 13:27:29 +0200
Message-ID: <20250630113035.820557-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Resizing a node below a filter would result in the filter still
reporting the old size. Implement a 'resize' callback for the
child_of_bds class, that refreshes filter parents recursively.

Fiona Ebner (4):
  include/block/block_int-common: document when resize callback is used
  block: make bdrv_co_parent_cb_resize() a proper IO API function
  block: implement 'resize' callback for child_of_bds class
  iotests: add test for resizing a node below filters

 block.c                                       | 12 +++
 block/io.c                                    |  9 +--
 include/block/block_int-common.h              |  5 +-
 include/block/block_int-io.h                  |  6 ++
 tests/qemu-iotests/tests/resize-below-filter  | 73 +++++++++++++++++++
 .../tests/resize-below-filter.out             |  5 ++
 6 files changed, 103 insertions(+), 7 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/resize-below-filter
 create mode 100644 tests/qemu-iotests/tests/resize-below-filter.out

-- 
2.47.2



