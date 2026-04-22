Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432C0F94CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFNwj-0005nD-U5; Tue, 21 Apr 2026 23:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1wFNwh-0005mw-7E
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:08:11 -0400
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1wFNwe-0005Wr-B8
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 23:08:10 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=e5T38cmle/cKzcgGdgI7uWHLt+iqlatgW7MoWMv6PlA=;
 b=erZ9pZDm68qpzPByHxT6sgOdg/CqJB9GERVvB5KPR5Q+gyUENSYLr7GP0HLYwx8sfc6ZnqIqM
 WoqS361UZEhL+Pz86ABxvNu0Io3tFZ31+YQmuO1RJbDYW27FeH4ObJb3eV1mp+RuBkxeM5eVLCK
 U7RkHpzuMtSv4LY2YMLTmrI=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4g0kWy1TW8z1K99C;
 Wed, 22 Apr 2026 11:01:34 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 6CB6A4056E;
 Wed, 22 Apr 2026 11:07:54 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Apr 2026 11:07:53 +0800
Message-ID: <62ee8716-5aff-4164-b1d7-dee89f955822@huawei.com>
Date: Wed, 22 Apr 2026 11:07:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <peter.maydell@linaro.org>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20260114013257.3500578-1-ruanjinjie@huawei.com>
 <8a9bb7a8-a45b-ecb1-4a16-b48bb6b9f856@huawei.com>
In-Reply-To: <8a9bb7a8-a45b-ecb1-4a16-b48bb6b9f856@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)
Received-SPF: pass client-ip=113.46.200.225;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout10.his.huawei.com
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



On 3/18/2026 3:03 PM, Jinjie Ruan wrote:
> Gentle ping.
> 
> On 2026/1/14 9:32, Jinjie Ruan wrote:
>> In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
>> "NANOSECONDS_PER_SECOND" may overflow the uint64_t type, which will
>> cause the QEMU Linux Virtual Machine's RTC time to jump and in turn
>> triggers a kernel Soft Lockup and ultimately leads to a crash.
>>
>> Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
>> because get_guest_rtc_ns() is used either take the remainder of
>> NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.
>>
>> Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - Add comment for get_guest_rtc_ns().
>> - Update the commit message.

Hi, peter, do you have any further suggestions for this version, or is
it ready to be merged? Thanks!

>> ---
>>  hw/rtc/mc146818rtc.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
>> index 8631386b9f..36de30649c 100644
>> --- a/hw/rtc/mc146818rtc.c
>> +++ b/hw/rtc/mc146818rtc.c
>> @@ -77,12 +77,13 @@ static inline bool rtc_running(MC146818RtcState *s)
>>              (s->cmos_data[RTC_REG_A] & 0x70) <= 0x20);
>>  }
>>  
>> +/*
>> + * Note: get_guest_rtc_ns() does not include the "base_rtc" seconds value,
>> + * so the caller "must" handle it themselves!!!
>> + */
>>  static uint64_t get_guest_rtc_ns(MC146818RtcState *s)
>>  {
>> -    uint64_t guest_clock = qemu_clock_get_ns(rtc_clock);
>> -
>> -    return s->base_rtc * NANOSECONDS_PER_SECOND +
>> -        guest_clock - s->last_update + s->offset;
>> +    return qemu_clock_get_ns(rtc_clock) - s->last_update + s->offset;
>>  }
>>  
>>  static void rtc_coalesced_timer_update(MC146818RtcState *s)
>> @@ -623,10 +624,8 @@ static void rtc_update_time(MC146818RtcState *s)
>>  {
>>      struct tm ret;
>>      time_t guest_sec;
>> -    int64_t guest_nsec;
>>  
>> -    guest_nsec = get_guest_rtc_ns(s);
>> -    guest_sec = guest_nsec / NANOSECONDS_PER_SECOND;
>> +    guest_sec = s->base_rtc + get_guest_rtc_ns(s) / NANOSECONDS_PER_SECOND;
>>      gmtime_r(&guest_sec, &ret);
>>  
>>      /* Is SET flag of Register B disabled? */
>> @@ -637,7 +636,7 @@ static void rtc_update_time(MC146818RtcState *s)
>>  
>>  static int update_in_progress(MC146818RtcState *s)
>>  {
>> -    int64_t guest_nsec;
>> +    uint64_t guest_nsec;
>>  
>>      if (!rtc_running(s)) {
>>          return 0;


