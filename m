Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C692D132AE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7v3B-0000eG-03; Mon, 04 Nov 2024 06:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1t7v2v-0000dM-2q
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:14:57 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1t7v2t-0006FS-4s
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:14:56 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-718065d6364so1882233a34.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1730718893; x=1731323693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtozNNuiFFFi4w1Zy1O7+ZhWvqKX2dDJF9x7QvW1LtQ=;
 b=Fwmzv4Y6jxfBG1crQxKtmnxPT5h25fqeGPbJzTbCPePIdTd0qSNvS1dLjYNEZIdiOz
 B/2vOtaRUO/SUXm1wqjiCg+7NOUSUkkWTeBNkgr+523AepQiY2acGnopm9Y9VUGG3Bqp
 V1ndf2Zq90DiY7uaw8hS81GUV8I/ELQg/LuNgYcShzymFvviB+fdEa0zJ26mp8bbGpVS
 betbV/3QLIScSlQOM5KJQwYEjX4uUd0vTGx7k8b3veIe6fb9cLpiJdjDXim7YyvFZMxv
 Dyno0X21PjRs90qSYTqJSgEYT05ZlD/tuDPTV2bH0h3JYUAO4H/IyHMn0QL487pMNhcu
 HxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730718893; x=1731323693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtozNNuiFFFi4w1Zy1O7+ZhWvqKX2dDJF9x7QvW1LtQ=;
 b=uc+LOl8xiUKgx3mtumw0z4Etpb9A7AeNpDXq76CzW9FdTji3vTxZ//BQKrinjor6i8
 FD8fIgmsaQ9OU9pptDa5SqbQCSatSJfxzB30zbS2GwYIspDuaFhawP/mpJegi1HHnPCm
 cJow723ctNWEF3EsZzkSP9Vfk95fi9AcBb8Qy8lz47IFSxEYCbDH6EjnkmBqe0skWLcj
 6Tuh6bA7esnPSS633SsqVkJEsJQ23B+jYL07ZKtrcM6x/UZc1KQ5DQE5C6MYZ4pfGqDm
 1Pv6Ko/Vb8rztedFGi6iBg6dYQQp5ZurBFneVEuUx5icQpSKTlsQVdRx5KEYV4aRn43R
 J/1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQCLCnwDjCVhrkdaZWDC8J9bOG6KTOw7Hed+9N6lpCgC/dt95IUxqQc4wTxQg4i8Bm7j5lTPzq6v9j@nongnu.org
X-Gm-Message-State: AOJu0YzErwGeEAZc+3irkbY3BCEs/eLaBtZQwAcoVwTouGLpMV21Qt9F
 LwMPTdutOuK3tM8V2v+Y3BtZHUzlNqaY8x8rn3J/YiKC9+Tof/IzbDmeXJNBBBmKU+rIvW9mpEI
 +qfeC3mx9Ad1gcqsYa5KOj8tYgrKw410iT/Iegg==
X-Google-Smtp-Source: AGHT+IGE02lxffNu2taMIzdnd0qEj5C04JjiZgKoi0zh6SWwXPFQ2MbFQp30MvFDf/by+cfjtROl9MSEouhwE6hVXU8=
X-Received: by 2002:a05:6871:283:b0:288:2b43:e0e3 with SMTP id
 586e51a60fabf-2949efafdaemr9274980fac.35.1730718893049; Mon, 04 Nov 2024
 03:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20241101083606.5122-1-yongxuan.wang@sifive.com>
 <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
 <20241101-6ada91d63644e8d715b1cf35@orel>
In-Reply-To: <20241101-6ada91d63644e8d715b1cf35@orel>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 4 Nov 2024 19:14:42 +0800
Message-ID: <CAMWQL2hwDZdB9TmHF4=krzrUa1_=P78aBYt6nJddGZxMjk702A@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host
 doesn't support it
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-ot1-x336.google.com
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

Hi Daniel and Andrew,

When handling an external interrupt via IMSIC, we need to use the stopei CS=
R
to claim the top interrupt. Even though the QEMU can emulate the IMSIC devi=
ces
without the in-kernel irqchip, we still need to trap and emulate the stopei
CSR. But since the host machine doesn't support the AIA extension, the gues=
t OS
will hit the illegal instruction exception instead of the virutal instructi=
on
exception when it accesses the stopei CSR. We can't have a chance to redire=
ct
this instruction to QEMU. So I think we can directly report errors when the
user wants to use KVM AIA(MSI) without in-kernel AIA irqchip support.

Regards,
Yong-Xuan

On Fri, Nov 1, 2024 at 11:09=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Nov 01, 2024 at 08:45:13AM -0300, Daniel Henrique Barboza wrote:
> >
> >
> > On 11/1/24 5:36 AM, Yong-Xuan Wang wrote:
> > > Currently QEMU will continue to emulate the AIA MSI devices and enabl=
e the
> > > AIA extension for guest OS when the host kernel doesn't support the
> > > in-kernel AIA irqchip. This will cause an illegal instruction excepti=
on
> > > when the guest OS uses the IMSIC devices. Add additional checks to en=
sure
> > > the guest OS only uses the AIA MSI device when the host kernel suppor=
ts
> > > the in-kernel AIA chip.
> > >
> > > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > > ---
> > >   hw/riscv/virt.c | 19 +++++++++++++------
> > >   1 file changed, 13 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > index 45a8c4f8190d..0d8e047844a6 100644
> > > --- a/hw/riscv/virt.c
> > > +++ b/hw/riscv/virt.c
> > > @@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *m=
achine)
> > >           }
> > >       }
> > > -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> > > -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > > -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_=
NUM_MSIS,
> > > -                             memmap[VIRT_APLIC_S].base,
> > > -                             memmap[VIRT_IMSIC_S].base,
> > > -                             s->aia_guests);
> > > +    if (kvm_enabled() && s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSI=
C) {
> > > +        if (virt_use_kvm_aia(s)) {
> > > +            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT=
,
> > > +                                 VIRT_IRQCHIP_NUM_SOURCES,
> > > +                                 VIRT_IRQCHIP_NUM_MSIS,
> > > +                                 memmap[VIRT_APLIC_S].base,
> > > +                                 memmap[VIRT_IMSIC_S].base,
> > > +                                 s->aia_guests);
> > > +        } else {
> > > +            error_report("Host machine doesn't support in-kernel APL=
IC MSI, "
> > > +                         "please use aia=3Dnone or aia=3Daplic");
> > > +            exit(1);
> > > +        }
> >
> > As you said in the commit msg it looks like we have a bug in this parti=
cular path: kvm accel,
> > aia=3Daplic-imsic, no irqchip present. Erroring out is one possible sol=
ution but I wonder why we
> > couldn't just emulate the APLIC and IMSIC controllers in this case. We =
have code that does
> > that in TCG, so it would be a matter of adding the needed plumbing to t=
reat KVM AIA without
> > irqchip =3D=3D TCG AIA.
> >
> > Drew, care to weight in? Thanks,
> >
>
> If I understand the motivation for this patch correctly, then we'll alway=
s
> need something like it anyway. With the proposal of supporting KVM with
> usermode-imsic, then KVM would ultimately have three possible states:
> inkernel-irqchip, usermode-imsic, nothing. usermode-imsic will need KVM
> support for forwarding imsic accesses to QEMU, but when that support isn'=
t
> present (and the inkernel-irqchip isn't selected either), then we should
> still want to error out before allowing the guest to try accesses that
> can't work.
>
> Thanks,
> drew

