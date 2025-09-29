Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DE3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3HpH-0006Ld-Lm; Mon, 29 Sep 2025 13:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1v3HpG-0006LP-87
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 13:38:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1v3HpB-0007lG-L7
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 13:38:13 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3e74c6de6f7so618667f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759167484; x=1759772284; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V52Crn6Nz00R+bIQosCcIfTtiYqYITWKRc8t6+yTbUQ=;
 b=I8quUPZdCyhlMrB2CisVx7sG1PP/D6+EH8J8vW/1iCatEFFZXu+JbhD0XaC3X+okNQ
 I55AVyjhOAv4PfquWxLYmlcs6wZDoaDtkoUygImV2EGAhOwQhYE+kolZ3bwF+pf1Q02r
 mMaMho2UBAZa36Euf6JlL4lHg1SGMh8WfhJmuaZxMouOKowhGs3eKJX9qmJOG7z5UD9J
 LEiT1W/+aCnwgaj9er8/5UidhgyS5L7uasPgZW0FM+Ts9xIl1yETJN/EMxrqc27SZOY9
 TK4SNppYU6sZQ04bTisY51PLSerzum0bDZGaPQCcBnIMpVQZ/lhQX0AZmMymi1FxJzV1
 bB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759167484; x=1759772284;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V52Crn6Nz00R+bIQosCcIfTtiYqYITWKRc8t6+yTbUQ=;
 b=ftTT9zL7neReJ4bUsCT9mA7YoRdl+Z6v0RL17kf0971yIcnu/KNAMAp4gu6hEcUhtQ
 v/QP6IoVnrhGLdzRh42Z+u2KWYJFEhBe1wH26N2p+oOzUBj24G89FnHduMCWmfOB6A9J
 lvBupYzVFZ0b3DaOcNAIQYSlZiTUZ5ieelV3l1QZH8IqCPf5z4Y8361bPH6xLGpD/I6r
 HF8xxfxckYbOPA4Eklzu28GEkhSvz2iAlqAVtb8y0U/AV+v1doH5iUi1ADQqE8sVJb7I
 LtQOgE4G8EEHgUwfNZugECgImXXwoOa0t46aW86P+Psm6luDtfrjP9PutUfEJFP+AtuL
 Gv6Q==
X-Gm-Message-State: AOJu0Ywkzte8vZJfaIxPYycalN5ppgBv/1Olx2m/acQ1+02hALnGFOyv
 Ap6oajSOSWYTP78FDRdRHGPE7waAyr7n1e+LTtx2fEt8PBHqEPWEMr+muuI6ja8COYo=
X-Gm-Gg: ASbGncso8rWSfyArNbJfu9YK3KB7sm/qym4L6zK2+8IuSOncUJoUHXS+nMMXPsQYe2L
 GsXGAAQ9pZvOaPv/W5Vow4Xo3KRrQSkVgC+zxoGTPZqsh5HnjMmAKCotfeAF9julPaogEpFcJtI
 3eoTgIjXQLzLs55jUkX4TtWtItuAmI9NoE8O8W2X/IENUFwuSIG83i3B9CMBOvz3Hh22Yx/+NEJ
 6egu4D5b6DPnQiqFn+KSDRv3HQnIKUWVtPapiF2KH/5pvm0dZVO7kTFJWokHGjOoQcHzlEIOaLF
 HzndKIpIsYfZ0+l4pG1vTTxHA4WxUSNr3zHWMMLdRem//sQDlFPPgRIjw/8keqW8ws/Kr70zxRG
 PtZxbEJ1J5QY=
X-Google-Smtp-Source: AGHT+IG7iJS7gF0moqttIOHNgFk6bj8EUtz/kbXO7BG75tJlqkGduicQcAwp/3dxbvzxI44fqmqNjQ==
X-Received: by 2002:a05:600c:8b5b:b0:46e:3dc2:ebae with SMTP id
 5b1f17b1804b1-46e3dc2ee1cmr69936275e9.5.1759167483867; 
 Mon, 29 Sep 2025 10:38:03 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::bfbb])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-46e56f64d06sm21182395e9.12.2025.09.29.10.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:38:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 19:36:58 +0200
