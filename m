Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FA2CCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 19:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stXhT-0006S0-6a; Wed, 25 Sep 2024 15:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh7-00065D-UG; Wed, 25 Sep 2024 15:29:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh4-0001wc-Gj; Wed, 25 Sep 2024 15:29:01 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8ce5db8668so32124466b.1; 
 Wed, 25 Sep 2024 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727292536; x=1727897336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mg74pexZQVTEGPDGWQhe3MOWTkYe255JTpYjTNv1AQs=;
 b=UaKwXaDbi0s7w1wPoMEyDq7jcV52qXDMV7xEg8aRIqfPwK4WH0twCnVeILq8eTdtnU
 NrhcD5c2X/lA5Idwqi+fW7gFkS1s/VZYjsf65WCOQlh+i+i/dWeGk8Sxnz30EE9ERhWp
 4nc4pEqIhe0cnYgQCBP57EyMA1apnBcxlQxbzX4SmheducJ9nQE2zidSnTiag4Co8PW6
 AwF7WLwQStvxS1PZUd2M5TSNOIiM0Je66+WS1I4iStNf7Jm3AeoZEb91S1YfYFZQ1yom
 tKQ37HjgoP09CpXlY6SnYAxGwN2IFquLnzYl4DlSGmdlI7ecDD6YGsxbfvAxwCJAddwe
 RGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727292536; x=1727897336;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mg74pexZQVTEGPDGWQhe3MOWTkYe255JTpYjTNv1AQs=;
 b=UVCWk6vp6kc5qg5OpiB2ezaA3+w+gDTV1i3ctlakOhVgepVKkCICnpbwlZy11+1ggT
 z0aOOHv7fgYsyHsCle0wgj46O4NV/Rp3v3dO+W24YXRSjbnP8znrNCvijmRIKoJRHrKF
 IvN9zyQ3nDL9RVDxQYNNEw95LL+HybMqkv5+uGBgfu1KYmeOE4F044+eKl4hThZjfOFE
 OX5eCnJVnMm3J3cmwDxRuh5h9NPmQXNii/vYWbAZ/v4EPVfc1E9SN+QDca8Qphxs2Vua
 Ba6hvin6eKSGOK0l+slDSExaGsXl1ZaZc/M9HvWJWyP4Lducm+NyWw1MrLf32ocKvXSh
 DxSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdwAV2g0wMIJOeFTsiFv8+ISX04PXqh2EcQIdRnwEjJww8nuG9Y/osIRSPwVqpxw9K+Z2FdJ4AMYf2+w==@nongnu.org,
 AJvYcCWq2Yh59s0dXU2bRIhuGdfFuH9Td7McgM2ZzQIrfd8JdIuDzxNopkNtGU2yMNv+3DYW6o8LFcPajB7E@nongnu.org,
 AJvYcCXRKkKU+DePU0GHmqM24P7l/Wlu42HndRBiMUjT+Iz6k5FDk5P5xWd7qj12K2IvGPOTniXthM17bng=@nongnu.org
X-Gm-Message-State: AOJu0YwcJobxQ1gUnhSb92NwxsWnIZvG7gWLcfnX2CY15dSS5VdnM5vt
 6mPAsWvGI4QokS4TJBRmvZxJTcCESu1Zwzf4rk1qmlzJXTFrC2c5
X-Google-Smtp-Source: AGHT+IFIDzUskRFoEacWXBZVclm5bn5PTmav9Z+bnMT0ShXzl+/0qAwUr+TAzaO+GnMVzhChYqC76Q==
X-Received: by 2002:a17:907:ea8:b0:a90:c411:24f8 with SMTP id
 a640c23a62f3a-a93a03380dfmr414025066b.2.1727292536132; 
 Wed, 25 Sep 2024 12:28:56 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-049-158.77.11.pool.telefonica.de.
 [77.11.49.158]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f51e82sm249305966b.71.2024.09.25.12.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 12:28:55 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:02:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
CC: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 02/23] hw/ppc/e500: Reduce scope of env pointer
In-Reply-To: <9ee5b660-c3d1-49a4-8123-e15219fe2d60@redhat.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-3-shentey@gmail.com>
 <9ee5b660-c3d1-49a4-8123-e15219fe2d60@redhat.com>
Message-ID: <22897BC3-DDAC-4EEC-83DE-41B573232DF9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 25=2E September 2024 15:37:22 UTC schrieb "C=C3=A9dric Le Goater" <clg@=
redhat=2Ecom>:
>On 9/23/24 11:29, Bernhard Beschow wrote:
>> The env pointer isn't used outside the for loop, so move it inside=2E A=
fter that,
>> the firstenv pointer is never read, so remove it=2E
>
>Just wondering, have you considered introducing an PowerPCCPU array
>under the machine state ?
>
>This would be an intermediate step towards the introduction of an SoC
>model (in the long term)

Well, there seem to be many members in the QorIQ family with incompatible =
offsets=2E So I experimented with dtb-driven machine creation instead to si=
destep the whole problem=2E Once this series is merged I plan to submit an =
RFC for that=2E

Best regards,
Bernhard

>
>Thanks,
>
>C=2E
>
>
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/ppc/e500=2Ec | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>=20
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 75b051009f=2E=2Ef68779a1ea 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -899,7 +899,6 @@ void ppce500_init(MachineState *machine)
>>       const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(mach=
ine);
>>       MachineClass *mc =3D MACHINE_CLASS(pmc);
>>       PCIBus *pci_bus;
>> -    CPUPPCState *env =3D NULL;
>>       uint64_t loadaddr;
>>       hwaddr kernel_base =3D -1LL;
>>       int kernel_size =3D 0;
>> @@ -921,7 +920,6 @@ void ppce500_init(MachineState *machine)
>>       IrqLines *irqs;
>>       DeviceState *dev, *mpicdev;
>>       DriveInfo *dinfo;
>> -    CPUPPCState *firstenv =3D NULL;
>>       MemoryRegion *ccsr_addr_space;
>>       SysBusDevice *s;
>>       PPCE500CCSRState *ccsr;
>> @@ -930,6 +928,7 @@ void ppce500_init(MachineState *machine)
>>       irqs =3D g_new0(IrqLines, smp_cpus);
>>       for (i =3D 0; i < smp_cpus; i++) {
>>           PowerPCCPU *cpu;
>> +        CPUPPCState *env;
>>           CPUState *cs;
>>             cpu =3D POWERPC_CPU(object_new(machine->cpu_type));
>> @@ -950,10 +949,6 @@ void ppce500_init(MachineState *machine)
>>                                    &error_abort);
>>           qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>>   -        if (!firstenv) {
>> -            firstenv =3D env;
>> -        }
>> -
>>           irqs[i]=2Eirq[OPENPIC_OUTPUT_INT] =3D
>>               qdev_get_gpio_in(DEVICE(cpu), PPCE500_INPUT_INT);
>>           irqs[i]=2Eirq[OPENPIC_OUTPUT_CINT] =3D
>> @@ -974,8 +969,6 @@ void ppce500_init(MachineState *machine)
>>           }
>>       }
>>   -    env =3D firstenv;
>> -
>>       if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
>>           error_report("RAM size must be multiple of %" PRIu64, RAM_SIZ=
ES_ALIGN);
>>           exit(EXIT_FAILURE);
>

