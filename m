Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1ECC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thcVs-0006hJ-Mp; Mon, 10 Feb 2025 17:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1thcVq-0006gq-9g; Mon, 10 Feb 2025 17:44:22 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1thcVn-0007lk-Qd; Mon, 10 Feb 2025 17:44:21 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab78e6edb48so509340166b.2; 
 Mon, 10 Feb 2025 14:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739227456; x=1739832256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMiOfTbKGdUSnrzjPYFyrwRord+4epbRH65Zn+Id4C0=;
 b=YL+Nz8LijkkuesG5JCpko2/2i/zaF3tGojcMPeYnpIAbzDuzFLeL2pKT/IJqCf+iWq
 fkFcfmJMwMjNnClElBejmjpQ1eAOeQfFgc7MaTEfEYXf7zS4XFnZslqHPMjkwPzPEl5C
 vaYyfsHLF7SakIsL5R1c0rMF+q0Ed63P8UnYqLaIbMW68RF/y4EeGRxJS14lCGwG3N+1
 MzDDXlSN0/hpwK6l7JQFV4ch3FkamMjTXj1Sh/CwoO2Z0569uLzbbqf8Afr0LEbNNZKk
 gWqIP1AFpvsXr/9cRXWkQAAL1M88c6iWSYuLZYNsxUCQqxog1EijMFIxnoDwQT/S8vFQ
 KIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739227456; x=1739832256;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMiOfTbKGdUSnrzjPYFyrwRord+4epbRH65Zn+Id4C0=;
 b=TRINufgE7B8ymYMmUHeHMSx439ZQb29HofL4xV34kvclAr5TCdU/8ofbu/xcWRUaii
 syXqjnXtzg1aGli1yY+5VfwvvKetCKSss/FS1/S/Y5Nid695OXRCp4NMWxBRr//axJx5
 j7Sq91z297XzfwYX37154nuK2pip3M+O2B429B+UPn5h6jGwysiBaWFHC0frGIAAcjhE
 x5x/9N+g1udT4u2MT/rQ9CPPykFXU961GpqnvRfcc8Hu2Q96qvG3LIOVYhy5d3jIbtIz
 v5lpe7QYIGGUs2jBWkz7xEZ4tZBuR+4fS4OPll4BcmO2RqXDqH0NgNp9Puc/za1NELeA
 z8CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ubXESq+j8YWNmtOZ5TtXgqQFZbWO5STb2VCzxpr7NLEgBtFuNz7skCVqRYpotfVIu4GtoVbGhw==@nongnu.org
X-Gm-Message-State: AOJu0YwptgtMVFcH0yuuSI0SrAzxSNn5Bx4wtXx8HbhelQKNBhk7h66d
 wEccnK2z/Z8xvu9h7opbTwFnGiVt60z3sZP/iN6783CJ9T3mnBeF
X-Gm-Gg: ASbGnctPCUK9iEAYsvso7z8/njMJKuIUqh6leX5CB//WqUhM7EPUZN0JK6Xri6GrfSH
 vLtzWZIraM8pvZAptFItLielpStbmbuVjV5mPh6Zre3eVgjpTTxW1r4QC31t6FMD6tneTapVHKs
 24dS/adA8vUichcfSdOwKiKvMgpEuFVCk6M7tERTrl8swb22GKUtktmeqR20f3lX12pxcJk7Nrv
 lUOG97VY6lDRfg4XY3nmZZfUNWtwgqCwQxC6H60wg18Zdwtp5Npxb5BX86GMzCA/m18Bfdfx8CO
 Ka3V4BEvaLBMUjBcw8z3oI+F6koDCpTORC1YuLAkfo8blt/Gk/4tgdA4bkn7TVJ4
