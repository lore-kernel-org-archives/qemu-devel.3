Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B5CCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QBn-0003KD-6l; Thu, 16 Oct 2025 11:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9QBi-0003JF-J9
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:46:47 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9QBU-0007RV-3u
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:46:46 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-63bbf5f77daso951806d50.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760629586; x=1761234386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDm07NJB2hE3/mMHvYQo6YCBd15iEsHVaMUmmw+KhSE=;
 b=h4oms7K9x6HQBOpARhrSybi+W4okMXAzsOLyuZTFBnNVfDox/aIiis86DkzLnOvJC0
 ixeMcf/+bGcTyfHUguAWtxwUcGPQe+dl3+CZfSXB3CEiX8sBgw9HXTlkGGmZjJvgSBCU
 GreW86q1g7hzQkzdnY4VecGr4n/F3x+HtokgQuOOZJdAbxQHY4d6i9h0rGjTlqM649dS
 Qj3tzhW13dUpMVt/1pt21RQ9tfk5B8ooY0pWibj4yKnSIZ2gaFbz12lWMkg2w9ZJPJ7F
 wAFE6fhUw2xbh9oJsnudjcHoJbhi6Mv0bt7TbNKMCqSZGQWUXEHCxLTCRCqINZY/hxqq
 0G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760629586; x=1761234386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDm07NJB2hE3/mMHvYQo6YCBd15iEsHVaMUmmw+KhSE=;
 b=hFWIwAmgAhmRwHSZkMLXadaSWd6UUi2gkKeBwFWjXIlfGKZt0q3W0dy77qvjwxVhdI
 DXr1gwK8YLEMIHcpyewJqJ9V9zPBGKHkrR/ib+bQt2onBecLRUpmDTh3/vnnmICHj+qb
 uiPlmQ+edIcZePEJhXgHNZi25bnK/uiNQbWIpnKSZYBkB3yybyUC4vTF8XXhGFQ1b9P4
 /eKzVeJEdF4F8N84SN4Eo4IgKjSbFyPQYLxIHHrEm3LtY+BgsBRi2KQ+fvLSppZGDnRs
 FSGwcnUSwiVYiCJHE8hS3k0+A8r297e2XZSZ1sBXyXMPaG9PYnK6tg2UDFZQu1BOjy2Q
 Ygww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkQIxtbNr0rEKewBBkGZaKxgCVWLHEMZuUBOAw9TBAhpkyToDi59UTKoO+gOMpgSx5XTntBAK8/nDk@nongnu.org
X-Gm-Message-State: AOJu0Yxy1FLk8+bWY5JUVyaVVwZdH+dKHaoBz/dpUD4rtRhgDbEsMPbk
 FI1MCWaiuv5Uob2Hffl6wtSJbKSuI9BOvz/VUgi3tT9OTZG7KsBnmz3NipafOyC3Z0yP9c7suCp
 WcQUlqAfxS7wRtbS8Vwx8EdXPOGDlCvbXT7kdIichNw==
X-Gm-Gg: ASbGncs/kgRGT79a3PN5I3ZHQvmJ8liE4MpOzhp1XG8SS4t0l0uVYOMcCWukmV29KLG
 2x96Gzub+0wToW+QWEtjD4gyAY9J+nHOc4pKAewMsWlucwL7lYwFuBzk2v4vSBHUsGiUcZz45Ml
 pEQvq+zSrQF9Yzn2TMEJNmwhKkBZqQO800as7TYDJb8o2CZPfJ6nsMrZTWdY46MJj5Mgz4WR0/7
 9kN4Aq7rVm8NjvnZUuctlbTbvu+3NirUoTsczZOaXOgwHGoxJBIvK0cZif/sw==
X-Google-Smtp-Source: AGHT+IHY64Dy26HM49NmnvPLVAwhLiwipHZIqIjfiiHswJmP+hg7GLhlB8N1bfpTuvtQRtnUppYFM1wecl/272LG8gM=
X-Received: by 2002:a05:690e:400d:b0:63d:318a:efb4 with SMTP id
 956f58d0204a3-63e161f10b9mr529900d50.63.1760629585765; Thu, 16 Oct 2025
 08:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <d6f9dfa368b2419998379ac9dd986a7b@huawei.com>
 <CAFEAcA8U_3zJsnHt2wxME3j8J83whzTNgP9vEvUGuWHe7KGaYA@mail.gmail.com>
 <e2b03da8f7514b57aef7d236be1dcb90@huawei.com>
 <CAFEAcA_KcvBOOc4nY6VMziSuh=YrcgbaNZhi3+M_kM01v97WtQ@mail.gmail.com>
 <CAJ7pxeaCeSPAzjqnhVG6VkQyX3Vx82yvb-ex1ya+j7pFjFOekg@mail.gmail.com>
