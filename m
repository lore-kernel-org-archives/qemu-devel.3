Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F66C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClKv-0005y4-HX; Thu, 30 May 2024 15:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClKt-0005xU-Ve
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:21:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClKp-0001nv-FM
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:21:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4202c1d19d5so12705925e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717096869; x=1717701669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P9SF0rYYdV3t4VltPyqLAJZ0jL2EqtpaokIf9rvVHrk=;
 b=yXe0oyDgRkgWG2C6Q5A8hnpJTPEGrtFhXhtdIPQ8WSbtah4lg5D2wnjOAKhpdo5+IK
 c6hUgt4UhwccHxLW4kdQhW0Mp4nhkvM+buklLiHbwTQPmCpzlTX1jP5MRDartgh4E4Z0
 gN9RAwv/MM2O21wrty7BCIf6fAGMPpwaTyaQDsA8pAe5eTgsS1NqAs0msghkz/oUe7ot
 S/K5oxKhiWfmFFykiK7wINNFaSQ9pbGDT0oFl69cFesM8oNUFRnfiadtEPqD/FsldfOq
 Z5zYBgrw/JPTkfSdM6lk/1bTSfKAC1CErNfQZor94SeLSYiYOjTBul/ybBQb7o9gmHSb
 cvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717096869; x=1717701669;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9SF0rYYdV3t4VltPyqLAJZ0jL2EqtpaokIf9rvVHrk=;
 b=PoZlQY6G/iN6O4kl4Jh0whZGcB/A/xuYkyhG6pK996NAEy9Fc213Ojyr655IV3Gvsq
 17jV6bttnkWnaPAzSGnRG8rXx3yGGNRiCgxnxwScDsfBNUyP2PKJP8R2c0IcINUZnx+O
 kb9DocUCQVQT034RrDglCboSQdUiC4j5R41mCP7aVboSSKbc50l7fR5OTUtP3TiHNKuX
 sCcdKtvVELo6bMMseOsXhvxLyqFxHLoFx7elMExjIYyIGHXy1YNQBVqrG6GD7DCsVKj8
 qxV4C42xfC+6Rc/IRggh2Grc9sxKSH4Mt8ACj2xi2fdwP1kxvOLlBAvNdmsXng7YksaU
 3fHw==
X-Gm-Message-State: AOJu0YwpZcz5/V5MlLpfuSdP95VrRulq4AnG2/pGrMcfc6newIdN2rpN
 aJjw1VuaxH9gRp1mL3+tQo/aq0rnGn92/yCspZ6ddKtN1Rn54vvY4B/xuP3phQ8=
X-Google-Smtp-Source: AGHT+IHsfBI4dNA2nVIMxTIjEnYdltnajj61YfpmVJPVNEoi6PAn12PtuFARDkgqjCGIGEYslCylEg==
X-Received: by 2002:a05:600c:424c:b0:420:2986:ccee with SMTP id
 5b1f17b1804b1-42127925d0emr29982765e9.30.1717096868331; 
 Thu, 30 May 2024 12:21:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421270697b6sm33105485e9.24.2024.05.30.12.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:21:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4C4845F8CB;
 Thu, 30 May 2024 20:21:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [RFC PATCH] cpus: split qemu_init_vcpu and delay vCPU thread
 creation
