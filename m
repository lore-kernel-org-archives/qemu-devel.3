Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53929C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGXQ-0002oA-6o; Wed, 28 May 2025 09:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uKGXH-0002m4-S9; Wed, 28 May 2025 09:09:36 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uKGXE-0004iQ-Lc; Wed, 28 May 2025 09:09:35 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 07BB240F5B;
 Wed, 28 May 2025 15:09:27 +0200 (CEST)
Message-ID: <71ee9ce4-706c-4314-9872-761cc2189efa@proxmox.com>
Date: Wed, 28 May 2025 15:09:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/24] block: move drain outside of
 bdrv_set_backing_hd_drained()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
 <20250526132140.1641377-12-f.ebner@proxmox.com> <aDXaW_Xr5etQejUd@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aDXaW_Xr5etQejUd@redhat.com>
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

Am 27.05.25 um 17:29 schrieb Kevin Wolf:
> Am 26.05.2025 um 15:21 hat Fiona Ebner geschrieben:
>> @@ -3578,7 +3577,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
>>      ret = bdrv_refresh_perms(bs, tran, errp);
>>  out:
>>      tran_finalize(tran, ret);
>> -    bdrv_drain_all_end();
>>      return ret;
>>  }
> 
> Do we need to update the comment for bdrv_set_backing_hd_drained()?
> 
>  * If a backing child is already present (i.e. we're detaching a node), that
>  * child node must be drained.
> 
> Same as in the previous patch, this is now probably all nodes.

Yes, and even in case no backing child is already present.

>> @@ -3594,11 +3592,11 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
>>      bdrv_graph_rdunlock_main_loop();
>>  
>>      bdrv_ref(drain_bs);
>> -    bdrv_drained_begin(drain_bs);
>> +    bdrv_drain_all_begin();
>>      bdrv_graph_wrlock();
>>      ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
>>      bdrv_graph_wrunlock();
>> -    bdrv_drained_end(drain_bs);
>> +    bdrv_drain_all_end();
>>      bdrv_unref(drain_bs);
> 
> The only thing we do with drain_bs now is finding it, bdrv_ref() and
> immediately bdrv_unref(). I don't think it should exist any more after
> the change to drain_all.

I'll drop it in v4.

I now noticed that bdrv_set_backing_hd() is required to be
GRAPH_UNLOCKED, because it calls bdrv_drain_all_begin(), but is not
marked as such yet. Adding that annotation requires adapting some
callers of bdrv_set_backing_hd() first. I'll try to add some more
patches at the end of the series for this.

At least the caller in block/mirror.c seems to be better of using
bdrv_set_backing_hd_drained() and bdrv_graph_wrlock_drained() itself, so
the section can cover more related calls like
"unfiltered_target = bdrv_skip_filters(target_bs);"

Best Regards,
Fiona


