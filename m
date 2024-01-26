Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7C5C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMbI-0000Ec-W7; Fri, 26 Jan 2024 08:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTMbF-0000BI-QN
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:50:30 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTMbB-0004aV-Fj
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:50:29 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3394dc2ae23so572093f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706277024; x=1706881824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RExDWECEv/iJcIdwKdXdTPrWBVUdsgQpfNmCXH9YCJI=;
 b=luj8x8q24nim3ybd0ZTnUCgTH8vP90E46UnIXERx99K6D/B5Qa6OKbNJTUg71TMnGZ
 B9jBfVYhXd3jW6hWTUewDGGOfoLqhaSTlvLoCqOdBLQXJ96I1CYiIIlYGV6OI7JtPE57
 q8mNbYvgR2LbdidgxwbpDwShhzbuGF8JWdjRdnefrdU8o/VmJx35pIZbYZGFWi+0ErCf
 2YYt2IFTqZ7vMzxakVcrNhaLY6rUFZ4bxy4IXzddiLBq9xhpXWpvfzOW2iG+BsfWjze+
 WcFqRCxQiDPjTX2Ip/PkgMSTaZNKVH1unFrxwrB41IpOwCRzEpo0iFs4WxT5L6Z1ThYI
 XI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706277024; x=1706881824;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RExDWECEv/iJcIdwKdXdTPrWBVUdsgQpfNmCXH9YCJI=;
 b=WnA75e92UR86/b45ayIIDVi78x6QaSupKfvGzPdmVeMMHwsGtF/1FsADs3qU/0ZhZC
 feH2dBN5CghttcsB87mZjpbYnAJAimFN0XC6F5tm9YZDlbhs/Xj/U+pWfMNM7p9xIWEZ
 bPBs/9YNUM8T3ds7S6VM28aEGPFKG7f8XihCX15q22Bd59ZXiOyPBpLCFG5YwgZDv9Xs
 KXPMdsaAIdkYrf6r+0s5Lh8M9DZZRGkaC+42v1gvUlfgo6K0oyHvO3uDMOjhty2sgRwQ
 T7Q5KFoUcZX+ZYHRO8PeWcxfqEBtv9y/DAEyrFY2zjooU1Nd82QrKz2nP2g47hqesIoL
 jKEw==
X-Gm-Message-State: AOJu0Yy/DlAhrEZLG5s0IBJSH5RphcoWTw4OMnr0VRVYd6gaSMwrbRdM
 +BDYL29I56Zm6elSRp6yJo3/jyrdCzG/hh1dG+cpyzCnrvfcGAabd8n2sB4s0fY=
X-Google-Smtp-Source: AGHT+IEXtEivQRbIxdZYsknPBDgHVxf9bUzHseOJ0PylVUZl+C+LlTvZTfKiewdCxKxhK+mnZrxlcA==
X-Received: by 2002:a5d:4050:0:b0:337:c0de:1f70 with SMTP id
 w16-20020a5d4050000000b00337c0de1f70mr690609wrp.41.1706277023620; 
 Fri, 26 Jan 2024 05:50:23 -0800 (PST)
Received: from [192.168.69.100] ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a5d6288000000b00337be3b02aasm1315839wru.100.2024.01.26.05.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 05:50:23 -0800 (PST)
Message-ID: <2936a022-5c95-4527-8132-8db1439a9bd3@linaro.org>
Date: Fri, 26 Jan 2024 14:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts/coccinelle: Add cpu_env.cocci_template script
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20240125165648.49898-1-philmd@linaro.org>
 <20240125165648.49898-2-philmd@linaro.org>
 <1128019c-adca-4cd4-aa73-937001ad990a@linaro.org>
 <CABgObfZuPwzVdPjgeLOOtjmNqUMGcK=ExsvVQOzLqnUABmmX-A@mail.gmail.com>
 <d739d778-c84e-4c72-bf55-21d4aa562d96@linaro.org>
