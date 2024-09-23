Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40F9CF9C70
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 13:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssjQc-0006tr-Ik; Mon, 23 Sep 2024 09:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1ssjQb-0006sJ-B2; Mon, 23 Sep 2024 09:48:37 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1ssjQY-0007co-RH; Mon, 23 Sep 2024 09:48:37 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B1A25C5897;
 Mon, 23 Sep 2024 13:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41751C4CEC4;
 Mon, 23 Sep 2024 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727099310;
 bh=HuMMChUdC1UukgvtTeuJ1DeYHz8RT0EB4AVI21bBJrg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k0LxE29Y8YdNpkSEia5PjLXW3/0NVI7KfYimXE9xEug2qYIakyIYm+TTTetHXodRX
 +X6Rkmi7VOMAwk1hlunX/NV5kMcGHQmtiY0mzZ0nxaPZDkGFwzzuC07tHnQ52F/AzZ
 ryh2H/12frsyCdc2iVOb2XQeXgn9PMIPTo85NOCUFvfZ8n7PtJJrFspiWNqFRtv3ag
 sB6yeuYQRIj+7rs3i3TB9ZSFiJIlWGvmN7YzzJZeSP/aeNZBhcEPT3viZW8huO/CsP
 hTc4/rGMe7EC/mbZHUARNGAd+u11Gm30R1k73mZ8bWX5QmzbD+rud8gJMeVvoJWP5J
 UwcH8h2lz3Zrg==
Message-ID: <1a673b82-4362-4f10-bf62-41825f5a203b@kernel.org>
Date: Mon, 23 Sep 2024 15:48:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] qcow2: add zoned emulation capability
To: Sam Li <faithilikerun@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-4-faithilikerun@gmail.com>
 <20240312183010.GB389553@fedora>
 <CAAAx-8LyxDtZra_5TC0CLmq4F4ShYtQqVTF0OCGVZ9tYWP4QMA@mail.gmail.com>
 <bc821290-2003-4795-a5fa-99a7c55e1374@kernel.org>
 <CAAAx-8JrPFEgBPKWEjXCXi8=ReEMkCEVGe-GEPSWUnfEGcZ=XQ@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAAx-8JrPFEgBPKWEjXCXi8=ReEMkCEVGe-GEPSWUnfEGcZ=XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=dlemoal@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/09/23 15:40, Sam Li wrote:
> Hi Damien,
> 
> Damien Le Moal <dlemoal@kernel.org> 于2024年9月23日周一 15:22写道：
>>
>> On 2024/09/23 13:06, Sam Li wrote:
>>
>> [...]
>>
>>>>> @@ -2837,6 +3180,19 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>>>>          qiov_offset += cur_bytes;
>>>>>          trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
>>>>>      }
>>>>> +
>>>>> +    if (bs->bl.zoned == BLK_Z_HM) {
>>>>> +        index = start_offset / zone_size;
>>>>> +        wp = &bs->wps->wp[index];
>>>>> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
>>>>> +            /* Advance the write pointer when the write completes */
>>>>
>>>> Updating the write pointer after I/O does not prevent other write
>>>> requests from beginning at the same offset as this request. Multiple
>>>> write request coroutines can run concurrently and only the first one
>>>> should succeed. The others should fail if they are using the same
>>>> offset.
>>>>
>>>> The comment above says "Real drives change states before it can write to
>>>> the zone" and I think it's appropriate to update the write pointer
>>>> before performing the write too. The qcow2 zone emulation code is
>>>> different from the file-posix.c passthrough code. We are responsible for
>>>> maintaining zoned metadata state and cannot wait for the result of the
>>>> I/O to tell us what happened.
>>
>> Yes, correct. The wp MUST be updated when issuing the IO, with the assumption
>> that the write IO will succeed (errors are rare !).
>>
>>> The problem of updating the write pointer before IO completion is the
>>> failure case.  It can't be predicted in advance if an IO fails or not.
>>> When write I/O fails, the wp should not be updated.
>>
>> Correct, if an IO fails, the wp should not be updated. However, that is not
>> difficult to deal with:
>> 1) under the zone lock, advance the wp position when issuing the write IO
>> 2) When the write IO completes with success, nothing else needs to be done.
>> 3) When *any* write IO completes with error you need to:
>>         - Lock the zone
>>         - Do a report zone for the target zone of the failed write to get the current
>> wp location
>>         - Update bs->wps->wp[index] using that current wp location
>>         - Unlock the zone
>>
>> With that, one may get a few errors if multiple async writes are being issued,
>> but that behavior is consistent with the same happening with a real drive. So no
>> issue. And since the report zones gets you the current wp location, the user can
>> restart writing from that location once it has dealt with all the previous write
>> failures.
> 
> I see. To allow the concurrent writes, the lock will only be used on
> the failure path while processing append writes.
> 
>>
>>> The alternative way is to hold the wps lock as is also required for wp
>>> accessing. Therefore only one of multiple concurrent write requests
>>> will succeed.
>>
>> That is a very simple solution that avoids the above error recovery, but that
>> would be very bad for performance (especially for a pure sequential write
>> workload as we would limit IOs to quue depth 1). So if we can avoid this simple
>> approach, that would be a lot better.
> 
> Yeah, I'll drop this approach. Although, it reminds me of how
> file-posix driver emulates zone_append. It holds the lock whenever
> accessing wps. Does that limit IOs to QD 1 too? If so, it can be
> improved.
> -- one zone_append starts
>>> wp_lock()
>>>> IO processing
>>>>> wp_update
>>>>>> wp_unlock()
> -- ends

Yes, this limits the IO queue depth to 1, so not great. file-posix can use the
exact same error recovery mechanism as I explained. The write IO flow would thus
become:

On submission:

1) wp_lock()
2) Check write alignement with wp (or change zone append into regular write)
3) Issue write as an asynchronous IO
4) wp_update
5) wp_unlock()

And on completion, all you need is:
1) If no error, return success
2) wp_lock()
3) Do a report zone and use the reported wp value as the current wp
4) wp_unlock()
5) return IO error

With this simple scheme, when there are no IO errors, things are fast and there
is no "big lock" limiting the number of writes that can be issued. Only write
error recovery ends up locking everything during the report zones, but that is
fine. Errors are rare :)


-- 
Damien Le Moal
Western Digital Research

