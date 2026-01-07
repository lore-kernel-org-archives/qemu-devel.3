Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B462CD5829
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 10:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQRw-0007UB-Jh; Wed, 07 Jan 2026 05:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vdQRq-0007Qc-Tl; Wed, 07 Jan 2026 05:07:27 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vdQRo-0001X0-UI; Wed, 07 Jan 2026 05:07:26 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4F6B3454BA;
 Wed, 07 Jan 2026 11:07:14 +0100 (CET)
Message-ID: <ea269fae-4069-4cb1-a0da-c4fab4ad4ed8@proxmox.com>
Date: Wed, 7 Jan 2026 11:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/io: fallback to bounce buffer if BLKZEROOUT is not
 supported because of alignment
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, kwolf@redhat.com, fam@euphon.net
References: <20260105143416.737482-1-f.ebner@proxmox.com>
 <20260105191049.GB59391@fedora>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260105191049.GB59391@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1767780396538
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Am 06.01.26 um 3:23 PM schrieb Stefan Hajnoczi:
> On Mon, Jan 05, 2026 at 03:29:55PM +0100, Fiona Ebner wrote:
>> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
>> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
>> certain 'qemu-img convert' invocations, because of a pre-existing
>> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
>> the request is shorter than the block size of the block device.
>> Fallback to the bounce buffer, similar to when the ioctl is not
>> supported at all, rather than treating such an error as fatal.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3257
>> Resolves: https://bugzilla.proxmox.com/show_bug.cgi?id=7197
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> ---
>>  block/io.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index cace297f22..e37d9d2417 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1917,7 +1917,8 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>              assert(!bs->supported_zero_flags);
>>          }
>>  
>> -        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
>> +        if ((ret == -ENOTSUP || (ret == -EINVAL && num < alignment)) &&
>> +            !(flags & BDRV_REQ_NO_FALLBACK)) {
>>              /* Fall back to bounce buffer if write zeroes is unsupported */
>>              BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
> 
> This patch invokes the ioctl(BLKZERO) first and then falls back to a
> write request. In the bug report this only occurs at the end of qemu-img
> convert, so the performance overhead of failing the ioctl first and then
> submitting a write doesn't matter.

In my testing, it does not only happen at the end of the image, but
after the 2 GiB mark for larger zero images. Initially,
convert_iteration_sectors() returns 4096, but at the 2 GiB mark
s->sector_next_status - sector_num is 4095, so it will take precedence
in the assignment
n = MIN(n, s->sector_next_status - sector_num);
in convert_iteration_sectors(). After that, convert_iteration_sectors()
will return 4096 again, but short zero writes happen from there on,
because of that one time throwing off the alignment. (Similarly, around
other multiples of 2 GiB, there will be one time where 4095 is returned
in between).

> I would prefer taking advantage of the existing alignment code in
> bdrv_co_do_zero_pwritev() instead of falling back like this. The
> alignment code currently has no effect because
> BlockLimits->request_alignment = 1 for cache=writeback. It is unaware
> that ioctl(BLKZERO) requires block alignment. Once that is fixed,
> bdrv_co_do_zero_pwritev() will submit a regular write request for the
> misaligned tail.
> 
> Block drivers with specific alignment requirements for write zeroes
> report them in BlockLimits->pwrite_zeroes_alignment. I think
> bdrv_co_do_zero_pwritev() should prioritize
> bs->bl.pwrite_zeroes_alignment over bs->bl.request_alignment.
> file-posix.c already populates pwrite_zeroes_alignment - it's just not
> used by bdrv_co_do_zero_pwritev() yet.
> 
> Do you want to give that a try?

Yes, I'll try. This approach sounds cleaner :)

Best Regards,
Fiona


