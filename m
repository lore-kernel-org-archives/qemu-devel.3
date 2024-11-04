Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B4CD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wVC-0001cr-LP; Mon, 04 Nov 2024 07:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1t7wV5-0001VC-Bz
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:48:08 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1t7wV3-00038Z-Hu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:48:07 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3e5fbc40239so1977959b6e.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1730724484; x=1731329284; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZP6SGc3gobfNd6b+tAKnwm1CfqQ+SKmBFnWJAVkNMg=;
 b=hoJsiIbCQHFIGnkxEkUZkzkkmXC1W4cA1sfLhuZnMZ1z/arGjo9D2wYqKUMp3ZhLn+
 zj0eS2LB6mqD6qSppU/4mX7rpdrLhHoWjuGJYQ/pXlStRFAnA278iSgCUK3ub5dvbxwa
 /uv2Ct9FlpKS0ksyhTzhguIcbNrB6VpzBwZ7KBvcSZeKbgevo9Prz+tlGCKxlmjtbr2d
 ZPxJIzuiN2iIafrjBLW9UGn1Y1lqbuPdE3J71ycItAKEMd5prguLKY1lCBcSrHjNwVCN
 k9y+3FS2VNckLzssgTHvVWFcQFGhw5qzaMvcKYq4AG6BVMDo4Gzl2PAk5ZFssmhFeKxt
 5NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730724484; x=1731329284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZP6SGc3gobfNd6b+tAKnwm1CfqQ+SKmBFnWJAVkNMg=;
 b=ASyw4S4e+nEdNayb1Zic51qSeE9uc+2WpUBVAgNiDnf/C8PAQxvh7O9GrGchlbFTs9
 aMv/RksKVuj+3SjiAB58blfQ0O/xThDlRIpMLLU9B2D6ZAjYV021OdNJOcdAT896Uj3G
 lT3qKcm5TG0IM4++OuZOZYCys1F3tBCpO5TaGaNRV5Y2kY2PadAlbd5JpyyW2joS0c4U
 jD5O2hhwjoF/WgJIznhO99xkDKOgVg6iKSMoElPTTFMTeJfQ2S1ezOVmGuNCCjy7+DCh
 B1YU41V+YTL8WbpaoPAz4v3QE07cn3VkKsM+qig1+/1zJziLSCqnTRnco500PG06dymR
 bOng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNodiLsaqhhGPB/RiKqHmK1IiEioVI+DuW1FgAriKAj1fj5xq4p5rSdV8cdzOpHTMcoGhoK6+urUEj@nongnu.org
X-Gm-Message-State: AOJu0Yw8ykz2Puas9SfERYcrUfRAwWrJbyjhku0AX9Lwak/QqywEsGwt
 kGnGIdsVbCTDS+fG/AMqJJEo//f2F6sj1ZocQ1RwujpxYp3R3fGVZ5Xf7Hm4p300RIVI+WOpxcL
 eqaOWTDZeaNFeiEoi068Eb4VwV1FkgAoz1jsQHQ==
X-Google-Smtp-Source: AGHT+IH4U1GlMRQMyjvhD4HTjaABGrtw1BYQsNyA8FouBa+w0hbXCRGeDxfEl6u6W0m9f9frhuxHwEG+/OhWTJNBlPY=
X-Received: by 2002:a05:6870:d1d4:b0:278:1f2:a23f with SMTP id
 586e51a60fabf-2949ed9d559mr7891212fac.13.1730724483970; Mon, 04 Nov 2024
 04:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20241101083606.5122-1-yongxuan.wang@sifive.com>
 <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
 <20241101-6ada91d63644e8d715b1cf35@orel>
 <CAMWQL2hwDZdB9TmHF4=krzrUa1_=P78aBYt6nJddGZxMjk702A@mail.gmail.com>
 <f2614f02-b297-4320-84ca-42b7384f8f93@ventanamicro.com>
In-Reply-To: <f2614f02-b297-4320-84ca-42b7384f8f93@ventanamicro.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 4 Nov 2024 20:47:53 +0800
Message-ID: <CAMWQL2hm8-_+V-Jv7tcVy-KeztHk=tvp83ZTVoczjCoJG4cZUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host
 doesn't support it
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-oi1-x233.google.com
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

Sorry I found that I forgot a situation. Host kernel doesn't support
in-kernel AIA is not equal to host machine doesn't support AIA extension.

If user specifies aia=3Daplic-imsic when using KVM acceleration, we have 3
possibilities:
1. host doesn't support AIA extension -> report error since we can't handle
   the stopei CSR.
2. host support AIA extension but doesn't have in-kernel AIA -> use usermod=
e
   IMSIC and handle the stopei CSR in QEMU
3. host support AIA extension and have in-kernel AIA -> use in-kernel AIA
   and handle the stopei CSR in KVM