X-Google-Smtp-Source: AGHT+IHwj0qNpDxKF4rPs4Wtn+vWMG+Gv+GnIgvQUOT+M4GD/DNJE3+5WZ3BhkvLWKddo+M6cH1SuQ==
X-Received: by 2002:a05:6402:e83:b0:5dc:d8d2:e38f with SMTP id
 4fb4d7f45d1cf-5de450839f3mr41330141a12.31.1739227456244; 
 Mon, 10 Feb 2025 14:44:16 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-086-138.78.54.pool.telefonica.de.
 [78.54.86.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab779832909sm901409966b.49.2025.02.10.14.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:44:15 -0800 (PST)
Date: Mon, 10 Feb 2025 22:44:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
In-Reply-To: <CAFEAcA8qgEDAnfaQDmpUjy77KZBiqwdKSmyLE-ZwEAhMNLWn4Q@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-5-shentey@gmail.com>
 <CAFEAcA8qgEDAnfaQDmpUjy77KZBiqwdKSmyLE-ZwEAhMNLWn4Q@mail.gmail.com>
Message-ID: <831901E4-69B2-4637-8507-77C7BF4DA65D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 10=2E Februar 2025 17:30:01 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> As a first step, implement the bare minimum: CPUs, RAM, interrupt contr=
oller,
>> serial=2E All other devices of the A53 memory map are represented as
>> TYPE_UNIMPLEMENTED_DEVICE, i=2Ee=2E the whole memory map is provided=2E=
 This allows
>> for running Linux without it crashing due to invalid memory accesses=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>
>
>
>> --- /dev/null
>> +++ b/docs/system/arm/imx8mp-evk=2Erst
>> @@ -0,0 +1,56 @@
>> +NXP i=2EMX 8M Plus Evaluation Kit (``imx8mp-evk``)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The QEMU i=2EMX 8M Plus EVK board emulation is intended to emulate a p=
lain i=2EMX 8M
>> +Plus system on chip (SoC)=2E All peripherals the real board has such a=
s flash and
>> +I2C devices are intended to be added via configuration, e=2Eg=2E comma=
nd line=2E
>
>Why do this? If they're on the real hardware board, we should
>be creating them by default in the machine model in QEMU=2E
>Command line options are for devices that are optional and
>pluggable by the user on the hardware=2E

My goal is to be able to model a custom, proprietary machine which runs in=
 a CI=2E In order to avoid peripherals getting in the way, the idea is to h=
ave a machine which essentially exposes the plain SoC, and allow users to "=
decorate" it themselves=2E Is an EVK machine the wrong approach for this? A=
re there any other ways to achieve this, e=2Eg=2E with -nodefaults?

>
>> +Supported devices
>> +-----------------
>> +
>> +The ``imx8mp-evk`` machine implements the following devices:
>> +
>> + * Up to 4 Cortex-A53 Cores
>
>"cores"

Fixed in v3=2E

>
>> + * Generic Interrupt Controller (GICv3)
>> + * 4 UARTs
>> +
>> +Boot options
>> +------------
>> +
>> +The ``imx8mp-evk`` machine can start using the standard -kernel functi=
onality
>> +for loading a Linux kernel=2E
>> +
>> +Direct Linux Kernel Boot
>> +''''''''''''''''''''''''
>> +
>> +Probably the easiest way to get started with a whole Linux system on t=
he machine
>> +is to generate an image with Buildroot=2E Version 2024=2E11=2E1 is tes=
ted at the time
>> +of writing and involves two steps=2E First run the following commands =
in the
>> +toplevel directory of the Buildroot source tree:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ echo "BR2_TARGET_ROOTFS_CPIO=3Dy" >> configs/freescale_imx8mpevk_d=
efconfig
>> +  $ make freescale_imx8mpevk_defconfig
>> +  $ make
>> +
>> +Once finished successfully there is an ``output/image`` subfolder=2E N=
avigate into
>> +it patch the device tree needs to be patched with the following comman=
ds which
>> +will remove the ``cpu-idle-states`` properties from CPU nodes:
>
>This sentence seems to be confused in the middle -- cut-and-paste
>error ?

Yeah, probably=2E Fixed in v3=2E

>
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ dtc imx8mp-evk=2Edtb | sed '/cpu-idle-states/d' > imx8mp-evk-patch=
ed=2Edts
>> +  $ dtc imx8mp-evk-patched=2Edts -o imx8mp-evk-patched=2Edtb
>> +
>> +Now that everything is prepared the newly built image can be run in th=
e QEMU
>> +``imx8mp-evk`` machine:
>
>> +#define NAME_SIZE 20
>> +
>> +static void fsl_imx8mp_init(Object *obj)
>> +{
>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    FslImx8mpState *s =3D FSL_IMX8MP(obj);
>> +    char name[NAME_SIZE];
>
>Better than fixed sized char arrays for object names
>is to use
>   g_autofree char *name =3D g_strdup_printf("cpu%d", i);
>inside the block of each for() loop etc=2E

Will fix for v3, touching subsequent patches=2E

>
>> +    int i;
>> +
>> +    for (i =3D 0; i < MIN(ms->smp=2Ecpus, FSL_IMX8MP_NUM_CPUS); i++) {
>> +        snprintf(name, NAME_SIZE, "cpu%d", i);
>> +        object_initialize_child(obj, name, &s->cpu[i],
>> +                                ARM_CPU_TYPE_NAME("cortex-a53"));
>> +    }
>> +
>> +    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
>> +
>> +    for (i =3D 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
>> +        snprintf(name, NAME_SIZE, "uart%d", i + 1);
>> +        object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIA=
L);
>> +    }
>> +}
>> +
>> +static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>> +{
>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>> +    FslImx8mpState *s =3D FSL_IMX8MP(dev);
>> +    DeviceState *gicdev =3D DEVICE(&s->gic);
>> +    int i;
>> +
>> +    if (ms->smp=2Ecpus > FSL_IMX8MP_NUM_CPUS) {
>> +        error_setg(errp, "%s: Only %d CPUs are supported (%d requested=
)",
>> +                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp=2Ecpu=
s);
>> +        return;
>> +    }
>> +
>> +    /* CPUs */
>> +    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>> +        /* On uniprocessor, the CBAR is set to 0 */
>> +        if (ms->smp=2Ecpus > 1) {
>> +            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>> +                                    fsl_imx8mp_memmap[FSL_IMX8MP_GIC_D=
IST]=2Eaddr,
>> +                                    &error_abort);
>> +        }
>> +
>> +        /*
>> +         * Magic value from Linux output: "arch_timer: cp15 timer(s) r=
unning at
>> +         * 8=2E00MHz (phys)"=2E
>> +         */
>> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>> +                                &error_abort);
>
>This is the CNTFRQ value in Hz=2E The datasheet actually tells you
>this, so we don't need to call it a magic number (section 4=2E11=2E4=2E1=
=2E6=2E4
>of the i=2EMX 8M Plus Applications Processor Reference Manual says the
>base frequency of the system counter is 8MHz)=2E

Ah, so then it's the "nxp,sysctr-timer"-compatible counter in the device t=
ree? I've stared my own implementation but didn't see the relation to the c=
p15 timer=2E Thanks for clarifying this=2E I'd comment: 'CNTFID0 base frequ=
ency in Hz'=2E

>
>(Incidentally the memory mapped system counter is a stock Arm
>IP block and I have about 60% of a model of it, I just haven't
>needed to upstream it yet because in practice no guest software
>really tries to mess with it=2E If we turn out to need it for
>this SoC that would be a reason for me to clean it up and
>send it out=2E But I suspect we don't need it in practice=2E)

The ugly workaround for the cpu-idle-states above is actually related to t=
his counter, IIUC=2E I suppose that QEMU doesn't support these idle states,=
 it only seems to support WFI=2E But if it did, then this counter would wak=
e up the CPUs (if I'm not mistaken, I'm no expert here)=2E It would be nice=
 to be able to boot the machine via U-Boot, and I wonder if that could fix =
the idle states when there are PSCI handlers in the secure world=2E Again, =
this probably also requires the counter implementation=2E Looking into U-Bo=
ot, TF-A, and OP-TEE is on my plan, but right now I'm focusing on direct ke=
rnel boot=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

