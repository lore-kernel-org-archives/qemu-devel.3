Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E25C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCy6t-0003tD-Df; Fri, 31 May 2024 04:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCy6s-0003t5-99
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:59:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCy6q-0003UD-Ey
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:59:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so695725f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717145975; x=1717750775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HFU9KKTRbDofEDS8aJAnWea9GBFWQtUAah9gN/YYUmE=;
 b=PXu4NX3tuXlia+VdD/kZQjqXqZjlO/Lfl3mIrxljjB/EdsaNWdK488Ivkt6J7zZX4C
 IyZxQfvQ1/uwBvlsyd3cAxDU0c6s7H5arN0XdNMIwc5dD+/O8J8lLUKurfpnt5Kq5PkF
 XmpoTH7RkH8Sm/bNehmviA2zwbLtDr6f2nLJ1RV7qbwlSl1hX2KKdc5631kX9Btgqkdq
 Vxn44oNUhWlUE3fVi7WAZkR/yrqVI5DSSAk9QIEqFy2roSPCJazMyNwBEL79l1vP6FKS
 dfNIeHldt77n9h0IWU8LJoG9r1zJmn9aFeZma6jzCCbDUUTOoWApKwh7jGx3sf00Bxf1
 MaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717145975; x=1717750775;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFU9KKTRbDofEDS8aJAnWea9GBFWQtUAah9gN/YYUmE=;
 b=R4CgnuvbkxXSFBI+qE04ENUGECw9FKEr1RCE2wXDHSqCIFhiksgpWd0MkRxtcTBBpf
 CtJB04gAVgQeH3+Yu9/n9Lo/obhEz6IJh84+14dFKs0kzt4z/15ynn/STsAe2akw7+bC
 QHb1f/kdlTO+snjCqk7ujI89jlZ0fT14TkhavGTccQwXJq4nupvwUnU7FlUYIXJ1+waT
 fdKxNtiTjc8IrOWrrjd0uXIe84rMYnmXTCOnVHlrkXc/5f2unaVc1svRl1a4dEZSNDC6
 +G4kkRjB+cM/O8R8dH+tUY2M4GAMfpg7JYZ8P68zdkywdQDy1kBtIUrw4+1nRshCElAU
 tZMg==
X-Gm-Message-State: AOJu0Yze3vhC1U1o4PJ1b2ygaPDMlrE0OtdLUBd4DSwI2hV7XF9CtYco
 kuSyiTztJj4M/vZ04ws3F2lvG5Zi05PzAuQ29tex+77He9ba7/PrG1QOLDJUJAE=
X-Google-Smtp-Source: AGHT+IHlD6Au5junwHiGk/7tjJB3tOTkAx0owjoRjG4EL0CHBDXbT6nfB1PVCFuLMHfgLYlU0cdvsg==
X-Received: by 2002:a5d:46d2:0:b0:355:148:ea23 with SMTP id
 ffacd0b85a97d-35e0f316ab9mr843678f8f.56.1717145974622; 
 Fri, 31 May 2024 01:59:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0f1fsm1390309f8f.15.2024.05.31.01.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 01:59:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B3F325F747;
 Fri, 31 May 2024 09:59:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Sunil
 Muthuswamy <sunilmut@microsoft.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Reinoud
 Zandijk <reinoud@netbsd.org>,  kvm@vger.kernel.org,  Roman Bolshakov
 <rbolshakov@ddn.com>
Subject: Re: [PATCH 5/5] core/cpu-common: initialise plugin state before
 thread creation
In-Reply-To: <23926d03-b55f-448f-82b1-99e4bc9d76dd@linaro.org> (Pierrick
 Bouvier's message of "Thu, 30 May 2024 15:31:53 -0700")
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-6-alex.bennee@linaro.org>
 <23926d03-b55f-448f-82b1-99e4bc9d76dd@linaro.org>
Date: Fri, 31 May 2024 09:59:33 +0100
Message-ID: <871q5icq6i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 5/30/24 12:42, Alex Benn=C3=A9e wrote:
>> Originally I tried to move where vCPU thread initialisation to later
>> in realize. However pulling that thread (sic) got gnarly really
>> quickly. It turns out some steps of CPU realization need values that
>> can only be determined from the running vCPU thread.
>> However having moved enough out of the thread creation we can now
>> queue work before the thread starts (at least for TCG guests) and
>> avoid the race between vcpu_init and other vcpu states a plugin might
>> subscribe to.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   hw/core/cpu-common.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>> index 6cfc01593a..bf1a7b8892 100644
>> --- a/hw/core/cpu-common.c
>> +++ b/hw/core/cpu-common.c
>> @@ -222,14 +222,6 @@ static void cpu_common_realizefn(DeviceState *dev, =
Error **errp)
>>           cpu_resume(cpu);
>>       }
>>   -    /* Plugin initialization must wait until the cpu start
>> executing code */
>> -#ifdef CONFIG_PLUGIN
>> -    if (tcg_enabled()) {
>> -        cpu->plugin_state =3D qemu_plugin_create_vcpu_state();
>> -        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_=
NULL);
>> -    }
>> -#endif
>> -
>>       /* NOTE: latest generic point where the cpu is fully realized */
>>   }
>>   @@ -273,6 +265,18 @@ static void cpu_common_initfn(Object *obj)
>>       QTAILQ_INIT(&cpu->watchpoints);
>>         cpu_exec_initfn(cpu);
>> +
>> +    /*
>> +     * Plugin initialization must wait until the cpu start executing
>> +     * code, but we must queue this work before the threads are
>> +     * created to ensure we don't race.
>> +     */
>> +#ifdef CONFIG_PLUGIN
>> +    if (tcg_enabled()) {
>> +        cpu->plugin_state =3D qemu_plugin_create_vcpu_state();
>> +        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_=
NULL);
>> +    }
>> +#endif
>>   }
>>     static void cpu_common_finalize(Object *obj)
>
> Could you check it works for all combination?
> - user-mode
> - system-mode tcg
> - system-mode mttcg

I was hand testing against the record replay tests in avocado (rr single
thread tcg) and general system and user mode stuff. I haven't run a full
pipeline yet, although I did apply your IPS patches ontop and run that:

  https://gitlab.com/stsquad/qemu/-/pipelines/1312869352

but all those failures are user-mode build failures due to the missing
time stubs AFAICT.

>
> When I tried to move this code around, one of them didn't work correctly.
>
> Else,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

