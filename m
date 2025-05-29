Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCF2C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 04:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKUv5-0008BA-9P; Thu, 29 May 2025 00:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKUuw-0008AU-Vd
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:30:59 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKUut-0003Ij-Dw
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:30:58 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af548cb1f83so447300a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 21:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748493051; x=1749097851;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JKZiHC5LL9HFEfkfheH93l8WWb0G46WNBXOgweuqW8g=;
 b=yWGCa/zqA+uexBdWhJSw0Lz2lVtlqGvIJMWufrGySJSJvK9RuLR5VyT0hSiYgm5nOs
 l1nX3ifYQxqOZYUEJCXEbpfNu7GwYrVdkCEto0LGuNQluskf2VbKXrctXMB+hgHm+f46
 zulE9ZacS+bYbdUSGg+kJnd5TcoSvqWeVCl7Kmq1w5MInncV/G3iZ+Qouthd3EkcaPF6
 kTSbyt0wQTlaoQVT4rtw44Y7az9l0R0gPbufeXzEFQ1y3ahhpTII3O9Fax9xAGbkR52n
 R1Chm7HImxjizAKNHIiKU2XflzyN3VZowTTj0QpUXVv4kLHtCHBaxuEwq0ai8la4+b7e
 0LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748493051; x=1749097851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JKZiHC5LL9HFEfkfheH93l8WWb0G46WNBXOgweuqW8g=;
 b=IMw9MwSa+NvqrvKMqes5G6saCjXTPLGzPP4FvYRVJaE+OHRXNV+uWBWeY19oFftHUg
 ezomdMz1bw6iR1/Vq1W4AI8c/E0ZjS0QpYR93l4cmSlM15Ay2fPtgCA/L4jS7AtysB6A
 YRju9jP71TmWN4CdkMHb4MBOIvWXJZcbirZvWHBONBhLwd64Ffbkdvi682A9JLoU8rsn
 iCv9PRDX79PNruTvH3h28JH9lCXgHbq93v1HwIURxGRWjSYYy1GDaDXbE0q+/cOBvWHo
 H8Lcbj6Jghnol0EtYSFJxOEo9v5XoH+bynAPCC5FZgCt8qfJr23IAekgnS0K0rE/MgtI
 eBhA==
X-Gm-Message-State: AOJu0YyPwsEkrKwP4Z/7Izv/rjpEKtz5ndonPLRYquXfQQ+MZi2MY/8g
 iw36KtMBECGF/t+LszdWkf9Ss0mpS4nBp7+OUko/oAWb8YcZzQFQ59k6PD12fkIYSoU=
X-Gm-Gg: ASbGnctS/RfRBlXLaIFlRbSbBwhtQDd7iJ2Tq0+eJKYA0Z12u4ZE0dUhdvsVs5fNYIy
 9rRJzkzf35cupAXQQA4UUXyyzfDl74FAdXhgv4MX5P9uR+HlRSuIHYcspx0A9De5sGy4WW0B0Yy
 2ULa+xo/LO2nFZm+qQSq7cFguBtsc0nxNVl5y3pCZ1MJ+J8u0r5JKQrlVNO4LUk99r9V/s69UCB
 eyW6bx8NXbQTtOg6adkQlVi24He2p0a2mgRx0/yAKoNXV/wpWsG0lfNZ3EhjdDDoDsxBnwwuQZm
 odpUszUgR7Bo6pX+t24M0TiLoPJN1EaMqgevItUwfshdAKu34PLnLW9CwTMmYg==
X-Google-Smtp-Source: AGHT+IGPeBZNqHRqlItsIj05Qbz5wr57ECbi7O3TNMSc64FUTHNMpYBAbFjp6A8wrjhIQHm1DY52Qw==
X-Received: by 2002:a17:903:18b:b0:234:c2e7:a0d0 with SMTP id
 d9443c01a7336-234c2e7a293mr94213815ad.5.1748493051498; 
 Wed, 28 May 2025 21:30:51 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506be2622sm3990945ad.102.2025.05.28.21.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 21:30:51 -0700 (PDT)
Message-ID: <e2ce1dd8-ca37-4aa8-9d72-29d9ea3f3793@daynix.com>
Date: Thu, 29 May 2025 13:30:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] file-posix: Tolerate unaligned hole at middle
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, devel@daynix.com
References: <20250528-dio-v1-1-633066a71b8c@daynix.com>
 <wh5wbm4cfu6jxt3lchkktqnduxyxctpn7byeilmvdt7li4jllp@ol7geqo2t76q>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <wh5wbm4cfu6jxt3lchkktqnduxyxctpn7byeilmvdt7li4jllp@ol7geqo2t76q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/28 22:00, 'Eric Blake' via devel wrote:
