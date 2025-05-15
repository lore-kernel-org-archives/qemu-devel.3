Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E867BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 12:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFXJd-0005Uo-3T; Thu, 15 May 2025 08:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFXJX-0005H6-2x; Thu, 15 May 2025 08:03:52 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFXJU-00036r-RF; Thu, 15 May 2025 08:03:50 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 239A542A2C;
 Thu, 15 May 2025 14:03:46 +0200 (CEST)
Message-ID: <fff173d3-8bcb-4d3e-aa51-62d42e99c858@proxmox.com>
Date: Thu, 15 May 2025 14:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] block/snapshot: move drain outside of read-locked
 bdrv_snapshot_delete()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
 <20250508140936.3344485-4-f.ebner@proxmox.com> <aCTKXFeACdBnrIZ-@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aCTKXFeACdBnrIZ-@redhat.com>
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

Am 14.05.25 um 18:52 schrieb Kevin Wolf:
> Am 08.05.2025 um 16:09 hat Fiona Ebner geschrieben:
>> This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.
>>
>> More granular draining is not trivially possible, because
>> bdrv_snapshot_delete() can recursively call itself.
>>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> ---
>>  block/snapshot.c | 18 ++++++++++++------
>>  blockdev.c       | 25 +++++++++++++++++--------
>>  qemu-img.c       |  2 ++
>>  3 files changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index 22567f1fb9..7788e1130b 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -327,7 +327,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>>  
>>  /**
>>   * Delete an internal snapshot by @snapshot_id and @name.
>> - * @bs: block device used in the operation
>> + * @bs: block device used in the operation, needs to be drained
> 
> Forgot to add this piece of nitpicking on the previous patch: Other
> places say "must be drained", which I slightly prefer because of how
> RFC 2119 has "MUST", but not "NEEDS TO". Matter of taste, I guess, but
> if you agree, we could change it for the non-RFC series.

Sure, will do!

>> @@ -573,9 +571,13 @@ int bdrv_all_delete_snapshot(const char *name,
>>      GList *iterbdrvs;
>>  
>>      GLOBAL_STATE_CODE();
>> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
>> +
>> +    bdrv_drain_all_begin();
>> +    bdrv_graph_rdlock_main_loop();
>>  
>>      if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
>> +        bdrv_graph_rdunlock_main_loop();
>> +        bdrv_drain_all_end();
>>          return -1;
>>      }
> 
> I think this wants to be changed into:
> 
>     ret = bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp);
>     if (ret < 0) {
>         goto out;
>     }
> 
> (Changing the return value from -1 to -errno is fine for the callers.)
> 
>> @@ -594,12 +596,16 @@ int bdrv_all_delete_snapshot(const char *name,
>>          if (ret < 0) {
>>              error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
>>                            name, bdrv_get_device_or_node_name(bs));
>> +            bdrv_graph_rdunlock_main_loop();
>> +            bdrv_drain_all_end();
>>              return -1;
>>          }
> 
> Same here.

Ack.

Best Regards,
Fiona


