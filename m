Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBEEC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJoox-00023A-LO; Tue, 27 May 2025 03:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJoow-000230-MN
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:33:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJoon-00077p-0U
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:33:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a35c894313so2984373f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748331224; x=1748936024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qtx6hs3oMoJyKfla6vTtXDeD5yxOX/zNXnxSsXN/A8A=;
 b=ynTAcDGZ0jdRv+UdEuzf6Rp8AJ+j0LswnvZgiouzrHaWXNAIp9Bj4g9l+cvs8z/SYG
 bm5oiWP/m1mMcL1yao3qzQSewPYkG8M94OT5Po/B4I6WgvN5HstpkSjrR8wGOLggEpyQ
 EK8xdhxjAl8115c8zPTA78CU234a5Nfk94aRNnHyx4dge1rZpu+U6W8YZVHVbaI86qDs
 9C7s3LGN/LcV0+1PRqA++s7plc2wj29enDtSSFVaT7DOO0XkmJrz7zrFZOjOBhNmfAG5
 H3FQW8Jwpc6nbjypBWL7KhmgjjQue53Ez2WgegQkYTXU21z0BPLIOFPrnu7p8B4I8MyY
 ddzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748331224; x=1748936024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qtx6hs3oMoJyKfla6vTtXDeD5yxOX/zNXnxSsXN/A8A=;
 b=wD0gJfQadXvUYrZqITT7MCylezwRlMUt9fdg/8ccGAOFVozsybVDpDZBeN5HOfgaRv
 2Yk9HU49oNKH7qhm/7BwBO6g1qf8oj/C5ZJFY7BxVFALxW1/2utBqv6FMkZXq6UhmkRR
 CDZuSo1YWWyljmH3+wXtZi+R/M3MWiZxFA6iIZobXu3TeHppVniUARg3vNbqx+ELKk01
 j7NSVgVgI5aAI8KHDUmRNe35XyUD5++yVcJ2eY9gPhyv6xdZnWPuUESNCI/rhqU4pZWp
 OTlBTs3dMSuVlv4pMk9y07O+kRp+oHlvqqhfBT2oj0m+BPRptESwWc2FCvKznkjynhLC
 0Y1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI5PZeRd18Q35GNza8g9wAXEwaX8iNLcWXRpROL14/RYT94HLJqGOyMayLf6ekiNgA9fv7e9Sp4XAm@nongnu.org
X-Gm-Message-State: AOJu0YzFiUrjTwy08ixSw0VT6iFmiXr+T+VcIbNBhYJlHsrcvgk4P/e9
 kPYn+blNfXPhXjlg2w8i8svmi166+L6dlwyX5BCr5/KdydQVGy1iDvKMmzSHtayYqQY=
X-Gm-Gg: ASbGncsPOVvBnJLudf4l0xScqPt2afA3cJZ4lIr3N4sO9RODjCYa5naBH+NZ5yeS+ku
 nbfizUTO85OH39N1dKOQ+EAvxL8wXPb59u+OLsiQKnRXiR4kdKqj3O9zq05E63wSVg0ovAyJpvd
 Kgsnm/OO7un7l2Et7beJosSorf59UjdTGd05HN324yqtDoR6sD7tAIHUb46cM/rwQNx1CKP+SUI
 jtuk9ViqZT/PMWVsaQzHemzEvYLbHpOjeHJW2xmMmsNFUh+Iayijh3XCu65+oiX2REGKHgTo+aX
 TMRiEqrsumrIxT2LMnesEIKdqCWr1bHSqfovC9wAoG0eBWBEVquKuGZjncKsh9AgUg==
X-Google-Smtp-Source: AGHT+IFzrHAT7O/1U9vrbNqPmWZgHUYuri2sMq+uvO6Vodm++3vULWIZPM8XjBS/ZasbiNjQwFeS+Q==
X-Received: by 2002:a05:6000:2481:b0:3a4:d738:f98c with SMTP id
 ffacd0b85a97d-3a4d738fb73mr4772965f8f.30.1748331223820; 
 Tue, 27 May 2025 00:33:43 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d47c0684sm6706179f8f.44.2025.05.27.00.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 00:33:43 -0700 (PDT)
Message-ID: <ae9e0a75-bafe-4d66-a8f2-9c3371315279@linaro.org>
Date: Tue, 27 May 2025 08:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] target/arm: Fill in TCGCPUOps.pointer_wrap
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-5-richard.henderson@linaro.org>
 <e8176be8-dbe9-4cf4-a23c-a6100d530c0b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e8176be8-dbe9-4cf4-a23c-a6100d530c0b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/26/25 19:21, Philippe Mathieu-Daudé wrote:
> +Gustavo
> 
> On 4/5/25 22:57, Richard Henderson wrote:
>> For a-profile, check A32 vs A64 state.
>> For m-profile, use cpu_pointer_wrap_uint32.
>>
>> Cc: qemu-arm@nongnu.org
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/cpu.c         | 24 ++++++++++++++++++++++++
>>   target/arm/tcg/cpu-v7m.c |  1 +
>>   2 files changed, 25 insertions(+)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 45cb6fd7ee..18edcf49c6 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -2710,6 +2710,29 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
>>   #endif
>>   #ifdef CONFIG_TCG
>> +#ifndef CONFIG_USER_ONLY
>> +static vaddr aprofile_pointer_wrap(CPUState *cs, int mmu_idx,
>> +                                   vaddr result, vaddr base)
>> +{
>> +    /*
>> +     * The Stage2 and Phys indexes are only used for ptw on arm32,
>> +     * and all pte's are aligned, so we never produce a wrap for these.
>> +     * Double check that we're not truncating a 40-bit physical address.
>> +     */
>> +    assert((unsigned)mmu_idx < (ARMMMUIdx_Stage2_S & ARM_MMU_IDX_COREIDX_MASK));
>> +
>> +    if (!is_a64(cpu_env(cs))) {
>> +        return (uint32_t)result;
>> +    }
>> +
>> +    /*
>> +     * TODO: For FEAT_CPA2, decide how to we want to resolve
>> +     * Unpredictable_CPACHECK in AddressIncrement.
>> +     */
>> +    return result;
>> +}
>> +#endif /* !CONFIG_USER_ONLY */
>> +
>>   static const TCGCPUOps arm_tcg_ops = {
>>       .mttcg_supported = true,
>>       /* ARM processors have a weak memory model */
>> @@ -2729,6 +2752,7 @@ static const TCGCPUOps arm_tcg_ops = {
>>       .untagged_addr = aarch64_untagged_addr,
>>   #else
>>       .tlb_fill_align = arm_cpu_tlb_fill_align,
>> +    .pointer_wrap = aprofile_pointer_wrap,
> 
> IIUC this is also used by non A-profiles (R-profiles and
> non Cortex cores).

Yes, r-profile is mostly a-profile.  Those non-cortex cores are also a-profile: armv[456].

The point is the separation between m-profile and not. In particular, the mmu indexes are 
different between A and M (see ARM_MMU_IDX_TYPE_MASK). The assert would not be valid for 
m-profile. We can avoid a check vs ARM_FEATURE_M by only using this function for 
not-m-profile.


r~

