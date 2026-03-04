Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676CEEF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmSD-0006VW-TN; Wed, 04 Mar 2026 08:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vxmS1-0006UU-VY; Wed, 04 Mar 2026 08:39:47 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vxmRx-0004yI-Pc; Wed, 04 Mar 2026 08:39:44 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDnPNAPNqhpOZWsAA--.31778S2;
 Wed, 04 Mar 2026 21:39:27 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.233.224])
 by mail (Coremail) with SMTP id AQAAfwDHH+0ONqhpmfgeAA--.38616S2;
 Wed, 04 Mar 2026 21:39:27 +0800 (CST)
Message-ID: <2156c211-101f-4182-a4a9-3a6c3313bf92@phytium.com.cn>
Date: Wed, 4 Mar 2026 21:39:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
To: eric.auger@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
 <aaGu5v0To65M5LkB@google.com>
 <585be3ce-d5f3-455a-a7fb-3181920cfc60@phytium.com.cn>
 <3cff6489-e487-4f7b-b2ea-984fb5379ed9@linaro.org>
 <b6c17396-be09-4497-8dd1-8f66d9c2fe63@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <b6c17396-be09-4497-8dd1-8f66d9c2fe63@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHH+0ONqhpmfgeAA--.38616S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWmnT6AGHwABs5
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF17XF1rZFWUtF4UJF4UCFg_yoW8AF1rpF
 WUKay5KF4kt3W8Ary2kr4IqFyFvw4Fy3y5W345Gr9Y9Fn0qrWSqr1a9wn8uryDur4kWr48
 Zw4vqa9xZFyUZa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi all,

On 2026/3/3 01:53, Eric Auger wrote:
>
> On 3/2/26 6:47 PM, Pierrick Bouvier wrote:
>> On 3/1/26 4:33 AM, Tao Tang wrote:
>>> Hi Mostafa,
>>>
>>> On 2026/2/27 PM10:49, Mostafa Saleh wrote:
>>>> On Sat, Feb 21, 2026 at 06:17:33PM +0800, Tao Tang wrote:
>>>>> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL
>>>>> path
>>>>> and return CERROR_ILL when stage-1 translation is not implemented,
>>>>> matching the architecture requirement (IHI 0070G.b, page 176).
>>>>>
>>>>> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
>>>>> Signed-off-by: Tao Tang<tangtao1634@phytium.com.cn>
>>>> This is a separate fix, it can be sent standalone to make this series
>>>> smaller, similarly the first patch.
>>>
>>> For #1, #2 and #19 commit (this one), since I’m not fully sure about
>>> the expected process here, should I resend these already Reviewed-by
>>> fixes as standalone patch respectively right now,  and try to get
>>> them merged first?
>>>
>> If a set of patches is fully ready, you can always put them first in
>> next version, and ask the maintainer to pull this one.
>> If your current series needs them to build, I usually prefer to keep
>> it all together, instead of having two different series, and using a
>> Based-on tag. But it's a personal preference, some people prefer to
>> see several series.
> Either, either send them in a separate series or put them at the
> beginning. We are approaching the soft freeze so maybe a separate series
> would be better.


Thank you all for the guide.
I’ll resend #1/#2/#19 as a small standalone fixes series with the Fixes 
tags, so it can be picked up independently.

The main series will then be rebased accordingly.

Best regards,

Tao


