Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5101AC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLQH-0007Ig-VW; Fri, 26 Jan 2024 07:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTLQF-0007HV-98
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:35:03 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTLQC-00018D-R4
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:35:02 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e76626170so4765415e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 04:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706272499; x=1706877299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gnw9dE/qole01E/zaRh07r7pSbqRWG5R2vAhV/iCxTA=;
 b=AMrRTyjRdxA/xQtvnd9uXtBgCTPYqDc3AxgMSn8JzxvTmDly9pc9VjFwEQKLazaD3I
 7SyHKoVKLPPzbf5Sq4WE4I6uarMzQ0GVjFLQk/EYHtMA9tbBXtguDCR2H4oP7k3CFlvK
 lpV77ioOb+UNI/lvAGLuIZZwG3NyFXT1bQNUwE5jBV4pY+yzzfdrzRB2nHgnJ+3gaMM4
 St9S8FeT/K7WOYfV6MTtiwbchLajJXgREIMXQOMkyu7AWGh18sdwDLsHRg0kJmKfiC98
 6uNg/c3xK2nqIVAS9IJH3+fDMVB4cEQ1dAroQjneWyJqTMh6KNjAj8JkBZ8xh13Ju9jG
 wJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706272499; x=1706877299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gnw9dE/qole01E/zaRh07r7pSbqRWG5R2vAhV/iCxTA=;
 b=X7bYxfyssnND9Ebf9+44UhK8ueehQhx1P24v5x101txKoT/eFwRT9cny1FbqevxJWm
 1/RP1LpaknBp8iZhMv1DemLkAhQqyn6abgGtbufBz8xVbj79UlkVndKVkWxGtcieoMy0
 nNJYqSuwdFL90C1QdXEQHlCEbhwhTTtlhlvDBQdSR0EoWqgVktU5nSTtFVuO2LZSrTJ5
 n+OBZAKpkJSt2FC9Q2ZSmsoAs4uUyTW6v0QWvI7Tyi03z0WeLg3eLofwH897517TPd4l
 It/Ab4xuuNqIfldFLY6QW+3pzBiFxw/A79FHs+kwXz31i3LFnb3BCfatYwnAkFDpmsXF
 DBZQ==
X-Gm-Message-State: AOJu0YwBhkRS2bpwh2EjCbRo/CNjLOh6AyI2BwApF25cCrbOPyiDmrSs
 nkLB+Jppk7iYd+aiaVxz3R1quWYn8GJwOma4GJMpHP8HQ6+dMYRXeo7PdA0TaQE=
X-Google-Smtp-Source: AGHT+IFb1Dh6nvR5vA2rw0cagWGL6rCaklfAD0plWhnLxeIn8Vx61sgM3FYm/VDvhxrfucmQkpTzFw==
X-Received: by 2002:a05:600c:a41:b0:40e:b274:e80b with SMTP id
 c1-20020a05600c0a4100b0040eb274e80bmr859583wmq.94.1706272499123; 
 Fri, 26 Jan 2024 04:34:59 -0800 (PST)
