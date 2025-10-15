Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A657CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90HG-0008Mk-Ig; Wed, 15 Oct 2025 08:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v90H3-0008LU-Sf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:06:34 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v90Gw-0000o6-ST
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:06:33 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7501c24a731so77253647b3.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760529979; x=1761134779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1NSOXM+21hN6vLOK+gx+jUeqiMVSuJSg+BtE0AwsORA=;
 b=CEcImpR6W+bPGr2a31xT+eJcKkFQL+gzFE5fuaHpCxk/L7zIO+2S3rOPLW33uJEp2O
 av2EzZQtSoamXPBClkjb1t8BMrXlkXFdQYCW8U51jy2vPOsRW5FUa6K3OPm3G6A/Lj6e
 EAaZyvRdvoO2hh+BkijzjT6g4IHm+M6Yutou/kszNXR4cAO1aK8G852YFqfByafwW03s
 BfrXccQrAn15XFaMM5GQ4LSIgLnVGHv8CWUYaYPwCDpavHBe9zeL25DV5j4GBZv3wVWk
 r0Kyinxi2I3kn+KvHyQTh2S4GVeIPHbB4FMWjwYAJdcfoG0nKw+ibANY7ZF141Or8uQD
 YlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760529979; x=1761134779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1NSOXM+21hN6vLOK+gx+jUeqiMVSuJSg+BtE0AwsORA=;
 b=rZ6+kySTKCIGuSbKLN9bBv7yd3uNI02HdQmO6L1xzlVob+tM85QI86iNEwuv1MAYPa
 0nYRSYtNyXxTrFdlnk9n7AIK1FhpcbG6InAzNUW0tl8Uvly1DUhZbSnLtVOIEWCVFln6
 oPsiPfORCRovtS/XkFmkuDRpo5A301XVj6hP0+/bATAS2YJo97G/vMvoL6/pe8sC902E
 rkYPnARrwtO4IDvWGWrHvYMYIOabsM6Lw6p3hemmwBabtf6g1zMJ7jSmam/x7VBUAKOI
 x0uXpmZmtXIra6wCjm5J5cZGy0/FeQfiXwBE5os73xVU4+wy+KvLO2+9/i5gdP4uUeyc
 xvlg==
X-Gm-Message-State: AOJu0YwY9WagjpIqEr/cLvwDMQEQTtREMmzI/uY56bahj56WYIJYEI8H
 ef7xPFVnB2m5YaVBZoegh7RVVK/dT822OQKpcbdx8YXaORircAgEs965JszLT8HSPrLwDxV0CDp
 ePoEgVqAJtTr7ue2JwsA+PC3SJGV81K4qbHA1tDsBww==
X-Gm-Gg: ASbGncuqiDXrIX+QxmHHW6YvRUVzVDMtAtKQaF6bqAg/qIN8PtIEA3Dhr0xuCZpOJ3A
 bIrsIKOODBmlw+AcekjnUHrMl8CqBvKxwrHSWuwc1SiQPsTHaMQ3eCMYTFiox0me2RwgMPFLedl
 ps/XsCehZlT3LYdUec8x6wRA5aAHzzggSe+XUQRkogJZMRWThypiYnUolFxBn7Za1AXohNZIR7t
 qfEL1U+lfKkH75DLauQdDYbCZoCwOH7GSRkIGB7WA==
X-Google-Smtp-Source: AGHT+IGWfC4cFcDhyouSG1w+x4/v8TPW8AMEClTGKNAnV63sDIImFQYgZLakmPIF66hTUY3MDfIiVKqvuGEv90Qy/WM=
X-Received: by 2002:a05:690e:14ce:b0:63d:ec38:cbf1 with SMTP id
 956f58d0204a3-63dec38cc2cmr163224d50.24.1760529979554; Wed, 15 Oct 2025
 05:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <d6f9dfa368b2419998379ac9dd986a7b@huawei.com>
