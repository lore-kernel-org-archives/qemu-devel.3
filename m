Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD19CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gVp-0005GG-8j; Tue, 14 Oct 2025 11:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8gVb-0005FT-Vy
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:00:16 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8gVX-0004B8-De
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:00:15 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63b710f276fso5630607d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760454007; x=1761058807; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EXdtC+RoVqzJ6jxvALg4/2uKoqvuJlAPbcy64ykvg5U=;
 b=qXAdnNKT7HPpyZ736SLLGUKDIGfKIn/+vAg4GNLir4EQSCPyNQVlSRZTplO6Tt8gSE
 O0GTxa8aTsXtsL1JoDJu8XzqgFixwQc9qdm+wqaM6kazsBXVKqCAhIwweHeo9CBnGY68
 F8rC6oIaS5ACFQEL+sTyBR+E0oTmyP2tlOTpvDKrLba4pNF+UU4dt/WfFbOZeyuQK6vz
 QfsYqpv4e75JBMOKdSZ7CePUbcplxeQpURvLM1lVm1PHPtZCeWpxvk+/AaHmj+mXTDGS
 ymvbR/6TQmq+i4QXAP7syGEyltHwL40Xl/KBVk6T0++/WJGyWAHL+DXf/qkRrysByawr
 SZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760454007; x=1761058807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXdtC+RoVqzJ6jxvALg4/2uKoqvuJlAPbcy64ykvg5U=;
 b=iE2mZBpy6jURijGKWTaMNtiKpoxkcdkxEZ3WU7MJCo/RY0CnUW47mfh1OBNrbCF88r
 79KFNV/P34yhiDiMYxhpxbneVPD26pOyipqyVo7J0e88far6ufyO7VwuHsmm+TAlNvvA
 Lz47Vnim0TPZfDG0DhpmcPs5qUxG/93AgUO8bOmWp2NSx41QiubyAVrLiYS387MYcvlp
 nrawoMziH9RZCVAZhiw86f1h8LArU4kyvPut4UIBF6eQZA+gAYKXueF24W0d5XaZn8x2
 EXadjMD47U9nwM9ptd4emgRhvvUy0lZ3nRkqsZWjR487yw6NlPqpEyFQdvlfB3St6PUw
 rNfg==
X-Gm-Message-State: AOJu0Ywlc8PnZ00l+S3kFwFxp9ru83pOhnLijcWHog7HIuR/KrKpoMbA
 Uhj5MX3SiY2xtkqVnryc6Jjf8hrBGOHUxJOfVqUyRDeMrmMEdtaWMvSLBI+Khu6AqB8odhqoqcz
 QqEYxP85BGSGYRg5gEJ6IxIuWWU4RHxnc4V7THVKXGA==
X-Gm-Gg: ASbGncvLSGQdHw9X98OFO1hxkToWlRE+gJz15mRxcB+8GFE7mRp/0XfjFvghJ9z02TM
 eWF3lC0GFLg/DdkH2CPROg14zEck74/1w7QhtmQE2/tbVFONs1jNPwoHfofOS+PTaLIhX7zCM+W
 83akNroHMWJ3NupliFYReVrGcAuNvVGeK6lZTqW922QUhcxFQjaI3wXa9V0iHquh+nmQ3cYuB06
 RFVbZrfVgNfQpDW/glLmjM/7PYW1QVTpvlRKbRAbw==
X-Google-Smtp-Source: AGHT+IGOiTb1+nKX3ewnngbdy2ro26GRL3gH9UHygOyv8vLClLz4UTW/XFdoZVw+hZSAb3nBHdFUiCcciE9TdeNYzDg=
X-Received: by 2002:a05:690e:483:b0:633:c0f9:705c with SMTP id
 956f58d0204a3-63ccb8e0f2bmr17151955d50.24.1760454006783; Tue, 14 Oct 2025
 08:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
 <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
In-Reply-To: <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 15:59:55 +0100
X-Gm-Features: AS18NWBaS0H5ukysZElQa47-py_dztF4XooGgnjUICZXI55S-TQhwa8UM44LqHw
Message-ID: <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 14 Oct 2025 at 15:48, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
>
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Sent: Tuesday, October 14, 2025 3:29 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> >
> > On Tue, 14 Oct 2025 at 15:22, Salil Mehta <salil.mehta@huawei.com> wrote:
> > >
> > > Hi Peter,
> > >
> > > > From: Peter Maydell <peter.maydell@linaro.org>
> > > > Sent: Tuesday, October 14, 2025 2:50 PM
> > > > To: Salil Mehta <salil.mehta@huawei.com>
> > > >
> > > > On Tue, 14 Oct 2025 at 14:41, Salil Mehta <salil.mehta@huawei.com>
> > wrote:
> > > > > I thought you asked me to validate the fix by replacing below:
> > > > >
> > > > > https://lore.kernel.org/qemu-devel/20251001010127.3092631-22-salil
> > > > > .meh
> > > > > ta@opnsrc.net/
> > > > >
> > > > >
> > > > > Yes, I'm using the recent RFC V6 vCPU Hotplug patches branch I've
> > > > > pushed to the community.
> > > > >
> > > > > https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.
> > > > > meht
> > > > > a@opnsrc.net/
> > > >
> > > > That's the one with the "lazy realize" hack, right? I imagine what's
> > > > happening is that we realize the GIC, and the code in this patch
> > > > assumes that all the CPUs are already realized at that point. When
> > > > we try to get the register value for a not-yet-realized CPU the kernel
> > complains.
> > >
> > >
> > > Even if we realize all of the vCPUs the problem will not go away. This
> > > problem is happening because we have recently started to Exit Hypercalls
> > to userspace.
> > > This means we are now accessing the system register in a non-atomic
> > context.
> >
> > The point of this patch is that it moves the read of ICC_CTLR_EL1 out of the
> > reset path and into the GIC realize method, at which point no vCPUs should
> > have started running. But it does assume that you don't have half-created
> > VCPUs connected to the GIC.
>
>
> This Is not true. Actually, inner cpu_exec() (in kvm-all..c)  loop keeps on dipping
> into the KVM_RUN IOCTL and exiting back with INTR continuously as the realized
> vCPUs are in RUNNABLE state initially. The actual "start-powered-off" policy only
> gets applied after first system-reset happens.

In what situation do we ever start running a VCPU before
the *GIC* has been realized? The GIC should get realized
as part of creating the virt board, which must complete
before we do anything like running a vcpu.

> > > The observation you are seeing has got nothing to do with lazy realization.
> > > The problem happens even after threads are realized and then we try to
> > > access the ICC_CTLR_EL1 register during cpu_reset()
> >
> > With this patch, we should not be accessing ICC_CTLR_EL1 during CPU reset.
> > The backtrace you posted does not have CPU reset in it, so whatever is going
> > wrong there must be something else.
>
> Yes, but its crashing in the realization of the GIC i.e. in context of machvirt_init()
> First reset of the vCPUs happens much later than this. Hence, the reason of this
> contention is different than the one you are trying to solve using this patch.

Yes, and my suggestion is that the failure you are seeing is only
because you have got half-created vcpu objects. Your backtrace
shows that the error here is not EBUSY, but ENOTTY.

-- PMM

