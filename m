Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE1C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 08:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCxvi-0007iC-5n; Fri, 31 May 2024 04:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCxvg-0007i0-CR
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:48:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCxve-0001lo-I4
 for qemu-devel@nongnu.org; Fri, 31 May 2024 04:48:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42108739ed8so23457425e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717145281; x=1717750081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=meoL7WfK42ojhKeIQHmQAYOy8DiET5LFPofSDuIY/tE=;
 b=KUvUhsENI/Wfuo8465Tu9eRxqwoxgXyxkv1v7pz5MRed6xE7hFzoaKzOMoTpHNqN27
 M4lW65eWl9/FU2pVxr5BJqzSXOuF11hgRvAxsEVFdQ/jwcQLrbo4wKCwjxzTE5eF+keK
 E0XBuIPGyt/VIfBWmRmSJ/EMN9BmtPyEQs6Inz92BnqBLNfuAnByBwkxSvNy0juUlNhR
 XJGF5neiP7oTc6LpxEWvVBiwUfOsVsoIIqi0HTjGW7Xg52XB0C3w2uOW83r7T+HXBjk9
 DGAuOgOCCsgW2nLzYIgLmQsW0anOql9or5soS6ggJGwq9FjBY5a4is4H/BAm2p25inzL
 xSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717145281; x=1717750081;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meoL7WfK42ojhKeIQHmQAYOy8DiET5LFPofSDuIY/tE=;
 b=RAV6mIetEnixI9yCxynAyMMFZ071VybcvRYF1/yO+cFEDGf6fDfMHxEtE0p2zB1S7n
 sbOksOec4HgmbdOESWvC+UdCV8Tn/tnJ4WfDXxev64oIdXf/UYFKj7HxatJIUqywribI
 oV5Ch9RCn9DsWBPtrlY64SWolm9jaUBPTOvOuP63HAHW76MTnWVBIA2D3YvfdxPCmNnd
 c9egxELMRi6tKLmr3Hs9+Ll8pBizd9CC6oJeGiwo37zl3mj2qxHFJ0x7IA3845RGx9MW
 16nvQrM3uIe4O4srcdAuidc6t08zLsSNBwmKSemhcL5s3fvtoe3KY7WTuKxgcllAzLsh
 mivg==
X-Gm-Message-State: AOJu0YxwVyH31/QKA3Al+0dAZzeoDUiaQoP1mE5QDS0JQv3ri8a+b5Ao
 i5p3WXrAXR/3+GZy5jEQdLvQ3HHDDom0pZyV3hoLP78POf1faQrGovHpLROi6LQ=
X-Google-Smtp-Source: AGHT+IEV4VB90Yp5BlcabsTwRd4BgRHuw3uHX/14npi+yUJEgcNk6X77K92oI3w52Eu/2/hHdMqhmg==
X-Received: by 2002:a05:600c:4f46:b0:421:212c:c963 with SMTP id
 5b1f17b1804b1-4212e075949mr12173695e9.20.1717145280676; 
 Fri, 31 May 2024 01:48:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84ae09sm18355335e9.18.2024.05.31.01.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 01:48:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB0EE5F747;
 Fri, 31 May 2024 09:47:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Sunil
 Muthuswamy <sunilmut@microsoft.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,  kvm@vger.kernel.org,  Roman
 Bolshakov <rbolshakov@ddn.com>
Subject: Re: [PATCH 5/5] core/cpu-common: initialise plugin state before
 thread creation
In-Reply-To: <1c950cd6-9ee0-4b40-b9d6-3cc422046d65@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 31 May 2024 09:26:55
 +0200")
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-6-alex.bennee@linaro.org>
 <1c950cd6-9ee0-4b40-b9d6-3cc422046d65@linaro.org>
Date: Fri, 31 May 2024 09:47:59 +0100
Message-ID: <87a5k6cqps.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 30/5/24 21:42, Alex Benn=C3=A9e wrote:
>> Originally I tried to move where vCPU thread initialisation to later
>> in realize. However pulling that thread (sic) got gnarly really
>> quickly. It turns out some steps of CPU realization need values that
>> can only be determined from the running vCPU thread.
>
> FYI:
> https://lore.kernel.org/qemu-devel/20240528145953.65398-6-philmd@linaro.o=
rg/

But this still has it in realize which would still race as the threads
are started before we call the common realize functions.

>
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
>
> Per https://etherpad.opendev.org/p/QEMU_vCPU_life, plugin_state could
> be initialized in AccelCPUClass::cpu_instance_init (although this
> callback is called at CPUClass::instance_post_init which I haven't
> yet figured why).

Why are x86 and RiscV special in terms of calling this function?

>
>> +        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_=
NULL);
>> +    }
>> +#endif
>>   }
>>     static void cpu_common_finalize(Object *obj)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