In-Reply-To: <d6f9dfa368b2419998379ac9dd986a7b@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Oct 2025 13:06:07 +0100
X-Gm-Features: AS18NWDan5KV9g4Wyk7ZbQeYnD54B7as9t89RrLOa3DsqOr84uSHBrHkyJuR6A8
Message-ID: <CAFEAcA8U_3zJsnHt2wxME3j8J83whzTNgP9vEvUGuWHe7KGaYA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 15 Oct 2025 at 11:58, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
>
> > From: qemu-devel-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
> > devel-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Peter
> > Maydell
> > Sent: Tuesday, October 14, 2025 11:25 AM
> > To: qemu-devel@nongnu.org
> > Cc: Salil Mehta <salil.mehta@opnsrc.net>; Marc Zyngier <maz@kernel.org>
> > Subject: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
> > kernel in cpuif reset
> >
> > Currently in arm_gicv3_icc_reset() we read the kernel's value of
> > ICC_CTLR_EL1 as part of resetting the CPU interface.  This mostly works, but
> > we're actually breaking an assumption the kernel makes that userspace only
> > accesses the in-kernel GIC data when the VM is totally paused, which may
> > not be the case if a single vCPU is being reset.  The effect is that it's possible
> > that the read attempt returns EBUSY.
> >
> > Avoid this by reading the kernel's value of the reset ICC_CTLR_EL1 once in
> > device realize. This brings ICC_CTLR_EL1 into line with the other cpuif
> > registers, where we assume we know what the kernel is resetting them to
> > and just update QEMU's data structures in arm_gicv3_icc_reset().
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I've only tested this fairly lightly, but it seems to work.
> > Salil, does this fix the EBUSY issues you were seeing ?
> >
> >  include/hw/intc/arm_gicv3_common.h |  3 ++
> >  hw/intc/arm_gicv3_kvm.c            | 49 +++++++++++++++++++++---------
> >  2 files changed, 38 insertions(+), 14 deletions(-)
> >
> [...]
> > +
> > +    /*
> > +     * Now we can read the kernel's initial value of ICC_CTLR_EL1, which
> > +     * we will need if a CPU interface is reset. If the kernel is ancient
> > +     * and doesn't support writing the GIC state then we don't need to
> > +     * care what reset does to QEMU's data structures.
> > +     */
> > +    if (!s->migration_blocker) {
> > +        for (i = 0; i < s->num_cpu; i++) {
> > +            GICv3CPUState *c = &s->cpu[i];
> > +
> > +            kvm_device_access(s->dev_fd,
> > KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> > +                              KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
> > +                              &c->kvm_reset_icc_ctlr_el1, false, &error_abort);
> > +        }
> > +    }
> >  }
>
>
> Above changes assume that the driver's configured value of the ICC_CTLR_EL1
> system register is the same as the default value. I've verified that this
> currently the case. However, it safe to assume that this will remain true
> in the future as well?

I don't understand what you mean here. We read the kernel's ICC_CTLR_EL1
at VM startup, when we know it will be the reset value, because we haven't
run any VCPUs yet.

> We can instead cache the value once during the first cpu_reset() for each
> CPU interface and reuse that cached value for all subsequent cpu_reset()
> operations.  This would simplify the implementation while retaining
> major goals.

No, we should read the value at realize time, as this patch does.
Trying to do it at cpu_reset runs into the same problem that we
have now that the kernel doesn't expect us to be reading the
register when another vcpu might be running.

> Calling pause_vcpus_all() at VM initialization time--during  the first
> cpu_reset()--should not cause any issues, as all secondary vCPUs are idle
> (i.e. their PCs are not initialized and kernel has not yet loaded). Pausing
> such vCPUs at this stage should not be a disruptive action.

We should not need to run pause_vcpus_all() at all here. CPU reset
should be fine done for one vcpu with the others running.

> Moreover, if this stage poses a problem for a KVM device IOCTL access, it
> similarly affect other components like GICv3 ITS, which also uses KVM
> device IOCTL during GICv3 reset hold. At this stage all the vCPUs should still
> be in a pre-boot or idle state

> static void kvm_arm_its_reset_hold(Object *obj, ResetType type)
> {
> [...]
>
>     if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>                                KVM_DEV_ARM_ITS_CTRL_RESET)) {
>         kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>                           KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
>         return;
>     }
> [...]
>
> }
>
> We are not even pausing vCPUs here, yet we expect above KVM device IOCTL
> to succeed on the first attempt. The operation also ends up acquiring the
> mutex for all vCPUs within the KVM.

ITS reset should only happen (a) at start of the run, before any
vcpus run or (b) as part of a full system reset. We should check that
the vcpus are paused when we're doing system reset, but I would expect
that to be the case because it would be likely to be buggy if not.

-- PMM

