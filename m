Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40643D30CDB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 01:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfpjj-0006NJ-Iv; Tue, 13 Jan 2026 20:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1vfpjh-0006Li-0b
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 20:31:49 -0500
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1vfpjd-0006Yc-56
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 20:31:48 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=LWwuJNWrTdDe/+2k18n2vYK7cyHOr7i/7KqgucGg3hs=;
 b=ocbB0GMl2tisDmFm2p9FvxhF6Frnd4WvPzMCU1Cqs/HyEZ3UROooZJl96cfSfug6tqaZhanrk
 IUoL3TRs3EwPRuhhQBk3ZODI+F9wVzu+2V+RHmP84CrgbmdJRFWeF9ppuvYKBSmWxsDjfEuBwYo
 DjZH2KEJ+JCwA8SPstVQqh4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4drT4p5M4xz1T4LZ;
 Wed, 14 Jan 2026 09:27:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 27E81201E9;
 Wed, 14 Jan 2026 09:31:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Jan 2026 09:31:30 +0800
Message-ID: <5a7700f5-750d-e491-9c45-b7e261a4983d@huawei.com>
Date: Wed, 14 Jan 2026 09:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20260106062145.151760-1-ruanjinjie@huawei.com>
 <CAFEAcA-gztPHR=Pe743n-tCYuBK4KuXx5JsEdR4vqL33Kb50kg@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAFEAcA-gztPHR=Pe743n-tCYuBK4KuXx5JsEdR4vqL33Kb50kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
Received-SPF: pass client-ip=113.46.200.216;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout01.his.huawei.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.379,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/1/13 22:22, Peter Maydell wrote:
> On Tue, 6 Jan 2026 at 06:22, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
>> "NANOSECONDS_PER_SECOND" may overflow the uint64_t type.
>>
>> Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
>> because get_guest_rtc_ns() is used either take the remainder of
>> NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.
>>
>> Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  hw/rtc/mc146818rtc.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>> index 8631386b9f..78bdfab8bd 100644
>> --- a/hw/rtc/mc146818rtc.c
>> +++ b/hw/rtc/mc146818rtc.c
>> @@ -79,10 +79,7 @@ static inline bool rtc_running(MC146818RtcState *s)
>>
>>  static uint64_t get_guest_rtc_ns(MC146818RtcState *s)
>>  {
>> -    uint64_t guest_clock = qemu_clock_get_ns(rtc_clock);
>> -
>> -    return s->base_rtc * NANOSECONDS_PER_SECOND +
>> -        guest_clock - s->last_update + s->offset;
>> +    return qemu_clock_get_ns(rtc_clock) - s->last_update + s->offset;
>>  }
> 
> This is all logically correct and avoids the overflow, but I
> do wonder if this is setting us up for future bugs, because
> now the function get_guest_rtc_ns() doesn't actually return
> you the guest RTC value in nanoseconds...
> 
> I think at minimum it would be useful to have a comment noting
> that this doesn't include the base_rtc seconds value and the
> caller needs to handle that themselves.

Thank you for the review.

> 
> (Maybe there's a neater function/set of functions that would
> abstract things more obviously, but I can't think of one
> right now.)
> 
> thanks
> -- PMM