In-Reply-To: <c5803a9f-c30b-4b9e-b3ce-75db38f555c4@linaro.org> (Pierrick
 Bouvier's message of "Thu, 30 May 2024 10:31:40 -0700")
References: <20240529152219.825680-1-alex.bennee@linaro.org>
 <c5803a9f-c30b-4b9e-b3ce-75db38f555c4@linaro.org>
Date: Thu, 30 May 2024 20:21:07 +0100
Message-ID: <87ed9jcdi4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> On 5/29/24 08:22, Alex Benn=C3=A9e wrote:
>> This ensures we don't start the thread until cpu_common_realizefn has
>> finished. This ensures that plugins will always run
>> qemu_plugin_vcpu_init__async first before any other states. It doesn't
>> totally eliminate the race that plugin_cpu_update__locked has to work
>> around though. I found this while reviewing the ips plugin which makes
>> heavy use of the vcpu phase callbacks.
>> An alternative might be to move the explicit creation of vCPU
>> threads
>> to qdev_machine_creation_done()? It doesn't affect user-mode which
>> already has a thread to execute in and ensures the QOM object has
>> completed creation in cpu_create() before continuing.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>   include/hw/core/cpu.h      |  8 ++++++++
>>   accel/tcg/user-exec-stub.c |  5 +++++
>>   hw/core/cpu-common.c       |  7 ++++++-
>>   plugins/core.c             |  5 +++++
>>   system/cpus.c              | 15 ++++++++++-----
>>   5 files changed, 34 insertions(+), 6 deletions(-)
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index bb398e8237..6920699585 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -1041,6 +1041,14 @@ void end_exclusive(void);
>>    */
>>   void qemu_init_vcpu(CPUState *cpu);
>>   +/**
>> + * qemu_start_vcpu:
>> + * @cpu: The vCPU to start.
>> + *
>> + * Create the vCPU thread and start it running.
>> + */
>> +void qemu_start_vcpu(CPUState *cpu);
>> +
>>   #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
>>   #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
>>   #define SSTEP_NOTIMER 0x4  /* Do not Timers while single stepping */
>> diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
>> index 4fbe2dbdc8..162bb72bbe 100644
>> --- a/accel/tcg/user-exec-stub.c
>> +++ b/accel/tcg/user-exec-stub.c
>> @@ -18,6 +18,11 @@ void cpu_exec_reset_hold(CPUState *cpu)
>>   {
>>   }
>>   +void qemu_start_vcpu(CPUState *cpu)
>> +{
>> +    /* NOP for user-mode, we already have a thread */
>> +}
>> +
>>   /* User mode emulation does not support record/replay yet.  */
>>     bool replay_exception(void)
>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>> index 0f0a247f56..68895ddd59 100644
>> --- a/hw/core/cpu-common.c
>> +++ b/hw/core/cpu-common.c
>> @@ -230,7 +230,12 @@ static void cpu_common_realizefn(DeviceState *dev, =
Error **errp)
>>       }
>>   #endif
>>   -    /* NOTE: latest generic point where the cpu is fully realized
>> */
>> +    /*
>> +     * With everything set up we can finally start the vCPU thread.
>> +     * This is a NOP for linux-user.
>> +     * NOTE: latest generic point where the cpu is fully realized
>> +     */
>> +    qemu_start_vcpu(cpu);
>>   }
>>     static void cpu_common_unrealizefn(DeviceState *dev)
>> diff --git a/plugins/core.c b/plugins/core.c
>> index 0726bc7f25..1e5da7853b 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -65,6 +65,11 @@ static void plugin_cpu_update__locked(gpointer k, gpo=
inter v, gpointer udata)
>>       CPUState *cpu =3D container_of(k, CPUState, cpu_index);
>>       run_on_cpu_data mask =3D RUN_ON_CPU_HOST_ULONG(*plugin.mask);
>>   +    /*
>> +     * There is a race condition between the starting of the vCPU
>> +     * thread at the end of cpu_common_realizefn and when realized is
>> +     * finally set.
>> +     */
>
> Could we simply have an active wait here?
> while (!DEVICE(cpu)->realized) {}
>
> We have a guarantee it will be realized shortly, and if it's too hard
> to have a proper synchronization mechanism (introduce a
> realize_cond?), then waiting for the proper state does not seem too
> bad.
>
> It's a bit strange for me to document an existing race condition,
> instead of finding a solution.

If only it were that simple ;-)

Having been digging into this today it looks like there is a careful set
of dependencies on when threads need to be created during CPU
realization. I did try pushing the thread creation out of realization
but that breaks things like KVM which can't initialise some things
until the thread is up.

I'm now trying to move the plugin queuing its async work to after things
are initialised and before threads are created. My only concern now is
if I need to avoid kicking threads before they are created.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

