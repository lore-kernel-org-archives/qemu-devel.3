Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FDF10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVk-0004Gv-4k; Wed, 08 Apr 2026 15:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAY51-0006fj-N8
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOaA-0004T0-35
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:48:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso50933065e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775638096; x=1776242896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvzBA4OHOr7PmSM301GToLUSw3BYcg9F+hkpHOOTPZM=;
 b=eFvAesbwk4LVUqtoBZ5OSDDv0DawfJ0vjXBJBNhO+Dnkb/4oagO0w4/mCvSeOpHeoL
 J/SSOvYL4ROW+jZuqZwP9AauPl9Y3rJeN2cB4Z4zU+DjW2kPJ4JUxlqbnT7RlE7h/Kub
 BHGW2wWHJzhvrAhXv3/dk190AGKBzkJa/XRfGm/Y+4HIk6sbsNtPYUVos/66yiQvztny
 GQRh5/SMwPq9ZE3IxL1UKZuXowYR5+XTK10HDisusvQOPaAWYQqeVLNlLbQE56RaAR5Q
 7MWtY2uTLpyZfe1SedpdC3dyD8HjcltIV0BpJQSjWYDKFk1++qDD5JuhJfmMovYAIVV/
 Q7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775638096; x=1776242896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dvzBA4OHOr7PmSM301GToLUSw3BYcg9F+hkpHOOTPZM=;
 b=e4a7m8WXsR9LtPSr6xIbn7TKx2XTryCgQWcyl92mzetEWG/cYTt6x3X/oVw5o8K+A2
 a+b2IioFlNV3ubFrAhg1viQeerIjZmvCn4H9nuMsGX221EbY0uCxJwzZAGTUCttMLRDK
 9ap3N//v/hwf2TYxgLbiPm48bV16efynRIDRZYHieYHEerZZ4D54Xhidr/mXjWTV0SnR
 BufS5MH/XfgrMwkzaENbzeZofYuP1rkkvG71a028slsjFp75sE6bEWgXxZN7+z8jYWql
 YLadfbJybbV8j1mYydQdEZr8i3t0EpUPOts7uzz1KuX560U1vhXH8A+Rl63kez71hjRS
 6n6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvrQazq36Ve8jGHn1Fqx/pdPwscCUaw/rYNyS50SwZ6alJ2nQ6xMasnrbV5SJpZQU/XrGxr9Y5tuUw@nongnu.org
X-Gm-Message-State: AOJu0Yw1RPfFlVNq1/r6OxU4QtQxLrHkHU1ke+hCoe69goTqKOROl1l5
 26tfuPHifNNPmF+oEaHxBF5iRzOqWiMqfIPfdF0n/BLzED4HetU+s3RQmCRwgDBCJQ0=
X-Gm-Gg: AeBDiethm/IlPkrFPLTVKToxHmaA//mifeELnDIMO2KCGQTGZQcWXqkeTjXgTfD9s6c
 0rZh+mCMYWjCEJFsQIWwJb3IfrOGycB9R9SxdhwpFqj291Y8HEvbTuEUcwjH3oYbz4jd0VTB/YN
 eUYCIG4zkvQBVn9nIEEI4XdVBlDTBXNFKoQsO2IhCM7sLW6jy47NhNMOfYynoZSOthB5nyLmdWH
 iZyFWrixrboHXeTuNpXUnNW9FXqZYk3qZxt5PVeXvIcm4BgFkLd4/8YCiqVrfjAV3x6XTLqNiqw
 syXa7YV1zOI4nrfhtRHoSZ7iYZhzBh9NYLr0IfYOg/YNPGr+C/aowqfwmiJlFtw4u08QpfubTKn
 JZXd+nvxk2ESs/cA26LuOHvBh0XDYzzApdq3vVCxtAcF6cBwh7J4gScSCZM1Iz9Vcmtbt+XSeg1
 /wfYfC9Ye9r8gIDU5zf/WAvJV6Okl0l/O69jMEcybOJMGy7XHro7/EkZ1F768krD9Zzq8Tvbsb4
 QXA
X-Received: by 2002:a05:600c:15d2:b0:488:a14d:3d81 with SMTP id
 5b1f17b1804b1-488a14d3ef0mr133441035e9.2.1775638096351; 
 Wed, 08 Apr 2026 01:48:16 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e822227sm700158125e9.4.2026.04.08.01.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:48:15 -0700 (PDT)
Message-ID: <09cf72c9-7333-4f1f-bb2a-bc88b668b294@linaro.org>
Date: Wed, 8 Apr 2026 10:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
 <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/4/26 11:38, Daniel Henrique Barboza wrote:
> 
> 
> On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> The RISC-V spec states:
>>
>> "For the purposes of memory protection, a failed SC.W may be treated
>> like a store."
>>
>> So if the comparison in sc.w fails we should still check for alignment
>> and do a probe access to check permissions.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
>> Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
> 
> Typo: "Resoves"
> 
> 
> Also, IIRC the bug URL that automatically closes Gitlab issues when
> merging the patch is on the format:
> 
> "Resolves: https://gitlab.com/qemu-project/qemu/-/issues/(number)"
> 
> 
> Maybe this URL with "work_items" also works, but even with the regular
> URL Gitlab fails to autoclose the bug sometimes.  I suggest changing the
> "work_items" to "issues" in all those URLs to be safe.

FWIW I concur :)

> 
> 
> That said,
> 
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/helper.h                   |  3 +++
>>   target/riscv/op_helper.c                | 14 ++++++++++++++
>>   target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>> index b785456ee0..af6cfcfc27 100644
>> --- a/target/riscv/helper.h
>> +++ b/target/riscv/helper.h
>> @@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>>   #ifndef CONFIG_USER_ONLY
>>   DEF_HELPER_1(ssamoswap_disabled, void, env)
>>   #endif
>> +
>> +/* Zalrsc" SC write probe */
>> +DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>> index 6ccc127c30..b569366369 100644
>> --- a/target/riscv/op_helper.c
>> +++ b/target/riscv/op_helper.c
>> @@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, 
>> target_ulong address)
>>       /* We don't emulate the cache-hierarchy, so we're done. */
>>   }
>> +void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
>> +                           target_ulong size)

We could directly use uint64_t for @size. Then after the release the
@addr argument will be converted to vaddr type [*]. We could do that
directly now:


DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, vaddr, i64)

void helper_sc_probe_write(CPURISCVState *env, vaddr addr,
                            uint64_t size)


[*] 
https://lore.kernel.org/qemu-devel/20260401143456.79843-1-philmd@linaro.org/

>> +{
>> +    uintptr_t ra = GETPC();
>> +    int mmu_idx = riscv_env_mmu_index(env, false);
>> +
>> +    if (addr & (size - 1)) {
>> +        env->badaddr = addr;
>> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
>> +    }
>> +
>> +    probe_write(env, addr, size, mmu_idx, ra);
>> +}

