Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223DECCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v63gU-0004ct-Je; Tue, 07 Oct 2025 05:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v63gS-0004cQ-3U; Tue, 07 Oct 2025 05:08:36 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v63gQ-0007H8-11; Tue, 07 Oct 2025 05:08:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id DB86280D69;
 Tue, 07 Oct 2025 12:08:28 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:152::1:3c] (unknown
 [2a02:6bf:8080:152::1:3c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S8hWqD0FYSw0-wpeAslgk; Tue, 07 Oct 2025 12:08:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1759828108;
 bh=FEBXng8FrkMfOasNEV61mWYTgZ/extlFznz4IUkPZxc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OhoymXEL6KbccwYjUD+Y/X1iL6wD04ICInlKs7lYziUH99h8bsXF16zs0ZQ9lb1Zy
 J2TGT4cqyLlxc40M5cT5C+ZTsp6kTCKf586WFz6h5ji+qEmzSzlWIpDbSKBN+151As
 quO6MIhXHnsbbWxmBuNR0xAZqsPiFbYbC3cFEj2o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <187de322-4862-4299-82c2-69918a0f9148@yandex-team.ru>
Date: Tue, 7 Oct 2025 12:08:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] file-posix: populate pwrite_zeroes_alignment
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>,
 Hanna Reitz <hreitz@redhat.com>
References: <20251002184000.410486-1-stefanha@redhat.com>
 <20251002184000.410486-2-stefanha@redhat.com>
 <dd50f99b-03d3-44ca-9f79-dde3dff1c3d4@yandex-team.ru>
 <20251006145710.GB21887@fedora>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251006145710.GB21887@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 06.10.25 17:57, Stefan Hajnoczi wrote:
> On Fri, Oct 03, 2025 at 10:55:09AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 02.10.25 21:39, Stefan Hajnoczi wrote:
>>> Linux block devices require write zeroes alignment whereas files do not.
>>>
>>> It may come as a surprise that block devices opened in buffered I/O mode
>>> require the alignment although regular read/write requests do not.
>>>
>>> Therefore it is necessary to populate the pwrite_zeroes_alignment field.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>    block/file-posix.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index 8c738674ce..05c92c824d 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -1602,6 +1602,23 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>>>                bs->bl.pdiscard_alignment = dalign;
>>>            }
>>> +
>>> +#ifdef __linux__
>>> +        /*
>>> +         * When request_alignment > 1, pwrite_zeroes_alignment does not need to
>>> +         * be set explicitly. When request_alignment == 1, it must be set
>>> +         * explicitly because Linux requires logical block size alignment.
>>> +         */
>>> +        if (bs->bl.request_alignment == 1) {
>>> +            ret = probe_logical_blocksize(s->fd,
>>> +                                          &bs->bl.pwrite_zeroes_alignment);
>>> +            if (ret < 0) {
>>> +                error_setg_errno(errp, -ret,
>>> +                                 "Failed to probe logical block size");
>>
>> Isn't it too restrictive? Could we consider failed attempt to probe as permission
>> to proceed without write-zeroes alignment? In raw_probe_alignment, we fallback
>> to guessing request_alignment from memalign.
> 
> The logical block size alignment is required for write zeroes, otherwise
> write zeroes will fail with EINVAL (not ENOTSUP).
> 
> There is no way to probe in the !needs_alignment case since read
> requests don't require alignment and write zeroes would be destructive.

Theoretically, if we also implement some kind of automation for unaligned tails
(like for read/write request_alignment), to support "required write-zeroes alignment",
we could postpone probing up to the first write-zeroes operation.. But seems, that
would be too much work (and complex logic to support in future) for nothing.

> 
> I think it's preferrable to fail here. This should never happen on a
> Linux kernel because BLKSSZGET has been there since the initial git
> import in 2005.
> 

Agreed.

>>
>>> +                return;
>>> +            }
>>> +        }
>>> +#endif /* __linux__ */
>>>        }
>>>        raw_refresh_zoned_limits(bs, &st, errp);
>>
>>
>> -- 
>> Best regards,
>> Vladimir
>>


-- 
Best regards,
Vladimir

