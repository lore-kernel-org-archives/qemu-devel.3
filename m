Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6318FEE0219
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 08:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJ3H-0007mq-6q; Wed, 11 Sep 2024 04:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1soJ3E-0007jb-Dy; Wed, 11 Sep 2024 04:50:12 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1soJ3B-0001SK-9H; Wed, 11 Sep 2024 04:50:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 25CABC000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726044604;
 bh=xeg32jJTXFc1Tee+Qagg1QF69CLyznNP0E20+PK6lDs=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
 b=GeTsR5J/EvzuGn5ohQ3AYWAUXfahoOBVJ4V7mpELndayBVO1+fB+J+iF/qhVUjvll
 d6t63BpjqM04C0yE/RehH9OGLaN8xCGU8w6gniPvIyfJ0bMO4txNw98YHnPkdoZv+L
 ymM0DCch8IuB37Ei5XvBoOkEqKSNVxv6SNj+CTRWO41cA4Ob9JB9Q6ZQUX9bKCkV/c
 KQW/FVpuvM8wBInn4l47c+ov+94Jb28GHWMR9nX9xS14qDYqusXaqSVEpE+U97QK89
 pRwTl8p/Q8Xt8iZdEXhO5jPv6qqIokv23LJY6QD04yLy39cjiImO/7E+7CdZ/kTF/v
 bKmsWSlrMRc7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726044604;
 bh=xeg32jJTXFc1Tee+Qagg1QF69CLyznNP0E20+PK6lDs=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
 b=X0rzESeHcmk6JWoYrt7rT3DtTzUkCR9nmDWJhxEy8EcsSLgsjQGFSLuH6XDE/IMof
 B4qN8C6pMejfekfuCZQUHJQldka9ugiPog+xKTVBnb4i1RL1uJ3zXnKyZ9KLHGgpaD
 GATSpF9l7Nn4kzYCw7wntkUlRdELifJ3ew28v+4JIG6/nynESdhOt20qpCgr1okTA9
 15RX3MTDxaGroQjk8xtYe2pKWQjoo8s2/Te5H5B/0a6Y6M995gEeRomPM6aPzxkxK0
 dwyFV3pNEHRs4pPT90th26jbJgbTaUnsO3bnyBqtQ9W833lFYBIya/X4ip26lGHeqI
 liVi44lSttO7Q==
Message-ID: <f968f7db-2b2c-4cb7-ac1c-504121745ab7@syntacore.com>
Date: Wed, 11 Sep 2024 11:50:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Aleksei Filippov <alexei.filippov@syntacore.com>
Subject: Re: [PATCH v2] target/riscv: Add support for machine specific pmu's
 events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, <palmer@dabbelt.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <liwei1518@gmail.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
References: <20240625144643.34733-1-alexei.filippov@syntacore.com>
 <2cb94b34-1a5f-4dc9-bec4-78c7008cd79d@linaro.org>
 <a019a09d-9549-4fa9-8b30-befb4df96fc0@syntacore.com>
 <b94c987e-835a-490f-a4d4-72f87db7f7b1@linaro.org>
Content-Language: en-US
Organization: Syntacore
In-Reply-To: <b94c987e-835a-490f-a4d4-72f87db7f7b1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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



On 08.07.2024 16:42, Philippe Mathieu-Daudé wrote:
> Hi Aleksei,
> 
> On 8/7/24 11:46, Aleksei Filippov wrote:
>> On 25.06.2024 21:18, Richard Henderson wrote:
>>> On 6/25/24 07:46, Alexei Filippov wrote:
>>>> Was added call backs for machine specific pmu events.
>>>> Simplify monitor functions by adding new hash table, which going to map
>>>> counter number and event index.
>>>> Was added read/write callbacks which going to simplify support for events,
>>>> which expected to have different behavior.
>>>>
>>>> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
>>>> ---
>>>> Changes since v2:
>>>>         -rebased to latest master
>>>>   target/riscv/cpu.h |   9 +++
>>>>   target/riscv/csr.c |  43 +++++++++-----
>>>>   target/riscv/pmu.c | 139 ++++++++++++++++++++++-----------------------
>>>>   target/riscv/pmu.h |  11 ++--
>>>>   4 files changed, 115 insertions(+), 87 deletions(-)
>>>>
>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>> index 6fe0d712b4..fbf82b050b 100644
>>>> --- a/target/riscv/cpu.h
>>>> +++ b/target/riscv/cpu.h
>>>> @@ -374,6 +374,13 @@ struct CPUArchState {
>>>>       uint64_t (*rdtime_fn)(void *);
>>>>       void *rdtime_fn_arg;
>>>> +    /*machine specific pmu callback */
>>>> +    void (*pmu_ctr_write)(PMUCTRState *counter, uint32_t event_idx,
>>>> +                          target_ulong val, bool high_half);
>>>> +    target_ulong (*pmu_ctr_read)(PMUCTRState *counter, uint32_t event_idx,
>>>> +                                 bool high_half);
>>>> +    bool (*pmu_vendor_support)(uint32_t event_idx);
>>>
>>> Do these really belong in CPUArchState, rather than RISCVCPUClass?
>>>
>>> Surely there's more to this series, since these fields are never set...
>>>
>>>
>>> r~
>>
>> Initially this callbacks was added to CPUArchState just to be along with 
>> similar implementation with rdtime_fn*.
>>
>> Yes, you're right, there are more series to this, but, it can't be separated 
>> from syntacore specific parts, which is unfortunately not ready yet to be 
>> published. So, I can prepare second patch to implement PMU subsystem for virt 
>> device. What do you think about it? (I'll send it in the few days).
> 
> How can we test your patch meanwhile?
Sorry for such late response, but anyway, I created an RFC with PoC and 
description on how I tested this and resend patch with PoC all together. 
https://lore.kernel.org/all/20240910174747.148141-1-alexei.filippov@syntacore.com/

> 
> Thanks,
> 
> Phil.
> 

-- 
Sincerely,
Aleksei Filippov