> On Wed, May 28, 2025 at 08:30:05PM +0900, Akihiko Odaki wrote:
>> file-posix used to assume that existing holes satisfy the requested
>> alignment, which equals to the estimated direct I/O alignment
>> requirement if direct I/O is requested, and assert the assumption
>> unless it is at EOF.
>>
>> However, the estimation of direct I/O alignment requirement is sometimes
>> inexact and can be overly strict. For example, I observed that QEMU
>> estimated the alignment requirement as 16K while the real requirement
>> is 4K when Btrfs is used on Linux 6.14.6 and the host page size is 16K.
>>
>> For direct I/O alignment, open(2) sugguests as follows:
>>> Since Linux 6.1, O_DIRECT support and alignment restrictions for a
>>> file can be queried using statx(2), using the STATX_DIOALIGN flag.
>>> Support for STATX_DIOALIGN varies by filesystem; see statx(2).
> 
> We really should be using statx() in the block/ subdirectory (even
> though we aren't yet) - over time, more and more filesystems WILL
> support it, and it is a more precise answer than anything else.

I found the following patch searching qemu-devel:
https://lore.kernel.org/qemu-devel/20221103183609.363027-3-stefanha@redhat.com/

> 
>>>
>>> Some filesystems provide their own interfaces for querying O_DIRECT
>>> alignment restrictions, for example the XFS_IOC_DIOINFO operation in
>>> xfsctl(3). STATX_DIOALIGN should be used instead when it is available.
>>>
>>> If none of the above is available, then direct I/O support and
>>> alignment restrictions can only be assumed from known characteristics
>>> of the filesystem, the individual file, the underlying storage
>>> device(s), and the kernel version. In Linux 2.4, most filesystems
>>> based on block devices require that the file offset and the length and
>>> memory address of all I/O segments be multiples of the filesystem
>>> block size (typically 4096 bytes). In Linux 2.6.0, this was relaxed to
>>> the logical block size of the block device (typically 512 bytes). A
>>> block device's logical block size can be determined using the ioctl(2)
>>> BLKSSZGET operation or from the shell using the command:
>>
>> Apparently Btrfs doesn't support STATX_DIOALIGN nor provide its own
>> interface for querying the requirement. Using BLKSSZGET brings another
>> problem to determine the underlying block device, which also involves
>> heuristics.
>>
>> Moreover, even if we could figure out the direct I/O alignment
>> requirement, I could not find a documentation saying it will exactly
>> matche with the alignment of holes.
> 
> s/matche/match/

I'll fix it with the next version.

> 
>>
>> So stop asserting the assumption on the holes and tolerate them being
>> unaligned.
> 
> Tolerating unaligned holes is wise, even if we can improve our probing
> to be more accurate in other patches.  That said...
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   block/file-posix.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index ec95b748696b..7b686ce6817d 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -3307,22 +3307,21 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
>>           *pnum = bytes;
>>           ret = BDRV_BLOCK_DATA;
>>       } else if (data == offset) {
>> -        /* On a data extent, compute bytes to the end of the extent,
>> -         * possibly including a partial sector at EOF. */
>> +        /* On a data extent, compute bytes to the end of the extent. */
>>           *pnum = hole - offset;
>>   
>>           /*
>> +         * We may have allocation unaligned with the requested alignment due to
>> +         * the following reaons:
>> +         * - unaligned file size
>> +         * - inexact direct I/O alignment requirement estimation
>> +         * - mismatches between the allocation size and
>> +         *   direct I/O alignment requirement.
>> +         *
>>            * We are not allowed to return partial sectors, though, so
>>            * round up if necessary.
>>            */
>> -        if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
>> -            int64_t file_length = raw_getlength(bs);
>> -            if (file_length > 0) {
>> -                /* Ignore errors, this is just a safeguard */
>> -                assert(hole == file_length);
>> -            }
>> -            *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
>> -        }
>> +        *pnum = ROUND_UP(*pnum, bs->bl.request_alignment);
>>   
>>           ret = BDRV_BLOCK_DATA;
> 
> ...rounding data extent sizes up to the alignment that the rest of the
> block layer sees is always safe.  But I would expect some symmetry -
> anywhere we are rounding up to report data instead of hole, there
> either needs to be counterpart code on the holes or else a good reason
> why the holes don't need matching code, where unaligned holes are
> rounded down to alignment boundaries (and if that rounds down to 0,
> report data instead).  That way, you can't get different answers based
> on where in the sector you are asking the question.  We do know that
> the block layer is supposed to only be asking the question at the
> start of an alignment boundary (even when our alignment boundaries are
> too large, such as your mention of 16k alignment when the filesystem
> supports 4k holes).  At best, it may just be a matter of adding
> comments to document why we are safe, but I'm not sure that is
> sufficient for this patch.
> 
> Restated visually, if we have | at 16k boundaries (what qemu picked as
> the dio alignment), + at 4k boundaries (the granularity of holes that
> the fs supports), and the following file structure with Data and Holes
> marked:
> 
> |+++|+++|+++|+++|+++|
> DDDDDHHHHDDHDDDDHHHH
> 
> Then the claim is that the block layer will only ever ask for status
> at the | points (and not at the +), and the results that it should see
> after rounding are as follows (where lowercase respresents changed
> results due to rounding to alignment):
> 
> |+++|+++|+++|+++|+++|
> DDDDDHHHHDDHDDDDHHHH
> DDDDDddddDDdDDDDHHHH
>          ^
> 
> But the important question I don't see in your patch is whether you
> handle a block_status query at the point of ^ correctly (it lands in a
> hole, but since there is data also present in that alignment boundary,
> you have to report the entire 16k as data).

Thank you for a detailed explanation. I will ensure that offset + *pnum 
will be aligned with bs->bl.request_alignment with the next version, 
which I think semantically makes sense.

