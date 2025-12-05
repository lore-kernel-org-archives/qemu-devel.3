Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF8AD2E008
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRPMg-0007YH-00; Fri, 05 Dec 2025 01:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRPMb-0007Xg-J1; Fri, 05 Dec 2025 01:32:22 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vRPMY-0002Jd-Gm; Fri, 05 Dec 2025 01:32:21 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCnrmJmfDJphgoRAw--.2152S2;
 Fri, 05 Dec 2025 14:32:06 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDnP+1ffDJphbgJAA--.4243S2;
 Fri, 05 Dec 2025 14:32:00 +0800 (CST)
Message-ID: <c4b53716-47ad-4507-a889-f0f1487c1c68@phytium.com.cn>
Date: Fri, 5 Dec 2025 14:31:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 15/21] hw/arm/smmuv3: Determine register bank from MMIO
 offset
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151331.4130048-1-tangtao1634@phytium.com.cn>
 <83975c51-b49a-4300-af76-f2289c8bcdec@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <83975c51-b49a-4300-af76-f2289c8bcdec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwDnP+1ffDJphbgJAA--.4243S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWkwma4FjAAKsn
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFy7Cr4kJF4DXryxXr4Utwb_yoW7Jw47p3
 9xt3W3KF4ktF47Xr1SqF1UGF13Cws7Kr15Arn8Kry8Z3s0yr18JF40vryF9FyDJry5Ar1U
 tF45Jr17ur45ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Eric,

On 2025/12/4 22:21, Eric Auger wrote:
>
> On 10/12/25 5:13 PM, Tao Tang wrote:
>> Modify the main MMIO handlers (smmu_write_mmio, smmu_read_mmio)
>> to determine the security state of the target register based on its
>> memory-mapped offset.
>>
>> By checking if the offset is within the secure register space (>=
>> SMMU_SECURE_REG_START), the handlers can deduce the register's
>> SEC_SID (reg_sec_sid). This SID is then passed down to the register
>> access helper functions (smmu_writel, smmu_readl, etc.).
>>
>> Inside these helpers, the switch statement now operates on a masked,
>> relative offset:
>>
>>      uint32_t reg_offset = offset & 0xfff;
>>      switch (reg_offset) {
>>          ...
>>      }
>>
>> This design leverages a key feature of the SMMU specification: registers
>> with the same function across different security states
>> (Non-secure, Realm, Root) share the same relative offset. This avoids
>> significant code duplication. The reg_sec_sid passed from the MMIO
>> handler determines which security bank to operate on, while the masked
>> offset identifies the specific register within that bank.
>>
>> It is important to distinguish between the security state of the
>> register itself and the security state of the access. A
>> higher-privilege security state is permitted to access registers
>> belonging to a lower-privilege state, but the reverse is not allowed.
>> This patch lays the groundwork for enforcing such rules.
>>
>> For future compatibility with Realm and Root states, the logic in the
>> else block corresponding to the secure offset check:
>>
>> if (offset >= SMMU_SECURE_REG_START) {
>>      reg_sec_sid = SMMU_SEC_SID_S;
>> } else {
>>      /* Future Realm/Root handling */
>> }
>>
>> will need to be expanded. This will be necessary to differentiate
>> between the Root Control Page and Realm Register Pages, especially since
>> the Root Control Page is IMPLEMENTATION DEFINED.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c | 61 ++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 45 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index f161dd3eff..100caeeb35 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>>           bank->cr[0] = data;
>>           bank->cr0ack = data & ~SMMU_CR0_RESERVED;
>> @@ -1985,12 +1987,33 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>>       offset &= ~0x10000;
>>   
>> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>> +    /*
>> +     * The security state of the access (MemTxAttrs attrs) may differ from the
>> +     * security state to which the register belongs. Future support will include
>> +     * Realm and Root security states.
>> +     *
>> +     * The SMMU architecture specifies that Realm, Root, and Non-secure
>> +     * registers share the same offset layout within the last 4 hexadecimal
>> +     * digits (16 bits) of the address. Only Secure state registers are
>> +     * mapped to a higher address space, starting from
>> +     * SMMU_SECURE_REG_START (0x8000).
>> +     *
>> +     * Therefore, we can directly use the offset to distinguish Secure
>> +     * registers. When Realm and Root support is needed in the future, we
>> +     * only need to enhance the 'else' block of the corresponding 'if'
>> +     * statement to handle those specific security states.
> I wouldn't add that many references to the Realm and Root support in the
> very code. Maybe move that in the commit desc.
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>>   
>>   static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>> -                              uint64_t *data, MemTxAttrs attrs)
>> +                              uint64_t *data, MemTxAttrs attrs,
>> +                              SMMUSecSID reg_sec_sid)
>>   {
>> -    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, reg_sec_sid);
>> +    uint32_t reg_offset = offset & 0xfff;
>>   
>> -    switch (offset) {
>> +    switch (reg_offset) {
>>       case A_IDREGS ... A_IDREGS + 0x2f:
>>           *data = smmuv3_idreg(offset - A_IDREGS);
>>           return MEMTX_OK;
>> @@ -2165,13 +2190,17 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
>>   
>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>>       offset &= ~0x10000;
>> +    SMMUSecSID reg_sec_sid = SMMU_SEC_SID_NS;
> declaration should be at the beginning of the function, ie before the
> offset setting


Thanks for the review. I'll keep only a short comment in the code and 
move the roadmap description into commit msg. I'll also move these 
declarations to the beginning (I've found this issue in a few other places).


Best regards,

Tao


