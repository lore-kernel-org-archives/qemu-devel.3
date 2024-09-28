Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830A3CF6495
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 10:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suUzt-0003YK-GW; Sat, 28 Sep 2024 06:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1suUzr-0003XG-VK
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 06:48:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1suUzp-00015m-E7
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 06:48:19 -0400
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XG3rm0pPQzfc3m;
 Sat, 28 Sep 2024 18:45:28 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
 by mail.maildlp.com (Postfix) with ESMTPS id AB291140392;
 Sat, 28 Sep 2024 18:47:46 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 28 Sep 2024 18:47:45 +0800
Subject: Re: RTC time could run slow 3s than host time when clock=vm & base=UTC
To: =?UTF-8?B?6LS+5bqG5b2k?= <jiaqingtong@huawei.com>
References: <eba4b2cf-cf64-4237-aaf6-8aa521c77007@huawei.com>
CC: <qemu-devel@nongnu.org>, <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <artem.k.pisarenko@gmail.com>
Message-ID: <081379a0-a34f-49ae-e8f3-8fd497fea97a@huawei.com>
Date: Sat, 28 Sep 2024 18:47:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <eba4b2cf-cf64-4237-aaf6-8aa521c77007@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.219]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
Received-SPF: pass client-ip=45.249.212.188; envelope-from=yuzenghui@huawei.com;
 helo=szxga02-in.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.165,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Zenghui Yu <yuzenghui@huawei.com>
From:  Zenghui Yu via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+Cc maintainers and author of [1]

On 2024/9/21 19:33, 贾庆彤 via wrote:
> When start qemu with -rtc base=utc,clock=vm, sometime guest time can
> slower 3s than host.
> 
> There's no problem (also didn't be noticed) as we often start ntp
> service, who will adjust our system time.
> 
> But let's talk about if we havn't enable NTP service(for example system
> just booted)
> 
> After inspect into the code, i found that there are two problem we
> should think about:
> 
> 1） The RTC time accuracy problem
> 
> 1. in the call chains
> rtc_realizefn->rtc_set_date_from_host->qemu_get_timedate->qemu_ref_timedate,
> 
> 
> the qemu_clock_get_ms(clock) / 1000 will lost ~0.999s at max.
> 
> 2. In the call chains cmos_ioport_read->rtc_update_time, the guest_sec =
> guest_nsec / NANOSECONDS_PER_SECOND
> 
> will also lost ~0.999s at max.
> 
> 3. after this[1] merged, in configure_rtc, the rtc_ref_start_datetime =
> qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000
> 
> will also lost ~0.999s at max.
> 
> Therefore, total about 3s the guest time will behind the host.
> 
> So what precision should we offer? the RTC Hardware's precision is
> second(that means the smallest step is 1 second,
> 
> not the accurate like time error about 8.6 to 1.7 seconds per day),
> 
> 
> 2）The ref start datetime
> 
> After this[1] merged, which intend to solve the -rtc
> base=DATETIME,clock=vm's problem ("It restores determinism
> 
> of guest execution when used with clock=vm and specified base value.").
> 
> "-rtc base=utc,clock=vm"'s ref start date time changed from the host
> time of the current executing code to
> 
> the const time of executing configure_rtc(rtc_ref_start_datetime =
> qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;).
> 
> This will add additional time(current approx. 0.4s or other, depend on
> code executing time and how many class_init
> 
>  executed etc.),which start from configure_rtc to rtc device init, into
> guest time.
> 
> Hence, should we try to split -rtc base=utc,clock=vm's ref start date
> time to the original current host time
> 
> qemu_clock_get_ms(QEMU_CLOCK_HOST),not the time(rtc_ref_start_datetime)
> save in configure_rtc,
> 
> to achieve more accurate time?(or other better method)
> 
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03577.html
> 
> 
> .

