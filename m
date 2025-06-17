Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA7EC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSpx-0007mu-7x; Tue, 17 Jun 2025 05:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRSpv-0007mb-3t
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:42:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRSps-0000I4-RK
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:42:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so1973877f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750153349; x=1750758149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpX+41cuYJ64cPAY0HRIradoI+iSxfE6YBLLbmgMbuQ=;
 b=CPqzDXzco3iJCWFoJ20cLANTJbO8O1hgwV7vhPoU3RiyZlfc9ls5GWXSylT+XXNtqu
 7g5yycOeSrbNXeDmV47zGoLEQgWbzOXjqTl304p/LZNEm9AkOKppS5k72V9B61T1p+J1
 5Kck8teQKTQXi41RRrMVjxv0hWyP+IaqPw+aLcUoHyKXdNeAlPFfn2xjxNgOYqa/wqq/
 kgwhx4Ly2UZL6QjeYBNgyhP87lekgn6pxUNyTwHgMvnO9RaseiNhJNax0RecsNBqzyc8
 x7EMeLX+V0h5Lec0YrjqZNXN3/O6sfssHtjaN9k2OVPailSw4tT6o7iLrZkdmroxGguy
 829w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750153349; x=1750758149;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TpX+41cuYJ64cPAY0HRIradoI+iSxfE6YBLLbmgMbuQ=;
 b=YaeZMH92kotVRq+i4Ye/xcTNAIkew3E5p8i2Z5MPag0Uv2l9BqsX5uhtz33iXRWVpY
 PYgCm8l1+1i0mCAL6FLErjazWP4qXjttGdUVB/OS5TSWEEpLGjS6y+XaFScn+DEq66V7
 dixRWNAKlnhnXwOEh6swC6sA7u/60KDMoji7DMNLxfGYOFMTy9kbs15pUvQU9lsrlI39
 39fgpgDcV5NE0dpQa93FQqLzW0gQ5pvgJAaenleyKEltM7WcBGo1Q16GCpLn2up68k2B
 kM8NAoOgDmYiygww5fWMlLSuVttLV/qhpSL9FkSd+njK7PvnN+sCzi1cFyaMxv9n8b5c
 uO3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDULxw/WhfRrj4PM/cbKI5sjBmccmaFLKfatZDdUNDMIz+FWdFE3EnKE8iC78AbRF2AsnWKRESaHcY@nongnu.org
X-Gm-Message-State: AOJu0YxiwHi+c7PcnTsn5yom+ZiBbGsXdBmVH6ciOqHKYDHkZ2fVkLNH
 wlmrS6Xa+iF08YhvOFw4vZtZUexCIPumFPBF6GFiwYnUbFxJR/rglaiE/k/K3fhCDck=
X-Gm-Gg: ASbGncsXr4g+wrf61xYNPZdUxlHeKR68+Ga87cQ5CUvSI43yY7g0GMlGKGCPfu3E2/L
 ZcHdm701bZeSrGBqoml1+WQIsAOuv858OXUipo32Lb0KVTEG9NHvqtyHhpjKdU4iKg8Hx9MUIsL
 oSwBevKJWP/e9VlUlvtXq1URmYDdvalQQ1Y+TY4n9CuO3T1HOPxoL/s36Wjc6wxF4jNfm7+9IRs
 HvedD5ABxcZ93olUugcTmaIb5lLm3eK0dZMNezFYp6IOtFuL+t0nor/3KityNdCdovnTMVFelxn
 LZP3x10Uu1ef7wyY67/YoYjR1GtAuCfH3KQnJY6YWcDhYN8VKGt0I3zY0xA5IeVYoWedlEtZZQ=
 =
X-Google-Smtp-Source: AGHT+IEjVbVAOG8dYVgR9yC/zGkQLT1dThoT59oFCBqukSMLkU+OuSDMy8jXfe/2WvTihSM96wf9Iw==
X-Received: by 2002:a05:6000:2486:b0:3a5:2465:c0c8 with SMTP id
 ffacd0b85a97d-3a5723978aamr10146278f8f.7.1750153349317; 
 Tue, 17 Jun 2025 02:42:29 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532dea1c27sm169389805e9.15.2025.06.17.02.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 02:42:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D98F85F834;
 Tue, 17 Jun 2025 10:42:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 02/19] system/cpus: Only kick running vCPUs