In-Reply-To: <CAJ7pxeaCeSPAzjqnhVG6VkQyX3Vx82yvb-ex1ya+j7pFjFOekg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 16:46:14 +0100
X-Gm-Features: AS18NWB1loGHkMcIBpSOJXR56fO8SuoqJhfhzG5N3q48cktuZ1MKpYUqAqbe15U
Message-ID: <CAFEAcA-22x0rFK+Wqwc_MfaLpmP521PYO_sPJ3dtNTvmJ6vMVw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 16 Oct 2025 at 16:28, Salil Mehta <salil.mehta@opnsrc.net> wrote:
>
> Hi Peter,
>
> On Thu, Oct 16, 2025 at 12:46=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > On Thu, 16 Oct 2025 at 12:13, Salil Mehta <salil.mehta@huawei.com> wrot=
e:
> > >
> > > Hi Peter,
> > > > > Above changes assume that the driver's configured value of the
> > > > > ICC_CTLR_EL1 system register is the same as the default value. I'=
ve
> > > > > verified that this currently the case. However, it safe to assume=
 that
> > > > > this will remain true in the future as well?
> > > >
> > > > I don't understand what you mean here. We read the kernel's ICC_CTL=
R_EL1
> > > > at VM startup, when we know it will be the reset value, because we =
haven't
> > > > run any VCPUs yet.
> > >
> > >
> > > System register fetches its value from ICH_VMCR_EL2 and ICH_VTR_EL2.
> > > In specific, EOIMode, PMHE and CBPR fields of ICC_CTLR_EL1 are from
> > > the VMCR register. Later gets configured when driver gets loaded and =
again
> > > re-configured in context to each CPU ON request(via in-kernel  CPU Ho=
tplug
> > > state machine; CPUHP_AP_IRQ_GIC_STARTING). This configures the VMCR
> > > again and again. Although, the value as of now is same.
> > >
> > > You might want to check gic_cpu_sys_reg_init() in irq-gic-v3.c
> >
> > I'm afraid I still don't understand what you mean here. This is
> > all the guest writing to the GIC registers as it starts up, right?
> > That has no influence at all on what the reset value of the emulated
> > hardware should be. (This is the same as on real hardware:
> > it doesn't matter what the OS writes to registers when it is
> > running; when the hardware resets it resets to the reset value.)
>
> For context, the gic_cpu_init() function is invoked from two paths in
> the kernel: first from gic_init_bases() when the GICv3 driver is
> initially loaded on the boot CPU, and later from gic_starting_cpu()
> during each CPU online transition in the hotplug state machine.
>
> The hotplug path wires up
>
> CPUHP_AP_IRQ_GIC_STARTING -> gic_starting_cpu
>
> in gic_smp_init(). On every CPU online event this leads to:
>
> gic_starting_cpu() -> gic_cpu_init() -> gic_cpu_sys_reg_init()
>
> which reprograms the CPU-interface system registers on that CPU,
> including ICC_CTLR_EL1 (fields EOIMode, PMHE, CBPR).
>
> The following dump stack from a guest hotplug event shows this
> sequence clearly:
>
> echo 1 > /sys/devices/system/cpu/cpu1/online
> [   39.287402] gic_cpu_sys_reg_init+0x4c/0x294
> [   39.287406] gic_cpu_init.part.0+0xc0/0x114
> [   39.287409] gic_starting_cpu+0x24/0x8c
> [   39.287412] cpuhp_invoke_callback+0x104/0x20c
> [   39.287419] notify_cpu_starting+0x80/0xac
> [   39.287421] secondary_start_kernel+0xdc/0x15c
>
>
> As a result, ICC_CTLR_EL1 is at its architectural reset value at
> VM realize (before any vCPU runs), but it is guest-configured
> after the driver runs and again on each later CPU online event.

So? We do not care what the guest does with the register.
The reset value is the value it has *before* the guest touches it.

-- PMM

