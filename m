Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DE8D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vWt-00008G-De; Mon, 04 Nov 2024 06:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t7vWp-0008RL-Ri
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:45:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1t7vWn-00022T-Pa
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:45:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so31669325e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730720748; x=1731325548; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7fuxQQcDl1hc7l0lTimrv8xaWk/Nh3ifrl2sb9scv/I=;
 b=nnn9gOqiY6ZVbshoVC0ttnvbBM6yizeQjzYwHP9xN57v1RTPavuQm/5dwA7zUis399
 WCTKkINsKjKnI01kxdMtp+IMhMZ/l9PM5llscFmCBDbJsr7wLFYFLLhqs5RGaBmaqWse
 LlvGZoRhgMaG9gaSOqW+MTwbp22Jc8CHXFJfIwrGgWyrgsprYwpfOggxIUe4dFJVEFVa
 06hWRDAXeHWFvSfWVJa8alyjRW1ThKdq2drqN4XDsXejzg5u9ktUfrHWyoixx+zxUeHl
 +FFzDUsp7+3OmUK0gndUZUI+PDW/Qt1Gs38mQTmRiZFRZFRObaDw2o6m7wew3VOFGAf5
 nPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730720748; x=1731325548;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7fuxQQcDl1hc7l0lTimrv8xaWk/Nh3ifrl2sb9scv/I=;
 b=mjK0s8LTR1WbVXfZIzg9a/IeUOf8Wq3f53rwBXOe+8oI0HSWOIWaV46mXR/dHv3Vhm
 bjy20+/Cr/KBc/YSKUbUG6VusjcyIk/4x8PxJOBa16Ii0wu6q9BEXfpKrcHxtfBrEEN0
 juFbhit/YFqWsbtrDERqkKlumMADiOjctL7CveNL0aZSJbzlTL22IvhSWZn2gFSAnRKe
 C0oflT7o8AY8ql6h6w9QkSOfGvfMvXZOgLj42Ybth0Jfk5rQPu9jGfvsLOQeBO9oqW/g
 UeV1XYxjzNS33gfDs5DgQ2DGOHm4llHhlwjta42Is49TeO+YKBF/z/SKZ7tajJpsqmOL
 c9OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeUqMWZaoqpqr9SeYbsC2IWNdog2CiUVdwJ2BL0PTskQYwu8znFR+i3uZdmFvI3D7Tb/cEQRrLcRkE@nongnu.org
X-Gm-Message-State: AOJu0YxAr44PH1X6Rlj/lj6he3pbLMNEfiB0TnJy0ttOvH13uBo31gva
 hKX6ZGDAKpa4y2HYQhnt7nouUZdBTVwV13Zd0jRLHG8Qf5qepZFOtTlRAnn+5AU=
X-Google-Smtp-Source: AGHT+IGVnNrNX9klwoZWFzYCZ+Ki1QVVGCVjEfol978GvNQfs2UevjNMXa9KQuWqKVfSdjoQK2cjZQ==
X-Received: by 2002:a05:600c:511c:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-4319ad24423mr284980475e9.30.1730720747639; 
 Mon, 04 Nov 2024 03:45:47 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917f0bsm177203765e9.17.2024.11.04.03.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 03:45:47 -0800 (PST)
Date: Mon, 4 Nov 2024 12:45:46 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/1] hw/riscv: virt: prevent to use AIA MSI when host
 doesn't support it
Message-ID: <20241104-c2c2c8896c2fe76a2a865a3b@orel>
References: <20241101083606.5122-1-yongxuan.wang@sifive.com>
 <8ec6e960-8305-456c-b8f9-4c0dd14e51ff@ventanamicro.com>
 <20241101-6ada91d63644e8d715b1cf35@orel>
 <CAMWQL2hwDZdB9TmHF4=krzrUa1_=P78aBYt6nJddGZxMjk702A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMWQL2hwDZdB9TmHF4=krzrUa1_=P78aBYt6nJddGZxMjk702A@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32f.google.com
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