Received: from [192.168.69.100] ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600c450500b0040e9d507424sm1773106wmo.5.2024.01.26.04.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 04:34:58 -0800 (PST)
Message-ID: <d739d778-c84e-4c72-bf55-21d4aa562d96@linaro.org>
Date: Fri, 26 Jan 2024 13:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scripts/coccinelle: Add cpu_env.cocci_template script
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZuPwzVdPjgeLOOtjmNqUMGcK=ExsvVQOzLqnUABmmX-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 26/1/24 12:24, Paolo Bonzini wrote:
> On Fri, Jan 26, 2024 at 11:38 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 25/1/24 17:56, Philippe Mathieu-Daudé wrote:
>>> Add a Coccinelle script to convert the following slow path
>>> (due to the QOM cast macro):
>>>
>>>     &ARCH_CPU(..)->env
>>>
>>> to the following fast path:
>>>
>>>     cpu_env(..)
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    MAINTAINERS                               |  1 +
>>>    scripts/coccinelle/cpu_env.cocci_template | 60 +++++++++++++++++++++++
>>>    2 files changed, 61 insertions(+)
>>>    create mode 100644 scripts/coccinelle/cpu_env.cocci_template
>>
>>
>>> diff --git a/scripts/coccinelle/cpu_env.cocci_template b/scripts/coccinelle/cpu_env.cocci_template
>>> new file mode 100644
>>> index 0000000000..53aa3a1fea
>>> --- /dev/null
>>> +++ b/scripts/coccinelle/cpu_env.cocci_template
>>> @@ -0,0 +1,60 @@
>>> +/*
>>> +
>>> + Convert &ARCH_CPU(..)->env to use cpu_env(..).
>>> +
>>> + Rationale: ARCH_CPU() might be slow, being a QOM cast macro.
>>> +            cpu_env() is its fast equivalent.
>>> +
>>> + SPDX-License-Identifier: GPL-2.0-or-later
>>> + SPDX-FileCopyrightText: Linaro Ltd 2024
>>> + SPDX-FileContributor: Philippe Mathieu-Daudé
>>> +
>>> + Usage as of v8.2.0:
>>> +
>>> + $ for targetdir in target/*; do test -d $targetdir || continue; \
>>> +       export target=${targetdir:7}; \
>>> +       sed \
>>> +           -e "s/__CPUArchState__/$( \
>>> +               git grep -h --no-line-number '@env: #CPU.*State' \
>>> +                   target/$target/cpu.h \
>>> +               | sed -n -e 's/.*\(CPU.*State\).\?/\1/p')/g" \
>>> +           -e "s/__ARCHCPU__/$( \
>>> +               git grep -h --no-line-number OBJECT_DECLARE_CPU_TYPE.*CPU \
>>> +                   target/$target/cpu-qom.h \
>>> +               | sed -n -e 's/.*(\(.*\), .*, .*)/\1/p')/g" \
>>> +           -e "s/__ARCH_CPU__/$( \
>>> +               git grep -h --no-line-number OBJECT_DECLARE_CPU_TYPE.*CPU \
>>> +                   target/$target/cpu-qom.h \
>>> +               | sed -n -e 's/.*(.*, .*, \(.*\))/\1/p')/g" \
>>> +       < scripts/coccinelle/cpu_env.cocci_template \
>>> +       > $TMPDIR/cpu_env_$target.cocci; \
>>> +       for dir in hw target/$target; do \
>>> +           spatch --macro-file scripts/cocci-macro-file.h \
>>> +                  --sp-file $TMPDIR/cpu_env_$target.cocci \
>>> +                  --keep-comments \
>>> +                  --dir $dir \
>>> +                  --in-place; \
>>> +       done; \
>>> +   done
>>> +
>>> +*/
>>> +
>>> +@ CPUState_arg_used @
>>> +CPUState *cs;
>>> +identifier cpu;
>>> +identifier env;
>>> +@@
>>> +-   __ARCHCPU__ *cpu = __ARCH_CPU__(cs);
>>
>> Here we remove ARCH_CPU(), ...
>>
>>> +-   __CPUArchState__ *env = &cpu->env;
>>> ++   __CPUArchState__ *env = cpu_env(cs);
>>> +    ... when != cpu
>>> +
>>> +@ depends on never CPUState_arg_used @
>>> +identifier obj;
>>> +identifier cpu;
>>> +identifier env;
>>> +@@
>>> +-   __ARCHCPU__ *cpu = __ARCH_CPU__(obj);
>>> +-   __CPUArchState__ *env = &cpu->env;
>>> ++   __CPUArchState__ *env = cpu_env(CPU(obj));
>>
>> ... but here we just change it by a CPU() QOM call.
>> So this 2nd change is just style cleanup.
> 
> Can you also add a hunk that is
> 
> CPUState *cs;
> @@
> -  CPU(cs)
> + cs
> 
> to clean up on the second?  cpu_env(CPU(current_cpu)) is suboptimal
> and also a bit ugly.

These case should be cleaned because this is already a CPUState*:

+    CPUX86State *env = cpu_env(CPU(current_cpu));

+    CPUPPCState *env = cpu_env(CPU(first_cpu));

But these (instance_init and QOM visitors) can't, the argument
isn't a CPUState*:

  static void ev4_cpu_initfn(Object *obj)
  {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(CPU(obj));

@@ -5186,8 +5179,7 @@ static char *x86_cpuid_get_vendor(Object *obj, 
Error **errp)
  static void x86_cpuid_set_vendor(Object *obj, const char *value,
                                   Error **errp)
  {
-    X86CPU *cpu = X86_CPU(obj);
-    CPUX86State *env = &cpu->env;
+    CPUX86State *env = cpu_env(CPU(obj));

That said, these visitors take a Object* param because they implement
the generic QOM visitor API, but we know the visitor are registered
on classes/objects implementing CPUState, so QOM cast macro is
redundant.

