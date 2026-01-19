Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C730D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqa3-0008M5-Hq; Mon, 19 Jan 2026 09:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZm-0008Cg-Fc; Mon, 19 Jan 2026 09:49:56 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZi-0008Ml-E6; Mon, 19 Jan 2026 09:49:54 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C88218085E;
 Mon, 19 Jan 2026 17:49:43 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gnaGbV0CCKo0-hgzC1tPF; Mon, 19 Jan 2026 17:49:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768834183;
 bh=dKi326HYyvb6idNJK3J9Lw8tWJhYcbocAWIkXh0Zf7I=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=IrRdAlOmhc7ZZ1Q6ory6O4Nb19nkPMKIg0qzmkdRT1K5Soq92o4qqFaubGaTlyTx3
 k9HIHBw0HIytzzo1/6+u/4tcnwUqk+vxt4iyfoaj3sTIeJ7K5wsOP3T5IvW6ehO42P
 urSNXIXLnjn/JPudBWnCP4HneKE02U7UmqFPV6oU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v10 0/8] blockdev-replace
Date: Mon, 19 Jan 2026 17:49:33 +0300
Message-ID: <20260119144941.87936-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all!

This series presents a new command blockdev-replace, which helps to
insert/remove filters anywhere in the block graph. It can:

 - replace qdev block-node by qdev-id
 - replace export block-node by export-id
 - replace any child of parent block-node by node-name and child name

So insertions is done in two steps:

1. blockdev_add (create filter node, unparented)

    [some parent]  [new filter]
     |               |
     V               V
    [        some child       ]

2. blockdev-replace (replace child by the filter)

    [some parent]
     | 
     V
    [new filter]
     |
     V
    [some child]

And removal is done in reverse order:

1. blockdev-replace (go back to picture 1)
2. blockdev_del (remove filter node)

Ideally, we should do both operations (add + replace or replace + del) in a
transaction, but that should be another series.

v10: reabsed on master.
02: change exp-blk check into assert
04: rewrite to simpler API (on unique parent id)
07: switch to new API
08: new

Vladimir Sementsov-Ogievskiy (8):
  block-backend: blk_root(): drop const specifier on return type
  block/export: add blk_by_export_id()
  block: make bdrv_find_child() function public
  qapi: add blockdev-replace command
  block: bdrv_get_xdbg_block_graph(): report export ids
  iotests.py: introduce VM.assert_edges_list() method
  iotests: add filter-insertion
  deprecate names duplication between qdev, block-node and block-export

 block.c                                       |  29 +++
 block/block-backend.c                         |   2 +-
 block/export/export.c                         |  41 ++++
 blockdev.c                                    |  82 +++++--
 docs/about/deprecated.rst                     |  10 +
 include/block/block-global-state.h            |   1 +
 include/block/block_int-io.h                  |   2 +
 include/block/export.h                        |   1 +
 include/system/block-backend-global-state.h   |   5 +-
 qapi/block-core.json                          |  24 ++
 stubs/blk-by-qdev-id.c                        |  18 ++
 stubs/blk-exp-find-by-blk.c                   |  13 +
 stubs/meson.build                             |   2 +
 system/qdev-monitor.c                         |  16 ++
 tests/qemu-iotests/iotests.py                 |  17 ++
 tests/qemu-iotests/tests/filter-insertion     | 222 ++++++++++++++++++
 tests/qemu-iotests/tests/filter-insertion.out |   5 +
 17 files changed, 474 insertions(+), 16 deletions(-)
 create mode 100644 stubs/blk-by-qdev-id.c
 create mode 100644 stubs/blk-exp-find-by-blk.c
 create mode 100755 tests/qemu-iotests/tests/filter-insertion
 create mode 100644 tests/qemu-iotests/tests/filter-insertion.out

-- 
2.52.0


