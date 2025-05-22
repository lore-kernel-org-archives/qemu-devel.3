Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E5C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI1vf-0004YW-VP; Thu, 22 May 2025 05:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uI1vb-0004Xe-CG; Thu, 22 May 2025 05:09:27 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uI1vY-0001d9-BB; Thu, 22 May 2025 05:09:26 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9440D43CA7;
 Thu, 22 May 2025 11:09:19 +0200 (CEST)
Message-ID: <da1004d1-6366-4d2f-bc71-fd20de054bde@proxmox.com>
Date: Thu, 22 May 2025 11:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/24] block: move drain outside of
 bdrv_change_aio_context() and mark GRAPH_RDLOCK
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-9-f.ebner@proxmox.com> <aC35wP_tPcNzFvP9@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aC35wP_tPcNzFvP9@redhat.com>
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

Am 21.05.25 um 18:05 schrieb Kevin Wolf:
> Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
>> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
>>
>> Note that even if bdrv_drained_begin() would already be marked as
> 
> "if ... were already marked"

Ack.

---snip 8<---

>> diff --git a/block.c b/block.c
>> index 01144c895e..7148618504 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -106,9 +106,9 @@ static void bdrv_reopen_abort(BDRVReopenState *reopen_state);
>>  
>>  static bool bdrv_backing_overridden(BlockDriverState *bs);
>>  
>> -static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>> -                                    GHashTable *visited, Transaction *tran,
>> -                                    Error **errp);
>> +static bool GRAPH_RDLOCK
>> +bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>> +                        GHashTable *visited, Transaction *tran, Error **errp);
> 
> For static functions, we should have rhe GRAPH_RDLOCK annotation both
> here and in the actual definition, too.

Will fix in v3!

>>  /* If non-zero, use only whitelisted block drivers */
>>  static int use_bdrv_whitelist;
>> @@ -3040,8 +3040,10 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
>>  
>>          /* No need to visit `child`, because it has been detached already */
>>          visited = g_hash_table_new(NULL, NULL);
>> +        bdrv_drain_all_begin();
>>          ret = s->child->klass->change_aio_ctx(s->child, s->old_parent_ctx,
>>                                                visited, tran, &error_abort);
>> +        bdrv_drain_all_end();
>>          g_hash_table_destroy(visited);
>>  
>>          /* transaction is supposed to always succeed */
>> @@ -3122,9 +3124,11 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
>>              bool ret_child;
>>  
>>              g_hash_table_add(visited, new_child);
>> +            bdrv_drain_all_begin();
>>              ret_child = child_class->change_aio_ctx(new_child, child_ctx,
>>                                                      visited, aio_ctx_tran,
>>                                                      NULL);
>> +            bdrv_drain_all_end();
>>              if (ret_child == true) {
>>                  error_free(local_err);
>>                  ret = 0;
> 
> Should we document in the header file that BdrvChildClass.change_aio_ctx
> is called with the node drained?
> 
> We could add assertions to bdrv_child/parent_change_aio_context or at
> least comments to this effect. (Assertions might be over the top because
> it's easy to verify that both are only called from
> bdrv_change_aio_context().)

Sounds good. Would the following be okay?

For bdrv_parent_change_aio_context() and for change_aio_ctx() the same
(except the name of @child is @c for the former):

> /*
>  * Changes the AioContext of for @child to @ctx and recursively for the
>  * associated block nodes and all their children and parents. Returns true if
>  * the change is possible and the transaction @tran can be continued. Returns
>  * false and sets @errp if not and the transaction must be aborted.
>  *
>  * @visited will accumulate all visited BdrvChild objects. The caller is
>  * responsible for freeing the list afterwards.
>  *
>  * Must be called with the affected block nodes drained.
>  */

and for bdrv_child_change_aio_context() slightly different:

> /*
>  * Changes the AioContext of for @c->bs to @ctx and recursively for all its
>  * children and parents. Returns true if the change is possible and the
>  * transaction @tran can be continued. Returns false and sets @errp if not and
>  * the transaction must be aborted.
>  *
>  * @visited will accumulate all visited BdrvChild objects. The caller is
>  * responsible for freeing the list afterwards.
>  *
>  * Must be called with the affected block nodes drained.
>  */

---snip 8<---

>> @@ -7720,7 +7717,11 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
>>      if (ignore_child) {
>>          g_hash_table_add(visited, ignore_child);
>>      }
>> +    bdrv_drain_all_begin();
>> +    bdrv_graph_rdlock_main_loop();
>>      ret = bdrv_change_aio_context(bs, ctx, visited, tran, errp);
>> +    bdrv_graph_rdunlock_main_loop();
>> +    bdrv_drain_all_end();
>>      g_hash_table_destroy(visited);
> 
> I think you're ending the drained section too early here. Previously,
> the nodes were kept drained until after tran_abort/commit(), and I think
> that's important (tran_commit() is the thing that actually switches the
> AioContext).

Right, I'll change this in v3.

Best Regards,
Fiona


