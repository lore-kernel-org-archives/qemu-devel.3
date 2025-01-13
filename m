Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF000E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 12:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXJYl-00007C-Pg; Mon, 13 Jan 2025 07:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXJYi-00006t-3k
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXJYf-0004KG-JO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736771318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueAYnrjsfuliqqlqQjxpt8xAeGGfZUbi3Wdoc5K2/yA=;
 b=CxVWYvPnOfkQ2jkOfInH+rtuPWo8rRB1l/mBY3UYBbz5TSFkuUslQUHTsOaD2KldytE1K9
 P8Y2FQ0TY5rWmPv4sFd60DbeL/wdNf4buVqsrNBk9fsrWxUFEuUQ7zi4rgPoKEK2+0z/RJ
 XoJDQts8Q9uP8v7LGzLdbNexvlZ+7I8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-BRmB6ISdN9Whs-ZzACxl8w-1; Mon, 13 Jan 2025 07:28:36 -0500
X-MC-Unique: BRmB6ISdN9Whs-ZzACxl8w-1
X-Mimecast-MFC-AGG-ID: BRmB6ISdN9Whs-ZzACxl8w
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so1527169f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 04:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736771315; x=1737376115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ueAYnrjsfuliqqlqQjxpt8xAeGGfZUbi3Wdoc5K2/yA=;
 b=lR/wE4s1Ac4uI/aCna+iCaddoXsEjfstQvwobYkAG8X5XgvSnoPVJVUiMSXcLTjg40
 4SvkxqMJgDEahaxSJMISzSGwPQMxRbefYcQgNR0Ntx/NUP4NcX7vDOsvucUY0ctCngC9
 h677PqGo6kWZnDIFrGXiJunehh0nSek/lXXrUDnuAUmJ/KTGBt8bsGq9+sEfNzxem8SY
 qdqf8V1UBXt/bfLRXi2rZ2kgFh5d5J/ERvN07jYNTYCYFfmo7hltcpI5w+KbUNSIVsvv
 312muLYcv4m7KsI2r5xfN0eXiMRvDHrV8TTgND14p7sHpPFM/wZQLDux8l9vG9o3UNJA
 ycVg==
X-Gm-Message-State: AOJu0YxRpQP33OSdWtclh/WdesSWaEGt8CsCj4WCLVgfzU+a5GYxpZDb
 QDqA7PY2mBdZSrGGZ3DGniKo9tak3qYACZBVvncm69eVJmhWKWnHp38qMyFuPlPOHkJ6C+H0JSb
 PuqAhd7f8lzQqdZlSQlFJYCaRtfJHleZ+5UDQhox41uW02B0gD/aw
X-Gm-Gg: ASbGncvq/BhMOlwJqHUaYhGnUNtFvbTsI9kZ7ILa14WRh/tTzp5nLt5ij7T3s3XEGSa
 2suLlsQq0bE1VkY6iZ3ptr92vYoaWB80+qDaGa4Rubnu0x4juf55Id7f7uX2Njeysm4gId8CQ1V
 h63aWs5gE5ks6fZltV/5neiLkYF6b1AGayapga72r0DvLYKrgtSRjh7xKq426DYbg8DDq2l4dDa
 qi7qAar9SjmSw7LkgxGBq+dBo2poIgpTh1uKZJPyz4/K5m1Lxg1pR1zkbdZzmkhyb+60dVshM9T
 Kyz5DXw+i6PviFUJdi4I/QUkfit8
X-Received: by 2002:a05:6000:710:b0:385:f4db:e33b with SMTP id
 ffacd0b85a97d-38a872db2c7mr19033480f8f.21.1736771315381; 
 Mon, 13 Jan 2025 04:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHivnzbEcM+E9djZTshciCID1Rn2guWpRtnpEGOrwBgX1QkY5XuVr3AIX6KTADZntug3XJ+Ew==
X-Received: by 2002:a05:6000:710:b0:385:f4db:e33b with SMTP id
 ffacd0b85a97d-38a872db2c7mr19033453f8f.21.1736771314949; 
 Mon, 13 Jan 2025 04:28:34 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37e375sm11777951f8f.22.2025.01.13.04.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 04:28:33 -0800 (PST)
Date: Mon, 13 Jan 2025 13:28:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250112221726.30206-5-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 12 Jan 2025 23:16:40 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> QDev objects created with object_new() need to manually add
> their parent relationship with object_property_add_child().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Message-Id: <20240216110313.17039-22-philmd@linaro.org>
> ---
>  hw/i386/x86-common.c                     | 1 +
>  hw/microblaze/petalogix_ml605_mmu.c      | 1 +
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
>  hw/mips/cps.c                            | 1 +
>  hw/ppc/e500.c                            | 1 +
>  hw/ppc/spapr.c                           | 1 +
>  6 files changed, 6 insertions(+)
>=20
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 97b4f7d4a0d..9c9ffb3484a 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -60,6 +60,7 @@ static void x86_cpu_new(X86MachineState *x86ms, int64_t=
 apic_id, Error **errp)
>      if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
>          goto out;
>      }
> +    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu));

I might  be missing something but why it needs to be done manually?

device_set_realized() will place any parent-less device under (1) /machine/=
unattached
while devices created with device_add() are be placed under /machine/periph=
eral[-anon]

The commit message unfortunately doesn't explain why [1] shall be replaced
by direct cpu[*] array property directly under machine.
=20
Granted, those paths aren't any kind of ABI and wrt x86 cpus
nothing should break (or I'd say it shouldn't break our promises)=20
But I'd rather not do this without a good reason/explanation.

>      qdev_realize(DEVICE(cpu), NULL, errp);
> =20
>  out:
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogi=
x_ml605_mmu.c
> index 8b44be75a22..b6be40915ac 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -83,6 +83,7 @@ petalogix_ml605_init(MachineState *machine)
> =20
>      /* init CPUs */
>      cpu =3D MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
> +    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
>      object_property_set_str(OBJECT(cpu), "version", "8.10.a", &error_abo=
rt);
>      /* Use FPU but don't use floating point conversion and square
>       * root instructions
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/pet=
alogix_s3adsp1800_mmu.c
> index 2c0d8c34cd2..29629310ba2 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -73,6 +73,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      MemoryRegion *sysmem =3D get_system_memory();
> =20
>      cpu =3D MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
> +    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
>      object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abo=
rt);
>      object_property_set_bool(OBJECT(cpu), "little-endian",
>                               !TARGET_BIG_ENDIAN, &error_abort);
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 0d8cbdc8924..293b405b965 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -87,6 +87,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
>          /* All cores use the same clock tree */
>          qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
> =20
> +        object_property_add_child(OBJECT(dev), "cpu[*]", OBJECT(cpu));
>          if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
>              return;
>          }
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 4551157c011..17d63ced907 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -955,6 +955,7 @@ void ppce500_init(MachineState *machine)
>           */
>          object_property_set_bool(OBJECT(cs), "start-powered-off", i !=3D=
 0,
>                                   &error_abort);
> +        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cpu)=
);
>          qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
> =20
>          if (!firstenv) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 623842f8064..125be6d29fd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2705,6 +2705,7 @@ static void spapr_init_cpus(SpaprMachineState *spap=
r)
>                                      &error_fatal);
>              object_property_set_int(core, CPU_CORE_PROP_CORE_ID, core_id,
>                                      &error_fatal);
> +            object_property_add_child(OBJECT(spapr), "cpu[*]", OBJECT(co=
re));
>              qdev_realize(DEVICE(core), NULL, &error_fatal);
> =20
>              object_unref(core);


