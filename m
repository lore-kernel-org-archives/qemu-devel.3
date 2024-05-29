Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFC1C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLxe-0005bS-DR; Wed, 29 May 2024 12:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLxc-0005ak-IM
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:15:32 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLxa-0004jW-Fc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:15:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a653972487fso77792566b.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716999328; x=1717604128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OA5lDKkOaOTEc44tPS5n68woeG5DCERM4DVSCmrYjmc=;
 b=A7P8psQnHcj6kzfuxzWD3cC2Sm6zeRhSUNytyyQX/wIVDcs3MkjCenYR4xog2zp0cz
 cc0aLtcHZ2J4VSAzBgpuXYUGKuZB6NBjrm81zPokdQWZnrPOtfxSoCdPRDmKUpzDjAJu
 BTRTKgM30U6P6uBK+JIF5TDvNtkOl7bQPWf81vnpH9H90fBjV9GzAL2rGIlWJPJXTSe7
 VZlePxSdWrfsP+3IQY84V4evaqEu5usyVt2rGaaL0NIlhohmt8SituwBu3/+t9D5ZQmE
 wL/NBdXxiOJYQeQKQnLuGdRuF8hCUu441Hn81EzmvCmFddn/jDjM1o3rcAVX/Cdb4KlO
 xJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716999328; x=1717604128;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OA5lDKkOaOTEc44tPS5n68woeG5DCERM4DVSCmrYjmc=;
 b=BZiD76B9Ki67SLeNPN3iJuL54RDxsJVDApOKCGeC1NGe/S7ImA6hifrraC16QqB4wB
 5opMca0ttdHhBklcO2fQNzsIbM8/n7CDagzASlHnTT+eN0xHLr//CMPP+GQTEH0bbF3H
 APFD8NgFnGQDmazaTz/MzeXFxUeK3Kpcb6A7KqJTIMWCwzE9gT9+zuPtggyw72AECEAu
 Bxjw4aA12s5F5tUtCcZ7/GaOBRpn0tZa3RSciWLJmiwhZp6mxHYIQmX+M/C3ZEqeI5CS
 noxvwoTlfQf8YzyuL/17DoMwzVo6D+hw6/5mUrpSnCGPKh3VmFDO7cAL7K4t2KR7R19+
 hBfA==
X-Gm-Message-State: AOJu0YyBbgko96lZPds2EG3oWWYyTd0P8xIMb5dVC3JFPmSsnFYvaZHe
 ouCjH/qENtbx2HNr1uXsca55Vl99UtFToGn4oQuv4ISdLJ0g3z8LAnP4K82LGEk=
X-Google-Smtp-Source: AGHT+IGurSVTthdUU2zaK8kXUwCxbeK4+nzZmzoesJTYcO9eZjNDQMCpQy+JHDXTKy7DMhC7lfY4Sw==
X-Received: by 2002:a17:906:c011:b0:a5c:dfc2:7239 with SMTP id
 a640c23a62f3a-a626525cb05mr1054390466b.66.1716999328428; 
 Wed, 29 May 2024 09:15:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6522baad9csm66150866b.73.2024.05.29.09.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:15:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BDDB5F760;
 Wed, 29 May 2024 17:15:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [RFC PATCH] cpus: split qemu_init_vcpu and delay vCPU thread
 creation
In-Reply-To: <c98aeb97-e229-4b97-874c-5cc2deceeaf9@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 29 May 2024 17:34:31
 +0200")
References: <20240529152219.825680-1-alex.bennee@linaro.org>
 <c98aeb97-e229-4b97-874c-5cc2deceeaf9@linaro.org>
Date: Wed, 29 May 2024 17:15:27 +0100
Message-ID: <87h6egegrk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

> Hi Alex,
>
> On 29/5/24 17:22, Alex Benn=C3=A9e wrote:
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
> I'd like we simply assert(DEVICE(cpu)->realized) here;
> I still don't understand when this can be called while
> the vcpu isn't yet realized.

