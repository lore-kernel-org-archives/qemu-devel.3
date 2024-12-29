Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3E6E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 16:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRw32-0003WQ-TV; Sun, 29 Dec 2024 11:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRw31-0003WF-CI
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:21:47 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRw2v-0005Nw-6r
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 11:21:47 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so11405446a91.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735489298; x=1736094098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=//Pcfjil85A7zfZpSp2Xo9k4HB0I2DwknZ85CrQTzio=;
 b=Xm1dKPKp+msIVLtsEzFXB/vqdyHumPz/yJDQ4TymXHq+UklYPOULyQ6D0IE0regwvy
 JOGx6GqwfpsqGpJuylGTY0Ar0JWt2tKG65lx4vHFw+j5kx1VDAhbnN9OeCtugSDkvWJH
 1cn134mDAVPkYWWuFqJxtxOi6+3L5rlhgVQPy0f2ulsS7FAy7ENDwiDrcGQ9mJ2OC9A/
 L+n5IilbiFgS70LhJ1Q5FoJVNpGkUZrs6EHx2Mrttikwf4+SCyPp2WAkqU1mBspPRK0A
 TkSlNSTKaL7XX7zRP+S2RmOGCyhWNmPPQY6TyNpZKy0qqLXVX3sibJ0rfI6npY/zbV92
 S3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735489298; x=1736094098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//Pcfjil85A7zfZpSp2Xo9k4HB0I2DwknZ85CrQTzio=;
 b=TCqkgSEYoY2ONITP9FXFv9Uplc7mfxL1weJs+rSmaP0p6Eh+B8KylSJnvXE11F2zQM
 +vzYylkMI7Kv29g5Ufiq1IGfG7E4bU36s3OMAsHy54fJSf7dRHL3Z3G/U9D6pksRT3eI
 LvZuqvHiiQySWEYFmCf8QlXxB+9zS0B4NIgrzRd/uc/p5srdOjFxJ3+z7kIM/iUiRn7g
 uz64caDNZJjex3Z0KfHCClSR5u//ryImOMPsPFTke/Igd6T9M4681iNS+pSgOu6uvcmW
 v2tUZN+Phso6DhW8KKNpnC0hR6CA8VjXuWygwJBB9YPykcxXv/aZ/N8lWVPRdfmIza8Q
 Fzdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG1HKcN0ITj6QR/zeUZPVfW+2zRls2rQdjOM66bCpPxS4e0wu0/sjkdZoo5WVBCvVE8Dgi+PhhQ5of@nongnu.org
X-Gm-Message-State: AOJu0YwqgBrUS5JHlYLkvchcKFb5krKfSupDLvEFYY9+/QK4IAyTHX1n
 c139v/x7nvl0ndfCwltlVrm/SDL8smuWlLliWZBP0p3drKqyD3WaDSLLfMYvyl4=
X-Gm-Gg: ASbGncv1Vvw5/1cZvW7j0lLk48KSieDDaRKwvWlWUTqEcQYWkmIJptVlQ6S2kyLK3qK
 h9vTw4ZtKyy76OuThJREeKVdQq0m0m75vpgKxaoo3sCLt5PQBoBa03TdLsoFuLGek4vWvJyTYl2
 F2w9mcz4tiD98tCkdhP7Wsf36ORessKEGiTx37KJtjDhbAd7J1IKg+Drj/3zbp98IZFPinMzlTJ
 9z3SHMkyoETvTYOyCifDE/rhxpIewnwOVumQlhMCyzVPp78TCYRJba8/sGnHtX7RH6VJQn6+Vfz
 rzt+msSPE3TLB2ZGZqo36bGZdRh90NcNHKApZOE=
X-Google-Smtp-Source: AGHT+IGlDSi+vXGqd2DdIAWb2/0h+Aft9lqc9WV7wChIwI+yHSRGfYSN89JZ28yXkpySoeh+b/U+VQ==
X-Received: by 2002:a05:6a00:399a:b0:725:b7dd:e668 with SMTP id
 d2e1a72fcca58-72abdebb868mr43517842b3a.17.1735489298501; 
 Sun, 29 Dec 2024 08:21:38 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm13654944b3a.154.2024.12.29.08.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2024 08:21:38 -0800 (PST)
Message-ID: <c94f9eee-492b-49ac-9d8d-137c44f66ea6@linaro.org>
Date: Sun, 29 Dec 2024 08:21:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/hppa: Add CPU reset method
To: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
References: <Z281jSej_buitgV8@p100>
 <3b0804a9-4df9-4eb0-bdc8-2745b62355e8@linaro.org>
 <1db87d1a-cf80-4dbe-9d79-d9711d7c172f@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1db87d1a-cf80-4dbe-9d79-d9711d7c172f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 12/28/24 18:44, Helge Deller wrote:
> On 12/29/24 02:58, Richard Henderson wrote:
>> On 12/27/24 15:17, Helge Deller wrote:
>>> Add the CPU reset method, which resets all CPU registers and the TLB to
>>> zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
>>> start execution at address 0xf0000004.
>>> Although we currently want to zero out all values in the CPUHPPAState
>>> struct, add the end_reset_fields marker in case the state structs gets
>>> extended with other variables later on which should not be reset.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>
>>> V3:
>>> - Call reset function from hppa_machine_reset() instead
>>>
>>> V2:
>>> - Add end_reset_fields marker
>>> - call reset function in hppa_cpu_initfn()
>> ...
>>> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
>>> index c38439c180..b908cf65c6 100644
>>> --- a/target/hppa/cpu.c
>>> +++ b/target/hppa/cpu.c
>>> @@ -235,15 +235,39 @@ static const TCGCPUOps hppa_tcg_ops = {
>>>   #endif /* !CONFIG_USER_ONLY */
>>>   };
>>> +static void hppa_cpu_reset_hold(Object *obj, ResetType type)
>>> +{
>>> +    HPPACPU *cpu = HPPA_CPU(obj);
>>> +    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(cpu);
>>> +    CPUHPPAState *env = &cpu->env;
>>> +    CPUState *cs = CPU(cpu);
>>> +
>>> +    if (scc->parent_phases.hold) {
>>> +        scc->parent_phases.hold(obj, type);
>>> +    }
>>> +
>>> +    memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
>>> +    cpu_set_pc(cs, 0xf0000004);
>>> +    cpu_hppa_put_psw(env, hppa_is_pa20(env) ? PSW_W : 0);
>>> +    cpu_hppa_loaded_fr0(env);
>>> +
>>> +    cs->exception_index = -1;
>>> +    cs->halted = 0;
>>> +}
>>
>> There's also a set of exception_index in hppa_cpu_initfn.
> 
> I don't quite understand...
> Do you suggest I should remove the initialization of exception_index here,
> or drop the one in hppa_cpu_initfn() ?
I think the one in initfn is redundant.

r~

