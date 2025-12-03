Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71230D12690
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoq9-0000Bl-JJ; Wed, 03 Dec 2025 10:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQoq8-0000AG-6x; Wed, 03 Dec 2025 10:32:24 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQoq6-0004bE-CA; Wed, 03 Dec 2025 10:32:23 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXHJgCWDBpxF35Ag--.309S2;
 Wed, 03 Dec 2025 23:32:18 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwDnP+0BWDBpgVQJAA--.3606S2;
 Wed, 03 Dec 2025 23:32:17 +0800 (CST)
Message-ID: <4636f0d5-cdf2-4900-b43e-020fc3a45df3@phytium.com.cn>
Date: Wed, 3 Dec 2025 23:32:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 14/21] hw/arm/smmuv3: Add access checks for MMIO registers
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151303.4129730-1-tangtao1634@phytium.com.cn>
 <b5e2e404-1067-4ea2-bede-deaf692b2973@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <b5e2e404-1067-4ea2-bede-deaf692b2973@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwDnP+0BWDBpgVQJAA--.3606S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQAFst
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr4DZFW8Cr1xZryxKFW3Wrg_yoW5Jw4fpw
 1fJ3ZI9F4DJ3WxJ3Way3WjqF15G397Kr17tr47Gr18Zw1jvr1rtF4UKr4FgFyDWryUAw48
 ZF1jgFnxur1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2025/12/3 00:31, Eric Auger wrote:
> Hi Tao,
>
> On 10/12/25 5:13 PM, Tao Tang wrote:
>> The SMMUv3 model was missing checks for register accessibility under
>> certain conditions. This allowed guest software to write to registers
>> like STRTAB_BASE when they should be read-only, or read from
>> GERROR_IRQ_CFG registers when they should be RES0.
>>
>> This patch fixes this by introducing helper functions, such as the
>> smmu_(reg_name)_writable pattern, to encapsulate the architectural
>> access rules. In addition, writes to registers like STRTAB_BASE,
>> queue bases, and IRQ configurations are now masked to correctly
>> handle reserved bits.
>>
>> The MMIO handlers are updated to call these functions before accessing
>> registers. To purely fix the missing checks without introducing new
>> functionality, the security context in the MMIO handlers is explicitly
>> fixed to Non-secure. This ensures that the scope of this patch is
>> limited to fixing existing Non-secure logic.
>>
>> If a register is not accessible, the access is now correctly handled
>> and a guest error is logged, bringing the model's behavior in line with
>> the specification.
>>
>> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
>> Fixes: 10a83cb9887e ("hw/arm/smmuv3: Skeleton")
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 304 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 298 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index f9395c3821..f161dd3eff 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1321,6 +1321,127 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>       }
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>>           bank->gerror_irq_cfg1 = data;
>>           return MEMTX_OK;
>>       case A_GERROR_IRQ_CFG2:
>> @@ -1644,12 +1824,32 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>           }
>>           return MEMTX_OK;
>>       case A_STRTAB_BASE: /* 64b */
>> +        if (!smmu_strtab_base_writable(s, reg_sec_sid)) {
> would you mind splitting this patch into 2, changes related to
>
> smmu_gerror_irq_cfg_writable and changes related to smmu_strtab_base_writable if confirmed they are effectively independent on each others
>
> Eric


Sure. I'll split it in V4. Thanks for your suggestion.

Tao