It will be shortly but as the comment says we don't set it until we come
out of cpu_common_realizefn and return to QOM so you get:

  **
  ERROR:../../plugins/core.c:73:plugin_cpu_update__locked: assertion failed=
: (DEVICE(cpu)->realized)
  Bail out! ERROR:../../plugins/core.c:73:plugin_cpu_update__locked: assert=
ion failed: (DEVICE(cpu)->realized)

  Thread 4 "qemu-system-aar" received signal SIGABRT, Aborted.
  [Switching to Thread 0x7fffe5e006c0 (LWP 1000969)]
  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsigno@=
entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
  44      ./nptl/pthread_kill.c: No such file or directory.
  (gdb) bt
  #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
  #1  0x00007ffff4ca9e8f in __pthread_kill_internal (signo=3D6, threadid=3D=
<optimized out>) at ./nptl/pthread_kill.c:78
  #2  0x00007ffff4c5afb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
  #3  0x00007ffff4c45472 in __GI_abort () at ./stdlib/abort.c:79
  #4  0x00007ffff6e46ec8 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #5  0x00007ffff6ea6e1a in g_assertion_message_expr () at /lib/x86_64-linu=
x-gnu/libglib-2.0.so.0
  #6  0x000055555600e2c8 in plugin_cpu_update__locked (k=3D0x5555579e9ee8, =
v=3D<optimized out>, udata=3D<optimized out>) at ../../plugins/core.c:73
  #7  0x000055555600e5fc in qemu_plugin_vcpu_init_hook (cpu=3D0x5555579e9c2=
0) at ../../plugins/core.c:261
  #8  0x00005555558ff106 in process_queued_cpu_work (cpu=3D0x5555579e9c20) =
at ../../cpu-common.c:360
  #9  0x00005555560100f6 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x555557=
9e9c20) at ../../accel/tcg/tcg-accel-ops-mttcg.c:118
  #10 0x00005555561bcce8 in qemu_thread_start (args=3D0x555557a55d70) at ..=
/../util/qemu-thread-posix.c:541
  #11 0x00007ffff4ca8134 in start_thread (arg=3D<optimized out>) at ./nptl/=
pthread_create.c:442
  #12 0x00007ffff4d287dc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/=
clone3.S:81

Arguably I think we should just wait until machine is created I think.

>
>>       if (DEVICE(cpu)->realized) {
>>           async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>>       } else {
>> diff --git a/system/cpus.c b/system/cpus.c
>> index d3640c9503..7dd8464c5e 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -488,11 +488,13 @@ void cpus_kick_thread(CPUState *cpu)
>>     void qemu_cpu_kick(CPUState *cpu)
>>   {
>> -    qemu_cond_broadcast(cpu->halt_cond);
>> -    if (cpus_accel->kick_vcpu_thread) {
>> -        cpus_accel->kick_vcpu_thread(cpu);
>> -    } else { /* default */
>> -        cpus_kick_thread(cpu);
>> +    if (cpu->halt_cond) {
>
> cpu->halt_cond =3D NULL is a bug, why kicking a vcpu not
> yet fully created?

We are queuing work for when it is ready but we don't create
cpu->halt_cond until in the thread (this is mainly to workaround the
fact the rr_thread shares its context between multiple CPUStates).

>
>> +        qemu_cond_broadcast(cpu->halt_cond);
>> +        if (cpus_accel->kick_vcpu_thread) {
>> +            cpus_accel->kick_vcpu_thread(cpu);
>> +        } else { /* default */
>> +            cpus_kick_thread(cpu);
>> +        }
>>       }
>>   }
>>   @@ -674,7 +676,10 @@ void qemu_init_vcpu(CPUState *cpu)
>>           cpu->num_ases =3D 1;
>>           cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
>>       }
>> +}
>>   +void qemu_start_vcpu(CPUState *cpu)
>> +{
>>       /* accelerators all implement the AccelOpsClass */
>>       g_assert(cpus_accel !=3D NULL && cpus_accel->create_vcpu_thread !=
=3D NULL);
>>       cpus_accel->create_vcpu_thread(cpu);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

