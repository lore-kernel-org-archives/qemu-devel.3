Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D1FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricTQ-0002zJ-Dn; Fri, 08 Mar 2024 10:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTL-0002iG-W0; Fri, 08 Mar 2024 10:49:24 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTK-000481-CS; Fri, 08 Mar 2024 10:49:23 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4339C488C2;
 Fri,  8 Mar 2024 16:49:20 +0100 (CET)
Message-ID: <0a7ac6dd-3100-498f-9669-6b888ecbdb8f@proxmox.com>
Date: Fri, 8 Mar 2024 16:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 alexander.ivanov@virtuozzo.com
References: <20240228141501.455989-1-vsementsov@yandex-team.ru>
 <20240228141501.455989-5-vsementsov@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240228141501.455989-5-vsementsov@yandex-team.ru>
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

Am 28.02.24 um 15:15 schrieb Vladimir Sementsov-Ogievskiy:
> Add a parameter that enables discard-after-copy. That is mostly useful
> in "push backup with fleecing" scheme, when source is snapshot-access
> format driver node, based on copy-before-write filter snapshot-access
> API:
> 
> [guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
>    |            |
>    | root       | file
>    v            v
> [copy-before-write]
>    |             |
>    | file        | target
>    v             v
> [active disk]   [temp.img]
> 
> In this case discard-after-copy does two things:
> 
>  - discard data in temp.img to save disk space
>  - avoid further copy-before-write operation in discarded area
> 
> Note that we have to declare WRITE permission on source in
> copy-before-write filter, for discard to work. Still we can't take it
> unconditionally, as it will break normal backup from RO source. So, we
> have to add a parameter and pass it thorough bdrv_open flags.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>


