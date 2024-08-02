Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11BDC52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZuFQ-00016k-47; Fri, 02 Aug 2024 11:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZuFN-00014B-OZ; Fri, 02 Aug 2024 11:31:13 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZuFK-0006mK-KY; Fri, 02 Aug 2024 11:31:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3600760987;
 Fri,  2 Aug 2024 18:31:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4VaHMO0g7Ko0-B3beJrlZ; Fri, 02 Aug 2024 18:31:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722612664;
 bh=wd6h9xUNfL3dI4mHUPihBhfYfo4pOAoRxlcIe9gbwn4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=U4dIfr1uNVNRr1y8t9qqEaoYCK+NoDQ6iV7HStC0C6XY6MItvZJioF/PsmoySWey1
 y1qoi1hEU+zkJIrlBIBmovP1Ygsp2spw0UwID5+ZbObWDWmFxrebLBh+MiFsjCOrK9
 mR//JTuiFzjcTr4wPkgkwABXPx/ZfAUbwrx31y+Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6769e441-e3c1-4f9f-b7c1-ff9875b9dbf1@yandex-team.ru>
Date: Fri, 2 Aug 2024 18:31:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: zero data data corruption using
 prealloc-filter
To: "Denis V. Lunev" <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, eesposit@redhat.com
References: <20240712094617.565237-1-andrey.drobyshev@virtuozzo.com>
 <20240712094617.565237-2-andrey.drobyshev@virtuozzo.com>
 <ee1cf8a6-a381-4e30-9f5b-e6fd0a049863@yandex-team.ru>
 <a5104e75-dd44-4524-916d-1196fd585647@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <a5104e75-dd44-4524-916d-1196fd585647@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 16.07.24 16:32, Denis V. Lunev wrote:
> On 7/12/24 13:55, Vladimir Sementsov-Ogievskiy wrote:
>> On 12.07.24 12:46, Andrey Drobyshev wrote:
>>> From: "Denis V. Lunev" <den@openvz.org>
>>>
>>> We have observed that some clusters in the QCOW2 files are zeroed
>>> while preallocation filter is used.
>>>
>>> We are able to trace down the following sequence when prealloc-filter
>>> is used:
>>>      co=0x55e7cbed7680 qcow2_co_pwritev_task()
>>>      co=0x55e7cbed7680 preallocate_co_pwritev_part()
>>>      co=0x55e7cbed7680 handle_write()
>>>      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>>>      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>>>      co=0x7f9edb7fe500 do_fallocate()
>>>
>>> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
>>> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
>>> time to handle next coroutine, which
>>>      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>>>      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>>>      co=0x55e7cbee91b0 handle_write()
>>>      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>>>      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>>>      co=0x7f9edb7deb00 do_fallocate()
>>>
>>> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
>>> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
>>> the same area. This means that if (once fallocate is started inside
>>> 0x7f9edb7deb00) original fallocate could end and the real write will
>>> be executed. In that case write() request is handled at the same time
>>> as fallocate().
>>>
>>> The patch moves s->file_lock assignment before fallocate and that is
>>
>> text need to be updated
>>
>>> crucial. The idea is that all subsequent requests into the area
>>> being preallocation will be issued as just writes without fallocate
>>> to this area and they will not proceed thanks to overlapping
>>> requests mechanics. If preallocation will fail, we will just switch
>>> to the normal expand-by-write behavior and that is not a problem
>>> except performance.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>   block/preallocate.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/preallocate.c b/block/preallocate.c
>>> index d215bc5d6d..ecf0aa4baa 100644
>>> --- a/block/preallocate.c
>>> +++ b/block/preallocate.c
>>> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>>         want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>>>   +    /*
>>> +     * Assign file_end before making actual preallocation. This will ensure
>>> +     * that next request performed while preallocation is in progress will
>>> +     * be passed without preallocation.
>>> +     */
>>> +    s->file_end = prealloc_end;
>>> +
>>>       ret = bdrv_co_pwrite_zeroes(
>>>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>>>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
>>> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>>           return false;
>>>       }
>>>   -    s->file_end = prealloc_end;
>>>       return want_merge_zero;
>>>   }
>>
>>
>> Hmm. But this way we set both s->file_end and s->zero_start prior to actual write_zero operation. This means that next write-zero operation may go fast-path (see preallocate_co_pwrite_zeroes()) and return success, even before actual finish of preallocation write_zeroes operation (which may also fail). Seems we need to update logic around s->zero_start too.
>>
> Yes. This is not a problem at all. We go fast path and this new
> fast-pathed write request will stuck on overlapped request check.
> This if fine on success path.

Sorry for long delay. By fast-path I meant when we return true from

     /* Now s->data_end, s->zero_start and s->file_end are valid. */
                                                                                  
     if (end <= s->file_end) {
         /* No preallocation needed. */
         return want_merge_zero && offset >= s->zero_start;
     }

and then, preallocate_co_pwrite_zeroes() just reports success immediately. So, we don't stuck in any overlap-check.

Probably, that's not too bad: we just skip the write-zero after EOF. If user read from this area, zeroes should be returned anyway.

Still, if we do so we mix our preallocation (which we truncate at the end) with user written zeroes. So we may truncate user-written zeroes in the end. How much is it bad it's a question, but it was not planned in original code.

> 
> But error path is a trickier question.
> 
> iris ~/src/qemu $ cat 1.c
> #include <stdio.h>
> #include <unistd.h>
> #include <string.h>
> #include <fcntl.h>
> 
> int main()
> {
>      int fd = open("file", O_RDWR | O_CREAT);
>      char buf[4096];
> 
>      memset(buf, 'a', sizeof(buf));
>      pwrite(fd, buf, sizeof(buf), 4096);
> 
>      return 0;
> }
> iris ~/src/qemu $
> 
> This works just fine, thus error path would be also fine.
> 
> Den

-- 
Best regards,
Vladimir


