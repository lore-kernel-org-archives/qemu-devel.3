Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CADFD0068
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwhNf-0006kN-CA; Sun, 01 Mar 2026 09:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwhNc-0006jr-0o; Sun, 01 Mar 2026 09:02:44 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwhNZ-0007Qk-3F; Sun, 01 Mar 2026 09:02:43 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXn2P4RqRpbGimBw--.8355S2;
 Sun, 01 Mar 2026 22:02:32 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.118.211])
 by mail (Coremail) with SMTP id AQAAfwCH4O33RqRpcS4eAA--.52015S2;
 Sun, 01 Mar 2026 22:02:31 +0800 (CST)
Message-ID: <44d123b5-5f49-4e86-9a21-6a80c7d44362@phytium.com.cn>
Date: Sun, 1 Mar 2026 22:02:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 09/31] hw/arm/smmuv3: Enforce Secure stage 2 capability
 check when decoding STE
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-10-tangtao1634@phytium.com.cn>
 <aaGsu9u91KsDJMNm@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aaGsu9u91KsDJMNm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCH4O33RqRpcS4eAA--.52015S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWmiCd8FiAAFsR
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw1fJF1UGrykGF4UWw45Wrg_yoW8AFy3pF
 WrGa9Y9FWfG3W3ZF12vwnFyrZrW3y8Kr9rCr18K34xZw1DArnxJr10kF1YgryrXrW5X3y2
 9anF9Fs5Xws0y37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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

Hi Mostafa,

On 2026/2/27 PM10:39, Mostafa Saleh wrote:
> On Sat, Feb 21, 2026 at 06:02:28PM +0800, Tao Tang wrote:
>> When decoding a Stream Table Entry (STE) from the Secure stream table
>> that enables stage-2 translation, verify that the SMMU implementation
>> advertises Secure stage-2 support via S_IDR1.SEL2. If stage-2 is
>> requested but S_IDR1.SEL2 is 0, mark the STE as ILLEGAL.
>>
>> This implements the requirement from the Arm SMMUv3 architecture
>> specification (IHI 0070G.b, Section 5.2, Page 218) that a Secure STE
>> with stage-2 enabled is only valid when the implementation supports
>> Secure stage-2 translation.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 2192bec2368..d011357253e 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -623,6 +623,16 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>>           if (ret) {
>>               goto bad_ste;
>>           }
>> +
>> +        /*
>> +         * Stage 2 is implemented but Secure stage 2 is not supported while
>> +         * STE is from Secure stream table. STE is ILLEGAL in this case
>> +         * according to (IHI 0070G.b) 5.2 STE, Stream Table Entry, Page 218.
>> +         */
>> +        if ((cfg->sec_sid == SMMU_SEC_SID_S) &&
>> +            !(FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2))) {
>> +            goto bad_ste;
>> +        }
> The IDR is not currently set, we can just safely return bad_ste for
> “SMMU_SEC_SID_S”, no need to complicate things until SEL2 is supported.


Agreed. I’ll simplify this to unconditionally treat Secure STE 
requesting stage-2 as ILLEGAL, and revisit the SEL2 check once SEL2 
support is implemented.


> Thanks,
> Mostafa


Best regards,

Tao


