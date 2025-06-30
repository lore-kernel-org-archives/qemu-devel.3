Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF20C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 17:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWIb3-0000Ef-Ee; Mon, 30 Jun 2025 13:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWIay-0000E0-Li
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:47:10 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWIaw-0000fZ-83
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 13:47:08 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6fb1be9ba89so24275436d6.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751305623; x=1751910423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bt140AnAlmkHb1ONVg+2EfIHe9JNorpfYig6YcLTis4=;
 b=ABtWjPcyA1b/Ri42ZY2Aaa8TIHZRzptEd6g9E6hDPJV4gdyHvS7Hvt2W5/L+XoSqFT
 YP5JQCEpT6qbdOvM+pgCbcCEBq1cvV4iM5eohHiES3/EdhQxZRkfjdFVzNM8bT64tk1f
 B1JuBJqt4NyvDKHQ5SfsndciyRxqX17MGUah1FeFUN3eD6GyhAzXXqNboMo4ibIPzgnL
 so/+yIjoeSwE62gCmLQA18GmawlHpO/rIuOY9GXp4N6w9jx6p4wKANaFBIbj9PM5M7Yh
 wnOevHPgZtxOY67YfzNg1L9W0ESl9E2JOzVccK/z3KqflaUG//SzHTvfenRbjeTVZKxE
 8zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751305623; x=1751910423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt140AnAlmkHb1ONVg+2EfIHe9JNorpfYig6YcLTis4=;
 b=c7zGo5kvaAMZJ4+i3npRGyDz3QEiEUUr1Hz07pdeYIrRS6AGomFoDpXf4BVsjzRRtm
 ryo9tym6U1e5kAqF4mQDvNiTC735v9ZKtJ6AIWALAmdJ36F6ckA0kBg3muVvHB/5WJeU
 sgeyF5ct/vlXiuaHHf2sH8TkKPXoMocTqT8d2e0WfTguJpsR0rnLSJ6TsH/orggxRtRV
 yAjmTPe3gtsc8u8JjrgilSkSEK4Hr+G8IU8TvHkemgfos5WVP93Yq9em4yvd9GTh8CpR
 0rf+bMgextjoQmCpyZ4le9egF4DhtpY/WNfQDJnsFeJUQ6pMluxj+RTzaQx9IY7PjWlu
 t+Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCKxnRmJSF6bEiRoJkK0iBTLqAR7kTrYbAnebWc/K/YousK7JxN2IiozkYvncUKI8N0mqgAuQ2XJnH@nongnu.org
X-Gm-Message-State: AOJu0YyUSuwv9RkB+4s/PuCdFzFWhonJGatFHYUg8ocPIs49+TTS6ZNZ
 4nUh+s+ZI9m7IZh1D/UT5Jm78SvBturEFf0ruAKnmo5hIDZuob+EgTT9DH/34/mJTHc=
X-Gm-Gg: ASbGncsFJk+WrsqMKHP6R06oF1mYLVAHpL5o1T/djQdV5lWEvEtqWkKnYqXfaahwbYj
 hC6ENOUGtb6wRmc3QZdphPBT3xOZZpgllaAlaNO8hfelkMf2MwfMgqLCVLOsVe8VyX7K+rupJDx
 Vdz2LXsbc3JuzmuQ4ES7HbRcb+2P1pEYMy94jSMJLrXCy7TCaF0vJH3Aa5eknOGY1pxe+tnbLj0
 II1wF154ghYM+617Jy7nD4caC5TuaVTI9dr8cjPPkbO/fSiJN/ZH19BuCD7xjQMtNkcvSxqBaBo
 zf+6GEbGOZyaCUCKT2MjsRkH/pX/mo0QUUGqzwTKqaHyOqWKh1vnByEgki64Qmo3mfmJ59qEGgs
 =
