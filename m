Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EC7C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMz6-0001j3-Nx; Thu, 20 Jun 2024 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKMz5-0001im-N0
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:58:11 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKMz3-0007lT-UK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:58:11 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a4d7ba501so1301368a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718909887; x=1719514687; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1liMJUZn1L5IgyAaz4tLbwmffK1RBrw2W/ddp8QCTw=;
 b=Hi03ym5M/cEIf2sJQHGY/EdC+tI8x2Mar3eSAN7S4wHGYtG60xYllVgoz9GzU72DVO
 PX7/ehaIgJ4imrIrBmXBQzqmTCibuHsUQqW5BjPlLvtaiEtKupb3WN0qnvQWWRbslC0t
 sDizZ2wqVRXsyDfdv2A2I12MlioUro17q8KyWWqio6FmtWyFMYRm7u8X7acUOMx7ztx4
 t4KHOQSdEnBmuPUeCV1OvI0Lzrnu/XJC1JAZS/pdZH6zVpqJfjITi9k4RJtFTVop2EsI
 P6pehsn7skWMCAkYwz5mNZd9MYm3ikGFFwTd3ARKscfBQ9k3mxeERPT7gZceZrjwcfA4
 5++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718909887; x=1719514687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1liMJUZn1L5IgyAaz4tLbwmffK1RBrw2W/ddp8QCTw=;
 b=k3jHiuMSf/kR0si5WWeG1DibcJ97jEsLLNGESYfT5btR6bhOgH/UEk2LfRNsL+al30
 P0N9Ap5yM+FTC82Clmr7PWgWBYEiijRAmxjz5ilmwlkYj0MoC5ay41tXU3aTC3rh4HEx
 4Meba14ILhMwOUgH5RWIFBreCFBRdLHW2NjgDudZ+oH3aYNM9HOi/9+v5aLmMU5k3DeD
 nO26Ri1uECyKnDsOG8nVaq3t1tfJTPigaixipxAd7/Bo6nOXwGFlcExSuNBCXWvqi9GH
 kA6VhDmmSpOS+pSEjB/iI9s4j6MZCPyiTNDTu93+q529tgLOeaissilnpA27s/p0umKr
 iNyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMcMTD8SzhOdsGwFiiTwqesx/4vuVLpa6KJtvAImT0fm2wSt/xe2uUYnK+ekTwnrpECmmE1wscsUOU1pGnlBoG42nk9Es=
X-Gm-Message-State: AOJu0YwG/261+6IqhmhR1gQPIGBtTZSdGIHKgZNZU8nGHRiKRke4b3UF
 7AqUp60kbcQXgHF/k6nKG7duQxbiD7pWDWX5/H3wSYwCSafsdVpEUoLG0+MMhAtZvkliRaWJusv
 DQ9hmvods0WvM/3tPWl3nkg/eBGfZC3Mjlg2cbg==
X-Google-Smtp-Source: AGHT+IFrPa3vOgPMId25HcaBGzbkomQ1XLy2PaRVHMHcQ9iki8Kp5G4k+PBGQu+e7YEuhuGtR1GOk4/4Rr6cZsKSJ3s=
X-Received: by 2002:a50:ab5b:0:b0:57a:33a5:9b78 with SMTP id
 4fb4d7f45d1cf-57d07eabeb8mr3950396a12.34.1718909887441; Thu, 20 Jun 2024
 11:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240618144009.3137806-1-zheyuma97@gmail.com>
 <47a6e9d2-27f6-4e45-9de3-c4766bdf2566@linaro.org>
 <CAFEAcA82T-hS0Armp6PVBkrywfqv+-u+L4z8rtrjBpnwvE8Hxg@mail.gmail.com>
 <12471213-83da-4226-ba2a-2b8b6452d46b@linaro.org> <ZnQPjL4HjevwHh8R@toto>
In-Reply-To: <ZnQPjL4HjevwHh8R@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 19:57:56 +0100
Message-ID: <CAFEAcA9x0bfC=xtZdF-xEr94TT5gKx6ycY7_n3Q0LnXPaBidJw@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/a9gtimer: Handle QTest mode in
 a9_gtimer_get_current_cpu
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 20 Jun 2024 at 12:16, Edgar E. Iglesias <edgar.iglesias@amd.com> wr=
ote:
>
> On Thu, Jun 20, 2024 at 12:25:51PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 20/6/24 12:10, Peter Maydell wrote:
> > > On Tue, 18 Jun 2024 at 15:51, Philippe Mathieu-Daud=C3=A9 <philmd@lin=
aro.org> wrote:
> > > >
> > > > On 18/6/24 16:40, Zheyu Ma wrote:
> > > > > This commit updates the a9_gtimer_get_current_cpu() function to h=
andle
> > > > > cases where QTest is enabled. When QTest is used, it returns 0 in=
stead
> > > > > of dereferencing the current_cpu, which can be NULL. This prevent=
s the
> > > > > program from crashing during QTest runs.
> > > > >
> > > > > Reproducer:
> > > > > cat << EOF | qemu-system-aarch64 -display \
> > > > > none -machine accel=3Dqtest, -m 512M -machine npcm750-evb -qtest =
stdio
> > > > > writel 0xf03fe20c 0x26d7468c
> > > > > EOF
> > > > >
> > > > > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > > > > ---
> > > > >    hw/timer/a9gtimer.c | 5 +++++
> > > > >    1 file changed, 5 insertions(+)
> >
> >
> > > > >        if (current_cpu->cpu_index >=3D s->num_cpu) {
> > > >
> > > > That said, such accesses of @current_cpu from hw/ are dubious.
> > >
> > > True, but I'm not sure we ever settled on the right way to avoid
> > > them, did we?
> >
> > No we didn't, it is still in my TODO list; we might discuss it
> > when I post my RFC.
> >
>
> Yeah, this way of getting the core id is a problem when having multiple
> ARM CPU subsystems (and for heterogenous cores).
>
> IIRC, when I looked at what the GIC v2 HW does, the GIC exposes an AMBA
> port for each CPU. In my mental model that would translate to exposing
> multiple Memory Reginos (sysbus_init_mmio) and mapping the appropriate
> device MR to each CPU AddressSpace.

Yeah. The trouble is that doing this requires massively rearranging
how all the GICv2 board models connect up address spaces...

> We could also do it with memory attributes but I don't think the
> master Ids are standardised enough to extract a core-index from
> with out having SoC specific code,, at least not accross Xilinx devices.

...and yes, using the requester ID to specify the CPU in the
MemTxAttrs is the other proposal.

thanks
-- PMM

