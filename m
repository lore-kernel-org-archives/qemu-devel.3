Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8202FFEFB67
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw015-0000HU-8v; Fri, 27 Feb 2026 10:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vw011-0000H0-6h; Fri, 27 Feb 2026 10:44:32 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vw00z-0001rH-O2; Fri, 27 Feb 2026 10:44:30 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXX5vYu6Fp8hKYBw--.45S2;
 Fri, 27 Feb 2026 23:44:24 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.232.133])
 by mail (Coremail) with SMTP id AQAAfwAHXuvXu6FpPbkdAA--.36627S2;
 Fri, 27 Feb 2026 23:44:23 +0800 (CST)
Message-ID: <22745fd1-afa1-4b0b-943a-f275407ca3be@phytium.com.cn>
Date: Fri, 27 Feb 2026 23:44:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 23/31] hw/arm/smmuv3: Add access checks for CMDQ and
 EVENTQ registers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101823.2996302-1-tangtao1634@phytium.com.cn>
 <eeaf6ae9-23e0-4413-985f-dcff03737dbb@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <eeaf6ae9-23e0-4413-985f-dcff03737dbb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHXuvXu6FpPbkdAA--.36627S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWmguFMsVgAOsB
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw4DJr4rAryxurWfZFy8AFb_yoW8WrWDpF
 y8K3s8KF4Iqry2v3sayr10yay5WFZ7Jwn7Xr47Gr98Ww15Arn5ZF48Kr95Ga4kWry8J3Wx
 X3WDtayxW34rAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

Hi Pierrick,

On 2026/2/26 05:59, Pierrick Bouvier wrote:
> On 2/21/26 2:18 AM, Tao Tang wrote:
>> Add access control for command queue and event queue related registers
>> to ensure they can only be modified under proper conditions.
>>
>> For command queue (CMDQ):
>> - smmu_cmdq_disabled_stable(): checks CMDQ bit in CR0/CR0ACK
>> - smmu_cmdq_base_writable(): checks IDR1.QUEUES_PRESET==0 and CMDQ 
>> disabled
>>
>> For event queue (EVTQ):
>> - smmu_eventq_disabled_stable(): checks EVTQ bit in CR0/CR0ACK
>> - smmu_eventq_base_writable():checks IDR1.QUEUES_PRESET==0 and EVTQ 
>> disabled
>> - smmu_eventq_irq_cfg_writable(): checks MSI support and EVENTQ_IRQEN 
>> state
>>
>> Additionally, mask reserved bits on writes using 
>> SMMU_QUEUE_BASE_RESERVED
>> for queue base registers and SMMU_EVENTQ_IRQ_CFG0_RESERVED for
>> EVENTQ_IRQ_CFG0.
>>
>> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 154 insertions(+), 3 deletions(-)
>>
>
> It seems like we use the same pattern a lot of time for various SMMU 
> registers, and makes me wonder if we could not introduce proper 
> register definitions with callbacks similar to Arm *_reginfo.
>
> That said, it's definitely out of the scope for this series:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


Thanks for your suggestion. I will consider refactoring it after merging 
the current series.


Best regards,

Tao


