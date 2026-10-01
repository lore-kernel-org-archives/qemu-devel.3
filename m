Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA84CCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDUh-0002Bc-G5; Thu, 01 Oct 2026 05:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCDUY-0002At-QX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:54:20 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCDUX-0004rV-5n
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:54:18 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ab43af5e97so4566697b3.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 02:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790848450; cv=none;
 d=google.com; s=arc-20260327;
 b=stwVbesuNw7hz5gOB1a9JL/RjWU9cY2FbxaYJ/hxiPIe9j2ZA0k/9n9k/U7rDxrQjE
 UHG/GG9BEyIFRnyPims5xgsuPtjh4BMCSgYUc9fXUJ/CshVTbrhs4xlkSSr2szYWYZzi
 jezKnXIbM+3wEVxh3wN5ZUgpOhto5681HPObU8Xvxb2v0q+KOq+m97I8wPSjLf38PtHE
 3Zs1Fdqvk6ObYG5Hg22dfGME8qxsDagzZmpZuvxsz0lAQhnslZ7ZEWNeAg0WFA6qXpJk
 EhJIncQcdP+MmM3uRNsGq8YrCyRc1hxR2e5YuQI1+Wduww8qWj39UxDdMNsK7HexjQ8c
 H52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WrZ4og2iqhMmChmov0L+16CZKmGg2p7xKWkxhtoUHFU=;
 fh=4FtdHUzkuyC2Zq9xaVCFcthZJ7mi8fR7Tp+QzbKQ2zY=;
 b=Zrzr7yc/S4cKmOb2kSjgdjTmDWzueKlBwola5dl35rK6HslmtOfrdnkdvyxUGdawa3
 XYxxNz6eWL5Hd1261AyCm0Ipf2uyqhFDR5yK9jRy5649s2prvzKpDD/PBNCuYwuQqzmS
 yT/8w+3HVA8zwlVa+Bmxl05kqf9mG9CghhDC5nFh/o/z+kzngpaO6nuL92caoXN9t9ya
 dFX6FnRaW2ym91HWBkEM30cylOLDLpM6rYJHNypXxYd8ZZ8CmYR9d1k0kBDOAFNSSrDJ
 EtX9lU45eypmQIGjgA3kX8paO+DKDWXtV9mz0BERUsF2X/0SUbU6tB9d4nIt3y9KXhvb
 E8HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848450; x=1791453250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WrZ4og2iqhMmChmov0L+16CZKmGg2p7xKWkxhtoUHFU=;
 b=tSVaJuDjg82rYiiOYUHAWABIC+umkY8QLwd9PB1HaglHsiZ1l3dq0jGW1n3cj4TcLM
 HHvMI7wr+JFsU5/Tf1W/s5oAcQcGzWIc/YIgM9kJjOA14Z5Beco7+gaXhVnx8k8lIazG
 29wKXetAAYpihJi2+FWEpt+lvpTWRr+yuRID/QhUP24xmzfFhmGCu/tcOvfyPtEIh9uf
 D2E9I9VcH20FQv7mY/7yQfFzDHqUCT3v5YedmZI5aS/K3LoVIMYKqWugySC9E37rvl9y
 MRug+B0oYm+JgD6cxS22107LKdexqBW+wClJn3N5Zc3Uq7U62QcsmYn5qg1nXRVsCfEA
 I4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848450; x=1791453250;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WrZ4og2iqhMmChmov0L+16CZKmGg2p7xKWkxhtoUHFU=;
 b=dnozOKYaaVXj7/vIBr6p6T/OTd5zWvSgJpGc7yz2o9g2EHgYwQ1wJO0I4LZXe9bAnC
 eaJ56mhKRY30lK/Fwg0fG6BFUCZ2KOtIz8/hcLQDhPLGXTl+I8celIqd5jV1WgSI7j0A
 8Jb+0UaP8Tt9KqVAj94KHRgIs3C4ybv2IFRO9rddkHx4VCU7q23ws7oxyCMN9MDsgY+g
 m8PWAq3IEXGkB8iAg0plBgaBwkdIPnlgHBYNqnCnUPmcBPxOPnMn/rHSG/1rakG8UhmF
 bIxhGkzhHRQNHIKiwUjh8Q2llOJpZmbMMf3+tPCIMQqxa2cH8i5NgFO5jstq6nGGG2eO
 lLHw==
