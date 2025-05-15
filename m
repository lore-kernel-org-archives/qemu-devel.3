Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62B8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYqS-0004ZU-CD; Thu, 15 May 2025 09:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFYqI-0004YO-ME; Thu, 15 May 2025 09:41:48 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFYqB-000664-JN; Thu, 15 May 2025 09:41:44 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6EB8F42AC7;
 Thu, 15 May 2025 15:41:33 +0200 (CEST)
Message-ID: <19ad4476-d56e-4f7c-9d45-067649d325ef@proxmox.com>
Date: Thu, 15 May 2025 15:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] block: move drain outside of read-locked
 bdrv_reopen_queue_child()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 pbonzini@redhat.com
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-3-f.ebner@proxmox.com> <aCTGceRCQ4bywHx5@redhat.com>
 <d1d0c8c3-9cba-4916-877b-95ccd718a817@proxmox.com>
 <aCXd8MvDPnmKWiRI@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aCXd8MvDPnmKWiRI@redhat.com>
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

Am 15.05.25 um 14:28 schrieb Kevin Wolf:
> Am 15.05.2025 um 13:48 hat Fiona Ebner geschrieben:
>> Am 14.05.25 um 18:36 schrieb Kevin Wolf:
>>> Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
>>>> @@ -4368,6 +4368,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
>>>>                          bool keep_old_opts)
>>>>  {
>>>>      assert(bs != NULL);
>>>> +    assert(qatomic_read(&bs->quiesce_counter) > 0);
>>>
>>> BlockDriverState.quiesce_counter isn't accessed with atomics elsewhere.
>>> Did you confuse it with BlockBackend.quiesce_counter?
>>
>> No, but I saw that it is modified via qatomic_fetch_inc/dec(). And those
>> modifications are in bdrv_do_drained_begin/end() which are
>> IO_OR_GS_CODE(). So isn't it more correct to read via atomics here?
> 
> Aha, I missed these two places. Looks like Paolo's commit 414c2ec wasn't
> very thorough with converting.
> 
> The commit message is also empty, so I don't know why we made this
> change. Both places are GLOBAL_STATE_CODE(), so I don't think we
> actually need atomics to synchronise these two places. Maybe there are
> other accesses in iothreads, but then those should have been using
> atomics, too.

AFAICT, all accesses are either in a function with GLOBAL_STATE_CODE()
directly or in a function with GRAPH_WRLOCK (in the cases of
bdrv_replace_child_tran() and bdrv_replace_child_noperm()).

This does not change for the new accesses added by the series here.

Back then, there was no GLOBAL_STATE_CODE() macro yet, so I suppose this
wasn't easy to verify.

>> The documentation in include/block/block_int-common.h for struct
>> BlockDriverState also states:
>>>     /* Accessed with atomic ops.  */
>>>     int quiesce_counter;
>>
>> Should I rather add a patch to have the other readers use atomics too?
> 
> Either all accesses should use atomics or none of them. I'm not
> completely sure which way is the right one. Using atomics everywhere is
> the safe option, but I'm not sure if we ever access quiesce_counter
> outside of the main thread.

I'd add a patch dropping the atomic accesses and document that
quiesce_counter can only be accessed in the main thread.

Best Regards,
Fiona


