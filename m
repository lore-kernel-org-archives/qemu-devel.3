Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE5CD1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnt9-0002rc-4D; Wed, 03 Dec 2025 09:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQnsg-0002ou-FU; Wed, 03 Dec 2025 09:31:03 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vQnsc-0008HG-IR; Wed, 03 Dec 2025 09:30:57 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3f2OXSTBp1tX4Ag--.1967S2;
 Wed, 03 Dec 2025 22:30:47 +0800 (CST)
Received: from [192.168.31.152] (unknown [113.246.234.131])
 by mail (Coremail) with SMTP id AQAAfwAHXuuWSTBp5VIJAA--.3550S2;
 Wed, 03 Dec 2025 22:30:46 +0800 (CST)
Message-ID: <d5dfb06e-b80a-4f13-b629-87f9545c4b4e@phytium.com.cn>
Date: Wed, 3 Dec 2025 22:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 11/21] hw/arm/smmuv3: Decode security attributes from
 descriptors
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-12-tangtao1634@phytium.com.cn>
 <6173cde1-ee30-45b5-a8dc-0cdb09a4b1f1@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <6173cde1-ee30-45b5-a8dc-0cdb09a4b1f1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAHXuuWSTBp5VIJAA--.3550S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWkvSDQGnQACsq
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXrW7Ww45Kw43WrWxCw1UGFg_yoWrGrykpr
 WkGFn8KFW8J3WxKws2qr4avFs3Xws5tF1DCrn0gr95Aws0vryfWF1Ikry5KasF9rn5Jr42
 vr4qvas5urZFqrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Hi Eric

On 2025/12/2 23:19, Eric Auger wrote:
> Hi Tao,
>
> On 10/12/25 5:06 PM, Tao Tang wrote:
>> As the first step in implementing secure page table walks, this patch
>> introduces the logic to decode security-related attributes from various
>> SMMU structures.
>>
>> The NSCFG bits from the Context Descriptor are now decoded and stored.
>> These bits control the security attribute of the starting-level
>> translation table, which is crucial for managing secure and non-secure
>> memory accesses.
>>
>> The SMMU_S_IDR1.SEL2 bit is read to determine if Secure stage 2
>> translations are supported. This capability is cached in the
>> SMMUTransCfg structure for the page table walker's use.
>>
>> Finally, new macros (PTE_NS, PTE_NSTABLE) are added to prepare for
>> extracting attributes from page and table descriptors. To improve
>> clarity, these different attribute bits are organized into distinct
>> subsections in the header file.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmu-internal.h       | 16 ++++++++++++++--
>>   hw/arm/smmuv3-internal.h     |  2 ++
>>   hw/arm/smmuv3.c              |  2 ++
>>   include/hw/arm/smmu-common.h |  3 +++
>>   4 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
>> index d143d296f3..a0454f720d 100644
>> --- a/hw/arm/smmu-internal.h
>> +++ b/hw/arm/smmu-internal.h
>> @@ -58,16 +58,28 @@
>>       ((level == 3) &&                                                    \
>>        ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
>>   
>> +/* Block & page descriptor attributes */
>> +/* Non-secure bit */
>> +#define PTE_NS(pte) \
>> +    (extract64(pte, 5, 1))
>> +
>>   /* access permissions */
>>   
>>   #define PTE_AP(pte) \
>>       (extract64(pte, 6, 2))
>>   
>> +/* access flag */
>> +#define PTE_AF(pte) \
>> +    (extract64(pte, 10, 1))
>> +
>> +
>> +/* Table descriptor attributes */
>>   #define PTE_APTABLE(pte) \
>>       (extract64(pte, 61, 2))
>>   
>> -#define PTE_AF(pte) \
>> -    (extract64(pte, 10, 1))
>> +#define PTE_NSTABLE(pte) \
>> +    (extract64(pte, 63, 1))
>> +
>>   /*
>>    * TODO: At the moment all transactions are considered as privileged (EL1)
>>    * as IOMMU translation callback does not pass user/priv attributes.
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 99fdbcf3f5..1e757af459 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -703,6 +703,8 @@ static inline int oas2bits(int oas_field)
>>   #define CD_R(x)          extract32((x)->word[1], 13, 1)
>>   #define CD_A(x)          extract32((x)->word[1], 14, 1)
>>   #define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
>> +#define CD_NSCFG0(x)     extract32((x)->word[2], 0, 1)
>> +#define CD_NSCFG1(x)     extract32((x)->word[4], 0, 1)
>>   
>>   /**
>>    * tg2granule - Decodes the CD translation granule size field according
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 55f4ad1757..3686056d8e 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -812,6 +812,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>>               tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
>>           }
>>   
>> +        tt->nscfg = i ? CD_NSCFG1(cd) : CD_NSCFG0(cd);
>>           tt->had = CD_HAD(cd, i);
>>           trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>>       }
>> @@ -915,6 +916,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>>               cfg = NULL;
>>               return cfg;
>>           }
>> +        cfg->sel2 = FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2);
> I don't get why we store sel2 in the cfg as it does not vary.
>
> Thanks
>
> Eric

You're absolutely right—caching SEL2 in SMMUTransCfg was unnecessary. I 
didn’t think it through carefully at the time. I’ll drop that change in 
the next revision.

Thanks,

Tao


