Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ABEC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 11:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKFAy-0006bp-0C; Wed, 28 May 2025 07:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uKFAf-0006YG-Vk; Wed, 28 May 2025 07:42:11 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uKFAW-0006gQ-Vo; Wed, 28 May 2025 07:42:06 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EAAEA4190E;
 Wed, 28 May 2025 13:41:47 +0200 (CEST)
Message-ID: <4135ecdc-5c8c-4053-9291-150b765a130f@proxmox.com>
Date: Wed, 28 May 2025 13:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/24] block: move drain outside of
 bdrv_attach_child_common(_abort)()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
 <20250526132140.1641377-11-f.ebner@proxmox.com> <aDXY29pxla27wXru@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aDXY29pxla27wXru@redhat.com>
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

Am 27.05.25 um 17:23 schrieb Kevin Wolf:
> Am 26.05.2025 um 15:21 hat Fiona Ebner geschrieben:
>> @@ -3129,11 +3123,9 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
>>              bool ret_child;
>>  
>>              g_hash_table_add(visited, new_child);
>> -            bdrv_drain_all_begin();
>>              ret_child = child_class->change_aio_ctx(new_child, child_ctx,
>>                                                      visited, aio_ctx_tran,
>>                                                      NULL);
>> -            bdrv_drain_all_end();
>>              if (ret_child == true) {
>>                  error_free(local_err);
>>                  ret = 0;
> 
> Should we mention in the function comment for bdrv_attach_child_common()
> that all block nodes must be drained from before this functoin is called
> until after the transaction is finalized?
> 
> A similar note would probably be good for all the other functions you
> mention in the commit message that don't finalize the transaction yet so
> that we convert them in this same patch.
> 
>> @@ -4721,6 +4719,8 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
>>   * Return 0 on success, otherwise return < 0 and set @errp.
>>   *
>>   * @reopen_state->bs can move to a different AioContext in this function.
>> + *
>> + * The old child bs must be drained.
>>   */
>>  static int GRAPH_UNLOCKED
>>  bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
> 
> Only the old child or all nodes?
> 
> bdrv_try_change_aio_context_locked() is documented as "Called while all
> bs are drained." and we call it indirectly here (which will be more
> obvious when you add the comments as suggested above).

Yes, it needs to be all nodes. I'll try to document the requirement for
all affected functions in v4 (also what you mentioned in the replies to
the other patches).

Best Regards,
Fiona


