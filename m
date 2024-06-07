Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADB8C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:27:31 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFat1-00088g-2G; Fri, 07 Jun 2024 10:48:11 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFasz-00088S-Tz
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:48:09 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFasy-0005F8-7y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:48:09 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57c681dd692so47910a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717771684; x=1718376484; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RHsLqbA0ARigZErh3p5J1JPw7aHC7YUyqGXlvJ7XIi0=;
 b=oKdhBr7UF2ZyWUETKEd6Wx1dZIingvEsLAiGw5nWQVQxCXruy7L7Qf8pFQGzjtbJHG
 YKsBxD3CI8uoHowPMsABWxCS/5gylGhGkVP36MXPdZF3yJNXCUeC4a9DFt2OAX+JKliJ
 E6GE9MjDW6GfPzZ7mwx7IohXkIrOHi0J09XILnpDFOWNPxkUqqmtapONRas1LZ3CG5/a
 GCyWsCGq8gtSmGfmyQKaw7lUtwejgzx2Ayt07faJJ/frsHy+Fue+4gwAnOu4vgb6e6v1
 QE+4ynb2PxnFNNAL1YSbm0kcd/lvTzQRnb5ytP7n7tXeYdHZe/lKpwj/PUTy9eiSMxtJ
 WjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717771684; x=1718376484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHsLqbA0ARigZErh3p5J1JPw7aHC7YUyqGXlvJ7XIi0=;
 b=AoF09RZn0TkGnePwWggkR5R7h3keOXPZrMU+zIGLG0zqt6T2dl9otm1DHLDMUyYOtJ
 fEEKJYu7o+SCA9rdVMQi4OaC5hz8/VItXUNbSFOlfAN04Bv6gqvLV5iRTV9Unp3sInZ1
 voCld+18617xy7gTE+Jmh0XIHs+FKUCTN0U3lxQPgxv9b11U8ODV1o5i0JkyJ/yx5YFF
 WKj6X73wAwtbUhSRiHerk9Y85CQ8BFnLDRy1GzJiyUV53rfU1Clwq0Z9bx/YRj2rGVS7
 xa0iMJ7eAEleS3z68HYGQoj9FWWJaY+MMSu0DpcMEg2rg/Jffh1PGVNVnp4w/InjosBX
 n9Xg==
X-Gm-Message-State: AOJu0YzbSipAsVE26QousgAurQ7OgsUgytUnETouCDhu5+PsaScZK5qo
 oIAakFns9TTBWOTbKZIFFV7MFBRJWn0DccpBIlKEa149SuhB6HDnTDFGrLfgkiPz/mQh2dqiZDu
 lsuRuRdvIiwpG+qoBwaO1PGrK0tLSsAEmEQhg3A==
X-Google-Smtp-Source: AGHT+IHyIm3yFtEZMnKwoebxfADRCGjrq200rfPnkMUZ36kZX0gB6zwkW3+gKSRI94ZXmxZhv47aDKlcLk5RQ17lqXE=
X-Received: by 2002:a50:cc96:0:b0:578:36a2:7073 with SMTP id
 4fb4d7f45d1cf-57c509a811amr1490294a12.29.1717771684201; Fri, 07 Jun 2024
 07:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240524120837.10057-1-sebastian.huber@embedded-brains.de>
 <CAFEAcA81fqWKXL_7m6LTi0-zkmtMQC0RY6_ZNP49cdWCVJK+1Q@mail.gmail.com>
 <cdfed70e-9dd1-4169-a73d-6a6c98c41ac2@embedded-brains.de>
In-Reply-To: <cdfed70e-9dd1-4169-a73d-6a6c98c41ac2@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 15:47:52 +0100
Message-ID: <CAFEAcA9auJ5A_YSBgwTM_9r=NYPcpieZhw_+yNKB-HnCy4EWEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Zynq 7000 Improvements
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 7 Jun 2024 at 15:28, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> On 30.05.24 12:30, Peter Maydell wrote:
> > On Fri, 24 May 2024 at 13:08, Sebastian Huber
> > <sebastian.huber@embedded-brains.de> wrote:
> >>
> >> v2:
> >>
> >> * Add Kconfig support
> >>
> >> * Add array of CPUs to ZynqMachineState
> >>
> >> * Add FIQ support
> >>
> >> Sebastian Huber (2):
> >>    hw/arm/xilinx_zynq: Add cache controller
> >>    hw/arm/xilinx_zynq: Support up to two CPU cores
> >
> >
> >
> > Applied to target-arm.next, thanks.
>
> Thanks, for the integration. I did some more tests and there is an issue
> with the IPI support. My test case worked with this change:
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 7f7a3d23fb..8d84eaf070 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -253,9 +253,9 @@ static void zynq_init(MachineState *machine)
>       sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
>       for (n = 0; n < smp_cpus; n++) {
>           DeviceState *cpudev = DEVICE(zynq_machine->cpu[n]);
> -        sysbus_connect_irq(busdev, (2 * n) + 0,
> +        sysbus_connect_irq(busdev, n,
>                              qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> -        sysbus_connect_irq(busdev, (2 * n) + 1,
> +        sysbus_connect_irq(busdev, smp_cpus + n,
>                              qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
>       }
>
> This is just guess work on my side since I have no idea how the second
> parameter relates to the pin.
>
> Originally I used the hw/arm/realview.c as a reference, but his target
> doesn't use the ARM_CPU_FIQ at all.

(I suspect it's a bug that we don't wire up FIQ on realview,
but Linux doesn't care as it only uses IRQ anyway.)

The a9mpcore device's inbound IRQ lines are a passthrough of
the IRQ inputs to the GICv2 device. We don't document that
that's what a9mpcore does, unfortunately, but we do document
the GICv2 layout in include/hw/intc/arm_gic.h:

 *  + sysbus IRQs: (in order; number will vary depending on number of cores)
 *    - IRQ for CPU 0
 *    - IRQ for CPU 1
 *      ...
 *    - FIQ for CPU 0
 *    - FIQ for CPU 1
 *      ...
 *    - VIRQ for CPU 0 (exists even if virt extensions not present)
 *    - VIRQ for CPU 1 (exists even if virt extensions not present)
 *      ...
 *    - VFIQ for CPU 0 (exists even if virt extensions not present)
 *    - VFIQ for CPU 1 (exists even if virt extensions not present)
 *      ...
 *    - maintenance IRQ for CPU i/f 0 (only if virt extensions present)
 *    - maintenance IRQ for CPU i/f 1 (only if virt extensions present)

So yes, your change here is correct.

The original patch is in upstream git already, so would you
mind sending this fix as a proper patch email? Then I can
pick it up as a bugfix.

thanks
-- PMM

