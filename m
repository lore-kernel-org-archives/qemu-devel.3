Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233C9D18130
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0OEr-0000ov-LV; Mon, 14 Oct 2024 12:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t0OEq-0000ok-TA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:48:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t0OEp-0002Ed-ER
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:48:08 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5BAF24E6004;
 Mon, 14 Oct 2024 18:48:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id NdRxcMNSsGUR; Mon, 14 Oct 2024 18:48:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 698304E600F; Mon, 14 Oct 2024 18:48:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 684C8746F60;
 Mon, 14 Oct 2024 18:48:02 +0200 (CEST)
Date: Mon, 14 Oct 2024 18:48:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH 1/2] log: Add separate debug option for logging invalid
 memory accesses
In-Reply-To: <CAFEAcA9sbAdDufXC1kVfHHcEg=DAHgB2dTSi2u4snppGG=KajA@mail.gmail.com>
Message-ID: <df3261a7-6ab9-7e45-e711-b074756abbaa@eik.bme.hu>
References: <cover.1728232526.git.balaton@eik.bme.hu>
 <59dd3361ca8ede93122e87752c7d66a304b05c0f.1728232526.git.balaton@eik.bme.hu>
 <CAFEAcA9sbAdDufXC1kVfHHcEg=DAHgB2dTSi2u4snppGG=KajA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Mon, 14 Oct 2024, Peter Maydell wrote:
> On Sun, 6 Oct 2024 at 17:50, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Currently -d guest_errors enables logging of different invalid actions
>> by the guest such as misusing hardware, accessing missing features or
>> invalid memory areas. The memory access logging can be quite verbose
>> which obscures the other messages enabled by this debug switch so
>> separate it by adding a new -d memaccess option to make it possible to
>> control it independently of other guest error logs.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  include/qemu/log.h | 1 +
>>  system/memory.c    | 6 +++---
>>  system/physmem.c   | 2 +-
>>  util/log.c         | 2 ++
>>  4 files changed, 7 insertions(+), 4 deletions(-)
>
> It seems reasonable to me to separate out "log invalid
> memory accesses", yes.
>
>> diff --git a/util/log.c b/util/log.c
>> index 6219819855..1aa7396277 100644
>> --- a/util/log.c
>> +++ b/util/log.c
>> @@ -503,6 +503,8 @@ const QEMULogItem qemu_log_items[] = {
>>        "open a separate log file per thread; filename must contain '%d'" },
>>      { CPU_LOG_TB_VPU, "vpu",
>>        "include VPU registers in the 'cpu' logging" },
>> +    { LOG_MEM_ACCESS, "memaccess",
>> +      "log invalid memory accesses" },
>>      { 0, NULL, NULL },
>
> As a naming thing, these are logging specifically invalid
> memory accesses, not all accesses, so we should have
> both the user-facing name and the LOG_ constant be
> named appropriately. Perhaps
>  LOG_INV_MEM_ACCESS, "invalid_mem_accesses" ?

That's way too long to type and remember. Maybe invalid_mem could do?

Regards,
BALATON Zoltan

> thanks
> -- PMM
>
>

