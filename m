Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC01C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLOT-00032Z-CT; Wed, 29 May 2024 11:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLOR-00031x-GJ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:39:11 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLOO-0006Nn-Oz
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:39:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f466so2558946a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716997147; x=1717601947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Na7k3Vaa3d92xA8Pw5XbAObZT2Uk5U1ggpE0rcCYIo=;
 b=KNdIhLTcmZrdpYizaTsKg20xtVq69+SvSJJ2y2b/cz79qxhptSPjQ4qpoCqD7wCjHf
 XIY618+X8XunA1rI64erMlz6zorbh8iD+KTxNLwwLgJkosToQFBW9RifC7leD4P43Syi
 BydljYswsZ7+V+013BYI1OUxr+me9XszCPZJqjuPjNMS67A7qb2Pir4Io3inHQRuv5Y3
 FJktP0xdlhmOxqcNGJNsvZtxO/sVd1if5RwfCGR/gjObZjXFaZIPrxW2NbhNz8M7Aotg
 NN+NVnAki0HrVS8El1KUFiQekvrcFdN6he5M+yEO7GCXpXO9ztvZjDcc7UHmlPVC+G24
 guNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716997147; x=1717601947;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Na7k3Vaa3d92xA8Pw5XbAObZT2Uk5U1ggpE0rcCYIo=;
 b=X0sf5x457kNuUbKdqC49bMdWAIu+jBy8j4oPRMdDq1o6mlUW8MylBHaqBwi5plNomx
 bTlSK1474XbTZVSQSGjgJNwY8tgWn83CvEb2T9xvswdNj9yYGOYEZ2Sw3X/IMEBFsOkr
 ovFjOxLqxUKlRqs9R/ZBtHJiNpyd89E2nKuRxfWS/3zgl4doY47LUkaBeujYRbEs84Q+
 Z580CqeCboOvQvbOgadrctaS2J1Q2ewx2reYc1y1UOB8O73KRoQd3AFxq3yB47RnC1b3
 mtYj1/7mNbqD5GXED/K8TeGGn87KqvKIDE8lqpe+igqSJoqJfR5W+daEUDPjW4bU0yN6
 Lc8A==
X-Gm-Message-State: AOJu0Yz9wMk2QVUx5lZYWYOww4dDwxca/3uKCfJnDG4YADaihzzVk30N
 pEck8WXFnlejBANFpyG+LxK5kVA4YC4GGKydk+Jb6LDaZqwS++53rpFT3zJfgb8=
X-Google-Smtp-Source: AGHT+IHm5ZtV9Md8fS7KFhzSjW8w5yUIqPqC5wLVRfztGnkergLLywxeL0n8oqNNxwVSd04kj6JCVw==
X-Received: by 2002:a50:c353:0:b0:578:5dce:9d2c with SMTP id
 4fb4d7f45d1cf-5785dce9e3bmr9118047a12.23.1716997146773; 
 Wed, 29 May 2024 08:39:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57861b4ddefsm7285987a12.60.2024.05.29.08.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:39:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E488D5F760;
 Wed, 29 May 2024 16:39:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 5/5] contrib/plugins: add ips plugin example for cost
 modeling
