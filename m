Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FCECD37B6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 03:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMH2S-0002S4-Gk; Sun, 10 May 2026 23:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1wMH2Q-0002Ro-6O
 for qemu-devel@nongnu.org; Sun, 10 May 2026 23:10:34 -0400
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1wMH2M-0004fq-6p
 for qemu-devel@nongnu.org; Sun, 10 May 2026 23:10:33 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qHtvfc5pL3Eg2CqVd8S5idmvaRQxqe8dNaktKqdMN1Y=;
 b=WV9XBkKdGnCYxJGMx6IfWVPrhjaS8XKMZZINyqU0ukFcP4DOxdXP69vnmL7TcfLHGuz95wHbj
 MaqsUk1n95MUDd3YsvUXGYmsL9inySLqYe4FsepwYjcJLrHKFk9y2L6fRWDrNID9dUt37xS51fd
 tgtdt0YQfPYDsxAbE39+keE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gDPfQ1fJYz1K96y;
 Mon, 11 May 2026 11:02:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 9157B40562;
 Mon, 11 May 2026 11:10:12 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 May 2026 11:10:12 +0800
Message-ID: <737e7981-f7cb-4578-93bd-5c69cfdc51b9@huawei.com>
Date: Mon, 11 May 2026 11:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
To: Peter Maydell <peter.maydell@linaro.org>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20260114013257.3500578-1-ruanjinjie@huawei.com>
 <8a9bb7a8-a45b-ecb1-4a16-b48bb6b9f856@huawei.com>
 <62ee8716-5aff-4164-b1d7-dee89f955822@huawei.com>
 <CAFEAcA9FNqHTWrBd-eakJ0OvVRsTaCBsF-a1uCFt4vVcovBPzg@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAFEAcA9FNqHTWrBd-eakJ0OvVRsTaCBsF-a1uCFt4vVcovBPzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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



On 4/30/2026 8:53 PM, Peter Maydell wrote:
> On Wed, 22 Apr 2026 at 04:08, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>
>>
>> On 3/18/2026 3:03 PM, Jinjie Ruan wrote:
>>> Gentle ping.
>>>
>>> On 2026/1/14 9:32, Jinjie Ruan wrote:
>>>> In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
>>>> "NANOSECONDS_PER_SECOND" may overflow the uint64_t type, which will
>>>> cause the QEMU Linux Virtual Machine's RTC time to jump and in turn
>>>> triggers a kernel Soft Lockup and ultimately leads to a crash.
>>>>
>>>> Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
>>>> because get_guest_rtc_ns() is used either take the remainder of
>>>> NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.
>>>>
>>>> Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>> ---
>>>> v2:
>>>> - Add comment for get_guest_rtc_ns().
>>>> - Update the commit message.
>>
>> Hi, peter, do you have any further suggestions for this version, or is
>> it ready to be merged? Thanks!
> 
> As the mc146818's main user is the x86 PC models, this ought
> to be reviewed by one of their maintainers. Paolo ?

That makes sense, as this change primarily impacts x86 platforms. I'll
wait for Paolo's feedback. @Paolo, please let me know if you have any
concerns.

> 
> thanks
> -- PMM
> 