X-Google-Smtp-Source: AGHT+IE1Ufk3p4am7QoyJcXpZilxz1tEwepWme1U7t6HEg4s3G9BkL+6zNFQ6mAlUoH93i2Vt67/SQ==
X-Received: by 2002:ad4:4ee2:0:b0:6fd:d91:ba28 with SMTP id
 6a1803df08f44-70002ee6d21mr177388056d6.41.1751305623355; 
 Mon, 30 Jun 2025 10:47:03 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd771abd15sm72244346d6.29.2025.06.30.10.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 10:47:02 -0700 (PDT)
Message-ID: <26d4e4de-d7fc-410c-a1cd-d86de538b70f@ventanamicro.com>
Date: Mon, 30 Jun 2025 14:46:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hmp-cmds-target, target/riscv: add 'info register'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250630132228.1276838-1-dbarboza@ventanamicro.com>
 <be01b414-f30f-4ca5-a515-94a60187e8e6@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <be01b414-f30f-4ca5-a515-94a60187e8e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf2d.google.com
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



On 6/30/25 1:00 PM, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 30/6/25 15:22, Daniel Henrique Barboza wrote:
>> The RISC-V target has *a lot* of CPU registers, with more registers
>> being added along the way when new extensions are added. In this world,
>> 'info registers' will throw a wall of text that can be annoying to deal
>> with when the user wants to verify the value of just a couple of
>> registers.
>>
>> Add a new 'info register' HMP command that prints a specific register.
>> The semantics, and implementation, is similar to what 'info registers'
>> already does, i.e. '-a' will print a register for all VCPUs and it's
>> possible to print a reg for a specific VCPU.
>>
>> A RISC-V implementation is included via riscv_cpu_dump_register().
>>
>> Here's an example:
>>
>> Welcome to Buildroot
>> buildroot login: QEMU 10.0.50 monitor - type 'help' for more information
>> (qemu) info register mstatus
>>
>> CPU#0
>>   mstatus  0000000a000000a0
>> (qemu) info register mstatus -a
>>
>> CPU#0
>>   mstatus  0000000a000000a0
>>
>> CPU#1
>>   mstatus  0000000a000000a0
>> (qemu)
>>
>> The API is introduced as TARGET_RISCV only.
>>
>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hmp-commands-info.hx         | 17 +++++++++++++
>>   hw/core/cpu-common.c         |  8 ++++++
>>   include/hw/core/cpu.h        | 11 +++++++++
>>   include/monitor/hmp-target.h |  1 +
>>   monitor/hmp-cmds-target.c    | 30 ++++++++++++++++++++++
>>   target/riscv/cpu.c           | 48 ++++++++++++++++++++++++++++++++++++
>>   6 files changed, 115 insertions(+)
>>
>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>> index 639a450ee5..f3561e4a02 100644
>> --- a/hmp-commands-info.hx
>> +++ b/hmp-commands-info.hx
>> @@ -113,6 +113,23 @@ SRST
>>       Show the cpu registers.
>>   ERST
>> +#if defined(TARGET_RISCV)
> 
> Just make this command available for all targets, displaying
> "No such register" or better when no handler registered.

What about "<targe-name> does not support this command" ?


> 
>> +    {
>> +        .name       = "register",
>> +        .args_type  = "register:s,cpustate_all:-a,vcpu:i?",
>> +        .params     = "[register|-a|vcpu]",
>> +        .help       = "show a cpu register (-a: show the register value for all cpus;"
>> +                      " vcpu: specific vCPU to query; show the current CPU's register if"
>> +                      " no vcpu is specified)",
> 
> I'd invert the default behavior: dump for all vcpus except if a specific
> one is specified.

Fair enough.

> 
> I wonder about a 'info register -h' do list all register names available.

That's a neat idea. I'll see what I can do.


Thanks,

Daniel

> 
>> +        .cmd        = hmp_info_register,
>> +    },
>> +
>> +SRST
>> +  ``info register``
>> +    Show a cpu register.
>> +ERST
>> +#endif
> 
> Regards,
> 
> Phil.