Message-Id: <DD5GSZ9KWEIJ.2GLJ40HGEWWM1@ventanamicro.com>
Subject: Re: [PATCH v9 1/2] Set KVM initial privilege mode and mp_state
Cc: <qemu-devel@nongnu.org>, <ajones@ventanamicro.com>,
 <qemu-riscv@nongnu.org>, <pbonzini@redhat.com>, <anup@brainfault.org>,
 <alistair.francis@wdc.com>, <palmer@dabbelt.com>, <xiamy@ultrarisc.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Alistair Francis" <alistair23@gmail.com>, "Xie Bo" <xb@ultrarisc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20250915070811.3422578-2-xb@ultrarisc.com>
 <CAKmqyKMMo0XfaEsTYqpsV8UfXkhM5YHZsCdptFVR5pSYM1KRxQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMMo0XfaEsTYqpsV8UfXkhM5YHZsCdptFVR5pSYM1KRxQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-09-29T11:48:08+10:00, Alistair Francis <alistair23@gmail.com>:
> On Mon, Sep 15, 2025 at 5:08=E2=80=AFPM Xie Bo <xb@ultrarisc.com> wrote:
>>
>> For KVM mode, the privilege mode should not include M-mode, and the
>> initial value should be set to S-mode. Additionally, a following patch
>> adds the implementation of putting the vCPU privilege mode to KVM.
>> When the vCPU runs for the first time, QEMU will first put the privilege
>> state to KVM. If the initial value is set to M-mode, KVM will encounter
>> an error.
>>
>> In addition, this patch introduces the 'mp_state' field to RISC-V
>> vCPUs, following the convention used by KVM on x86. The 'mp_state'
>> reflects the multiprocessor state of a vCPU, and is used to control
>> whether the vCPU is runnable by KVM. Randomly select one CPU as the
>> boot CPU. Since each CPU executes the riscv_cpu_reset_hold() function
>> and CPU0 executes first, only CPU0 randomly selects the boot CPU.
>>
>> Signed-off-by: Xie Bo <xb@ultrarisc.com>
>> ---
>>  target/riscv/cpu.c | 17 ++++++++++++++++-
>>  target/riscv/cpu.h |  2 ++
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> This fails to build with the following error, it seems an include is miss=
ing
>
> ../target/riscv/cpu.c: In function =E2=80=98riscv_cpu_reset_hold=E2=80=99=
:
> ../target/riscv/cpu.c:711:25: error: =E2=80=98KVM_MP_STATE_RUNNABLE=E2=80=
=99
> undeclared (first use in this function)
>  711 |         env->mp_state =3D KVM_MP_STATE_RUNNABLE;
>      |                         ^~~~~~~~~~~~~~~~~~~~~
> ../target/riscv/cpu.c:711:25: note: each undeclared identifier is
> reported only once for each function it appears in
> ../target/riscv/cpu.c:713:25: error: =E2=80=98KVM_MP_STATE_STOPPED=E2=80=
=99 undeclared
> (first use in this function); did you mean =E2=80=98S390_CPU_STATE_STOPPE=
D=E2=80=99?
>  713 |         env->mp_state =3D KVM_MP_STATE_STOPPED;
>      |                         ^~~~~~~~~~~~~~~~~~~~
>      |                         S390_CPU_STATE_STO

I think this is because the code belongs in kvm_riscv_reset_vcpu().

>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> +    static int boot_cpu_index;
>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    if (cs->cpu_index =3D=3D 0) {
>> +        boot_cpu_index =3D g_random_int_range(0, ms->smp.cpus);
>> +    }

If we're already touching the code, can we also express boot_cpu_index
in a VM state?  Using a static variable is pretty scary.

Thanks.

