Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464B2C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI2fK-0001QS-2O; Thu, 22 May 2025 05:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uI2fH-0001Pb-Bc; Thu, 22 May 2025 05:56:39 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uI2fE-00018J-0t; Thu, 22 May 2025 05:56:38 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2DA6E43CD8;
 Thu, 22 May 2025 11:56:23 +0200 (CEST)
Message-ID: <67436842-4c8a-4536-ad6f-36952160770e@proxmox.com>
Date: Thu, 22 May 2025 11:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/24] block: move drain outside of
 bdrv_try_change_aio_context()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-10-f.ebner@proxmox.com> <aC4BCk_BWM-lMuVs@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aC4BCk_BWM-lMuVs@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 21.05.25 um 18:36 schrieb Kevin Wolf:
> Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
>> This is part of resolving the deadlock mentioned in commit "block:
>> move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".
>>
>> Convert the function to a _locked() version that has to be called with
>> the graph lock held and add a convenience wrapper that has to be
>> called with the graph unlocked, which drains and takes the lock
>> itself. Since bdrv_try_change_aio_context() is global state code, the
>> wrapper is too.
>>
>> Callers are adapted to use the appropriate variant. In the
>> test_set_aio_context() unit test, prior drains can be removed, because
>> draining already happens inside the new wrapper.
> 
> I'm not sure what's the difference between qmp_x_blockdev_set_iothread()
> which is converted to _locked() and e.g. qmp_blockdev_mirror().

For deciding on the variant, I only looked at whether the caller holds
the graph lock or not.

> The reason I could see in qmp_x_blockdev_set_iothread() is that (as we
> discussed in the RFC version of this series) draining can change the
> graph and that could in theory invalidate bs. But the same is true for
> other functions in blockdev.c.

Right, my patches are not enough to address that kind of problem.

> If it's just that qmp_x_blockdev_set_iothread() was easy to fix and the
> others are more complex, that's fine with me, but maybe worth mentioning
> in the commit message.

Yes, I can mention something in the commit message, maybe:

Functions like qmp_blockdev_mirror() query the nodes to act on before
draining and locking. In theory, draining could invalidate those nodes.
This kind of issue is not addressed by these commits.

Best Regards,
Fiona


