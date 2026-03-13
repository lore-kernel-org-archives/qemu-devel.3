Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A45105F78C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w11hf-0002Kc-GW; Fri, 13 Mar 2026 08:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w11hd-0002Jp-Iv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:33:17 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w11hb-00032a-Vn
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:33:17 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so2440173d50.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 05:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773405195; cv=none;
 d=google.com; s=arc-20240605;
 b=cVTkn9VYRKTvFOTHFxaoFqHtVQI2qokWCh0fey77VCiLS+UI+3EC7RpLP8IMzqsbBm
 Ne4mgbScqe1dPFmQ6h3ZAqWF55JYROGGssDevqXxtoiGRj+Vpisp+KRtH2CE1yuR2sHR
 2o+KxJ0CkGPcsBZliat/q12MkDFO7wjmT/u7v01eqk3P3twE8vkIOkLVz4WygVa1do0u
 bk23DzIj03EhEKwv8/BY/dbaOn2ZqtI9pO8xliXk7Q70xK9KDscqPlP5Gdfb78pGEgKB
 2fKHjTxF16Gl/lT1H1rMZNkJ40BJ06zBqwpVUXcaFQZwOLKnPmNAfjgHsXT40fp5XSU2
 mAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8qpkgKKZi4M0dKGmoIqvJ6FewWUr3N/GbWr7jXlFiMc=;
 fh=kNIogqq3vuwisK2itGMBAsxxrTxhp1uBN4cTU4uTg6A=;
 b=XFgdd2TmJsAbhqUrmAHTcF7sHc7Hw/vaovnXuA7WfWBjGh2RWtS0wQ5Tgq4ekcz6bj
 nqIEulJcVWrxTO+DEQWFVh5dZqTKHrwdwdjoUGaDv2rvQoYfbvJ05SgQRRsmpHMHPGe3
 5MONa5QG6f8znouD4yINH5kho/uirv3ItEncorQiCFWqqx1MOHlhewRwZUrHhRpQRIaV
 IgaK1UCs+WUhYWwL0JcHgciJoTaZgDyP3AiGdAg0jrq4my0jXDugzVeYgMKBn9aC2mey
 6iIpxGu1eSATPQGPk/SX6bjPa0y58SdXDWxOEBRXGJmHxam4TJSTz8mr7RIld6waGTzW
 ly9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773405195; x=1774009995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qpkgKKZi4M0dKGmoIqvJ6FewWUr3N/GbWr7jXlFiMc=;
 b=hb1HyqOu1Q0roaNzlPRBtQbuBjk71j5ChA4L2W2ipAasR87n0QRM1OBfHKmWu5FJmg
 tl7qyZZTx+wYfWLBaiIEOx107dTbQ2D3MkoXI7xW8f6zcfRI/TnGOq+XWu3HQ/d907p/
 sxhkEEk25Bzl6USZpjtacmKvYXamkGzq5+m6vlkOOtuKSLGSCJRxFNEpW0rqjOPb1hMY
 yJz997hcCyfdPvo+GO41bt0S/c7Gz24ei9WhdqYQ7vg7eZwsjhWnOk/AKdBlAORGOfJY
 qCX8ysmybW2SgbSdiNdPArOs9BSQ/KFFXMRbYwj0WvDCIAoXTulb4YwQN2C4O2qyOFET
 a7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773405195; x=1774009995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qpkgKKZi4M0dKGmoIqvJ6FewWUr3N/GbWr7jXlFiMc=;
 b=VSHdRooXAQNoD0PEJHkHXcAhYv5xJjIa/beKQVzA0MAyFs2wHlrZB57P0ytVyX2uN3
 2LM/gyjnbtQMONcR8mcaZnomy2nSWJUyK+kDltCgj1DzX1Q9E5tQGxk6Aa9mXw4P5zYq
 3lmDbX4lNV+9RaoGRW+c8hkvvMP4kVUABVjzmqm76E+wrAiGV6O6V4kGLRkA2JSiDavJ
 VHOFBwnVsJqZDgfs3dZukFAU7uRBr8naku3AKuT1LvLsY5r37bWY6MmULtffeup8TMZZ
 n7kSkX9VUNi3qHqYNCqMCiKTOnyjPYOrrNje6VxCqTyZZnLTn+eORveqt5gftV02JoHc
 QwqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUChelIqExeglw2ItmuhnLydc6ocHYwu/6gDERmcjAa/Ull84XkE8jdrLhO+ZBL333jhtQ7YVbQNXmY@nongnu.org