In-Reply-To: <9ec68c71-c53d-495f-b7ab-6061ea727dd0@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 16 Jun 2025 10:21:28
 +0200")
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-3-philmd@linaro.org>
 <c9a8d923-0faf-46a4-962b-5a0f4289008f@linaro.org>
 <9ec68c71-c53d-495f-b7ab-6061ea727dd0@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 17 Jun 2025 10:42:27 +0100
Message-ID: <87sejyvh4s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 7/6/25 15:23, Richard Henderson wrote:
>> On 6/6/25 17:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>> As an optimization, avoid kicking stopped vCPUs.

This also breaks gdbstub:

 pause_all_vcpus() -> cpu_pause(sets cpu->stop) -> qemu_cpu_kick(skips kick=
ing)

>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>> =C2=A0 system/cpus.c | 5 +++++
>>> =C2=A0 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/system/cpus.c b/system/cpus.c
>>> index d16b0dff989..4835e5ced48 100644
>>> --- a/system/cpus.c
>>> +++ b/system/cpus.c
>>> @@ -494,6 +494,11 @@ void cpus_kick_thread(CPUState *cpu)
>>> =C2=A0 void qemu_cpu_kick(CPUState *cpu)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_cond_broadcast(cpu->halt_cond);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!cpu_can_run(cpu)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>> This would appear to be a race condition.=C2=A0 The evaluation of
>> cpu_can_run should be done within the context of 'cpu', not here,
>> and not *after* we've already woken 'cpu' via the broadcast.
>
> OK.
>
> Still I don't understand something, when putting this assertion:
>
> -- >8 --
> diff --git a/system/cpus.c b/system/cpus.c
> index d16b0dff989..0631015f754 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -493,7 +493,10 @@ void cpus_kick_thread(CPUState *cpu)
>
>  void qemu_cpu_kick(CPUState *cpu)
>  {
> +    assert(cpu_can_run(cpu));
> +
>      qemu_cond_broadcast(cpu->halt_cond);
>      if (cpus_accel->kick_vcpu_thread) {
>          cpus_accel->kick_vcpu_thread(cpu);
>      } else { /* default */
> ---
>
> I get:
>
> (lldb) bt
> * thread #1, queue =3D 'com.apple.main-thread', stop reason =3D hit
>   program assert
>     frame #0: 0x000000018a669388 libsystem_kernel.dylib`__pthread_kill + 8
>     frame #1: 0x000000018a6a288c libsystem_pthread.dylib`pthread_kill + 2=
96
>     frame #2: 0x000000018a5abc60 libsystem_c.dylib`abort + 124
>     frame #3: 0x000000018a5aaeec libsystem_c.dylib`__assert_rtn + 284
>   * frame #4: 0x000000010057ddc4 qemu_cpu_kick(cpu=3D0x0000000130218000)
>     at cpus.c:496:5
>     frame #5: 0x00000001000106ec
>     queue_work_on_cpu(cpu=3D0x0000000130218000, wi=3D0x000060000038c000)
>     at cpu-common.c:140:5
>     frame #6: 0x0000000100010780
>     async_run_on_cpu(cpu=3D0x0000000130218000, func=3D(tcg_commit_cpu at
>     physmem.c:2758), data=3D(host_int =3D 60885632, host_ulong =3D
>     105553177152128, host_ptr =3D 0x0000600003a10a80, target_ptr =3D
>     105553177152128)) at cpu-common.c:177:5
>     frame #7: 0x000000010059ad34
>     tcg_commit(listener=3D0x0000600003a10a98) at physmem.c:2789:9
>     frame #8: 0x0000000100591240
>     listener_add_address_space(listener=3D0x0000600003a10a98,
>     as=3D0x0000600003611980) at memory.c:3082:9
>     frame #9: 0x0000000100590f48
>     memory_listener_register(listener=3D0x0000600003a10a98,
>     as=3D0x0000600003611980) at memory.c:3170:5
>     frame #10: 0x000000010059abe4
>     cpu_address_space_init(cpu=3D0x0000000130218000, asidx=3D0,
>     prefix=3D"cpu-memory", mr=3D0x000000012b1faba0) at physmem.c:813:9
>     frame #11: 0x0000000100750c40
>     arm_cpu_realizefn(dev=3D0x0000000130218000, errp=3D0x000000016fdfe2c0)
>     at cpu.c:2572:5
>     frame #12: 0x0000000100b7ed9c
>     device_set_realized(obj=3D0x0000000130218000, value=3Dtrue,
>     errp=3D0x000000016fdfe388) at qdev.c:494:13
>     frame #13: 0x0000000100b8a880
>     property_set_bool(obj=3D0x0000000130218000, v=3D0x0000600003f12d00,
>     name=3D"realized", opaque=3D0x000060000010c1d0,
>     errp=3D0x000000016fdfe388) at object.c:2375:5
>     frame #14: 0x0000000100b87acc
>     object_property_set(obj=3D0x0000000130218000, name=3D"realized",
>     v=3D0x0000600003f12d00, errp=3D0x000000016fdfe388) at object.c:1450:5
>     frame #15: 0x0000000100b8f14c
>     object_property_set_qobject(obj=3D0x0000000130218000,
>     name=3D"realized", value=3D0x0000600000386920,
>    errp=3D0x0000000101e39e28) at qom-qobject.c:28:10
>     frame #16: 0x0000000100b882f8
>     object_property_set_bool(obj=3D0x0000000130218000, name=3D"realized",
>     value=3Dtrue, errp=3D0x0000000101e39e28) at object.c:1520:15
>     frame #17: 0x0000000100b7d240 qdev_realize(dev=3D0x0000000130218000,
>     bus=3D0x0000000000000000, errp=3D0x0000000101e39e28) at qdev.c:276:12
>     frame #18: 0x000000010083a81c
>     machvirt_init(machine=3D0x000000012b1fa710) at virt.c:2329:9
>     frame #19: 0x0000000100136a40
>     machine_run_board_init(machine=3D0x000000012b1fa710,
>     mem_path=3D0x0000000000000000, errp=3D0x000000016fdfe6a8) at
>    machine.c:1669:5
>     frame #20: 0x0000000100571384 qemu_init_board at vl.c:2714:5
>     frame #21: 0x0000000100571154
>     qmp_x_exit_preconfig(errp=3D0x0000000101e39e28) at vl.c:2808:5
>     frame #22: 0x0000000100573a14 qemu_init(argc=3D17,
>     argv=3D0x000000016fdff138) at vl.c:3844:9
>     frame #23: 0x0000000100d036e0 main(argc=3D17,
>     argv=3D0x000000016fdff138) at main.c:71:5
>     frame #24: 0x000000018a302b98 dyld`start + 6076
> (lldb)
>
> I expect a vCPU to be in a "stable" state and usable *after* it is
> realized, as we are calling various hooks in many places. Here we are
> processing the pending work queue while the vCPU isn't fully realized,
> so some hooks might not have been called yet...
>
> Git history of tcg_commit() points to commit 0d58c660689 ("softmmu: Use
> async_run_on_cpu in tcg_commit").
> This isn't the first time I ends there, see also:
> https://lore.kernel.org/qemu-devel/20230907161415.6102-1-philmd@linaro.or=
g/.
> Using the same reasoning of this patch, adding:
>
> -- >8 --
> diff --git a/system/physmem.c b/system/physmem.c
> index a8a9ca309ea..479a7a88037 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2773,6 +2774,14 @@ static void tcg_commit(MemoryListener *listener)
>      cpuas =3D container_of(listener, CPUAddressSpace, tcg_as_listener);
>      cpu =3D cpuas->cpu;
>
> +    if (!qdev_is_realized(DEVICE(cpu))) {
> +        /*
> +         * The listener is also called during realize, before
> +         * all of the tcg machinery for run-on is initialized.
> +         */
> +        return;
> +    }
> +
>      /*
>       * Defer changes to as->memory_dispatch until the cpu is quiescent.
>       * Otherwise we race between (1) other cpu threads and (2) ongoing
> ---
>
> makes my issues disappear; tcg_commit_cpu() calls are run on realized
> vCPUs, and the order of pre-realize vcpu hooks doesn't alter anything.
>
> I don't remember why I wrote this "The listener is also called during
> realize, before all of the tcg machinery for run-on is initialized"
> comment, it could be better to call memory_region_transaction_commit()
> after CpuRealize, maybe in CpuReset.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