In-Reply-To: <d739d778-c84e-4c72-bf55-21d4aa562d96@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/1/24 13:34, Philippe Mathieu-Daudé wrote:
> On 26/1/24 12:24, Paolo Bonzini wrote:
>> On Fri, Jan 26, 2024 at 11:38 AM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> On 25/1/24 17:56, Philippe Mathieu-Daudé wrote:
>>>> Add a Coccinelle script to convert the following slow path
>>>> (due to the QOM cast macro):
>>>>
>>>>     &ARCH_CPU(..)->env
>>>>
>>>> to the following fast path:
>>>>
>>>>     cpu_env(..)
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    MAINTAINERS                               |  1 +
>>>>    scripts/coccinelle/cpu_env.cocci_template | 60 
>>>> +++++++++++++++++++++++
>>>>    2 files changed, 61 insertions(+)
>>>>    create mode 100644 scripts/coccinelle/cpu_env.cocci_template
>>>
>>>
>>>> diff --git a/scripts/coccinelle/cpu_env.cocci_template 
>>>> b/scripts/coccinelle/cpu_env.cocci_template
>>>> new file mode 100644
>>>> index 0000000000..53aa3a1fea
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/cpu_env.cocci_template
>>>> @@ -0,0 +1,60 @@
>>>> +/*
>>>> +
>>>> + Convert &ARCH_CPU(..)->env to use cpu_env(..).
>>>> +
>>>> + Rationale: ARCH_CPU() might be slow, being a QOM cast macro.
>>>> +            cpu_env() is its fast equivalent.
>>>> +
>>>> + SPDX-License-Identifier: GPL-2.0-or-later
>>>> + SPDX-FileCopyrightText: Linaro Ltd 2024
>>>> + SPDX-FileContributor: Philippe Mathieu-Daudé
>>>> +
>>>> + Usage as of v8.2.0:
>>>> +
>>>> + $ for targetdir in target/*; do test -d $targetdir || continue; \
>>>> +       export target=${targetdir:7}; \
>>>> +       sed \
>>>> +           -e "s/__CPUArchState__/$( \
>>>> +               git grep -h --no-line-number '@env: #CPU.*State' \
>>>> +                   target/$target/cpu.h \
>>>> +               | sed -n -e 's/.*\(CPU.*State\).\?/\1/p')/g" \
>>>> +           -e "s/__ARCHCPU__/$( \
>>>> +               git grep -h --no-line-number 
>>>> OBJECT_DECLARE_CPU_TYPE.*CPU \
>>>> +                   target/$target/cpu-qom.h \
>>>> +               | sed -n -e 's/.*(\(.*\), .*, .*)/\1/p')/g" \
>>>> +           -e "s/__ARCH_CPU__/$( \
>>>> +               git grep -h --no-line-number 
>>>> OBJECT_DECLARE_CPU_TYPE.*CPU \
>>>> +                   target/$target/cpu-qom.h \
>>>> +               | sed -n -e 's/.*(.*, .*, \(.*\))/\1/p')/g" \
>>>> +       < scripts/coccinelle/cpu_env.cocci_template \
>>>> +       > $TMPDIR/cpu_env_$target.cocci; \
>>>> +       for dir in hw target/$target; do \
>>>> +           spatch --macro-file scripts/cocci-macro-file.h \
>>>> +                  --sp-file $TMPDIR/cpu_env_$target.cocci \
>>>> +                  --keep-comments \
>>>> +                  --dir $dir \
>>>> +                  --in-place; \
>>>> +       done; \
>>>> +   done
>>>> +
>>>> +*/
>>>> +
>>>> +@ CPUState_arg_used @
>>>> +CPUState *cs;
>>>> +identifier cpu;
>>>> +identifier env;
>>>> +@@
>>>> +-   __ARCHCPU__ *cpu = __ARCH_CPU__(cs);
>>>
>>> Here we remove ARCH_CPU(), ...
>>>
>>>> +-   __CPUArchState__ *env = &cpu->env;
>>>> ++   __CPUArchState__ *env = cpu_env(cs);
>>>> +    ... when != cpu
>>>> +
>>>> +@ depends on never CPUState_arg_used @
>>>> +identifier obj;
>>>> +identifier cpu;
>>>> +identifier env;
>>>> +@@
>>>> +-   __ARCHCPU__ *cpu = __ARCH_CPU__(obj);
>>>> +-   __CPUArchState__ *env = &cpu->env;
>>>> ++   __CPUArchState__ *env = cpu_env(CPU(obj));
>>>
>>> ... but here we just change it by a CPU() QOM call.
>>> So this 2nd change is just style cleanup.
>>
>> Can you also add a hunk that is
>>
>> CPUState *cs;
>> @@
>> -  CPU(cs)
>> + cs
>>
>> to clean up on the second?  cpu_env(CPU(current_cpu)) is suboptimal
>> and also a bit ugly.
> 
> These case should be cleaned because this is already a CPUState*:
> 
> +    CPUX86State *env = cpu_env(CPU(current_cpu));
> 
> +    CPUPPCState *env = cpu_env(CPU(first_cpu));
> 
> But these (instance_init and QOM visitors) can't, the argument
> isn't a CPUState*:
> 
>   static void ev4_cpu_initfn(Object *obj)
>   {
> -    AlphaCPU *cpu = ALPHA_CPU(obj);
> -    CPUAlphaState *env = &cpu->env;
> +    CPUAlphaState *env = cpu_env(CPU(obj));
> 
> @@ -5186,8 +5179,7 @@ static char *x86_cpuid_get_vendor(Object *obj, 
> Error **errp)
>   static void x86_cpuid_set_vendor(Object *obj, const char *value,
>                                    Error **errp)
>   {
> -    X86CPU *cpu = X86_CPU(obj);
> -    CPUX86State *env = &cpu->env;
> +    CPUX86State *env = cpu_env(CPU(obj));
> 
> That said, these visitors take a Object* param because they implement
> the generic QOM visitor API, but we know the visitor are registered
> on classes/objects implementing CPUState, so QOM cast macro is
> redundant.

Bah actually for CPU() this is not a problem, per commit 0d6d1ab499
("cpu: Avoid QOM casts for CPU()") you suggested :)

     Keep the CPU() macro for a consistent developer experience and for
     flexibility to exchange its implementation, but turn it into a pure,
     unchecked C cast for now.


