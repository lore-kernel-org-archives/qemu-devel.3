Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184FEC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uByUa-0000j4-5R; Mon, 05 May 2025 12:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uByUY-0000il-4Z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:16:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uByUQ-0006Jd-3L
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:16:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso4856878b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746461779; x=1747066579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CTaCdUmIeV73xmPzDsx1t0Q/XPdcKguN5F8MchSG028=;
 b=W6dcrlj0fZkGsj4j2cIiMpgDConoCXpwzY0u1HYttgMxcRZxrHIxxeinAJY+FoANZ0
 Iz5K4XdKIQc1FHQOMSi6MdXxruLZS2NafWPcdo3MmOQ8afF0yFbyD6bY44BVvKUEMZrs
 vm3vxjf0mVqGE3NfRmI4eeBwsos/c7ctVF4HZUkXD3gmUEq5+JcpA/cS8zENEAer0J/i
 nxGBQLNWbs/BmzoySa5rPvCdeH8+JvwWZI0vf0IIhCUDC4PC7n6wFfppyKtJRrtLh3+m
 f7ZQsDvD2oJMU8kyn+qAZmswib9VoUzLasvbF6O4zLEW+zgoncVRjm3TP2hdBuwD2mc/
 YX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746461779; x=1747066579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTaCdUmIeV73xmPzDsx1t0Q/XPdcKguN5F8MchSG028=;
 b=k698jqYmOg0Av+36q+R/FsP0GbXsXARy3pxLs2QP+jPb3YJDDE5Z47YNpO2lLoZG4S
 GH+BEPebW/R7PyHttMFPacEUHoVQ2K9uZXz0SgHVm4vSQdy9dpfh6nC8+Rno06YTmMTf
 Ofm2B01faei+mkK3VnznTT65zLVTsgSxdMnCsbRHu3ST3rNzWk8VAlV4pHLWyFq6+Z2N
 CvpbDNRtGHKf8peXzq4yTUc5MeekifinfOzLOGEJ2fAHYfbgsjJCidGdwpkvBCt480lT
 AOtODZybWa8bd2u0mLhVJyeN8d1O+81PXflEAKQuIiDm4jsdeuSPu9YBN/wimEpl7DPm
 R8wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdaKuCa5pxtNCIU4ZG6ggsdRFGzB9/aJ1lv0yduhQ2eR2PctTilhd6NZf0EMcxvlxtSiC5xiDj7AAF@nongnu.org
X-Gm-Message-State: AOJu0Yy45zaefyv/q69qiZ/VF3Csfl9ag3vZsdtcGrK2AwpQ787JdnZ4
 eRjIX+5ymySHWjVht9v5HX8NppMf5fLulGJC5lL3fOI8ADCR8qIXAOudfA47FOA=
X-Gm-Gg: ASbGnctpAZ0SwI4m93ctvJrzrh0Duax5UZ5mVa5mj9bC/EUbWNXBtmxsknGvXmsdNNa
 9XC+OKUfWDFpdACEwTrlO367eiTM2bBrI6QLNJjdc8IvH3Zi4kv+Rvo7bdjI2cm2dI5QxiOqcRa
 7TtEducEiH+4EFC/8CuZ/9CnCUdHwm7PKn3NvxkK7Sg+KkGNx1FgnBo65aqD+MN4YtoEApu4uFq
 A23vdTACt0eBJ3GrT3kXvgg063sNpbg3gmWXNWo3w7QFpyPasrb5RHGpZktsn3oOBJXE2KW8uTg
 26QEL2+uechHd+oIPAZhulQv8asDsYborluKkXIRv2AsJ3WMyH9BRHV9yA/+lqFBuPf0oOZH8X1
 EqW27CmM=
X-Google-Smtp-Source: AGHT+IEkO7NEtmeSzaO6GZ08Ie8up/TUhPdl0L0Dr7Ag6SwfxIb/2CDyI7wjO5txwEpyrmPKKeMzsg==
X-Received: by 2002:a05:6a20:cf83:b0:1f5:a3e8:64dd with SMTP id
 adf61e73a8af0-20e94437f30mr14376065637.0.1746461778856; 
 Mon, 05 May 2025 09:16:18 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058db8befsm6940664b3a.40.2025.05.05.09.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:16:18 -0700 (PDT)
Message-ID: <aa4579d9-4e15-409a-9cf9-232b94aa7f7d@linaro.org>
Date: Mon, 5 May 2025 09:16:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target/s390x: Fill in TCGCPUOps.pointer_wrap
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-s390x@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-11-richard.henderson@linaro.org>
 <9aebfbbc-ff29-4af7-8afe-8e0d82c62557@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9aebfbbc-ff29-4af7-8afe-8e0d82c62557@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/25 07:41, Philippe Mathieu-Daudé wrote:
> On 4/5/25 22:57, Richard Henderson wrote:
>> Use the existing wrap_address function.
>>
>> Cc: qemu-s390x@nongnu.org
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/s390x/cpu.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 9c1158ebcc..f05ce317da 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -347,6 +347,14 @@ static TCGTBCPUState s390x_get_tb_cpu_state(CPUState *cs)
>>       };
>>   }
>> +#ifndef CONFIG_USER_ONLY
>> +static vaddr s390_pointer_wrap(CPUState *cs, int mmu_idx,
>> +                               vaddr result, vaddr base)
>> +{
>> +    return wrap_address(cpu_env(cs), result);
>> +}
>> +#endif
>> +
>>   static const TCGCPUOps s390_tcg_ops = {
>>       .mttcg_supported = true,
>>       .precise_smc = true,
>> @@ -367,6 +375,7 @@ static const TCGCPUOps s390_tcg_ops = {
>>       .record_sigbus = s390_cpu_record_sigbus,
>>   #else
>>       .tlb_fill = s390_cpu_tlb_fill,
>> +    .pointer_wrap = s390_pointer_wrap,
> 
> As future cleanup, we might now remove the wrap_address() calls
> in target/s390x/tcg/crypto_helper.c, and target/s390x/tcg/vec_helper.c,
> is that correct?
> 
> Also some uses in target/s390x/tcg/mem_helper.c.

No, not correct.

The new pointer_wrap hook is only used for unaligned accesses that cross page boundaries. 
It does not apply to a sequence of individual accesses like we have in the s390x helpers.


r~

