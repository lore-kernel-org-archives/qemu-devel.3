Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7DDCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3aBC-0007bO-2R; Tue, 30 Sep 2025 09:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3aB3-0007Y3-QV
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3aB0-0003HI-JL
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759238029;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jjRIhaZR8ZlE9lRBTTO3oPPJoTeikj7GqYFH/IFWeKY=;
 b=Iznn+TvWplRQmoCk2xOGHLFRwakQP1KtmnXElAxqCKe8NPTWWGU4Oz2x3bzkrhZezcKa2G
 7iJJ9cGfYKzAI4zp6tz0Y9b/5NJYmqO/304vjLP4Z4ER74oOEOejMWokxwDdqM6pkgTlm6
 GoFbBN8TgoPSEe1lA4a32h0Xv1/bDtY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-AG1zxV8LMSSSUnTpKStcxA-1; Tue, 30 Sep 2025 09:13:48 -0400
X-MC-Unique: AG1zxV8LMSSSUnTpKStcxA-1
X-Mimecast-MFC-AGG-ID: AG1zxV8LMSSSUnTpKStcxA_1759238027
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f93db57449so3461368f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759238027; x=1759842827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjRIhaZR8ZlE9lRBTTO3oPPJoTeikj7GqYFH/IFWeKY=;
 b=ElAlhJSR8e9QP6DSAhKuVfr4IfJvpTesZgEBRTTxVLiZN1J2nQipi84Boc3pXYJC0e
 POVn5SOU8YF2k1CA4Nm754YkO/7n4t+bR4doE0mmGn/3/g0C6A46bfBoMTzwL5dYz3YY
 UtZ+v2cnxZmpya/pkWrf0dt1Jr0KrXZ6dTKZkVtdpcHCK5tr0DQlRYP6yr+gM/kh2STH
 kZ2XSdopSGaG2dA7sVj28pzbMfvO9kk5CMXQzka25iEqsXejaxgxFnmFFQrv0O6re+u+
 RLyNpvCiDdI5BIsK5h/Tk+suU7NSzTsPREJBXwQlzCrcVdBf/aa5XJp3FfGJ5ZUy2w28
 xIzQ==
X-Gm-Message-State: AOJu0YzY0g8fFS2b06asbfzxLiHt9UVWg5YmgA13TGuHQ5E/pqHw0v8l
 8VbO5kv8h/1h8QIbsE2eTkHhxsGO7YIsGjAPwNYhKTi+uHfikPnlB2LvD3jft0fHPyawg44EC5o
 Sa0Czrab4vkrITA9GplxQTrlYTbyrxc+h5LdulptWQ5oxnAOmAZ6NoJQB
X-Gm-Gg: ASbGncsV8c9xhwjPDy4KlKZO2Pq4KDsuQz1Uk9tB+sX58ihRrDAaf2sqfKHY3gzU1tj
 aOdgdHQPXUff8vBOAlSOnqQ2hBF7ooQv3cT7Guuu0LMMCdXPUjdHLIK3eWlxYQVZ+P1TM/KULjR
 cXriQfUJN1s2L1SjozrC2Px+M/uDjMIStp8SrRj4NT+xkIcv5YklPZ08bVXMbqCcfWf7wgtlO9n
 hS1Eef3SO+7jmaJZTEjiYnYpmwPfwLolCr11RttB9vF0bmyBoxlKl3znlCq+QKsE9VwgPdmMu8K
 jlvLISFP+hQc0wcZF6guPS05pRf/83HXb9jJZpJI7rOIhnaNqS/UswsUNJwClnYS0e0g7bAdL3z
 LiSVN7jm+NeXp/okm
X-Received: by 2002:a05:6000:26ce:b0:3ee:15b4:8470 with SMTP id
 ffacd0b85a97d-40e4be0c962mr18472473f8f.45.1759238026992; 
 Tue, 30 Sep 2025 06:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0stWe80laMO9K0dNAx9yMp9to1ZAmp75cvF65yUu1FkD7ErgcfXrN9KYbbASkScdYaHyF9w==
X-Received: by 2002:a05:6000:26ce:b0:3ee:15b4:8470 with SMTP id
 ffacd0b85a97d-40e4be0c962mr18472442f8f.45.1759238026517; 
 Tue, 30 Sep 2025 06:13:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc749b8f9sm22267946f8f.50.2025.09.30.06.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:13:45 -0700 (PDT)
Message-ID: <d6049019-e45b-4b65-a55f-be52184e5ff9@redhat.com>
Date: Tue, 30 Sep 2025 15:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] hw/arm/smmuv3: Harden security checks in MMIO
 handlers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-12-tangtao1634@phytium.com.cn>
 <81c98959-45dc-4cbc-836f-a34fdf160801@redhat.com>
 <e43de190-7643-49e1-8e57-0b5f28c33fe9@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e43de190-7643-49e1-8e57-0b5f28c33fe9@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 9/29/25 5:56 PM, Tao Tang wrote:
