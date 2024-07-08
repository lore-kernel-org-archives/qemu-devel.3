Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04302C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 09:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQkxU-00058R-3V; Mon, 08 Jul 2024 05:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sQkxN-000578-Fi; Mon, 08 Jul 2024 05:46:51 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sQkxL-0000qZ-Et; Mon, 08 Jul 2024 05:46:49 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A51D4C0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1720431999;
 bh=h9FBMue+lSJJa4CegpDfm0jQjIxBppdJ+RRVSvcvzH0=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=o80Zvw9J+1Smnj6dV6kFCzKiYu3kWlpZIOBCyfdwSsaYhTq2vUydWS20CGxa59GbN
 R17+CzwsSPcsUccFmJNwmDpHUpUCu+D8+tim7xiXN1jg7e79xAP8HrD3qLaZVU3cG+
 /OHEl0reWsrALSr/8vUXt/EomkPCzs4iUX/qfBUnePZFBT3Z+T18IIkmhPtVQUNS+u
 H1hkgFMdcaB/FRPlZFly3zD6Vl3ZZk8ftuE2mlUZqEW5yuH+IGiUlEF0ss+wezC2Nm
 DiHUSR+uHVCCH0ejYy6HnljrkbslC3kKCiNXi3KdiyVw89YzEuk183NdLBilx//hLn
 YQGy2ueqYkDIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1720431999;
 bh=h9FBMue+lSJJa4CegpDfm0jQjIxBppdJ+RRVSvcvzH0=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=tpKUV/kcFSetdJ1u4yzQQdhPNHFBtm2Wd/7I6aSnXeoqCUKYddTpKp2/cY/FFmBnM
 6vpQXmIiEe+cU3gxseTraoB3PoLRWkF/BfEzWAsvyF0+pHBHIrCBhljxZXgrnoQLHk
 Z/xvvyLSc4muoZqIgSbhRdmydLFcCKipPYhV6nDGqUkpO0OuYQqRj4y6VGEGSLWL73
 qPRuTvNkMZ20cQWQPAGGMqpufEGlyO6Wu1YfXNlkBVHHoCLf8zdgF8uSGXilE6Y9qh
 +rpes/Q8zn5qMoYhDN9njCkaZdryNKqw2EBW+ER6V87UV7XCCw5se8R9rHEU2M42Ic
 muyNp3DmhBwvg==
Message-ID: <a019a09d-9549-4fa9-8b30-befb4df96fc0@syntacore.com>
Date: Mon, 8 Jul 2024 12:46:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Add support for machine specific pmu's
 events
To: Richard Henderson <richard.henderson@linaro.org>, <palmer@dabbelt.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <liwei1518@gmail.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
References: <20240625144643.34733-1-alexei.filippov@syntacore.com>
 <2cb94b34-1a5f-4dc9-bec4-78c7008cd79d@linaro.org>
Content-Language: en-US
From: Aleksei Filippov <alexei.filippov@syntacore.com>
Organization: Syntacore
In-Reply-To: <2cb94b34-1a5f-4dc9-bec4-78c7008cd79d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
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



On 25.06.2024 21:18, Richard Henderson wrote:
> On 6/25/24 07:46, Alexei Filippov wrote:
>> Was added call backs for machine specific pmu events.
>> Simplify monitor functions by adding new hash table, which going to map
>> counter number and event index.
>> Was added read/write callbacks which going to simplify support for events,
>> which expected to have different behavior.
>>
>> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
>> ---
>> Changes since v2:
>>         -rebased to latest master
>>   target/riscv/cpu.h |   9 +++
>>   target/riscv/csr.c |  43 +++++++++-----
>>   target/riscv/pmu.c | 139 ++++++++++++++++++++++-----------------------
>>   target/riscv/pmu.h |  11 ++--
>>   4 files changed, 115 insertions(+), 87 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 6fe0d712b4..fbf82b050b 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -374,6 +374,13 @@ struct CPUArchState {
>>       uint64_t (*rdtime_fn)(void *);
>>       void *rdtime_fn_arg;
>> +    /*machine specific pmu callback */
>> +    void (*pmu_ctr_write)(PMUCTRState *counter, uint32_t event_idx,
>> +                          target_ulong val, bool high_half);
>> +    target_ulong (*pmu_ctr_read)(PMUCTRState *counter, uint32_t event_idx,
>> +                                 bool high_half);
>> +    bool (*pmu_vendor_support)(uint32_t event_idx);
> 
> Do these really belong in CPUArchState, rather than RISCVCPUClass?
> 
> Surely there's more to this series, since these fields are never set...
> 
> 
> r~

Initially this callbacks was added to CPUArchState just to be along with similar 
implementation with rdtime_fn*.

Yes, you're right, there are more series to this, but, it can't be separated 
from syntacore specific parts, which is unfortunately not ready yet to be 
published. So, I can prepare second patch to implement PMU subsystem for virt 
device. What do you think about it? (I'll send it in the few days).

-- 
Sincerely,
Aleksei Filippov