On Mon, Nov 04, 2024 at 07:14:42PM +0800, Yong-Xuan Wang wrote:
> Hi Daniel and Andrew,
> 
> When handling an external interrupt via IMSIC, we need to use the stopei CSR
> to claim the top interrupt. Even though the QEMU can emulate the IMSIC devices
> without the in-kernel irqchip, we still need to trap and emulate the stopei
> CSR. But since the host machine doesn't support the AIA extension, the guest OS
> will hit the illegal instruction exception instead of the virutal instruction
> exception when it accesses the stopei CSR. We can't have a chance to redirect
> this instruction to QEMU. So I think we can directly report errors when the
> user wants to use KVM AIA(MSI) without in-kernel AIA irqchip support.

Thanks for the additional info, Yong-Xuan. I think putting something like
this in the commit message, or even a comment, would be helpful.

Thanks,
drew

> 
> Regards,
> Yong-Xuan
> 
> On Fri, Nov 1, 2024 at 11:09 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Fri, Nov 01, 2024 at 08:45:13AM -0300, Daniel Henrique Barboza wrote:
> > >
> > >
> > > On 11/1/24 5:36 AM, Yong-Xuan Wang wrote:
> > > > Currently QEMU will continue to emulate the AIA MSI devices and enable the
> > > > AIA extension for guest OS when the host kernel doesn't support the
> > > > in-kernel AIA irqchip. This will cause an illegal instruction exception
> > > > when the guest OS uses the IMSIC devices. Add additional checks to ensure
> > > > the guest OS only uses the AIA MSI device when the host kernel supports
> > > > the in-kernel AIA chip.
> > > >
> > > > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > > > Reviewed-by: Jim Shu <jim.shu@sifive.com>
> > > > ---
> > > >   hw/riscv/virt.c | 19 +++++++++++++------
> > > >   1 file changed, 13 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > > index 45a8c4f8190d..0d8e047844a6 100644
> > > > --- a/hw/riscv/virt.c
> > > > +++ b/hw/riscv/virt.c
> > > > @@ -1567,12 +1567,19 @@ static void virt_machine_init(MachineState *machine)
> > > >           }
> > > >       }
> > > > -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> > > > -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > > > -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
> > > > -                             memmap[VIRT_APLIC_S].base,
> > > > -                             memmap[VIRT_IMSIC_S].base,
> > > > -                             s->aia_guests);
> > > > +    if (kvm_enabled() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> > > > +        if (virt_use_kvm_aia(s)) {
> > > > +            kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > > > +                                 VIRT_IRQCHIP_NUM_SOURCES,
> > > > +                                 VIRT_IRQCHIP_NUM_MSIS,
> > > > +                                 memmap[VIRT_APLIC_S].base,
> > > > +                                 memmap[VIRT_IMSIC_S].base,
> > > > +                                 s->aia_guests);
> > > > +        } else {
> > > > +            error_report("Host machine doesn't support in-kernel APLIC MSI, "
> > > > +                         "please use aia=none or aia=aplic");
> > > > +            exit(1);
> > > > +        }
> > >
> > > As you said in the commit msg it looks like we have a bug in this particular path: kvm accel,
> > > aia=aplic-imsic, no irqchip present. Erroring out is one possible solution but I wonder why we
> > > couldn't just emulate the APLIC and IMSIC controllers in this case. We have code that does
> > > that in TCG, so it would be a matter of adding the needed plumbing to treat KVM AIA without
> > > irqchip == TCG AIA.
> > >
> > > Drew, care to weight in? Thanks,
> > >
> >
> > If I understand the motivation for this patch correctly, then we'll always
> > need something like it anyway. With the proposal of supporting KVM with
> > usermode-imsic, then KVM would ultimately have three possible states:
> > inkernel-irqchip, usermode-imsic, nothing. usermode-imsic will need KVM
> > support for forwarding imsic accesses to QEMU, but when that support isn't
> > present (and the inkernel-irqchip isn't selected either), then we should
> > still want to error out before allowing the guest to try accesses that
> > can't work.
> >
> > Thanks,
> > drew

