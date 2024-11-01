Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC2DE6F066
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 15:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6tHT-0002kh-QY; Fri, 01 Nov 2024 11:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t6tHR-0002jh-It
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:09:41 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t6tHP-00016G-1M
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:09:41 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f4d8ef66so2740303e87.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730473776; x=1731078576; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=46znDBoqQGBD0O089ftXep6apf53Vr677UxWL8i4ym0=;
 b=DP64GyLuXE0nNshTWx3j3eAMSQWAFs5HEaQB/vHCHyI02frUrRDFb7Ikqc2ZLziRgz
 dMC2H2PGgh0Y1ZG+wPcjjmrTOtChLXtShENhIywUmNUIINns7ntnswqNk5dokLklsi+X
 +OJkBfmcXob6FOTfrpRenjR3JwEUpL4B/G0eCry3XVIIaXjIRZ6uQHZEUOXaZJ+gQbii
 WiIHVAVH/Ur7iBNqQ8TQ0e2pOR/CIsZvTf8tAqH4lu1LCMuMInU/w2APvSKEJi2p5xg8
 tJmx1M44YSrQMR8E5vssWymwfbAFALcMFJlaLsBcfWJ06n1/UKJJyHT9lIqYUSEKkaxs
 skKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730473776; x=1731078576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46znDBoqQGBD0O089ftXep6apf53Vr677UxWL8i4ym0=;
 b=sjzEg7xjc7gpiRNaWhH4Ab9Ez13VK0e2T6lPfSHSemyE8FdcRMK/PgeyHded3Ph2yb
 qYCKcdbrO9HpTSVIcI8v7SkCcxn7MBOBYzuj2w+wQbx8g3SiBPfDzgjnvnZa80J0j+87
 nbuJNhdNSH16X6frUnRSZcjJO0l1uhuLqoHHGY/YIj5X0Hg066jjUTHvfJdG0Yz4Qzdb
 tvNVlIhl+189Ensrn89nYa5v27GnX8adgMceYg/3NvDoNs7PK9cXxJisLECGD558XESq
 MwD5zHkJtcaJlDirMI9XVyW/YZxHvRQaQy/f2s/5yGB4gj0Apb6Y2vRoDt1YpqFcy9Jt
 V3XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+0/HvgzFCHWIE3kuNwhydTkKOlVSqlxibZ/qVY69FFVeW2iSr8XTvwWUsvBPBLtoZr/ezBlDUXPWI@nongnu.org
X-Gm-Message-State: AOJu0YzYk0iKSM0FsFXLsD2SKScE1jBIOoRwJz0FUVm8/H2Efmn4vPFb
 N8BRWdtqeYeDTL/VG8BxF7VCjberJG+HI71Yx11ByXoaN4MjlggdFhdlLeta/Ec=
X-Google-Smtp-Source: AGHT+IGA+mikfca3RaUZfxn3BMPw7SJFVbuQMfjRZYjJ1sP8aDas+68G/VMV/Ut9pHA49hNzlAX7Wg==
X-Received: by 2002:a05:6512:104d:b0:539:d10b:e389 with SMTP id
 2adb3069b0e04-53b348f9681mr12381209e87.13.1730473776287; 
 Fri, 01 Nov 2024 08:09:36 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116abc0sm5427011f8f.94.2024.11.01.08.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:09:35 -0700 (PDT)
Date: Fri, 1 Nov 2024 16:09:34 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, greentime.hu@sifive.com, vincent.chen@sifive.com, 
 frank.chang@sifive.com, jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host
 doesn't support it
Message-ID: <20241101-6ada91d63644e8d715b1cf35@orel>
References: <20241101083606.5122-1-yongxuan.wang@sifive.com>
 <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x12a.google.com
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

On Fri, Nov 01, 2024 at 08:45:13AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 11/1/24 5:36 AM, Yong-Xuan Wang wrote:
> > Currently QEMU will continue to emulate the AIA MSI devices and enable the
> > AIA extension for guest OS when the host kernel doesn't support the
> > in-kernel AIA irqchip. This will cause an illegal instruction exception
> > when the guest OS uses the IMSIC devices. Add additional checks to ensure
> > the guest OS only uses the AIA MSI device when the host kernel supports
> > the in-kernel AIA chip.
> > 
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   hw/riscv/virt.c | 19 +++++++++++++------
> >   1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 45a8c4f8190d..0d8e047844a6 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *machine)
> >           }
> >       }
> > -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> > -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
> > -                             memmap[VIRT_APLIC_S].base,
> > -                             memmap[VIRT_IMSIC_S].base,
> > -                             s->aia_guests);
> > +    if (kvm_enabled() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> > +        if (virt_use_kvm_aia(s)) {
> > +            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > +                                 VIRT_IRQCHIP_NUM_SOURCES,
> > +                                 VIRT_IRQCHIP_NUM_MSIS,
> > +                                 memmap[VIRT_APLIC_S].base,
> > +                                 memmap[VIRT_IMSIC_S].base,
> > +                                 s->aia_guests);
> > +        } else {
> > +            error_report("Host machine doesn't support in-kernel APLIC MSI, "
> > +                         "please use aia=none or aia=aplic");
> > +            exit(1);
> > +        }
> 
> As you said in the commit msg it looks like we have a bug in this particular path: kvm accel,
> aia=aplic-imsic, no irqchip present. Erroring out is one possible solution but I wonder why we
> couldn't just emulate the APLIC and IMSIC controllers in this case. We have code that does
> that in TCG, so it would be a matter of adding the needed plumbing to treat KVM AIA without
> irqchip == TCG AIA.
> 
> Drew, care to weight in? Thanks,
>

If I understand the motivation for this patch correctly, then we'll always
need something like it anyway. With the proposal of supporting KVM with
usermode-imsic, then KVM would ultimately have three possible states:
inkernel-irqchip, usermode-imsic, nothing. usermode-imsic will need KVM
support for forwarding imsic accesses to QEMU, but when that support isn't
present (and the inkernel-irqchip isn't selected either), then we should
still want to error out before allowing the guest to try accesses that
can't work.

Thanks,
drew

