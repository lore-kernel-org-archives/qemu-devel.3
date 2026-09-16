Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1343C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mwH-0002eA-9O; Wed, 16 Sep 2026 06:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6mw5-0002dh-8i; Wed, 16 Sep 2026 06:32:19 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x6mw1-00016K-UW; Wed, 16 Sep 2026 06:32:17 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAHXt0mcKpq6ZkGAA--.11515S2; 
 Wed, 16 Sep 2026 18:32:07 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dw0HUhcKpqk73WAA--.40037S2;
 Wed, 16 Sep 2026 18:32:01 +0800 (CST)
Message-ID: <51ba67b8-98db-42a7-aa60-5a802b78a63d@phytium.com.cn>
Date: Wed, 16 Sep 2026 18:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 18/28] hw/arm/smmuv3: Add access checks for CMDQ and
 EVENTQ registers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162558.2808607-3-tangtao1634@phytium.com.cn>
 <72f6a745-1a31-4bc6-887f-a79c72669cfe@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <72f6a745-1a31-4bc6-887f-a79c72669cfe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dw0HUhcKpqk73WAA--.40037S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWqpnMkFrwAAs4
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WFWrZF1UKr1DZr4DWr18AFb_yoW8ury7pr
 yUGws0qr4vgrWIv393tw10va1YgFWkJr17Xry3Wr98W345GryYyF15Ka95JaykWry5G34I
 qFsrtFW3C3y5AFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Eric,

On 2026/8/28 18:09, Eric Auger wrote:
>
> On 8/13/26 6:25 PM, Tao Tang wrote:
>> Add access control for command queue and event queue related registers
>> to ensure they can only be modified under proper conditions.
> please explain what is wrong first
OK.
>> For command queue (CMDQ):
>> - smmu_cmdq_disabled_stable(): checks CMDQ bit in CR0/CR0ACK
> always assume CR0=CR0ACK?
I'll drop the redundant CR0ACK checks.
>> - smmu_cmdq_base_writable(): checks IDR1.QUEUES_PRESET==0 and CMDQ disabled
>>
>> For event queue (EVTQ):
>> - smmu_eventq_disabled_stable(): checks EVTQ bit in CR0/CR0ACK
>> - smmu_eventq_base_writable(): checks IDR1.QUEUES_PRESET==0 and EVTQ disabled
...
>> - smmu_irq_cfg_present(): checks SMMU_IDR0.MSI for the Non-secure
>>    EVENTQ_IRQ_CFG register set and SMMU_S_IDR0.MSI for the Secure set
> can't you simply assume MSI is not supported?

Sure. EVENTQ_IRQ_CFGx should be RES0 because of unsupported MSI as 
discussed for patch #16.

Additionally, QUEUES_PRESET checks will be dropped following the 
TABLES_PRESET simplification in patch #17.

>> - smmu_eventq_irq_cfg_writable(): additionally checks EVENTQ_IRQEN
>>
>> Absent EVENTQ_IRQ_CFG registers read as RES0. Present registers retain
>> their programmed values for readback. The helper remains keyed by
>> SEC_SID so future Realm support can select SMMU_R_IDR0.MSI.
>>
>> Additionally, mask reserved bits on writes using SMMU_QUEUE_BASE_RESERVED
>> for queue base registers and SMMU_EVENTQ_IRQ_CFG0_RESERVED for
>> EVENTQ_IRQ_CFG0.
>>
>> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++--
> 210 changes lines -> Can't you split into 2a ll the more so the handling
> is different from CMDQ and EVENTQ

I'll split it into 2 patches and describe these issues first in the 
commit messages.


Thanks,

Tao


