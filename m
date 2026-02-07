Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32292EE0AC6
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 10:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vofTy-0001tk-0h; Sat, 07 Feb 2026 05:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vofTw-0001tK-6N; Sat, 07 Feb 2026 05:24:04 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vofTt-0000Ql-4Z; Sat, 07 Feb 2026 05:24:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 47C6BC01E0;
 Sat, 07 Feb 2026 13:23:55 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:1d::1:1d] (unknown [2a02:6bf:8080:1d::1:1d])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ONMmEB1BsOs0-V8K5KqsJ; Sat, 07 Feb 2026 13:23:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770459835;
 bh=X+nd4xjs40Srn2mE60xLtdmbiHS98KLk4LnP2ChDVGs=;
 h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
 b=TFBYDWWw33ULcbcKam3ba4dAg14lNZWsMIIbhc2CnpfF05LCMxUH/B2cfIp0fS6dF
 BoVfVqY9KP+IMnm1t1qK41joJEqPx8hfsfSgApelHHXnTljpwfLIVaxRQvk+2+kbP7
 2xmR8ongP64HJc5NVT6riKcxeAiVOoay7sErAbdA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <14605571-e078-4d93-9f0b-411889a70076@yandex-team.com>
Date: Sat, 7 Feb 2026 15:23:24 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergei Heifetz <heifetz@yandex-team.com>
Subject: Re: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-4-heifetz@yandex-team.com>
 <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
Content-Language: en-US
In-Reply-To: <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 17:53, Laurent Vivier wrote:
> Le 04/02/2026 à 08:57, Sergei Heifetz a écrit :
>> Reorder the code so the assertion of block occurs before it is
>> used in the subsequent lines.
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>   system/physmem.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index b0311f4531..4308e02940 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2054,11 +2054,11 @@ static int memory_try_enable_merging(void 
>> *addr, size_t len)
>>    */
>>   int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>>   {
>> +    assert(block);
>> +
>>       const ram_addr_t oldsize = block->used_length;
>>       const ram_addr_t unaligned_size = newsize;
>>   -    assert(block);
>> -
>
> According to coding style (docs/devel/style.rst):
>
> Mixed declarations (interleaving statements and declarations within
> blocks) are generally not allowed.
>
>>       newsize = TARGET_PAGE_ALIGN(newsize);
>>       newsize = REAL_HOST_PAGE_ALIGN(newsize);
>
> Thanks,
> Laurent

Should I remove the assertion altogether, then? I think the const 
qualifier on oldsize is more useful than the assertion.


