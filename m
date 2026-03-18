Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A4FCD0C1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2kwV-0004Dr-O6; Wed, 18 Mar 2026 03:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1w2kwS-0004DN-6j
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:03:44 -0400
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1w2kwP-00027f-3T
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:03:43 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=eba/oeJbw1c6TtdQ2j4eTbvAyfwgeAwL4tP35oV/SwU=;
 b=KtaOVMY9Ulu0PMG9WwmtaZsMNiGtmHAfGQ3TsQTQuT+kgV119uXniHPRtZ67RVONsJo6N56y7
 BL7ppEUQ8reaR1jWp/r60TTqypTuUfMDJw/80Li94BxwLXLl2UrZoQYbB4XX1YfZ/yKbiHNjUQQ
 zXTYJkn8oGonZa6QVuxBFso=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fbKRQ0g9qz1K9VZ;
 Wed, 18 Mar 2026 14:58:26 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 50CE340565;
 Wed, 18 Mar 2026 15:03:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Mar 2026 15:03:22 +0800
Message-ID: <8a9bb7a8-a45b-ecb1-4a16-b48bb6b9f856@huawei.com>
Date: Wed, 18 Mar 2026 15:03:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] hw/rtc/mc146818rtc: Fix get_guest_rtc_ns() overflow bug
Content-Language: en-US
To: <peter.maydell@linaro.org>, <mst@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20260114013257.3500578-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260114013257.3500578-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
Received-SPF: pass client-ip=113.46.200.225;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout10.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.101,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Gentle ping.

On 2026/1/14 9:32, Jinjie Ruan wrote:
> In get_guest_rtc_ns(), "s->base_rtc" is uint64_t, which multiplied by
> "NANOSECONDS_PER_SECOND" may overflow the uint64_t type, which will
> cause the QEMU Linux Virtual Machine's RTC time to jump and in turn
> triggers a kernel Soft Lockup and ultimately leads to a crash.
> 
> Fix it by avoiding adding s->base_rtc in get_guest_rtc_ns_offset(),
> because get_guest_rtc_ns() is used either take the remainder of
> NANOSECONDS_PER_SECOND or take the quotient of NANOSECONDS_PER_SECOND.
> 
> Fixes: 56038ef6234e ("RTC: Update the RTC clock only when reading it")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add comment for get_guest_rtc_ns().
> - Update the commit message.
> ---
>  hw/rtc/mc146818rtc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index 8631386b9f..36de30649c 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -77,12 +77,13 @@ static inline bool rtc_running(MC146818RtcState *s)
>              (s->cmos_data[RTC_REG_A] & 0x70) <= 0x20);
>  }
>  
> +/*
> + * Note: get_guest_rtc_ns() does not include the "base_rtc" seconds value,
> + * so the caller "must" handle it themselves!!!
> + */
>  static uint64_t get_guest_rtc_ns(MC146818RtcState *s)
>  {
> -    uint64_t guest_clock = qemu_clock_get_ns(rtc_clock);
> -
> -    return s->base_rtc * NANOSECONDS_PER_SECOND +
> -        guest_clock - s->last_update + s->offset;
> +    return qemu_clock_get_ns(rtc_clock) - s->last_update + s->offset;
>  }
>  
>  static void rtc_coalesced_timer_update(MC146818RtcState *s)
> @@ -623,10 +624,8 @@ static void rtc_update_time(MC146818RtcState *s)
>  {
>      struct tm ret;
>      time_t guest_sec;
> -    int64_t guest_nsec;
>  
> -    guest_nsec = get_guest_rtc_ns(s);
> -    guest_sec = guest_nsec / NANOSECONDS_PER_SECOND;
> +    guest_sec = s->base_rtc + get_guest_rtc_ns(s) / NANOSECONDS_PER_SECOND;
>      gmtime_r(&guest_sec, &ret);
>  
>      /* Is SET flag of Register B disabled? */
> @@ -637,7 +636,7 @@ static void rtc_update_time(MC146818RtcState *s)
>  
>  static int update_in_progress(MC146818RtcState *s)
>  {
> -    int64_t guest_nsec;
> +    uint64_t guest_nsec;
>  
>      if (!rtc_running(s)) {
>          return 0;