In-Reply-To: <c2476a9b-c7a0-4ecb-8586-53bd286d4a24@linaro.org> (Pierrick
 Bouvier's message of "Wed, 29 May 2024 07:33:55 -0700")
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-6-pierrick.bouvier@linaro.org>
 <874jahg34h.fsf@draig.linaro.org>
 <42db6c5a-d3a2-4ae4-aba2-6cb1eb6f35ba@linaro.org>
 <87zfs9emlj.fsf@draig.linaro.org>
 <4d87e502-2664-4be4-bcf0-9411ce3d9070@linaro.org>
 <87v82wery7.fsf@draig.linaro.org>
 <c2476a9b-c7a0-4ecb-8586-53bd286d4a24@linaro.org>
Date: Wed, 29 May 2024 16:39:05 +0100
Message-ID: <87mso8eig6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

> On 5/29/24 05:13, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>> (Added Philip to CC)
>>=20
>>> On 5/28/24 12:57, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>>
>>>>> On 5/28/24 12:14, Alex Benn=C3=A9e wrote:
>>>>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>>>>
>>>>>>> This plugin uses the new time control interface to make decisions
>>>>>>> about the state of time during the emulation. The algorithm is
>>>>>>> currently very simple. The user specifies an ips rate which applies
>>>>>>> per core.
>> <snip>
>>=20
>>>>>>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
>>>>>>> +{
>>>>>>> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_inde=
x);
>>>>>>> +    /* ensure start time is set first */
>>>>>>> +    set_start_time();
>>>>>>> +    /* start counter from absolute time reference */
>>>>>>> +    vcpu->counter =3D num_insn_during(uptime_ns());
>>>>>>> +    vcpu_set_state(vcpu, EXECUTING);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
>>>>>>> +{
>>>>>>> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_inde=
x);
>>>>>>> +    vcpu_set_state(vcpu, IDLE);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void vcpu_resume(qemu_plugin_id_t id, unsigned int cpu_inde=
x)
>>>>>>> +{
>>>>>>> +    vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpus, cpu_inde=
x);
>>>>>>> +    g_assert(vcpu->state =3D=3D IDLE);
>>>>>> I'm triggering a weird race here:
>>>>>>      (gdb) b vcpu_init
>>>>>>      Breakpoint 1 at 0x7ffff7fa15f7: file /home/alex/lsrc/qemu.git/c=
ontrib/plugins/ips.c, line 127.
>>>>>>      (gdb) r
>>>>>>      The program being debugged has been started already.
>>>>>>      Start it from the beginning? (y or n) y
>>>>>>      Starting program:
>>>>>> /home/alex/lsrc/qemu.git/builds/arm.debug/qemu-system-aarch64
>>>>>> -machine type=3Dvirt,virtualization=3Don,pflash0=3Drom,pflash1=3Defi=
vars
>>>>>> -cpu cortex-a57 -smp 32 -accel tcg -device
>>>>>> virtio-net-pci,netdev=3Dunet -device virtio-scsi-pci -device
>>>>>> scsi-hd,drive=3Dhd -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22
>>>>>> -blockdev
>>>>>> driver=3Draw,node-name=3Dhd,file.driver=3Dhost_device,file.filename=
=3D/dev/zen-ssd2/trixie-arm64,discard=3Dunmap
>>>>>> -serial mon:stdio -blockdev
>>>>>> node-name=3Drom,driver=3Dfile,filename=3D/home/alex/lsrc/qemu.git/bu=
ilds/arm.debug/pc-bios/edk2-aarch64-code.fd,read-only=3Dtrue
>>>>>> -blockdev
>>>>>> node-name=3Defivars,driver=3Dfile,filename=3D/home/alex/images/qemu-=
arm64-efivars
>>>>>> -m 8192 -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don -=
kernel
>>>>>> /home/alex/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image -append
>>>>>> root=3D/dev/sda2\ console=3DttyAMA0 -plugin
>>>>>> contrib/plugins/libips.so,ips=3D1000000000
>>>>>>      [Thread debugging using libthread_db enabled]
>>>>>>      Using host libthread_db library "/lib/x86_64-linux-gnu/libthrea=
d_db.so.1".
>>>>>>      [New Thread 0x7fffe72006c0 (LWP 360538)]
>>>>>>      [New Thread 0x7fffe68006c0 (LWP 360540)]
>>>>>>      [New Thread 0x7fffe5e006c0 (LWP 360541)]
>>>>>>      [New Thread 0x7fffe54006c0 (LWP 360542)]
>>>>>>      [New Thread 0x7fffe4a006c0 (LWP 360543)]
>>>>>>      [New Thread 0x7fffdfe006c0 (LWP 360544)]
>>>>>>      [New Thread 0x7fffdf4006c0 (LWP 360545)]
>>>>>>      [New Thread 0x7fffdea006c0 (LWP 360546)]
>>>>>>      [Switching to Thread 0x7fffdf4006c0 (LWP 360545)]
>>>>>>      Thread 8 "qemu-system-aar" hit Breakpoint 1, vcpu_init
>>>>>> (id=3D10457908569352202058, cpu_index=3D0) at
>>>>>> /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:127
>>>>>>      127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpu=
s, cpu_index);
>>>>>>      (gdb) c
>>>>>>      Continuing.
>>>>>>      [New Thread 0x7fffde0006c0 (LWP 360548)]
>>>>>>      [Switching to Thread 0x7fffdea006c0 (LWP 360546)]
>>>>>>      Thread 9 "qemu-system-aar" hit Breakpoint 1, vcpu_init
>>>>>> (id=3D10457908569352202058, cpu_index=3D1) at
>>>>>> /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:127
>>>>>>      127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpu=
s, cpu_index);
>>>>>>      (gdb)
>>>>>>      Continuing.
>>>>>>      [New Thread 0x7fffdd6006c0 (LWP 360549)]
>>>>>>      [Switching to Thread 0x7fffde0006c0 (LWP 360548)]
>>>>>>      Thread 10 "qemu-system-aar" hit Breakpoint 1, vcpu_init
>>>>>> (id=3D10457908569352202058, cpu_index=3D2) at
>>>>>> /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:127
>>>>>>      127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpu=
s, cpu_index);
>>>>>>      (gdb)
>>>>>>      Continuing.
>>>>>>      [New Thread 0x7fffdcc006c0 (LWP 360550)]
>>>>>>      [Switching to Thread 0x7fffdd6006c0 (LWP 360549)]
>>>>>>      Thread 11 "qemu-system-aar" hit Breakpoint 1, vcpu_init
>>>>>> (id=3D10457908569352202058, cpu_index=3D3) at
>>>>>> /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:127
>>>>>>      127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpu=
s, cpu_index);
>>>>>>      (gdb)
>>>>>>      Continuing.
>>>>>>      [New Thread 0x7fffd3e006c0 (LWP 360551)]
>>>>>>      [Switching to Thread 0x7fffdcc006c0 (LWP 360550)]
>>>>>>      Thread 12 "qemu-system-aar" hit Breakpoint 1, vcpu_init
>>>>>> (id=3D10457908569352202058, cpu_index=3D4) at
>>>>>> /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:127
>>>>>>      127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpu=
s, cpu_index);
>>>>>>      (gdb) n
>>>>>>      129         set_start_time();
>>>>>>      (gdb)
>>>>>>      131         vcpu->counter =3D num_insn_during(uptime_ns());
>>>>>>      (gdb)
>>>>>>      132         vcpu_set_state(vcpu, EXECUTING);
>>>>>>      (gdb)
>>>>>>      133     }
>>>>>>      (gdb) p vcpu->state
>>>>>>      $1 =3D EXECUTING
>>>>>>      (gdb) p &vcpu->state
>>>>>>      $2 =3D (vCPUState *) 0x555557c6b5d0
>>>>>>      (gdb) watch *(vCPUState *) 0x555557c6b5d0
>>>>>>      Hardware watchpoint 2: *(vCPUState *) 0x555557c6b5d0
>>>>>>      (gdb) c
>>>>>>      Continuing.
>>>>>>      [Thread 0x7fffdfe006c0 (LWP 360544) exited]
>>>>>>      [Thread 0x7fffe5e006c0 (LWP 360541) exited]
>>>>>>      Thread 12 "qemu-system-aar" hit Hardware watchpoint 2:
>>>>>> *(vCPUState *) 0x555557c6b5d0
>>>>>>      Old value =3D EXECUTING
>>>>>>      New value =3D IDLE
>>>>>>      vcpu_set_state (vcpu=3D0x555557c6b5c0, new_state=3DIDLE) at /ho=
me/alex/lsrc/qemu.git/contrib/plugins/ips.c:83
>>>>>>      83      }
>>>>>>      (gdb) c
>>>>>>      Continuing.
>>>>>>      [New Thread 0x7fffdfe006c0 (LWP 360591)]
>>>>>>      [New Thread 0x7fffe5e006c0 (LWP 360592)]
>>>>>>      [New Thread 0x7fffd34006c0 (LWP 360593)]
>>>>>>      [Switching to Thread 0x7fffdfe006c0 (LWP 360591)]
>>>>>>      Thread 14 "qemu-system-aar" hit Breakpoint 1, vcpu_init
>>>>>> (id=3D10457908569352202058, cpu_index=3D6) at
>>>>>> /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:127
>>>>>>      127         vCPUTime *vcpu =3D qemu_plugin_scoreboard_find(vcpu=
s, cpu_index);
>>>>>>      (gdb)
>>>>>>      Continuing.
>>>>>>      [New Thread 0x7fffd2a006c0 (LWP 360594)]
>>>>>>      **
>>>>>>      ERROR:/home/alex/lsrc/qemu.git/contrib/plugins/ips.c:144:vcpu_r=
esume: assertion failed: (vcpu->state =3D=3D IDLE)
>>>>>>      Bail out! ERROR:/home/alex/lsrc/qemu.git/contrib/plugins/ips.c:=
144:vcpu_resume: assertion failed: (vcpu->state =3D=3D IDLE)
>>>>>>      Thread 13 "qemu-system-aar" received signal SIGABRT, Aborted.
>>>>>>      [Switching to Thread 0x7fffd3e006c0 (LWP 360551)]
>>>>>>      __pthread_kill_implementation (threadid=3D<optimized out>, sign=
o=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
>>>>>>      44      ./nptl/pthread_kill.c: No such file or directory.
>>>>>>      (gdb) bt
>>>>>>      #0  __pthread_kill_implementation (threadid=3D<optimized out>, =
signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.=
c:44
>>>>>>      #1  0x00007ffff4ca9e8f in __pthread_kill_internal (signo=3D6, t=
hreadid=3D<optimized out>) at ./nptl/pthread_kill.c:78
>>>>>>      #2  0x00007ffff4c5afb2 in __GI_raise (sig=3Dsig@entry=3D6) at .=
./sysdeps/posix/raise.c:26
>>>>>>      #3  0x00007ffff4c45472 in __GI_abort () at ./stdlib/abort.c:79
>>>>>>      #4  0x00007ffff6e46ec8 in  () at /lib/x86_64-linux-gnu/libglib-=
2.0.so.0
>>>>>>      #5  0x00007ffff6ea6e1a in g_assertion_message_expr () at /lib/x=
86_64-linux-gnu/libglib-2.0.so.0
>>>>>>      #6  0x00007ffff7fa16e2 in vcpu_resume (id=3D1045790856935220205=
8, cpu_index=3D5) at /home/alex/lsrc/qemu.git/contrib/plugins/ips.c:144
>>>>>>      #7  0x00005555562c3202 in plugin_vcpu_cb__simple (cpu=3D0x55555=
83d9540, ev=3DQEMU_PLUGIN_EV_VCPU_RESUME) at ../../plugins/core.c:111
>>>>>>      #8  0x00005555562c43f7 in qemu_plugin_vcpu_resume_cb (cpu=3D0x5=
555583d9540) at ../../plugins/core.c:523
>>>>>>      #9  0x0000555555d9150e in qemu_wait_io_event (cpu=3D0x5555583d9=
540) at ../../system/cpus.c:465
>>>>>>      #10 0x00005555562c67d0 in mttcg_cpu_thread_fn (arg=3D0x5555583d=
9540) at ../../accel/tcg/tcg-accel-ops-mttcg.c:118
>>>>>>      #11 0x00005555565120ff in qemu_thread_start (args=3D0x555558471=
6e0) at ../../util/qemu-thread-posix.c:541
>>>>>>      #12 0x00007ffff4ca8134 in start_thread (arg=3D<optimized out>) =
at ./nptl/pthread_create.c:442
>>>>>>      #13 0x00007ffff4d287dc in clone3 () at ../sysdeps/unix/sysv/lin=
ux/x86_64/clone3.S:81
>>>>>>      (gdb)
>>>>>> But I don't understand how we can ever hit the idle callback without
>>>>>> first hitting the init callback.
>>>>>>
>>>>>
>>>>> More exactly, the assert we hit means that the idle callback, was not
>>>>> called before the resume callback.
>>>>> Any chance you can check what is the current vcpu->state value? I
>>>>> wonder if it's not an exited cpu, that gets resumed after.
>>>> No when I looked at it it was set as UNKNOWN. Unfortunately it
>>>> doesn't
>>>> trigger if I stick breakpoints in or run under rr.
>>>>
>>>
>>> By using rr record --chaos mode maybe?
>> Ahh yes that triggered it.
>> It looks like we have a race:
>>    (rr) c
>>    Continuing.
>>    Thread 1 hit Hardware watchpoint 7: *(int *) 0x5559ba6899b0
>>    Old value =3D -1
>>    New value =3D 10
>>    machvirt_init (machine=3D0x5559b9ac3c00) at ../../hw/arm/virt.c:2214
>>    2214            numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index]=
, DEVICE(cpuobj),
>>    (rr) c
>>    Continuing.
>>    [New Thread 650125.650142]
>>    [Switching to Thread 650125.650142]
>>    Thread 44 hit Breakpoint 8, mttcg_cpu_thread_fn
>> (arg=3D0x5559ba6896e0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:70
>>    70          assert(tcg_enabled());
>>    (rr) p cpu->cpu_index
>>    $24 =3D 10
>>    (rr) c
>>    Continuing.
>>    [Switching to Thread 650125.650125]
>>    Thread 1 hit Breakpoint 10, cpu_common_realizefn
>> (dev=3D0x5559ba6896e0, errp=3D0x7fff02322c10) at
>> ../../hw/core/cpu-common.c:205
>>    205         Object *machine =3D qdev_get_machine();
>>    (rr) p cpu->cpu_index
>>    $25 =3D 10
>>    (rr) bt
>>    #0  cpu_common_realizefn (dev=3D0x5559ba6896e0, errp=3D0x7fff02322c10=
) at ../../hw/core/cpu-common.c:205
>>    #1  0x00005559b606e6a5 in arm_cpu_realizefn (dev=3D0x5559ba6896e0, er=
rp=3D0x7fff02322c10) at ../../target/arm/cpu.c:2552
>>    #2  0x00005559b63dd5d0 in device_set_realized (obj=3D0x5559ba6896e0, =
value=3Dtrue, errp=3D0x7fff02322d20) at ../../hw/core/qdev.c:510
>>    #3  0x00005559b63e84e7 in property_set_bool (obj=3D0x5559ba6896e0, v=
=3D0x5559ba681540, name=3D0x5559b68fafe1 "realized", opaque=3D0x5559b97f73c=
0, errp=3D0x7fff02322d20)
>>        at ../../qom/object.c:2354
>>    #4  0x00005559b63e6065 in object_property_set (obj=3D0x5559ba6896e0, =
name=3D0x5559b68fafe1 "realized", v=3D0x5559ba681540, errp=3D0x7fff02322d20=
) at ../../qom/object.c:1463
>>    #5  0x00005559b63ead1d in object_property_set_qobject (obj=3D0x5559ba=
6896e0, name=3D0x5559b68fafe1 "realized", value=3D0x5559ba681420, errp=3D0x=
5559b7810320 <error_fatal>)
>>        at ../../qom/qom-qobject.c:28
>>    #6  0x00005559b63e640a in object_property_set_bool (obj=3D0x5559ba689=
6e0, name=3D0x5559b68fafe1 "realized", value=3Dtrue, errp=3D0x5559b7810320 =
<error_fatal>)
>>        at ../../qom/object.c:1533
>>    #7  0x00005559b63dccbd in qdev_realize (dev=3D0x5559ba6896e0, bus=3D0=
x0, errp=3D0x5559b7810320 <error_fatal>) at ../../hw/core/qdev.c:291
>>    #8  0x00005559b5fe4243 in machvirt_init (machine=3D0x5559b9ac3c00) at=
 ../../hw/arm/virt.c:2295
