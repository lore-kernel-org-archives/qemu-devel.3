Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27A5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricU2-0005Xe-B0; Fri, 08 Mar 2024 10:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTz-0005Al-Sy; Fri, 08 Mar 2024 10:50:04 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTx-0004DV-Ty; Fri, 08 Mar 2024 10:50:03 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 19B4E488C0;
 Fri,  8 Mar 2024 16:50:00 +0100 (CET)
Message-ID: <c2251dd3-0e7e-4f97-86a1-cb01f98a2bb2@proxmox.com>
Date: Fri, 8 Mar 2024 16:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] backup: discard-source parameter
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 alexander.ivanov@virtuozzo.com
References: <20240228141501.455989-1-vsementsov@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240228141501.455989-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 28.02.24 um 15:14 schrieb Vladimir Sementsov-Ogievskiy:
> Hi all! The main patch is 04, please look at it for description and
> diagram.
> 
> v3:
> 02: new patch
> 04: take WRITE permission only when discard_source is required
> 
> Vladimir Sementsov-Ogievskiy (5):
>   block/copy-before-write: fix permission
>   block/copy-before-write: support unligned snapshot-discard
>   block/copy-before-write: create block_copy bitmap in filter node
>   qapi: blockdev-backup: add discard-source parameter
>   iotests: add backup-discard-source
> 
>  block/backup.c                                |   5 +-
>  block/block-copy.c                            |  12 +-
>  block/copy-before-write.c                     |  39 ++++-
>  block/copy-before-write.h                     |   1 +
>  block/replication.c                           |   4 +-
>  blockdev.c                                    |   2 +-
>  include/block/block-common.h                  |   2 +
>  include/block/block-copy.h                    |   2 +
>  include/block/block_int-global-state.h        |   2 +-
>  qapi/block-core.json                          |   4 +
>  tests/qemu-iotests/257.out                    | 112 ++++++-------
>  .../qemu-iotests/tests/backup-discard-source  | 151 ++++++++++++++++++
>  .../tests/backup-discard-source.out           |   5 +
>  13 files changed, 271 insertions(+), 70 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/backup-discard-source
>  create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out
> 

Tested-by: Fiona Ebner <f.ebner@proxmox.com>


