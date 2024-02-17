Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33643C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 09:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbGh4-0000lx-Uj; Sat, 17 Feb 2024 04:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rbGh3-0000le-3w
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:09:09 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rbGgx-0005TA-Q6
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 04:09:08 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-59f786b2b59so1321288eaf.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 01:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1708160942; x=1708765742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OUPRFafdu1pnm8k3a5iqOvAeWByKXJpU9624AlGP1FQ=;
 b=VMj+bjkuC2mu0f1hZZHbQ9r+abP4HuUG9QHuWedW/uciEez0XxTwTuLquLvYKP7ATZ
 6YmLkZYqdjW/v5x4jlwftbLQhqxlYowU1iDL9A6ujjWrc5xPP42+z9kWCji8fyKoB4Rb
 KbsQ0W7spme6rVqQ1JPQ8zd3TzdlUCSHbx8ZMHZi/DtW1LmTEv6Gs802rRtMilpIYFu2
 qXPsOzCWQVdjAqZLNtUzCG7wF9i+Ul9sHoJOoa0e8Bm+9pbWjanrfadgTg7lnMaqrrV6
 VAskfmJP6d6ZqT/AKpTymOI5kGs7BcrXdNpCAyIWcmc3Uez//tMnsdAx4O52ftAiVPBo
 Ttkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708160942; x=1708765742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OUPRFafdu1pnm8k3a5iqOvAeWByKXJpU9624AlGP1FQ=;
 b=uZVz9h/Yy7m2X5p7SzCBVmNEX2oXKPyb7gfM2AUUtFe/E8BhsXuVQfzHlqF4IZIF3S
 b33Uvz949ucUPyTphqZHYiWVF+e7pDCQ/mG5UERD46Azz3QUXoGWD7InJH5yd3w/sUAO
 V1IMLlZ7qO29RnxdBhjDzWQ8mYKXaBQV6ErHzY8/n+KXcknjZyonODWbC6XE3fRVRsWB
 npGmuFQkT/L+jLTh/NIg9RoxqwA88CzegAH3/ZFQdDWqgOQ6zyHDC9YTzTDImA3v5E5n
 ISpOnk0qtIzKuvuk34h3Qzngdca17e7bcc5K+abNGPRn2ytww15Wladm38ftPO6TW7le
 z+bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5tItCH0FiXV+NHsgw+p/7aJO69aRf99VH3qeCVSG4Vz7MlFcWwwxw+/QkikMNDBd65l5IJhhCnrADJEkc55XGQ1ZUKkQ=
X-Gm-Message-State: AOJu0YzG+U1y6u7Rv2iPcNWigXeGXELBa8cOtYp3acGIAdQ1r7GAjWpo
 yOG2/1V3fq78us0xqOqJCHIvB5A5RPofScJ4WJJPPNXeIlVnxwkmYWhW/I8++Ps=
X-Google-Smtp-Source: AGHT+IHplEMYsKg98eaqgsyMZmSbCUP9e3zY/nokBsjZYAm1lbTqs8jAQNZNNm60D6ZQKRe9S2JF5Q==
X-Received: by 2002:a05:6358:8aa:b0:176:5c73:393b with SMTP id
 m42-20020a05635808aa00b001765c73393bmr8397139rwj.18.1708160942017; 
 Sat, 17 Feb 2024 01:09:02 -0800 (PST)
Received: from [100.64.0.1] ([136.226.240.197])
 by smtp.gmail.com with ESMTPSA id
 v9-20020aa78089000000b006e13a88d52esm1228777pff.61.2024.02.17.01.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 01:09:01 -0800 (PST)
Message-ID: <0d5cbc01-a121-ab44-a8f0-4fe99e03fb20@sifive.com>
Date: Sat, 17 Feb 2024 17:08:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 2/6] accel/tcg: Avoid uncessary call overhead from
 qemu_plugin_vcpu_mem_cb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-3-max.chou@sifive.com>
 <0d95525a-8307-4c89-9045-68130b44f095@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <0d95525a-8307-4c89-9045-68130b44f095@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=max.chou@sifive.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.399,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

Thank you for the suggestion. I'll do a v2 with this.

Thanks,
Max

On 2024/2/16 4:03 AM, Richard Henderson wrote:
> On 2/15/24 09:28, Max Chou wrote:
>> If there are not any QEMU plugin memory callback functions, checking
>> before calling the qemu_plugin_vcpu_mem_cb function can reduce the
>> function call overhead.
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>>   accel/tcg/ldst_common.c.inc | 40 +++++++++++++++++++++++++++----------
>>   1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
>> index c82048e377e..bf24986c562 100644
>> --- a/accel/tcg/ldst_common.c.inc
>> +++ b/accel/tcg/ldst_common.c.inc
>> @@ -134,7 +134,9 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr 
>> addr, MemOpIdx oi, uintptr_t ra)
>>         tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
>>       ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
>> -    plugin_load_cb(env, addr, oi);
>> +    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
>> +        plugin_load_cb(env, addr, oi);
>> +    }
>>       return ret;
>>   }
>
> Rather than repeating N times, modify plugin_load_cb and 
> plugin_store_cb just above to avoid the call to 
> cpu_plugin_mem_cbs_enabled().  I expect the compiler is inlining those 
> functions already.
>
>
> r~