X-Gm-Message-State: AOJu0Yy4AVaZG848xE6SJUZxz7qNZp27xerTCRDKCJEt9SozaJwWcl8O
 FxpbLIOzfOdC3kIek6oFZllmw/ejE3U3gMMcA6boG7sKNy0p7cQuA7e8J4mdWJ9Ez9tIagGJFF3
 6cLxp65YXznNqQtEuf8NBSjeAxgvzQB1Z/z+W9pvNwg==
X-Gm-Gg: ATEYQzzvvJkrgdSKLN3CCKgak0d3eS76aajaa+Qv7fA4VBOv1p+XRJ4e2rQk9zcjFJv
 l+pg33Z+szefAMP9+uzHEnOrSrHxkMO1NACXkAQLze67ng0+snDdk/DiJ3nDhfvMLrCmCjW/5ZC
 pl058MjMcNt1+mfLAmHUpsRy1JWLSQC+4e/kwJhhTWnOWLnDZwr9QbkUmboH3mGcH0zl7gT196p
 pvdCjtLyrkPlS0qm9pbF5odT5Zud+0kwIgnmaRgwZB1vxWoAc7GyOCdzDFsdG0fm9QE0OQjg4ww
 /40GkeIgwcp5kLSe4rUdeUFYw/3y0kBExvHlv2crWd6Owu3pnDNye2SkKNdlhnFJjEE35RwTZc3
 WuA==
X-Received: by 2002:a53:ee60:0:b0:64d:29b6:3853 with SMTP id
 956f58d0204a3-64e63084523mr2294434d50.62.1773405194653; Fri, 13 Mar 2026
 05:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is>
 <CAFEAcA8ycT250JaECAYTKF+U2a4m6jauLPLbD8PVx2atd70A7g@mail.gmail.com>
 <87fr64vtms.fsf@alyssa.is>
In-Reply-To: <87fr64vtms.fsf@alyssa.is>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 12:33:02 +0000
X-Gm-Features: AaiRm524LdjNgHnlTdSFCUVAmKkaUkrny2G6lg3rMMTHEglnrcDvbVKjUJvoiPM
Message-ID: <CAFEAcA98aTmU0cKSbddQnLFwrmifNfXYaDeNsdvJR9XuB--6ew@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Alyssa Ross <hi@alyssa.is>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 13 Mar 2026 at 11:47, Alyssa Ross <hi@alyssa.is> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Looking a bit closer at this, it's a bit awkward that we're
> > looking at a machine property in generic target/arm code.
>
> Isn't SMP a machine property that we're looking at just above?

It's one of the ones in the base MachineState that exist for
all boards.

> > There is no guarantee that the machine is "virt" or that every
> > KVM-supporting machine has a "virtualization" property, and
> > the target/ code isn't really supposed to do board-specific stuff.
>
> FWIW: there's another arm board with the same property, which I think
> would have the same requirements.  That's why I chose to just check the
> property rather than checking machine type =E2=80=94 the idea being to es=
tablish
> the convention that machines /do/ have a virtualization property where
> it makes sense.
>
> > The board-independent way to say "are we trying to enable EL2" is
> > to look at the CPU property has_el2. But the CPU isn't created at
> > this point, so it's too early to do that here.
>
> I spent a day or so trying to make something involving has_el2 work, but
> ultimately couldn't get anywhere with it.
>
> > Similar things where the early accelerator code wants information
> > from the board we have handled with a method in MachineClass,
> > like get_physical_address_range. We could do that here, but
> > maybe it's a bit over-engineered? IDK.
>
> I'll give it a go and see if I can make it work.
>
> > There are other cases also where the virt board will error
> > out for "KVM and some config we could do with TCG":
> >  * KVM + EL2 + GICv2
> >  * KVM + EL2 + kernel-irqchip=3Doff
> >  * KVM + GICv2 but host hardware doesn't support GICv2 emulation
> >  * KVM + GICv3 but host hardware doesn't support GICv3 emulation
> >  * KVM + MTE but host hardware/kernel doesn't support MTE
> >
> > The first two are "always fails", but if we're going to have
> > a mechanism for "figure out in kvm_arch_init what KVM features
> > the board is going to want to enable" then it might be nice
> > to also be able to use it for the last 3.
>
> I can try that.

Thanks, that would be helpful. I don't really have any
specific ideas about what kind of API might be best here.

There are probably similar issues with the other accelerators,
e.g. -accel hvf,tcg -machine virtualization=3Don
also ought to fall back to TCG, and similarly with "picked
a GIC version we can't handle with this accelerator".

-- PMM