X-Gm-Message-State: AFq9FYL2CyWfzg+va/9sWV4pBeEvwvBtHEMgH8vfmjofg5PJD48WbY4J
 NPeQLNtATM6QhsqG/8IjowvKnIwOOKbWlAAaUhQjyRYTH3oZrkAt1F/fFFDK+ORV+kA+AcC8Gcc
 IkHFMp/LiJYdpWvCSOg1Qpk3vk8liu7MXWtS1ViEnmQ==
X-Gm-Gg: AYBFou0Fsnofl1aNyrnrk96CwxZQxXxjgITkFoS6tmy/HTl9/F4xRMTLjw5ZSyhUl+W
 mYRo5jYUAupgxMR2gIxCCBoptEjb/gheQbzG1NQM0v1DqEEaiThdZRoMXUJ/CTC8NB3CQy/MY7P
 v8OWJQafdIdKeg6qfKs7/QyMDX2ATk+q6n+nVXUBDPbwfFQCSLpe/V48VAAepacakpztNCgl1Pc
 rCD5yYZ+ZfM7U6I2yh0ufLSRvEsJJOpk6ENkRSJJuSdxwVi3BYwJD+Y/LDnj0H+oUCousE07OVJ
 TIxDDsxpHU91L12l1etwMb+LIwfoo4FNjcGiuDiAYE/KAio6Rkb1HxG0YfJck4qLDwoLwHU4TSU
 OvGTd+sx308KiQVTncm4WiMIJKi3o1sgBAXlfP5H/kq2MRPB84w==
X-Received: by 2002:a05:690c:e3ed:b0:8a8:93e9:381f with SMTP id
 00721157ae682-8acdaee44f8mr10634387b3.22.1790848450256; Thu, 01 Oct 2026
 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
 <20260930174946.82195-10-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174946.82195-10-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2026 10:53:58 +0100
X-Gm-Features: AclHuK-AQIrHsn86uBQIqSqBHDz3HBv4x_KwjFung085t5QqnfzZ5LMfCBD62IY
Message-ID: <CAFEAcA81kUriHYPj2EBNYiBsJUMmgknCGRif0q0cc5sndro2dg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] target/arm: Kick vCPU after updating PSCI power
 state
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 30 Sept 2026 at 18:50, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> PSCI can update the power state of a vCPU other than the caller.
> arm_cpu_has_work() reads env->halt_reason to decide whether that
> vCPU has work to do, and is called from the vCPU thread without the
> BQL held. A remote power_state/halt_reason update is therefore not
> observed until the target vCPU is rescheduled, so the vCPU stays
> halted and a PSCI CPU_ON of a secondary vCPU can hang.
>
> Kick the vCPU after changing its state so it re-evaluates promptly.
>
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  target/arm/arm-powerctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
> index ef14a1f8a94..1ba5277b023 100644
> --- a/target/arm/arm-powerctl.c
> +++ b/target/arm/arm-powerctl.c
> @@ -48,9 +48,14 @@ struct CpuOnInfo {
>  void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
>  {
>      CPUARMState *env =3D &cpu->env;
> +    CPUState *cs =3D CPU(cpu);
>
>      qatomic_set(&cpu->power_state, state);
>      qatomic_set(&env->halt_reason, state =3D=3D PSCI_OFF ? HALT_PSCI : N=
OT_HALTED);
> +
> +    if (!qemu_cpu_is_self(cs)) {
> +        qemu_cpu_kick(cs);
> +    }
>  }

Looking at the callsites of this function:

 * three places in arm-powerctl.c call it from an async_run_on_cpu
   callback function which runs it in the context of the vCPU it
   is changing the power state for
 * target/arm/cpu.c calls it from within reset for the vCPU being
   reset, so we definitely don't want to kick the vCPU
 * target/arm/kvm.c calls it as part of the "sync the vCPU state
   to/from KVM" function, which should only be running from
   that vCPU's thread
 * target/arm/machine.c calls it as part of an inbound migration
   to set the vCPU's power-state to whatever it was on the source

So I think that in the cases where we're actually running the VM
the if() check will fail and we do nothing anyway, and in the other
cases (reset, migration) we don't want to be kicking the vCPU.

thanks
-- PMM

