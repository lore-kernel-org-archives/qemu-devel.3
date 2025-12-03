Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB62D12D79
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoV9-0004FC-Jk; Wed, 03 Dec 2025 10:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQoV6-0004EP-S1; Wed, 03 Dec 2025 10:10:40 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQoV4-0001vd-CC; Wed, 03 Dec 2025 10:10:40 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX35vkUjBp7DH5Ag--.37S2;
 Wed, 03 Dec 2025 23:10:28 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwAXce7XUjBp6lMJAA--.23924S2;
 Wed, 03 Dec 2025 23:10:22 +0800 (CST)
Message-ID: <4a0aab55-2805-47f9-a1be-91b8e7b6ceae@phytium.com.cn>
Date: Wed, 3 Dec 2025 23:10:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 12/21] hw/arm/smmu-common: Implement secure state
 handling in ptw
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151200.4129164-1-tangtao1634@phytium.com.cn>
 <274e3061-c4ab-48f6-ba95-ed0eed0e2ce2@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <274e3061-c4ab-48f6-ba95-ed0eed0e2ce2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXce7XUjBp6lMJAA--.23924S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQADsr
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jw4UKw4UWw47ur15uw48Zwb_yoW7Zr4DpF
 Z3G3Zxtr4ftFyfZwn2qr4qv3W7A3yvqr4UGrZrG3sY9Fyqyr97tryqkryF9FykJry5J3Wj
 va1UKrsxW3W5trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Eric,

On 2025/12/2 23:53, Eric Auger wrote:
>
> On 10/12/25 5:12 PM, Tao Tang wrote:
>> Enhance the page table walker to correctly handle secure and non-secure
>> memory accesses. This change introduces logic to select the appropriate
>> address space and enforce architectural security policies during walks.
>>
>> The page table walker now correctly processes Secure Stage 1
>> translations. Key changes include:
>>
>> - The get_pte function now uses the security context to fetch table
>> entries from either the Secure or Non-secure address space.
>>
>> - The stage 1 walker tracks the security state, respecting the NSCFG
>> and NSTable attributes. It correctly handles the hierarchical security
>> model: if a table descriptor in a secure walk has NSTable=1, all
>> subsequent lookups for that walk are forced into the Non-secure space.
>> This is a one-way transition, as specified by the architecture.
>>
>> - A check is added to fault nested translations that produce a Secure
>> IPA when Secure stage 2 is not supported (SMMU_S_IDR1.SEL2 == 0).
>>
>> - The final TLB entry is tagged with the correct output address space,
>> ensuring proper memory isolation.
>>
>> Stage 2 translations are currently limited to Non-secure lookups. Full
>> support for Secure Stage 2 translation will be added in a future series.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-common.c | 64 +++++++++++++++++++++++++++++++++++++++-----
>>   hw/arm/trace-events  |  2 +-
>>   2 files changed, 59 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 5fabe30c75..a092bb5a8d 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -399,20 +399,26 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>>    * @base_addr[@index]
>>    */
>>   static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
>> -                   SMMUPTWEventInfo *info)
>> +                   SMMUPTWEventInfo *info, SMMUSecSID sec_sid)
>>   {
>>       int ret;
>>       dma_addr_t addr = baseaddr + index * sizeof(*pte);
>> -
>> +    MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
>> +    AddressSpace *as = smmu_get_address_space(sec_sid);
>> +    if (!as) {
>> +        info->type = SMMU_PTW_ERR_WALK_EABT;
> is it WALK_EABT or PERMISSION in that case? I fail to find where it is
> specified in the spec. Add a reference once?


Maybe this is the same situation I described earlier in the previous 
thread [1]?  I’m still not confident there is a clear architected 
mapping for this condition to a specific PTW event type. Rather than 
arbitrarily picking WALK_EABT or PERMISSION, I am leaning towards 
treating it as a pure model bug:

I’ll switch this to a g_assert(as) so we don’t report an architected 
event for something that should never happen on a correctly wired 
machine model.


[1] 
https://lore.kernel.org/qemu-devel/e80c6fbc-47a4-490a-8615-be2ee122eb94@phytium.com.cn/

>> +        info->addr = addr;
>> +        return -EINVAL;
>> +    }
>>       /* TODO: guarantee 64-bit single-copy atomicity */
>> -    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
>> +    ret = ldq_le_dma(as, addr, pte, attrs);
>>   
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>>           tlbe->entry.translated_addr = gpa;
>>           tlbe->entry.iova = iova & ~mask;
>>           tlbe->entry.addr_mask = mask;
>> @@ -688,7 +726,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>>           dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>>           uint8_t s2ap;
>>   
>> -        if (get_pte(baseaddr, offset, &pte, info)) {
>> +        /* Use NS as Secure Stage 2 is not implemented (SMMU_S_IDR1.SEL2 == 0)*/
> I don't really get this as you passed the sel2 in the cfg?


In the next revision I’ll simplify the story. SMMUTransCfg will no 
longer carry a sel2 field, and this series will explicitly not support 
Secure Stage 2. In that context, the Stage-2 PTW will be hard-coded to 
use SMMU_SEC_SID_NS. If/when we add SEL2 support in a follow-up series, 
we can then make this driven by configuration instead of hard-coded.


>> +        if (get_pte(baseaddr, offset, &pte, info, SMMU_SEC_SID_NS)) {
>>                   goto error;
>>           }
>>           trace_smmu_ptw_level(stage, level, ipa, subpage_size,
>> @@ -741,6 +780,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>>               goto error_ipa;
>>           }
>>   
>> +        tlbe->sec_sid = SMMU_SEC_SID_NS;
>> +        tlbe->entry.target_as = &address_space_memory;
>>           tlbe->entry.translated_addr = gpa;
>>           tlbe->entry.iova = ipa & ~mask;
>>           tlbe->entry.addr_mask = mask;
>> @@ -825,6 +866,17 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
>>           return ret;
>>       }
>>   
>> +    if (!cfg->sel2 && tlbe->sec_sid > SMMU_SEC_SID_NS) {
>> +        /*
>> +         * Nested translation with Secure IPA output is not supported if
>> +         * Secure Stage 2 is not implemented.
>> +         */
>> +        info->type = SMMU_PTW_ERR_TRANSLATION;
> pointer to the spec for TRANSLATION error?
>
> Otherwise looks good
>
> Eric


After re-reading the spec, I think we should move the check earlier, 
when decoding the STE/CD, and use the combination of SMMU_S_IDR1.SEL2, 
Config == 0b11x, and the Secure Stream table context to detect an 
architecturally illegal nested configuration.


In that case I’ll report a C_BAD_STE-style configuration error and bail 
out before running any Secure Stage-1 page walk. That both matches the 
spec more closely and avoids doing extra work in this unsupported 
configuration. How do you think about this?


Thanks again your review.

Tao


