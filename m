Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB4C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JjU-000247-U4; Tue, 07 May 2024 08:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s4JjG-0001z3-T3; Tue, 07 May 2024 08:15:31 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s4JjE-0000wJ-Gy; Tue, 07 May 2024 08:15:30 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 57C9C4520B;
 Tue,  7 May 2024 14:15:15 +0200 (CEST)
Message-ID: <14e568d4-ae82-4eaa-921f-1927a9b81ceb@proxmox.com>
Date: Tue, 7 May 2024 14:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mirror: allow specifying working bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com
References: <20240307134711.709816-1-f.ebner@proxmox.com>
 <20240307134711.709816-3-f.ebner@proxmox.com>
 <3e338160-a172-42b8-946c-ae7f7d97a17c@yandex-team.ru>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <3e338160-a172-42b8-946c-ae7f7d97a17c@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 02.04.24 um 22:14 schrieb Vladimir Sementsov-Ogievskiy:
> On 07.03.24 16:47, Fiona Ebner wrote:
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 1609354db3..5c9a00b574 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -51,7 +51,7 @@ typedef struct MirrorBlockJob {
>>       BlockDriverState *to_replace;
>>       /* Used to block operations on the drive-mirror-replace target */
>>       Error *replace_blocker;
>> -    bool is_none_mode;
>> +    MirrorSyncMode sync_mode;
> 
> Could you please split this change to separate preparation patch?
> 

Will do.

>> +        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO,
>> errp)) {
> 
> Why allow read-only bitmaps?
> 

Good catch! This is a left-over from an earlier version. Now that the
bitmap shall be used as the working bitmap, it cannot be read-only. I'll
change it to BDRV_BITMAP_DEFAULT in v3 of the series.

>> +# @bitmap: The name of a bitmap to use as a working bitmap for
>> +#     sync=full mode.  This argument must be not be present for other
>> +#     sync modes and not at the same time as @granularity.  The
>> +#     bitmap's granularity is used as the job's granularity.  When
>> +#     the target is a diff image, i.e. one that should only contain
>> +#     the delta and was not synced to previously, the target's
>> +#     cluster size must not be larger than the bitmap's granularity.
> 
> Could we check this? Like in block_copy_calculate_cluster_size(), we can
> check if target does COW, and if not, we can check that we are safe with
> granularity.
> 

The issue here is (in particular) present when the target does COW, i.e.
in qcow2 diff images, allocated clusters which end up with partial data,
when we don't have the right cluster size. Patch 4/4 adds the check for
the target's cluster size.

>> +#     For a diff image target, using copy-mode=write-blocking should
>> +#     not be used, because unaligned writes will lead to allocated
>> +#     clusters with partial data in the target image!
> 
> Could this be checked?
> 

I don't think so. How should we know if the target already contains data
from a previous full sync or not?

Those caveats when using diff images are unfortunate, and users should
be warned about them of course, but the main/expected use case for the
feature is to sync to the same target multiple times, so I'd hope the
cluster size check in patch 4/4 and mentioning the edge cases in the
documentation is enough here.

>>  The bitmap
>> +#     will be enabled after the job finishes.  (Since 9.0)
> 
> Hmm. That looks correct. At least for the case, when bitmap is enabled
> at that start of job. Suggest to require this.
> 

It's true for any provided bitmap: it will be disabled when the mirror
job starts, because we manually set it in bdrv_mirror_top_do_write() and
then in mirror_exit_common(), the bitmap will be enabled.

Okay, I'll require that it is enabled at the beginning.

>> +#
>>   # @granularity: granularity of the dirty bitmap, default is 64K if the
>>   #     image format doesn't have clusters, 4K if the clusters are
>>   #     smaller than that, else the cluster size.  Must be a power of 2
>> @@ -2548,6 +2578,10 @@
>>   #     disappear from the query list without user intervention.
>>   #     Defaults to true.  (Since 3.1)
>>   #
>> +# Features:
>> +#
>> +# @unstable: Member @bitmap is experimental.
>> +#
>>   # Since: 2.6
> 
> Y_MODE_BACKGROUND,
>>                    &error_abort);
> 
> [..]
> 
> Generally looks good to me.
> 

Thank you for the review!


