Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CAFC5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRfc-0002So-9M; Fri, 21 Aug 2026 12:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxRfM-0002RJ-U2; Fri, 21 Aug 2026 12:00:25 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wxRfC-0007jm-F4; Fri, 21 Aug 2026 12:00:24 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBXWbEGdohqDHUHAQ--.18350S2; 
 Sat, 22 Aug 2026 00:00:06 +0800 (CST)
Received: from [192.168.2.8] (unknown [113.246.117.12])
 by mail (Coremail) with SMTP id AQAAf8DwanUBdohqo8ZhAA--.11063S2;
 Sat, 22 Aug 2026 00:00:01 +0800 (CST)
Message-ID: <0f3cec2d-a184-4fdf-b4e1-d7d2ae4a67fb@phytium.com.cn>
Date: Sat, 22 Aug 2026 00:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 15/28] hw/arm/smmu: Make CMDQ invalidation security-state
 aware
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-5-tangtao1634@phytium.com.cn>
 <4b80bd7c-1002-4ae4-a9fe-7449c0637687@oss.qualcomm.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <4b80bd7c-1002-4ae4-a9fe-7449c0637687@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwanUBdohqo8ZhAA--.11063S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWqHVcgGNAAFsN
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFyktr4kCr45XF1ktw43KFg_yoW5Zr13pa
 yrKr95K3ykGF4Ikw1fAw48ua45W397Wr1UGw13K34fZwn0yr1Yqr42kr1agFykur18Gr1U
 Za42vF4Dua4jy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Pierrick,

On 8/21/2026 6:29 AM, Pierrick Bouvier wrote:
> On 8/13/2026 9:25 AM, Tao Tang wrote:
>> Refactor CMDQ invalidation paths to carry security state and apply cache
>> invalidation per sec_sid instead of globally. Add separate helpers for
>> invalidating all entries and for invalidating entries belonging to one
>> valid sec_sid.
>>
>> In smmuv3, propagate the command queue sec_sid and command SSec through
>> CFGI and TLBI handling, and gate VMID use on the stage-2 capability of
>> the selected command queue, including SMMU_S_IDR1.SEL2 for a Secure
>> Command queue.
>>
>> Keep acceleration and IOMMU notifier propagation Non-secure-only.
>> Commands targeting a programming interface other than Non-secure do not
>> reach the accelerated backend or Non-secure notifiers, while Non-secure
>> stage-1 CMD_TLBI_NH_ALL remains forwarded to the host.
>>
>> Include the command queue SEC_SID and target SEC_SID in the relevant
>> invalidation tracepoints.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c         | 100 ++++++++++++++++++++++++++++-
>>   hw/arm/smmuv3-accel-stubs.c  |   6 +-
>>   hw/arm/smmuv3-accel.c        |  30 +++++++--
>>   hw/arm/smmuv3-accel.h        |   6 +-
>>   hw/arm/smmuv3.c              | 121 ++++++++++++++++++++++++++---------
>>   hw/arm/trace-events          |  12 ++--
>>   include/hw/arm/smmu-common.h |   6 ++
>>   7 files changed, 231 insertions(+), 50 deletions(-)
>>
> Given this patch, would that be simpler to have multiple iotlb hashtable
> per sec_sid? This way, invalidation becomes trivial.
>
> It has been long time since last version, so I forgot if there was a
> specific reason to keep a single table and add sec_sid to each entry.


I agree that separate IOTLB tables per SEC_SID would simplify the 
namespace-wide invalidation in the current model. Mostafa made the same 
suggestion in v4 [1], and I agreed to rework it for v5.

As Eric later pointed out [2], SEC_SID is not itself the architectural 
TLB tag. It selects the programming interface and Stream table, while 
cached translations are identified by the effective StreamWorld and the 
applicable ASID/VMID.

My reason for retaining the single table is therefore patch scope, not 
an architectural objection to per-SEC_SID tables. This series models one 
StreamWorld per SEC_SID and uses SEC_SID as a temporary discriminator, 
as described in the definition of struct SMMUIOTLBKey [3]. I would 
prefer to keep the cache topology unchanged here and address the layout 
together with full StreamWorld tagging and invalidation in a follow-up 
series.

Eric, would you prefer that v6 adopt the per-SEC_SID split suggested by 
Pierrick and Mostafa, or keep the current layout and defer the topology 
decision to the StreamWorld work? I am happy to follow the preferred 
direction.

[1] https://lore.kernel.org/qemu-devel/aaGuGuevX8HFqx0x@google.com/
[2] 
https://lore.kernel.org/qemu-devel/72026588-1db3-48a1-af99-e5e2aca69058@redhat.com/
[3] 
https://lore.kernel.org/qemu-devel/20260813162512.2807281-2-tangtao1634@phytium.com.cn/ 



> Regards,
> Pierrick


Best regards,

Tao