We need to update the kvm_riscv_handle_csr() for situation 2. And it's bett=
er
to determine the availability of AIA extension in riscv_imsic_realize().

Please ignore this patch, I will send another patchset to handle the
above situations.

Regards,
Yong-Xuan

On Mon, Nov 4, 2024 at 8:15=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 11/4/24 8:14 AM, Yong-Xuan Wang wrote:
> > Hi Daniel and Andrew,
> >
> > When handling an external interrupt via IMSIC, we need to use the stope=
i CSR
> > to claim the top interrupt. Even though the QEMU can emulate the IMSIC =
devices
> > without the in-kernel irqchip, we still need to trap and emulate the st=
opei
> > CSR. But since the host machine doesn't support the AIA extension, the =
guest OS
> > will hit the illegal instruction exception instead of the virutal instr=
uction
> > exception when it accesses the stopei CSR. We can't have a chance to re=
direct
> > this instruction to QEMU. So I think we can directly report errors when=
 the
> > user wants to use KVM AIA(MSI) without in-kernel AIA irqchip support.
>
> Can you please add this info in the commit message? This makes it clearer
> that there's not much we can do in QEMU aside from erroring out.
>
> Also, please add a:
>
> Fixes: 48c2c33c52 ("target/riscv: select KVM AIA in riscv virt machine")
>
>
> Thanks,
>
> Daniel
>
> >
> > Regards,
> > Yong-Xuan
> >
> > On Fri, Nov 1, 2024 at 11:09=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> >>
> >> On Fri, Nov 01, 2024 at 08:45:13AM -0300, Daniel Henrique Barboza wrot=
e:
> >>>
> >>>
> >>> On 11/1/24 5:36 AM, Yong-Xuan Wang wrote:
> >>>> Currently QEMU will continue to emulate the AIA MSI devices and enab=
le the
> >>>> AIA extension for guest OS when the host kernel doesn't support the
> >>>> in-kernel AIA irqchip. This will cause an illegal instruction except=
ion
> >>>> when the guest OS uses the IMSIC devices. Add additional checks to e=
nsure
> >>>> the guest OS only uses the AIA MSI device when the host kernel suppo=
rts
> >>>> the in-kernel AIA chip.
> >>>>
> >>>> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> >>>> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> >>>> ---
> >>>>    hw/riscv/virt.c | 19 +++++++++++++------
> >>>>    1 file changed, 13 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> >>>> index 45a8c4f8190d..0d8e047844a6 100644
> >>>> --- a/hw/riscv/virt.c
> >>>> +++ b/hw/riscv/virt.c
> >>>> @@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *=
machine)
> >>>>            }
> >>>>        }
> >>>> -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> >>>> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> >>>> -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP=
_NUM_MSIS,
> >>>> -                             memmap[VIRT_APLIC_S].base,
> >>>> -                             memmap[VIRT_IMSIC_S].base,
> >>>> -                             s->aia_guests);
> >>>> +    if (kvm_enabled() && s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMS=
IC) {
> >>>> +        if (virt_use_kvm_aia(s)) {
> >>>> +            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIF=
T,
> >>>> +                                 VIRT_IRQCHIP_NUM_SOURCES,
> >>>> +                                 VIRT_IRQCHIP_NUM_MSIS,
> >>>> +                                 memmap[VIRT_APLIC_S].base,
> >>>> +                                 memmap[VIRT_IMSIC_S].base,
> >>>> +                                 s->aia_guests);
> >>>> +        } else {
> >>>> +            error_report("Host machine doesn't support in-kernel AP=
LIC MSI, "
> >>>> +                         "please use aia=3Dnone or aia=3Daplic");
> >>>> +            exit(1);
> >>>> +        }
> >>>
> >>> As you said in the commit msg it looks like we have a bug in this par=
ticular path: kvm accel,
> >>> aia=3Daplic-imsic, no irqchip present. Erroring out is one possible s=
olution but I wonder why we
> >>> couldn't just emulate the APLIC and IMSIC controllers in this case. W=
e have code that does
> >>> that in TCG, so it would be a matter of adding the needed plumbing to=
 treat KVM AIA without
> >>> irqchip =3D=3D TCG AIA.
> >>>
> >>> Drew, care to weight in? Thanks,
> >>>
> >>
> >> If I understand the motivation for this patch correctly, then we'll al=
ways
> >> need something like it anyway. With the proposal of supporting KVM wit=
h
> >> usermode-imsic, then KVM would ultimately have three possible states:
> >> inkernel-irqchip, usermode-imsic, nothing. usermode-imsic will need KV=
M
> >> support for forwarding imsic accesses to QEMU, but when that support i=
sn't
> >> present (and the inkernel-irqchip isn't selected either), then we shou=
ld
> >> still want to error out before allowing the guest to try accesses that
> >> can't work.
> >>
> >> Thanks,
> >> drew