>>    #9  0x00005559b5ada5d6 in machine_run_board_init (machine=3D0x5559b9a=
c3c00, mem_path=3D0x0, errp=3D0x7fff02322f30) at ../../hw/core/machine.c:15=
76
>>    #10 0x00005559b5eb416f in qemu_init_board () at ../../system/vl.c:2621
>>    #11 0x00005559b5eb4482 in qmp_x_exit_preconfig (errp=3D0x5559b7810320=
 <error_fatal>) at ../../system/vl.c:2713
>>    #12 0x00005559b5eb7088 in qemu_init (argc=3D35, argv=3D0x7fff02323268=
) at ../../system/vl.c:3759
>>    #13 0x00005559b63d7ff2 in main (argc=3D35, argv=3D0x7fff02323268) at =
../../system/main.c:47
>> Because looking at the order things happen in the specific CPU
>> realisation:
>>      qemu_init_vcpu(cs);
>>      cpu_reset(cs);
>>      acc->parent_realize(dev, errp);
>> And the common realize function doesn't get to do:
>>      /* Plugin initialization must wait until the cpu start
>> executing code */
>> #ifdef CONFIG_PLUGIN
>>      if (tcg_enabled()) {
>>          cpu->plugin_state =3D qemu_plugin_create_vcpu_state();
>>          async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_=
NULL);
>>      }
>> #endif
>> before we've started executing.....
>>=20
>
> Thanks for the analysis Alex.
> It seems to me this is integrating the recent series from Philippe.
> Maybe the race has been introduced there.
> Could you try without this series?

No this is based off master and I think the race has always been there.
I think I was just triggering because I was using -smp 32 for some bit
system simulations. See:

  Message-Id: <20240529152219.825680-1-alex.bennee@linaro.org>
  Date: Wed, 29 May 2024 16:22:19 +0100
  Subject: [RFC PATCH] cpus: split qemu_init_vcpu and delay vCPU thread cre=
ation
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