> Hi Eric,
>
> On 2025/9/29 23:30, Eric Auger wrote:
>> Hi Tao,
>>
>> On 9/25/25 6:26 PM, Tao Tang wrote:
>>> This patch hardens the security validation within the main MMIO
>>> dispatcher functions (smmu_read_mmio and smmu_write_mmio).
>>>
>>> First, accesses to the secure register space are now correctly gated by
>>> whether the SECURE_IMPL feature is enabled in the model. This prevents
>>> guest software from accessing the secure programming interface when
>>> it is
>>> disabled, though some registers are exempt from this check as per the
>>> architecture.
>>>
>>> Second, the check for the input stream's security is made more robust.
>>> It now validates not only the legacy MemTxAttrs.secure bit, but also
>>> the .space field. This brings the SMMU's handling of security spaces
>>> into full alignment with the PE.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>   hw/arm/smmuv3.c | 58
>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 58 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 53c7eff0e3..eec36d5fd2 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1484,6 +1484,12 @@ static bool
>>> smmu_eventq_irq_cfg_writable(SMMUv3State *s,
>>>       return smmu_irq_ctl_evtq_irqen_disabled(s, sec_idx);
>>>   }
>>>   +/* Check if the SMMU hardware itself implements secure state
>>> features */
>>> +static inline bool smmu_hw_secure_implemented(SMMUv3State *s)
>>> +{
>>> +    return FIELD_EX32(s->bank[SMMU_SEC_IDX_S].idr[1], S_IDR1,
>>> SECURE_IMPL);
>>> +}
>>> +
>>>   static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex
>>> sec_idx)
>>>   {
>>>       SMMUState *bs = ARM_SMMU(s);
>>> @@ -1723,6 +1729,43 @@ static int smmuv3_cmdq_consume(SMMUv3State
>>> *s, SMMUSecurityIndex sec_idx)
>>>       return 0;
>>>   }
>>>   +static bool is_secure_impl_exempt_reg(hwaddr offset)
>> Worth a comment: some secure registers can be accessed even if secure HW
>> is not implemented. Returns true if this is the case or something alike.
>
>
> You're right, that function definitely needs a comment to explain the
> architectural exception it handles. I will add one in the next version
> to improve clarity.
>
>>> +{
>>> +    switch (offset) {
>>> +    case A_S_EVENTQ_IRQ_CFG0:
>>> +    case A_S_EVENTQ_IRQ_CFG1:
>>> +    case A_S_EVENTQ_IRQ_CFG2:
>>> +        return true;
>>> +    default:
>>> +        return false;
>>> +    }
>>> +}
>>> +
>>> +/* Helper function for Secure register access validation */
>>> +static bool smmu_check_secure_access(SMMUv3State *s, MemTxAttrs attrs,
>>> +                                     hwaddr offset, bool is_read)
>>> +{   /* Check if the access is secure */
>>> +    if (!(attrs.space == ARMSS_Secure || attrs.space == ARMSS_Root ||
>> First occurence of ARMSS_Root in hw dir? Is it needed?
>
>
> This is a good question, and I'd like to clarify your expectation. My
> thinking was that if we are using ARMSecuritySpace to propagate the
> security context at the device level, then ARMSS_Root will eventually
> be part of this check.
>
> Is your suggestion that I should remove the ARMSS_Root check for now,
> as it's not strictly necessary for the current Secure-state
> implementation, and only re-introduce it when full Realm/Root support
> is added to the SMMU model? I'm happy to do that to keep this patch
> focused.

Well I think I would remove it if not supported anywhere. As an
alternative If we can get this value and if this is definitively not
supported by the code we can assert.

Thanks

Eric
>
> Thanks,
> Tao
>
>>> +          attrs.secure == 1)) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +            "%s: Non-secure %s attempt at offset 0x%" PRIx64 "
>>> (%s)\n",
>>> +            __func__, is_read ? "read" : "write", offset,
>>> +            is_read ? "RAZ" : "WI");
>>> +        return false;
>>> +    }
>>> +
>>> +    /* Check if the secure state is implemented. Some registers are
>>> exempted */
>>> +    /* from this check. */
>>> +    if (!is_secure_impl_exempt_reg(offset) &&
>>> !smmu_hw_secure_implemented(s)) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +            "%s: Secure %s attempt at offset 0x%" PRIx64 ". But
>>> Secure state "
>>> +            "is not implemented (RES0)\n",
>>> +            __func__, is_read ? "read" : "write", offset);
>>> +        return false;
>>> +    }
>>> +    return true;
>>> +}
>>> +
>>>   static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>>>                                  uint64_t data, MemTxAttrs attrs,
>>>                                  SMMUSecurityIndex reg_sec_idx)
>>> @@ -2038,6 +2081,13 @@ static MemTxResult smmu_write_mmio(void
>>> *opaque, hwaddr offset, uint64_t data,
>>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact
>>> aliases */
>>>       offset &= ~0x10000;
>>>       SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
>>> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
>>> +        if (!smmu_check_secure_access(s, attrs, offset, false)) {
>>> +            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
>>> +            return MEMTX_OK;
>>> +        }
>>> +        reg_sec_idx = SMMU_SEC_IDX_S;
>>> +    }
>>>         switch (size) {
>>>       case 8:
>>> @@ -2252,6 +2302,14 @@ static MemTxResult smmu_read_mmio(void
>>> *opaque, hwaddr offset, uint64_t *data,
>>>       /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact
>>> aliases */
>>>       offset &= ~0x10000;
>>>       SMMUSecurityIndex reg_sec_idx = SMMU_SEC_IDX_NS;
>>> +    if (offset >= SMMU_SECURE_BASE_OFFSET) {
>>> +        if (!smmu_check_secure_access(s, attrs, offset, true)) {
>>> +            *data = 0;
>>> +            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
>>> +            return MEMTX_OK;
>>> +        }
>>> +        reg_sec_idx = SMMU_SEC_IDX_S;
>>> +    }
>>>         switch (size) {
>>>       case 8:
>> Thanks
>>
>> Eric
>


