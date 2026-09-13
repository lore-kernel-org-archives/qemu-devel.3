Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2289AC88E64
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5tZs-0007iQ-Tn; Sun, 13 Sep 2026 19:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1x5tZr-0007iA-8T
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 19:25:39 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1x5tZo-0007b3-UL; Sun, 13 Sep 2026 19:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=1XvX2Gz35Pbgtp17RL3W7VaYMzM2Sqat7cOLBOMrqNE=; b=V6gWhZjtJyXvesidA1c6
 pdh0fkB9nm0OtcQ/+Y2/G73ZckajlVtLWg6Im6aJmRHavdknWm18oxuJwm+uH+ru2ezHSvhNKok40
 hO0jKswmShBn3N32zaud+pP4OxW0HSukaou/FDyONkYALfbijm2FLiOrgYrMocXsD2+nQ77gtTTma
 uUVe9E8yLbjhVtMajSpBvqQccIEqiCvRrPxDQCSzkwDxLTSyrdlVN+YFyoZo6DgzWhhwZHG68eavM
 YpUqGSTagw/Ye8i3Y+e5ofF7DVue17QnQLnlT1IwNpZYzt6TIjVhflsOlM+IoRBs7dg9AGchOMUy5
 QdpVwyxYsY2/aw==;
Date: Mon, 14 Sep 2026 01:25:30 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: qemu-devel@nongnu.org, adam@os.inf.tu-dresden.de, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com
Subject: Re: [PATCH] Revert 9696846600ca ("multiboot: Prevent loading of
 x86_64 images")
Message-ID: <aqcw6tAYGBtThnZu@end>
References: <20260829175047.2710519-1-samuel.thibault@ens-lyon.org>
 <ap6i1z057uqnYo6g@end>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ap6i1z057uqnYo6g@end>
Organization: I am not organized
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

Hello,

Any opinion on this?

With regards,
Samuel

Samuel Thibault, le lun. 07 sept. 2026 13:41:11 +0200, a ecrit:
> Hello,
> 
> Ping on this?
> 
> With regards,
> Samuel
> 
> Samuel Thibault, le sam. 29 août 2026 19:50:47 +0200, a ecrit:
> > Loading x86_64 images in multiboot was disabled on the ground that since
> > multiboot actually boots 64bit kernels in 32bit mode, the binary would
> > have to be 32bit.
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2010-08/msg00913.html
> > 
> > But making the binary 32bit makes using debugging tools such as gdb
> > unnecessarily complex since they don't understand what architecture the
> > kernel actually is.  Letting qemu load x86_64 images and boot them in 32bit
> > mode is completely fine, works, and is what the multiboot standard actually
> > expects.
> > 
> > This notably fixes loading gnumach in x86_64 mode.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > ---
> >  hw/i386/multiboot.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> > index d544b62afb..004d5185fb 100644
> > --- a/hw/i386/multiboot.c
> > +++ b/hw/i386/multiboot.c
> > @@ -196,11 +196,6 @@ int load_multiboot(X86MachineState *x86ms,
> >          int kernel_size;
> >          fclose(f);
> >  
> > -        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
> > -            error_report("Cannot load x86-64 image, give a 32bit one.");
> > -            exit(1);
> > -        }
> > -
> >          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, &elf_entry,
> >                                 &elf_low, &elf_high, NULL,
> >                                 ELFDATA2LSB, I386_ELF_MACHINE, 0, 0);
> > -- 
> > 2.53.0

-- 
Samuel
Linux, c'est simple : ça s'adresse à une machine qui est parfois un peu
maraboutée mais qui d'habitude n'a pas d'états d'âme. Sur Usenet y'a
plein d'humains et de primates, et ça devient vraiment gore par moment.
-+- TP in : Guide du linuxien pervers - "Le linuxien a-t-il une âme ?" -+-

