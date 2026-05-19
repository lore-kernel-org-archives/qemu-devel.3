Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FB1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKsS-0006qa-CL; Tue, 19 May 2026 09:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wPKsQ-0006pm-LB; Tue, 19 May 2026 09:52:54 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wPKsO-0004ER-KP; Tue, 19 May 2026 09:52:54 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9DDDA42DBF;
 Tue, 19 May 2026 15:52:42 +0200 (CEST)
Message-ID: <5bb78ad4-51ca-4d10-82fe-561309dfab95@proxmox.com>
Date: Tue, 19 May 2026 15:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: replace assert with proper error handling
To: =?UTF-8?B?0JDRgNGC0LXQvCDQndCw0YHQvtC90L7Qsg==?=
 <anasonov@astralinux.ru>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com,
 sdl.qemu@linuxtesting.org
References: <20250116111600.2570490-1-anasonov@astralinux.ru>
 <CAFEAcA_S1COmR=_t8Q7mXoEoAwYSbxUNRSvZmp35LiH9JSbtPg@mail.gmail.com>
 <90110e6f-55ec-4006-aa3a-22137dab631d@astralinux.ru>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <90110e6f-55ec-4006-aa3a-22137dab631d@astralinux.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779198747645
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

Dear Maintainers,

Am 16.01.25 um 1:30 PM schrieb Артем Насонов:
> 16/01/25 14:32, Peter Maydell пишет:
>> On Thu, 16 Jan 2025 at 11:17, Artem Nasonov <anasonov@astralinux.ru>
>> wrote:
>>> This assert was found during fuzzing and can be triggered with some
>>> qtest commands.
>>> So instead of assert failure I suggest to handle this error and abort
>>> the command.
>>> This patch is required at least to improve fuzzing process and do not
>>> spam with this assert.
>>> RFC.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with libFuzzer.
>>>
>>> Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in
>>> ide_dma_cb()")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2777
>>> Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
>>> ---
>>>   hw/ide/core.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index f9baba59e9..baca7121ec 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -931,7 +931,10 @@ static void ide_dma_cb(void *opaque, int ret)
>>>       s->io_buffer_size = n * 512;
>>>       prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s-
>>> >io_buffer_size);
>>>       /* prepare_buf() must succeed and respect the limit */
>>> -    assert(prep_size >= 0 && prep_size <= n * 512);
>>> +    if (prep_size < 0 || prep_size > n * 512) {
>>> +        ide_dma_error(s);
>>> +        return;
>>> +    }
>> Now the comment and the code disagree (the comment
>> says that the callback must never do the thing that we
>> now have code to handle).
>>
>> What's the actual situation when the prepare_buf callback hits
>> this assertion? Is the problem in this code, or is it in the
>> callback implementation? Which IDEDMAOps is involved?
>>
>> thanks
>> -- PMM
> 
> Steps to reproduse are described in related issue:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/2777 In this case,
> function ahci_dma_prepare_buf() from hw/ide/ahci.c stands for s->bus-
>>dma->ops->prepare_buf. It is called and returns -1. This is because of
> call to ahci_populate_sglist() function, which returns -1 due to check
> if (!prdtl), where prdtl is one of the fields of AHCIDevice cmd header.
> So we have a situation: prepare_buf() must succeed, but returns -1 for
> some reason and application fails (which is harmful for fuzzing too). We
> may solve it in two ways: patch callback or patch caller. I don't see
> any possible way to handle error of populating sglist inside
> ahci_dma_prepare_buf() function: it fails to prepare buf, but has to
> return something. Since then, we should catch this error and interrupt
> operation or maybe other action. Thanks, Artem

I'd like to ping this patch, since we got a report from a user hitting
this issue in production now [0].

I suppose we could keep the assert for the latter half, since not
respecting the limit would be an implementation error inside QEMU AFAIU.

[0]:
https://forum.proxmox.com/threads/opt-in-linux-7-0-kernel-for-proxmox-ve-9-available-on-test-and-no-subscription.182328/post-851185

Best Regards,
Fiona


