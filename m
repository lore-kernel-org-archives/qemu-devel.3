Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD3EC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 16:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4isu-00070R-M8; Tue, 15 Apr 2025 12:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4isl-0006yX-8k; Tue, 15 Apr 2025 12:11:32 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4ish-0003xm-1O; Tue, 15 Apr 2025 12:11:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:381b:0:640:f69d:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A25B9610FA;
 Tue, 15 Apr 2025 19:11:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:16e::1:36] (unknown
 [2a02:6bf:8080:16e::1:36])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HBKFMZ0FhmI0-YbeF79Wm; Tue, 15 Apr 2025 19:11:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744733478;
 bh=W4t6gNlCoa+T9JdU1ymQ1zdJCB8pVX1/swIJJZ4aCdg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0DRLr/S+ix5CeCknaaR1Po5L9b4Q1OO/sMWbO5tde7PMn9ebCPDNOooI8EJvikQPX
 Ln+3ra8Wvt76ugItLJL6vGhMgtRwLZFMupRA/jnSFjtpwmDLiFYeTi/suEwIcOtjuf
 l3/vXq9fPdr5WAg5DbEqOVjq18R9Dsa1lXGnXe4Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7e6b2cfc-b2b9-46de-9219-9c1a15a3c5be@yandex-team.ru>
Date: Tue, 15 Apr 2025 19:11:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] file-posix: Allow lseek at offset 0 when !want_zero
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:raw" <qemu-block@nongnu.org>,
 "Denis V. Lunev" <den@openvz.org>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-10-eblake@redhat.com>
 <2d17f631-40b0-40bc-a4ba-0b507cd39c71@yandex-team.ru>
 <6dn2vursoidmgeba4jtdrpy76b4o6ktkvh6l22bykm7cllmahw@hchia4nkjv2s>
 <7628c28f-8d6c-4f0b-af28-2cde86a2a8c7@yandex-team.ru>
 <gysmpcvn54bbcir6dytw3243j4zf5v7phlw3zfncqept6qqwua@meptpfpqkkq7>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <gysmpcvn54bbcir6dytw3243j4zf5v7phlw3zfncqept6qqwua@meptpfpqkkq7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 15.04.25 18:22, Eric Blake wrote:
> On Tue, Apr 15, 2025 at 03:37:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 14.04.25 21:12, Eric Blake wrote:
>>> On Mon, Apr 14, 2025 at 08:05:21PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 11.04.25 04:04, Eric Blake wrote:
>>>>> The 'want_zero' parameter to raw_co_block_status() was added so that
>>>>> we can avoid potentially time-consuming lseek(SEEK_DATA) calls
>>>>> throughout the file (working around poor filesystems that have O(n)
>>>>> rather than O(1) extent probing).  But when it comes to learning if a
>>>>> file is completely sparse (for example, it was just created), always
>>>>> claiming that a file is all data without even checking offset 0 breaks
>>>>> what would otherwise be attempts at useful optimizations for a
>>>>> known-zero mirror destination.
>>>>>
>>>>> Note that this allows file-posix to report a file as completely zero
>>>>> if it was externally created (such as via 'truncate --size=$n file')
>>>>> as entirely sparse; however, it does NOT work for files created
>>>>> internally by blockdev-create.  That's because blockdev-create
>>>>> intentionally does a sequence of truncate(0), truncate(size),
>>>>> allocate_first_block(), in order to make it possible for gluster on
>>>>> XFS to probe the sector size for direct I/O (which doesn't work if the
>>>>> first block is sparse).  That will be addressed in a later patch.
>>>>>
>>>>> Signed-off-by: Eric Blake<eblake@redhat.com>
>>>>> ---
>>>>>     block/file-posix.c | 9 ++++++++-
>>>>>     1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>>> index 56d1972d156..67e83528cf5 100644
>>>>> --- a/block/file-posix.c
>>>>> +++ b/block/file-posix.c
>>>>> @@ -3217,7 +3217,14 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
>>>>>             return ret;
>>>>>         }
>>>>>
>>>>> -    if (!want_zero) {
>>>>> +    /*
>>>>> +     * If want_zero is clear, then the caller wants speed over
>>>>> +     * accuracy, and the only place where SEEK_DATA should be
>>>>> +     * attempted is at the start of the file to learn if the file has
>>>>> +     * any data at all (anywhere else, just blindly claim the entire
>>>>> +     * file is data).
>>>>> +     */
>>>>> +    if (!want_zero && offset) {
>>>>>             *pnum = bytes;
>>>>>             *map = offset;
>>>>>             *file = bs;
>>>> Looks like a hack. So we have bdrv_co_is_zero_fast() which do pass want_zero=false to block-status. But in case of mirror, which want to check the whole disk, we actually want want_zero=true, and detect it by offset=0..
>>>>
>>>> Isn't it better to add a kind of bdrv_is_zero_middle_speed() (which means, don't try to read the data to check, but be free to use suboptimal lseek call or something like this), which will pass want_zero=true, and use it from mirror? Mirror case differs from usage in qcow2 exactly by the fact that we call it only once.
>>> Which is exactly why I wrote patch 4/6 turning the want_zero bool into
>>> an enum so that we are being more explicit in WHY block status is
>>> being requested.
>>
>> Hmm, and this makes more strange that this hack for file-posix is kept after it. Don't we have other block drivers, where we should behave similarly in block_status for offset=0? Or I mean, could we just use different block-status modes in qcow2 and mirror, when call bdrv_co_is_zero_fast(), and don't handle offset==0 specially in file-posix?
> 
> I'll need to ajust this in v2 of my series.
> 
> The problem I'm trying to resolve: libvirt migration with
> --migrate-disks-detect-zeroes is causing the destination to become
> fully allocated if the destination does not use "discard":"unmap",
> whereas with QEMU 9.0 it did not.  The change was commit d05ae948c,
> where we fixed a problem with punching holes into the mirror
> destination even when the user had requested the file to not shrink;
> but it means that a file that is not allowed to shrink is now fully
> allocated rather than left sparse even when leaving it sparse would
> still be an accurate mirror result with less I/O.
> 
> And it turns out that when libvirt is driving the mirror into a raw
> destination, the mirroring is done over NBD, rather than directly to a
> file-posix destination.  Coupled with the oddity that 'qemu-img create
> -f raw' ends up pre-allocating up to 64k of the image with all zero
> contents to make alignment probing easier, it is no longer possible to
> quickly see that the entire NBD image reads as zero, just as it was
> not possible to quickly see that for file-posix.  So, in v2 of my
> patch series, I think I need to hoist the logic that I added to
> file-posix.c that reads an initial small sector in order to determine
> if the entire image is zero to instead live in io.c to be used across
> all protocols, NBD included.
> 
> So if you don't think offset=0 should be given any special treatment
> in file-posix, but instead have generic code in io.c that checks if an
> entire image has block_status of sparse and/or just a small initial
> non-sparse section that can be manually checked for zero contents,
> then that should still fix the issue of mirroring to a sparse
> destination with "discard":"ignore" but keeping the destination
> sparse.
> 

Thanks for explanation! Yes I think making such specific checks about first sector in some kind of generic bdrv_is_all_zeroes() would be cleaner.

-- 
Best regards,
Vladimir


