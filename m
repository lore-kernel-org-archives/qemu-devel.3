Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B9BCF9C5B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 13:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srzun-0007dI-Tu; Sat, 21 Sep 2024 09:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaqingtong@huawei.com>)
 id 1sryN9-0001s7-51
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 07:33:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaqingtong@huawei.com>)
 id 1sryN5-0003zf-Ed
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 07:33:54 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X9nFT15zzz1ym08
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 19:33:33 +0800 (CST)
Received: from kwepemj100001.china.huawei.com (unknown [7.202.195.246])
 by mail.maildlp.com (Postfix) with ESMTPS id 53098140259
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 19:33:32 +0800 (CST)
Received: from [10.174.176.198] (10.174.176.198) by
 kwepemj100001.china.huawei.com (7.202.195.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 21 Sep 2024 19:33:31 +0800
Message-ID: <eba4b2cf-cf64-4237-aaf6-8aa521c77007@huawei.com>
Date: Sat, 21 Sep 2024 19:33:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <qemu-devel@nongnu.org>
Subject: RTC time could run slow 3s than host time when clock=vm & base=UTC
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.198]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemj100001.china.huawei.com (7.202.195.246)
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=jiaqingtong@huawei.com; helo=szxga06-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 21 Sep 2024 09:12:43 -0400
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
Reply-to:  =?UTF-8?B?6LS+5bqG5b2k?= <jiaqingtong@huawei.com>
From:  =?UTF-8?B?6LS+5bqG5b2k?= via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When start qemu with -rtc base=utc,clock=vm, sometime guest time can 
slower 3s than host.

There's no problem (also didn't be noticed) as we often start ntp 
service, who will adjust our system time.

But let's talk about if we havn't enable NTP service(for example system 
just booted)

After inspect into the code, i found that there are two problem we 
should think about:

1） The RTC time accuracy problem

1. in the call chains 
rtc_realizefn->rtc_set_date_from_host->qemu_get_timedate->qemu_ref_timedate,

the qemu_clock_get_ms(clock) / 1000 will lost ~0.999s at max.

2. In the call chains cmos_ioport_read->rtc_update_time, the guest_sec = 
guest_nsec / NANOSECONDS_PER_SECOND

will also lost ~0.999s at max.

3. after this[1] merged, in configure_rtc, the rtc_ref_start_datetime = 
qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000

will also lost ~0.999s at max.

Therefore, total about 3s the guest time will behind the host.

So what precision should we offer? the RTC Hardware's precision is 
second(that means the smallest step is 1 second,

not the accurate like time error about 8.6 to 1.7 seconds per day),


2）The ref start datetime

After this[1] merged, which intend to solve the -rtc 
base=DATETIME,clock=vm's problem ("It restores determinism

of guest execution when used with clock=vm and specified base value.").

"-rtc base=utc,clock=vm"'s ref start date time changed from the host 
time of the current executing code to

the const time of executing configure_rtc(rtc_ref_start_datetime = 
qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;).

This will add additional time(current approx. 0.4s or other, depend on 
code executing time and how many class_init

  executed etc.),which start from configure_rtc to rtc device init, into 
guest time.

Hence, should we try to split -rtc base=utc,clock=vm's ref start date 
time to the original current host time

qemu_clock_get_ms(QEMU_CLOCK_HOST),not the time(rtc_ref_start_datetime) 
save in configure_rtc,

to achieve more accurate time?(or other better method)


[1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03577.html


