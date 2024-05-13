Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7925CC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VfQ-0003eL-K6; Mon, 13 May 2024 09:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s6VfO-0003e4-7l; Mon, 13 May 2024 09:24:34 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s6VfM-0004vi-3n; Mon, 13 May 2024 09:24:33 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AC61247E68;
 Mon, 13 May 2024 15:24:29 +0200 (CEST)
Message-ID: <1acd096c-5ec9-411d-b06e-cd64fb898852@proxmox.com>
Date: Mon, 13 May 2024 15:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] copy-before-write: allow specifying minimum cluster
 size
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com
References: <20240308155158.830258-1-f.ebner@proxmox.com>
 <20240308155158.830258-2-f.ebner@proxmox.com> <875xx9s6pp.fsf@pond.sub.org>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <875xx9s6pp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Am 26.03.24 um 10:06 schrieb Markus Armbruster:
>> @@ -365,7 +368,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>>  
>>      GLOBAL_STATE_CODE();
>>  
>> -    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
>> +    if (min_cluster_size && !is_power_of_2(min_cluster_size)) {
> 
> min_cluster_size is int64_t, is_power_of_2() takes uint64_t.  Bad if
> min_cluster_size is negative.  Could this happen?
> 

No, because it comes in as a uint32_t via the QAPI (the internal caller
added by patch 2/2 from the backup code also gets the value via QAPI and
there uint32_t is used too).

---snip---

>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0a72c590a8..85c8f88f6e 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4625,12 +4625,18 @@
>>  #     @on-cbw-error parameter will decide how this failure is handled.
>>  #     Default 0. (Since 7.1)
>>  #
>> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
>> +#     operations.  Has to be a power of 2.  No effect if smaller than
>> +#     the maximum of the target's cluster size and 64 KiB.  Default 0.
>> +#     (Since 9.0)
>> +#
>>  # Since: 6.2
>>  ##
>>  { 'struct': 'BlockdevOptionsCbw',
>>    'base': 'BlockdevOptionsGenericFormat',
>>    'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
>> -            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
>> +            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
>> +            '*min-cluster-size': 'uint32' } }
> 
> Elsewhere in the schema, we use either 'int' or 'size' for cluster-size.
> Why the difference?
> 

The motivation was to disallow negative values up front and have it work
with block_copy_calculate_cluster_size(), whose result is an int64_t. If
I go with 'int', I'll have to add a check to disallow negative values.
If I go with 'size', I'll have to add a check for to disallow too large
values.

Which approach should I go with?

Best Regards,
Fiona


